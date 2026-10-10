# Engineering

Skills de fluxo de produto e código. No destino, copie cada pasta `<nome>/` para `.agents/skills/<nome>/` — o bucket não vai junto.

| Skill | Resumo |
|-------|--------|
| `setup-skills` | Configura tracker, commits, provedor e destinos no repo destino |
| `workflow-router` | Indica a próxima skill ou fluxo |
| `prd` | Gera PRD com specs funcionais em `docs/prd/` |
| `plan-spec` | Converte spec pendente em plano técnico (e implementa se pedido) |
| `preflight` | Roda as verificações que cobrem o diff e gera checklist para PR/MR |
| `code-review` | Revisa o diff em qualidade e atendimento à spec |
| `delivery` | Entrega via GitHub ou GitLab conforme `docs/agents/delivery.md` |
