---
name: plan-spec
description: Technical plan for the next pending spec in docs/prd/, based on Status. Use with /plan-spec. Add "todas" for the full scope; "implementa" to code without going through the plan.
disable-model-invocation: true
---

# Plano da spec

Só `/plan-spec`. Não peça para colar spec nem PRD.

## Como devolver o plano

Sem `implementa`: o plano tem que aparecer **como o Cursor faz** (painel / arquivo de plano), não como um markdown solto no chat.

1. Se não estiver em Plan mode, **troque para Plan mode** (`SwitchMode` → `plan`) antes de redigir o plano. Peça o aceite do usuário e só continue depois.
2. Explore o PRD e o código **em Plan mode** (leitura). Monte o plano aí.
3. Não implemente, não crie arquivo de código. Espere o usuário aprovar o plano.
4. Se Plan mode / `SwitchMode` não existir (outro editor): escreva o plano no chat e pare. Diga que não há painel nativo.

Com `implementa`: não troque de modo; vá ao código no recorte abaixo.

## Alvo

1. Ache o PRD em `docs/prd/` (vários pendentes → confirme qual).
2. Seção 14: pule **Implementada**. A próxima **Aguardando implementação** é o alvo.
3. Padrão: **só essa spec**. `todas` / `task curta`: pendentes na ordem, um bloco por Spec 0N.
4. Verdade: corpo da spec alvo + código. Dependências = o que já está no repo.

## Conteúdo do plano

Por spec: o que muda (stack já usada) · ordem nesta spec · o que NÃO fazer · aceite em checagens.

Fora do escopo da spec = fora do plano. Spec seguinte = não planejar, salvo `todas`.

## Implementar

Só com **implementa** (ou depois do usuário aprovar o plano neste chat). Mesmo recorte. Spec pronta → Status **Implementada**. Todas prontas → Status do PRD **Implementada**.
