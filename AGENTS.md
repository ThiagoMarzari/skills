# Instruções para agentes

Kit reutilizável de skills e prompts — **não é um aplicativo**. Copie seletivamente para o projeto destino e adapte. Catálogo, fluxo e onde copiar: `README.md` (consulte sob demanda).

## Mapa

- Skills: `.agents/skills/engineering/<nome>/` e `.agents/skills/productivity/<nome>/`. No destino, cada skill vai para `.claude/skills/<nome>/` ou `.agents/skills/<nome>/`; os buckets não vão junto.
- Prompts: `.prompts/` — colados ou pedidos explicitamente.
- Terceiros: listados em `skills-lock.json` e instalados com `npx skills add`; os arquivos ficam só na máquina (`.agents/skills/` fora dos buckets está no `.gitignore`). Não são do kit: não edite nem aplique as regras abaixo a elas.
- `install.sh`: instala as skills do kit e as do lock num projeto destino.

## Regras de trabalho

- Portabilidade: cada artefato funciona copiado sozinho.
- Não invente stack, rotas, banco, auth ou features de produto neste repositório.
- Português na conversa e nos artefatos; termos técnicos no idioma original quando evitar ambiguidade.
- Altere só o que a tarefa exige. Plan mode para mudanças que tocam vários arquivos.
- Não crie commits nem altere Git sem pedido explícito.

## Commits

- Português, assunto curto no presente, 3ª pessoa, sem prefixo de tipo: `Adiciona …`, `Reescreve …`, `Remove …`.
- Corpo explicando o que mudou e por quê, quando o assunto não basta.
- Sem trailer de IA: nada de `Co-Authored-By`, `Generated with`, 🤖 ou link de sessão.

## Skills

Todas são user-invoked (`disable-model-invocation: true`): `/tm-setup-skills`, `/tm-workflow-router`, `/tm-prd`, `/tm-plan-spec`, `/tm-preflight`, `/tm-code-review`, `/tm-delivery`, `/tm-handoff`. Não deduza uma skill a partir de pedido parecido. Próximo passo incerto → `/tm-workflow-router`. Repo destino sem `docs/agents/` → `/tm-setup-skills`.

## Alterar artefatos

- **Skill**: `SKILL.md` com `name`, `description` e `disable-model-invocation: true`; corpo curto; detalhes em `references/` na mesma pasta.
- **Nome**: prefixo `tm-` em toda skill do kit; pasta com o mesmo nome do campo `name`.
- **Prompt**: um arquivo em `.prompts/`, uma tarefa, sem depender deste kit.
- Ao adicionar, remover ou renomear skill, atualize `README.md`, este arquivo e `tm-workflow-router`.
