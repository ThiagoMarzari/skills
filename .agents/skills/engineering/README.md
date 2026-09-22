# Engineering

Skills de fluxo de produto e código. No destino, copie cada pasta `<nome>/` para `.agents/skills/<nome>/` — o bucket não vai junto.

| Skill | Resumo |
|-------|--------|
| `setup-skills` | Configura tracker, commits, provedor e destinos no repo destino |
| `workflow-router` | Indica a próxima skill ou fluxo |
| `scope-clarifier` | Fecha escopo, comportamento e trade-offs antes de avançar |
| `prd` | Gera PRD com specs funcionais em `docs/prd/` |
| `plan-spec` | Converte spec pendente em plano técnico (e implementa se pedido) |
| `preflight` | Verifica prontidão conforme risco e gera checklist para PR/MR |
| `adr` | Registra decisão arquitetural confirmada em `docs/adr/` |
| `code-review` | Revisa o diff em qualidade e atendimento à spec |
| `documentation-writer` | Alinha README e docs de produto ao código |
| `rework-commits` | Reorganiza a branch em commits pequenos e coerentes |
| `delivery` | Entrega via GitHub, GitLab ou checklist manual conforme `docs/agents/delivery.md` |

Referência compartilhada: [`references/entrevista.md`](references/entrevista.md) — tópicos de entrevista para `scope-clarifier` e `prd`.
