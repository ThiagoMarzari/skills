---
name: tm-workflow-router
description: "Indica a skill ou o prompt adequado neste kit. Use somente com /tm-workflow-router quando o próximo passo não estiver claro ou houver duas opções parecidas."
argument-hint: "O que você quer fazer agora?"
disable-model-invocation: true
---

# Workflow Router

Indique **uma** rota: qual comando usar agora e qual decisão humana falta. Não execute a skill indicada, não escreva código nem documentos, não altere arquivos. Se o usuário passou argumentos, trate-os como a descrição do que ele quer fazer.

## Ler o estado

Descubra pelo repositório antes de perguntar. Só leitura:

- `docs/agents/` existe?
- Skills instaladas: pastas em `.claude/skills/` e `.agents/skills/`; prompts em `.prompts/`.
- `docs/prd/`: PRDs e status das specs (`Aguardando implementação` ou `Implementada`).
- `git status` e `git diff --stat`: mudanças locais.
- `git log --oneline <principal>..HEAD`: commits da branch que a principal não tem.

Pode ler o `SKILL.md` de uma opção só para confirmar o comportamento.

## Medir o risco

- **Pequena:** alteração isolada sem impacto em comportamento, API, regra de negócio, segurança, dados ou produção — bug pontual, ajuste, docs.
- **Com risco:** muda comportamento, API, regra de negócio, integração, dependência ou CI.
- **Alto risco:** auth/permissões, dados sensíveis, migração ou exclusão de dados, pagamentos, produção.

Na dúvida entre dois níveis, use o maior: subestimar o risco pula verificações que custam pouco.

## Classificar

Escolha a **primeira** linha que se aplica:

| # | Situação | Rota |
|---|----------|------|
| 0 | Repo sem `docs/agents/` | `/tm-setup-skills` |
| 1 | Mudança com risco ou alto risco, ainda não implementada, sem PRD que a cubra | `/tm-prd` |
| 2 | PRD com spec `Aguardando implementação` | `/tm-plan-spec` no modo certo (abaixo) |
| 3 | Mudança pequena | implementação direta, se faltar → testes pertinentes → `/tm-code-review` |
| 4 | Mudança com risco implementada | `/tm-preflight` → `/tm-code-review` |
| 5 | Mudança de alto risco implementada | `/tm-preflight` → validar rollback e monitoramento → `/tm-code-review` |
| 6 | Revisar branch ou PR/MR | `/tm-code-review` |
| 7 | Entrega explicitamente solicitada | `/tm-delivery` |
| 8 | Trabalho precisa viajar (outro harness, pasta, colega) | `/tm-handoff` |

**Modo do `/tm-plan-spec`:** acrescente `todas` se o usuário quer cobrir todas as pendentes, e `implementa` só se ele dispensou a aprovação do plano. Sem esses sinais, use `/tm-plan-spec` puro. Se não houver sinal de que o usuário revisou o PRD, coloque essa revisão como decisão pendente.

**Testes:** se a rota inclui escrever testes e `.prompts/testes-automatizados.md` existe, coloque antes uma etapa para colar esse prompt (é prompt, não skill).

**Skill ausente:** se a rota usa uma skill que não está instalada, diga isso e troque pela etapa manual equivalente. Por exemplo, sem `/tm-preflight`: rodar os testes, lint e typecheck que cobrem o diff. Sem `tm-setup-skills`, pule a linha 0 e avise que `/tm-delivery` não vai funcionar.

Se o estado e o pedido não decidirem entre duas linhas, faça **uma** pergunta objetiva.

## Responder

```markdown
Situação: [uma frase, citando o estado lido].

1. [comando ou ação]
2. [próxima etapa, se houver]

Decisão pendente: [só se houver].

Agora: [comando exato ou ação].
```

Inclua só etapas aplicáveis. Sugira chat novo quando a fase mudar (ex.: PRD pronto, vem planejamento); nunca no meio de implementação.

**Conclua quando:** uma rota, última linha com o próximo passo exato, nenhuma skill ausente indicada, skill indicada não executada.
