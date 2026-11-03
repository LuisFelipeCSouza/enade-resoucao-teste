# Resolução de exercícios — Sistemas Elétricos de Potência

Material de resolução comentada de questões de concurso de SEP, com figuras
próprias (unifilares e circuitos equivalentes) e revelação passo a passo.
Autor: Luis Felipe Souza. Idioma de todo o material: português do Brasil.

Este arquivo resume uma conversa no claude.ai em que o material foi iniciado.
Leia-o antes de mexer em qualquer coisa.

## Estrutura

```
enunciados/   q51.jpeg, q24.jpeg — fotos originais das questões
beamer/       resolucao.tex (+ .pdf) — Q51 e Q24, circuitikz, tema metropolis
              resolucao_grei.tex (+ .pdf) — mesmo conteúdo, com o template
              TemplateBeamerUFC/ (pasta irmã de resolucao-exercicios/):
              aspectratio=169, header/footer/logo/marca d'água do GREI/UFC
typst/        resolucao.typ — mesma resolução em Typst (Touying 0.8 + zap 0.6)
quarto/       questao24.qmd — Q24 em reveal.js com unifilar animado (paleta
              Navy/Teal/Ember)
              questao24_grei.qmd — mesma Q24, tema grei.scss + logo do GREI
              fluxo_animado.svg / fluxo_animado_grei.svg — SVG avulso de cada
              paleta (tudo visível e animado)
              grei.scss — tema reveal.js com a paleta GREI (verde/amarelo/azul)
              gerar_animacao.py — fonte única do desenho; gera as DUAS
              paletas (original e _grei) de uma vez
slidev/       slides.md — Q24 em Slidev (Navy/Teal/Ember), mesma animação
              com v-click
              slides_grei.md — mesma Q24, títulos/resposta na paleta GREI
              project/ — scaffold do Slidev (`pnpm create slidev`, npm/vite,
              node_modules); project/slides.md é uma CÓPIA de slides_grei.md
              (não editar direto ali: editar slides_grei.md e copiar de novo)
```

`gerar_animacao.py` é a fonte única do desenho animado: edite o desenho ali
e rode `python3 quarto/gerar_animacao.py` para regenerar os seis arquivos
(original + `_grei`, SVG + .qmd + slides.md). A função `svg()`/`css()` recebe
a cor do traço e da carga como parâmetro — é aí que entra uma paleta nova.

## Estado de cada versão

| Versão | Status |
|---|---|
| Beamer | compilado com pdflatex e conferido página a página |
| Beamer (GREI) | compilado com pdflatex (2 passes) e conferido página a página; usa `../../TemplateBeamerUFC/libs/ufc_format` via `\documentclass` com caminho relativo (sem duplicar a classe) |
| Typst | **nunca compilado** (sem acesso ao compilador na época); API conferida contra o código-fonte dos pacotes. Requer Typst ≥ 0.15 |
| Quarto | renderizado com `quarto render` (Quarto 1.11.9 + Jupyter) → `questao24.html`; conferido no navegador |
| Quarto (GREI) | renderizado com `quarto render` → `questao24_grei.html`; conferido no navegador (tema grei.scss, logo, cores e célula Python ok) |
| Slidev | mesmo SVG, com `v-click`; conteúdo não copiado para dentro de `project/` ainda |
| Slidev (GREI) | projeto scaffolded em `slidev/project/` (`pnpm create slidev`); `project/slides.md` é cópia de `slides_grei.md`; `npm run dev` testado e sobe sem erro em `localhost:3030` |

Ferramenta final ainda não escolhida. Direção discutida: Beamer/Typst para
PDF estático; Quarto (reveal.js) se quiser animação + LaTeX + Python no mesmo
arquivo; Manim Slides se quiser animações cinematográficas (ex.: fasorial).
As versões GREI replicam só a Q24 (decisão: manter o escopo atual do
Quarto/Slidev); a Q51 só existe nessas duas ferramentas na versão Beamer.

## Soluções (já conferidas numericamente)

### Questão 51 — perda de uma linha de transmissão
- Topologia: barras de 250 kV dos dois lados → T1∥T2, L1∥L2, T3∥T4.
- Base: 100 MVA; tensões base 20 / 250 / 25 kV; Z_b = 250²/100 = 625 Ω.
- Reatâncias (pu): X_G = 0,1; X_T = 0,1·100/50 = 0,2; X_L = 125/625 = 0,2.
- Antes: X_eq = 0,1+0,1+0,1+0,1+0,1 = 0,5. Depois: 0,1+0,1+0,2+0,1+0,1 = 0,6.
- E e δ constantes ⇒ P' = P·X/X' = 0,5/0,6 = **0,833 pu**; δ = 30°.
- Interpretação adotada: tensões *internas* dos geradores (X_G no caminho).
  Se fossem as terminais: 0,3/0,4 = 0,75 pu (fica como observação no slide).
- Gabarito oficial não encontrado.

### Questão 24 — fluxo de potência em três barras
- Interpretação: V1 = V3 = 1∠0° (fasores), S_G3 = 0,5 + j0, x = 0,2 por trecho.
- I32 = (S/V)* = 0,5; V2 = V3 − jx·I32 = **1,0 − j0,1** (|V2| = 1,005, θ2 = −5,71°).
- I12 = (V1−V2)/jx = 0,5; S12 = **0,5 + j0** ⇒ **alternativa (D)**.
- Carga na barra 2: 1,0 − j0,1 (cada trecho consome Q = 0,05; fontes não
  entregam reativo). (C)/(E) falham: V2 = 1 + j0,1 dá I12 = −0,5.
- Sem a leitura V3 = 1∠0° o problema é subdeterminado (carga desconhecida).

## Convenções

- Vírgula decimal sempre (0,5). LaTeX: pacote `icomma`; MathJax/KaTeX: `0{,}5`;
  Typst: show rule no topo do .typ (não usar decimais como argumento de função
  matemática, ex. `underbrace(0,1, …)`, e pôr decimais entre parênteses em
  frações: `(0,5)/(0,6)`).
- Paleta original: Navy #1D3557, Teal #2A7F8E, Ember #D1495B
  (destaques/respostas), Paper #FAFAF7, Ink #22262B, Mute #7A828C.
- Paleta GREI (versões `_grei`): verde #2F5D4B (`blue_theme`, estrutural),
  amarelo #F4D525 (`yellow`, destaque), azul claro #51CBEE (`green_ufc`,
  auxiliar/referência), vermelho #D70000 (`red`, alerta/resposta) — mesmas
  cores do template `TemplateBeamerUFC/libs/ufc_format.cls`. Ink/Mute
  continuam neutros nas duas paletas (não fazem parte da identidade visual).
- Figuras desenhadas no próprio material (circuitikz / CeTZ+zap / SVG), nada
  de recorte das imagens originais. O autor também desenha no Inkscape.
- Estrutura de cada questão: enunciado redesenhado → estratégia → passos →
  resposta em caixa → conferência/interpretação física.

## Armadilhas já encontradas

- Animação: o SVG precisa estar **inline** no slide; como imagem (`![]()`)
  ele anima, mas os cliques (fragments/v-click) não alcançam os grupos.
- Sentido do fluxo animado = ordem dos pontos do `path` (`stroke-dashoffset`).
- Slidev/Vue ignora `<style>` dentro do template: o CSS vai num `<style>` do slide.
- Use `&#8722;` para o sinal de menos em texto SVG (evita problema de codificação).
- Typst: menos depois de `angle` sai binário; usar `#neg` (classe "unary").

## Comandos

```bash
cd beamer && latexmk -pdf resolucao.tex
cd beamer && latexmk -pdf resolucao_grei.tex   # versão com o template GREI
typst compile typst/resolucao.typ          # ou cole no typst.app
quarto render quarto/questao24.qmd         # último slide roda Python: precisa de Jupyter
quarto render quarto/questao24_grei.qmd    # idem, versão GREI
# Quarto instalado via installer .msi (não fica no PATH por padrão):
# C:\Users\grei-luis-felipe\AppData\Local\Programs\Quarto\bin\quarto.exe
# Jupyter: py -3 -m pip install jupyter pyyaml
cd slidev/project && npm run dev           # projeto já criado; slides.md = cópia de slides_grei.md
python3 quarto/gerar_animacao.py           # regenera as DUAS paletas (original + _grei)
```
