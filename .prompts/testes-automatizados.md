# Prompt — o que testar

Cole no chat **antes** de escrever testes. Depois de fechar o que testar, use o fluxo em [tdd-com-agentes.md](tdd-com-agentes.md).

```text
Analise a funcionalidade que [ x | acabamos de implementar].


Não escreva testes ainda.


Identifique apenas comportamentos que realmente merecem testes automatizados considerando:
- regras de negócio
- dinheiro
- autenticação/permissões
- perda ou corrupção de dados
- estados e transições
- casos limite
- integrações externas
- regressões prováveis


Ignore detalhes visuais e implementações triviais.


Classifique cada teste sugerido como:
CRÍTICO, IMPORTANTE ou DISPENSÁVEL.
```