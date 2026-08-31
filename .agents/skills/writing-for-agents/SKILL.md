---
name: writing-for-agents
description: "Cria e melhora documentos que serão lidos por agentes de IA, incluindo skills, AGENTS.md, CLAUDE.md e referências apontadas por esses arquivos. Use quando o usuário pedir para escrever, revisar, simplificar ou organizar instruções para agentes."
disable-model-invocation: true
---

# Escrita para agentes

## Objetivo

Transforme conhecimento, regras e processos em instruções que um agente consiga executar de forma previsível. O documento deve dizer:

- qual comportamento é esperado;
- em que situação ele deve ser aplicado;
- quais decisões o agente precisa tomar;
- como saber que terminou.

Escreva em português, salvo se o usuário pedir outro idioma ou se um trecho técnico precisar permanecer no idioma original.

## Antes de escrever

1. Identifique o tipo de documento:
   - **Skill**: processo acionado por um comando ou condição.
   - **Regra permanente** (`AGENTS.md`/`CLAUDE.md`): orientação carregada com o projeto.
   - **Referência**: conhecimento consultado por uma skill ou regra.
2. Leia o arquivo que será alterado e os documentos diretamente relacionados.
3. Observe o padrão dos arquivos vizinhos: idioma, formato, nomes, limites e modo de ativação.
4. Defina o resultado esperado em uma frase.

Se o objetivo, o público ou o momento de uso estiverem indefinidos e isso mudar a estrutura do documento, faça uma pergunta objetiva antes de escrever. Caso contrário, use o contexto do repositório e registre somente as suposições que realmente afetarem o comportamento.

**Conclua esta etapa quando** souber qual documento está sendo escrito, quem o consumirá, quando ele deve ser usado e qual resultado deve produzir.

## Estrutura recomendada

Organize o conteúdo na ordem em que o agente precisa pensar:

1. **Metadados**: nome, descrição e modo de ativação, quando o formato exigir.
2. **Ativação**: situação que inicia o fluxo e situações em que ele não se aplica.
3. **Objetivo**: resultado final, sem explicação histórica.
4. **Processo**: etapas numeradas na ordem de execução.
5. **Referência**: definições, critérios e exemplos consultados durante o processo.
6. **Saída**: formato exato da resposta ou do arquivo produzido.
7. **Validação**: condições verificáveis para considerar o trabalho concluído.

Coloque no arquivo principal tudo que todas as execuções precisam. Mova para um arquivo de referência apenas o material usado por uma parte específica do fluxo ou que ficaria extenso demais. Aponte para a referência com o caminho relativo e diga exatamente em qual situação ela deve ser lida.

## Como escrever cada etapa

Cada etapa deve conter uma ação observável e um critério de conclusão:

```markdown
### Etapa 1 — [verbo + objeto]

1. Faça [ação].
2. Verifique [evidência].

**Conclua quando:** [condição objetiva e verificável].
```

Prefira:

- verbos concretos: `leia`, `compare`, `pergunte`, `crie`, `valide`;
- limites explícitos: quantidade, caminho, formato ou ordem;
- decisões condicionais: “se X, faça Y; se Z, faça W”;
- critérios que permitam distinguir concluído de incompleto.

Evite instruções vagas como “seja cuidadoso”, “entenda o contexto” ou “faça uma boa revisão”. Troque-as por uma ação e uma evidência: “leia os arquivos relacionados e cite o caminho de cada decisão usada”.

## Referências e apontadores

Um apontador é qualquer frase que manda o agente procurar outro arquivo. Ele precisa informar:

1. o que existe no arquivo;
2. em qual situação o arquivo deve ser lido;
3. onde o arquivo está.

Exemplo:

```markdown
Se a tarefa for criar uma spec funcional, leia
[`references/spec-template.md`](references/spec-template.md) antes de escrever.
```

Não aponte para um arquivo obrigatório sem tornar explícito o momento de leitura. Não crie uma referência apenas para guardar uma regra curta que todas as execuções precisam.

## Escrita de regras

- Declare a regra positivamente: “valide a entrada antes de persistir”.
- Use proibições apenas para limites essenciais, sempre acompanhadas do comportamento esperado.
- Não transforme preferência pessoal em regra.
- Não invente stack, caminhos, entidades, comandos ou comportamento que não estejam no contexto.
- Preserve termos importantes do projeto e defina siglas ou conceitos na primeira ocorrência.
- Mantenha cada significado em um único lugar. Se a mesma regra aparecer duas vezes, escolha uma fonte e aponte para ela.
- Não repita informações que o agente pode descobrir facilmente no ambiente, como um script já descrito no `package.json`, salvo quando houver uma armadilha importante.

## Skills

Quando o documento for uma skill:

1. Leia [`SKILL-MECHANICS.md`](SKILL-MECHANICS.md) antes de decidir o modo de ativação.
2. Defina `name` com letras minúsculas, números e hífens, com até 64 caracteres.
3. Escreva uma `description` específica: o que a skill faz e em quais situações deve ser usada.
4. Use `disable-model-invocation: true` quando a skill só deve rodar por comando explícito. Deixe o campo ausente somente quando o agente precisar acioná-la sozinho.
5. Mantenha o fluxo principal no `SKILL.md`; deixe detalhes opcionais em referências na mesma pasta.

## Revisão final

Antes de entregar, verifique:

- [ ] O objetivo e o momento de ativação estão claros.
- [ ] O agente sabe qual arquivo ou resultado deve produzir.
- [ ] As etapas estão numeradas e na ordem correta.
- [ ] Cada etapa termina com um critério verificável.
- [ ] As decisões importantes têm condições explícitas.
- [ ] Os termos técnicos estão traduzidos ou definidos.
- [ ] Os apontadores dizem quando e por que ler a referência.
- [ ] Não há dependência escondida de outro arquivo, skill ou integração.
- [ ] Não há regra duplicada, exemplo obsoleto ou explicação sem efeito no comportamento.
- [ ] O arquivo respeita o padrão e o limite do projeto.

Se algum item falhar, corrija antes de entregar. Informe brevemente o que foi alterado e quais validações foram feitas.
