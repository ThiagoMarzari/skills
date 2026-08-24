# Instruções para o Claude Code

Este repositório é um **kit reutilizável de práticas de IA**, não um aplicativo. Skills, prompts, rules e docs de exemplo existem para serem copiados para outros projetos.

See @README.md

## Onde estão as coisas

- Skills deste kit: `.agents/skills/<nome>/SKILL.md`
- No **projeto destino**, coloque skills em `.claude/skills/` (descoberta nativa). Cursor também lê `.agents/skills/`.
- Prompts: `.prompts/` — não são auto-carregados; o usuário cola ou pede para usar.
- Rules de exemplo (Cursor): `.cursor/rules/` — **não** interprete este repo como app Next.js.
- Exemplos de doc de produto: `docs/` (amostra, não o produto deste kit).

## Como trabalhar aqui

- Mantenha cada artefato **portátil**: uma skill/prompt/rule deve funcionar copiada sozinha.
- Não invente stack, rotas, banco, auth ou features de produto neste repo.
- Não trate `docs/` como a identidade do kit.
- Não especializine um artefato “para o projeto X” aqui; isso pertence ao destino.
- Português na conversa e nos artefatos, salvo termos técnicos.

## Skills (só com o comando)

| Comando | Função |
|---------|--------|
| `/questiona` | Fechar decisões antes de implementar |
| `/prd-generator` | PRD e specs em `docs/prd/` |
| `/documentation-writer` | Sincronizar docs com o que existe de fato |
| `/security-audit` | Auditoria de segurança no projeto alvo |

Não infira skills com `disable-model-invocation`. Sem o comando, não rode o fluxo.

## Hábitos

- Plan mode para mudanças que tocam vários arquivos.
- Diff é revisão, não formalidade.
- CLAUDE.md é cheat sheet: mantenha curto; detalhes ficam nas skills.

## Ao criar ou alterar artefatos

- Skill: pasta + `SKILL.md` (`name`, `description` com o quê e quando), corpo enxuto, refs em arquivos irmãos.
- Prompt: um arquivo, uma tarefa, zero dependência deste kit.
- Rule: uma preocupação, curta, com exemplo.
- Doc de exemplo: modelo, não domínio acoplado a este repositório.
