---
name: delivery
description: Revisa e entrega uma mudança pelo provedor configurado no repositório. Use somente com /delivery.
disable-model-invocation: true
---

# Delivery

## Ativação

Use somente com `/delivery` ou pedido explícito de concluir a entrega.

O comando explícito autoriza o last mile configurado: revisar, criar branch se necessário, commitar, fazer push e abrir PR/MR. Nunca fazer merge nem deploy. Fora dessa invocação, não commite, faça push ou crie PR/MR.

## Objetivo

Conclua o last mile pelo provedor e destinos definidos em `docs/agents/delivery.md`, gravado por `/setup-skills`; no modo manual, entregue somente um checklist. Não edite esta skill no destino.

## Sem marca d'água

Commit e corpo de PR/MR só com conteúdo humano. Sem `Co-authored-by`, `Made-with`, `Generated with`, 🤖, links de sessão Cursor/Claude/Codex ou trailer de ferramenta. Não alterar `user.name` / `user.email`.

## Etapa 1 — Resolver configuração

1. Sem `docs/agents/delivery.md` ou com campos obrigatórios vazios/placeholder → pare e peça `/setup-skills`.
2. Confira `Provider`, `Reconhecer por`, `Destinos`, `Branches protegidas` e CLI configurada. Confirme que remote e pasta correspondem ao repo configurado.
3. `github` → exatamente um destino e CLI `gh`; `gitlab` → um ou mais destinos e CLI `glab`; `manual` → nenhum destino e nenhuma CLI. Configuração incompatível → pare.

**Conclua quando:** provedor, destinos e proteções deste repo estiverem verificados.

No modo manual, continue até a revisão do diff (etapa 2), pule as etapas 3–7 e entregue checklist; não faça mutações locais ou remotas.

## Etapa 2 — Revisar

`git status`, `git diff`, `git log` recente. Procure trabalho incompleto, debug leftover, secrets, arquivos que não devem ir.

Bloqueio → pare e pergunte. Não commite no escuro.

**Conclua quando:** o diff estiver revisado e seguro para commit, ou a working tree já estiver limpa.

## Etapa 3 — Verificar CLI e autenticação

No modo manual, pule esta etapa. Nos outros modos, use somente a CLI configurada e confira sua autenticação (`gh auth status` ou `glab auth status`). Faltando ou auth falha → pare com instrução curta.

**Conclua quando:** CLI correspondente ao provedor está instalada e autenticada, salvo no modo manual.

## Etapa 4 — Branch

No modo manual, pule esta etapa. Caso contrário, nunca commite/pushe diretamente nas branches protegidas na etapa 1. Se HEAD for uma delas, crie uma branch `feat|fix|chore/...` a partir do primeiro destino configurado. Se o destino local não estiver disponível, pare e peça orientação; não escolha outra base.

**Conclua quando:** HEAD for uma branch de feature.

## Etapa 5 — Commit

No modo manual, pule esta etapa. Se a working tree estiver limpa, pule para a etapa 6.

Caso contrário: status + diff + log; stage só arquivos nomeados (sem `git add .` / `git add -A`); mensagem via HEREDOC; sem `--no-verify`; sem marca d'água.

Se existir `docs/agents/commit-conventions.md`, aplique o formato de lá.

**Conclua quando:** mudanças relevantes estiverem commitadas ou não houver nada a commitar.

## Etapa 6 — Push

No modo manual, pule esta etapa.

`git push -u origin HEAD`. Sem force push.

**Conclua quando:** a branch estiver no remoto.

## Etapa 7 — Abrir PR/MR(s)

No modo manual, pule esta etapa.

Abra um PR no GitHub ou uma MR por destino GitLab, sempre com a mesma source e os destinos de `docs/agents/delivery.md`. Antes de criar, procure par source/target já existente e não duplique.

```bash
gh pr create --base <destino> --head <branch> --title "<titulo>" --body "<corpo>"
glab mr create --yes --target-branch <destino> --source-branch <branch> --title "<titulo>" --description "<corpo>"
```

Inclua o checklist do `/preflight`, quando houver. Corpos sem marca d'água.

Par source/destino já existente → não duplique; devolva URL existente (`gh pr list --base <destino> --head <branch>` ou `glab mr list --source-branch <branch> --target-branch <destino>`).

**Conclua quando:** cada destino configurado tiver URL nova ou já existente.

## Entrega

Informe o provedor, as URLs ou o checklist manual, validações e bloqueios. Sem merge ou deploy.
