# Instruções para agentes (Cursor / Codex)

Este repositório é um **kit reutilizável de práticas de IA**, não um aplicativo. Skills, prompts, rules e docs de exemplo existem para serem copiados para outros projetos.

## Como navegar

- Visão humana: `README.md`
- Skills: `.agents/skills/<nome>/SKILL.md` (Cursor também lê `.cursor/skills/` e `.claude/skills/`)
- Prompts: `.prompts/` — só valem quando o usuário cola ou pede para usar
- Rule geral (sempre): `.cursor/rules/projetos.mdc` — vale para qualquer stack
- Rules de exemplo (Next.js, **não** aplicar neste kit): `docs/exemplos/rules/`
- Exemplos de documentação de produto: `docs/` (domínio de amostra, não o produto deste kit)

## Regras de trabalho neste repo

- Preserve **portabilidade**: cada skill, prompt ou rule deve funcionar copiada sozinha para outro projeto.
- Não invente stack, rotas, banco, auth ou features de produto aqui.
- Não misture o conteúdo de exemplo em `docs/` com a identidade deste kit.
- Não edite uma skill/prompt/rule “para o projeto X”; extraia o que for específico para o destino, não para este repo.
- Responda em **português**, salvo termos técnicos.

## Skills (invocar pelo nome)

| Comando | Função |
|---------|--------|
| `/pergunte-marzari` | Router — qual skill ou fluxo usar |
| `/questiona` | Fechar decisões antes de implementar |
| `/prd-generator` | PRD e specs em `docs/prd/` |
| `/plan-spec` | Plano da próxima spec pendente (`todas` / `implementa` se pedir) |
| `/documentation-writer` | Sincronizar docs com o que existe de fato |

Skills com `disable-model-invocation` **não** devem ser inferidas. Sem o comando, não execute o fluxo delas.

## Ao criar ou alterar artefatos

- Skill: pasta própria, `SKILL.md` com `name` + `description` (o quê e quando), corpo < 500 linhas, detalhes em `refs/`.
- Prompt: um arquivo em `.prompts/`, focado numa tarefa, sem depender deste repo.
- Rule: uma preocupação, curta, com exemplos concretos.
- Doc de exemplo: genérica o bastante para servir de modelo; nada de acoplar a um produto específico deste kit.
