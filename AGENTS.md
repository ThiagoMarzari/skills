# Instruções para agentes

Este repositório é um kit reutilizável de práticas para agentes de IA. Ele reúne skills, prompts, regras e documentos de exemplo para serem copiados e adaptados a outros projetos. Não é um aplicativo e não possui uma stack de produto própria.

## Mapa do kit

- `README.md`: visão geral e formas de reutilização.
- `.agents/skills/<nome>/SKILL.md`: skills do kit.
- `.prompts/`: prompts que o usuário cola ou solicita explicitamente.
- `.cursor/rules/projetos.mdc`: regra geral para qualquer stack.
- `docs/exemplos/rules/`: regras de exemplo, atualmente voltadas a Next.js.
- `docs/`: exemplos de documentação e PRD; não representam um produto real.

## Regras de trabalho

- Preserve a portabilidade: uma skill, prompt ou regra deve continuar útil quando copiada para outro projeto.
- Mantenha cada artefato autossuficiente; referências necessárias devem estar no próprio diretório ou ter um caminho claro.
- Não invente stack, rotas, banco, autenticação ou funcionalidades de produto neste repositório.
- Não misture o domínio dos exemplos em `docs/` com a identidade do kit.
- Não adapte uma skill para um produto específico; extraia instruções genéricas e deixe o contexto do destino para o projeto que a receber.
- Escreva em português, mantendo termos técnicos no idioma original quando isso evitar ambiguidade.
- Faça somente as alterações pedidas e preserve mudanças existentes do usuário.

## Skills disponíveis

| Comando | Uso |
|---|---|
| `/ask-marzari` | Escolher a skill ou o fluxo adequado |
| `/questiona` | Fechar escopo, decisões e trade-offs |
| `/prd-generator` | Criar PRD e especificações funcionais |
| `/plan-spec` | Planejar ou implementar specs pendentes de um PRD |
| `/code-review` | Revisar qualidade do código e aderência à especificação |
| `/documentation-writer` | Sincronizar documentação com o código existente |
| `/writing-for-agents` | Criar ou melhorar instruções para agentes |
| `/rework-commits` | Reorganizar uma branch em commits revisáveis |

Skills com `disable-model-invocation: true` só devem ser executadas quando o usuário as invocar pelo nome. Não deduza uma skill a partir de uma solicitação parecida.

## Regras para alterar artefatos

- Skill: mantenha `SKILL.md` com `name`, `description` e corpo com menos de 500 linhas; coloque detalhes extensos em referências diretas.
- Prompt: mantenha um arquivo em `.prompts/`, focado em uma tarefa e sem depender deste repositório.
- Regra: trate uma preocupação por arquivo e use exemplos concretos.
- Documento de exemplo: mantenha-o genérico e identifique claramente que é exemplo.
- Não crie commits ou altere configuração do Git sem pedido explícito.
