---
name: tm-prd
description: "Investiga o projeto e entrevista o usuário para gerar um PRD de produto ou feature com decisões confirmadas, histórias, regras, fluxos, critérios de aceite, stack e specs funcionais. Use somente com /tm-prd."
disable-model-invocation: true
---

# Gerador de PRD

Use somente com `/tm-prd`.

Transforme uma ideia de produto ou feature em um PRD que registre **o que foi decidido e por quê**. O documento serve como entrada para `/tm-plan-spec`, que cria o plano técnico de cada spec. Nesta skill, não crie plano técnico, tarefas ou código.

## Condução

1. **Entenda o pedido e o projeto.** Se a ideia ainda não foi descrita, peça uma descrição breve. Inspecione apenas o que for relevante: `AGENTS.md` e outras instruções locais, README, documentação, estrutura, dependências e o código dos fluxos afetados. Em um projeto novo, verifique o que já está definido antes de sugerir uma stack. Identifique se o PRD é do produto inicial ou de uma feature e informe ao usuário sua leitura; ajuste se ele indicar outro recorte. Não trate uma feature como uma nova versão do produto inteiro.
2. **Investigue o objetivo.** Descubra o problema, os usuários, o resultado esperado, as ações necessárias e as restrições. No projeto existente, identifique comportamentos, entidades, integrações e convenções que a proposta toca ou pode reaproveitar. Diferencie fatos observados no repositório, informações dadas pelo usuário e hipóteses suas.
3. **Analise alternativas antes de fechar decisões.** Para escolhas que mudam o comportamento ou a stack, apresente opções viáveis com vantagens, custos e riscos proporcionais ao caso. Recomende a opção que melhor atende ao objetivo e explique o motivo. Aponte conflitos com o sistema atual e complexidade desnecessária. Pergunte em blocos pequenos, numerando cada pergunta e dando sua resposta recomendada, para o usuário poder aceitar rápido; ofereça opções concretas quando ele não souber responder. Não transforme uma recomendação em decisão sem confirmação.
4. **Consolide as decisões.** Confirme o recorte, o que fica fora dele, histórias, regras, fluxos, estados, validações, tratamento de erros, dados conceituais e critérios de aceite que importam. Combine também como dividir a entrega em specs: cada spec é uma entrega coerente e verificável, em ordem de dependência. Resolva dúvidas que alteram o resultado antes de finalizar. Use seu julgamento para detalhes menores, mas apresente-os ao usuário como proposta para confirmação. Se uma decisão essencial continuar pendente, continue a conversa e não publique um PRD final incompleto.
5. **Gere e revise o PRD.** Salve somente o documento Markdown em `docs/prd/NN-prd-<slug>.md` na raiz do projeto, com `NN` sequencial de dois dígitos a partir dos arquivos já existentes em `docs/prd/`; nunca sobrescreva um PRD existente. Verifique se cada história aparece em um fluxo ou comportamento, se as regras importantes têm critérios de aceite verificáveis e se cada critério pertence a alguma spec. Entregue só o caminho do arquivo e indique que o próximo passo é `/tm-plan-spec` em outro chat.

Durante esta skill, o código do projeto é fonte de leitura, não alvo de alteração. Não instale dependências nem execute comandos que modifiquem o projeto. A única saída em arquivo é o PRD.

## Conteúdo do PRD

Adapte as seções à complexidade real do pedido. Registre somente o que foi decidido para o recorte atual. Não inclua requisitos desejáveis, backlog, melhorias futuras, alternativas rejeitadas ou hipóteses não confirmadas. A análise de alternativas acontece na conversa; no documento, registre a escolha e sua justificativa.

As seções **Fora do escopo**, **Specs** e **Ordem recomendada de implementação** são obrigatórias: `/tm-plan-spec` lê as specs nessa ordem e usa o status de cada uma, e `/tm-code-review` usa o fora do escopo para apontar escopo extra.

```markdown
# PRD — [Nome do produto ou da feature]

> Tipo: [Produto inicial | Feature] · Data: [AAAA-MM-DD]
> Status: Aguardando implementação

## Visão geral e objetivo

[Problema, público afetado e resultado que a entrega deve produzir.]

## Contexto do projeto

[Em uma feature: comportamento existente relevante, pontos de integração e restrições constatadas. Em um produto inicial: contexto e restrições já definidos.]

## Decisões do produto

[Comportamentos e limites positivos acordados para esta entrega, com justificativa quando ajudar a interpretar a decisão.]

## Fora do escopo

- [O que foi explicitamente deixado de fora desta entrega.]

## Histórias de usuário

- Como [ator], quero [ação ou capacidade], para [benefício].

## Regras de negócio e dados

[Regras objetivas, permissões, validações, estados e dados conceituais necessários para compreender o comportamento.]

## Fluxos

### [Nome do fluxo]

1. [Ação do ator e resposta do sistema.]
2. [Resultado, incluindo caminhos de erro relevantes.]

## Critérios de aceite

- Dado [contexto], quando [ação], então [resultado observável].

## Stack e restrições técnicas decididas

[Tecnologias existentes que serão mantidas ou escolhas de alto nível confirmadas, com justificativa breve. Cite uma tecnologia nova somente se sua adoção foi decidida.]

## Specs

### Spec 01 — [nome curto]

> Status: Aguardando implementação

- **Objetivo:** [o que esta entrega torna possível]
- **Comportamento:** [o que o usuário vê e o sistema faz]
- **Aceite:** [critérios da seção acima que esta spec cumpre]
- **Depende de:** [specs anteriores ou "nenhuma"]

## Ordem recomendada de implementação

1. Spec 01 — [motivo da posição, se não for óbvio]
```

Escreva em linguagem clara e verificável. Descreva comportamento e dados no nível de produto; deixe arquitetura detalhada, nomes de arquivos, APIs internas, schemas e testes de implementação para `/tm-plan-spec`. Se uma seção opcional não acrescentar informação ao PRD específico, remova-a em vez de preencher com suposições.
