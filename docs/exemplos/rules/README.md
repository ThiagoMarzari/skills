# Rules de exemplo (stack específica)

Estas `.mdc` **não** são carregadas neste kit. São modelos para copiar para um **app** com aquela stack.

| Arquivo | Quando copiar |
|---------|----------------|
| `page-rules.mdc` | App Next.js (App Router) — estrutura `page` / `_components` / `_actions` / `_data-access` |
| `nextjs-app.mdc` | App Next.js — UI, formulários, colocação de componentes (arquivo largo; enxugue no destino) |

No projeto destino:

1. Copie para `.cursor/rules/` (Cursor) ou adapte para `.claude/rules/` (Claude Code).
2. Ligue `alwaysApply: true` **ou** `globs` (ex.: `src/app/**/*.tsx`).
3. A rule geral `projetos.mdc` (stack-agnóstica) vai à parte; não misture Next e Nest no mesmo arquivo.
