---
name: setup-skills
description: Configura o repo destino para as skills de engenharia — tracker, commits e bases sandbox/release. Use somente com /setup-skills.
disable-model-invocation: true
---

# Setup das skills de engenharia

Configura **este** repositório para que as skills de engenharia leiam decisões em runtime, em vez de assumir ferramenta.

Grava:

- `docs/agents/issue-tracker.md` — onde issues vivem e como aparecem em commits (`code-review` lê)
- `docs/agents/commit-conventions.md` — formato de mensagem (`rework-commits` lê)
- `docs/agents/delivery.md` — bases sandbox/release deste repo (`fecha-a-task` lê), só se a skill `fecha-a-task` estiver instalada
- bloco `## Agent skills` em `CLAUDE.md` ou `AGENTS.md`

Skill prompt-driven: explore, proponha, confirme, só então escreva. Roda uma vez por repo; reexecute só para trocar tracker, delivery ou recomeçar.

## Ativação e limites

Use somente com `/setup-skills`.

Altera só os arquivos em `docs/agents/` listados acima e o bloco `## Agent skills` no arquivo escolhido (`CLAUDE.md` ou `AGENTS.md`). Crie `docs/agents/` ao gravar, se necessário. Não edite o `SKILL.md` de nenhuma skill.

## Etapa 1 — Explorar

Leia o que existir; não assuma:

1. `git remote -v` e `.git/config` — GitHub, GitLab, outro, nenhum.
2. `AGENTS.md` e `CLAUDE.md` na raiz — qual existe; se já há `## Agent skills`.
3. `docs/agents/` — output anterior desta skill.
4. Convenção de commit visível: `git log -10 --oneline`, `CONTRIBUTING.md`, section de commits em README.
5. Branches locais e remotas (`git branch -a`) — candidatos a sandbox/release.
6. Se a pasta `fecha-a-task` existe ao lado das skills deste repo (no destino: `.agents/skills/fecha-a-task` ou `.claude/skills/fecha-a-task`). Sem ela, pule a seção Delivery.

**Conclua quando:** remote, arquivos de instrução, configs existentes e presença de `fecha-a-task` estiverem registrados.

## Etapa 2 — Propor e perguntar

Resuma o que encontrou. Uma seção, uma pergunta, depois a próxima. Lidere com a recomendação para o usuário aceitar em uma palavra.

### Seção A — Tracker de issues

Onde o trabalho deste repo é rastreado. `code-review` usa isso para achar spec a partir de commits.

Se o remote aponta para GitHub, proponha GitHub. Se GitLab (`gitlab.com` ou self-hosted), proponha GitLab. Ofereça:

- **GitHub** — issues no GitHub Issues do repo
- **GitLab** — issues no GitLab Issues do repo
- **Local** — arquivos markdown no próprio repo (indique a pasta)
- **Nenhum** — sem tracker; `code-review` segue docs e o pedido do usuário
- **Outro** — o usuário descreve o fluxo em um parágrafo; grave como prosa

Grave a escolha em `docs/agents/issue-tracker.md`. Inclua o **formato de referência em commits** (ex.: `#123`, `Closes #45`, `ABC-123`) — é o que `code-review` consome.

### Seção B — Convenções de commit

Como `rework-commits` redige mensagens. Se o log recente já for consistente, proponha esse padrão. Ofereça:

- **Curta e descritiva** — uma linha, mudança lógica, sem prefixo obrigatório (padrão se nada estiver definido)
- **Conventional Commits** — `tipo(escopo): descrição`
- **Outro** — o usuário descreve o formato

Inclua idioma das mensagens se o log já o revelar.

### Seção C — Delivery (só se `fecha-a-task` estiver instalada)

Bases **deste** repo para duas MRs GitLab. `fecha-a-task` lê só este arquivo; não preenche a skill.

Pergunte, nesta ordem, com recomendação a partir das branches vistas:

1. **Papel** deste checkout: `front`, `back` ou `único`.
2. **Reconhecer por** — trecho estável da URL do remote ou nome da pasta (sanity check se o arquivo for copiado para o repo errado).
3. **Base sandbox** e **base release** — nomes literais das branches. Não invente; se não aparecerem em `git branch -a`, confirme com o usuário.
4. **Branches protegidas contra commit/push direto** — no mínimo as duas bases, `main` e `master`. Essa proteção não proíbe MRs: os targets permitidos são **Base sandbox** e **Base release**.

Front e back são dois repositórios: cada um tem o próprio `docs/agents/delivery.md`. Não grave o mapa do par no mesmo arquivo.

**Conclua quando:** as seções aplicáveis estiverem confirmadas pelo usuário.

## Etapa 3 — Mostrar rascunho

Mostre, antes de gravar:

- o bloco `## Agent skills` (arquivo-alvo segundo a etapa 4)
- o conteúdo de `docs/agents/issue-tracker.md`
- o conteúdo de `docs/agents/commit-conventions.md`
- o conteúdo de `docs/agents/delivery.md`, se a seção C rodou

Aguarde edição ou confirmação.

**Conclua quando:** o usuário confirmar o rascunho.

## Etapa 4 — Gravar

Arquivo do bloco:

- Se `CLAUDE.md` existir, edite-o.
- Senão, se `AGENTS.md` existir, edite-o.
- Se nenhum existir, pergunte qual criar.

Se `## Agent skills` já existir, atualize no lugar; preserve o restante do arquivo.

```markdown
## Agent skills

### Issue tracker

[uma linha: onde as issues vivem]. Ver `docs/agents/issue-tracker.md`.

### Convenções de commit

[uma linha: formato das mensagens]. Ver `docs/agents/commit-conventions.md`.
```

Se a seção C rodou, acrescente:

```markdown
### Delivery

[uma linha: duas MRs GitLab, bases sandbox e release]. Ver `docs/agents/delivery.md`.
```

Escreva os arquivos a partir dos seeds:

- Tracker GitHub → [`references/issue-tracker-github.md`](references/issue-tracker-github.md)
- Tracker GitLab → [`references/issue-tracker-gitlab.md`](references/issue-tracker-gitlab.md)
- Tracker local → [`references/issue-tracker-local.md`](references/issue-tracker-local.md)
- Tracker nenhum → [`references/issue-tracker-none.md`](references/issue-tracker-none.md)
- Convenções → [`references/commit-conventions.md`](references/commit-conventions.md)
- Delivery → [`references/delivery.md`](references/delivery.md)

Para **Outro** no tracker, escreva `docs/agents/issue-tracker.md` a partir da descrição do usuário, no mesmo formato dos seeds (tipo, onde, referência em commits, consumidores).

Preencha os campos do seed de delivery com os nomes confirmados. Não deixe placeholder.

**Conclua quando:** os arquivos aplicáveis em `docs/agents/` existirem e o bloco `## Agent skills` estiver no arquivo escolhido, sem duplicata.

## Entrega

Informe os caminhos gravados. `code-review`, `rework-commits` e `fecha-a-task` passam a ler esses arquivos. O usuário pode editar `docs/agents/*.md` direto; reexecute esta skill só para trocar tracker, delivery ou recomeçar.
