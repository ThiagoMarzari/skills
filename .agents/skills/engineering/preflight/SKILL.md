---
name: preflight
description: Avalia a prontidão de uma mudança conforme seu risco e gera um checklist para PR/MR. Use com /preflight.
disable-model-invocation: true
---

# Preflight

## Ativação e limites

Use somente com `/preflight`, depois da implementação e antes do review/entrega.

Leia o pedido, diff, instruções, testes e configuração do projeto. Não altere arquivos, não instale dependências, não faça commit/push, não abra PR/MR e não faça deploy.

## Avaliar risco

- **Baixo:** mudança isolada sem alteração de comportamento, API, regra de negócio, segurança, dados ou produção. Verifique apenas testes/lint pertinentes ao diff.
- **Relevante:** mudança de comportamento, API, regras de negócio, integração, dependência ou CI. Inclua testes aplicáveis, compatibilidade e CI.
- **Alto:** auth/permissões, privacidade, dados sensíveis, migração ou exclusão de dados, pagamentos, segredo, operação/deploy em produção. Inclua controles de segurança, reversibilidade/rollback, monitoramento e validação operacional pertinentes.

Não transforme itens irrelevantes em bloqueios. Marque cada verificação como **OK**, **Pendente**, **Bloqueado** ou **N/A**, com evidência curta. Rode verificações locais apropriadas quando seguras; não alegue que CI, staging ou produção foram validados sem evidência.

Se houver decisão arquitetural duradoura ainda aberta, recomende `/adr`; não invente nem registre a decisão.

## Saída

Entregue: nível e motivo do risco; verificações aplicáveis com status/evidência; pendências e bloqueios; checklist conciso pronto para colar no PR/MR. No modo manual, o checklist continua sendo a saída. Não crie arquivo ou altere descrição remota.

**Conclua quando:** cada verificação aplicável tiver status e evidência ou bloqueio explícito.
