---
name: prd-generator
description: Gera PRD com especificações funcionais em docs/prd/. Use somente com /prd-generator.
disable-model-invocation: true
---

# Gerador de PRD

## Ativação e limites

Use somente com `/prd-generator`.

**Único arquivo alterável:** `docs/prd/NN-prd-<slug>.md`.

Durante a entrevista: leia código e docs sem alterá-los; comandos só de leitura. Não instale deps, migre, formate nem altere código. A pasta `docs/prd/` é criada ao gravar o arquivo, se necessário.

Se o pedido exigir alteração fora do PRD, explique o limite e gere só o documento.

Não grave o PRD até o usuário confirmar entendimento compartilhado.

## Objetivo

Transformar ideia ou funcionalidade em PRD com **comportamento, regras e critérios de aceite** — não implementação técnica.

Modos:

- **Inicial**: produto novo.
- **Funcionalidade**: recorte em projeto existente.

Detecte o modo pelo ambiente. Use funcionalidade quando já houver código relevante. Informe o modo em uma frase; só pergunte se dois recortes forem decisões de produto igualmente plausíveis.

## Etapa 0 — Levantar fatos

Encontrar fatos é o seu trabalho, nunca do usuário.

1. Leia `README.md`, instruções do projeto, `docs/` e configs.
2. Localize código, dados, auth e integrações no recorte.
3. Liste nomes em `docs/prd/` (sem abrir conteúdo, salvo decisão de produto já registrada).

Registre o que o ambiente já responde — stack, telas, entidades, permissões, o que permanece. Não pergunte isso.

**Conclua quando:** modo detectado e fatos do recorte registrados, sem ter perguntado o que o repositório já responde.

## Etapa 1 — Percorrer a árvore de design

Antes da primeira rodada, leia [`../references/entrevista.md`](../references/entrevista.md) para a lista de tópicos.

Entreviste até alcançar um entendimento compartilhado. Mapeie o recorte como **árvore de design**: cada decisão ramifica nas que dependem dela.

Trabalhe a árvore em **rodadas**. A **fronteira** é cada decisão cujos pré-requisitos já foram definidos — o que dá para perguntar agora sem adivinhar resposta ainda não ouvida. Pergunte toda a fronteira numa única rodada: numere cada pergunta e dê a sua resposta recomendada. Aguarde as respostas antes da próxima rodada.

Cada rodada respondida reformula a árvore: decisões definidas empurram a fronteira para fora e desbloqueiam o que dependia delas. Recompute a fronteira e faça a próxima rodada. Uma pergunta cuja resposta dependa de outra ainda aberta nesta rodada pertence a uma rodada posterior, não a esta.

Decisões já dadas no briefing ou em rodadas anteriores entram na árvore como definidas — não re-pergunte. Resposta vaga: refine o mesmo ponto na próxima rodada, ainda naquela ramificação.

Quando uma pergunta da fronteira precisar de um fato do ambiente, envie um subagente para encontrá-lo; não peça ao usuário o que você mesmo pode procurar. Não trave a rodada: exploração em andamento é pré-requisito indefinido — só as perguntas abaixo dela esperam o relatório; pergunte o restante da fronteira agora.

As decisões pertencem ao usuário: apresente cada uma e aguarde. Recomendação não é fechamento.

Formato da rodada:

```markdown
**1. [título]:** [corpo; alternativas concretas se houver]

**Recomendação:** [resposta] — [motivo]

---

**2. [título]:** …
```

A árvore cobre os tópicos de `entrevista.md` à medida que a fronteira avançar, mais:

- stack em alto nível só se o modo for inicial e ainda indefinida (em funcionalidade, a stack já é fato)
- fases por dependência e o recorte de cada spec: objetivo, comportamento, aceite verificável (Dado/Quando/Então), dependências

Cada spec cabe em uma entrega coerente. Sem fase "Futuro" — o que não entra agora é fora de escopo.

A sessão de entrevista termina quando a fronteira estiver vazia: cada ramificação visitada, nada presumido em silêncio. Resuma o entendimento e pergunte se está compartilhado. Não avance enquanto a confirmação não vier.

**Conclua quando:** fronteira vazia e o usuário confirmou o entendimento compartilhado.

## Etapa 2 — Gerar o PRD

Leia [`references/prd-template.md`](references/prd-template.md) e preencha todas as seções só com o que a árvore fechou.

Nome: `docs/prd/NN-prd-<slug>.md` — `NN` sequencial de dois dígitos; use a lista de nomes da etapa 0 para o próximo número.

Status do PRD e de todas as specs: `Aguardando implementação`. Campo N/A: escreva `Não se aplica` com motivo breve. Toda spec nova começa nesse status.

**Conclua quando:** o arquivo existir, com seções preenchidas, specs autossuficientes na ordem combinada, e só comportamento observável.

## Entrega

Informe só o caminho e:

> PRD criado em `docs/prd/<arquivo>.md`. Próximo passo: outro chat e `/plan-spec`.

Não cole o PRD no chat.
