---
name: writing-for-agents
description: Escreve e revisa documentos consumidos por agentes. Use ao criar ou editar skills, AGENTS.md, CLAUDE.md, rules, PRDs, specs, tickets, prompts ou qualquer doc apontado para um agente.
---

# Escrita para agentes

Referência para qualquer documento que um agente lê: skill, `AGENTS.md` / `CLAUDE.md`, rule, spec, ticket, prompt ou README. O empacotamento muda; a escrita não — o objetivo é o mesmo **processo** a cada execução, não o mesmo texto de saída.

Se o documento for uma **skill**, leia [`SKILL-MECHANICS.md`](SKILL-MECHANICS.md) antes de decidir frontmatter e modo de invocação.

Termos centrais (**carga**, **hierarquia da informação**, **poda**, **palavras-âncora**) estão definidos em [`references/principios.md`](references/principios.md) — é o glossário único desta skill. Leia quando precisar da definição, não para o fluxo normal.

## Objetivo

Produzir instruções que digam ao agente: o que fazer, quando fazer, quais decisões tomar e como saber que terminou.

## Etapa 1 — Classificar o documento

1. Identifique o tipo: skill, regra permanente, referência, spec/PRD, prompt ou índice (`README`).
2. Leia o arquivo alvo e os vizinhos diretos; copie formato, idioma e modo de ativação.
3. Defina o resultado esperado em uma frase.

Se objetivo, público ou momento de uso mudarem a estrutura e estiverem indefinidos, faça **uma** pergunta objetiva. Caso contrário, use o contexto e registre só suposições que afetem comportamento.

**Conclua quando:** tipo, consumidor, gatilho de uso e resultado estiverem claros.

## Etapa 2 — Mapear branches e cargas

1. Liste os **ramos** distintos do documento (caminhos diferentes entre execuções).
2. Para cada trecho, decida qual **carga** paga:
   - **Contexto**: material sempre carregado (`AGENTS.md`, `description` de skill model-invoked).
   - **Cognitiva**: o humano precisa lembrar que o arquivo existe (skills user-invoked, prompts em `.prompts/`).
3. Inline o que **todo** ramo precisa; empurre o resto para referência ou arquivo separado.

Consulte [`references/principios.md`](references/principios.md) se precisar decidir entre inline, referência no arquivo ou arquivo externo.

**Conclua quando:** cada trecho tiver um degrau na hierarquia (passo no arquivo → referência no arquivo → referência externa via apontador).

## Etapa 3 — Escrever ou revisar

### Passos

Cada passo termina com critério verificável:

```markdown
### Etapa N — [verbo + objeto]

1. Faça [ação].
2. Verifique [evidência].

**Conclua quando:** [condição objetiva].
```

- Use verbos concretos: `leia`, `compare`, `pergunte`, `crie`, `valide`.
- Decisões condicionais explícitas: se X, faça Y; se Z, faça W.
- Afirme o comportamento desejado; proibições só para limites essenciais, sempre com o positivo correspondente.

### Apontadores

Um apontador diz **o que** existe no arquivo, **quando** ler e **onde** está. A redação do apontador — não o alvo — decide se o agente busca o material.

```markdown
Se precisar da definição de **carga**, leia
[`references/principios.md`](references/principios.md) antes de decidir o degrau.
```

Não aponte arquivo obrigatório sem dizer o momento de leitura. Não crie referência só para guardar regra curta que toda execução precisa.

### Poda

Antes de entregar, remova:

- **No-ops**: instruções que o modelo já seguiria por padrão.
- **Duplicação**: o mesmo significado em dois lugares — escolha uma fonte.
- **Cache do ambiente**: o que o agente encontra sozinho (`package.json`, `--help`, layout de pastas), salvo armadilha real.
- **Sedimento**: linhas que não mudam mais o comportamento.

Teste de no-op: delete a linha e pergunte se o comportamento mudou. Se não, remova a frase inteira.

**Conclua quando:** o corpo principal couber no que toda execução precisa e o restante estiver atrás de apontadores com gatilho claro.

## Etapa 4 — Entregar

Confirme que o documento tem objetivo, gatilho, formato de saída e cada etapa com critério verificável; apontadores com o quê, quando e onde; uma fonte por regra; padrão do projeto (idioma, limite de linhas, frontmatter) respeitado.

Informe brevemente o que mudou.

**Conclua quando:** o documento atende a cada critério da etapa 3 e a entrega descreve o que mudou.
