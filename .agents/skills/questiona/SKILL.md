---
name: questiona
description: Interroga o usuário para fechar escopo, comportamento, decisões e trade-offs antes da implementação. Use somente com /questiona ou quando o usuário pedir explicitamente este processo.
disable-model-invocation: true
---

# Questiona

## Objetivo

Transforme uma ideia vaga em entendimento compartilhado: o usuário e o agente concordam sobre o que será feito, para quem, como deverá se comportar e o que ficará de fora.

## Limites

Durante esta skill:

- não escreva código;
- não crie nem altere arquivos;
- não implemente a solução;
- não invoque outra skill automaticamente;
- use o código e a documentação somente para responder perguntas que já tenham resposta no projeto.

Ao terminar, recomende o próximo passo, mas aguarde o usuário decidir.

## Etapa 1 — Ancorar no projeto

Antes da primeira pergunta, leia o contexto relevante:

1. documentação e instruções do projeto;
2. estrutura e tecnologia existentes;
3. módulos, entidades e fluxos relacionados;
4. PRDs ou especificações já existentes;
5. testes ou restrições que afetem a ideia.

Resuma em 3 a 5 pontos somente o que muda as decisões da conversa. Não pergunte o que o código ou a documentação já respondem.

**Conclua quando:** os limites técnicos e o contexto do pedido estiverem identificados.

## Etapa 2 — Percorrer as decisões

Cubra os ramos abaixo, nesta ordem, priorizando os que bloqueiam os demais:

1. problema e valor;
2. público e permissões;
3. escopo e ações do usuário;
4. fluxos principais e estados;
5. regras de negócio;
6. erros, limites e casos de borda;
7. integrações e dados;
8. impacto no projeto;
9. critérios de aceite;
10. fora do escopo.

Faça **uma pergunta por mensagem**. Para cada pergunta, informe:

1. por que a decisão importa neste projeto;
2. a pergunta;
3. alternativas concretas, quando ajudarem;
4. uma recomendação e uma justificativa curta, baseada no contexto.

Formato:

```markdown
Essa decisão importa porque [impacto no projeto].

**Pergunta:** [decisão]

- **A:** [opção]
- **B:** [opção]

**Recomendação:** [opção] — [motivo em uma frase].
```

Quando a resposta for vaga, refine o mesmo ramo. Quando surgir uma contradição, mostre as duas decisões conflitantes e peça uma escolha. A cada 3 a 5 decisões, resuma o que foi fechado e confronte o principal trade-off com a alternativa descartada.

Não recomende uma alternativa artificial quando a resposta puder ser deduzida do projeto. Não avance para outro ramo enquanto houver uma decisão bloqueante aberta.

**Conclua quando:** cada ramo relevante tiver uma decisão confirmada, uma suposição explícita ou uma razão para não se aplicar.

## Etapa 3 — Fechar o entendimento

Apresente:

### Decisões confirmadas

- ...

### Suposições aceitas

- ...

### Trade-offs

- Escolha: ...
- Alternativa descartada: ...
- Motivo: ...

### Fora do escopo

- ...

### Próximo passo

Recomende:

- `/prd-generator` se o recorte for grande ou precisar de documentação detalhada;
- implementação direta se for pequeno e estiver completamente definido.

Pergunte: **“Fechamos ou ainda existe alguma decisão em aberto?”**

Só considere o processo encerrado após o usuário confirmar que não há ramo bloqueante aberto.

## Validação

Antes de terminar, confira:

- [ ] uma pergunta foi feita por vez;
- [ ] perguntas não repetiram informações presentes no projeto;
- [ ] cada recomendação tem motivo curto;
- [ ] decisões e suposições estão separadas;
- [ ] trade-offs relevantes foram explicitados;
- [ ] nenhum código ou arquivo foi alterado;
- [ ] o próximo passo foi recomendado, não executado.
