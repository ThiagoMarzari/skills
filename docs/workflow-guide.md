# Guia de workflow

Este kit leva mudanças de uma ideia à revisão e entrega sem exigir o SDLC completo em toda task. O risco define quais gates entram; o repo destino define tracker e provedor de entrega. Estado duradouro fica em arquivos do repo, não apenas no chat.

## Rotas

```text
Mudança pequena: implementação → verificações aplicáveis → /code-review
Mudança de produto: /scope-clarifier → /prd → /plan-spec → implementação → /preflight → /code-review
Entrega explícita: /delivery
```

Use somente as fases necessárias:

- **Pequena:** alteração isolada sem impacto em comportamento, API, regra de negócio, segurança, dados ou produção. Pode ir direto à implementação; rode os testes pertinentes e faça review.
- **Com risco relevante:** mudança de comportamento, API, regra de negócio, integração, dependência ou CI. Faça clarificação se restarem decisões, use PRD/plano conforme o tamanho e rode `/preflight` antes do review.
- **Alto risco:** auth/permissões, privacidade, dados sensíveis, migração/exclusão de dados, pagamentos ou operação em produção. Além do preflight, valide segurança, reversibilidade, monitoramento e operação aplicáveis.

Uma decisão arquitetural duradoura com trade-offs materiais pode exigir `/adr`. Isso não substitui requisitos de produto no PRD. Próximo passo incerto: `/workflow-router`.

## Skills

| Skill | Responsabilidade |
|---|---|
| `setup-skills` | Configura tracker, commits e entrega por repo destino |
| `workflow-router` | Recomenda uma rota, sem executá-la |
| `scope-clarifier` | Fecha decisões de produto; não grava arquivo |
| `prd` | Grava PRD e specs em `docs/prd/` |
| `plan-spec` | Planeja specs pendentes; implementa somente quando pedido |
| `preflight` | Verifica prontidão por risco e produz checklist para PR/MR |
| `adr` | Registra decisão arquitetural confirmada em `docs/adr/` |
| `code-review` | Revisa diff em qualidade e aderência à especificação |
| `documentation-writer` | Alinha docs de produto ao código |
| `rework-commits` | Reorganiza commits com confirmação, sem mudar o diff final |
| `delivery` | Faz o last mile pelo provedor configurado, quando explicitamente invocado |
| `writing-for-agents` | Escreve e revisa documentos para agentes |
| `handoff` | Leva contexto para outra sessão/harness em arquivo temporário |

Skills com `disable-model-invocation: true` exigem o comando explícito. Prompts em `.prompts/` são colados quando necessários; não são skills nem auto-carregados.

## Configuração no repo destino

Copie as pastas das skills para `.agents/skills/<nome>/` (ou `.claude/skills/<nome>/`) e leve as referências indicadas por cada `SKILL.md`. `scope-clarifier` e `prd` usam a referência compartilhada `engineering/references/entrevista.md`, copiada como `references/entrevista.md` ao lado das skills no destino.

Rode `/setup-skills` uma vez para configurar `docs/agents/`:

- `issue-tracker.md`: onde issues vivem e como são referenciadas nos commits;
- `commit-conventions.md`: formato de mensagens;
- `delivery.md`: provider (`github`, `gitlab` ou `manual`), CLI, identidade do repo, destinos e branches protegidas — somente se `delivery` estiver instalada.

GitHub usa um destino; GitLab usa um ou mais destinos, inclusive o fluxo atual com sandbox e release; manual não executa Git/CLI e retorna checklist. A configuração pertence a cada repo (front e back têm arquivos próprios). Sem setup válido, `delivery` para em vez de inventar configuração ou fazer fallback.

## Artefatos e posse

| Artefato | Quem cria/lê/altera |
|---|---|
| `docs/agents/*` | `setup-skills` cria; skills de review/entrega leem |
| `docs/prd/*.md` | `prd` cria; `plan-spec` atualiza apenas status após validação |
| `docs/adr/*.md` | `adr` cria após confirmação da decisão; não sobrescreve ADR existente |
| Código e testes | Implementação / `plan-spec implementa` |
| README e docs de produto | `documentation-writer` propõe sync; código permanece fonte da verdade |
| Histórico Git | Humanos; `rework-commits` reorganiza com confirmação; `delivery` commita/pusha somente sob comando explícito |

O critério de aceite liga PRD, plano, implementação e review. Cada requisito deve ter comportamento verificável ou uma justificativa de não aplicabilidade. `/preflight` registra status/evidência apenas das verificações relevantes e gera texto pronto para PR/MR; não altera o remoto, não cria arquivo e não faz deploy.

## Caminho completo

1. **Configurar:** se o repo destino ainda não tem `docs/agents/`, rode `/setup-skills` antes das skills que dependem dessas configurações.
2. **Fechar produto:** `/scope-clarifier` resolve decisões em aberto. Se o escopo for grande, `/prd` grava o contrato funcional em `docs/prd/`; revise-o antes do planejamento. Tarefa pequena e clara pode pular ambos.
3. **Planejar e implementar:** `/plan-spec` transforma a próxima spec pendente em plano técnico. Sem `implementa`, não altera código; com `/plan-spec implementa` ou aprovação explícita, implementa e só marca a spec concluída após validação.
4. **Registrar decisão quando necessário:** use `/adr` para trade-off técnico duradouro já decidido; mantenha requisitos e aceite no PRD.
5. **Verificar:** rode verificações do projeto e `/preflight` quando o risco justificar. Depois, `/code-review` compara o diff com a spec ou pedido. Use `/documentation-writer` se docs humanas divergirem do código.
6. **Entregar:** `/delivery` revisa o diff, confere configuração e autenticação, e então faz commit/push e abre PR/MR(s) configurados. O modo manual retorna checklist. Nunca faz merge ou deploy.

`/rework-commits` é opcional e só reescreve histórico após apresentar o plano e receber confirmação; para se a working tree estiver suja ou a branch principal/publicada tornar a operação insegura. `/handoff` é só quando o trabalho precisa viajar para outro agente, pasta ou harness.

## Migração de nomes

| Nome antigo | Nome atual |
|---|---|
| `/questiona` | `/scope-clarifier` |
| `/fecha-a-task` | `/delivery` |

Na cópia destino, substitua as pastas antigas pelas novas; não mantenha ambas instaladas. Os demais nomes das skills já estão em inglês.
