---
name: handoff
description: Compacta a conversa atual num documento de handoff para outro agente continuar. Use somente com /handoff.
argument-hint: "Para que serve a próxima sessão?"
disable-model-invocation: true
---

# Handoff

Escreva um documento de handoff resumindo a conversa atual para um agente fresco continuar o trabalho. Salve no diretório temporário do SO do usuário — **não** no workspace atual.

Inclua uma seção **Skills sugeridas**, nomeando quais skills o próximo agente deve invocar.

Não duplique conteúdo já capturado em outros artefatos (specs, planos, ADRs, issues, commits, diffs). Referencie por path ou URL.

Antes de gravar, remova ou mascare informações sensíveis (API keys, senhas, PII), substituindo os valores por `[REDACTED]`. Confira que nenhum desses valores permaneceu no documento.

Se o usuário passou argumentos, trate-os como descrição do foco da próxima sessão e ajuste o documento a isso.

Ao terminar, informe o caminho absoluto do arquivo.
