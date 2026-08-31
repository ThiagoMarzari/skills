---
name: plan-spec
description: Cria o plano técnico da próxima especificação pendente de um PRD em docs/prd/. Use com /plan-spec; acrescente "todas" para planejar todas as especificações pendentes ou "implementa" para executar o recorte sem uma etapa separada de aprovação.
disable-model-invocation: true
---

# Planejamento de especificação

## Ativação e objetivo

Use esta skill somente quando o usuário digitar `/plan-spec`.

Transforme uma especificação funcional de `docs/prd/` em um plano técnico implementável, usando o código e a tecnologia que já existem no projeto. O plano deve explicar **o que mudar, em que ordem, como validar e o que fica fora do recorte**.

Não peça para o usuário colar o PRD ou a especificação. Leia os arquivos do projeto.

## Modos

O comando pode receber dois modificadores:

- `/plan-spec`: planeja somente a próxima especificação pendente.
- `/plan-spec todas`: planeja todas as especificações pendentes, na ordem definida pelo PRD.
- `/plan-spec implementa`: implementa somente a próxima especificação pendente, sem esperar aprovação de um plano separado.
- `/plan-spec todas implementa`: implementa todas as especificações pendentes, na ordem do PRD.

Sem `implementa`, esta skill apenas planeja. Com `implementa`, pode alterar o código dentro do recorte selecionado.

## Etapa 1 — Localizar o PRD

1. Liste apenas os nomes dos arquivos em `docs/prd/`.
2. Considere primeiro arquivos no padrão `NN-prd-<slug>.md`.
3. Se houver mais de um PRD aplicável, identifique qual corresponde ao pedido atual.
4. Se a escolha não puder ser feita pelo contexto, pergunte qual PRD usar.
5. Leia o PRD escolhido e a especificação-alvo.

Se não houver PRD em `docs/prd/`, informe que `/prd-generator` precisa ser executado antes. Não crie um PRD nesta skill.

**Conclua quando:** houver um único PRD escolhido e seu conteúdo estiver disponível para análise.

## Etapa 2 — Selecionar a especificação

Use a seção **Ordem recomendada de implementação** do PRD:

1. percorra as especificações na ordem apresentada;
2. pule as que tiverem `Status: Implementada`;
3. selecione a primeira com `Status: Aguardando implementação`;
4. verifique as dependências dessa especificação;
5. se o comando incluir `todas`, inclua todas as especificações ainda pendentes, mantendo a ordem do PRD.

Se todas estiverem implementadas, informe que não há trabalho pendente. Não gere um plano vazio. Se uma especificação depender de outra que ainda não foi implementada, preserve a ordem e destaque a dependência no plano.

Uma especificação que não tenha status, esteja com status desconhecido ou não apareça na ordem do PRD deve ser tratada como pendência de documentação: informe o problema e peça correção antes de planejar.

**Conclua quando:** o alvo estiver definido, seu status for conhecido e a ordem de execução estiver clara.

## Etapa 3 — Entender o código existente

Leia somente o contexto necessário para o alvo:

1. arquivos diretamente relacionados ao fluxo;
2. modelos ou tipos das entidades envolvidas;
3. rotas, telas, serviços, ações ou integrações afetados;
4. autenticação, permissões e validações existentes, quando aplicáveis;
5. testes relacionados;
6. configurações e scripts relevantes para validar a mudança.

Em um projeto existente, reutilize a tecnologia, os padrões e as entidades encontradas. Não proponha troca de framework, biblioteca, banco, autenticação ou estrutura sem necessidade explícita da especificação.

Compare o código com todos os campos importantes da spec:

- objetivo e intenção;
- contexto e atores;
- comportamento;
- entradas e saídas;
- dados e entidades;
- estados e transições;
- regras e validações;
- fluxo;
- casos de borda e erros;
- impacto no existente;
- critérios de aceite;
- definição de pronto;
- dependências;
- fora do escopo.

Se a spec tiver uma lacuna que impeça decisões técnicas, pare e informe a lacuna. Não invente comportamento. Se a lacuna não bloquear o plano, registre-a como suposição explícita.

**Conclua quando:** o código relacionado, as dependências, os pontos de integração e todas as lacunas relevantes estiverem identificados.

## Etapa 4 — Montar o plano

Sem `implementa`, se ainda não estiver no modo de planejamento, troque para Plan mode antes de redigir o plano. Apresente o plano no painel nativo de planejamento do editor; não entregue apenas um texto solto no chat. Espere a aprovação do usuário antes de implementar.

Se o editor não tiver Plan mode, escreva o plano no chat e pare para aprovação.

Para cada especificação planejada, inclua:

1. **Objetivo do recorte**: resultado e intenção.
2. **Pontos afetados**: arquivos, módulos ou áreas identificados no código; não invente caminhos.
3. **Sequência de implementação**: passos ordenados, cada um com sua finalidade.
4. **Dados e regras**: entidades, validações, permissões e transições que precisam ser respeitadas.
5. **Integrações**: pontos existentes a reutilizar ou alterar.
6. **Testes e verificações**: como validar cada critério de aceite e os casos de erro.
7. **Fora do escopo**: itens da spec ou do PRD que não entram neste recorte.
8. **Dependências**: o que precisa estar pronto antes e qual parte será liberada para a próxima spec.

O plano deve usar a tecnologia já presente no projeto e manter a granularidade da spec. Não inclua funcionalidades de outra especificação.

**Conclua quando:** cada requisito da spec tiver uma ação planejada, uma forma de validação ou uma justificativa clara de não aplicabilidade.

## Etapa 5 — Implementar quando solicitado

Só implemente quando:

- o comando incluir `implementa`; ou
- o usuário aprovar explicitamente o plano produzido nesta conversa.

Com `implementa`:

1. implemente apenas o recorte selecionado;
2. siga a ordem planejada;
3. valide os critérios de aceite e os casos de erro;
4. preserve alterações existentes fora do recorte;
5. marque a spec como `Implementada` somente depois que a implementação estiver validada;
6. se todas as specs do PRD estiverem implementadas, atualize o status do PRD conforme o padrão usado no documento.

Sem `implementa`, não altere código, testes, documentação ou status no PRD.

## Saída e validação

Sem `implementa`, o plano deve terminar com:

- especificação planejada;
- decisões técnicas e dependências;
- passos de implementação;
- verificações e critérios de aceite;
- fora do escopo;
- pergunta de aprovação: **“Aprova este plano para implementação?”**

Com `implementa`, informe:

- o que foi implementado;
- quais validações foram executadas;
- quais critérios de aceite foram atendidos;
- qualquer pendência ou bloqueio;
- o status atualizado da spec.

Antes de terminar, confira:

- [ ] o PRD correto foi usado;
- [ ] a especificação foi selecionada pelo status e pela ordem;
- [ ] as dependências foram respeitadas;
- [ ] o plano cobre comportamento, erros, validações e aceite;
- [ ] nenhuma funcionalidade fora do recorte foi incluída;
- [ ] a tecnologia existente foi preservada;
- [ ] nenhuma alteração foi feita sem `implementa` ou aprovação explícita.
