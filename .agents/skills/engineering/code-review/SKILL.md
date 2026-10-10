---
name: code-review
description: Revisa alterações desde um ponto informado em duas frentes independentes — qualidade estrutural e atendimento à especificação. Use com /code-review.
disable-model-invocation: true
---

# Code Review

## Ativação

Use somente com `/code-review`. Outro caminho → recuse e instrua o comando.

Sem ponto de comparação → pergunte (`main`, `develop`, `HEAD~3`, tag, commit).

## Objetivo

Compare `<ponto>...HEAD` em duas frentes **independentes**:

1. **Qualidade**: problemas estruturais observáveis no diff (heurísticas, não falhas automáticas).
2. **Especificação**: implementação vs. pedido original — faltas, escopo extra, comportamento incorreto.

Mantenha as frentes separadas no relatório final.

## Etapa 1 — Diff

```bash
git rev-parse <ponto>
git diff <ponto>...HEAD
git log <ponto>..HEAD --oneline
```

Ponto inválido ou diff vazio → informe e pare.

**Conclua quando:** o ponto resolve e o diff não está vazio.

## Etapa 2 — Especificação

Ordem de busca:

1. Caminho informado pelo usuário
2. Referências a issues/tickets nos commits, no formato que o projeto já usa
3. `docs/`, `specs/`, `.scratch/` relacionados à branch
4. Pedido do usuário, se claro

Sem spec e usuário confirma ausência → pule frente Especificação; informe no resultado.

**Conclua quando:** a fonte da spec estiver identificada, ou a frente Especificação pulada com confirmação do usuário.

## Etapa 3 — Análises

Limite: **400 palavras** por frente. Cite arquivo e linha/trecho.

### Paralelo (preferido)

Dois subagentes com: comando do diff, commits, diff ou arquivos, instruções de citação. Qualidade não deve ver spec; Especificação não deve ver achados de qualidade.

### Fallback (sem subagentes)

Execute as duas frentes **em sequência** na mesma sessão:

1. Complete Qualidade sem ler a spec.
2. Depois Especificação sem reordenar nem combinar achados de Qualidade.

Não misture as frentes no fallback.

#### Qualidade — heurísticas

Reporte só com evidência no diff. Marque como "possível":

nome pouco claro, duplicação, inveja de dados, grupo de dados, obsessão por primitivos, condicionais repetidas, mudança espalhada, mudanças divergentes, generalização prematura, cadeia de mensagens, intermediário desnecessário, herança não utilizada.

#### Especificação

Compare diff com spec: requisitos ausentes, escopo extra, implementação incorreta, erros/limites/permissões não tratados. Cite linha da spec e trecho do código.

**Conclua quando:** as duas frentes tiverem rodado isoladas, cada uma com no máximo 400 palavras e achados com arquivo e linha.

## Etapa 4 — Relatório

```markdown
## Qualidade do código

[achados ou "Nenhum problema encontrado nesta frente."]

## Especificação

[achados ou "Nenhum problema..." / "Não há especificação disponível para esta frente."]

Resumo: Qualidade — N achado(s), pior: …; Especificação — N achado(s), pior: …
```

Não combine nem reordene achados entre frentes.

**Conclua quando:** o relatório tiver as duas seções, sem misturar achados.
