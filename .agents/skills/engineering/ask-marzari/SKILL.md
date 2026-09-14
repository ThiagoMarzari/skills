---
name: ask-marzari
description: "Indica a skill ou o prompt adequado neste kit. Use somente com /ask-marzari quando o próximo passo não estiver claro ou houver duas opções parecidas."
disable-model-invocation: true
---

# Pergunte ao Marzari

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
| 1 | Ideia vaga ou decisões em aberto | `/questiona` |
| 2 | Escopo fechado, falta PRD/specs | `/prd-generator` |
| 3 | PRD existe, falta plano ou implementação | `/plan-spec` |
| 4 | Sabe o que construir, quer código | implementação direta |
| 5 | Revisar branch/PR desde um ponto | `/code-review` |
| 6 | Docs desatualizadas vs. código | `/documentation-writer` |
| 7 | Branch com histórico confuso | `/rework-commits` |
| 8 | Task pronta: revisar, commit, push e MRs sandbox/release | `/fecha-a-task` |
| 9 | Criar ou revisar instruções para agentes | `/writing-for-agents` |
| 10 | Trabalho precisa viajar (outro harness, pasta, colega ou fork) | `/handoff` |

Se não couber em uma categoria, faça **uma** pergunta objetiva.

**Conclua quando:** houver categoria principal e próximo comando.

## Etapa 2 — Detalhar a rota

### Setup do repo destino

`/setup-skills` → uma vez por repo, antes de `/code-review`, `/rework-commits` e `/fecha-a-task` lerem config. Roda só se `docs/agents/` ainda não existir ou o usuário quiser reconfigurar.

### Decisões e escopo

`/questiona` → depois: escopo grande → `/prd-generator`; tarefa pequena e clara → implementação.

### PRD e specs

`/prd-generator` → com PRD em `docs/prd/`:

- próxima spec → `/plan-spec`
- todas → `/plan-spec todas`
- implementar → `/plan-spec implementa` ou `/plan-spec todas implementa`

PRD revisado pelo usuário antes de planejar. Plano aprovado antes de implementar, salvo `implementa` no comando.

### Implementação

Durante implementação com regras de negócio, o usuário pode colar `.prompts/tdd-com-agentes.md` ou `.prompts/testes-automatizados.md`. São prompts, não skills.

### Revisão

`/code-review` — usuário informa ponto de comparação (`main`, `HEAD~3`, tag).

### Documentação e commits

- `/documentation-writer` — sync de README e docs de produto.
- `/rework-commits` — reorganizar histórico antes de entregar.
- `/fecha-a-task` — last mile no GitLab: duas MRs (sandbox e release) da mesma branch. Lê `docs/agents/delivery.md`; sem o arquivo, `/setup-skills` primeiro.

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
