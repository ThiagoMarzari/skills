---
name: rework-commits
description: Reorganiza branch em commits pequenos e semanticamente separados, preservando o conteúdo. Use somente com /rework-commits.
disable-model-invocation: true
---

# Reorganização de commits

## Ativação

Use somente com `/rework-commits` ou pedido explícito de reorganizar commits.

Reescreve histórico — só com pedido explícito.

## Objetivo

Sequência de commits pequenos, coerentes e revisáveis, **sem** mudar o diff final da branch.

## Proteções

- Pare se houver alterações não commitadas
- Não execute na branch principal
- Confirme branch e base
- Informe hash atual antes de operação destrutiva
- Salve diff original antes de reescrever
- Não force push; avise se branch já foi publicada
- Falha em validação → pare sem alterar histórico

## Etapa 1 — Verificar

Status limpo, branch segura, base correta, sem rebase em andamento, hash de recuperação informado.

**Conclua quando:** repositório pronto para reescrita.

## Etapa 2 — Preservar

1. Diff completo em `/tmp/original-diff.patch`
2. Lista de commits `base..HEAD`
3. Agrupe alterações por unidade lógica

**Conclua quando:** cópia verificável e divisão proposta.

## Etapa 3 — Planejar

Cada commit: uma mudança lógica, compreensível isolada, ordem de dependências respeitada.

Ordem sugerida quando couber: dados/modelos → backend/regras → frontend → testes/docs. Adapte ao projeto.

**Conclua quando:** toda alteração atribuída a um commit.

## Etapa 4 — Reescrever

1. Apresente plano; aguarde confirmação
2. Reorganize com Git; use `GIT_EDITOR=true` se necessário
3. Compare diff final com `/tmp/original-diff.patch`
4. Rode validações do projeto
5. Remova patch temporário só após comparação OK

Falha na comparação → pare, informe hash de recuperação.

**Conclua quando:** commits criados, diff igual ao original, validações OK ou falhas registradas.

## Entrega

Commits criados, validações, limitações, hash de recuperação se útil.
