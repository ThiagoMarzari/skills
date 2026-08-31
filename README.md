# Kit de práticas para IA no dia a dia

Repositório genérico para **usar IA com as mesmas convenções do Cursor e do Claude Code**: regras, skills, prompts e exemplos de documentação. Nada aqui é um produto. Tudo foi pensado para **copiar para outro projeto** e começar a trabalhar.

## O que este kit contém

| Pasta / arquivo | O que é | Como reutilizar |
|-----------------|---------|-----------------|
| `.agents/skills/` | Mini-manuais invocáveis (`SKILL.md` + refs) | Copie a pasta da skill para `.agents/skills/` (Cursor) ou `.claude/skills/` (Claude Code) |
| `.cursor/rules/` | Rule geral (`projetos.mdc`) — qualquer stack | Copie para o destino; não amarra Next nem Nest |
| `docs/exemplos/rules/` | Rules de **exemplo** (hoje: Next.js) | Copie só se o destino for aquela stack; ligue `alwaysApply` ou `globs` lá |
| `.prompts/` | Prompts para colar na conversa | Copie o arquivo ou o texto; prompts **não** são carregados sozinhos |
| `docs/` | Exemplos de overview, arquitetura, design e PRD | Use como modelo; adapte, não copie o conteúdo de domínio |
| `AGENTS.md` | Instruções para agentes Cursor/Codex | Adapte ao projeto destino (stack, comandos, o que não fazer) |
| `CLAUDE.md` | Instruções para Claude Code | Idem; no destino, rode `/init` e complete o que faltar |

## Como usar neste repositório

1. Leia a skill ou o prompt **antes** de pedir a tarefa.
2. Invoque a skill pelo nome (`/questiona`, `/prd-generator`, `/plano-spec`, `/documentation-writer`, `/security-audit`).
3. Cole o prompt de `.prompts/` quando a tarefa for pontual (ex.: [briefing do PRD](.prompts/prd-generator.md), [decidir o que testar](.prompts/testes-automatizados.md) ou [TDD com agentes](.prompts/tdd-com-agentes.md)).
4. Trate `docs/` como **exemplo**, não como o produto deste repo.

## Como levar para outro projeto

Copie **só o que aquele projeto precisa**. Skills e prompts são independentes; rules e `AGENTS.md`/`CLAUDE.md` devem refletir a stack real do destino.

```text
# Skill (Cursor)
destino/.agents/skills/<nome-da-skill>/

# Skill (Claude Code)
destino/.claude/skills/<nome-da-skill>/

# Prompt
destino/.prompts/<nome>.md

# Rule geral (qualquer stack)
destino/.cursor/rules/projetos.mdc

# Rule de stack (só se o destino for Next, Nest, etc.)
destino/.cursor/rules/<regra-de-exemplo>.mdc
```

Cada skill deve continuar **autossuficiente**: o agente lê o `SKILL.md` e, se precisar, os arquivos em `refs/`. Não dependa de pastas deste kit existirem no projeto destino.

## Skills atuais

| Skill | Quando usar |
|-------|-------------|
| `questiona` | Fechar escopo e trade-offs **antes** de implementar |
| `prd-generator` | Gerar PRD/specs em `docs/prd/` |
| `plano-spec` | Plano (e, se pedir, código) da **próxima** spec pendente |
| `documentation-writer` | Atualizar overview, arquitetura e README a partir do código |
| `security-audit` | Auditar segurança (Next.js/React e ecossistema comum) |

## Convenções do kit

- **Português** na conversa e nos artefatos gerados, salvo trechos técnicos (OWASP, APIs).
- Uma preocupação por rule; skill com `SKILL.md` enxuto e detalhes em `refs/`.
- Skills com `disable-model-invocation` só rodam quando invocadas pelo nome.
- Este repositório **não** é um app: não invente stack, rotas, banco ou features de produto aqui.

## Referências

- [Cursor — Creating features (TDD com agentes)](https://cursor.com/learn/creating-features)
- [Cursor — Rules e AGENTS.md](https://cursor.com/docs/rules)
- [Cursor — Skills](https://cursor.com/docs/skills)
- [Claude Code — CLAUDE.md / memory](https://code.claude.com/docs/en/memory)
- [Claude Code — Best practices](https://code.claude.com/docs/en/best-practices)
