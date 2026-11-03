"""Gera o SVG animado e as versões Quarto e Slidev a partir de um único desenho.

Gera dois conjuntos de arquivos a partir do mesmo desenho:
  - original (paleta Navy/Teal/Ember do CLAUDE.md): fluxo_animado.svg,
    questao24.qmd, slidev/slides.md
  - GREI (paleta verde/amarelo/azul do template TemplateBeamerUFC):
    fluxo_animado_grei.svg, questao24_grei.qmd, slidev/slides_grei.md
"""
from pathlib import Path

OUT = Path(__file__).resolve().parent            # quarto/
OUT_SLIDEV = OUT.parent / "slidev"               # slidev/
OUT_SLIDEV.mkdir(parents=True, exist_ok=True)

# cores neutras (traço/rótulos discretos), iguais nas duas paletas
INK, MUTE = "#22262B", "#7A828C"

# paleta original (Navy/Teal/Ember, ver CLAUDE.md)
ORIG_FLOW, ORIG_LOAD = "#2A7F8E", "#D1495B"   # Teal, Ember

# paleta GREI (igual à do beamer/libs/ufc_format.cls: blue_theme, red)
GREI_FLOW, GREI_LOAD = "#2F5D4B", "#D70000"

# caminho do ícone do GREI (quadrado, já gerado para o template) usado como
# logo discreto nas versões GREI; relativo a partir de quarto/ e slidev/
GREI_LOGO = "../../TemplateBeamerUFC/libs/ufcpixel.png"


def css(flow):
    """CSS da animação (parametrizado pela cor do traço, igual nos três arquivos)."""
    return f"""
.fx-flow {{ fill: none; stroke: {flow}; stroke-width: 5; stroke-dasharray: 8 12;
           animation: fx-corre 1.2s linear infinite; }}
.fx-rapido {{ animation-duration: 0.6s; }}
@keyframes fx-corre {{ to {{ stroke-dashoffset: -40; }} }}
""".strip()


def sub(base, idx, size=15):
    """Texto com subscrito, ex.: S_12."""
    return (f'{base}<tspan font-size="{size - 4}" dy="4">{idx}</tspan>'
            f'<tspan dy="-4">')


def svg(flow, load, step1="", step2="", step3="", inline_style=True):
    """Desenho do unifilar. stepN = atributos que controlam a etapa de cada fluxo."""
    style = f"<style>\n{css(flow)}\n</style>\n" if inline_style else ""
    t = f'font-size="15" fill="{INK}"'
    return f"""<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 680 240" width="680" height="240" font-family="Fira Sans, Helvetica, Arial, sans-serif">
{style}<defs>
  <marker id="fx-seta" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto">
    <path d="M1 1L9 5L1 9z" fill="{INK}"/>
  </marker>
</defs>
<!-- geradores -->
<circle cx="70" cy="130" r="22" fill="white" stroke="{INK}" stroke-width="1.5"/>
<path d="M58 130 Q64 119 70 130 T82 130" fill="none" stroke="{INK}" stroke-width="1.5"/>
<circle cx="610" cy="130" r="22" fill="white" stroke="{INK}" stroke-width="1.5"/>
<path d="M598 130 Q604 119 610 130 T622 130" fill="none" stroke="{INK}" stroke-width="1.5"/>
<line x1="92" y1="130" x2="140" y2="130" stroke="{INK}" stroke-width="1.5"/>
<line x1="540" y1="130" x2="588" y2="130" stroke="{INK}" stroke-width="1.5"/>
<!-- linhas e carga -->
<line x1="140" y1="130" x2="540" y2="130" stroke="{INK}" stroke-width="1.5"/>
<path d="M340 152 H360 V212" fill="none" stroke="{INK}" stroke-width="1.5" marker-end="url(#fx-seta)"/>
<!-- barras -->
<line x1="140" y1="95" x2="140" y2="165" stroke="{INK}" stroke-width="6"/>
<line x1="340" y1="95" x2="340" y2="165" stroke="{INK}" stroke-width="6"/>
<line x1="540" y1="95" x2="540" y2="165" stroke="{INK}" stroke-width="6"/>
<!-- rótulos -->
<text x="140" y="82" text-anchor="middle" {t}>Barra 1</text>
<text x="340" y="82" text-anchor="middle" {t}>Barra 2</text>
<text x="540" y="82" text-anchor="middle" {t}>Barra 3</text>
<text x="240" y="119" text-anchor="middle" font-size="14" fill="{MUTE}">j0,2</text>
<text x="440" y="119" text-anchor="middle" font-size="14" fill="{MUTE}">j0,2</text>
<text x="70" y="174" text-anchor="middle" {t}>G1</text>
<text x="610" y="174" text-anchor="middle" {t}>G3</text>
<!-- etapa 1: fluxo da barra 1 para a 2 -->
<g id="fx-12" {step1}>
  <path class="fx-flow" d="M146 130 H334"/>
  <text x="240" y="157" text-anchor="middle" font-size="15" fill="{flow}">{sub("S", "12")} = 0,5 pu</tspan></text>
</g>
<!-- etapa 2: fluxo da barra 3 para a 2 -->
<g id="fx-32" {step2}>
  <path class="fx-flow" d="M534 130 H346"/>
  <text x="440" y="157" text-anchor="middle" font-size="15" fill="{flow}">{sub("S", "32")} = 0,5 pu</tspan></text>
</g>
<!-- etapa 3: potência entregue à carga (dobro da velocidade: 1,0 pu) -->
<g id="fx-c" {step3}>
  <path class="fx-flow fx-rapido" d="M346 152 H360 V204"/>
  <text x="374" y="198" font-size="15" fill="{load}">carga: 1,0 &#8722; j0,1 pu</text>
</g>
</svg>"""


def qmd_source(svg_quarto, *, theme_lines, logo_line, highlight_open, highlight_close):
    return f"""---
title: "Questão 24 — Fluxo de potência em três barras"
subtitle: "Sistemas Elétricos de Potência"
author: "Luis Felipe Souza"
lang: pt-BR
format:
  revealjs:
{theme_lines}
    slide-number: true
    transition: fade
{logo_line}---

## Enunciado

Potência injetada na barra 3 e impedâncias em pu. Tensões nas barras 1 e 3
iguais a $1{{,}}0$ pu. Qual a tensão na barra 2 e o fluxo de potência
saindo da barra 1 para a barra 2?

- $V_1 = V_3 = 1{{,}}0\\angle 0^\\circ$ pu
- $S_{{G3}} = 0{{,}}5 + j0$ pu
- $x = 0{{,}}2$ pu em cada trecho

## Passos 1 e 2: corrente e tensão na barra 2

$$
I_{{32}} = \\left(\\frac{{S_{{G3}}}}{{V_3}}\\right)^{{*}} = 0{{,}}5\\angle 0^\\circ \\ \\text{{pu}}
$$

. . .

$$
V_2 = V_3 - jx\\,I_{{32}} = 1 - j0{{,}}2 \\times 0{{,}}5 = 1{{,}}0 - j0{{,}}1 \\ \\text{{pu}}
$$

## Passo 3: fluxo da barra 1 para a barra 2

$$
I_{{12}} = \\frac{{V_1 - V_2}}{{jx}} = \\frac{{j0{{,}}1}}{{j0{{,}}2}} = 0{{,}}5 \\ \\text{{pu}}
\\qquad
S_{{12}} = V_1\\,I_{{12}}^{{*}} = 0{{,}}5 \\ \\text{{pu}}
$$

. . .

::: {{{highlight_open}.callout-important appearance="simple"{highlight_close}}}
Alternativa **(D)**: $V_2 = 1{{,}}0 - j0{{,}}1$ pu e $S_{{12}} = 0{{,}}5$ pu
:::

## Sentido do fluxo de potência

Cada clique revela um trecho; a velocidade do tracejado é proporcional à potência.

```{{=html}}
<div style="text-align:center">
{svg_quarto}
</div>
```

::: {{.fragment fragment-index=4}}
Simetria: cada barra geradora entrega 0,5 pu e a carga recebe 1,0 pu.
:::

## Conferência numérica

```{{python}}
#| echo: true
V1 = V3 = 1 + 0j
x = 0.2
I32 = (0.5 / V3).conjugate()
V2 = V3 - 1j * x * I32
S12 = V1 * ((V1 - V2) / (1j * x)).conjugate()
print(f"V2 = {{V2:.3f}} pu   S12 = {{S12:.3f}} pu")
```
"""


def slidev_source(svg_slidev, css_block, *, heading_color=None, answer_color=None):
    """heading_color/answer_color = None -> markup idêntico à versão original
    (sem span de cor); um valor -> envolve título/resposta num <span> colorido."""
    h = (lambda t: f'<span style="color:{heading_color}">{t}</span>') if heading_color else (lambda t: t)
    a = (lambda t: f'<span style="color:{answer_color}; font-weight:bold">{t}</span>') if answer_color else (lambda t: f"**{t}**")
    return f"""---
theme: default
title: Questão 24 — Fluxo de potência em três barras
info: Sistemas Elétricos de Potência
transition: fade
---

# {h("Questão 24")}

Fluxo de potência em três barras

---

# {h("Passos 1 e 2: corrente e tensão na barra 2")}

$$
I_{{32}} = \\left(\\frac{{S_{{G3}}}}{{V_3}}\\right)^{{*}} = 0{{,}}5\\angle 0^\\circ \\ \\text{{pu}}
$$

<v-click>

$$
V_2 = V_3 - jx\\,I_{{32}} = 1{{,}}0 - j0{{,}}1 \\ \\text{{pu}}
$$

</v-click>

---

# {h("Passo 3: fluxo da barra 1 para a barra 2")}

$$
I_{{12}} = \\frac{{V_1 - V_2}}{{jx}} = \\frac{{j0{{,}}1}}{{j0{{,}}2}} = 0{{,}}5 \\ \\text{{pu}}
\\qquad
S_{{12}} = V_1\\,I_{{12}}^{{*}} = 0{{,}}5 \\ \\text{{pu}}
$$

<v-click>

Alternativa {a("(D)")}: $V_2 = 1{{,}}0 - j0{{,}}1$ pu e $S_{{12}} = 0{{,}}5$ pu

</v-click>

---

# {h("Sentido do fluxo de potência")}

Cada clique revela um trecho; a velocidade do tracejado é proporcional à potência.

{svg_slidev}

<div v-click="4" class="text-center mt-4">
Simetria: cada barra geradora entrega 0,5 pu e a carga recebe 1,0 pu.
</div>

<style>
{css_block}
</style>
"""


def gerar(*, suffix, flow, load, qmd_theme_lines, qmd_logo_line, highlight_open,
          highlight_close, heading_color=None, answer_color=None):
    # newline="\n" evita que o Python traduza para CRLF no Windows e "suje"
    # o diff dos arquivos da versão original, que não deve mudar.
    def write(path, text):
        path.write_text(text, encoding="utf-8", newline="\n")

    svg_plain = svg(flow, load) + "\n"
    write(OUT / f"fluxo_animado{suffix}.svg", svg_plain)

    frag = lambda i: f'class="fragment" data-fragment-index="{i}"'
    svg_quarto = svg(flow, load, frag(1), frag(2), frag(3))
    qmd = qmd_source(svg_quarto, theme_lines=qmd_theme_lines, logo_line=qmd_logo_line,
                      highlight_open=highlight_open, highlight_close=highlight_close)
    write(OUT / f"questao24{suffix}.qmd", qmd)

    vc = lambda i: f'v-click="{i}"'
    svg_slidev = svg(flow, load, vc(1), vc(2), vc(3), inline_style=False).replace(
        '<svg xmlns="http://www.w3.org/2000/svg" ', '<svg class="mx-auto" ')
    md = slidev_source(svg_slidev, css(flow), heading_color=heading_color,
                        answer_color=answer_color)
    write(OUT_SLIDEV / f"slides{suffix}.md", md)


# 1) Versão original (Navy/Teal/Ember) — mesmos três arquivos de sempre,
#    byte-a-byte idênticos ao que já existia (sem spans de cor extras).
gerar(
    suffix="",
    flow=ORIG_FLOW, load=ORIG_LOAD,
    qmd_theme_lines="    theme: simple",
    qmd_logo_line="",
    highlight_open="", highlight_close="",
)

# 2) Versão GREI (verde/amarelo/azul do template TemplateBeamerUFC)
gerar(
    suffix="_grei",
    flow=GREI_FLOW, load=GREI_LOAD,
    qmd_theme_lines="    theme: [simple, grei.scss]",
    qmd_logo_line=f'    logo: "{GREI_LOGO}"\n',
    highlight_open="", highlight_close="",
    heading_color=GREI_FLOW,
    answer_color=GREI_LOAD,
)

print("ok: fluxo_animado(.svg|_grei.svg), questao24(.qmd|_grei.qmd), "
      "slidev/slides(.md|_grei.md)")
