---
name: ask-marzari
description: "Indica a skill, o prompt ou a sequência adequada para uma tarefa neste kit. Use somente com /ask-marzari quando o próximo passo não estiver claro, quando houver duas opções parecidas ou ao trocar de fase."
disable-model-invocation: true
---

# Pergunte ao Marzari

## Objetivo

Analise o pedido do usuário e indique o próximo passo mais adequado dentro deste kit. O resultado deve informar:

- qual fluxo resolve a situação;
- qual skill ou prompt deve ser usado;
- quais decisões pertencem ao usuário;
- quando revisar ou trocar de fase.

## Limites

Esta skill é um roteador. Depois de recomendar o caminho:

1. não execute a skill recomendada;
2. não escreva código, PRD, plano ou documentação;
3. não altere arquivos;
4. termine com o comando ou caminho que o usuário deve usar agora.

Pode ler o `SKILL.md` da opção recomendada para confirmar seu comportamento. Essa leitura serve apenas para orientar a recomendação e não inicia a skill.

## Etapa 1 — Entender a situação

Classifique o pedido pela primeira necessidade real:

1. **Entendimento e decisões**: a ideia está vaga ou há escolhas de escopo, fluxo ou regra em aberto?
2. **Documentação de produto**: o escopo está definido, mas falta registrar comportamento, regras e aceite?
3. **Planejamento técnico**: existe um PRD com especificações e falta decidir como implementar a próxima?
4. **Implementação**: o usuário já sabe o que quer construir e quer alterar o código?
5. **Revisão**: quer verificar uma branch, um pull request ou alterações desde um ponto?
6. **Documentação existente**: o código mudou e os documentos precisam ser sincronizados?
7. **Histórico da branch**: precisa organizar commits antes de entregar?
8. **Escrita de instruções**: quer criar ou melhorar uma skill, regra ou documento consumido por agentes?

Se o pedido não permitir escolher uma categoria, faça **uma pergunta objetiva**. Não faça uma lista de perguntas nem recomende várias rotas sem explicar a diferença.

**Conclua quando:** houver uma categoria principal e um próximo passo claro.

## Etapa 2 — Escolher a rota

### Ideia ou escopo ainda aberto

Use `/questiona` quando o usuário ainda não sabe exatamente o que construir ou há decisões importantes pendentes.

Depois que o escopo estiver fechado:

- produto ou funcionalidade precisa ser documentado → `/prd-generator`;
- tarefa pequena, clara e sem necessidade de PRD → implementação direta pelo agente.

### PRD e especificações

Use `/prd-generator` para transformar uma ideia ou funcionalidade em PRD e especificações funcionais.

Quando já existir um PRD em `docs/prd/`:

- revisar qual especificação vem depois → `/plan-spec`;
- planejar todas as especificações → `/plan-spec todas`;
- implementar diretamente o recorte → `/plan-spec implementa`;
- implementar todas em uma tarefa curta → `/plan-spec todas implementa`.

O PRD deve ser revisado pelo usuário antes do planejamento. O plano deve ser aprovado antes da implementação quando o comando não incluir `implementa`.

### Implementação e testes

Durante uma implementação que envolva regras de negócio, o agente pode usar `.prompts/tdd-com-agentes.md`.

Antes de decidir a estratégia de testes, use `.prompts/testes-automatizados.md`.

Esses arquivos são prompts para o usuário colar ou solicitar; não são skills e não são executados por este roteador.

### Revisão de código

Use `/code-review` quando o usuário quiser revisar alterações de uma branch, pull request ou período definido por commit, tag ou branch.

O usuário precisa informar o ponto de comparação, como `main`, `HEAD~3` ou uma tag. A revisão separa qualidade estrutural do código e atendimento à especificação.

### Documentação

Use `/documentation-writer` quando a documentação do projeto estiver desatualizada em relação ao código existente.

Use `/writing-for-agents` quando o usuário quiser criar ou revisar instruções para agentes, como skills, `AGENTS.md`, `CLAUDE.md` ou arquivos de referência.

### Organização de commits

Use `/rework-commits` quando a branch tiver um commit único, histórico confuso ou precisar ser reorganizada antes da entrega.

## Etapa 3 — Informar o fluxo

Responda neste formato:

```markdown
Situação: [resumo em uma frase].

Fluxo recomendado: [nome do fluxo].

1. [comando ou prompt inicial]
2. [próxima etapa, se houver]
3. [ponto de revisão ou decisão humana]

Agora: [o que o usuário deve fazer].
```

Inclua somente as etapas aplicáveis ao pedido. Se uma etapa depender de uma decisão humana, diga qual decisão precisa ser tomada. Não apresente uma sequência genérica.

## Fluxos principais

### Da ideia à entrega

`/questiona` → `/prd-generator` → `/plan-spec` → implementação → `/documentation-writer`

Use apenas as etapas necessárias. Não force PRD para uma tarefa pequena e clara.

### De um PRD à implementação

`/plan-spec` → aprovação do plano → `/plan-spec implementa`

Para poucas especificações, use `/plan-spec todas`; para executar todas sem uma etapa separada de plano, use `/plan-spec todas implementa`.

### Da implementação à entrega

Implementação → testes → `/code-review` → `/documentation-writer`

Use `/code-review` quando houver um ponto de comparação e uma alteração concreta para revisar. Use `/documentation-writer` somente quando houver documentação para sincronizar.

## Troca de fase

Sugira um novo chat quando:

- o PRD terminou e o próximo trabalho é planejar;
- uma especificação mudou;
- o contexto ficou cheio de tentativas descartadas;
- uma nova fase tem objetivo diferente.

Continue no mesmo chat quando a próxima ação depende diretamente do contexto atual e não houver risco de confusão.

Não recomende uma troca de fase no meio de uma implementação que ainda está em andamento.

## Validação da resposta

Antes de terminar, confirme:

- [ ] uma única rota principal foi escolhida;
- [ ] o motivo da escolha está claro;
- [ ] skills e prompts não foram confundidos;
- [ ] decisões humanas estão indicadas;
- [ ] nenhuma skill foi executada;
- [ ] a última linha diz exatamente o próximo comando ou ação.
