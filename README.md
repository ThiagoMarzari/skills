# Kit de práticas para IA

Repositório genérico com skills, prompts, regras e exemplos para agentes no Cursor, Claude Code ou ferramentas compatíveis. **Não é um aplicativo** — copie seletivamente e adapte ao destino.

## Conteúdo

| Caminho | Conteúdo |
|---------|----------|
| `.agents/skills/` | Skills com processos executáveis |
| `.prompts/` | Prompts para tarefas específicas |
| `.cursor/rules/` | Regras permanentes |
| `docs/exemplos/rules/` | Rules de exemplo por tecnologia |
| `docs/exemplos/` | PRD, architecture, design — modelos apenas |
| `AGENTS.md` / `CLAUDE.md` | Orientação carregada com o projeto |

## Como usar

1. Escolha skill ou prompt compatível com a tarefa.
2. Invoque explicitamente skills user-invoked (`/nome`).
3. Se o próximo passo não estiver claro, use `/ask-marzari`.
4. Copie prompts de `.prompts/` só quando a tarefa precisar.

## Fluxo recomendado

Para funcionalidade que ainda precisa de decisões:

`/questiona` → `/prd-generator` → `/plan-spec` → implementação → `/code-review` → `/documentation-writer`

Use só as etapas necessárias. Tarefa pequena e clara pode ir direto à implementação.

## Skills

| Comando | Quando usar |
|---------|-------------|
| `/ask-marzari` | Escolher skill ou fluxo |
| `/questiona` | Fechar escopo e decisões |
| `/prd-generator` | PRD e specs em `docs/prd/` |
| `/plan-spec` | Planejar ou implementar specs pendentes (`todas` / `implementa`) |
| `/code-review` | Revisar diff desde um ponto informado |
| `/documentation-writer` | Sincronizar docs com o código |
| `/writing-for-agents` | Escrever ou melhorar instruções para agentes |
| `/rework-commits` | Reorganizar commits da branch |

`writing-for-agents` também pode ser alcançada pelo agente ao editar docs agent-facing, sem comando.

## Prompts

| Arquivo | Uso |
|---------|-----|
| `.prompts/prd-generator.md` | Briefing inicial antes de `/prd-generator` |
| `.prompts/testes-automatizados.md` | Decidir o que merece teste |
| `.prompts/tdd-com-agentes.md` | Ciclo red-green-refactor com agente |

Prompts não são auto-carregados.

## Onde copiar no destino

```text
destino/.agents/skills/<nome-da-skill>/
destino/.claude/skills/<nome-da-skill>/
destino/.prompts/<nome>.md
destino/.cursor/rules/<nome>.mdc
```

Leve referências indicadas pelo `SKILL.md` da skill copiada.

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
