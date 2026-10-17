# Kit de práticas para IA

Skills e prompts para agentes no Claude Code, Cursor ou ferramentas compatíveis. **Não é um aplicativo** — copie seletivamente e adapte ao destino.

## Conteúdo

| Caminho | Conteúdo |
|---------|----------|
| `.agents/skills/` | Skills, em buckets `engineering/` e `productivity/` (só organização da origem) |
| `skills-lock.json` | Lista das skills de terceiros que uso (origem e versão). Os arquivos delas ficam só na máquina, fora do Git |
| `install.sh` | Instala as skills do kit e as do lock em qualquer projeto |
| `.prompts/` | Prompts colados quando a tarefa precisar; não são auto-carregados |
| `AGENTS.md` / `CLAUDE.md` | Orientação carregada com o projeto |
| `LICENSE` | MIT — vale para o conteúdo do kit, não para as skills de terceiros |

## Skills

Todas são user-invoked: só rodam com o comando explícito. O prefixo `tm-` marca as skills deste kit e as separa das skills da empresa, de terceiros e embutidas na ferramenta. No destino, tudo que começa com `tm-` pode ser substituído pela versão nova do kit.

| Comando | Quando usar |
|---------|-------------|
| `/tm-setup-skills` | Uma vez por repo destino: grava commits, provedor e destinos em `docs/agents/` |
| `/tm-workflow-router` | Próximo passo incerto |
| `/tm-prd` | Entrevistar e gravar PRD com specs em `docs/prd/` |
| `/tm-plan-spec` | Planejar ou implementar specs pendentes (`todas` / `implementa`) |
| `/tm-preflight` | Rodar as verificações que cobrem o diff e gerar checklist para PR/MR |
| `/tm-code-review` | Revisar as mudanças da branch: bugs, aderência à spec e qualidade |
| `/tm-delivery` | Commit, push e PR/MR pelo provedor configurado (GitHub ou GitLab); nunca merge nem deploy |
| `/tm-handoff` | Compactar a conversa num arquivo no temp para outro agente continuar |

## Prompts

| Arquivo | Uso |
|---------|-----|
| `.prompts/prd.md` | Briefing inicial antes de `/tm-prd` |
| `.prompts/testes-automatizados.md` | Decidir o que merece teste fora do `/tm-plan-spec`, que já faz essa triagem |

## Fluxo

```text
Mudança pequena:    implementação → verificações aplicáveis → /tm-code-review
Mudança de produto: /tm-prd → /tm-plan-spec → implementação → /tm-preflight → /tm-code-review
Entrega explícita:  /tm-delivery
```

Use só as fases necessárias:

- **Pequena:** alteração isolada sem impacto em comportamento, API, regra de negócio, segurança, dados ou produção. Implemente, rode os testes pertinentes e revise.
- **Com risco:** mudança de comportamento, API, regra de negócio, integração, dependência ou CI. PRD/plano conforme o tamanho e `/tm-preflight` antes do review.
- **Alto risco:** auth/permissões, dados sensíveis, migração/exclusão de dados, pagamentos ou produção. Além do preflight, valide reversibilidade e monitoramento.

PRD revisado pelo usuário antes de planejar; plano aprovado antes de implementar, salvo `/tm-plan-spec implementa`. Prefira chat novo entre PRD e planejamento.

## Artefatos e posse

| Artefato | Quem cria/lê/altera |
|---|---|
| `docs/agents/*` | `tm-setup-skills` cria; `tm-delivery` lê |
| `docs/prd/*.md` | `tm-prd` cria; `tm-plan-spec` atualiza só o status após validação |
| Código e testes | Implementação / `tm-plan-spec implementa` |
| Histórico Git | Humanos; `tm-delivery` commita/pusha só sob comando explícito |

## Instalar

Rode dentro do projeto destino. A CLI [`skills`](https://github.com/vercel-labs/skills) detecta os agentes instalados e copia cada skill sem o bucket (`engineering/`, `productivity/`).

| Para | Comando |
|---|---|
| Só as skills do kit | `npx skills add ThiagoMarzari/skills` |
| Kit + terceiros do lock | `curl -fsSL https://raw.githubusercontent.com/ThiagoMarzari/skills/main/install.sh \| sh` |
| O mesmo, para todos os projetos | `curl -fsSL https://raw.githubusercontent.com/ThiagoMarzari/skills/main/install.sh \| sh -s -- -g` |
| Atualizar o que foi instalado | `npx skills update` |

Para manter a coleção:

- **Adicionar uma skill de terceiro:** neste repo, `npx skills add dono/repo --skill <nome>` e commite o `skills-lock.json`. O `install.sh` passa a instalá-la.
- **Clonou este repo numa máquina nova:** `npx skills experimental_install` restaura os terceiros a partir do lock.
- **Sem a CLI:** copie a pasta da skill para `destino/.claude/skills/<nome>/` (Claude Code) ou `destino/.agents/skills/<nome>/`, com as referências da própria pasta. Prompts vão para `destino/.prompts/`.

Depois rode `/tm-setup-skills` uma vez no destino. A configuração é por repo (front e back têm arquivos próprios); sem ela, `tm-delivery` para em vez de inventar. Não edite o `SKILL.md` no projeto.

## Referências externas

- [Claude Code — memória](https://code.claude.com/docs/en/memory)
- [Cursor — Skills](https://cursor.com/docs/skills)
- [Matt Pocock — Skills](https://www.aihero.dev/skills)
