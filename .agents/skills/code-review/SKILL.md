---
name: code-review
description: "Revisa alterações de código desde um ponto de comparação informado pelo usuário em duas frentes independentes: padrões do repositório e atendimento à especificação. Use com /code-review ao revisar uma branch, um pull request, alterações ainda não finalizadas ou ao pedir uma revisão desde um commit, tag ou branch."
disable-model-invocation: true
---

# Revisão de código em duas frentes

## Ativação

Use esta skill somente quando o usuário digitar `/code-review`.

Se o usuário chamar por outro caminho, recuse e instrua: "Use `/code-review` para iniciar esta skill."

Se o usuário não informar de onde a revisão deve começar, pergunte pelo ponto de comparação. Exemplos: `main`, `develop`, `HEAD~3`, uma tag ou um commit.

## Objetivo

Compare as alterações entre o ponto informado e `HEAD` (a ponta atual da branch) em duas frentes independentes:

1. **Qualidade do código**: procura problemas estruturais comuns e riscos de manutenção observáveis no próprio diff.
2. **Especificação**: verifica se o código implementa o pedido original, sem deixar requisitos de fora nem adicionar comportamento sem justificativa.

As duas análises devem ser feitas em paralelo por dois subagentes, para que uma não influencie a outra. No resultado final, mantenha as frentes separadas.

## Termos usados nesta skill

- **Diff**: conjunto de linhas adicionadas, removidas ou alteradas.
- **Merge-base**: ancestral comum entre duas branches. O comando com três pontos (`base...HEAD`) compara a partir desse ancestral, evitando incluir alterações antigas que já existiam na base.
- **Especificação**: documento, issue, requisito ou pedido que descreve o comportamento esperado.
- **Achado**: problema encontrado na revisão. Todo achado deve indicar arquivo e linha/trecho quando possível.
- **Subagente**: análise independente executada por outro agente, recebendo apenas o contexto necessário.
- **Problema estrutural**: possível dificuldade de manutenção ou desenho do código. É uma indicação para análise humana, não uma falha automática.

## Processo

### 1. Validar o ponto de comparação

Depois de receber o ponto de comparação:

1. Confirme que ele existe:
   ```bash
   git rev-parse <ponto>
   ```
2. Obtenha o diff uma única vez:
   ```bash
   git diff <ponto>...HEAD
   ```
3. Liste os commits incluídos:
   ```bash
   git log <ponto>..HEAD --oneline
   ```
4. Verifique se o diff contém alterações.

Se o ponto não existir, informe o erro e pare. Se o diff estiver vazio, informe que não há alterações para revisar e pare. Não inicie os subagentes antes dessas validações.

### 2. Encontrar a especificação

Procure a especificação nesta ordem:

1. Um caminho informado pelo usuário.
2. Referências no histórico de commits, como `#123`, `Closes #45` ou `!67`.
3. Arquivos em `docs/`, `specs/` ou `.scratch/` relacionados ao nome da branch ou da funcionalidade.
4. O texto do pedido do usuário, caso ele descreva claramente o que deveria ser feito.

Não dependa de uma ferramenta, integração ou skill externa para localizar uma issue. Se uma referência exigir acesso a um serviço externo que não está disponível, registre essa limitação e continue com as fontes locais.

Se nenhuma especificação for encontrada, pergunte ao usuário pelo caminho ou conteúdo. Caso ele confirme que não existe especificação, não execute a frente de Especificação; informe no resultado: `Não há especificação disponível para esta frente.`

### 3. Preparar as duas análises paralelas

Os dois subagentes devem receber:

- o comando exato do diff;
- a lista de commits;
- o conteúdo relevante do diff, ou acesso aos mesmos arquivos;
- instruções para citar arquivo e linha/trecho;
- limite de 400 palavras para o relatório.

Não procure nem exija arquivos externos de regras do projeto. Esta skill é autossuficiente. A análise de qualidade deve usar apenas o diff, o código ao redor e o comportamento que puder ser verificado no repositório.

#### Subagente de qualidade do código

Procure estes problemas estruturais. Eles são **heurísticas**: devem ser descritos como “possível”, nunca como falha comprovada. Só reporte um item quando houver evidência concreta no diff ou no código relacionado.

- **Nome pouco claro**: nome de função, variável ou tipo que não revela seu propósito ou conteúdo. Sugestão: dar um nome preciso.
- **Código duplicado**: mesma lógica repetida em mais de um arquivo ou trecho. Sugestão: extrair a parte comum, se isso realmente melhorar a compreensão.
- **Inveja de dados**: método que acessa mais dados de outro objeto do que os dados do próprio objeto. Sugestão: mover o comportamento para o objeto cujos dados ele usa.
- **Grupo de dados**: mesmos campos ou parâmetros sempre viajando juntos. Sugestão: agrupá-los em um tipo ou objeto, quando houver um conceito claro.
- **Obsessão por tipos primitivos**: string, número ou booleano usado no lugar de um conceito do domínio. Sugestão: criar um tipo pequeno quando isso trouxer validação ou significado real.
- **Condicionais repetidas**: vários `switch` ou cascatas de `if` decidindo com base no mesmo tipo. Sugestão: compartilhar um mapa de decisões ou usar polimorfismo quando fizer sentido.
- **Mudança espalhada**: uma única mudança lógica exige alterações em muitos arquivos. Sugestão: aproximar o comportamento relacionado.
- **Mudanças divergentes**: um mesmo arquivo foi alterado por vários motivos sem relação. Sugestão: separar responsabilidades apenas se isso reduzir o acoplamento.
- **Generalização sem necessidade**: abstração, parâmetro ou extensão criada para uma necessidade que a especificação não possui. Sugestão: remover até surgir uma necessidade real.
- **Cadeia de mensagens**: navegação longa como `a.b().c().d()` que expõe detalhes internos. Sugestão: esconder a navegação atrás de um método significativo.
- **Intermediário desnecessário**: classe ou função que apenas repassa a chamada para outro lugar. Sugestão: remover a camada se ela não acrescentar regra, proteção ou significado.
- **Herança não utilizada**: classe derivada ou implementação que ignora a maior parte do contrato herdado. Sugestão: usar composição, se a relação de herança não representar o domínio.

O relatório deve citar o trecho afetado e explicar por que o item é um possível problema. Não invente uma regra externa para justificar o achado.

#### Subagente de especificação

Compare o diff com a especificação encontrada e procure:

1. requisitos ausentes ou parcialmente implementados;
2. comportamento adicionado sem ser pedido (aumento de escopo);
3. requisito aparentemente implementado, mas com comportamento incorreto;
4. casos de erro, limites ou permissões descritos na especificação e não tratados.

Cada achado deve citar a linha correspondente da especificação e o arquivo/trecho afetado. Não invente requisitos que não estejam na especificação.

### 4. Montar o relatório final

Apresente os resultados exatamente nesta ordem:

## Qualidade do código

Para cada possível problema estrutural, informe:

- gravidade: `Alta`, `Média` ou `Baixa`;
- localização: arquivo e linha/trecho;
- evidência;
- impacto;
- sugestão objetiva.

Se nada for encontrado, escreva: `Nenhum problema encontrado nesta frente.`

## Especificação

Inclua os requisitos ausentes, o aumento de escopo e as implementações possivelmente incorretas. Para cada achado, cite a especificação e a localização no código.

Se a especificação não existir, escreva: `Não há especificação disponível para esta frente.` Se nada for encontrado, escreva: `Nenhum problema encontrado nesta frente.`

Finalize com uma única linha contendo:

`Resumo: Qualidade — <quantidade> achado(s), pior: <descrição ou "nenhum">; Especificação — <quantidade> achado(s), pior: <descrição ou "sem especificação">.`

Não combine, compare ou reordene os achados entre as duas frentes. Um código pode ter boa qualidade estrutural e ainda não atender à especificação, ou o contrário.
