# Princípios de escrita para agentes

Referência de apoio — consulte apenas quando tiver dúvida sobre _por que_
uma regra do fluxo principal existe. Não é necessária para o uso normal
da skill.

## Os dois custos

Todo documento e todo apontador gastam um de dois orçamentos:

- **Custo de contexto**: o preço de algo que fica sempre carregado — uma
  linha de `AGENTS.md`, a `description` de uma skill, qualquer coisa
  presente no contexto em todo turno, gastando espaço mesmo quando não
  é usada.
- **Custo cognitivo**: o preço para o humano — saber quais documentos
  existem e quando buscar cada um. Não é um custo a minimizar a todo
  custo; é o preço da autonomia humana. Gaste-o onde o julgamento
  humano importa; remova-o onde não importa.

Material acessado só por um apontador paga apenas o custo cognitivo (mais
a linha do próprio apontador). Material sem apontador nenhum vive
inteiramente no custo cognitivo — ninguém lembra que ele existe.

## Apontadores (context pointers)

Um apontador é uma referência no contexto do agente que nomeia um
material fora do contexto e diz a condição para buscá-lo. A _redação_ do
apontador — não o conteúdo do arquivo apontado — decide se e quando o
agente vai buscar aquele material. Um apontador fraco para um material
essencial é um bug de variância: melhore a redação antes de considerar
trazer o conteúdo para dentro do arquivo principal.

Um bom apontador faz duas coisas: diz o que é o material, e lista as
situações que devem levar a buscá-lo. Cada situação distinta merece um
gatilho; sinônimos que renomeiam a mesma situação não contam como
gatilhos novos.

## Hierarquia da informação

Um documento é feito de **passos** (ações em ordem) e **referência**
(definições e regras consultadas sob demanda). Cada trecho ocupa um
degrau:

1. **Passo no arquivo** — o que o agente faz, em ordem.
2. **Referência no arquivo** — consultada sob demanda, mas ainda dentro
   do documento principal.
3. **Referência em outro arquivo** — só acessada via apontador, carregada
   apenas quando o apontador dispara.

Empurrar pouco demais para baixo deixa o topo inchado; empurrar demais
esconde o que o agente realmente precisa. Essa tensão é a decisão
inteira.

**Progressive disclosure** é mover conteúdo para baixo nessa escada —
para fora do arquivo principal, atrás de um apontador — para manter o
topo enxuto. O teste mais simples: o que _todo_ fluxo precisa fica
dentro; o que só _algumas_ situações alcançam vai para uma referência
separada.

**Co-localização** é o complemento dentro do arquivo: mantenha definição,
regras e ressalvas de um mesmo conceito juntas sob um único título, em
vez de espalhadas pelo documento.

## Critério de conclusão

Cada passo deve terminar em uma condição verificável de "pronto". Dois
fatores importam:

- **Clareza**: dá para distinguir concluído de incompleto? Um critério
  vago ("compreensão alcançada") convida à **conclusão prematura** — o
  agente encerra o passo antes da hora, atraído pelos passos seguintes
  já visíveis. Resolva afiando o critério primeiro; só esconda os
  próximos passos se isso não bastar.
- **Exigência**: o quanto o critério cobra. "Todo item verificado" força
  um trabalho mais completo do que "produza uma lista".

## Palavras-âncora (leading words)

Uma palavra-âncora é um conceito compacto que já existe no
pré-treinamento do modelo (ex.: _tight_, _fog of war_) e que, repetido
como token, ancora um comportamento inteiro com poucos tokens. Prefira
uma palavra já existente a inventar uma nova — a nova exige definição
explícita; a existente já vem com significado embutido.

**Negação é a armadilha correspondente**: dizer "não faça X" traz X para
o contexto e o torna mais presente, não menos. Prefira afirmar o
comportamento desejado ("valide a entrada antes de persistir") em vez de
proibir o indesejado. Proibições só valem a pena para limites realmente
essenciais — e mesmo assim, sempre acompanhadas do comportamento
positivo correspondente.

## Poda (pruning)

- **Fonte única de verdade**: cada significado deve existir em um único
  lugar. Duplicação custa manutenção e infla a importância de algo além
  do que ele merece.
- **O ambiente também é fonte de verdade**: um script já descrito no
  `package.json`, uma config, a saída de `--help` — não repita o que o
  agente encontra sozinho, a menos que exista uma armadilha real ali.
- **Relevância**: toda linha deve seguir influenciando o comportamento.
  Uma linha perde relevância por nunca ter afetado o resultado ou por
  ficar desatualizada com o tempo. Sem disciplina de poda, o documento
  acumula sedimento — camadas obsoletas que ninguém remove.
- **No-ops**: uma instrução que o modelo já seguiria por padrão não muda
  nada e só custa espaço. O teste é sempre comportamental: "isso muda o
  que o agente faz, comparado ao padrão dele?" — não uma opinião pessoal
  sobre o que parece útil.
