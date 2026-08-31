---
name: prd-generator
description: Gera um PRD com especificações funcionais completas em docs/prd/ para um produto novo ou uma funcionalidade de um projeto existente. Use somente com /prd-generator.
disable-model-invocation: true
---

# Gerador de PRD e especificações funcionais

## Objetivo

Transforme uma ideia ou pedido de funcionalidade em um PRD claro, crítico e pronto para orientar o planejamento e a implementação. O documento deve definir **comportamento, intenção, regras e critérios de aceite**; não deve definir a implementação técnica.

Há dois modos:

- **Inicial**: planeja um produto novo.
- **Funcionalidade**: planeja uma funcionalidade dentro de um projeto existente.

Use o modo funcionalidade quando já houver código relevante, mesmo que a funcionalidade seja grande. O recorte atual pode ter suas próprias fases e especificações.

## Ativação e limite de escrita

Use esta skill somente quando o usuário digitar `/prd-generator`.

O único arquivo que pode ser criado ou alterado é `docs/prd/NN-prd-<slug>.md`.

Durante a preparação:

- leia o código, a documentação e o histórico, sem alterá-los;
- use comandos somente para leitura, como listar arquivos e consultar o histórico;
- não instale dependências, execute migrações, formate o projeto ou altere código;
- não crie pastas manualmente: ao gravar o arquivo, a pasta `docs/prd/` deve ser criada pelo próprio recurso de escrita, quando necessário.

Se o pedido exigir qualquer alteração fora desse arquivo, explique o limite e gere apenas o PRD.

## Princípios

- Seja direto, crítico e útil.
- Diferencie sempre **decisão confirmada**, **suposição** e **ponto pendente**.
- Pergunte quando uma resposta mudar o escopo ou o comportamento; não invente requisitos.
- Quando oferecer alternativas, recomende uma delas e explique o motivo em uma frase curta, com base no contexto do projeto e no objetivo do recorte.
- Se o escopo estiver grande ou confuso, proponha um recorte menor antes de escrever.
- Use linguagem simples, sem perder precisão.
- Em uma funcionalidade existente, respeite as entidades, fluxos e limitações já encontradas no projeto.
- Não transforme automaticamente um produto em SaaS nem acrescente pagamento, IA, notificações ou painel avançado sem necessidade.

## Etapa 0 — Identificar o contexto

Antes de fazer perguntas, examine o contexto necessário:

1. Leia `README.md`, as instruções do projeto, a documentação em `docs/` e os arquivos de configuração relevantes.
2. Liste as pastas principais e localize o código, a camada de dados, autenticação e integrações, quando existirem.
3. Consulte os commits recentes.
4. Verifique se há PRDs em `docs/prd/`. Para essa verificação, liste somente os nomes dos arquivos; leia conteúdo apenas se for necessário entender uma decisão do produto.

Escolha provisoriamente o modo:

- **Inicial** se o projeto estiver vazio ou ainda não houver produto relevante.
- **Funcionalidade** se já houver código e a solicitação acrescentar algo ao produto.

Informe o modo detectado em uma frase e peça confirmação. O usuário pode escolher o outro modo.

**Conclua quando:** o modo escolhido, o contexto existente e o recorte do pedido estiverem identificados.

## Mensagem inicial

Se o usuário ainda não descreveu o produto ou a funcionalidade, pergunte:

> Vamos montar o PRD. Qual produto ou funcionalidade você quer criar?

Se já descreveu, comece pela etapa 1.

## Etapa 1 — Fechar o recorte

Colete as decisões abaixo. Faça uma pergunta por mensagem ou um pequeno bloco de perguntas relacionadas. Depois de cada resposta, registre mentalmente o que está confirmado e o que continua pendente.

Para cada pergunta com alternativas, use este formato:

```markdown
**Pergunta:** [decisão que precisa ser tomada]

- **A:** [alternativa]
- **B:** [alternativa]
- **C:** [alternativa, se necessário]

**Recomendação:** [alternativa escolhida] — [motivo em uma frase curta].
```

A recomendação orienta, mas não substitui a decisão do usuário. Se houver uma opção claramente melhor pelo contexto, explique o motivo sem apresentar alternativas artificiais. Se a escolha depender de uma informação ainda desconhecida, diga qual informação falta.

1. **Problema**: qual dificuldade existe, para quem e como é resolvida hoje?
2. **Público**: quem usa ou é afetado? Transforme “qualquer pessoa” em um grupo específico.
3. **Ações**: o que a pessoa consegue fazer? Converta verbos vagos em ações observáveis, como criar, editar, listar, buscar, consultar, cancelar ou excluir.
4. **Funcionalidades**: separe o que é essencial agora, desejável depois e fora do recorte.
5. **Regras**: quais condições permitem, impedem ou alteram uma ação?
6. **Fluxos**: qual é o caminho principal e quais são os caminhos de erro?
7. **Aceite**: que comportamento pode ser verificado sem interpretação?
8. **Fora do escopo**: o que ficará explicitamente de fora desta entrega?

Quando o usuário não souber, apresente opções baseadas no contexto já lido, recomende uma delas e peça uma escolha. A justificativa deve ser curta e concreta, por exemplo: “Recomendo A porque atende o fluxo essencial com menor escopo.” Não feche decisões importantes por conta própria.

**Conclua quando:** problema, público, ações, escopo, regras, fluxos, critérios de aceite e itens fora do escopo estiverem definidos ou marcados como pendentes assumidos pelo usuário.

## Etapa 2 — Definir a tecnologia em alto nível

### Modo funcionalidade

Detecte a tecnologia usada no projeto; não pergunte algo que o repositório já responde. Registre somente o que a nova funcionalidade realmente precisa reutilizar ou acrescentar. Não descreva arquitetura interna, nomes de arquivos, pastas, bibliotecas ou comandos.

### Modo inicial

Se a tecnologia não estiver definida, pergunte se há preferência. Se não houver, sugira uma opção proporcional ao produto e recomende-a com uma justificativa curta:

- página simples: HTML, CSS e JavaScript, ou React com Vite e TypeScript;
- aplicação web com login: Next.js, TypeScript e a solução de dados já escolhida;
- aplicativo mobile: Expo, React Native e TypeScript;
- API separada: a combinação de frontend, backend e banco que atenda ao recorte sem complexidade desnecessária.

Inclua a tecnologia no PRD em alto nível, junto com uma justificativa curta. Não transforme a escolha em especificação de implementação.

**Conclua quando:** a tecnologia necessária estiver confirmada ou detectada, sem decisões técnicas detalhadas que pertençam ao plano de implementação.

## Etapa 3 — Organizar fases e especificações

Divida o recorte em fases na ordem de dependência: base, acesso, funcionalidade principal, complementos e validações, conforme fizer sentido. Cada fase deve conter especificações que possam ser implementadas em uma entrega coerente.

Não crie uma fase “Futuro”. Tudo que não entrar nesta entrega pertence a “Fora do escopo”.

Uma especificação é adequada quando:

- tem um objetivo e uma intenção claros;
- descreve comportamento principal, entradas, saídas, estados, validações e erros;
- trata limites, conflitos e permissões aplicáveis;
- tem critérios de aceite verificáveis, preferencialmente no formato Dado/Quando/Então;
- informa dependências e o que fica fora dela;
- cabe em uma entrega coerente. Se misturar, por exemplo, cadastro, relatório e exportação, divida-a.

Toda especificação nova deve começar com:

`Status: Aguardando implementação`

Não marque especificações como implementadas. O agente que implementar atualizará o status.

**Conclua quando:** todas as funcionalidades essenciais estiverem distribuídas em especificações ordenadas, com dependências explícitas e granularidade implementável.

## Etapa 4 — Revisar antes de escrever

Faça uma revisão crítica do material:

- o problema justifica o recorte?
- o público está definido?
- cada ação tem comportamento e resultado?
- regras, erros, limites e permissões foram cobertos?
- há requisitos contraditórios ou dependências escondidas?
- existe funcionalidade desejável que deveria sair do recorte?
- no modo funcionalidade, há conflito ou duplicação com o que já existe?
- cada especificação é compreensível isoladamente?

Se uma resposta alterar o comportamento, volte à etapa 1 e confirme-a com o usuário. Não escreva o PRD com lacunas que impediriam sua implementação.

**Conclua quando:** não houver decisão bloqueante pendente e o recorte estiver coerente, limitado e implementável.

## Etapa 5 — Gerar o PRD

Leia [`references/prd-template.md`](references/prd-template.md) antes de escrever e preencha todas as seções.

Use um nome em kebab-case com prefixo numérico sequencial:

- primeiro PRD: `docs/prd/00-prd-<slug>.md`;
- PRD seguinte: `docs/prd/01-prd-<slug>.md`, depois `02`, `03` e assim por diante;
- o número deve ter sempre dois dígitos e ser o próximo número disponível entre os arquivos de `docs/prd/`;
- no modo funcionalidade, mantenha o mesmo padrão: `docs/prd/00-prd-<slug-da-funcionalidade>.md`.

Antes de escolher o nome, liste somente os nomes dos arquivos existentes em `docs/prd/`, extraia os prefixos numéricos e use o próximo número disponível. Não abra os PRDs nem leia seu conteúdo para fazer essa conta. Não reutilize um número já usado e não use a data como substituto do prefixo.

Preencha o status do PRD e de todas as especificações como `Aguardando implementação`. Em cada campo que não se aplicar, escreva `Não se aplica` e explique brevemente o motivo.

As especificações devem conter, no mínimo:

- status e fase;
- objetivo e intenção;
- contexto e atores;
- comportamento;
- entradas, saídas e dados conceituais;
- estados e transições, quando houver;
- regras e validações;
- fluxo passo a passo;
- casos de borda e erros;
- impacto no existente;
- critérios de aceite;
- definição de pronto;
- dependências;
- fora do escopo da especificação.

## Validação e entrega

Antes de informar que terminou, confira:

- [ ] o arquivo está em `docs/prd/`;
- [ ] o nome começa com um prefixo numérico sequencial no formato `NN-prd-`;
- [ ] todas as seções do template foram preenchidas;
- [ ] o documento define comportamento, não implementação;
- [ ] cada especificação é autossuficiente e tem status correto;
- [ ] critérios de aceite são verificáveis;
- [ ] dependências e fora do escopo estão explícitos;
- [ ] não foram adicionados requisitos sem confirmação;
- [ ] o PRD não descreve funcionalidades excluídas do recorte.

Informe apenas o caminho do PRD criado e o próximo passo:

> PRD criado em `docs/prd/<arquivo>.md`. Próximo passo: abra outro chat e use `/plan-spec`.

Não cole o PRD inteiro no chat.
