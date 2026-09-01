---
name: questiona
description: Interroga o usuário para fechar escopo, comportamento, decisões e trade-offs antes da implementação. Use somente com /questiona.
disable-model-invocation: true
---

# Questiona

## Ativação e limites

Use somente com `/questiona`.

Durante a skill: não escreva código; não crie nem altere arquivos; não invoque outra skill. Use código e docs só para evitar perguntas já respondidas no projeto.

Ao terminar, recomende o próximo passo e aguarde o usuário decidir.

## Objetivo

Transformar ideia vaga em entendimento compartilhado: o que será feito, para quem, como se comporta e o que fica de fora.

## Etapa 1 — Ancorar no projeto

Leia contexto relevante: docs, estrutura, módulos relacionados, PRDs/specs existentes, testes e restrições.

Resuma em 3–5 pontos só o que muda decisões. Não pergunte o que o projeto já responde.

**Conclua quando:** limites técnicos e contexto estiverem identificados.

## Etapa 2 — Percorrer decisões

Cubra nesta ordem, priorizando bloqueantes:

1. problema e valor
2. público e permissões
3. escopo e ações
4. fluxos e estados
5. regras de negócio
6. erros, limites e bordas
7. integrações e dados
8. impacto no projeto
9. critérios de aceite
10. fora do escopo

### Ritmo de perguntas

**Padrão: uma decisão por mensagem.** Cada mensagem cobre um ramo bloqueante por vez.

Use **bloco de 2–3 perguntas** só quando todas forem:

- do **mesmo ramo**;
- **independentes** entre si (uma resposta não muda as outras);
- **factuais** (dado que o usuário já sabe), não trade-off de produto.

Se o usuário já colou briefing completo, **não repita** o que está respondido — pergunte só lacunas.

Resposta vaga ou que muda escopo → refine **o mesmo ramo**; não avance nem empilhe novas perguntas na mesma mensagem.

Cada pergunta inclui:

- por que importa neste projeto;
- a pergunta;
- alternativas concretas, se ajudarem;
- recomendação curta baseada no contexto.

```markdown
Essa decisão importa porque [impacto].

**Pergunta:** [decisão]

- **A:** [opção]
- **B:** [opção]

**Recomendação:** [opção] — [motivo].
```

A cada 3–5 decisões, resuma o fechado e confronte o trade-off principal.

**Conclua quando:** cada ramo relevante tiver decisão confirmada, suposição explícita ou "não se aplica".

## Etapa 3 — Fechar

Apresente: **Decisões confirmadas**, **Suposições**, **Trade-offs**, **Fora do escopo**, **Próximo passo** (`/prd-generator` se grande; implementação se pequeno e fechado).

Pergunte: **"Fechamos ou ainda existe decisão em aberto?"**

Encerre só após confirmação do usuário.

## Validação

- [ ] Uma decisão por mensagem (bloco só se factual e do mesmo ramo)
- [ ] Resposta vaga refinada antes de avançar
- [ ] Decisões ≠ suposições
- [ ] Trade-offs explícitos
- [ ] Nenhum arquivo alterado
- [ ] Próximo passo recomendado, não executado
