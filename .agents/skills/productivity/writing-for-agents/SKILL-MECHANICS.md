# Mecânica de skills

Ramo específico de [`writing-for-agents`](SKILL.md): frontmatter, escolha de invocação e router skills. O restante da escrita segue o arquivo principal.

## Invocação

Duas escolhas, trocando as duas cargas:

| Modo | Frontmatter | Carga de contexto | Carga cognitiva |
|------|-------------|-------------------|-----------------|
| **Model-invoked** | Omitir `disable-model-invocation` | `description` sempre carregada; o agente pode acionar sozinho | Baixa para o humano |
| **User-invoked** | `disable-model-invocation: true` | Zero — `description` não entra no contexto do agente | Alta — o humano é o índice |

Escolha model-invocation quando:

- o agente precisa alcançar a skill sozinho; ou
- outra skill precisa invocá-la; ou
- a skill é referência compartilhada entre várias skills.

Escolha user-invocation quando a skill só dispara por comando explícito (`/nome`) e você quer preservar orçamento de contexto. Workflows com gate humano (PRD, plano, reorganização de commits) devem ser user-invoked.

### Escrever a `description` (model-invoked)

A `description` é um **apontador de contexto**: diz o que a skill faz e lista os **ramos** que devem dispará-la. Cada palavra custa em todo turno — poda mais agressivamente que o corpo.

- Primeira frase: capacidade.
- Segunda frase: `Use quando…` com ramos genuinamente distintos (não sinônimos do mesmo ramo).
- Até 64 caracteres no `name`; `description` concisa, em terceira pessoa.

### `description` em skill user-invoked

Serve só ao humano: resumo de uma linha. Sem lista de gatilhos — o agente não a lê.

## Referência compartilhada entre skills user-invoked

Duas skills user-invoked não podem se invocar (sem `description`, nenhuma alcança a outra). Material que ambas precisam vai para arquivo **fora** da pasta de cada skill — neste kit, `engineering/references/` no bucket; no destino, `references/` irmã das skills copiadas, ou doc apontado por `AGENTS.md`.

## Dividir por invocação

Separe uma skill model-invoked quando houver palavra-âncora ou ramo que deve disparar sozinho, ou quando outra skill precisa alcançá-la. Você paga carga de contexto pela nova `description` — o ganho de descoberta precisa valer a pena.

## Router skills

Quando skills user-invoked passam do que o humano lembra, use uma **router skill** user-invoked (ex.: `/ask-marzari`): uma skill que nomeia as outras e quando usar cada uma.

Limites do router:

- só **indica** o próximo comando;
- **não** executa a skill recomendada;
- **não** altera arquivos.

O router cura carga cognitiva; não remove a necessidade de invocar cada workflow à mão.
