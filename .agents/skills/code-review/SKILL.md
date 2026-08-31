---
name: code-review
description: "Review the changes since a fixed point (commit, branch, tag, or merge-base) along two axes: Standards (does the code follow this repo's documented coding standards?) and Spec (does the code match what the originating issue/spec asked for?). Runs both reviews in parallel sub-agents and reports them side by side. Use when the user wants to review a branch, a PR, work-in-progress changes, or asks to \"review since X\"."
disable-model-invocation: true
---

# Code Review (2 eixos)

## Ativação

Use somente com `/code-review`.

Se o usuário chamar por outro caminho, recuse e instrua: "Use `/code-review` para iniciar esta skill."

## Pré-requisitos

- Existe `docs/agents/issue-tracker.md` no repo? Se **não** existir, pare e diga ao usuário para executar `/setup-matt-pocock-skills`.

## Objetivo

Fazer uma revisão do diff entre `HEAD` e um **ponto fixo** fornecido pelo usuário, em duas frentes separadas:

- **Standards**: conformidade com as convenções/documentação de escrita do repo + smell baseline (heurísticas de Fowler).
- **Spec**: conformidade com o que a issue/spec original pediu.

As duas frentes devem ser analisadas por **sub-agentes em paralelo** e reportadas lado a lado, sem reranking entre eixos.

## Process

### 1. Fixar o ponto de comparação

Whatever o usuário disser é o “fixed point” (commit SHA, branch name, tag, `main`, `HEAD~5`, etc.). Se o usuário não indicar, **pergunte** qual ponto fixo usar.

Com o fixed point definido:

1. Capture **uma** comparação de diff (triple-dot para comparar contra merge-base):
   - `git diff <fixed-point>...HEAD`
2. Capture a lista de commits:
   - `git log <fixed-point>..HEAD --oneline`
3. Confirme que o fixed point resolve:
   - `git rev-parse <fixed-point>`
4. Confirme que o diff não é vazio. Se o diff for vazio, falhe aqui (não deixe quebrar dentro dos sub-agentes).

### 2. Identificar a origem da spec

Procure a spec em ordem:

1. Referências de issue nos commits (ex: `#123`, `Closes #45`, GitLab `!67`) via workflow em `docs/agents/issue-tracker.md`.
2. Um caminho que o usuário passou como argumento.
3. Um arquivo de spec em `docs/`, `specs/`, ou `.scratch/` que bata com o nome do branch/feature.
4. Se não achar nada:
   - Peça ao usuário onde está a spec.
   - Se o usuário disser que não há spec, o sub-agente **Spec** deve pular e reportar "no spec available".

### 3. Identificar fontes de Standards

Considere arquivos que documentam como o código deve ser escrito, como `CODING_STANDARDS.md` ou `CONTRIBUTING.md`.

Além disso, o eixo **Standards** sempre carrega o smell baseline abaixo (heurísticas de Fowler, ch.3) mesmo que o repo não documente nada.

Regras de baseline:

- **The repo overrides.** Um standard documentado no repo sempre vence: onde ele endossa algo que o baseline flagaria, suprime o smell.
- **Always a judgement call.** Cada smell é um “possível problema” (heurística), nunca violação hard.
- Como qualquer standard aqui: se uma ferramenta do repo já enforca algo, ignore aquilo.

Smell baseline (Fowler, ch.3) — use este texto para orientar os achados:

- **Mysterious Name**: a function, variable, or type whose name doesn't reveal what it does or holds. → rename it; if no honest name comes, the design's murky.
- **Duplicated Code**: the same logic shape appears in more than one hunk or file in the change. → extract the shared shape, call it from both.
- **Feature Envy**: a method that reaches into another object's data more than its own. → move the method onto the data it envies.
- **Data Clumps**: the same few fields or params keep travelling together (a type wanting to be born). → bundle them into one type, pass that.
- **Primitive Obsession**: a primitive or string standing in for a domain concept that deserves its own type. → give the concept its own small type.
- **Repeated Switches**: the same `switch`/`if`-cascade on the same type recurs across the change. → replace with polymorphism, or one map both sites share.
- **Shotgun Surgery**: one logical change forces scattered edits across many files in the diff. → gather what changes together into one module.
- **Divergent Change**: one file or module is edited for several unrelated reasons. → split so each module changes for one reason.
- **Speculative Generality**: abstraction, parameters, or hooks added for needs the spec doesn't have. → delete it; inline back until a real need shows.
- **Message Chains**: long `a.b().c().d()` navigation the caller shouldn't depend on. → hide the walk behind one method on the first object.
- **Middle Man**: a class or function that mostly just delegates onward. → cut it, call the real target direct.
- **Refused Bequest**: a subclass or implementer that ignores or overrides most of what it inherits. → drop the inheritance, use composition.

### 4. Rodar dois sub-agentes em paralelo

Inicie **dois sub-agentes**:

1. **Standards sub-agent**
   - Deve receber: o diff command, a lista de commits, a lista de standards-source files que você encontrou, e o smell baseline (copiar o bloco acima integralmente).
   - Prompt do sub-agente (copiar/usar exatamente este briefing, apenas ajustando a parte dos caminhos e commands):

     Report, per file/hunk where relevant, (a) every place the diff violates a documented standard: cite the standard (file + the rule); and (b) any baseline smell you spot: name it and quote the hunk. Distinguish hard violations from judgement calls: documented-standard breaches can be hard, but baseline smells are always judgement calls, and a documented repo standard overrides the baseline. Skip anything tooling already enforces. Under 400 words.

2. **Spec sub-agent**
   - Deve receber: o diff command, a lista de commits, e o conteúdo do spec (ou o path e o conteúdo relevante que você coletou).
   - Prompt do sub-agente (copiar/usar exatamente este briefing, apenas ajustando a parte da spec):

     Report: (a) requirements the spec asked for that are missing or partial; (b) behaviour in the diff that wasn't asked for (scope creep); (c) requirements that look implemented but where the implementation looks wrong. Quote the spec line for each finding. Under 400 words.

Se a spec estiver ausente, rode o sub-agente Spec, mas ele deve **pular** e reportar que não há spec disponível.

### 5. Agregar (resultado final)

Apresente as respostas em duas seções:

- `## Standards`
- `## Spec`

Regra: **não** misture ou reranke achados entre eixos. Retorne os dois relatórios como “verbatim” (ou levemente limpos).

Finalize com:

- Uma linha única com: total de findings por eixo e o pior issue dentro de cada eixo (se houver).

## Notas de escopo

- Standards e Spec devem ser avaliados somente com base no diff e nas fontes de standards/spec que foram encontradas.
- Sempre que houver dúvida de “violação vs heurística”, trate como judgement call (baseline smells) e destaque.

