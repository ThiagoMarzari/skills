# Prompt — o que testar

Cole **antes** de escrever testes. Depois, use [tdd-com-agentes.md](tdd-com-agentes.md).

```text
Analise [a funcionalidade X | o que acabamos de implementar].

Não escreva testes ainda.

Liste só comportamentos que merecem teste automatizado:
- regras de negócio
- dinheiro
- auth/permissões
- perda ou corrupção de dados
- estados e transições
- casos limite
- integrações externas
- regressões prováveis

Ignore UI trivial e implementação óbvia.

Classifique cada sugestão: CRÍTICO, IMPORTANTE ou DISPENSÁVEL.
```
