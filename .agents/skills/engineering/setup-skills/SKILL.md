---
name: setup-skills
description: Configura tracker, commits e entrega por provedor no repo destino. Use somente com /setup-skills.
disable-model-invocation: true
---

# Setup Skills

Configura **este** repositório para que as skills de engenharia leiam decisões em runtime, em vez de assumir ferramenta.

Grava:

- `docs/agents/issue-tracker.md` — onde issues vivem e como aparecem em commits (`code-review` lê)
- `docs/agents/commit-conventions.md` — formato de mensagem (`rework-commits` lê)
- `docs/agents/delivery.md` — provedor, destinos e branches protegidas deste repo (`delivery` lê), só se a skill estiver instalada
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
5. Branches locais e remotas (`git branch -a`) — candidatos a destinos de entrega.
6. Se a pasta `delivery` existe ao lado das skills deste repo (no destino: `.agents/skills/delivery` ou `.claude/skills/delivery`). Sem ela, pule a seção Delivery.

**Conclua quando:** remote, arquivos de instrução, configs existentes e presença de `delivery` estiverem registrados.

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

### Seção C — Delivery (só se `delivery` estiver instalada)

Provedor e destinos **deste** repo. `delivery` lê só este arquivo; não preenche a skill.

Pergunte, nesta ordem, recomendando a partir do remote e das branches vistas:

1. **Provider:** `github`, `gitlab` ou `manual`. Detecte pelo remote, mas confirme com o usuário.
2. **CLI:** `gh` para GitHub, `glab` para GitLab, `nenhuma` para manual.
3. **Reconhecer por:** trecho estável da URL do remote ou nome da pasta, para evitar usar config copiada do repo errado.
4. **Destinos:** um branch para GitHub; um ou mais branches para GitLab; nenhum para manual. Não invente branches: confirme os destinos que não apareçam em `git branch -a`.
5. **Branches protegidas contra commit/push direto:** inclua todos os destinos e `main`/`master`, salvo escolha explícita diferente do usuário. Proteção contra push direto não impede PR/MR para destino configurado.

Front e back são dois repositórios: cada um tem o próprio `docs/agents/delivery.md`.

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

[uma linha: provedor e destino(s) configurados]. Ver `docs/agents/delivery.md`.
```

Escreva os arquivos a partir dos seeds:

- Tracker GitHub → [`references/issue-tracker-github.md`](references/issue-tracker-github.md)
- Tracker GitLab → [`references/issue-tracker-gitlab.md`](references/issue-tracker-gitlab.md)
- Tracker local → [`references/issue-tracker-local.md`](references/issue-tracker-local.md)
- Tracker nenhum → [`references/issue-tracker-none.md`](references/issue-tracker-none.md)
- Convenções → [`references/commit-conventions.md`](references/commit-conventions.md)
- Delivery → [`references/delivery.md`](references/delivery.md)

Para **Outro** no tracker, escreva `docs/agents/issue-tracker.md` a partir da descrição do usuário, no mesmo formato dos seeds (tipo, onde, referência em commits, consumidores).

Preencha o seed de delivery com a configuração confirmada. GitHub usa exatamente um destino e `gh`; GitLab usa um ou mais destinos e `glab`; `manual` usa `nenhuma` e nenhum destino. Não deixe placeholder.

**Conclua quando:** os arquivos aplicáveis em `docs/agents/` existirem e o bloco `## Agent skills` estiver no arquivo escolhido, sem duplicata.

## Entrega

Informe os caminhos gravados. `code-review`, `rework-commits` e `delivery` passam a ler esses arquivos. O usuário pode editar `docs/agents/*.md` direto; reexecute esta skill só para trocar tracker, delivery ou recomeçar.
