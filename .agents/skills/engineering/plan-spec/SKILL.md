---
name: plan-spec
description: Plano técnico de specs pendentes em docs/prd/. Use com /plan-spec; acrescente "todas" para todas as pendentes ou "implementa" para executar sem etapa separada de aprovação.
disable-model-invocation: true
---

# Plan Spec

## Ativação e objetivo

Use somente com `/plan-spec`.

Transforme spec funcional de `docs/prd/` em plano técnico implementável com o código existente. Não peça PRD colado — leia o projeto.

## Modos

| Comando | Efeito |
|---------|--------|
| `/plan-spec` | Pergunta: uma spec ou todas |
| `/plan-spec todas` | Planeja todas pendentes, em ordem do PRD |
| `/plan-spec implementa` | Implementa próxima pendente |
| `/plan-spec todas implementa` | Implementa todas pendentes |

Sem `implementa`: só planeja. Com `implementa`: pode alterar código no recorte.

Se faltar `todas` e `implementa`, pergunte: **"Uma spec ou todas as pendentes?"** (use `AskQuestion` se disponível).

## Etapa 1 — Localizar PRD

1. Liste nomes em `docs/prd/` (`NN-prd-<slug>.md`).
2. Escolha o PRD do pedido; se ambíguo, pergunte.
3. Leia PRD e spec-alvo.

Sem PRD → informe que `/prd` vem antes. Não crie PRD aqui.

**Conclua quando:** um PRD escolhido e lido.

## Etapa 2 — Selecionar spec

Use **Ordem recomendada de implementação** do PRD:

- Pule `Status: Implementada`.
- Uma spec: primeira `Aguardando implementação`.
- Todas: todas pendentes, na ordem.
- Respeite dependências; destaque bloqueios.

Spec sem status ou fora da ordem → peça correção antes de planejar.

**Conclua quando:** alvo, status e ordem definidos.

## Etapa 3 — Entender código

Leia só o necessário: fluxo, tipos, rotas, auth, testes, configs.

Compare com a spec: objetivo, comportamento, dados, regras, erros, aceite, dependências.

Lacuna bloqueante → pare e informe. Lacuna não bloqueante → suposição explícita.

Reutilize stack e padrões do projeto; não troque framework sem necessidade da spec.

**Conclua quando:** código, integrações e lacunas mapeados.

## Etapa 4 — Montar plano

Sem `implementa`: use Plan mode se disponível; espere aprovação.

Por spec planejada:

1. Objetivo do recorte
2. Pontos afetados (caminhos reais, não inventados)
3. Sequência de implementação
4. Dados, regras, permissões
5. Integrações
6. Testes e verificação por critério de aceite
7. Fora do escopo
8. Dependências
9. Decisão arquitetural duradoura em aberto, se houver

**Conclua quando:** cada requisito tiver ação, validação ou justificativa de N/A.

## Etapa 5 — Implementar

Só com `implementa` ou aprovação explícita do plano nesta conversa.

1. Implemente só o recorte
2. Valide aceite e erros
3. Marque spec `Implementada` após validação
4. Atualize status do PRD se todas implementadas

Sem `implementa`: código, testes, docs e status no PRD permanecem como estão.

**Conclua quando:** com `implementa` ou aprovação, o recorte estiver implementado e a spec marcada; sem `implementa`, só o plano existir e o código intacto.

## Saída

**Plano:** spec planejada, passos, verificações, fora do escopo → **"Aprova este plano para implementação?"**

**Implementação:** o que foi feito, validações, aceite atendido, pendências, status da spec.
