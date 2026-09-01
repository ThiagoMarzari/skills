# Rules de exemplo (stack específica)

Estas `.mdc` **não** são carregadas neste kit. Copie para um **app** com a stack correspondente.

| Arquivo | Quando copiar |
|---------|----------------|
| `page-rules.mdc` | Next.js App Router — estrutura por rota (`page`, `_components`, `_actions`, `_data-access`) |
| `nextjs-app.mdc` | Next.js — UI, formulários, colocação de componentes (enxugue no destino) |

No projeto destino:

1. Copie para `.cursor/rules/` ou `.claude/rules/`.
2. Ative com `alwaysApply: true` **ou** `globs` (ex.: `src/app/**/*.tsx`).
3. Mantenha a rule geral stack-agnóstica separada; não misture Next e Nest no mesmo arquivo.
