# Guia de workflow

Este kit leva mudanças de uma ideia à revisão e entrega sem exigir o SDLC completo em toda task. O risco define quais gates entram; o repo destino define tracker e provedor de entrega. Estado duradouro fica em arquivos do repo, não apenas no chat.

## Rotas

```text
Mudança pequena: implementação → verificações aplicáveis → /tm-code-review
Mudança de produto: /tm-prd → /tm-plan-spec → implementação → /tm-preflight → /tm-code-review
Entrega explícita: /tm-delivery
```

Use somente as fases necessárias:

- **Pequena:** alteração isolada sem impacto em comportamento, API, regra de negócio, segurança, dados ou produção. Pode ir direto à implementação; rode os testes pertinentes e faça review.
- **Com risco relevante:** mudança de comportamento, API, regra de negócio, integração, dependência ou CI. Use PRD/plano conforme o tamanho e rode `/tm-preflight` antes do review.
- **Alto risco:** auth/permissões, privacidade, dados sensíveis, migração/exclusão de dados, pagamentos ou operação em produção. Além do preflight, valide segurança, reversibilidade, monitoramento e operação aplicáveis.

Próximo passo incerto: `/tm-workflow-router`.

## Skills

| Skill | Responsabilidade |
|---|---|
| `tm-setup-skills` | Configura tracker, commits e entrega por repo destino |
| `tm-workflow-router` | Recomenda uma rota, sem executá-la |
| `tm-prd` | Grava PRD e specs em `docs/prd/` |
| `tm-plan-spec` | Planeja specs pendentes; implementa somente quando pedido |
| `tm-preflight` | Roda as verificações que cobrem o diff e produz checklist para PR/MR |
| `tm-code-review` | Revisa diff em qualidade e aderência à especificação |
| `tm-delivery` | Faz o last mile pelo provedor configurado, quando explicitamente invocado |
| `tm-handoff` | Leva contexto para outra sessão/harness em arquivo temporário |

Skills com `disable-model-invocation: true` exigem o comando explícito. Prompts em `.prompts/` são colados quando necessários; não são skills nem auto-carregados.

## Configuração no repo destino

Copie as pastas das skills para `.agents/skills/<nome>/` (ou `.claude/skills/<nome>/`) e leve as referências indicadas por cada `SKILL.md`.

Rode `/tm-setup-skills` uma vez para configurar `docs/agents/`:

- `issue-tracker.md`: onde issues vivem e como são referenciadas nos commits;
- `commit-conventions.md`: formato de mensagens;
- `delivery.md`: provider (`github` ou `gitlab`), CLI, identidade do repo, destinos e branches protegidas — somente se `tm-delivery` estiver instalada.

GitHub usa um destino; GitLab usa um ou mais destinos, inclusive o fluxo atual com sandbox e release. A configuração pertence a cada repo (front e back têm arquivos próprios). Sem setup válido, `tm-delivery` para em vez de inventar configuração ou fazer fallback.

## Artefatos e posse

| Artefato | Quem cria/lê/altera |
|---|---|
| `docs/agents/*` | `tm-setup-skills` cria; skills de review/entrega leem |
| `docs/prd/*.md` | `tm-prd` cria; `tm-plan-spec` atualiza apenas status após validação |
| Código e testes | Implementação / `tm-plan-spec implementa` |
| Histórico Git | Humanos; `tm-delivery` commita/pusha somente sob comando explícito |

O critério de aceite liga PRD, plano, implementação e review. Cada requisito deve ter comportamento verificável ou uma justificativa de não aplicabilidade. `/tm-preflight` registra status/evidência apenas do que o diff toca e gera checklist pronto para PR/MR; não altera arquivos nem o remoto.

## Caminho completo

1. **Configurar:** se o repo destino ainda não tem `docs/agents/`, rode `/tm-setup-skills` antes das skills que dependem dessas configurações.
2. **Fechar produto:** se o escopo for grande, `/tm-prd` entrevista e grava o contrato funcional em `docs/prd/`; revise-o antes do planejamento. Tarefa pequena e clara pode pular.
3. **Planejar e implementar:** `/tm-plan-spec` transforma a próxima spec pendente em plano técnico. Sem `implementa`, não altera código; com `/tm-plan-spec implementa` ou aprovação explícita, implementa e só marca a spec concluída após validação.
4. **Verificar:** rode verificações do projeto e `/tm-preflight` quando o risco justificar. Depois, `/tm-code-review` compara o diff com a spec ou pedido.
5. **Entregar:** `/tm-delivery` revisa o diff, confere configuração e autenticação, e então faz commit/push e abre PR/MR(s) configurados. Nunca faz merge ou deploy.

`/tm-handoff` é só quando o trabalho precisa viajar para outro agente, pasta ou harness.

## Migração de nomes

| Nome antigo | Nome atual |
|---|---|
| `/fecha-a-task` | `/tm-delivery` |
| `/setup-skills` | `/tm-setup-skills` |
| `/workflow-router` | `/tm-workflow-router` |
| `/prd` | `/tm-prd` |
| `/plan-spec` | `/tm-plan-spec` |
| `/preflight` | `/tm-preflight` |
| `/code-review` | `/tm-code-review` |
| `/delivery` | `/tm-delivery` |
| `/handoff` | `/tm-handoff` |

Na cópia destino, substitua as pastas antigas pelas novas; não mantenha ambas instaladas.
