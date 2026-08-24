# Visão geral do produto

> Última atualização: 2026-08-23

Sistema web para **um único condomínio** registrar, acompanhar e comentar ocorrências do dia a dia (manutenção, limpeza, segurança, barulho e outras).

## Problema

Relatos de problemas do prédio costumam ficar espalhados (conversa, papel, mensagem), sem histórico único, sem status e sem fotos organizadas. Moradores não sabem se algo já foi aberto ou se andou. Funcionários não têm uma fila clara do que está aberto, em andamento ou resolvido.

## Solução

O produto concentra o ciclo: **abrir → acompanhar → comentar → resolver** (ou reabrir).

## Público-alvo

- **Moradores** cadastrados (nome, e-mail, torre/apartamento, telefone).
- **Funcionários** do condomínio (administração, zeladoria e equivalentes), todos com os **mesmos poderes** neste recorte.

Não é para o público geral nem para síndicos de outros condomínios.

## Áreas do sistema

| Área | Rota | Acesso |
|------|------|--------|
| Página inicial | `/` | Escolha entre dashboard ou morador |
| Dashboard | `/dashboard/*` | Funcionário com e-mail e senha (Supabase Auth) |
| Morador | `/morador/*` | Morador com e-mail cadastrado e ativo (sem senha) |

## Funcionalidades principais

### Funcionário (dashboard)

- Login com e-mail e senha
- Listagem e detalhe de **todas** as ocorrências, com filtros por status e categoria
- Alteração de status: Aberta, Em andamento, Resolvida (pode reabrir)
- Comentários em qualquer status; edição só do próprio comentário; exclusão de qualquer comentário
- Exclusão de qualquer ocorrência
- Cadastro, edição e desativação de moradores, categorias e funcionários

### Morador

- Login apenas com e-mail cadastrado e ativo
- Listagem de **todas** as ocorrências do condomínio (não só as próprias)
- Abertura de nova ocorrência: título, descrição, categoria, local e até 5 fotos opcionais
- Comentários em ocorrências não resolvidas
- Exclusão apenas de ocorrências **criadas por ele** e **não resolvidas**

## Regras de negócio (resumo)

- Um condomínio por instância; sem multi-inquilino.
- E-mail único por papel; o mesmo e-mail não pode ser funcionário e morador.
- Status possíveis: `open` (Aberta), `in_progress` (Em andamento), `resolved` (Resolvida).
- Código público automático: `OC-1001`, `OC-1002`, …
- Em ocorrência **Resolvida**, o morador não comenta, não exclui a ocorrência e não edita nem exclui comentários.
- Comentário: só o **autor** edita; o autor ou um **funcionário** exclui. Em Resolvida o funcionário edita só o próprio e pode excluir qualquer um.
- Morador desativado não entra; ocorrências antigas permanecem visíveis.
- Não é possível desativar o último funcionário ativo.

## Documentação relacionada

- [Arquitetura](./architecture.md) — stack, camadas e decisões técnicas
- [Design](./DESIGN.md) — identidade visual Civic Horizon
