# PRD — [Nome do Projeto/Feature]

> Tipo: [PRD inicial | PRD de feature] · Data: [YYYY-MM-DD]
> **Status:** Aguardando implementação
>
> <!-- Valores possíveis: "Aguardando implementação" | "Implementada". Atualize para "Implementada" quando todas as specs estiverem concluídas. -->

## 1. Visão geral

[Explicação clara do que é, em linguagem simples.]

## 2. Problema que resolve

[Problema principal.]

## 3. Público-alvo

[Quem vai usar.]

## 4. Objetivo do recorte atual

[O objetivo desta entrega — produto inicial OU feature.]

## 5. Funcionalidades

**Essenciais:**

- ...

**Desejáveis:**

- ...

## 6. Fora do escopo

- ...

## 7. Regras de negócio

- Regra 1: ...
- Regra 2: ...

## 8. Fluxos principais

### Fluxo 1 — [nome]

1. ...
2. ...

## 9. Critérios de aceite

- O usuário consegue ...
- O sistema deve ...
- O sistema não deve ...
- Quando X, o sistema deve Y

## 10. Stack

[Em alto nível. Em modo feature, a stack já existente do projeto.]

## 11. Justificativa da stack

[Por que faz sentido — simples e direto.]

## 12. Fases de construção

### Fase 1 — [nome]

Objetivo: ...
Specs:

- Spec 01 — ...
- Spec 02 — ...

## 13. Specs funcionais detalhadas

> Cada spec deve ser autossuficiente: um agente de codificação vai ler SÓ esta spec (mais as dependências) para montar o plano técnico e implementar. Preencha todos os campos; se um não se aplica, escreva "Não se aplica" e o porquê.

### Spec 01 — [nome curto e claro]

- **Fase:** [a qual fase pertence]
- **Objetivo (o quê):** [o resultado que esta spec entrega, em 1–2 frases]
- **Intenção (por quê):** [o valor/problema que justifica esta spec — o agente usa isso para decidir bem na hora de implementar]
- **Contexto:** [o que já existe e se relaciona; em modo feature, telas/entidades/fluxos do projeto que esta spec toca ou reutiliza]
- **Atores:** [quem dispara/usa este comportamento]
- **Descrição do comportamento:** [o que o sistema faz, em detalhe — o caminho principal de ponta a ponta]
- **Entradas e saídas:** [dados que entram (com origem) e o que o sistema produz/exibe/retorna]
- **Dados/entidades envolvidos (conceitual):** [quais informações são manipuladas — ex.: "contrato: início, fim, valor, status"; sem schema/tabelas/tipos técnicos]
- **Estados e transições:** [estados possíveis e o que muda de um para outro; "Não se aplica" se não houver]
- **Regras de negócio:** [regras objetivas que valem nesta spec]
- **Validações:** [o que precisa ser validado antes de aceitar uma ação]
- **Fluxo do usuário (passo a passo):**
  1. ...
  2. ...
- **Casos de borda e erros:** [entradas inválidas, vazios, conflitos, permissão negada, falhas — e o que o sistema faz em cada um]
- **Impacto no existente:** [modo feature: o que muda/é afetado no que já existe; "Nenhum" se for isolado]
- **Critérios de aceite (Dado/Quando/Então):**
  - Dado ... Quando ... Então ...
  - Dado ... Quando ... Então ...
- **Definição de pronto:** [como saber que esta spec está concluída e validável]
- **Dependências:** [Nenhuma | Spec X — e o que dela é necessário]
- **Fora do escopo desta spec:** [o que NÃO entra aqui, para o agente não extrapolar]

## 14. Ordem recomendada de implementação

1. Spec 01 — ...
2. Spec 02 — ...

[Explique que seguir a ordem evita implementar partes fora de contexto e respeita as dependências.]
