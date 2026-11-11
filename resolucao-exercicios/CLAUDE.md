# Resolução de exercícios — Sistemas Elétricos de Potência

Material de resolução comentada de questões de concurso de SEP, com figuras
próprias (unifilares e circuitos equivalentes) e revelação passo a passo.
Autor: Luis Felipe Souza. Idioma de todo o material: português do Brasil.

Este arquivo resume uma conversa no claude.ai em que o material foi iniciado.
Leia-o antes de mexer em qualquer coisa.

## Estrutura

```
enunciados/   q51.jpeg, q24.jpeg, q45.png — fotos originais das questões
beamer/       resolucao.tex (+ .pdf) — Q51 e Q24, circuitikz, tema metropolis
              resolucao_grei.tex (+ .pdf) — mesmo conteúdo, com o template
              TemplateBeamerUFC/ (pasta irmã de resolucao-exercicios/):
              aspectratio=169, header/footer/logo/marca d'água do GREI/UFC
              referencias.bib — bibliografia das DUAS versões (biblatex +
              biber, style=numeric, sorting=none): Stevenson, Bichels,
              Borges. Citadas nos quadros de revisão; numeração = ordem da
              1ª citação. Quadro "Referências" no fim de cada deck (o
              \nocite ali garante que entrem mesmo sem citação)
documento/    resolucao_detalhada.tex (+ .pdf) — versão A4 em texto corrido
              das duas questões (identidade GREI): o que nos slides é dito
              oralmente vem por extenso, com deduções e contas passo a passo
              e conferências. Mesma ordem dos slides (enunciado → conteúdos →
              revisão → resolução). Bibliografia: ../beamer/referencias.bib.
              As figuras são cópias das dos slides, adaptadas ao A4 (zonas
              estáticas, sem overlays): mudou figura nos slides, mude aqui.
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
`svg(..., enunciado=True)` gera o diagrama estático do enunciado (sem fluxos,
com S_G3 = 0,5; marcador com id próprio `fx-seta-enun`); `largura=` muda o
tamanho exibido. Os slides de enunciado do .qmd e do slides.md também vêm do
gerador (`qmd_source`/`slidev_source`) — não editar só os arquivos gerados.

## Estado de cada versão

| Versão | Status |
|---|---|
| Beamer | compilado com pdflatex e conferido página a página (enunciados integrais conferidos em 2026-11-04) |
| Beamer (GREI) | compilado com pdflatex (2 passes) e conferido página a página; usa `../../TemplateBeamerUFC/libs/ufc_format` via `\documentclass` com caminho relativo (sem duplicar a classe) (enunciados integrais conferidos em 2026-11-04) |
| Documento A4 | compilado com pdflatex + biber (latexmk) e conferido página a página (22 páginas com a Q45, sem overfull) em 2026-11-04 |
| Typst | **nunca compilado** (sem acesso ao compilador na época); API conferida contra o código-fonte dos pacotes. Requer Typst ≥ 0.15. Enunciados integrais (2026-11-04) também não compilados: conferir se cabem no slide |
| Quarto | renderizado com `quarto render` (Quarto 1.11.9 + Jupyter) → `questao24.html`; conferido no navegador. Slides "Enunciado"/"Enunciado (continuação)"/"Leitura dos dados" (2026-11-04) **ainda não renderizados** |
| Quarto (GREI) | renderizado com `quarto render` → `questao24_grei.html`; conferido no navegador (tema grei.scss, logo, cores e célula Python ok). Slides de enunciado de 2026-11-04 **ainda não renderizados** |
| Slidev | mesmo SVG, com `v-click`; conteúdo não copiado para dentro de `project/` ainda. Slides de enunciado (2026-11-04) **ainda não testados** |
| Slidev (GREI) | projeto scaffolded em `slidev/project/` (`pnpm create slidev`); `project/slides.md` é cópia de `slides_grei.md`; `npm run dev` testado e sobe sem erro em `localhost:3030`. Slides de enunciado (2026-11-04) **ainda não testados** |

Os arquivos gerados (.qmd, slides*.md) de 2026-11-04 foram aplicados à mão
(sem Python na máquina), espelhando o gerador; ao rodar `gerar_animacao.py`
de novo, o `git diff` deve sair vazio — se não sair, vale o que o gerador produz.

Ferramenta final ainda não escolhida. Direção discutida: Beamer/Typst para
PDF estático; Quarto (reveal.js) se quiser animação + LaTeX + Python no mesmo
arquivo; Manim Slides se quiser animações cinematográficas (ex.: fasorial).
As versões GREI replicam só a Q24 (decisão: manter o escopo atual do
Quarto/Slidev); a Q51 só existe nessas duas ferramentas na versão Beamer.

## Soluções (já conferidas numericamente)

### Questão 51 — perda de uma linha de transmissão
- Topologia: barras de 250 kV dos dois lados → T1∥T2, L1∥L2, T3∥T4.
- Zonas de tensão base (quadro "Passo 1: zonas do circuito", antes de
  "Passo 1: bases"): zona 1 = G1 + lado de 20 kV de T1/T2; zona 2 = lado de
  250 kV de T1–T4 + linhas; zona 3 = lado de 25 kV de T3/T4 + G2. Fronteiras
  tracejadas pelo meio dos trafos. Só no Beamer (as duas versões): zonas
  reveladas uma por slide (cores ZonaA/ZonaB = Teal/Navy ou
  green_ufc/blue_theme). Não replicado no Typst.
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

### Questão 45 — potência reativa a partir da curva de potência instantânea
- Só no Beamer (as duas versões) e no documento A4; Typst/Quarto/Slidev não.
- $p(t) = VI\cos\theta - VI\cos(2\omega t - \theta)$: média $P$, amplitude
  $S = VI$. Gráfico: $p_{\max} \approx 1500$, $p_{\min} \approx -500$ W.
- $P = (1500 - 500)/2 = 500$ W; $S = (1500 + 500)/2 = 1000$ VA;
  $\cos\theta = 0{,}5$, $\theta = 60^\circ$; $Q = 500\sqrt3 \approx 866$ var
  ⇒ **alternativa (B)** (870).
- Sinal: a curva sai de zero descendo, $p'(0) = -2\omega VI\sen\theta < 0$
  ⇒ $\theta > 0$ (corrente atrasada, $Q > 0$).
- Curva redesenhada com pgfplots: $p(t) = 500 - 1000\cos(36000\,t - 60)$
  (graus; $\omega = 100\pi$, 50 Hz). Mínimo em 1/600 s, máximo em 1/150 s.
- Distratores: (A) 1000 = $S$; (C) 500 = $P$; (D) ≈ 289 = $P\,\mathrm{tg}\,30^\circ$.
- Usa `\sen` (`\providecommand{\sen}{\operatorname{sen}}`), como no enunciado;
  as outras questões usam `\sin`.

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
- Estrutura de cada questão (pedido do autor, 2026-11-04):
  1. **Enunciado** (redesenhado, completo);
  2. **Conteúdos envolvidos** — quais tópicos a questão usa e por quê;
  3. **Revisão do conteúdo** — um quadro por tópico, com fórmulas-chave na
     caixa `conceito` e "Ver \cite{...}" no rodapé do quadro;
  4. **Resolução** — (Leitura dos dados) → estratégia → passos → resposta em
     caixa → conferência/interpretação física.
  Feito só no Beamer (as duas versões); Typst/Quarto/Slidev ainda na
  estrutura antiga. Na GREI, os quadros da Q51 não têm o prefixo
  "Questão 51 ---" no título (edição do autor); os da Q24 ainda têm.
- **Enunciado sempre completo, sem resumo**, em todas as ferramentas: texto
  transcrito na íntegra (com "p.u."/"pu", "Dados dos componentes:" etc. como
  no original), figura redesenhada com todos os dados que só aparecem nela,
  comando da questão e todas as alternativas. Se não couber num slide, dividir
  em "Enunciado" + "Enunciado (continuação)", na ordem do original.
  Interpretações (ex.: V = 1∠0°, S = 0,5 + j0) vão num slide à parte
  ("Leitura dos dados"), nunca no slide do enunciado.

## Armadilhas já encontradas

- Animação: o SVG precisa estar **inline** no slide; como imagem (`![]()`)
  ele anima, mas os cliques (fragments/v-click) não alcançam os grupos.
- Sentido do fluxo animado = ordem dos pontos do `path` (`stroke-dashoffset`).
- Slidev/Vue ignora `<style>` dentro do template: o CSS vai num `<style>` do slide.
- Use `&#8722;` para o sinal de menos em texto SVG (evita problema de codificação).
- Typst: menos depois de `angle` sai binário; usar `#neg` (classe "unary").
- TikZ: com `scale=`, os raios de `circle (r)` dos pics gerador/trafo **não**
  encolhem; rótulos abaixo deles precisam ficar a r/scale do centro.
  `\circuitoQcinquentaum{escala}` (desenho único do unifilar da Q51, usado no
  enunciado a 0.62 e nas zonas a 0.75) já calcula esse afastamento.
- biblatex: `@book` não imprime `institution`/`organization` (apostila da
  Borges: juntados em `publisher`); total de páginas vai em `pagetotal`, não
  em `pages`.
- Compilar com `-outdir` a partir de `beamer/`: se houver um `.bbl` velho
  em `beamer/` (de uma compilação local), o MiKTeX lê esse e não o do outdir
  → "Citation undefined". Compilar numa cópia limpa ou apagar o `.bbl` velho.
- `\underbrace` é um átomo Op: um "+" logo depois perde o espaço de
  operador ("0,20 +0,10"). Envolver em chaves: `{\underbrace{...}_{...}}`
  (feito no documento A4; os slides ainda têm a forma antiga).
- tcolorbox: título com `=` (fórmula) precisa de chaves: `title={...}`.
- pgfplots (Q45): o estilo `q45` é igual nos três arquivos; os slides
  acrescentam `q45 girado` (rótulos do tempo a 45°, senão se sobrepõem).
  `rotate` do TikZ é cumulativo (`rotate=0` não desfaz `rotate=45`), por
  isso o giro é opcional e não vem no estilo base. Um `xticklabel style`
  que entra em `/pgf/number format/.cd` precisa terminar com `/tikz/.cd`,
  senão chaves acrescentadas depois (rotate, anchor) dão erro de pgfkeys.
- Perl no Git Bash: `\\g...` na substituição perde a barra; para inserir
  comandos LaTeX, prefira o Edit ou `\Q...\E` com cuidado.
- metropolis redefine `frametitle continuation`: o `[from second]` (evita
  "Referências i" com um slide só) precisa vir depois do `\usetheme`.

## Comandos

```bash
cd beamer && latexmk -pdf resolucao.tex       # latexmk roda o biber sozinho
cd beamer && latexmk -pdf resolucao_grei.tex   # versão com o template GREI
cd documento && latexmk -pdf resolucao_detalhada.tex   # documento A4 detalhado
typst compile typst/resolucao.typ          # ou cole no typst.app
quarto render quarto/questao24.qmd         # último slide roda Python: precisa de Jupyter
quarto render quarto/questao24_grei.qmd    # idem, versão GREI
# Quarto instalado via installer .msi (não fica no PATH por padrão):
# C:\Users\grei-luis-felipe\AppData\Local\Programs\Quarto\bin\quarto.exe
# Jupyter: py -3 -m pip install jupyter pyyaml
cd slidev/project && npm run dev           # projeto já criado; slides.md = cópia de slides_grei.md
python3 quarto/gerar_animacao.py           # regenera as DUAS paletas (original + _grei)
```
