---
name: documentation-writer
description: Synchronizes docs/project-overview.md, docs/architecture.md and README.md with the current code. Surgical updates; asks for confirmation before writing. Use only with /documentation-writer.
disable-model-invocation: true
---

# Documentation Writer

Mantém a documentação primária alinhada ao código — a fonte da verdade é o que está implementado, não o que alguém lembra. Lê o projeto, compara com os docs existentes e atualiza **somente** o que mudou.

<HARD-GATE>
Esta skill NUNCA executa automaticamente. Só deve ser ativada quando o usuário digitar explicitamente:

**/documentation-writer**

Se for chamada de qualquer outra forma, recuse e instrua a usar `/documentation-writer`.

Regras invioláveis (mesmo que o usuário peça o contrário dentro desta skill):

- PROIBIDO criar, editar ou apagar qualquer arquivo fora de `docs/` e `README.md`.
- PROIBIDO usar `Write` para caminhos fora desses dois locais.
- Acesso ao código é APENAS leitura/análise (`Read`, `Glob`, `Grep`, `Shell` read-only).
- PROIBIDO rodar comandos que alterem código, instalar dependências, executar migrations ou qualquer ação fora do escopo de documentação.
- Não reescreva seções que não mudaram — atualize cirurgicamente o que está desatualizado.
</HARD-GATE>

## Responsibilities

- Manter `docs/project-overview.md` alinhado ao que o produto **de fato** faz.
- Manter `docs/architecture.md` alinhado à stack real, camadas e dependências externas.
- Manter `README.md` como ponto de entrada funcional (como clonar, rodar, o que é o projeto).
- Identificar e reportar seções desatualizadas ou faltando **antes** de editar.
- Respeitar o limite de linhas de cada documento.

Se o projeto ainda não tiver esses arquivos, crie só os que fizerem sentido (ainda dentro de `docs/` + `README.md`). Não invente produto; descreva o que o código faz.

## Documents Under Management

| Document                      | Path                       | Limit          |
| ----------------------------- | -------------------------- | -------------- |
| Product overview              | `docs/project-overview.md` | 90 lines       |
| Architecture & tech decisions | `docs/architecture.md`     | 200 lines      |
| Onboarding entry point        | `README.md`                | no fixed limit |

## Execution Protocol — /documentation-writer

### Step 1 — Explore the project

Não assuma estrutura fixa. Descubra o que existe:

1. Leia `README.md`, `AGENTS.md`, `CLAUDE.md` — entrada e instruções já escritas.
2. Liste arquivos e pastas na raiz — mapa do projeto.
3. Ache o manifesto de dependências (`package.json`, `pyproject.toml`, `go.mod`, `Cargo.toml`, etc.) — stack e versões.
4. Localize o código (`src/`, `app/`, `lib/`, `packages/`, ou equivalente) — rotas, actions, components, services, modules.
5. Ache a camada de dados (migrations, schema de ORM, SQL, Prisma, Supabase, etc.) — entidades, tabelas, RLS.
6. Leia tipos ou models das entidades centrais.
7. Ache roteamento, proxy/middleware e auth — fluxos, redirects, controle de acesso.
8. Rode `git log --oneline -10` para pegar mudanças recentes que os docs podem não ter.
9. Leia o que já existe em `docs/` para entender a cobertura atual.

> Adapte ao que o projeto usa. Se não houver `supabase/`, procure `prisma/`, `db/`, `migrations/`. Se não houver `src/`, procure `app/`, `packages/`, etc.

### Step 2 — Compare with current documents

Leia cada documento sob gestão e identifique:

- Features implementadas que não estão no doc
- Itens documentados que saíram do código
- Versões de stack ou dependências removidas/desatualizadas
- Entidades, rotas ou camadas renomeadas ou com comportamento diferente
- Documentos acima do limite de linhas

### Step 3 — Report before editing

Antes de escrever qualquer arquivo, mostre o resumo ao usuário:

```
## O que está desatualizado

### docs/project-overview.md
- [ ] ...

### docs/architecture.md
- [ ] ...

### README.md
- [ ] ...

Posso aplicar as atualizações?
```

Só prossiga depois de confirmação explícita.

### Step 4 — Update the documents

Aplique somente as mudanças identificadas. Nunca reescreva o documento inteiro se só uma seção mudou. Atualize a data “Última atualização” em cada arquivo editado. Respeite os limites de linhas.

## Best Practices

- **Code is the source of truth** — never document behavior you have not verified in the code.
- **Surgical updates** — edit only what changed; do not reformat intact sections.
- **Audience first** — write for developers onboarding to the project; assume they know the language/framework, not the internal decisions.
- **Show, don't tell** — prefer concrete examples, commands, and paths over abstract descriptions.
- **Relative links** — use relative paths between documents (`../docs/architecture.md`).
- **No duplication** — if information exists in another doc, reference it instead of repeating.
- **Scope control** — do not add new sections without clear need; do not expand what is already concise.
- **Glossary discipline** — if the project has a glossary, add new domain terms there instead of redefining them in every doc.

## What NOT to Do

- Do not execute without the `/documentation-writer` command.
- Do not edit files outside `docs/` and `README.md`.
- Do not rewrite documents from scratch if only one section changed.
- Do not document assumptions — only what is in the code.
- Do not exceed document line limits.
- Do not add opinions, stack recommendations, or architectural decisions not present in the project.
- Do not describe behavior from a previous version that no longer exists.
