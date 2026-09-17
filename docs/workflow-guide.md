# Guia de workflow

Conjunto de skills que levam uma mudança da ideia vaga até o código publicado. Uma skill por fase. Rode só as que a mudança precisa, na ordem que couber.

O estado vive em arquivos no repositório, não no chat. A conversa pode acabar; um colega puxa a branch e o trabalho continua.

```
ideia → /questiona → /prd-generator → /plan-spec → implementação → /code-review → /documentation-writer → /fecha-a-task
```

Repo destino ainda sem `docs/agents/`: rode `/setup-skills` uma vez, antes de `/code-review`, `/rework-commits` e `/fecha-a-task`.

Próximo passo incerto: `/ask-marzari`. Bug ou correção pequena: pule o PRD e vá à implementação. Tarefa pronta para o last mile: `/fecha-a-task`.

O catálogo curto está no [`README.md`](../README.md). Este arquivo é o walkthrough: o que cada skill faz, quais arquivos carregam o trabalho, quem altera o quê, e um exemplo do início ao fim.

---

## As skills

| Skill | O que faz |
|---|---|
| `setup-skills` | Grava tracker, convenções de commit e bases sandbox/release em `docs/agents/` |
| `ask-marzari` | Indica **uma** skill ou prompt agora; não executa o que recomenda |
| `questiona` | Fecha escopo, comportamento e trade-offs; não grava arquivo |
| `prd-generator` | Entrevista e grava PRD com specs em `docs/prd/` |
| `plan-spec` | Converte spec pendente em plano técnico; com `implementa`, constrói |
| `code-review` | Revisa o diff desde um ponto: qualidade e atendimento à spec |
| `documentation-writer` | Alinha README e docs de produto ao código |
| `rework-commits` | Reorganiza a branch em commits pequenos, sem mudar o diff final |
| `fecha-a-task` | Revisa, commita, faz push e abre duas MRs GitLab (sandbox e release) |
| `writing-for-agents` | Escreve ou revisa instruções para agentes |
| `handoff` | Compacta a conversa num arquivo no temp do OS para outro agente continuar |

Skills com `disable-model-invocation` só rodam com o comando (`/nome`). `writing-for-agents` também pode ser alcançada ao editar docs agent-facing.

Prompts em `.prompts/` não são skills. Cole `.prompts/prd-generator.md` junto com `/prd-generator` para fechar ramos da entrevista de antemão. Durante implementação, cole `.prompts/tdd-com-agentes.md` ou `.prompts/testes-automatizados.md` se a tarefa pedir.

---

## Como funciona

### Os arquivos que carregam o trabalho

Tudo o que o fluxo precisa saber está no disco. Chat acaba, sessão limpa, outro agente abre o repo — o conhecimento continua lá.

**Configuração das skills, em `docs/agents/`.** `/setup-skills` grava isto uma vez no **repo destino** (não neste kit):

- `issue-tracker.md` — onde issues vivem e como aparecem em commits (`code-review` lê)
- `commit-conventions.md` — formato de mensagem (`rework-commits` e `fecha-a-task` leem)
- `delivery.md` — bases sandbox/release deste repo (`fecha-a-task` lê); só se a skill `fecha-a-task` estiver no destino

Sem esses arquivos, as skills de entrega não inventam tracker, formato de commit nem nome de branch.

**O PRD, em `docs/prd/`.** Um arquivo `NN-prd-<slug>.md` é o contrato da funcionalidade: comportamento, regras e critérios de aceite, não o plano técnico. `/prd-generator` cria. `/plan-spec` lê as specs com status `Aguardando implementação`, planeja (e, com `implementa`, constrói) e marca `Implementada` depois de validar. `/code-review` usa o PRD como fonte da frente Especificação, se o ponto de comparação e os commits não apontarem outra.

**Instruções do projeto, `AGENTS.md` e `CLAUDE.md`.** Descrevem o repo para qualquer agente. Neste kit, apontam para skills, prompts e exemplos. No destino, `/setup-skills` acrescenta um bloco `## Agent skills` com o que configurou. Não misture o domínio de `docs/exemplos/` com a identidade deste kit — aqueles arquivos são modelo, não produto.

### Quem cria, lê e altera

Os arquivos continuam confiáveis porque a posse é fixa.

| Arquivo | Cria | Lê | Altera |
|---|---|---|---|
| `docs/agents/*` | `setup-skills` | `code-review`, `rework-commits`, `fecha-a-task` | `setup-skills` de novo, se o usuário reconfigurar |
| `docs/prd/*.md` | `prd-generator` | `plan-spec`, `code-review` | `plan-spec` só o status das specs (e do PRD, se todas implementadas) |
| README e docs de produto no destino | humanos, ou `documentation-writer` | todas | `documentation-writer` só os três arquivos que administra |
| Código | implementação / `plan-spec implementa` | todas | implementação / `plan-spec implementa` |
| Histórico git | humanos / `fecha-a-task` | `code-review`, `rework-commits`, `fecha-a-task` | `rework-commits` (reescreve); `fecha-a-task` (commit, push, MRs) |
| Handoff no temp do OS | `handoff` | o próximo agente | ninguém no workspace |

`questiona` e `ask-marzari` não gravam. `writing-for-agents` só altera o documento agent-facing que o usuário pediu.

### O fio que amarra as fases

O critério de aceite. Quando `/prd-generator` fecha uma spec, cada requisito vira comportamento observável (Dado/Quando/Então). `/plan-spec` amarra cada passo do plano a esse aceite. A implementação valida contra ele. `/code-review` compara o diff com a spec, numa frente separada da qualidade. Nada importante fica sem medida, e nada é marcado `Implementada` sem ter sido comprovado no recorte.

---

## Um exemplo, da ideia ao shipped

Ideia: um app em que a pessoa entra e guarda a própria lista de tarefas. Produto novo no repo destino. Em cada fase o fluxo faz poucas perguntas; a resposta muda o que vem depois.

### Etapa 1 — configurar o destino

Você copia as skills para `.agents/skills/<nome>/` (Claude Code: `.claude/skills/<nome>/`) e roda `/setup-skills`. A skill explora remote, branches e convenções de commit, propõe tracker / formato de mensagem / bases sandbox e release, e só grava depois da confirmação.

Isso precisa existir antes do last mile. Sem `docs/agents/delivery.md`, `/fecha-a-task` para e pede o setup de novo.

### Etapa 2 — fechar o escopo

Você roda `/questiona`. Ela lê o que o repo já responde e pergunta só o que trava a decisão: para quem é, o que entra agora, o que fica de fora, trade-offs. Uma decisão por mensagem, salvo bloco factual do mesmo ramo.

Não grava arquivo. No fechamento, recomenda `/prd-generator` (recorte grande) ou implementação direta (tarefa pequena e clara). Você confirma: **"Fechamos ou ainda existe decisão em aberto?"**

Para a lista de tarefas, o recorte é grande o bastante para um PRD.

### Etapa 3 — gravar o contrato

Você abre **outro chat** e roda `/prd-generator`. Pode colar `.prompts/prd-generator.md` preenchido para gastar menos rodadas.

A skill detecta modo **inicial** (produto novo) ou **funcionalidade** (já há código no recorte). Levanta fatos sozinha. Entrevista em rodadas: cada rodada é a fronteira de decisões cujos pré-requisitos já fecharam. Não grava o PRD até você confirmar o entendimento compartilhado.

O arquivo nasce em `docs/prd/01-prd-lista-de-tarefas.md`, com specs autossuficientes na ordem combinada e status `Aguardando implementação`. O próximo passo que a skill recomenda é outro chat e `/plan-spec`.

### Etapa 4 — planejar (e, se pedido, construir)

Você roda `/plan-spec`. Sem `todas` nem `implementa`, ela pergunta: uma spec ou todas as pendentes.

- `/plan-spec` — plano da próxima pendente; código intacto até você aprovar
- `/plan-spec todas` — todas as pendentes, na ordem do PRD
- `/plan-spec implementa` — implementa a próxima
- `/plan-spec todas implementa` — implementa todas

O plano cita caminhos reais do código, sequência, dados, permissões, testes amarrados ao aceite, fora de escopo. Reusa a stack do projeto.

Com `implementa` (ou aprovação explícita nesta conversa), constrói só o recorte, valida o aceite e marca a spec `Implementada`. Sem isso, só o plano existe.

Para a lista de tarefas, a primeira spec é cadastro e sessão; a segunda, CRUD da lista. Você aprova o plano da primeira e pede implementação.

Durante o código, se quiser o ciclo red-green-refactor, cole `.prompts/tdd-com-agentes.md`. Não é skill; é prompt da conversa.

### Etapa 5 — revisar o diff

Você roda `/code-review` e informa o ponto (`main`, `develop`, `HEAD~3`, tag). Sem ponto, a skill pergunta.

Duas frentes independentes, cada uma com teto de 400 palavras:

1. **Qualidade** — problemas estruturais no diff
2. **Especificação** — o que o PRD (ou o pedido) pedia vs. o que entrou

A skill lê; não altera código. Você decide o que corrigir.

### Etapa 6 — alinhar docs (se o código mudou o que o humano lê)

Você roda `/documentation-writer`. Código é a fonte da verdade. Ela compara README e, no destino, `docs/project-overview.md` e `docs/architecture.md`, lista só o desatualizado e espera confirmação antes de gravar. Não altera código.

Numa lista de tarefas recém-nascida, isso costuma ser o README de como rodar e o overview do recorte. Se nada divergiu, ela informa e para.

### Etapa 7 — (opcional) limpar o histórico

Branch com commits confusos: `/rework-commits`. Reescreve para unidades lógicas, **sem** mudar o diff `base...HEAD`. Para se houver working tree suja, se estiver na branch principal, ou se a branch já foi publicada — nesse caso avisa e não faz force push.

### Etapa 8 — fechar a task

Você roda `/fecha-a-task`. Last mile no GitLab (`glab`, não `gh`): revisa o diff, commita no formato de `commit-conventions.md`, faz push da branch de feature e abre **duas** MRs da mesma source — uma para a base sandbox e outra para a base release lidas de `delivery.md`. Não mergeia. Commit e corpo das MRs sem marca d'água de ferramenta.

Se `delivery.md` não existir ou tiver placeholder, para e pede `/setup-skills`.

Aqui o loop fecha: a spec está `Implementada`, o diff foi revisado, as MRs existem. Limpe a sessão e comece a próxima spec no fresco — o PRD no disco diz exatamente onde parou.

---

## Atalhos: o mesmo fluxo sem passar por todas as fases

Não precisa das onze. Uma correção pontual pode ser implementação → `/code-review` → `/fecha-a-task`. Um bug não pede `/questiona`. Docs defasadas: só `/documentation-writer`.

**Repo destino já existente (brownfield).** `/setup-skills` ainda é o primeiro passo se `docs/agents/` não existir. `/questiona` e `/prd-generator` leem o código e tratam o recorte como **funcionalidade**, não produto novo. `/plan-spec` planeja contra o que já está no disco.

**Tarefa pequena e já fechada.** Pule `/questiona` e `/prd-generator`. Implemente. Feche com `/code-review` e `/fecha-a-task`.

**Trocar de agente, pasta ou harness.** `/handoff` grava no temp do OS, com skills sugeridas para a próxima sessão. Não é resumo da mesma conversa: use só se o trabalho precisa viajar. Mesma task na mesma sessão → continue, ou chat novo com `@` no artefato que já está no disco.

**Instruções para agentes.** `/writing-for-agents` (ou o agente alcança sozinho ao editar skill, `AGENTS.md`, rule, spec). Detalhe de empacotamento de skill: `SKILL-MECHANICS.md` na pasta da skill `writing-for-agents`.

---

## O que o fluxo não faz

- Não infere skill user-invoked a partir de um pedido parecido. Sem o comando, a skill não começa. Incerteza → `/ask-marzari`.
- Não inventa stack, rotas, banco ou auth **neste kit**. No destino, reusa o que o projeto já tem.
- `questiona` e a entrevista de `/prd-generator` não gravam até o entendimento estar compartilhado. Recomendação não é fechamento.
- `/plan-spec` sem `implementa` não mexe em código.
- `/code-review` não edita o diff. Lê e relata.
- `/fecha-a-task` não mergeia e não cai para GitHub. Sem `delivery.md`, para.
- Nenhuma skill reescreve o arquivo de outra. Posse fixa é o que impede o disco virar lama.

---

## Perguntas comuns

**Preciso rodar todas?** Não. Só as que a mudança precisa. `/ask-marzari` escolhe uma rota.

**E se não houver PRD?** `/plan-spec` informa que `/prd-generator` vem antes e não cria PRD. Tarefa pequena: implemente sem PRD.

**Por que outro chat depois do PRD?** Conversa longa custa mais e deriva. O contrato já está em `docs/prd/`. Sessão nova lê o arquivo e planeja limpo.

**Onde copiar no destino?** Cada skill isolada, sem o bucket `engineering/` ou `productivity/`. Leve as referências que o `SKILL.md` aponta. `questiona` e `prd-generator` também precisam de `references/entrevista.md` no mesmo nível relativo. Depois, `/setup-skills` uma vez. Não edite o `SKILL.md` no projeto.

**Posso pular `/questiona` se o briefing já veio completo?** Sim. Cole o briefing com `/prd-generator`; a skill não re-pergunta o que já está respondido.

**E testes?** Não há skill `/test`. Há prompts: `.prompts/testes-automatizados.md` e `.prompts/tdd-com-agentes.md`. `/plan-spec` já exige verificação por critério de aceite no plano.

---

## Como começar

1. Copie as skills que o destino vai usar (veja [`README.md`](../README.md) — Onde copiar no destino).
2. No destino, `/setup-skills`.
3. Produto ou recorte novo: `/questiona` → `/prd-generator` → `/plan-spec`.
4. Código pronto: `/code-review` → se fizer sentido, `/documentation-writer` e `/rework-commits` → `/fecha-a-task`.

Bug ou mudança mínima: implementação → `/code-review` → `/fecha-a-task`.
