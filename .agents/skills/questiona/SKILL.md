---
name: questiona
description: Interroga o usuário uma pergunta por vez até fechar escopo, trade-offs e regras no projeto atual. Use apenas com questiona ou /questiona — nunca inferir de um pedido de implementação.
disable-model-invocation: true
---

# Questiona

Interrogue o usuário até **entendimento compartilhado** — acordo explícito entre dev e IA. Percorra a árvore de decisão **um ramo por vez**. Em cada pergunta, dê **Recomendação** com justificativa no repo atual.

**Uma pergunta por mensagem.** Se a resposta estiver no código ou nas docs, **explore** em vez de perguntar.

<HARD-GATE>
Não escreva código, não crie arquivos, não proponha implementação até o usuário encerrar o modo ou confirmar entendimento fechado.
</HARD-GATE>

## Ativação

Somente **questiona** ou **/questiona**. Não inferir de ideia vaga nem de “implementa X”.

## Objetivo

Fechar cada ângulo aberto (escopo, comportamento, trade-offs, impacto no código) com base no que o projeto **já tem**. Não avance de ramo enquanto o atual estiver vago ou contraditório.

## Fluxo

### 1. Ancorar no projeto

Antes da 1ª pergunta, leia codebase e docs (`docs/`, PRDs): stack, convenções, módulos relacionados. Resuma em 3–5 bullets o que impacta a ideia.

### 2. Árvore de decisões

Mapeie: escopo, usuário/fluxo, dados/permissões, UX/erros, integrações, impacto no código, edge cases. Priorize ramos **bloqueantes**.

### 3. Questionar

Não pare no “parece ok”. Cubra os ramos críticos ou até o usuário encerrar.

Formato de cada pergunta:

1. 1 frase: por que importa _neste projeto_
2. Pergunta (preferir múltipla escolha)
3. **Recomendação:** opção + motivo no contexto do repo

Ao responder:

- Vago → refine o mesmo ramo
- Novo ramo → fila; não pule dependências
- Contradição → aponte e peça resolução
- A cada 3–5 decisões → confronte o trade-off vs a alternativa descartada

### 4. Fechamento

Resumo: **Decisões fechadas**, **Trade-offs aceitos**, **Fora de escopo**, **Próximo passo**. Sugira `/prd-generator` se o escopo for grande; implementação se for pequeno. Pergunte: _"Fechamos ou ainda tem ramo aberto?"_

## Princípios

- Ambiguidade restante = falha
- Fechar decisões, não “mais ou menos”
- Recomendações ancoradas no repo, não greenfield
- YAGNI — desafie nice-to-have
- Nunca só concorde: analise alternativas

## Evitar

- Perguntar o que já está no código/docs
- Aceitar “tanto faz” sem recomendação
- Pular para solução técnica antes de fechar comportamento/escopo
- Invocar outras skills sozinho — só **sugerir** `/prd-generator`
