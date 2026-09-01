# Instruções para o Claude Code

Kit reutilizável de práticas de IA — **não é um aplicativo**. Skills, prompts, rules e exemplos existem para serem copiados ao projeto destino.

See @README.md

## Onde estão as coisas

- Skills: `.agents/skills/engineering/<nome>/` e `.agents/skills/productivity/<nome>/` (no destino, extraia para `.claude/skills/<nome>/` — buckets não vão junto)
- Prompts: `.prompts/` — não auto-carregados
- Rule geral: `.cursor/rules/projetos.mdc`
- Exemplos Next.js: `docs/exemplos/rules/` — **não** aplicar neste kit
- Exemplos de produto: `docs/exemplos/` — amostra, não identidade do kit

## Como trabalhar aqui

- Artefato **portátil**: funciona copiado sozinho.
- Não invente stack, rotas, banco ou auth neste repo.
- Português na conversa e nos artefatos, salvo termos técnicos.
- `CLAUDE.md` é cheat sheet curto; detalhes ficam nas skills e no `README.md`.

## Skills

- **User-invoked** (`disable-model-invocation: true`): só com comando explícito — `/setup-skills`, `/questiona`, `/prd-generator`, `/plan-spec`, etc.
- **Model-invoked**: `writing-for-agents` — alcançável ao editar docs para agentes.

Não infira skills user-invoked sem o comando. Próximo passo incerto → `/ask-marzari`. Repo destino sem config → `/setup-skills`.

## Hábitos

- Plan mode para mudanças que tocam vários arquivos.
- Diff é revisão, não formalidade.

## Ao criar ou alterar artefatos

Siga `writing-for-agents` e, se for skill, `SKILL-MECHANICS.md` na mesma pasta.
