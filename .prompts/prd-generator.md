# Prompt — briefing para /prd-generator

Cole no chat **com** `/prd-generator`. Quanto mais preencher, menos a skill pergunta. O que não souber, deixe em **Regras em aberto** — a skill pergunta em vez de inventar.

Troque `[colchetes]`; apague seções que não se aplicarem.

---

## Produto novo

```text
/prd-generator

Modo: INICIAL.

## Ideia
[Uma frase: o que é e para qual contexto]

## Problema
[Como é hoje; quem sofre]

## Público
- [perfil principal]
[Recorte do que NÃO é público]

## Ações
[Perfil]: [ação observável 1], [ação 2], …

## Essencial agora
- …

## Fora do escopo agora
- …

## Regras fechadas
- …

## Regras em aberto
- …

## Fluxos principais
1. [ator] → [passos] → [resultado]

## Como saber que está bom
- [critério verificável]
```

---

## Funcionalidade em projeto existente

```text
/prd-generator

Modo: FEATURE.

## Feature
[Uma frase: o que passa a ser possível]

## Contexto (já existe)
- [2–5 bullets do que o sistema já faz]

Não reinventar: [o que permanece]

## Problema
[Lacuna atual e consequência]

## Ações
[por perfil]: …

## Essencial / Fora desta feature / Regras fechadas / Regras em aberto / Fluxos / Aceite
[mesma lógica do modelo acima]
```

---

**Depois do PRD:** chat novo e `/plan-spec` (sem colar o arquivo).
