# Princípios de escrita para agentes

Consulte quando tiver dúvida sobre **por que** uma regra do fluxo principal existe. Não é necessário para uso normal da skill.

## As duas cargas

| Carga | O que é | Quando minimizar |
|-------|---------|------------------|
| **Contexto** | Material sempre no contexto do agente | Tudo que não aplica em quase todo turno |
| **Cognitiva** | O humano lembra que o documento existe | Onde o julgamento humano importa (gates, escolha de workflow) |

Material só via apontador paga a linha do apontador + busca sob demanda. Material sem apontador paga só carga cognitiva — e costuma ser esquecido.

## Hierarquia da informação

1. **Passo no arquivo** — ação em ordem; o que todo fluxo precisa.
2. **Referência no arquivo** — definição consultada sob demanda, ainda no mesmo arquivo.
3. **Referência externa** — arquivo separado, alcançado por apontador com gatilho explícito.

**Progressive disclosure** é descer na escada para manter o topo legível. Teste: o que todo ramo precisa fica inline; o que só alguns ramos alcançam vai para referência.

**Co-localização**: definição, regras e ressalvas de um conceito sob o mesmo título — não espalhadas pelo documento.

**Sprawl**: documento longo demais mesmo sem duplicação. Cura: descer na escada ou dividir por ramo/sequência.

## Critério de conclusão

- **Clareza**: dá para distinguir concluído de incompleto? Critério vago convida a **conclusão prematura**.
- **Exigência**: "todo item verificado" força mais trabalho que "produza uma lista".

O critério mora na etapa. Recap de checkbox no fim do documento é duplicata — não adicionar.

Afie o critério antes de esconder passos seguintes (só funciona com fronteira real de contexto, ex. subagente).

## Palavras-âncora

Conceito compacto do pré-treinamento (`tight`, _tracer bullet_) que ancora comportamento com poucos tokens. Prefira palavra existente a inventar termo novo.

**Negação** traz o proibido para o contexto. Prefira afirmar o alvo: "valide antes de persistir", não "não persista sem validar".

## Poda

- **Fonte única**: um significado, um lugar.
- **Ambiente como fonte**: não repita o que `package.json`, config ou `--help` já respondem.
- **Relevância**: toda linha deve ainda influenciar comportamento.
- **No-op**: "isso muda o que o agente faz vs. o padrão?" — resolva rodando o documento, não debatendo.

## Quando dividir por sequência

Separe quando passos posteriores visíveis fazem o agente apressar o passo atual. Manter sequências separadas fora de vista aumenta o trabalho no passo em curso. Cuidado com o inverso: juntar sequências expõe passos futuros e convida conclusão prematura.
