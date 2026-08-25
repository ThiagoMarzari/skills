# Prompt — /prd-generator

Cole o bloco no chat, **incluindo** a primeira linha. A skill só roda com `/prd-generator`.

Quanto mais você preencher (problema, público, ações, regras, fora de escopo), menos ela pergunta. O que não souber, omita.

Há dois exemplos: **produto novo** (INICIAL) e **funcionalidade em projeto existente** (FEATURE).

---

## Exemplo — produto novo (ocorrências de condomínio)

```text
/prd-generator

Modo: INICIAL (produto do zero).

## Ideia
Sistema web para **um condomínio** registrar, acompanhar e comentar ocorrências do dia a dia (manutenção, limpeza, segurança, barulho, etc.).

## Problema
Hoje os relatos ficam espalhados (conversa, papel, mensagem). Não há histórico único, status nem fotos organizadas. Morador não sabe se algo já foi aberto ou se andou. Funcionário não tem fila clara do que está aberto, em andamento ou resolvido.

## Público
- Moradores cadastrados (não é o público geral).
- Funcionários do condomínio (administração, zeladoria e equivalentes).
Não é multi-condomínio nem para síndicos de outros prédios.

## Ações

Morador (entra só com e-mail já cadastrado e ativo — sem senha):
- Listar ocorrências do condomínio, com filtro por status e categoria
- Abrir ocorrência: título, descrição, categoria, local, foto opcional
- Ver detalhe
- Comentar na ocorrência

Funcionário (área dashboard; só eles usam):
- Cadastrar moradores: nome completo, e-mail, torre/apartamento, telefone (sem senha)
- Acessar o mesmo ciclo de ocorrências (lista, filtro, detalhe, comentário)
- Login do funcionário: ainda não fechei — sugestão: e-mail e senha

Há um link/entrada para a área do morador (e-mail) e outra para o dashboard.

## Essencial agora
- Cadastro de moradores pelo funcionário
- Abrir / listar / filtrar / detalhar ocorrência
- Foto opcional na abertura
- Comentários no detalhe
- Duas áreas: dashboard (funcionário) e morador (e-mail)

## Pode ficar para depois (confirmar)
- Morador editar ou excluir a própria ocorrência
- App mobile
- Notificações (e-mail/push)
- Vários condomínios na mesma instância

## Fora do escopo agora
- Auto-cadastro do morador
- Senha para morador
- Pagamento, boleto, reservas de espaço, assembleia

## Regras (as que já fechei)
- Um condomínio por instância
- Morador só entra se o e-mail estiver cadastrado e ativo
- Ocorrência tem categoria e local
- Foto é opcional na abertura

## Regras ainda em aberto (a skill deve perguntar, não inventar)
- Quais status existem (ex.: aberta / em andamento / resolvida)?
- Morador vê todas as ocorrências do prédio ou só as que ele abriu?
- Quem pode comentar quando a ocorrência está resolvida?
- Funcionário altera status? exclui ocorrência? cadastra categorias e outros funcionários?
- Limite de fotos e tamanho?

## Fluxos principais
1. Funcionário cadastra o morador → morador acessa com o e-mail → vê a lista e abre uma ocorrência (com foto se quiser).
2. Morador ou funcionário abre o detalhe → lê o histórico → adiciona comentário.
3. Funcionário usa o dashboard para acompanhar a fila (lista + filtros).

## Como saber que está bom
- Morador cadastrado entra com o e-mail e abre uma ocorrência com categoria, local e foto opcional
- Dá para listar e filtrar por status e categoria
- No detalhe dá para comentar
- Quem não é funcionário não entra no dashboard
- E-mail não cadastrado (ou inativo) não entra na área do morador
```

Troque o domínio pelo seu; mantenha as seções.

---

## Exemplo — funcionalidade (editar e excluir ocorrência)

Use quando o produto **já existe**. Cite o que já tem; descreva só o recorte da feature. A skill detecta a stack do projeto — não peça Next/Nest de novo.

```text
/prd-generator

Modo: FEATURE.

## Feature
Permitir que o **morador** edite ou exclua uma ocorrência **criada por ele**, e que o **funcionário** exclua qualquer ocorrência pelo dashboard.

## Contexto (já existe)
Sistema de ocorrências de um condomínio:
- Morador entra com e-mail cadastrado; lista, abre, vê detalhe e comenta
- Funcionário usa o dashboard; cadastra moradores; lista, filtra, detalha e comenta
- Ocorrência tem categoria, local, foto opcional na abertura, status (aberta / em andamento / resolvida)
- Comentários no detalhe

Não reinventar login, cadastro de morador nem a abertura de ocorrência.

## Problema
Depois de abrir, o morador não consegue corrigir um erro (categoria errada, foto que não era para ir) nem tirar um relato que abriu por engano. Funcionário também não consegue remover ocorrência duplicada ou ofensiva. Hoje isso vira comentário solto ou conversa fora do sistema.

## Público desta feature
- Moradores que já abrem ocorrência
- Funcionários no dashboard

## Ações
Morador:
- Editar título, descrição, categoria, local e foto da ocorrência que **ele** criou
- Excluir a ocorrência que **ele** criou

Funcionário:
- Excluir qualquer ocorrência (não só as próprias)

## Essencial agora
- Editar ocorrência própria (morador)
- Excluir ocorrência própria (morador)
- Excluir qualquer ocorrência (funcionário)
- Impedir a ação quando a regra bloquear, com mensagem clara

## Pode ficar para depois
- Funcionário editar ocorrência de outro autor
- Histórico de edições
- Restaurar ocorrência excluída

## Fora do escopo desta feature
- Mudança de status (já existe ou fica para outro PRD)
- Comentários: editar/excluir comentário
- Notificações
- Novo tipo de ocorrência ou nova área do app

## Regras (as que já fechei)
- Morador só edita/exclui ocorrência **criada por ele**
- Em status **resolvida**, o morador não edita e não exclui
- Funcionário pode excluir em qualquer status
- Excluir some da lista (não precisa de “lixeira” agora)

## Regras ainda em aberto (a skill deve perguntar, não inventar)
- Excluir é definitivo ou só esconde?
- E os comentários e fotos da ocorrência excluída?
- Morador pode trocar a foto na edição? remover a foto?
- Precisa confirmar antes de excluir?

## Fluxos principais
1. Morador abre o detalhe de uma ocorrência **dele**, ainda não resolvida → edita os campos → salva → vê o detalhe atualizado.
2. Morador no detalhe de uma ocorrência **dele**, ainda não resolvida → confirma exclusão → volta para a lista; a ocorrência não aparece mais.
3. Funcionário no detalhe de qualquer ocorrência → confirma exclusão → some da lista dos dois lados (dashboard e morador).
4. Morador tenta editar/excluir ocorrência resolvida ou de outra pessoa → o sistema impede.

## Como saber que está bom
- Morador corrige uma ocorrência aberta criada por ele e o detalhe mostra o novo texto
- Morador exclui a própria ocorrência não resolvida e ela some da lista
- Morador não consegue editar/excluir ocorrência resolvida nem a de outro morador
- Funcionário exclui qualquer ocorrência e ela some para morador e para o dashboard
- Login, listagem, filtros, abertura e comentários continuam iguais
```

No FEATURE: não descreva o produto inteiro de novo. Âncora no que já existe; a skill completa o resto.
