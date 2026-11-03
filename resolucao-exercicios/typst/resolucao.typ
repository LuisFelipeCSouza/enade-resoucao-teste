// =====================================================================
//  Resolução de exercícios — Sistemas Elétricos de Potência
//  Questões 51 (abertura de linha) e 24 (fluxo de potência)
//  Typst 0.15+  ·  Touying 0.8.0 (slides)  ·  zap 0.6.0 (circuitos, via CeTZ)
//  No typst.app: crie um projeto, cole este arquivo e os pacotes baixam sozinhos.
// =====================================================================
#import "@preview/touying:0.8.0": *
#import themes.metropolis: *
#import "@preview/zap:0.6.0"
#let cetz = zap.cetz // mesma versão de CeTZ que o zap usa

// ---------------------------------------------------------------------
//  Cores
// ---------------------------------------------------------------------
#let c-navy = rgb("#1D3557")
#let c-teal = rgb("#2A7F8E")
#let c-ember = rgb("#D1495B")
#let c-paper = rgb("#FAFAF7")
#let c-ink = rgb("#22262B")
#let c-mute = rgb("#7A828C")

// ---------------------------------------------------------------------
//  Tema
// ---------------------------------------------------------------------
#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.subtitle,
  config-info(
    title: [Resolução de Exercícios],
    subtitle: [Sistemas Elétricos de Potência --- Questões 51 e 24],
    author: [Luis Felipe Souza],
  ),
  config-colors(
    primary: c-ember,
    primary-light: c-ember.lighten(70%),
    secondary: c-navy,
    neutral-lightest: c-paper,
    neutral-dark: c-navy,
    neutral-darkest: c-ink,
  ),
)

#set text(font: ("Fira Sans", "Inter"), size: 16pt, lang: "pt", region: "br")
#set par(spacing: 0.95em)
#set list(marker: text(fill: c-teal)[▸])
// vírgula decimal em modo matemático: 0,5 sem espaço depois da vírgula
#show math.equation: it => {
  show ",": math.class("normal", ",")
  it
}

// ---------------------------------------------------------------------
//  Componentes de texto
// ---------------------------------------------------------------------
#let passo(t) = text(fill: c-teal, weight: "bold", t) + h(0.5em)
#let resposta(body) = block(
  width: 100%,
  fill: c-ember.lighten(92%),
  stroke: 0.8pt + c-ember,
  radius: 3pt,
  inset: (x: 12pt, y: 9pt),
  align(center, body),
)
#let destaque(body) = text(fill: c-ember, body)
#let nota(body) = text(size: 0.8em, fill: c-mute, body)
// menos unário (ex.: ∠−5,71°), sem o espaçamento de subtração
#let neg = math.class("unary", sym.minus)

// ---------------------------------------------------------------------
//  Símbolos de diagrama unifilar (CeTZ puro)
// ---------------------------------------------------------------------
#let fio = 0.8pt + c-ink

#let gerador(x, y) = {
  import cetz.draw: *
  circle((x, y), radius: 0.36, fill: white, stroke: fio)
  let pts = range(0, 25).map(i => {
    let t = i / 24
    (x - 0.2 + 0.4 * t, y + 0.12 * calc.sin(t * 360deg))
  })
  line(..pts, stroke: fio)
}

#let trafo(x, y) = {
  import cetz.draw: *
  line((x - 0.62, y), (x - 0.44, y), stroke: fio)
  line((x + 0.44, y), (x + 0.62, y), stroke: fio)
  circle((x - 0.17, y), radius: 0.27, fill: white, stroke: fio)
  circle((x + 0.17, y), radius: 0.27, stroke: fio)
}

#let barra(x, y0, y1) = cetz.draw.line((x, y0), (x, y1), stroke: 2.2pt + c-ink)

#let rotulo(pos, body, anchor: "center", cor: c-ink) = cetz.draw.content(
  pos,
  text(fill: cor, body),
  anchor: anchor,
)

// ---------------------------------------------------------------------
//  Figura: unifilar da Questão 51
// ---------------------------------------------------------------------
#let unifilar-51() = {
  set text(size: 12pt)
  cetz.canvas(length: 1.2cm, {
    import cetz.draw: *
    // geradores
    line((0.36, 2), (1.2, 2), stroke: fio)
    gerador(0, 2)
    rotulo((0, 1.35), $G_1$)
    line((9.6, 2), (10.44, 2), stroke: fio)
    gerador(10.8, 2)
    rotulo((10.8, 1.35), $G_2$)
    // barras
    for x in (1.2, 3.6, 7.2, 9.6) { barra(x, 0.55, 3.45) }
    for (x, t) in ((1.2, [20 kV]), (3.6, [250 kV]), (7.2, [250 kV]), (9.6, [25 kV])) {
      rotulo((x, 3.55), t, anchor: "south")
    }
    // transformadores: (barra esq., centro, barra dir., números)
    for (xa, xb, xc, nums) in ((1.2, 2.4, 3.6, (1, 2)), (7.2, 8.4, 9.6, (3, 4))) {
      for (y, k) in ((3.0, nums.at(0)), (1.0, nums.at(1))) {
        line((xa, y), (xb - 0.62, y), stroke: fio)
        line((xb + 0.62, y), (xc, y), stroke: fio)
        trafo(xb, y)
        rotulo((xb, y - 0.62), $T_#k$)
      }
    }
    // linhas
    line((3.6, 2.4), (7.2, 2.4), stroke: fio)
    rotulo((5.4, 2.47), $j 125 thin Omega$, anchor: "south")
    line((3.6, 1.6), (7.2, 1.6), stroke: fio)
    rotulo((5.4, 1.53), $j 125 thin Omega$, anchor: "north")
  })
}

// ---------------------------------------------------------------------
//  Figura: circuito equivalente em pu da Questão 51 (zap)
//  aberta = false -> sistema completo ; true -> linha 2 fora de operação
// ---------------------------------------------------------------------
#let equiv-51(aberta) = {
  set text(size: 12pt)
  zap.circuit(length: 1.15cm, {
    import zap: *
    import cetz.draw: content, line, set-style
    set-style(zap: (inductor: (scale: 0.6), vsource: (scale: 0.8)))

    let abaixo(v) = (content: v, anchor: "south") // rótulo abaixo do elemento

    // fontes e reatâncias dos geradores
    acvsource("e1", (0, 0), (0, 2.4), label: $E_1 angle delta$)
    inductor("xg1", (0, 2.4), (2, 2.4), label: $j 0,1$)
    inductor("xg2", (8, 2.4), (10, 2.4), label: $j 0,1$)
    acvsource("e2", (10, 0), (10, 2.4), label: abaixo($E_2 angle 0 degree$))

    // barras como ligações verticais
    for x in (2, 4, 6, 8) { wire((x, 1.7), (x, 3.1)) }

    // T1 // T2
    inductor("t1", (2, 3.1), (4, 3.1), label: $j 0,2$)
    inductor("t2", (2, 1.7), (4, 1.7), label: abaixo($j 0,2$))
    // L1 // L2
    inductor("l1", (4, 3.1), (6, 3.1), label: $j 0,2$)
    if aberta {
      line((4, 1.7), (6, 1.7), stroke: (paint: c-mute.lighten(40%), thickness: 0.6pt, dash: "dashed"))
      line((4.75, 1.45), (5.25, 1.95), stroke: 1.4pt + c-ember)
      line((4.75, 1.95), (5.25, 1.45), stroke: 1.4pt + c-ember)
      content((5, 1.05), text(fill: c-ember)[aberta])
    } else {
      inductor("l2", (4, 1.7), (6, 1.7), label: abaixo($j 0,2$))
    }
    // T3 // T4
    inductor("t3", (6, 3.1), (8, 3.1), label: $j 0,2$)
    inductor("t4", (6, 1.7), (8, 1.7), label: abaixo($j 0,2$))

    // referência
    wire((0, 0), (10, 0))

    // rótulos dos blocos e das barras
    for (x, t) in ((1, $G_1$), (3, $T_1 parallel T_2$), (5, $L_1 parallel L_2$), (7, $T_3 parallel T_4$), (9, $G_2$)) {
      content((x, 4.15), text(fill: c-teal, size: 11pt, t))
    }
    for (x, t) in ((2, [20 kV]), (4, [250 kV]), (6, [250 kV]), (8, [25 kV])) {
      content((x, 0.5), text(fill: c-mute, size: 9pt, t))
    }
  })
}

// ---------------------------------------------------------------------
//  Figura: unifilar da Questão 24
//  sol = false -> enunciado ; true -> com tensões e fluxos da solução
// ---------------------------------------------------------------------
#let unifilar-24(sol) = {
  set text(size: 12pt)
  cetz.canvas(length: 1.3cm, {
    import cetz.draw: *
    line((0.36, 1), (1.2, 1), stroke: fio)
    gerador(0, 1)
    line((7.6, 1), (8.44, 1), stroke: fio)
    gerador(8.8, 1)
    for x in (1.2, 4.4, 7.6) { barra(x, 0.35, 1.65) }
    for (x, n) in ((1.2, 1), (4.4, 2), (7.6, 3)) {
      circle((x, 2.0), radius: 0.2, fill: white, stroke: 0.6pt + c-ink)
      content((x, 2.0), text(size: 10pt)[#n])
    }
    line((1.2, 1), (4.4, 1), stroke: fio)
    rotulo((2.8, 1.06), $j 0,2$, anchor: "south")
    line((4.4, 1), (7.6, 1), stroke: fio)
    rotulo((6.0, 1.06), $j 0,2$, anchor: "south")
    // carga
    line((4.4, 0.6), (4.85, 0.6), (4.85, -0.15), stroke: fio, mark: (end: "stealth", fill: c-ink))
    rotulo((7.7, 0.3), $S_(G 3) = 0,5$, anchor: "north-west")

    if sol {
      let seta = (end: "stealth", fill: c-ember)
      line((2.0, 0.62), (3.6, 0.62), stroke: 1pt + c-ember, mark: seta)
      rotulo((2.8, 0.55), $S_12 = 0,5$, anchor: "north", cor: c-ember)
      line((6.8, 0.62), (5.3, 0.62), stroke: 1pt + c-ember, mark: seta)
      rotulo((6.05, 0.55), $S_32 = 0,5$, anchor: "north", cor: c-ember)
      rotulo((4.85, -0.25), $S_c = 1,0 - j 0,1$, anchor: "north", cor: c-ember)
      rotulo((1.2, 2.3), $1 angle 0 degree$, anchor: "south", cor: c-teal)
      rotulo((4.4, 2.3), $1,005 angle #neg 5,71 degree$, anchor: "south", cor: c-teal)
      rotulo((7.6, 2.3), $1 angle 0 degree$, anchor: "south", cor: c-teal)
    }
  })
}

// ---------------------------------------------------------------------
//  Figura: diagrama fasorial da Questão 24 (em escala: 1 pu = 8 unidades)
// ---------------------------------------------------------------------
#let fasorial-24() = {
  set text(size: 14pt)
  cetz.canvas(length: 1.25cm, {
    import cetz.draw: *
    let seta(c) = (end: "stealth", fill: c, scale: 1.2)
    line((0, 0), (8, 0), stroke: 1.1pt + c-navy, mark: seta(c-navy))
    rotulo((8, 0.12), $V_3 = V_1 = 1 angle 0 degree$, anchor: "south-east", cor: c-navy)
    line((0, 0.25), (4, 0.25), stroke: 1.1pt + c-ember, mark: seta(c-ember))
    rotulo((2, 0.32), $I_32 = 0,5 angle 0 degree$, anchor: "south", cor: c-ember)
    line((8, 0), (8, -0.8), stroke: 0.9pt + c-mute, mark: seta(c-mute))
    rotulo((8.15, -0.45), $-j x I_32 = -j 0,1$, anchor: "west", cor: c-mute)
    line((0, 0), (8, -0.8), stroke: 1.1pt + c-teal, mark: seta(c-teal))
    rotulo((4.4, -0.52), $V_2 = 1,0 - j 0,1$, anchor: "north", cor: c-teal)
    arc((0, 0), start: -5.71deg, stop: 0deg, radius: 6, anchor: "origin", stroke: 0.7pt + c-mute)
    rotulo((6.08, -0.3), text(size: 12pt, $theta_2$), anchor: "west", cor: c-mute)
  })
}

// =====================================================================
//  Slides
// =====================================================================
#title-slide()

= Questão 51 --- Perda de uma linha de transmissão

== Questão 51 --- Enunciado

#align(center, unifilar-51())

#grid(
  columns: (1fr, 1fr),
  gutter: 2em,
  {
    set text(size: 14pt)
    table(
      columns: 2,
      stroke: none,
      inset: (x: 5pt, y: 4pt),
      table.hline(stroke: 0.9pt),
      [$G_1$], [100 MVA, 20 kV, $X = 10%$],
      [$G_2$], [100 MVA, 25 kV, $X = 10%$],
      [$T_1$, $T_2$], [50 MVA, 20/250 kV, $X = 10%$],
      [$T_3$, $T_4$], [50 MVA, 25/250 kV, $X = 10%$],
      table.hline(stroke: 0.9pt),
    )
  },
  text(size: 14pt)[
    Sistema sem perdas, $P_12 = 1,0$ pu com tensões nominais.
    Uma linha é perdida; tensões dos geradores e abertura angular
    #alert[inalteradas].

    *Nova potência ativa transmitida, em pu?*
  ],
)

== Questão 51 --- Estratégia

Num sistema sem perdas, a potência transferida entre duas fontes é
$ P = (E_1 E_2)/X_"eq" sin delta . $

#pause
Se $E_1$, $E_2$ e $delta$ #alert[não mudam], então $P prop 1 \/ X_"eq"$:

#align(center, box(stroke: 0.8pt + c-ink, inset: 8pt, $display(P' = P X_"eq"/X'_"eq")$))

#pause
Basta, portanto:
+ escolher as bases e passar tudo para pu;
+ calcular $X_"eq"$ antes e depois da perda da linha.

== Questão 51 --- Passo 1: bases

#passo[Potência base] $S_b = 100$ MVA, comum a todo o sistema.

#pause
#passo[Tensões base] definidas pelas relações dos transformadores:
- zona de $G_1$: 20 kV
- zona das linhas: 250 kV
- zona de $G_2$: 25 kV

#pause
#passo[Impedância base] na zona das linhas:
$ Z_b = V_b^2 / S_b = 250^2 / 100 = 625 thin Omega $

#pause
#nota[As tensões nominais dos equipamentos coincidem com as tensões base de suas
zonas, então só a potência base precisa ser corrigida.]

== Questão 51 --- Passo 2: reatâncias em pu

Mudança de base:
$ X_"novo" = X_"velho" (S_(b,"novo"))/(S_(b,"velho")) ((V_(b,"velho"))/(V_(b,"novo")))^2 $

#pause
#align(center, table(
  columns: (auto, auto, auto),
  stroke: none,
  align: (left, left, right),
  inset: (x: 10pt, y: 6pt),
  table.hline(stroke: 0.9pt),
  [*Elemento*], [*Cálculo*], [*$X$ (pu)*],
  table.hline(stroke: 0.5pt),
  [$G_1$, $G_2$], [já em 100 MVA e tensão nominal], [$0,10$],
  [$T_1 dots.h T_4$], [$0,10 times display(100/50)$], [$0,20$],
  [Cada linha], [$display(125/625)$], [$0,20$],
  table.hline(stroke: 0.9pt),
))

== Questão 51 --- Passo 3: equivalente antes da falha

#align(center, equiv-51(false))

#pause
Cada par em paralelo vale $0,2 parallel 0,2 = 0,1$:
$ X_"eq" &= X_(G_1) + X_(T_1 parallel T_2) + X_(L_1 parallel L_2) + X_(T_3 parallel T_4) + X_(G_2) \
         &= 0,1 + 0,1 + 0,1 + 0,1 + 0,1 = #destaque[$0,5$ pu] $

== Questão 51 --- Passo 4: equivalente após a perda da linha

#align(center, equiv-51(true))

#pause
Só o bloco das linhas muda: agora resta uma linha de $0,2$ pu.
$ X'_"eq" = 0,1 + 0,1 + #destaque[$0,2$] + 0,1 + 0,1 = #destaque[$0,6$ pu] $

== Questão 51 --- Resultado

$ P' = P X_"eq"/X'_"eq" = 1,0 times (0,5)/(0,6) $

#resposta[$P' = display(5/6) approx 0,833$ pu]

#pause
#passo[Conferência] Com $E_1 = E_2 = 1,0$: $sin delta = P X_"eq" = 0,5 => delta = 30 degree$.
Depois: $P' = sin 30 degree \/ 0,6 = 0,833$ pu.

#pause
#passo[Por que não cai pela metade?] A linha perdida é só uma parte da reatância
total: $X_"eq"$ sobe de $0,5$ para $0,6$ (20%), e a potência cai na proporção inversa.

#pause
#nota[Obs.: se as tensões mantidas fossem as _terminais_ dos geradores (sem $X_G$
no caminho), seria $0,3 \/ 0,4 = 0,75$ pu.]

= Questão 24 --- Fluxo de potência em três barras

== Questão 24 --- Enunciado

#align(center, unifilar-24(false))

#grid(
  columns: (1fr, 0.85fr),
  gutter: 2em,
  text(size: 15pt)[
    Potência injetada na barra 3 e impedâncias em pu.
    Tensões nas barras 1 e 3 iguais a $1,0$ pu.

    *Tensão na barra 2 e fluxo de potência saindo da barra 1 para a barra 2?*
  ],
  {
    set text(size: 15pt)
    set enum(numbering: "(A)")
    [
      + $1,0$ pu e $1,0$ pu
      + $1,0 - j 0,1$ pu e $1,0$ pu
      + $1,0 + j 0,1$ pu e $0,5$ pu
      + $1,0 - j 0,1$ pu e $0,5$ pu
      + $1,0 + j 0,1$ pu e $1,0$ pu
    ]
  },
)

== Questão 24 --- Leitura dos dados

- $V_1 = V_3 = 1,0 angle 0 degree$ pu #h(1em) (fasores dados como $1,0$)
- $S_(G 3) = 0,5 + j 0$ pu #h(1em) (só potência ativa)
- $x = 0,2$ pu em cada trecho

#pause
#passo[Ideia] A carga da barra 2 é desconhecida, mas na #alert[barra 3]
conhecemos tensão _e_ potência. Daí sai a corrente do trecho 3--2, depois $V_2$
e, por fim, o fluxo 1--2.

== Questão 24 --- Passos 1 e 2: corrente e tensão na barra 2

#passo[Passo 1] Corrente que sai da barra 3 em direção à barra 2:
$ I_32 = (S_(G 3) / V_3)^* = ((0,5)/(1 angle 0 degree))^* = 0,5 angle 0 degree "pu" $

#pause
#passo[Passo 2] Queda no trecho 3--2:
$ V_2 = V_3 - j x I_32 = 1 - j 0,2 times 0,5 = #destaque[$1,0 - j 0,1$ pu] $

#pause
#nota[Em módulo e ângulo: $|V_2| = 1,005$ pu, $theta_2 = -5,71 degree$.]

== Questão 24 --- Passo 3: fluxo da barra 1 para a barra 2

$ I_12 = (V_1 - V_2)/(j x) = (1 - (1 - j 0,1))/(j 0,2) = (j 0,1)/(j 0,2) = 0,5 "pu" $

#pause
$ S_12 = V_1 I_12^* = 1 times 0,5 = #destaque[$0,5 + j 0$ pu] $

#pause
#resposta[Alternativa *(D)*: #h(0.6em) $V_2 = 1,0 - j 0,1$ pu #h(0.6em) e #h(0.6em) $S_12 = 0,5$ pu]

== Questão 24 --- Diagrama fasorial (em escala)

#align(center, fasorial-24())

#pause
- $S_(G 3)$ é puramente ativa e $|V_3| = 1$ $=>$ $I_32$ fica #alert[em fase] com $V_3$.
#pause
- A queda $j x I_32$ é perpendicular à corrente: altera quase só o _ângulo_ de
  $V_2$ ($theta_2 = -5,71 degree$); o módulo vai a $1,005$.
#pause
- Conferência: $P_12 = (|V_1| |V_2|)/x sin theta_12 = (1 times 1,005)/(0,2) sin 5,71 degree = 0,5$ pu.

== Questão 24 --- Interpretação física

#align(center, unifilar-24(true))

#pause
- Simetria: $V_1 = V_3$ e trechos iguais $=>$ cada lado entrega $0,5$ pu à carga
  ($P_c = 1,0$ pu).
- Cada trecho consome $Q = |I|^2 x = 0,05$; como as fontes não entregam reativo,
  os $0,1$ pu vêm da barra 2 (carga capacitiva).
#pause
- (C) e (E) falham: com $V_2 = 1 + j 0,1$, $I_12 = -0,5$ e o fluxo seria de 2 para 1.

#focus-slide[
  Q51 #h(1em) $P' approx 0,833$ pu \
  Q24 #h(1em) Alternativa (D)
]
