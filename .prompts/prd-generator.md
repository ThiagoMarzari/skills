# Prompt — /prd-generator

Cole o bloco no chat, **incluindo** a primeira linha. A skill só roda com `/prd-generator`.

Quanto mais você preencher (problema, público, ações, regras, fora de escopo), menos ela pergunta. O que não souber, omita ou deixe em **Regras ainda em aberto** — a skill pergunta em vez de inventar.

Há dois modelos: **produto novo** (INICIAL) e **funcionalidade em projeto existente** (FEATURE). Troque tudo entre `[colchetes]` pelo seu caso; apague seções que não se aplicarem.

---

## Modelo — produto novo (INICIAL)

Use quando ainda **não existe** produto implementado (ou você quer replanejar do zero).

```text
/prd-generator

Modo: INICIAL (produto do zero).

## Ideia
[Uma frase: o que é o sistema e para qual contexto — ex.: "app web para [organização] registrar e acompanhar [tipo de registro]"]

## Problema
[Como é feito hoje sem o sistema. O que falta: histórico, status, visibilidade, fila, etc. Quem sofre e como.]

## Público
- [Perfil principal 1 — quem usa no dia a dia]
- [Perfil principal 2 — quem administra ou opera]
[Recorte explícito do que NÃO é público — ex.: "não é multi-tenant", "não é auto-cadastro"]

## Ações

[Perfil A] ([como entra — ex.: e-mail cadastrado, login senha, convite]):
- [ação 1 — ex.: listar X com filtro por Y]
- [ação 2 — ex.: criar X com campos A, B, C]
- [ação 3 — ex.: ver detalhe]
- [ação 4 — ex.: comentar / anexar / etc.]

[Perfil B] ([área ou papel — ex.: dashboard, backoffice]):
- [ação administrativa 1]
- [mesmas ações do fluxo principal, se compartilhadas]
- [login/auth — feche ou marque "ainda não fechei — sugestão: ..."]

[Como as áreas se separam — ex.: link público vs área restrita]

## Essencial agora
- [entrega 1]
- [entrega 2]
- [entrega 3]

## Pode ficar para depois (confirmar)
- [nice-to-have 1]
- [nice-to-have 2]

## Fora do escopo agora
- [feature que parece relacionada mas não entra neste recorte]
- [integração, pagamento, mobile, etc. — se não for agora]

## Regras (as que já fechei)
- [regra objetiva 1]
- [regra objetiva 2]
- [regra de permissão ou limite]

## Regras ainda em aberto (a skill deve perguntar, não inventar)
- [status possíveis?]
- [quem vê o quê?]
- [o que acontece em estado final / fechado?]
- [quem pode alterar ou excluir?]
- [limites de anexo, tamanho, quantidade?]

## Fluxos principais
1. [ator] faz [passo] → [passo] → [resultado]
2. [ator A ou B] no detalhe → [ação] → [resultado]
3. [fluxo operacional — ex.: fila, triagem, acompanhamento]

## Como saber que está bom
- [critério verificável 1]
- [critério verificável 2]
- [critério de permissão ou bloqueio]
- [critério de caso que NÃO deve funcionar]
```

---

## Modelo — funcionalidade (FEATURE)

Use quando o produto **já existe**. Descreva só o recorte da feature; cite o que já está pronto. A skill detecta a stack — não peça Next/Nest de novo.

```text
/prd-generator

Modo: FEATURE.

## Feature
[Uma frase: o que passa a ser possível — ex.: "permitir que [ator] edite/exclua [entidade] própria e que [ator admin] faça [ação broader]"]

## Contexto (já existe)
[2–5 bullets do que o sistema já faz — login, CRUD principal, listagem, filtros, campos da entidade, status atuais]

Não reinventar: [liste fluxos/autenticação/cadastros que ficam como estão]

## Problema
[O que não dá para fazer hoje por causa desta lacuna. Consequência prática — workaround manual, erro, duplicata, etc.]

## Público desta feature
- [quem ganha a nova capacidade]
- [quem ganha capacidade extra de admin/operação]

## Ações
[Perfil A]:
- [ação nova 1]
- [ação nova 2]

[Perfil B]:
- [ação nova com escopo maior ou diferente]

## Essencial agora
- [comportamento mínimo 1]
- [comportamento mínimo 2]
- [bloqueio com mensagem clara quando regra impedir]

## Pode ficar para depois
- [extensão futura da mesma feature]
- [auditoria, histórico, soft delete, etc.]

## Fora do escopo desta feature
- [mudança em outra parte do produto]
- [outro PRD — ex.: notificações, novo tipo, nova área]

## Regras (as que já fechei)
- [quem pode fazer o quê — ex.: só autor, só antes de status X]
- [o que admin pode vs usuário comum]
- [efeito da exclusão — some da lista, soft delete, etc.]

## Regras ainda em aberto (a skill deve perguntar, não inventar)
- [exclusão é definitiva?]
- [o que acontece com dados relacionados — comentários, anexos?]
- [campos editáveis na alteração?]
- [confirmação antes de ação destrutiva?]

## Fluxos principais
1. [ator] em [estado permitido] → [ação] → [resultado visível]
2. [ator] tenta [ação] em [estado bloqueado] → sistema impede → [feedback]
3. [admin] → [ação] → [efeito para todos os perfis]

## Como saber que está bom
- [happy path verificável]
- [bloqueio verificável]
- [regressão — o que já existia continua igual]
```

---

## Dicas rápidas

| Modo | Foque em | Evite |
|------|----------|--------|
| **INICIAL** | problema, público recortado, MVP, regras, fluxos | pedir stack; inflar escopo |
| **FEATURE** | lacuna atual, delta sobre o existente, impacto | reescrever o produto inteiro |

**Regras em aberto** são intencionais: deixe o que ainda não decidiu — a skill pergunta. **Regras fechadas** são contrato: só coloque o que já decidiu.

**Depois do PRD:** chat novo e `/plan-spec`. Sem colar o arquivo. `todas` = recorte curto no mesmo chat; `implementa` = sair do plano e codar.
