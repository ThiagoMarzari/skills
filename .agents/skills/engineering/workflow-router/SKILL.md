---
name: workflow-router
description: "Indica a skill ou o prompt adequado neste kit. Use somente com /workflow-router quando o próximo passo não estiver claro ou houver duas opções parecidas."
disable-model-invocation: true
---

# Workflow Router

Indique **uma** rota: qual comando usar agora e qual decisão humana falta. Não execute a skill indicada, não escreva código nem documentos, não altere arquivos. Pode ler o `SKILL.md` de uma opção só para confirmar o comportamento.

## Classificar

Escolha a **primeira** necessidade real:

| # | Situação | Rota |
|---|----------|------|
| 0 | Repo destino ainda sem `docs/agents/` | `/setup-skills` |
| 1 | Mudança de produto sem PRD/specs | `/prd` |
| 2 | PRD existe, falta plano ou implementação | `/plan-spec` (`todas`, `implementa`) |
| 3 | Mudança pequena e clara (bug, ajuste isolado, docs) | implementação direta → verificações aplicáveis → `/code-review` |
| 4 | Mudança com risco implementada, pronta para review | `/preflight` → `/code-review` |
| 5 | Revisar branch ou PR/MR | `/code-review` |
| 6 | Entrega explicitamente solicitada | `/delivery` |
| 7 | Trabalho precisa viajar (outro harness, pasta, colega) | `/handoff` |

Antes de escrever testes, sugira colar `.prompts/testes-automatizados.md` — é prompt, não skill.

Se não couber em uma categoria, faça **uma** pergunta objetiva.

## Responder

```markdown
Situação: [uma frase].

1. [comando ou ação]
2. [próxima etapa, se houver]

Agora: [comando exato].
```

Inclua só etapas aplicáveis e decisões humanas pendentes. Sugira chat novo quando a fase mudar (ex.: PRD pronto, vem planejamento); nunca no meio de implementação.

**Conclua quando:** uma rota, última linha com o comando exato, skill indicada não executada.
