---
name: fecha-a-task
description: Revisa o diff, commita, faz push e abre duas MRs no GitLab (sandbox e release). Use somente com /fecha-a-task.
disable-model-invocation: true
---

# Fecha a task

## Ativação

Use somente com `/fecha-a-task` ou pedido explícito de fechar a task (last mile, abrir as MRs de sandbox e release).

Pedido explícito de commit + **duas** MRs no **GitLab** (`glab`). Não usar `gh`. Não mergear. Regras de uma PR no GitHub não se aplicam.

## Objetivo

Branch de feature publicada, com duas MRs da mesma source: uma para a base sandbox e outra para a base release do repo atual (front e back têm nomes diferentes).

## Mapa de repos e branches

Preencha os `TODO_*` neste arquivo antes de usar em um destino. Não invente nomes.

- Front — reconhecer por: `TODO_FRONT_REMOTE` (trecho da URL GitLab ou nome da pasta)
- Front — sandbox: `TODO_FRONT_SANDBOX`
- Front — release: `TODO_FRONT_RELEASE`
- Back — reconhecer por: `TODO_BACK_REMOTE`
- Back — sandbox: `TODO_BACK_SANDBOX`
- Back — release: `TODO_BACK_RELEASE`

## Sem marca d'água

Commit e corpo das MRs só com conteúdo humano. Sem `Co-authored-by`, `Made-with`, `Generated with`, 🤖, links de sessão Cursor/Claude/Codex ou trailer de ferramenta. Não alterar `user.name` / `user.email`.

## Etapa 1 — Resolver bases

1. Leia `git remote get-url origin` e o basename do cwd.
2. Case com `TODO_FRONT_REMOTE` ou `TODO_BACK_REMOTE`.
3. Sem match, ou qualquer valor ainda `TODO_*` → **pare** e peça os quatro nomes de branch e como reconhecer cada repo. Não abra MR contra `main`/`master`.

**Conclua quando:** repo identificado como front ou back e as duas bases reais estiverem definidas.

## Etapa 2 — Revisar

`git status`, `git diff`, `git log` recente. Procure trabalho incompleto, debug leftover, secrets, arquivos que não devem ir.

Bloqueio → pare e pergunte. Não commite no escuro.

**Conclua quando:** o diff estiver revisado e seguro para commit, ou a working tree já estiver limpa.

## Etapa 3 — Verificar glab

`command -v glab` e `glab auth status`. Faltando ou auth falha → pare com instrução curta. Não caia para `gh`.

**Conclua quando:** `glab` autenticado no GitLab.

## Etapa 4 — Branch

Nunca commite/pushe nas bases sandbox/release do mapa, nem em `main`/`master`. Se estiver numa dessas, crie `feat|fix|chore/...` a partir da base sandbox daquele repo.

**Conclua quando:** HEAD for uma branch de feature.

## Etapa 5 — Commit

Se a working tree estiver limpa, pule para a etapa 6.

Caso contrário: status + diff + log; stage só arquivos nomeados (sem `git add .` / `git add -A`); mensagem via HEREDOC; sem `--no-verify`; sem marca d'água.

Se existir `docs/agents/commit-conventions.md`, aplique o formato de lá.

**Conclua quando:** mudanças relevantes estiverem commitadas ou não houver nada a commitar.

## Etapa 6 — Push

`git push -u origin HEAD`. Sem force push.

**Conclua quando:** a branch estiver no remoto.

## Etapa 7 — Duas MRs

Mesma source, targets do mapa:

```bash
glab mr create --yes --target-branch <base-sandbox> --source-branch <branch> --title "<titulo>" --description "<corpo sandbox>"
glab mr create --yes --target-branch <base-release> --source-branch <branch> --title "<titulo>" --description "<corpo release>"
```

Título igual nas duas. No corpo, uma linha com o ambiente (sandbox vs release), sem marca d'água.

Par source/target já existente → não duplique; devolva a URL (`glab mr list --source-branch <branch> --target-branch <base>`).

**Conclua quando:** as duas URLs existirem (criadas agora ou já abertas).

## Entrega

Só as duas URLs. Sem merge.
