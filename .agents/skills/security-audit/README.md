# security-audit

Auditoria de segurança para **React**, **Next.js**, **TypeScript** e ecossistema comum (Auth.js, Prisma, Stripe, Zod). Cada execução usa as versões **instaladas** no projeto auditado (`package.json` + lockfile).

Relatórios em **português**. Patches são **proposta** — nada é aplicado sozinho.

Esta pasta é uma skill **portátil**: copie-a para o app que vai auditar.

---

## Instalação

```text
# Cursor (projeto ou este kit)
destino/.agents/skills/security-audit/

# Claude Code
destino/.claude/skills/security-audit/

# Pessoal (todos os projetos Cursor)
~/.cursor/skills/security-audit/
```

Leve `SKILL.md` **e** `refs/`. Abra o **app auditado** no editor, não só este kit.

O Cursor também descobre `.agents/skills/` neste repositório; para auditar outro código, a skill precisa estar no workspace desse código (ou em `~/.cursor/skills/`).

---

## Quando usar

**Automática** — o agente pode puxar a skill se o pedido falar em segurança, XSS, IDOR, Server Actions, secrets, etc. (não há `disable-model-invocation`).

**Manual (auditoria completa):**

```text
/security-audit
/security-audit src/app/api
Usa a skill security-audit neste repositório. Relatório em português.
```

`/security-audit` é convenção de prompt, não comando nativo do Cursor.

---

## O que a skill faz

| Etapa | Conteúdo |
|-------|----------|
| 1 | Escopo + stack real (`npm ls`, lockfile, App Router vs Pages) |
| 2 | `npm audit --omit=dev` |
| 3 | Segredos (`.env` tracked, chaves, CI/CD) |
| 4–5 | Código: injeção, auth/IDOR, webhooks, uploads, fluxo |
| 6 | Falsos positivos |
| 7 | Relatório |
| 8 | Patches só para **CRITICAL** e **HIGH** |

**Não cobre** por padrão: Python, Java, Go (salvo pedido explícito).

Pré-requisito: Node + lockfile no projeto auditado.

---

## Next.js: `middleware` vs `proxy`

| Next | Borda |
|------|--------|
| **&lt; 16** | `middleware.ts` |
| **≥ 16** | `proxy.ts` |

Não reportar “falta `middleware.ts`” em Next 16+ sem procurar `proxy.ts`. Detalhe: `refs/proxy-middleware.md`.

---

## Entrega

1. Tabela resumo (CRITICAL → INFO)
2. Achados por categoria
3. Stack do lockfile
4. `npm audit` + segredos
5. Falsos positivos descartados
6. Patches CRITICAL/HIGH com aviso para revisar

Formato: `refs/report.md`. Anti-ruído: `refs/false-positives.md`.

---

## Manutenção

1. Frontmatter `name` + `description` alinhados aos gatilhos
2. Não renomeie `refs/` sem atualizar o `SKILL.md`
3. Teste num app real e confira se o relatório cita **versões do lockfile**
