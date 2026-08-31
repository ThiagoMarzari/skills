---
name: pergunte-marzari
description: Roteia para a skill, prompt ou sequência certa neste kit. Use com /pergunte-marzari quando não souber por onde começar, entre duas skills parecidas, ou no limite de fase de uma sessão longa.
disable-model-invocation: true
---

# Pergunte ao Marzari

Router sobre as skills e prompts **deste kit**. Você descreve a situação; o agente devolve o **fluxo**, onde **você** decide, e o próximo comando.

**Recomende e pare.** Não invoque a skill citada, não escreva código, não gere PRD/plano, não abra arquivos para trabalhar.

## Ativação

Só `/pergunte-marzari`. Se você já sabe a skill, invoque ela direto — o router não acrescenta nada.

## Como responder

1. Reconheça a situação em 1–2 frases.
2. Nomeie o **fluxo** (caminho *através* das skills), não só uma keyword.
3. Sequência de comandos, com ramos onde couber.
4. Onde o humano precisa **decidir** ou **revisar** (não só "rode X").
5. Sessão longa? Indique limite de fase (tabela abaixo).
6. Última linha: **o que digitar agora** — e pare.

Afirmou algo load-bearing sobre outra skill? **Leia o `SKILL.md` dela** antes de recomendar. Se o router e o `SKILL.md` divergirem, o `SKILL.md` manda.

Skills com `disable-model-invocation` **existem** — o harness pode não listá-las. Diga para digitar o `/comando` mesmo assim.

## Fluxo principal — ideia até entregar

Cabe em **um chat**, sem specs nem dependências cruzadas → pule PRD: `/questiona` curto (ou direto ao Agent). Não force `/prd-generator`.

| Passo | Situação | Próximo |
|-------|----------|---------|
| 1 | Ideia vaga, trade-offs abertos, não sabe *o quê* | `/questiona` |
| 2 | Escopo fechado; falta documentar *comportamento* | `/prd-generator` (briefing opcional: `.prompts/prd-generator.md`) |
| 3 | PRD em `docs/prd/`, specs com Status | Chat novo → `/plan-spec` |
| 4 | Quer codar sem plano no painel | `/plan-spec implementa` |
| 5 | Poucas specs, um chat só | `/plan-spec todas` (ou `todas implementa`) |
| 6 | Implementando regra/negócio | Durante codar: `.prompts/tdd-com-agentes.md` |
| 7 | Antes de escrever testes | `.prompts/testes-automatizados.md` |
| 8 | Feature pronta, docs desatualizados | `/documentation-writer` |
| 10 | Branch com commit único ou histórico confuso | `/rework-commits` |

**Human decisions neste fluxo:** após `/questiona` (escopo fechado?); após PRD (revisar specs); após cada plano (`/plan-spec` — aprovar antes de `implementa`); após implementação (marcar spec **Implementada** no PRD).

**Ordem típica:** `/questiona` → `/prd-generator` → (chat novo) `/plan-spec` → implementar → marcar spec → repetir `/plan-spec` até acabar → `/documentation-writer`.

## Entradas laterais (fora do fluxo principal)

| Situação | Rota | Por que não o fluxo principal |
|----------|------|-------------------------------|
| README, overview ou arquitetura errados | `/documentation-writer` | Código já existe; falta sincronizar doc |
| Reorganizar commits da branch | `/rework-commits` | Git, não produto |

## Skills parecidas — um teste cada

| Dúvida | Escolha | Teste |
|--------|---------|-------|
| `/questiona` ou `/prd-generator`? | Ainda não sabe *o quê* construir | → `/questiona`. Já sabe o quê, falta comportamento escrito | → `/prd-generator` |
| `/plan-spec` ou Agent livre? | Existe PRD com Status nas specs | → `/plan-spec`. Não existe PRD | → Agent (ou `/questiona` se vago) |
| `plan-spec` ou `plan-spec implementa`? | Quer revisar plano antes | → só `/plan-spec`. Confia no recorte e quer código | → `implementa` |
| Prompt TDD ou skill? | Decidir *o que* testar | → `.prompts/testes-automatizados.md`. Ciclo red-green na implementação | → `.prompts/tdd-com-agentes.md` |

## Prompts (não são skills)

Colar de `.prompts/` — o agente **não** carrega sozinho:

- `prd-generator.md` — briefing antes do PRD
- `testes-automatizados.md` — o que merece teste
- `tdd-com-agentes.md` — TDD durante implementação

## Limite de fase (sessão longa)

Só entre fases. No meio da implementação: continue ou subagent — não re-roteie.

| Opção | Quando |
|-------|--------|
| **Continuar** | Próxima fase usa este contexto; ainda há margem útil |
| **Chat novo** | Spec/PRD pronta; mudou de spec; contexto poluído com tentativas descartadas |
| **Compact** | Nenhuma acima se encaixa; precisa resumir e seguir no mesmo chat |

Padrão após spec implementada: **chat novo** + `/plan-spec`.

## O que NÃO fazer

- Não executar a skill recomendada
- Não gerar PRD, plano técnico nem código
- Não inventar skills fora deste kit
- Não substituir uma skill que o usuário já escolheu
