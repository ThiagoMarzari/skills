---
name: prd-generator
description: Gera PRD com especificações funcionais em docs/prd/. Use somente com /prd-generator.
disable-model-invocation: true
---

# Gerador de PRD

## Ativação e limites

Use somente com `/prd-generator`.

**Único arquivo alterável:** `docs/prd/NN-prd-<slug>.md`.

Durante preparação: leia código e docs sem alterá-los; comandos só de leitura. Não instale deps, migre, formate nem altere código. A pasta `docs/prd/` é criada ao gravar o arquivo, se necessário.

Se o pedido exigir alteração fora do PRD, explique o limite e gere só o documento.

## Objetivo

Transformar ideia ou funcionalidade em PRD com **comportamento, regras e critérios de aceite** — não implementação técnica.

Modos:

- **Inicial**: produto novo.
- **Funcionalidade**: recorte em projeto existente.

Use funcionalidade quando já houver código relevante.

## Etapa 0 — Contexto

1. Leia `README.md`, instruções do projeto, `docs/`, configs.
2. Localize código, dados, auth e integrações.
3. Liste nomes em `docs/prd/` (sem abrir conteúdo, salvo decisão de produto).

Informe modo detectado em uma frase e peça confirmação.

**Conclua quando:** modo, contexto e recorte estiverem claros.

## Etapa 1 — Fechar recorte

Uma pergunta por mensagem (ou bloco pequeno relacionado). Com alternativas:

```markdown
**Pergunta:** [decisão]

- **A:** …
- **B:** …

**Recomendação:** [opção] — [motivo].
```

Cubra: problema, público, ações observáveis, essencial vs. depois, regras, fluxos, aceite, fora do escopo.

Não feche decisões importantes sem o usuário.

**Conclua quando:** escopo, regras, fluxos e aceite estiverem definidos ou marcados como pendentes assumidos.

## Etapa 2 — Tecnologia em alto nível

- **Funcionalidade**: detecte no repositório; registre só o que o recorte reutiliza ou acrescenta. Sem arquitetura interna.
- **Inicial**: se indefinida, sugira opção proporcional e recomende com justificativa curta.

**Conclua quando:** stack necessária estiver confirmada sem virar spec de implementação.

## Etapa 3 — Fases e especificações

Divida em fases por dependência. Cada spec:

- objetivo e intenção claros;
- comportamento, entradas, saídas, estados, validações, erros;
- critérios de aceite verificáveis (Dado/Quando/Então);
- dependências e fora do escopo;
- cabe em uma entrega coerente.

Toda spec nova: `Status: Aguardando implementação`. Sem fase "Futuro" — use Fora do escopo.

**Conclua quando:** specs ordenadas, implementáveis e com dependências explícitas.

## Etapa 4 — Revisar

Confira: problema justifica recorte? regras e bordas cobertas? conflitos com existente? cada spec compreensível isolada?

Volte à etapa 1 se resposta mudar comportamento.

**Conclua quando:** sem lacuna bloqueante.

## Etapa 5 — Gerar

Leia [`references/prd-template.md`](references/prd-template.md) e preencha todas as seções.

Nome: `docs/prd/NN-prd-<slug>.md` — `NN` sequencial de dois dígitos; liste só nomes em `docs/prd/` para achar o próximo número.

Status do PRD e de todas as specs: `Aguardando implementação`. Campo N/A: escreva `Não se aplica` com motivo breve.

## Entrega

Informe só o caminho e:

> PRD criado em `docs/prd/<arquivo>.md`. Próximo passo: outro chat e `/plan-spec`.

Não cole o PRD no chat.

## Validação

- [ ] Arquivo em `docs/prd/` com prefixo `NN-prd-`
- [ ] Comportamento, não implementação
- [ ] Specs autossuficientes com aceite verificável
- [ ] Sem requisitos não confirmados
