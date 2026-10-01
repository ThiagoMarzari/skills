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

Conclua o last mile pelo provedor e destinos definidos em `docs/agents/delivery.md`, gravado por `/setup-skills`. Não edite esta skill no destino.

## Ambiente e ferramentas do provedor

Considere que `gh`, `glab` ou a CLI de outro provedor pode estar instalada e autenticada no computador do usuário, mas ausente ou inacessível no sandbox/ambiente do agente. A configuração do repositório informa qual ferramenta usar; ela não garante que essa ferramenta esteja disponível neste ambiente.

Antes de concluir que a CLI está ausente, verifique-a no ambiente de execução atual com `command -v <cli>` e consulte a ajuda/status somente se o comando existir. Não tente instalar a CLI, acessar o computador do usuário por outro meio, nem repita comandos que já falharam por ausência da ferramenta ou falta de acesso ao host.

Se a CLI estiver no computador do usuário, mas indisponível no ambiente do agente, não trate isso como erro de configuração do provedor nem fique alternando entre CLIs. Continue as etapas locais que forem seguras e possíveis. Pare antes da primeira ação que dependa dessa CLI (autenticação, consulta/criação de PR/MR etc.) e informe claramente: a CLI configurada, que ela não está acessível neste ambiente e o ponto exato em que a entrega parou. Forneça ao usuário os comandos restantes para executar no próprio computador. Se as etapas locais já tiverem sido concluídas, preserve o resultado e entregue instruções claras para finalizar a publicação; não desfaça commits ou branches.

Não peça ao usuário para instalar uma ferramenta que ele já tem no computador. Só recomende instalação se ele disser que ela também não está instalada no host.

## Sem marca d'água

Commit e corpo de PR/MR só com conteúdo humano. Sem `Co-authored-by`, `Made-with`, `Generated with`, 🤖, links de sessão Cursor/Claude/Codex ou trailer de ferramenta. Não alterar `user.name` / `user.email`.

## Etapa 1 — Resolver configuração

1. Sem `docs/agents/delivery.md` ou com campos obrigatórios vazios/placeholder → pare e peça `/setup-skills`.
2. Sem `docs/agents/commit-conventions.md`, ou se não definir um formato de mensagem aplicável → pare e peça `/setup-skills` antes de commitar.
3. Confira `Provider`, `Reconhecer por`, `Destinos`, `Branches protegidas` e CLI configurada. Confirme que remote e pasta correspondem ao repo configurado.
4. `github` → exatamente um destino e CLI `gh`; `gitlab` → um ou mais destinos e CLI `glab`. Configuração incompatível, inclusive `manual` → pare e peça `/setup-skills`.

**Conclua quando:** provedor, destinos e proteções deste repo estiverem verificados.

## Etapa 2 — Revisar

`git status`, `git diff`, `git log` recente. Procure trabalho incompleto, debug leftover, secrets, arquivos que não devem ir.

Bloqueio → pare e pergunte. Não commite no escuro.

**Conclua quando:** o diff estiver revisado e seguro para commit, ou a working tree já estiver limpa.

## Etapa 3 — Verificar CLI e autenticação

Verifique se a CLI configurada está disponível neste ambiente (`command -v gh`, `command -v glab` ou equivalente) e use somente essa CLI. Se estiver disponível, confira sua autenticação (`gh auth status`, `glab auth status` ou equivalente). Se estiver ausente/inacessível no sandbox, siga “Ambiente e ferramentas do provedor”: continue o trabalho local possível e pare antes da primeira operação que dependa dela. Se existir, mas não estiver autenticada, pare com instrução curta para autenticar no computador/ambiente que fará a entrega. Não troque de provedor ou CLI para contornar a configuração.

**Conclua quando:** CLI correspondente ao provedor está acessível e autenticada neste ambiente. Se não estiver, registre o bloqueio de ambiente e siga as instruções de parada acima.

## Etapa 4 — Branch

Nunca commite/pushe diretamente nas branches protegidas na etapa 1. Se HEAD for uma delas, crie uma branch `feat|fix|chore/...` a partir do primeiro destino configurado. Se o destino local não estiver disponível, pare e peça orientação; não escolha outra base.

**Conclua quando:** HEAD for uma branch de feature.

## Etapa 5 — Commit

Se a working tree estiver limpa, pule para a etapa 6.

Caso contrário: status + diff + log; stage só arquivos nomeados (sem `git add .` / `git add -A`); mensagem via HEREDOC; sem `--no-verify`; sem marca d'água.

Aplique o formato de mensagem definido em `docs/agents/commit-conventions.md`.

**Conclua quando:** mudanças relevantes estiverem commitadas ou não houver nada a commitar.

## Etapa 6 — Push

`git push -u origin HEAD`. Sem force push.

**Conclua quando:** a branch estiver no remoto.

## Etapa 7 — Abrir PR/MR(s)

Abra um PR no GitHub ou uma MR por destino GitLab, sempre com a mesma source e os destinos de `docs/agents/delivery.md`. Antes de criar, procure par source/target já existente e não duplique.

```bash
gh pr create --base <destino> --head <branch> --title "<titulo>" --body "<corpo>"
glab mr create --yes --target-branch <destino> --source-branch <branch> --title "<titulo>" --description "<corpo>"
```

Inclua o checklist do `/preflight`, quando houver. Corpos sem marca d'água.

Par source/destino já existente → não duplique; devolva URL existente (`gh pr list --base <destino> --head <branch>` ou `glab mr list --source-branch <branch> --target-branch <destino>`).

**Conclua quando:** cada destino configurado tiver URL nova ou já existente.

## Entrega

Informe o provedor, as URLs, validações e bloqueios. Sem merge ou deploy.
