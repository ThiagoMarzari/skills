# Instruções para agentes

Kit reutilizável de skills e prompts — **não é um aplicativo**. Copie seletivamente para o projeto destino e adapte. Catálogo, fluxo e onde copiar: `README.md` (consulte sob demanda).

## Mapa

- Skills: `.agents/skills/engineering/<nome>/` e `.agents/skills/productivity/<nome>/`. No destino, cada skill vai para `.claude/skills/<nome>/` ou `.agents/skills/<nome>/`; os buckets não vão junto.
- Prompts: `.prompts/` — colados ou pedidos explicitamente.
- Terceiros: `.agents/skills/third-party/<nome>/` — skills de outros autores, instaladas com `npx skills add` (ver `skills-lock.json`) e ligadas em `.claude/skills/`. Não são do kit: não edite nem aplique as regras abaixo a elas.

## Regras de trabalho

- Portabilidade: cada artefato funciona copiado sozinho.
- Não invente stack, rotas, banco, auth ou features de produto neste repositório.
- Português na conversa e nos artefatos; termos técnicos no idioma original quando evitar ambiguidade.
- Altere só o que a tarefa exige. Plan mode para mudanças que tocam vários arquivos.
- Não crie commits nem altere Git sem pedido explícito.

## Skills

Todas são user-invoked (`disable-model-invocation: true`): `/tm-setup-skills`, `/tm-workflow-router`, `/tm-prd`, `/tm-plan-spec`, `/tm-preflight`, `/tm-code-review`, `/tm-delivery`, `/tm-handoff`. Não deduza uma skill a partir de pedido parecido. Próximo passo incerto → `/tm-workflow-router`. Repo destino sem `docs/agents/` → `/tm-setup-skills`.

## Alterar artefatos

- **Skill**: `SKILL.md` com `name`, `description` e `disable-model-invocation: true`; corpo curto; detalhes em `references/` na mesma pasta.
- **Nome**: prefixo `tm-` em toda skill do kit; pasta com o mesmo nome do campo `name`.
- **Prompt**: um arquivo em `.prompts/`, uma tarefa, sem depender deste kit.
- Ao adicionar, remover ou renomear skill, atualize `README.md`, este arquivo e `tm-workflow-router`.
