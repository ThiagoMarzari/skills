# Engineering

Skills de fluxo de produto e código. No destino, copie cada pasta `<nome>/` para `.agents/skills/<nome>/` — o bucket não vai junto.

| Skill | Resumo |
|-------|--------|
| `tm-setup-skills` | Configura commits, provedor e destinos no repo destino |
| `tm-workflow-router` | Indica a próxima skill ou fluxo |
| `tm-prd` | Gera PRD com specs funcionais em `docs/prd/` |
| `tm-plan-spec` | Converte spec pendente em plano técnico (e implementa se pedido) |
| `tm-preflight` | Roda as verificações que cobrem o diff e gera checklist para PR/MR |
| `tm-code-review` | Revisa o diff em qualidade e atendimento à spec |
| `tm-delivery` | Entrega via GitHub ou GitLab conforme `docs/agents/delivery.md` |
