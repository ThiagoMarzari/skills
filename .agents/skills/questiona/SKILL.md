---
name: questiona
description: "Interrogue incansavelmente o usuário sobre cada aspecto de uma ideia ou plano até entendimento compartilhado — árvore de decisão, ângulos e trade-offs no projeto atual. Invocável APENAS com 'questiona' ou /questiona."
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

Antes da 1ª pergunta, explore codebase e docs (`docs/`, PRDs): stack, convenções, módulos relacionados, padrões a seguir ou quebrar. Resuma em 3–5 bullets o que impacta a ideia.

### 2. Árvore de decisões

Mapeie: escopo, usuário/fluxo, dados/permissões, UX/erros, integrações, impacto no código, edge cases. Priorize ramos **bloqueantes**.

### 3. Questionar (regra central)

**Uma pergunta por mensagem.** Não pare no "parece ok" — cubra todos os ramos críticos ou até o usuário encerrar.

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

Entregue resumo com: **Decisões fechadas**, **Trade-offs aceitos**, **Fora de escopo**, **Próximo passo** pergunte se deseja usar (`/prd-generator` se escopo grande, implementação se pequeno). Pergunte: _"Fechamos ou ainda tem ramo aberto?"_

## Princípios

- **Incansável** — ambiguidade restante = falha
- **Acordo explícito** — fechar decisões, não "mais ou menos"
- **Projeto primeiro** — recomendações ancoradas no repo, não greenfield
- **Codebase > suposição** — nunca pergunte o que já está no código
- **YAGNI** — desafie nice-to-have que infla escopo
- **Sem implementação** — termina em clareza
- **Nunca apenas concorde e sim analise o questionamento, alternativas

## Evitar

- Perguntar o que já está no código/docs
- Aceitar “tanto faz” sem recomendação
- Pular para solução técnica antes de fechar comportamento/escopo
- Invocar outras skills sozinho — só **sugerir** `/prd-generator`
