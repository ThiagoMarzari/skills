---
name: documentation-writer
description: Compara documentação do projeto com o código e atualiza só o desatualizado. Use somente com /documentation-writer.
disable-model-invocation: true
---

# Atualizador de documentação

## Ativação e limites

Use somente com `/documentation-writer`.

**Arquivos alteráveis:**

- `README.md`
- `docs/project-overview.md` (máx. 90 linhas)
- `docs/architecture.md` (máx. 200 linhas)

Leia código; comandos só de consulta. Não altere código, deps, migrações nem outros arquivos.

## Objetivo

Alinhar docs ao que existe. Código é fonte da verdade.

## Etapa 1 — Estado real

Leia `README.md`, `AGENTS.md`, `CLAUDE.md`, rules, estrutura, deps, rotas, auth, dados, tipos centrais, commits recentes e os três documentos administrados.

Adapte à stack encontrada.

**Conclua quando:** documentado vs. implementado puder ser comparado com evidência.

## Etapa 2 — Divergências

Por documento: funcionalidade omitida ou inexistente, rotas/entidades renomeadas, tech/comandos errados, instruções que não funcionam, excesso de linhas.

Registre divergência + evidência no código.

**Conclua quando:** cada mudança proposta tiver causa verificável.

## Etapa 3 — Confirmação

Liste só docs que serão alterados e peça confirmação. Sem divergências → informe e pare.

## Etapa 4 — Atualizar

Após confirmação: mudanças identificadas, estilo preservado, links relativos, limites de linhas, sem opinião nem features futuras como existentes.

**Conclua quando:** divergências confirmadas corrigidas.

## Validação

- [ ] Só arquivos permitidos alterados
- [ ] Afirmações confirmáveis no código
- [ ] Limites de linhas respeitados

Informe arquivos atualizados e resumo curto.
