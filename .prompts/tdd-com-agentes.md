# TDD com agentes

Prática recomendada pelo [Cursor — Creating features](https://cursor.com/learn/creating-features). Cole os blocos no chat quando for implementar comportamento novo.

**Relacionado:** use [.prompts/testes-automatizados.md](testes-automatizados.md) **antes** deste fluxo, se ainda não souber *o que* merece teste.

---

## Por que funciona

Agentes trabalham melhor quando conseguem saber se o código está correto. Quando um teste falha, o agente vê o que deu errado e tenta de novo.

Engenheiros usam TDD há muito tempo, mas nem sempre foi a forma mais popular de escrever código. Com agentes, fica muito mais fácil escrever os testes primeiro — e eles compensam à medida que a base de código cresce.

Isso vale especialmente para **backend e regras de negócio**, onde não dá para validar só olhando a tela: os testes descrevem o comportamento esperado; o agente escreve o código para bater com isso.

---

## Fluxo em 5 passos

| # | O que fazer | Objetivo |
|---|-------------|----------|
| 1 | Escreva os testes primeiro | Fixar entradas/saídas antes da implementação |
| 2 | Confirme que os testes falham | Garantir que o teste mede comportamento real, não mock vazio |
| 3 | Commit dos testes | Travar os requisitos que o agente deve implementar |
| 4 | Peça ao agente o código | Fazer todos os testes passarem **sem alterar os testes** |
| 5 | Commit do código | Revisar, validar e registrar a implementação |

**Dica:** separe em duas conversas ou sessões quando possível — uma só para testes, outra só para implementação. Reduz o agente “implementar primeiro e adaptar o teste depois”.

---

## Passo 1 — Escreva os testes primeiro

Peça testes com base nas **entradas e saídas esperadas**. Deixe explícito que é **TDD**, para o agente não criar mocks de funções que ainda não existem nem pular direto para a implementação.

```text
TDD: escreva os testes primeiro.

Escreva testes para uma função discountCode() que:
- retorne o preço com desconto ao receber um código válido
- lance InvalidCodeError para códigos expirados
- aplique descontos de valor fixo corretamente (ex.: "10OFF" = $10 de desconto)
- nunca retorne preço negativo (mínimo $0)

Siga os padrões de teste em src/__tests__/pricing.test.ts.
NÃO escreva a função ainda — só os testes.
```

Adapte: troque `discountCode`, caminhos e regras pelo seu caso. Cite um arquivo de teste existente como referência de estilo.

---

## Passo 2 — Confirme que os testes falham

Neste ponto você **não** está implementando a funcionalidade. Só validando que os testes falham pelo motivo certo (comportamento ausente, não erro de sintaxe ou setup quebrado).

```text
Rode a suíte de testes e confirme que os testes novos de discountCode() falham.
Não implemente discountCode() ainda.
Se falhar por motivo errado (import, typo, setup), corrija só isso.
```

---

## Passo 3 — Commit dos testes

Revise cobertura e qualidade (casos principais, bordas, erros). Quando estiver satisfeito, faça commit — isso fixa o contrato que o agente deve cumprir na implementação.

```text
# Exemplo de mensagem de commit (você faz o commit, não o agente)
test(pricing): add discountCode TDD specs
```

---

## Passo 4 — Peça ao agente escrever o código

Depois do commit dos testes, peça a implementação. Seja explícito: **todos os testes devem passar; os arquivos de teste não podem ser alterados**.

```text
TDD: faça os testes passarem.

Implemente discountCode() para que todos os testes em src/__tests__/discountCode.test.ts passem.
Siga os padrões de serviço em src/services/PricingService.ts.
NÃO modifique os testes.
Rode a suíte após cada alteração até ficar verde.
```

Se o agente travar após várias iterações, volte ao passo 2: o teste pode estar ambíguo ou o escopo da implementação grande demais.

**Anti-padrão:** agente altera o teste para “passar”. Sempre confira o diff dos arquivos de teste antes de aceitar.

---

## Passo 5 — Commit do código

Revise a saída, confirme que o comportamento bate com o que você queria além do mínimo dos testes, e faça commit.

```text
# Exemplo de mensagem de commit
feat(pricing): implement discountCode
```

---

## Checklist rápido

- [ ] Disse explicitamente que é TDD e que **não** deve implementar na fase de testes
- [ ] Testes novos **falham** antes da implementação (red)
- [ ] Commit dos testes antes de pedir código
- [ ] Pedido de implementação inclui “NÃO modifique os testes”
- [ ] Diff revisado — nenhum arquivo de teste mudou na fase green
- [ ] Commit da implementação

---

## Referência

- [Cursor — Creating features (TDD com agentes)](https://cursor.com/learn/creating-features)
