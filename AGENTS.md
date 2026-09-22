# Instruções para agentes

Kit reutilizável de skills, prompts, regras e exemplos — **não é um aplicativo**. Copie seletivamente para o projeto destino e adapte.

## Mapa

| Caminho | Uso |
|---------|-----|
| `README.md` | Índice humano: skills, fluxos, prompts |
| `docs/workflow-guide.md` | Walkthrough do fluxo: arquivos, posse, exemplo do início ao fim |
| `.agents/skills/engineering/<nome>/` | Skills de fluxo de produto e código |
| `.agents/skills/productivity/<nome>/` | Skills de escrita para agentes e handoff entre sessões |
| `.prompts/` | Prompts colados ou solicitados explicitamente |
| `docs/exemplos/` | Modelos de PRD, rules e docs — não é o produto deste kit |

No destino, copie cada skill para `.agents/skills/<nome>/` (Claude Code: `.claude/skills/<nome>/`). Os buckets ficam só nesta origem.

## Regras de trabalho

- Portabilidade: cada artefato deve funcionar copiado sozinho.
- Não invente stack, rotas, banco, auth ou features de produto neste repositório.
- Não misture domínio de `docs/exemplos/` com a identidade do kit.
- Escreva em português; termos técnicos no idioma original quando evitar ambiguidade.
- Altere só o que a tarefa exige.

## Invocação de skills

- Skills com `disable-model-invocation: true` só rodam quando o usuário digitar o comando (`/nome`).
- `writing-for-agents` é model-invoked: o agente pode alcançá-la ao criar ou revisar documentos agent-facing.
- Repo destino sem `docs/agents/` → `/setup-skills` antes de `/code-review`, `/rework-commits` e `/delivery`.
- Não deduza uma skill user-invoked a partir de pedido parecido — use `/workflow-router` se o próximo passo não estiver claro.

## Alterar artefatos

- **Skill**: `SKILL.md` com `name`, `description`, corpo com menos de 500 linhas; detalhes em referências na mesma pasta.
- **Prompt**: um arquivo em `.prompts/`, uma tarefa, sem depender deste kit.
- **Rule**: uma preocupação por arquivo.
- Não crie commits nem altere Git sem pedido explícito.

Para catálogo de skills, veja `README.md`. Para o walkthrough do fluxo, veja `docs/workflow-guide.md`.
