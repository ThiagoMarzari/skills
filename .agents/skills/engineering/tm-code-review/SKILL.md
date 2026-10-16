---
name: tm-code-review
description: "Revisa as mudanças da branch atual em busca de bugs, desvios da spec e problemas de qualidade, com achados verificados e citando arquivo e linha. Use somente com /tm-code-review."
disable-model-invocation: true
---

# Code Review

Use somente com `/tm-code-review`.

Revise o que esta branch muda e aponte o que deve ser corrigido antes do merge. O valor do review está em achados reais e acionáveis: um bug confirmado vale mais que dez sugestões de estilo. Nesta skill, não altere código; se o usuário pedir correções depois, isso é outra etapa.

## Condução

1. **Defina o que revisar.** Sem argumento, revise tudo o que a branch atual mudou em relação à branch principal, incluindo alterações ainda não commitadas: descubra a principal com `git symbolic-ref refs/remotes/origin/HEAD` (ou `main`/`master`) e use `git diff $(git merge-base <principal> HEAD)`. Se o usuário passar uma branch, commit ou número de PR/MR, revise isso. Sem nada para revisar, informe e pare. Diga em uma frase o que está revisando.
2. **Encontre a intenção.** Procure o que a mudança deveria fazer: caminho indicado pelo usuário, spec relacionada em `docs/prd/` (incluindo **Fora do escopo**), issues citadas nos commits ou o pedido na conversa. Se não houver nenhuma fonte, revise só correção e qualidade e diga isso no relatório.
3. **Procure bugs.** Leia o diff e o código ao redor que ele afeta, não só as linhas alteradas. Priorize o que quebra em uso real: lógica errada, casos limite, nulos e listas vazias, tratamento de erro, concorrência, permissões, dados sensíveis expostos, migrações que perdem dados, chamadas que mudaram de contrato sem atualizar quem as usa.
4. **Compare com a intenção.** Aponte requisitos ausentes, comportamento diferente do pedido e escopo extra. Cite o trecho da spec e o trecho do código.
5. **Avalie a qualidade.** Só o que tem custo concreto: duplicação de algo que já existe no projeto, complexidade desnecessária, nomes que enganam, desvio das convenções do repositório. Não aponte preferências de estilo que o linter ou o projeto não exigem.
6. **Verifique antes de reportar.** Para cada achado, confirme no código que o problema acontece: descreva a entrada ou o estado que leva ao erro. O que não conseguir confirmar, reporte como "possível" ou descarte. Se houver subagentes, você pode dividir os passos 3–5 entre eles, mas verifique os achados você mesmo.

## Relatório

Ordene por severidade e não repita o mesmo problema em seções diferentes.

```markdown
Revisado: [o que foi comparado] · Intenção: [fonte ou "nenhuma encontrada"]

## Bugs
- **[arquivo:linha]** [problema] — [cenário que dispara] — [correção sugerida]

## Aderência à spec
- **[arquivo:linha ou spec]** [falta, desvio ou escopo extra]

## Qualidade
- **[arquivo:linha]** [problema e custo concreto]

Resumo: [N bugs, N desvios, N de qualidade] — [o que bloqueia o merge, se algo]
```

Omita seções sem achados, mas deixe claro quando nada foi encontrado. Seja direto: um achado por linha, sem elogios nem resumo do diff.
