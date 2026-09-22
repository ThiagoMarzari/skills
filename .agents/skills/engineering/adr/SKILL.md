---
name: adr
description: Registra uma decisão arquitetural duradoura confirmada pelo usuário em docs/adr/. Use com /adr.
disable-model-invocation: true
---

# Architecture Decision Record

## Ativação e limites

Use somente com `/adr` ou pedido explícito para registrar uma decisão arquitetural.

Use para escolhas duradouras com trade-offs relevantes de arquitetura, dados, segurança, integrações ou operação. Não use para decisões rotineiras, detalhes locais de implementação ou requisitos de produto que pertencem ao PRD.

Leia a decisão e o contexto técnico relevante. Se a decisão ainda estiver aberta ou houver alternativas materiais sem escolha, apresente opções e recomendação; não grave até o usuário confirmar a decisão. Altere somente o novo ADR em `docs/adr/`.

## Criar o ADR

1. Liste os ADRs existentes e escolha o próximo número sequencial de quatro dígitos.
2. Crie `docs/adr/NNNN-<slug>.md`; nunca sobrescreva um ADR existente.
3. Registre status (`Aceita`), contexto, decisão, alternativas consideradas e consequências. Seja conciso e referencie documentos existentes em vez de duplicá-los.

**Conclua quando:** o arquivo registrar a decisão confirmada, alternativas relevantes e consequências, com número único.

## Entrega

Informe caminho e decisão registrada. Se faltou confirmação, entregue a recomendação sem alterar arquivos.
