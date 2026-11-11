---
theme: default
title: Questão 24 — Fluxo de potência em três barras
info: Sistemas Elétricos de Potência
transition: fade
---

# <span style="color:#2F5D4B">Questão 24</span>

Fluxo de potência em três barras

---

# <span style="color:#2F5D4B">Enunciado</span>

Considere um sistema elétrico de potência representado pelo diagrama
unifilar a seguir. A potência injetada na barra 3 e as impedâncias das
linhas que conectam a barra 1 à barra 2 bem como a barra 2 à barra 3 são
mensuradas por unidade (pu). Tanto a tensão na barra 1 quanto a tensão na
barra 3 são iguais a 1,0 pu.

<p class="text-center font-bold">Diagrama unifilar do sistema</p>

<svg class="mx-auto" viewBox="0 0 680 240" width="600" height="212" font-family="Fira Sans, Helvetica, Arial, sans-serif">
<defs>
  <marker id="fx-seta-enun" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto">
    <path d="M1 1L9 5L1 9z" fill="#22262B"/>
  </marker>
</defs>
<!-- geradores -->
<circle cx="70" cy="130" r="22" fill="white" stroke="#22262B" stroke-width="1.5"/>
<path d="M58 130 Q64 119 70 130 T82 130" fill="none" stroke="#22262B" stroke-width="1.5"/>
<circle cx="610" cy="130" r="22" fill="white" stroke="#22262B" stroke-width="1.5"/>
<path d="M598 130 Q604 119 610 130 T622 130" fill="none" stroke="#22262B" stroke-width="1.5"/>
<line x1="92" y1="130" x2="140" y2="130" stroke="#22262B" stroke-width="1.5"/>
<line x1="540" y1="130" x2="588" y2="130" stroke="#22262B" stroke-width="1.5"/>
<!-- linhas e carga -->
<line x1="140" y1="130" x2="540" y2="130" stroke="#22262B" stroke-width="1.5"/>
<path d="M340 152 H360 V212" fill="none" stroke="#22262B" stroke-width="1.5" marker-end="url(#fx-seta-enun)"/>
<!-- barras -->
<line x1="140" y1="95" x2="140" y2="165" stroke="#22262B" stroke-width="6"/>
<line x1="340" y1="95" x2="340" y2="165" stroke="#22262B" stroke-width="6"/>
<line x1="540" y1="95" x2="540" y2="165" stroke="#22262B" stroke-width="6"/>
<!-- rótulos -->
<text x="140" y="82" text-anchor="middle" font-size="15" fill="#22262B">Barra 1</text>
<text x="340" y="82" text-anchor="middle" font-size="15" fill="#22262B">Barra 2</text>
<text x="540" y="82" text-anchor="middle" font-size="15" fill="#22262B">Barra 3</text>
<text x="240" y="119" text-anchor="middle" font-size="14" fill="#7A828C">j0,2</text>
<text x="440" y="119" text-anchor="middle" font-size="14" fill="#7A828C">j0,2</text>
<text x="70" y="174" text-anchor="middle" font-size="15" fill="#22262B">G1</text>
<text x="610" y="174" text-anchor="middle" font-size="15" fill="#22262B">G3</text>
<text x="610" y="200" text-anchor="middle" font-size="15" fill="#22262B">S<tspan font-size="11" dy="4">G3</tspan><tspan dy="-4"> = 0,5</tspan></text>
</svg>

---

# <span style="color:#2F5D4B">Enunciado (continuação)</span>

Com base nessas informações, é correto dizer que a tensão na barra 2 e o
fluxo de potência saindo da barra 1 para a barra 2 são, respectivamente,

(A) $1{,}0$ pu e $1{,}0$ pu.\
(B) $1{,}0 - j0{,}1$ pu e $1{,}0$ pu.\
(C) $1{,}0 + j0{,}1$ pu e $0{,}5$ pu.\
(D) $1{,}0 - j0{,}1$ pu e $0{,}5$ pu.\
(E) $1{,}0 + j0{,}1$ pu e $1{,}0$ pu.

---

# <span style="color:#2F5D4B">Passos 1 e 2: corrente e tensão na barra 2</span>

$$
I_{32} = \left(\frac{S_{G3}}{V_3}\right)^{*} = 0{,}5\angle 0^\circ \ \text{pu}
$$

<v-click>

$$
V_2 = V_3 - jx\,I_{32} = 1{,}0 - j0{,}1 \ \text{pu}
$$

</v-click>

---

# <span style="color:#2F5D4B">Passo 3: fluxo da barra 1 para a barra 2</span>

$$
I_{12} = \frac{V_1 - V_2}{jx} = \frac{j0{,}1}{j0{,}2} = 0{,}5 \ \text{pu}
\qquad
S_{12} = V_1\,I_{12}^{*} = 0{,}5 \ \text{pu}
$$

<v-click>

Alternativa <span style="color:#D70000; font-weight:bold">(D)</span>: $V_2 = 1{,}0 - j0{,}1$ pu e $S_{12} = 0{,}5$ pu

</v-click>

---

# <span style="color:#2F5D4B">Sentido do fluxo de potência</span>

Cada clique revela um trecho; a velocidade do tracejado é proporcional à potência.

<svg class="mx-auto" viewBox="0 0 680 240" width="680" height="240" font-family="Fira Sans, Helvetica, Arial, sans-serif">
<defs>
  <marker id="fx-seta" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto">
    <path d="M1 1L9 5L1 9z" fill="#22262B"/>
  </marker>
</defs>
<!-- geradores -->
<circle cx="70" cy="130" r="22" fill="white" stroke="#22262B" stroke-width="1.5"/>
<path d="M58 130 Q64 119 70 130 T82 130" fill="none" stroke="#22262B" stroke-width="1.5"/>
<circle cx="610" cy="130" r="22" fill="white" stroke="#22262B" stroke-width="1.5"/>
<path d="M598 130 Q604 119 610 130 T622 130" fill="none" stroke="#22262B" stroke-width="1.5"/>
<line x1="92" y1="130" x2="140" y2="130" stroke="#22262B" stroke-width="1.5"/>
<line x1="540" y1="130" x2="588" y2="130" stroke="#22262B" stroke-width="1.5"/>
<!-- linhas e carga -->
<line x1="140" y1="130" x2="540" y2="130" stroke="#22262B" stroke-width="1.5"/>
<path d="M340 152 H360 V212" fill="none" stroke="#22262B" stroke-width="1.5" marker-end="url(#fx-seta)"/>
<!-- barras -->
<line x1="140" y1="95" x2="140" y2="165" stroke="#22262B" stroke-width="6"/>
<line x1="340" y1="95" x2="340" y2="165" stroke="#22262B" stroke-width="6"/>
<line x1="540" y1="95" x2="540" y2="165" stroke="#22262B" stroke-width="6"/>
<!-- rótulos -->
<text x="140" y="82" text-anchor="middle" font-size="15" fill="#22262B">Barra 1</text>
<text x="340" y="82" text-anchor="middle" font-size="15" fill="#22262B">Barra 2</text>
<text x="540" y="82" text-anchor="middle" font-size="15" fill="#22262B">Barra 3</text>
<text x="240" y="119" text-anchor="middle" font-size="14" fill="#7A828C">j0,2</text>
<text x="440" y="119" text-anchor="middle" font-size="14" fill="#7A828C">j0,2</text>
<text x="70" y="174" text-anchor="middle" font-size="15" fill="#22262B">G1</text>
<text x="610" y="174" text-anchor="middle" font-size="15" fill="#22262B">G3</text>
<!-- etapa 1: fluxo da barra 1 para a 2 -->
<g id="fx-12" v-click="1">
  <path class="fx-flow" d="M146 130 H334"/>
  <text x="240" y="157" text-anchor="middle" font-size="15" fill="#2F5D4B">S<tspan font-size="11" dy="4">12</tspan><tspan dy="-4"> = 0,5 pu</tspan></text>
</g>
<!-- etapa 2: fluxo da barra 3 para a 2 -->
<g id="fx-32" v-click="2">
  <path class="fx-flow" d="M534 130 H346"/>
  <text x="440" y="157" text-anchor="middle" font-size="15" fill="#2F5D4B">S<tspan font-size="11" dy="4">32</tspan><tspan dy="-4"> = 0,5 pu</tspan></text>
</g>
<!-- etapa 3: potência entregue à carga (dobro da velocidade: 1,0 pu) -->
<g id="fx-c" v-click="3">
  <path class="fx-flow fx-rapido" d="M346 152 H360 V204"/>
  <text x="374" y="198" font-size="15" fill="#D70000">carga: 1,0 &#8722; j0,1 pu</text>
</g>
</svg>

<div v-click="4" class="text-center mt-4">
Simetria: cada barra geradora entrega 0,5 pu e a carga recebe 1,0 pu.
</div>

<style>
.fx-flow { fill: none; stroke: #2F5D4B; stroke-width: 5; stroke-dasharray: 8 12;
           animation: fx-corre 1.2s linear infinite; }
.fx-rapido { animation-duration: 0.6s; }
@keyframes fx-corre { to { stroke-dashoffset: -40; } }
</style>
