---
name: rework-commits
description: Reorganiza uma branch em commits pequenos e semanticamente separados, preservando o conteúdo da alteração. Use somente com /rework-commits ou quando o usuário pedir explicitamente para dividir ou reorganizar commits.
disable-model-invocation: true
---

# Reorganização de commits

## Objetivo

Transforme uma branch em uma sequência de commits pequenos, coerentes e fáceis de revisar, sem perder nem alterar o comportamento da alteração original.

Esta skill reescreve o histórico. Só execute com pedido explícito do usuário.

## Proteções

- Não execute se houver alterações não commitadas.
- Não execute na branch principal.
- Confirme que a branch de destino e a base estão identificadas.
- Informe o hash do commit atual antes de qualquer operação destrutiva.
- Faça uma cópia do diff original antes de reescrever o histórico.
- Não force push. Se a branch já tiver sido publicada, avise que a reescrita exigirá uma decisão explícita sobre a atualização remota.
- Se qualquer validação falhar, pare sem alterar o histórico.

## Etapa 1 — Verificar o estado

1. Consulte o status da branch.
2. Confirme a branch atual e a branch base.
3. Verifique se a branch está baseada na base esperada.
4. Confirme que não há rebase ou operação de Git em andamento.
5. Registre o hash atual como ponto de recuperação.

**Conclua quando:** o repositório estiver limpo, a branch for segura para reescrita e o ponto de recuperação tiver sido informado ao usuário.

## Etapa 2 — Preservar a alteração original

1. Salve o diff completo em `/tmp/original-diff.patch`.
2. Registre a lista de commits entre a base e `HEAD`.
3. Leia todas as alterações e agrupe-as por unidade lógica.

Não use esse arquivo temporário como destino permanente e não o inclua em um commit.

**Conclua quando:** houver uma cópia verificável da alteração original e uma divisão proposta em commits.

## Etapa 3 — Planejar os commits

Crie uma sequência em que cada commit:

- representa uma mudança lógica única;
- seja compreensível isoladamente;
- explique o motivo da mudança;
- preserve a ordem de dependências.

Quando a arquitetura do projeto permitir, use esta ordem geral:

1. banco de dados e modelos;
2. backend e regras de negócio;
3. frontend e integração;
4. testes e documentação relacionados.

Adapte a ordem ao projeto; não crie commits artificiais para obedecer à lista.

**Conclua quando:** cada alteração estiver atribuída a um commit e a sequência puder ser aplicada sem deixar etapas incoerentes.

## Etapa 4 — Reescrever e validar

1. Apresente o plano de commits ao usuário antes de reescrever o histórico.
2. Só prossiga após confirmação explícita.
3. Reorganize os commits usando os comandos de Git apropriados.
4. Use `GIT_EDITOR=true` quando um comando puder abrir um editor interativo.
5. Compare o diff final com `/tmp/original-diff.patch`.
6. Verifique que nenhum arquivo ou comportamento foi perdido.
7. Execute as validações disponíveis no projeto.
8. Remova `/tmp/original-diff.patch` somente depois de a comparação passar.

Se a comparação falhar, pare, informe o hash de recuperação e não tente corrigir com operações destrutivas adicionais sem autorização.

**Conclua quando:** a sequência de commits estiver criada, o diff final corresponder ao original e as validações tiverem passado ou suas falhas estiverem registradas.

## Entrega

Informe:

- os commits criados e seu propósito;
- as validações executadas;
- eventuais falhas ou limitações;
- o hash de recuperação, enquanto ainda for útil.
