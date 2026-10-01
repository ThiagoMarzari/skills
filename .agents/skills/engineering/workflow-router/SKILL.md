---
name: workflow-router
description: "Indica a skill ou o prompt adequado neste kit. Use somente com /workflow-router quando o próximo passo não estiver claro ou houver duas opções parecidas."
disable-model-invocation: true
---

# Workflow Router

## Objetivo

Indicar **uma** rota principal: qual comando usar agora e qual decisão humana falta.

## Limites

Depois de recomendar:

1. não execute a skill indicada;
2. não escreva código, PRD, plano nem documentação;
3. não altere arquivos.

Pode ler o `SKILL.md` da opção só para confirmar comportamento — isso não inicia a skill.

## Etapa 1 — Classificar

Escolha a **primeira** necessidade real:

| # | Situação | Rota |
|---|----------|------|
| 0 | Repo destino ainda sem `docs/agents/` | `/setup-skills` |
| 1 | Ideia vaga ou decisões de produto em aberto | `/scope-clarifier` |
| 2 | Escopo de produto fechado, falta PRD/specs | `/prd` |
| 3 | PRD existe, falta plano ou implementação | `/plan-spec` |
| 4 | Mudança pequena e clara (bug, ajuste isolado, docs) | implementação direta → verificações aplicáveis → `/code-review` |
| 5 | Implementação de mudança com risco pronta para review | `/preflight` → `/code-review` |
| 6 | Mudança de comportamento, API, regra de negócio, segurança, dados ou produção ainda por definir | `/scope-clarifier` se houver decisões → PRD/plano conforme tamanho → implementação → `/preflight` → `/code-review` |
| 7 | Decisão arquitetural duradoura confirmada, ainda não registrada | `/adr` |
| 8 | Revisar branch/PR desde um ponto | `/code-review` |
| 9 | Docs desatualizadas vs. código | `/documentation-writer` |
| 10 | Branch com histórico confuso | `/rework-commits` |
| 11 | Entrega explicitamente solicitada | `/delivery` |
| 12 | Criar ou revisar instruções para agentes | `/writing-for-agents` |
| 13 | Trabalho precisa viajar (outro harness, pasta, colega ou fork) | `/handoff` |

Se não couber em uma categoria, faça **uma** pergunta objetiva.

**Conclua quando:** houver categoria principal e próximo comando.

## Etapa 2 — Detalhar a rota

### Setup do repo destino

`/setup-skills` → uma vez por repo, antes de `/code-review`, `/rework-commits` e `/delivery` lerem config. Roda só se `docs/agents/` ainda não existir ou o usuário quiser reconfigurar.

### Decisões e escopo

`/scope-clarifier` → depois: mudança de produto/escopo amplo → `/prd`; tarefa pequena e clara → implementação direta.

### PRD e specs

`/prd` → com PRD em `docs/prd/`:

- próxima spec → `/plan-spec`
- todas → `/plan-spec todas`
- implementar → `/plan-spec implementa` ou `/plan-spec todas implementa`

PRD revisado pelo usuário antes de planejar. Plano aprovado antes de implementar, salvo `implementa` no comando.

### Implementação

Antes de escrever testes, o usuário pode colar `.prompts/testes-automatizados.md`; é um prompt, não uma skill.

### Prontidão e decisões

- `/preflight` — depois da implementação de mudança com risco; verifica apenas testes, segurança, CI, migração, rollback e observabilidade aplicáveis. Gera checklist pronto para incluir no PR/MR; não abre PR, não faz deploy.
- `/adr` — registra decisão técnica duradoura em `docs/adr/` depois de o usuário confirmar a decisão. Não use para decisões rotineiras.

### Revisão

`/code-review` — usuário informa ponto de comparação (`main`, `HEAD~3`, tag).

### Documentação e commits

- `/documentation-writer` — sync de README e docs de produto.
- `/rework-commits` — reorganizar histórico antes de entregar.
- `/delivery` — entrega no provedor configurado em `docs/agents/delivery.md` (GitHub PR, GitLab MR(s) ou checklist manual). O comando autoriza o last mile configurado; nunca faz merge ou deploy.

### Handoff (portabilidade)

`/handoff` — grava documento no **temp do OS** para outro agente/sessão/harness/pasta. Não é `/summarize`: use só se o trabalho precisa **viajar**. Mesma task na mesma sessão → summarize ou chat novo com `@` no artefato no disco.

## Etapa 3 — Responder

```markdown
Situação: [uma frase].

Fluxo: [nome curto].

1. [comando ou ação]
2. [próxima etapa, se houver]

Agora: [comando exato].
```

Inclua só etapas aplicáveis. Indique decisões humanas pendentes. Distinga skill de prompt.

**Conclua quando:** uma rota, última linha com o comando exato, skill indicada não executada.

## Troca de fase

Sugira novo chat quando: PRD terminou e vem planejamento; spec mudou; contexto cheio de tentativas descartadas; objetivo da fase mudou.

Continue no mesmo chat quando a próxima ação depende do contexto atual sem risco de confusão.

Não recomende troca no meio de implementação em andamento.
