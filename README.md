# Kit de práticas para IA

Repositório genérico com skills, prompts, regras e exemplos para agentes no Cursor, Claude Code ou ferramentas compatíveis. **Não é um aplicativo** — copie seletivamente e adapte ao destino.

## Conteúdo

| Caminho | Conteúdo |
|---------|----------|
| `.agents/skills/` | Skills com processos executáveis, em buckets `engineering/` e `productivity/` |
| `.prompts/` | Prompts para tarefas específicas |
| `.cursor/rules/` | Regras permanentes |
| `docs/exemplos/rules/` | Rules de exemplo por tecnologia |
| `docs/exemplos/` | PRD, architecture, design — modelos apenas |
| `AGENTS.md` / `CLAUDE.md` | Orientação carregada com o projeto |

## Como usar

1. Escolha skill ou prompt compatível com a tarefa.
2. Invoque explicitamente skills user-invoked (`/nome`).
3. Se o próximo passo não estiver claro, use `/workflow-router`.
4. Copie prompts de `.prompts/` só quando a tarefa precisar.

## Fluxo recomendado

Repo destino ainda sem `docs/agents/`:

`/setup-skills`

Para uma mudança de produto com decisões em aberto:

`/scope-clarifier` → `/prd` → `/plan-spec` → implementação → `/preflight` (se aplicável) → `/code-review` → `/documentation-writer` (se necessário) → `/delivery` (se solicitado)

Mudança pequena e clara pode ir direto à implementação, verificações aplicáveis e `/code-review`. Use `/preflight` para mudanças com risco de comportamento, API, negócio, segurança, dados ou produção. Registre decisões arquiteturais duradouras com `/adr`.

Walkthrough completo (arquivos, posse, exemplo do início ao fim): **[Guia de workflow](docs/workflow-guide.md)**.

## Skills

| Comando | Quando usar |
|---------|-------------|
| `/setup-skills` | Configurar tracker, commits, provedor e destinos no repo destino |
| `/workflow-router` | Escolher skill ou fluxo |
| `/scope-clarifier` | Fechar escopo e decisões de produto |
| `/prd` | PRD e specs em `docs/prd/` |
| `/plan-spec` | Planejar ou implementar specs pendentes (`todas` / `implementa`) |
| `/preflight` | Verificar prontidão por risco e gerar checklist para PR/MR |
| `/adr` | Registrar decisão arquitetural confirmada em `docs/adr/` |
| `/code-review` | Revisar diff desde um ponto informado |
| `/documentation-writer` | Sincronizar docs com o código |
| `/writing-for-agents` | Escrever ou melhorar instruções para agentes |
| `/handoff` | Compactar a conversa num arquivo no temp para outro agente continuar |
| `/rework-commits` | Reorganizar commits da branch |
| `/delivery` | Entregar pela configuração do repo: GitHub ou GitLab |

### Migração de nomes

| Nome antigo | Nome atual |
|------------|------------|
| `/questiona` | `/scope-clarifier` |
| `/fecha-a-task` | `/delivery` |

Atualize as skills copiadas para os novos diretórios; não instale as versões antigas em paralelo.

`writing-for-agents` também pode ser alcançada pelo agente ao editar docs agent-facing, sem comando.

Neste kit as pastas vivem em `.agents/skills/engineering/<nome>/` e `.agents/skills/productivity/<nome>/`. Os buckets são só organização da origem.

## Prompts

| Arquivo | Uso |
|---------|-----|
| `.prompts/prd.md` | Briefing inicial antes de `/prd` |
| `.prompts/testes-automatizados.md` | Decidir o que merece teste |

Prompts não são auto-carregados.

## Onde copiar no destino

Os buckets **não** se replicam no destino. Extraia cada skill isoladamente:

```text
destino/.agents/skills/<nome-da-skill>/
destino/.claude/skills/<nome-da-skill>/
destino/.prompts/<nome>.md
destino/.cursor/rules/<nome>.mdc
```

Leve referências indicadas pelo `SKILL.md` da skill copiada. `scope-clarifier` e `prd` também precisam de `.agents/skills/engineering/references/entrevista.md` → `destino/.agents/skills/references/entrevista.md` (o apontador relativo `../references/entrevista.md` continua válido).

Depois de copiar as skills de engenharia, rode `/setup-skills` uma vez no destino. Ele grava `docs/agents/` (tracker, commits e, se `/delivery` estiver no destino, provedor e destinos). Não edite o `SKILL.md` no projeto.

## Convenções

- Português nos artefatos; termos técnicos quando precisos.
- Portabilidade e autossuficiência; sem dependências ocultas.
- `docs/exemplos/` é modelo, não descrição deste kit.
- Skills user-invoked exigem invocação explícita.

## Referências externas

- [Cursor — Rules](https://cursor.com/docs/rules)
- [Cursor — Skills](https://cursor.com/docs/skills)
- [Claude Code — memória](https://code.claude.com/docs/en/memory)
- [Matt Pocock — Skills](https://www.aihero.dev/skills)
