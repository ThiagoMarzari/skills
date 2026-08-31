# Kit de práticas para IA

Repositório genérico com skills, prompts, regras e exemplos para trabalhar com agentes de IA no Cursor, Claude Code ou ferramentas compatíveis. Este kit não é um aplicativo: os arquivos devem ser copiados seletivamente e adaptados ao projeto de destino.

## Conteúdo

| Caminho | Conteúdo | Uso |
|---|---|---|
| `.agents/skills/` | Skills com instruções de processo | Copie a pasta para `.agents/skills/` no Cursor ou `.claude/skills/` no Claude Code |
| `.prompts/` | Prompts para tarefas específicas | Cole o conteúdo na conversa ou solicite o prompt explicitamente |
| `.cursor/rules/` | Regras permanentes | Copie as regras aplicáveis ao projeto de destino |
| `docs/exemplos/rules/` | Regras de exemplo por tecnologia | Copie somente quando a tecnologia corresponder |
| `docs/` | Exemplos de documentação e PRD | Use como modelo; substitua o conteúdo de domínio |
| `AGENTS.md` | Orientações para agentes | Adapte ao projeto de destino |
| `CLAUDE.md` | Orientações para Claude Code | Adapte ao projeto de destino |

## Como usar

1. Escolha uma skill ou prompt compatível com a tarefa.
2. Leia suas instruções antes de invocá-la.
3. Se o próximo passo não estiver claro, use `/ask-marzari`.
4. Invoque explicitamente a skill desejada, por exemplo `/questiona`, `/prd-generator`, `/plan-spec` ou `/code-review`.
5. Copie prompts de `.prompts/` somente quando a tarefa precisar deles.

## Fluxo recomendado

Para uma funcionalidade que ainda precisa de decisões:

`/questiona` → `/prd-generator` → `/plan-spec` → implementação → `/code-review` → `/documentation-writer`

Use apenas as etapas necessárias. Uma tarefa pequena e clara pode ir direto para implementação. O fluxo melhora a consistência, mas não substitui testes, verificações automáticas ou revisão humana.

## Onde copiar

Copie somente o que o projeto destino precisa:

```text
destino/.agents/skills/<nome-da-skill>/
destino/.claude/skills/<nome-da-skill>/
destino/.prompts/<nome>.md
destino/.cursor/rules/<nome>.mdc
```

Uma skill pode possuir arquivos de referência em seu próprio diretório. Ao copiá-la, leve também as referências indicadas pelo `SKILL.md`.

## Skills

| Skill | Quando usar |
|---|---|
| `/ask-marzari` | Escolher a skill ou o fluxo adequado |
| `/questiona` | Fechar escopo e decisões antes de implementar |
| `/prd-generator` | Criar um PRD e especificações funcionais |
| `/plan-spec` | Planejar ou implementar especificações pendentes |
| `/code-review` | Revisar qualidade estrutural e aderência à especificação |
| `/documentation-writer` | Atualizar documentação com base no código real |
| `/writing-for-agents` | Escrever ou melhorar documentos para agentes |
| `/rework-commits` | Organizar commits de uma branch para revisão |

## Prompts

- `.prompts/prd-generator.md`: briefing para levantar informações antes de um PRD.
- `.prompts/testes-automatizados.md`: decidir o que merece testes.
- `.prompts/tdd-com-agentes.md`: conduzir um ciclo de desenvolvimento orientado por testes.

Prompts não são carregados automaticamente. O usuário deve colá-los ou pedir seu uso.

## Convenções

- Escreva em português, salvo quando um termo técnico em outro idioma for mais preciso.
- Mantenha skills, prompts e regras portáteis e sem dependências ocultas.
- Trate `docs/` como material de exemplo, não como a descrição deste kit.
- Não invente stack, banco, autenticação, rotas ou funcionalidades de produto neste repositório.
- Skills com `disable-model-invocation: true` exigem invocação explícita.

## Referências externas

- [Cursor — Rules](https://cursor.com/docs/rules)
- [Cursor — Skills](https://cursor.com/docs/skills)
- [Claude Code — memória e CLAUDE.md](https://code.claude.com/docs/en/memory)
- [Claude Code — boas práticas](https://code.claude.com/docs/en/best-practices)
