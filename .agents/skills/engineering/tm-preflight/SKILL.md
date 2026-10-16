---
name: tm-preflight
description: Confere se uma mudança está pronta para review e gera um checklist curto para o PR/MR. Use com /tm-preflight.
disable-model-invocation: true
---

# Preflight

Use somente com `/tm-preflight`, depois da implementação. Só leitura: não altere arquivos, não instale dependências, não faça commit/push nem abra PR/MR.

1. Leia o diff e identifique o que ele toca: comportamento, API, dados/migração, auth/segurança, dependências, CI.
2. Rode os testes, lint e typecheck do projeto que cobrem o diff, quando forem seguros localmente.
3. Para cada item tocado, marque **OK**, **Pendente** ou **Bloqueado**, com uma evidência curta. Ignore o que o diff não toca.

Não alegue validação de CI, staging ou produção sem evidência.

## Saída

```markdown
## Preflight
- [x] Testes: <comando> passou
- [ ] Migração: rollback não testado
```

Depois do checklist, liste os bloqueios, se houver.
