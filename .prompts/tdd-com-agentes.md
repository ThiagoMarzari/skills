# TDD com agentes

Cole os blocos ao implementar comportamento novo. Antes, use [testes-automatizados.md](testes-automatizados.md) se ainda não souber *o que* testar.

Referência: [Cursor — Creating features](https://cursor.com/learn/creating-features).

## Fluxo

| # | Ação | Gate |
|---|------|------|
| 1 | Escreva testes primeiro | Diga explicitamente **TDD**; não implemente ainda |
| 2 | Confirme falha (red) | Testes falham pelo motivo certo |
| 3 | Commit dos testes | Contrato fixado |
| 4 | Peça implementação | **NÃO modifique os testes** |
| 5 | Commit do código | Diff revisado |

Separe conversas (testes vs. implementação) quando possível.

## Passo 1 — Testes

```text
TDD: escreva os testes primeiro.

[Testes para função/comportamento X com entradas, saídas e erros esperados.]

Siga o padrão em [caminho/de/teste/existente].
NÃO escreva a implementação — só os testes.
```

## Passo 2 — Red

```text
Rode os testes e confirme que os novos falham.
Não implemente ainda. Corrija só setup/import se falhar por motivo errado.
```

## Passo 3 — Commit dos testes

Você faz o commit (ex.: `test(escopo): add specs for X`).

## Passo 4 — Green

```text
TDD: faça os testes passarem.

Implemente para [arquivo de teste] passar.
Siga padrões em [caminho de referência].
NÃO modifique os testes.
Rode a suíte após cada alteração.
```

## Passo 5 — Commit da implementação

Revise diff — **nenhum arquivo de teste mudou na fase green**.

## Checklist

- [ ] TDD explícito na fase de testes
- [ ] Red confirmado
- [ ] Commit dos testes antes do código
- [ ] "NÃO modifique os testes" no pedido de implementação
- [ ] Diff da fase green sem alteração em testes
