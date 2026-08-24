# PRD — Sistema de Ocorrências do Condomínio

> Tipo: PRD inicial · Data: 2026-08-22
# Status do PRD: Implementada
>
> <!-- Valores possíveis: "Aguardando implementação" | "Implementada". Atualize para "Implementada" quando todas as specs estiverem concluídas. -->

## 1. Visão geral

Sistema web para **um único condomínio** registrar, acompanhar e comentar ocorrências do dia a dia (manutenção, limpeza, segurança, barulho e outras).

Há duas áreas:

- **Dashboard** — só para **funcionários** (e-mail e senha). Lá eles gerenciam moradores, funcionários e categorias, veem todas as ocorrências, mudam status, comentam e podem excluir qualquer ocorrência. O casco visual é **sidebar + conteúdo**, no padrão da seção 10.
- **Área do morador** — acesso por um **link próprio**. O morador informa o **e-mail já cadastrado** (sem senha) e passa a listar ocorrências, abrir nova, ver detalhe, comentar e excluir as que ele mesmo criou (com restrições). Mesma identidade visual, navegação mais curta.

O sistema não é uma plataforma para vários condomínios.

A aparência segue a identidade **Civic Horizon** descrita em `docs/DESIGN.md`. O layout de referência da administração é o mockup de **Gestão de Ocorrências** (sidebar, cards de resumo, filtros, tabela) — detalhes e o que **não** copiar do mockup estão na seção 10.

## 2. Problema que resolve

Hoje o relato de problemas do prédio costuma ficar espalhado (conversa, papel, mensagem), sem histórico único, sem status e sem fotos organizadas. Morador não sabe se algo já foi aberto ou se andou. Funcionário não tem uma fila clara do que está aberto, em andamento ou resolvido.

Este produto concentra o ciclo: abrir → acompanhar → comentar → resolver (ou reabrir).

## 3. Público-alvo

- **Moradores** cadastrados do condomínio (nome, e-mail, torre/apartamento, telefone).
- **Funcionários** do condomínio (administração, zeladoria e equivalentes), todos com os **mesmos poderes** neste recorte.

Não é para o público geral, nem para síndicos de outros condomínios.

## 4. Objetivo do recorte atual

Entregar o V1 usável: funcionários entram no dashboard e preparam cadastros; moradores entram pelo e-mail e operam ocorrências e comentários, com regras de status, exclusão e fotos opcionais.

## 5. Funcionalidades

**Essenciais:**

- Login de funcionário com e-mail e senha, e dashboard restrito
- Sistema nasce com um funcionário administrador já existente; funcionários cadastram os demais
- Cadastro, edição e desativação de moradores (nome completo, e-mail, torre/apartamento, telefone)
- Acesso do morador só com e-mail cadastrado e ativo (sem senha, sem envio de link)
- Categorias com lista inicial (Manutenção, Limpeza, Segurança, Barulho, Outros); funcionário cadastra, edita e desativa
- Morador abre ocorrência: título, descrição, categoria, local (texto), até 5 fotos opcionais (somente imagem)
- Listagem de **todas** as ocorrências para morador e funcionário, com filtro por status e por categoria
- Detalhe da ocorrência (dados, autor, status, fotos, comentários)
- Funcionário altera status: Aberta, Em andamento, Resolvida (pode voltar de Resolvida)
- Morador exclui só ocorrência que ele criou, e somente se **não** estiver Resolvida
- Funcionário exclui qualquer ocorrência
- Comentários no detalhe; só o **autor** edita; o autor ou um **funcionário** exclui; comentário editado exibe indicação de “editado”
- Em ocorrência Resolvida, morador não comenta, não exclui e não altera comentários; funcionário ainda comenta, muda status, edita só o próprio comentário e pode excluir qualquer um
- Morador desativado não entra e não age; ocorrências antigas continuam visíveis na lista

**Desejáveis:**

- Confirmação explícita antes de excluir ocorrência ou comentário
- Na listagem, indicar quantidade de comentários
- Ampliar foto no detalhe

## 6. Fora do escopo

- Aplicativo mobile nativo
- Notificação por e-mail, SMS ou WhatsApp
- Vários condomínios / multi-inquilino
- Reserva de áreas, boletos, visitantes, assembleia, correspondências
- Relatórios e exportação PDF
- Atribuir ocorrência a um funcionário específico
- Perfis diferentes entre funcionários (admin vs. operador)
- Recuperação de senha do funcionário
- Login do morador com senha ou link mágico enviado por e-mail
- Funcionário abrir ocorrência (neste recorte, só o morador abre)
- Editar título, descrição, categoria, local ou fotos depois que a ocorrência foi criada
- Histórico completo de edições do comentário (vale só o indicador “editado”)
- Busca por texto livre na listagem

## 7. Regras de negócio

- Regra 1: O produto atende **um** condomínio. Não há escolha de condomínio no login.
- Regra 2: Existem dois papéis: **funcionário** e **morador**. Funcionários não usam a área do morador (a menos que também estejam cadastrados como moradores, com o mesmo e-mail — o sistema deve **impedir** o mesmo e-mail como funcionário e como morador).
- Regra 3: Todo funcionário tem os mesmos poderes.
- Regra 4: O sistema nasce com **um** funcionário administrador já cadastrado, capaz de entrar e cadastrar os outros.
- Regra 5: Funcionário entra com e-mail e senha. Morador entra **somente** com e-mail cadastrado e **ativo**, sem senha.
- Regra 6: E-mail de morador é único. E-mail de funcionário é único.
- Regra 7: Morador vê **todas** as ocorrências do condomínio, não só as suas.
- Regra 8: Só **morador ativo** abre ocorrência. Funcionário não abre.
- Regra 9: Categoria da ocorrência é obrigatória e precisa estar **ativa** no momento da abertura.
- Regra 10: Local é texto livre obrigatório.
- Regra 11: Fotos são opcionais, no máximo **5**, somente arquivo de imagem. Sem foto a ocorrência é válida.
- Regra 12: Status possíveis: **Aberta**, **Em andamento**, **Resolvida**. Toda ocorrência nasce **Aberta**.
- Regra 13: Só **funcionário** troca status. Pode ir para qualquer um dos três, inclusive voltar de Resolvida para Em andamento ou Aberta.
- Regra 14: Morador **não** troca status em hipótese alguma.
- Regra 15: Morador só exclui ocorrência **criada por ele** e somente se o status **não** for Resolvida (Aberta e Em andamento podem ser excluídas pelo autor).
- Regra 16: Em status **Resolvida**, o morador não exclui, não comenta, não edita nem exclui comentários daquela ocorrência.
- Regra 17: Funcionário pode excluir **qualquer** ocorrência, em qualquer status.
- Regra 18: Qualquer morador autenticado pode comentar em ocorrência **não** Resolvida. Funcionário pode comentar em qualquer status, inclusive Resolvida.
- Regra 19: Depois de enviado, o comentário só pode ser **editado** pelo **autor**. Pode ser **excluído** pelo **autor** ou por um **funcionário**. Os demais moradores não mexem. Exceção: se a ocorrência estiver Resolvida, o morador (mesmo autor) não edita nem exclui; o funcionário edita somente o próprio comentário e pode excluir qualquer um.
- Regra 20: Comentário editado deve exibir, ao lado, a indicação de que **foi editado**.
- Regra 21: Categoria desativada não pode ser usada em **nova** ocorrência; ocorrências antigas mantêm o nome da categoria e continuam filtráveis por ela.
- Regra 22: Morador desativado não faz login, não abre ocorrência, não comenta e não exclui. Ocorrências e comentários já feitos **permanecem** visíveis.
- Regra 23: Não é permitido desativar o **último** funcionário ativo (o condomínio não pode ficar sem ninguém no dashboard).
- Regra 24: Exclusão de ocorrência remove também seus comentários e fotos do ponto de vista do usuário (deixam de aparecer).
- Regra 25: A listagem padrão mostra as ocorrências **mais recentes primeiro**. Filtros de status e categoria combinam (os dois ao mesmo tempo). “Todos” em cada filtro mostra o conjunto completo daquele critério.
- Regra 26: A lista de ocorrências (funcionário e morador) segue o layout da seção 10: cards de resumo, tabela com código visível, badges **Aberta / Em andamento / Resolvida**, paginação, ação de ver detalhe. Sem busca textual.

## 8. Fluxos principais

### Fluxo 1 — Funcionário entra e prepara o condomínio

1. Funcionário acessa a área do dashboard.
2. Informa e-mail e senha.
3. Entra no dashboard.
4. Cadastra categorias extras se precisar (já existem as iniciais).
5. Cadastra moradores (nome, e-mail, torre/apartamento, telefone).
6. Se precisar, cadastra outros funcionários.

### Fluxo 2 — Morador entra

1. Morador acessa o **link da área do morador**.
2. Informa o e-mail cadastrado.
3. Se o e-mail existir e o morador estiver ativo, entra.
4. Vê a lista de ocorrências (todas) e pode filtrar.

### Fluxo 3 — Morador abre ocorrência

1. Morador autenticado escolhe abrir nova ocorrência.
2. Preenche título, descrição, categoria (ativas), local; opcionalmente anexa até 5 imagens.
3. Confirma.
4. A ocorrência nasce com status Aberta e aparece na lista para todos.

### Fluxo 4 — Acompanhar, comentar e (se for o caso) excluir

1. Morador ou funcionário abre o detalhe de uma ocorrência.
2. Lê dados, fotos e comentários.
3. Se a ocorrência não estiver Resolvida, o morador pode comentar. O funcionário pode comentar sempre.
4. Só o autor do comentário pode editar o texto. O autor ou um funcionário pode excluir (morador não, se estiver Resolvida; funcionário edita só o próprio em qualquer status).
5. Se o morador for o autor da ocorrência e ela não estiver Resolvida, pode excluí-la (com confirmação).
6. Funcionário pode excluir qualquer uma (com confirmação).

### Fluxo 5 — Funcionário trata a ocorrência

1. Funcionário vê a lista, filtra por status e/ou categoria.
2. Abre o detalhe.
3. Comenta se precisar.
4. Altera o status para Em andamento ou Resolvida.
5. Se preciso, volta de Resolvida para Em andamento ou Aberta.

### Fluxo 6 — Morador desativado

1. Funcionário desativa o morador.
2. Esse morador, ao tentar entrar com o e-mail, é recusado.
3. Ocorrências e comentários antigos dele continuam visíveis para os demais.

## 9. Critérios de aceite

- O funcionário consegue entrar com e-mail e senha e usar só o dashboard.
- O morador consegue entrar só com e-mail cadastrado e ativo, pelo link da área do morador.
- O sistema impede login de morador com e-mail inexistente, inativo ou de funcionário que não seja morador.
- O morador consegue abrir ocorrência com categoria, local, título, descrição e 0 a 5 imagens.
- O morador e o funcionário conseguem listar todas as ocorrências e filtrar por status e categoria.
- O usuário consegue abrir o detalhe, ver fotos e comentar (respeitando as regras de Resolvida).
- O sistema deve impedir o morador de trocar status.
- O sistema deve impedir o morador de excluir ou comentar ocorrência Resolvida.
- O sistema deve permitir que o funcionário volte o status de Resolvida para Em andamento ou Aberta.
- Quando um comentário é editado, o sistema deve exibir a indicação de “editado”.
- O sistema não deve permitir mais de 5 fotos, nem arquivo que não seja imagem.
- Quando o morador é desativado, o sistema não deve deixá-lo entrar.
- O sistema não deve permitir o mesmo e-mail como funcionário e como morador.
- O dashboard do funcionário segue o casco da seção 10 (sidebar, conteúdo, tabela de ocorrências com badges de status).
- A interface usa a identidade Civic Horizon (`docs/DESIGN.md`): tipografia Inter, cores primary/surface, raios e espaçamentos dali — não uma paleta genérica nem serif nos títulos.

## 10. Interface, layout e design

Fonte de verdade visual: **`docs/DESIGN.md`** (identidade **Civic Horizon**).  
Fonte de verdade de **casco** da administração: mockup da tela **Gestão de Ocorrências** (sidebar à esquerda, header, cards, filtros, tabela).

O mockup ilustra estrutura e densidade. **Regras de negócio deste PRD prevalecem** quando o mockup divergir (ver “O que o mockup mostra e o V1 não faz”).

### 10.1 Identidade Civic Horizon

Usar os tokens do design, em alto nível:

- **Primária:** azul-marinho profundo (`primary` `#00355f`, texto `on-primary` branco). Botão principal, item ativo da sidebar, ações primárias.
- **Superfícies:** fundo da página `background` / `surface` (`#f7fafc`); cards e tabela em `surface-container-lowest` (branco); faixas suaves (`surface-container-low` / `surface-container`) em cabeçalho de tabela e item ativo da nav.
- **Texto:** `on-surface` (`#181c1e`) para títulos e dados; `on-surface-variant` para legendas, subtítulos e metadados.
- **Contorno:** `outline` / `outline-variant` em bordas de input, tabela e divisórias.
- **Erro:** `error` / `error-container` só em falhas e exclusão destrutiva.
- **Tipografia:** **Inter** em todos os níveis (headline, body, label). O mockup usa serif nos números dos cards — **não seguir**: Civic Horizon é só Inter.
- **Raio:** cards e tabela no raio `md`–`lg`; badges e avatar `full`; inputs `DEFAULT`–`md`.
- **Espaço:** grade de 4px; padding de tela `margin-desktop` 40px / `margin-mobile` 16px; gap interno `md`/`lg`.

Componentes visuais no espírito shadcn (card, tabela, input, select, badge, botão, sidebar), pintados com esses tokens — não com cinza-ardósia genérico no lugar do `primary` Civic Horizon.

### 10.2 Casco do dashboard (funcionário)

Depois do login, o funcionário vê um **casco persistente**:

1. **Sidebar esquerda (fixa em desktop)**
   - Topo: marca + nome do condomínio (no mockup: “Residencial Aurora”) e rótulo **Administração**.
   - **Não** há botão “+ Nova Ocorrência” nesta sidebar (só o morador abre ocorrência).
   - Navegação:
     - **Ocorrências** — destino inicial após o login; tela do mockup (gestão).
     - **Cadastro de moradores**
     - **Configurações** — agrupa **Categorias** e **Funcionários** (duas telas; o mockup tem um único item “Configurações”).
   - Rodapé da sidebar: **Sair** (encerra a sessão da Spec 01).
   - Item da página atual: fundo claro (`primary-fixed` / container secundário) e texto `primary`.
   - O mockup tem um item **Dashboard** separado: neste V1 **não** existe home analítica extra. “Ocorrências” é a home.

2. **Header superior**
   - Título da página à esquerda, no conteúdo (ex.: “Gestão de Ocorrências” + subtítulo “Acompanhe e gerencie as solicitações do condomínio”).
   - À direita: identificação do funcionário logado (nome ou iniciais em avatar).
   - **Não** entram neste recorte a busca global “Buscar…”, o sino de notificação nem o atalho “Suporte” do mockup.

3. **Conteúdo principal**
   - Fundo `surface`; blocos em cards brancos, largura confortável, sem encostar nas bordas.

### 10.3 Tela Gestão de Ocorrências (referência do mockup)

Estrutura de cima para baixo, alinhada às Specs 07–10:

1. **Título + subtítulo** da página.
2. **Três cards de resumo** (contagens da lista, não um módulo novo de relatório):
   - Total de ocorrências
   - Abertas + Em andamento (equivalente visual ao “Pendentes / Em análise” do mockup)
   - Resolvidas (**total**, não “no mês” — o recorte mensal do mockup fica de fora para não criar período)
3. **Barra de filtros:** select de **status** (Todos / Aberta / Em andamento / Resolvida) e select de **categoria** (Todas + categorias), ação de aplicar. **Sem** campo “ID, Local ou Descrição” (busca textual está fora do escopo).
4. **Tabela** com colunas:
   - Código visível da ocorrência (formato curto, no espírito `#OC-1042`)
   - Categoria / título (ícone ou marca da categoria + título em destaque + nome da categoria abaixo)
   - Local
   - Autor (nome e torre/apartamento — o mockup omite; **entra** porque o PRD exige transparência de quem abriu)
   - Data
   - Status em **badge** colorido
   - Ação de **ver detalhe** (ícone de olho)
5. **Rodapé da tabela:** “Mostrando X a Y de Z resultados” e paginação.

**Badges de status (mapeamento do mockup → este PRD):**

| Mockup        | Produto (usar este rótulo) | Leitura visual                         |
| ------------- | -------------------------- | -------------------------------------- |
| Pendente      | **Aberta**                 | tom quente (tertiary / âmbar suave)    |
| Em análise    | **Em andamento**           | tom primary suave (azul)               |
| Resolvido     | **Resolvida**              | tom positivo, verde suave e sóbrio     |

Não usar os rótulos do mockup na interface.

### 10.4 Casco da área do morador

Mesma identidade Civic Horizon. Sidebar mais curta:

- Marca + nome do condomínio e rótulo **Moradores** (não “Administração”).
- Ação primária **+ Nova ocorrência** (é aqui que vive o botão que o mockup colocou no admin).
- **Ocorrências** (lista no mesmo espírito: filtros + tabela). **Suposição deste PRD:** o morador também vê os três cards de resumo, com os mesmos critérios da seção 10.3.
- **Sair**.

Sem Cadastro de moradores, sem Configurações, sem busca global, sem sino.

Telas de **login** (funcionário: e-mail e senha; morador: só e-mail): página centrada, card branco, botão primary, sem sidebar. Mesma paleta e Inter.

Telas de **cadastro** (moradores, funcionários, categorias) e **detalhe** da ocorrência: mesmo casco da área (sidebar + conteúdo); o miolo é formulário ou artigo do detalhe (dados, fotos, depois comentários), não a tabela.

### 10.5 O que o mockup mostra e o V1 não faz

- Botão **+ Nova ocorrência** no dashboard do funcionário
- Busca global do header e busca por ID/local/descrição na tabela
- Sino de notificação, Suporte, página Dashboard separada
- Status escritos Pendente / Em análise / Resolvido
- Card “Resolvidas (mês)”
- Tipografia serif nos números

### 10.6 Responsivo

- Desktop: sidebar visível.
- Largura estreita: sidebar recolhe (menu para abrir); tabela pode rolar na horizontal; cards de resumo empilham. Não é app nativo (continua fora do escopo).

## 11. Stack

- Next.js + TypeScript
- Tailwind CSS
- shadcn/ui (casco e componentes da seção 10, com tokens Civic Horizon)
- Supabase (autenticação de funcionários, banco de dados e armazenamento de fotos)
- TanStack Query (dados assíncronos, cache e revalidação da interface)

O login do morador (somente e-mail, sem senha e sem envio de link) é regra de produto sobre essa base — não exige outro provedor.

## 12. Justificativa da stack

O repositório já nasceu em Next.js, TypeScript e Tailwind. Dashboard com login, cadastros e fotos pede auth, banco e storage no mesmo lugar: Supabase cobre isso sem inflar o V1. shadcn/ui é a linguagem de componentes do casco da seção 10 (sidebar, tabela, cards, badges), pintada com **Civic Horizon** (`docs/DESIGN.md`), não com o tema cinza genérico do mockup. TanStack Query trata lista, detalhe e mutações com cache e revalidação, para a UI não parecer travada nem desatualizada.

**Limitação aceita neste recorte:** o acesso do morador só com e-mail é simples e frágil (quem souber o e-mail entra como aquele morador). Foi decisão consciente do V1; link mágico ou senha ficam fora deste recorte.

## 13. Fases de construção

### Fase 1 — Acesso dos funcionários

Objetivo: existir a área do dashboard, com login, casco da seção 10 e gestão da equipe.
Specs:

- Spec 01 — Login e área restrita do funcionário
- Spec 02 — Cadastro e gestão de funcionários

### Fase 2 — Moradores

Objetivo: funcionários cadastrarem moradores e o morador conseguir entrar pelo e-mail.
Specs:

- Spec 03 — Cadastro e gestão de moradores
- Spec 04 — Acesso do morador por e-mail

### Fase 3 — Categorias

Objetivo: haver categorias usáveis na abertura de ocorrência.
Specs:

- Spec 05 — Categorias de ocorrência

### Fase 4 — Ocorrências

Objetivo: ciclo principal sem comentários ainda: abrir, listar, filtrar, ver, mudar status, excluir.
Specs:

- Spec 06 — Abrir ocorrência
- Spec 07 — Listar e filtrar ocorrências
- Spec 08 — Ver detalhe da ocorrência
- Spec 09 — Alterar status da ocorrência
- Spec 10 — Excluir ocorrência

### Fase 5 — Comentários e bloqueios finais

Objetivo: conversa embaixo da ocorrência e regras de morador inativo ponta a ponta.
Specs:

- Spec 11 — Comentários na ocorrência
- Spec 12 — Morador inativo e bloqueios de acesso

## 14. Specs funcionais detalhadas

> Cada spec deve ser autossuficiente: um agente de codificação vai ler SÓ esta spec (mais as dependências) para montar o plano técnico e implementar. Preencha todos os campos; se um não se aplica, escreva "Não se aplica" e o porquê.

### Spec 01 — Login e área restrita do funcionário

- **Fase:** Fase 1 — Acesso dos funcionários
- **Objetivo (o quê):** Permitir que um funcionário entre com e-mail e senha e acesse somente o dashboard. Quem não estiver autenticado como funcionário não vê nem usa essa área.
- **Intenção (por quê):** Separar o trabalho interno (administração) da área do morador. Sem isso, não há como cadastrar moradores nem tratar ocorrências.
- **Contexto:** Produto novo. O sistema precisa nascer com **um funcionário administrador já existente** (definido na preparação do sistema), senão ninguém entra. A área do morador é outro ponto de entrada (Spec 04) e não se mistura com este login. O casco autenticado segue a **seção 10** (sidebar Administração, sem “Nova ocorrência”, sem busca global nem sino).
- **Atores:** Funcionário (incluindo o administrador inicial).
- **Descrição do comportamento:** O funcionário acessa a entrada do dashboard (página centrada, card, identidade Civic Horizon, **sem** sidebar). Informa e-mail e senha e envia. Se as credenciais forem de um funcionário **ativo**, o sistema inicia a sessão e mostra o casco do dashboard: sidebar (marca, “Administração”, Ocorrências, Cadastro de moradores, Configurações, Sair) + header com quem está logado + conteúdo. O destino inicial é **Ocorrências** (não existe página Dashboard separada neste recorte). Se falhar, permanece na entrada e explica o erro sem revelar se o e-mail existe ou não de forma detalhada demais (mensagem genérica de credenciais inválidas). Há ação **Sair** na sidebar: encerra a sessão e volta para a entrada do dashboard. Acessar qualquer parte do dashboard sem sessão válida redireciona para a entrada de funcionário. A área do morador não é acessível por este login.
- **Entradas e saídas:**
  - Entrada: e-mail, senha.
  - Saída em sucesso: sessão de funcionário + dashboard.
  - Saída em falha: permanência na entrada + mensagem de erro.
  - Saída ao sair: sessão encerrada.
- **Dados/entidades envolvidos (conceitual):** Funcionário: nome completo, e-mail, senha, indicador de ativo/inativo. Sessão: quem está autenticado e com qual papel (funcionário).
- **Estados e transições:** Sem sessão → (credenciais válidas de funcionário ativo) → Com sessão de funcionário → (sair ou sessão inválida) → Sem sessão.
- **Regras de negócio:** Só funcionário ativo entra. Morador não entra pelo dashboard mesmo que o e-mail exista na lista de moradores. Funcionário inativo não entra. Mensagem de erro de login é genérica.
- **Validações:** E-mail e senha obrigatórios. E-mail em formato de e-mail. Senha não vazia.
- **Fluxo do usuário (passo a passo):**
  1. Acessa a entrada do dashboard.
  2. Preenche e-mail e senha.
  3. Envia.
  4. Em sucesso, vê o dashboard; em falha, vê erro e tenta de novo.
  5. Usa “sair” quando quiser encerrar.
- **Casos de borda e erros:**
  - Campos vazios: não envia; indica o que falta.
  - E-mail/senha errados: erro genérico.
  - Funcionário inativo: mesmo tratamento de credenciais inválidas (não entra).
  - Já autenticado como funcionário e acessa a entrada: pode ir direto ao dashboard.
  - Autenticado como morador (depois da Spec 04) tentando dashboard: não entra; precisa de sessão de funcionário.
- **Impacto no existente:** Nenhum (primeira peça de acesso).
- **Critérios de aceite (Dado/Quando/Então):**
  - Dado um funcionário ativo com senha correta, quando ele envia e-mail e senha na entrada do dashboard, então entra no dashboard.
  - Dado e-mail ou senha incorretos, quando tenta entrar, então não entra e vê mensagem genérica.
  - Dado que não há sessão de funcionário, quando acessa uma tela do dashboard, então é levado à entrada de funcionário.
  - Dado um funcionário autenticado, quando escolhe sair, então a sessão acaba e a área do dashboard deixa de ser acessível.
  - Dado um funcionário recém-autenticado, quando entra, então vê o casco com sidebar de Administração e a home em Ocorrências, **sem** botão de nova ocorrência, **sem** busca global e **sem** sino de notificação.
- **Definição de pronto:** É possível entrar e sair como o funcionário inicial; o dashboard não abre sem sessão de funcionário; o casco da seção 10 (parte funcionário) está no lugar, mesmo que as telas internas ainda estejam vazias.
- **Dependências:** Nenhuma (o funcionário inicial precisa existir na preparação do sistema, descrito na Spec 02 como cadastro contínuo; o **primeiro** já nasce pronto para este login). Visual: seção 10.
- **Fora do escopo desta spec:** Cadastro de outros funcionários (Spec 02). Login do morador (Spec 04). Recuperação de senha. Tabela de ocorrências preenchida (Spec 07). Busca, notificações e Suporte do mockup.

### Spec 02 — Cadastro e gestão de funcionários

- **Fase:** Fase 1 — Acesso dos funcionários
- **Objetivo (o quê):** Permitir que um funcionário autenticado liste, cadastre, edite dados e desative outros funcionários, mantendo sempre pelo menos um ativo.
- **Intenção (por quê):** O condomínio precisa incluir e remover acesso da equipe sem depender de um único login eterno, mas sem se trancar para fora do dashboard.
- **Contexto:** Depende do login da Spec 01. O sistema já possui o funcionário inicial. Todos os funcionários têm os mesmos poderes, inclusive gerir a equipe.
- **Atores:** Funcionário autenticado.
- **Descrição do comportamento:** No dashboard, em **Configurações → Funcionários** (seção 10), há gestão de funcionários. A lista mostra nome, e-mail e se está ativo. Mesmo casco (sidebar + conteúdo); o miolo é lista/formulário, não a tabela de ocorrências. Ao cadastrar, informa nome completo, e-mail e senha; o novo funcionário nasce **ativo** e já pode entrar pela Spec 01. Ao editar, pode mudar nome; e-mail não deve ser alterado para um e-mail já usado por outro funcionário ou por um morador. Desativar impede novos logins daquela pessoa, mas não apaga o histórico futuro de ações já feitas (quando houver ocorrências/comentários). Não é possível desativar o último funcionário ativo, nem deixar o condomínio sem nenhum funcionário ativo. Não há exclusão definitiva neste recorte — usa-se desativar.
- **Entradas e saídas:**
  - Entrada cadastro: nome completo, e-mail, senha.
  - Entrada edição: nome (e, se permitido, demais dados cadastrais não conflitantes).
  - Entrada desativar: escolha do funcionário.
  - Saída: lista atualizada ou mensagem de erro de validação/regra.
- **Dados/entidades envolvidos (conceitual):** Funcionário: nome completo, e-mail, senha, ativo/inativo, data de criação.
- **Estados e transições:** Ativo → (desativar, se não for o último ativo) → Inativo. Inativo → (reativar) → Ativo. Cadastro novo → sempre Ativo.
- **Regras de negócio:** E-mail único entre funcionários e **não** pode coincidir com e-mail de morador. Último funcionário ativo não pode ser desativado. Funcionário inativo não autentica (Spec 01). Todos têm os mesmos poderes.
- **Validações:** Nome completo obrigatório. E-mail obrigatório e em formato válido. Senha obrigatória no cadastro, com tamanho mínimo razoável (não vazia / não trivialmente curta). Não cadastrar e-mail repetido.
- **Fluxo do usuário (passo a passo):**
  1. Funcionário autenticado abre a gestão de funcionários.
  2. Vê a lista.
  3. Cadastra um novo ou edita/desativa/reativa um existente.
  4. O sistema confirma sucesso ou explica por que recusou.
- **Casos de borda e erros:**
  - E-mail já usado por funcionário ou morador: recusa e explica.
  - Tentativa de desativar o último ativo: recusa e explica.
  - Funcionário tenta desativar a si mesmo sendo o último ativo: recusa. Se houver outros ativos, pode desativar a si mesmo e a sessão dele deve deixar de valer no próximo acesso.
  - Campos inválidos: não grava; mostra erros por campo.
- **Impacto no existente:** Amplia o dashboard da Spec 01 com a gestão de equipe. O login passa a considerar ativos/inativos cadastrados aqui.
- **Critérios de aceite (Dado/Quando/Então):**
  - Dado um funcionário autenticado, quando cadastra outro com dados válidos, então o novo aparece na lista como ativo e consegue entrar no dashboard.
  - Dado um e-mail já usado, quando tenta cadastrar, então o sistema recusa.
  - Dado que existe só um funcionário ativo, quando tenta desativá-lo, então o sistema recusa e ele continua podendo entrar.
  - Dado um funcionário inativo, quando tenta o login da Spec 01, então não entra.
- **Definição de pronto:** Dá para cadastrar um segundo funcionário, entrar com ele, e as regras de último ativo e e-mail único são respeitadas.
- **Dependências:** Spec 01 — sessão de funcionário e dashboard.
- **Fora do escopo desta spec:** Recuperação de senha. Papéis diferentes (admin vs. operador). Gestão de moradores (Spec 03).

### Spec 03 — Cadastro e gestão de moradores

- **Fase:** Fase 2 — Moradores
- **Objetivo (o quê):** Permitir que o funcionário cadastre, edite, liste, desative e reative moradores com nome completo, e-mail, torre/apartamento e telefone.
- **Intenção (por quê):** Só entra na área do morador quem a administração cadastrou. Sem lista de moradores, o acesso por e-mail (Spec 04) não tem base.
- **Contexto:** Dashboard do funcionário (Specs 01 e 02). Ainda não existe login do morador nesta spec; o cadastro é o pré-requisito. Vários moradores podem ter a mesma torre/apartamento (família). E-mail é o identificador de acesso.
- **Atores:** Funcionário autenticado.
- **Descrição do comportamento:** No dashboard, o item **Cadastro de moradores** da sidebar (seção 10) abre a gestão. Lista mostra nome, e-mail, torre/apartamento, telefone e se está ativo. Mesmo casco; tabela ou lista clara no conteúdo. Cadastro exige os quatro dados; o morador nasce **ativo**. Edição permite corrigir nome, torre/apartamento e telefone. E-mail, uma vez cadastrado, **não deve ser trocado** neste recorte (evita furar o acesso de outra pessoa); se precisar “trocar e-mail”, desativa o registro antigo e cadastra outro. Desativar impede o login do morador (Spec 04) e novas ações dele; não apaga ocorrências futuras já criadas. Reativar devolve o acesso. Não há exclusão definitiva de morador neste recorte.
- **Entradas e saídas:**
  - Entrada cadastro: nome completo, e-mail, torre/apartamento, telefone.
  - Entrada edição: nome, torre/apartamento, telefone.
  - Entrada desativar/reativar: escolha do morador.
  - Saída: lista atualizada ou erros de validação.
- **Dados/entidades envolvidos (conceitual):** Morador: nome completo, e-mail, torre/apartamento, telefone, ativo/inativo, data de criação.
- **Estados e transições:** Ativo → desativar → Inativo → reativar → Ativo. Novo cadastro → Ativo.
- **Regras de negócio:** E-mail único entre moradores e **não** pode coincidir com e-mail de funcionário. Torre/apartamento e telefone são obrigatórios. Desativar não remove histórico de ocorrências/comentários (quando existirem).
- **Validações:** Todos os campos de cadastro obrigatórios. E-mail em formato válido. Telefone não vazio. Nome não vazio. Torre/apartamento não vazio. Recusar e-mail duplicado (morador ou funcionário).
- **Fluxo do usuário (passo a passo):**
  1. Funcionário abre a gestão de moradores.
  2. Cadastra ou edita ou desativa/reativa.
  3. Vê a lista refletindo a mudança.
- **Casos de borda e erros:**
  - E-mail duplicado ou de funcionário: recusa e explica.
  - Campos vazios ou e-mail inválido: erros por campo.
  - Editar morador inexistente: informa que não encontrou.
- **Impacto no existente:** Novo módulo no dashboard. Cruza regra de e-mail único com funcionários (Spec 02).
- **Critérios de aceite (Dado/Quando/Então):**
  - Dado um funcionário autenticado, quando cadastra morador com dados válidos, então o morador aparece ativo na lista.
  - Dado um e-mail já usado por morador ou funcionário, quando tenta cadastrar, então recusa.
  - Dado um morador ativo, quando o funcionário o desativa, então ele passa a constar inativo e não poderá autenticar na Spec 04.
  - Dado um morador inativo, quando o funcionário o reativa, então volta a constar ativo.
- **Definição de pronto:** Funcionário consegue completar o ciclo cadastrar → editar contato/unidade → desativar → reativar, com e-mail único respeitado.
- **Dependências:** Spec 01 — dashboard autenticado. Spec 02 — regra de e-mail não coincidir com funcionário (a gestão de funcionários já existe).
- **Fora do escopo desta spec:** Tela de login do morador (Spec 04). Ocorrências. Senha para morador.

### Spec 04 — Acesso do morador por e-mail

- **Fase:** Fase 2 — Moradores
- **Objetivo (o quê):** Dar ao morador um link/área própria em que ele informa só o e-mail cadastrado e, se estiver ativo, entra para usar a área do morador.
- **Intenção (por quê):** Reduzir atrito (sem senha). A administração controla quem entra cadastrando e desativando na Spec 03.
- **Contexto:** Moradores vêm da Spec 03. Dashboard de funcionário permanece separado. **Decisão confirmada:** não envia e-mail mágico; quem souber um e-mail de morador ativo entra como ele. Isso é aceito neste V1. Login: página centrada (seção 10.4). Área autenticada: casco do morador (sidebar com Nova ocorrência, Ocorrências, Sair).
- **Atores:** Morador cadastrado (ativo ou não). Visitante não cadastrado.
- **Descrição do comportamento:** Existe um ponto de entrada distinto do dashboard, pensado para ser o “link dos moradores” (card centrado, só e-mail, Civic Horizon). A pessoa informa o e-mail e envia. Se existir morador **ativo** com aquele e-mail, o sistema inicia sessão de morador e mostra o casco da área do morador: sidebar com marca + rótulo **Moradores**, botão **+ Nova ocorrência**, item **Ocorrências** e **Sair**. Nas specs seguintes: lista, formulário de nova ocorrência, detalhe. Se o e-mail não existir, estiver inativo, ou for só de funcionário, não entra; mostra erro genérico de acesso não autorizado (sem dizer “inativo” vs “não existe”, para não facilitar enumeração). **Sair** encerra a sessão. Sem sessão de morador, as telas da área do morador redirecionam para esta entrada. Sessão de funcionário não abre a área do morador automaticamente.
- **Entradas e saídas:**
  - Entrada: e-mail.
  - Saída sucesso: sessão de morador + área do morador.
  - Saída falha: permanece na entrada + erro genérico.
- **Dados/entidades envolvidos (conceitual):** Morador (e-mail, ativo/inativo). Sessão: papel morador, identidade do morador.
- **Estados e transições:** Sem sessão → e-mail de morador ativo → sessão de morador → sair → sem sessão.
- **Regras de negócio:** Sem senha. Sem envio de e-mail. Só morador ativo. E-mail de funcionário que não seja morador não entra aqui.
- **Validações:** E-mail obrigatório e em formato válido.
- **Fluxo do usuário (passo a passo):**
  1. Acessa o link da área do morador.
  2. Informa o e-mail.
  3. Envia.
  4. Entra na área do morador ou vê erro genérico.
  5. Pode sair.
- **Casos de borda e erros:**
  - E-mail vazio/inválido: não aceita; indica o campo.
  - E-mail inexistente, inativo ou só de funcionário: erro genérico; não entra.
  - Já autenticado como morador: pode ir direto à área logada.
  - Tentativa de usar esta entrada para chegar no dashboard: não concede poderes de funcionário.
- **Impacto no existente:** Cria o segundo ponto de entrada. Não altera o login de funcionário. Desativar morador (Spec 03) passa a ter efeito imediato neste acesso (detalhado também na Spec 12).
- **Critérios de aceite (Dado/Quando/Então):**
  - Dado um morador ativo, quando informa o e-mail cadastrado no link do morador, então entra na área do morador.
  - Dado um e-mail que não é de morador ativo, quando tenta entrar, então não entra e vê erro genérico.
  - Dado que não há sessão de morador, quando acessa uma tela da área do morador, então é levado à entrada por e-mail.
  - Dado um morador autenticado, quando sai, então perde o acesso às telas da área do morador.
  - Dado um morador recém-autenticado, quando entra, então vê o casco de **Moradores** com **+ Nova ocorrência**, **Ocorrências** e **Sair**, sem cadastros de administração.
- **Definição de pronto:** Morador ativo entra só com e-mail; inativo/desconhecido não entra; área do morador está protegida por essa sessão (mesmo que ainda vazia de ocorrências); casco da seção 10.4 no lugar.
- **Dependências:** Spec 03 — morador cadastrado e flag ativo/inativo. Visual: seção 10.
- **Fora do escopo desta spec:** Abrir ocorrência, listar, comentar. Link mágico por e-mail. Senha. Notificações.

### Spec 05 — Categorias de ocorrência

- **Fase:** Fase 3 — Categorias
- **Objetivo (o quê):** Disponibilizar categorias para classificar ocorrências, já com uma lista inicial, e permitir que o funcionário cadastre, edite o nome e desative categorias.
- **Intenção (por quê):** Sem categoria padronizada, a lista de ocorrências não dá para filtrar nem organizar o trabalho.
- **Contexto:** Dashboard do funcionário. Ainda não há ocorrência nesta spec; ela existe para a Spec 06 consumir categorias **ativas**. Lista inicial obrigatória: **Manutenção**, **Limpeza**, **Segurança**, **Barulho**, **Outros**.
- **Atores:** Funcionário autenticado. (Morador só **usa** categorias ativas na Spec 06, não as gerencia.)
- **Descrição do comportamento:** No dashboard, em **Configurações → Categorias** (seção 10). O sistema já apresenta as cinco categorias iniciais, todas ativas. O funcionário lista categorias (nome e ativo/inativo). Pode criar nova (nome único). Pode editar o nome. Pode desativar: deixa de aparecer como opção ao **abrir** ocorrência; ocorrências antigas (quando existirem) **continuam** mostrando aquele nome e podem ser filtradas por ela. Pode reativar. Não há exclusão definitiva neste recorte (evita sumir o rótulo de ocorrências passadas).
- **Entradas e saídas:**
  - Entrada: nome da categoria.
  - Saída: lista de categorias; opção de categorias ativas para formulários futuros.
- **Dados/entidades envolvidos (conceitual):** Categoria: nome, ativo/inativo, se é uma das iniciais ou não (não precisa tratar iniciais como imutáveis: podem ser desativadas se o condomínio não usar).
- **Estados e transições:** Ativa → desativar → Inativa → reativar → Ativa. Nova → Ativa.
- **Regras de negócio:** Nome único (não há duas categorias com o mesmo nome). Só categoria **ativa** pode ser escolhida em nova ocorrência (Spec 06). Desativar não apaga ocorrências.
- **Validações:** Nome obrigatório, não vazio, não duplicado (ignorando diferenças irrelevantes de espaços nas pontas).
- **Fluxo do usuário (passo a passo):**
  1. Funcionário abre a gestão de categorias.
  2. Vê as cinco iniciais.
  3. Cria, edita, desativa ou reativa.
  4. A lista reflete a mudança.
- **Casos de borda e erros:**
  - Nome duplicado: recusa.
  - Nome vazio: recusa.
  - Desativar todas: permitido neste recorte, mas aí a Spec 06 não terá opções — o morador deve ser informado de que não há categoria disponível (tratar na Spec 06). Não é obrigatório impedir desativar a última.
- **Impacto no existente:** Novo módulo no dashboard. Não muda login nem moradores.
- **Critérios de aceite (Dado/Quando/Então):**
  - Dado um sistema recém-preparado, quando o funcionário abre categorias, então vê Manutenção, Limpeza, Segurança, Barulho e Outros, ativas.
  - Dado um nome novo válido, quando cadastra, então a categoria ativa aparece na lista.
  - Dado uma categoria ativa, quando desativa, então ela não poderá ser escolhida ao abrir ocorrência (Spec 06).
  - Dado um nome já existente, quando tenta cadastrar ou renomear para esse nome, então recusa.
- **Definição de pronto:** Lista inicial visível; criar/editar/desativar/reativar funciona; nome único é garantido.
- **Dependências:** Spec 01 — dashboard autenticado.
- **Fora do escopo desta spec:** Formulário de ocorrência. Ordenação especial além de uma lista estável e legível. Categorias por torre.

### Spec 06 — Abrir ocorrência

- **Fase:** Fase 4 — Ocorrências
- **Objetivo (o quê):** Permitir que o **morador autenticado** registre uma nova ocorrência com título, descrição, categoria ativa, local em texto e de 0 a 5 fotos (somente imagem).
- **Intenção (por quê):** Este é o ato principal do produto para quem mora no prédio: formalizar o problema com contexto e evidência opcional.
- **Contexto:** Área do morador (Spec 04). Categorias (Spec 05). Funcionário **não** abre ocorrência neste recorte. Depois de criada, título, descrição, categoria, local e fotos **não são editáveis** (fora do escopo do produto). O atalho **+ Nova ocorrência** fica na sidebar do morador (seção 10.4), não no dashboard do funcionário.
- **Atores:** Morador autenticado e ativo.
- **Descrição do comportamento:** Na área do morador, a ação **+ Nova ocorrência** (sidebar ou equivalente evidente no conteúdo) abre o formulário no casco do morador. O formulário pede título, descrição, categoria (somente ativas), local (texto livre) e anexos de imagem opcionais (até 5). Ao confirmar com dados válidos, a ocorrência é gravada com status **Aberta**, autor = morador logado, data/hora de criação, um **código visível** curto para a lista (no espírito `#OC-1042`), e passa a existir para listagem (Spec 07) e detalhe (Spec 08). Se não houver nenhuma categoria ativa, o morador não consegue concluir e é informado. Fotos são opcionais: 0 é válido. Mais de 5 ou arquivo que não seja imagem é recusado. Em caso de falha ao gravar, nada pela metade aparece como ocorrência “quebrada” para os outros: ou nasce completa, ou o morador vê erro e tenta de novo.
- **Entradas e saídas:**
  - Entrada: título, descrição, categoria, local, 0 a 5 imagens.
  - Saída sucesso: ocorrência Aberta criada; morador é levado a um lugar coerente (lista ou detalhe da criada).
  - Saída falha: formulário permanece com os dados preenchidos + erros.
- **Dados/entidades envolvidos (conceitual):** Ocorrência: código visível, título, descrição, categoria, local, status (Aberta), autor (morador), data/hora de criação, lista de fotos (0 a 5). Foto: imagem associada à ocorrência.
- **Estados e transições:** Não se aplica ciclo de status aqui além do nascimento em **Aberta**. Troca de status é Spec 09.
- **Regras de negócio:** Só morador autenticado ativo abre. Funcionário não tem essa ação. Categoria obrigatória e ativa. Local obrigatório em texto livre. Fotos opcionais, máximo 5, só imagem. Sem edição posterior dos campos desta spec.
- **Validações:** Título, descrição, categoria e local obrigatórios. Categoria deve existir e estar ativa no momento do envio. Quantidade de imagens ≤ 5. Tipo de cada arquivo: imagem. Recusar envio se a sessão não for de morador ativo.
- **Fluxo do usuário (passo a passo):**
  1. Morador autenticado escolhe abrir ocorrência.
  2. Preenche os campos e, se quiser, anexa até 5 imagens.
  3. Confirma.
  4. Vê confirmação de sucesso e encontra a ocorrência na lista/detalhe.
- **Casos de borda e erros:**
  - Campos obrigatórios vazios: erros por campo; não cria.
  - Categoria inativa ou inexistente (ex.: desativada entre abrir o form e enviar): recusa e pede outra.
  - Nenhuma categoria ativa no sistema: informa e não permite concluir.
  - 6ª imagem ou arquivo não imagem: recusa o arquivo / impede envio com mensagem clara.
  - Morador desativado no meio do preenchimento: não grava; trata como sem permissão (alinhado à Spec 12).
  - Funcionário autenticado: não usa este formulário neste recorte.
- **Impacto no existente:** Primeira criação de ocorrência. Lista e detalhe (Specs 07 e 08) passam a ter o que mostrar.
- **Critérios de aceite (Dado/Quando/Então):**
  - Dado um morador autenticado e ao menos uma categoria ativa, quando envia título, descrição, categoria, local e 0 fotos, então a ocorrência nasce Aberta e associada a ele.
  - Dado o mesmo morador, quando anexa 5 imagens válidas, então a ocorrência é criada com essas 5 fotos.
  - Dado uma tentativa com 6 imagens ou arquivo não imagem, quando envia, então o sistema recusa.
  - Dado um funcionário, quando está no dashboard, então não há fluxo de abrir ocorrência para ele neste recorte.
- **Definição de pronto:** Morador cria ocorrência válida com e sem fotos; regras de 5 imagens e categoria ativa valem; status inicial é Aberta.
- **Dependências:** Spec 04 — sessão de morador. Spec 05 — categorias ativas.
- **Fora do escopo desta spec:** Listagem, detalhe, status, exclusão, comentários. Editar ocorrência depois de criada. Funcionário como autor.

### Spec 07 — Listar e filtrar ocorrências

- **Fase:** Fase 4 — Ocorrências
- **Objetivo (o quê):** Mostrar a **todas** as ocorrências do condomínio, na área do morador e no dashboard do funcionário, com filtro por status e por categoria (combináveis).
- **Intenção (por quê):** Transparência entre vizinhos e fila de trabalho para o funcionário. Sem lista, o cadastro da Spec 06 não serve no dia a dia.
- **Contexto:** Ocorrências criadas na Spec 06. Categorias da Spec 05 (incluindo inativas, para filtrar histórico). Dois públicos, mesma visibilidade. Layout: **seção 10.3** no dashboard e o equivalente na área do morador (seção 10.4). Identidade Civic Horizon (Inter, primary, badges conforme tabela da seção 10).
- **Atores:** Morador autenticado. Funcionário autenticado.
- **Descrição do comportamento:** Cada área autenticada tem **Gestão de Ocorrências** (título + subtítulo no espírito do mockup). Acima da tabela, **três cards**: total; soma de Abertas + Em andamento; total de Resolvidas (números em Inter, não serif). Abaixo, filtros só de **status** e **categoria** (sem busca por texto). A lista é **tabela**: código visível, categoria/título (marca da categoria + título + nome da categoria), local, autor (nome e torre/apartamento), data, **badge de status** (Aberta = tom quente; Em andamento = azul suave; Resolvida = verde suave), ação de ver detalhe. Ordenação: **mais recentes primeiro**. Filtros combinam. Tabela **paginada**, com “Mostrando X a Y de Z”. Sem resultados: estado vazio claro. Clicar no olho/linha leva ao detalhe (Spec 08). Quantidade de comentários na linha é desejável (zero até a Spec 11).
- **Entradas e saídas:**
  - Entrada: sessão (morador ou funcionário); filtros opcionais de status e categoria; página da listagem.
  - Saída: cards com totais (respeitando filtro — **suposição deste PRD:** os cards refletem o conjunto **já filtrado** da lista) + tabela da página atual, ou estado vazio.
- **Dados/entidades envolvidos (conceitual):** Ocorrência (código visível, título, categoria, local, autor, data, status). Totais derivados. Categoria. Morador autor (nome, torre/apartamento).
- **Estados e transições:** Não se aplica (consulta). Os status aparecem como rótulos; quem muda é a Spec 09.
- **Regras de negócio:** Morador vê todas, não só as suas. Funcionário vê todas. Filtros combinam. Ordenação por criação decrescente. Listagem paginada. Badges usam os nomes deste PRD, não os do mockup. Sem sessão adequada, a lista daquela área não aparece (protege Specs 01 e 04).
- **Validações:** Valores de filtro devem ser um status válido ou “todos”; categoria existente ou “todas”. Filtro inválido é ignorado ou tratado como “todos”, sem erro técnico exposto.
- **Fluxo do usuário (passo a passo):**
  1. Entra na área correspondente já autenticado.
  2. Vê a lista completa por padrão.
  3. Escolhe status e/ou categoria.
  4. A lista se reduz ao que combina.
  5. Abre um item para o detalhe.
- **Casos de borda e erros:**
  - Nenhuma ocorrência: mensagem de vazio; morador ainda pode abrir nova (Spec 06).
  - Filtro sem match: vazio específico (“nenhuma com esses filtros”), com opção de limpar filtros.
  - Categoria desativada: ainda pode aparecer nos itens antigos e no filtro.
- **Impacto no existente:** Área do morador e dashboard ganham a tela principal de trabalho. Spec 06 passa a ter destino visível.
- **Critérios de aceite (Dado/Quando/Então):**
  - Dado ocorrências de vários autores, quando um morador abre a lista, então vê todas, mais recentes primeiro.
  - Dado um funcionário na lista, quando filtra status Em andamento e uma categoria, então só vê as que batem nos dois critérios.
  - Dado filtros que não batem com nada, quando aplica, então vê estado vazio e não um erro genérico.
  - Dado um visitante sem sessão, quando tenta a lista do morador ou do dashboard, então é barrado pela spec de acesso correspondente.
  - Dado ocorrências nos três status, quando o funcionário abre a lista, então vê três cards de total / em aberto (Aberta+Em andamento) / resolvidas, tabela com badges **Aberta / Em andamento / Resolvida** e paginação, sem campo de busca textual.
- **Definição de pronto:** Lista nas duas áreas no layout da seção 10, filtros combinados, cards, badges corretos, ordenação recente primeiro, paginação, vazio tratado, navegação para o detalhe.
- **Dependências:** Spec 01 e Spec 04 — sessões e casco. Spec 06 — existência de ocorrências (lista vazia é válida). Spec 05 — nomes de categoria. Seção 10 — layout e identidade.
- **Fora do escopo desta spec:** Busca por texto. Relatórios e “resolvidas no mês”. Mudar status na própria linha da lista (pode ser só no detalhe, Spec 09). Comentários completos (Spec 11). Sino, Suporte e home Dashboard extra do mockup.

### Spec 08 — Ver detalhe da ocorrência

- **Fase:** Fase 4 — Ocorrências
- **Objetivo (o quê):** Exibir uma ocorrência completa: dados, autor, status, local, categoria, data e fotos, para morador e funcionário autenticados.
- **Intenção (por quê):** Decidir o que fazer (comentar, mudar status, excluir) exige ver o caso inteiro, inclusive as imagens.
- **Contexto:** Chega-se pela lista (Spec 07) ou logo após criar (Spec 06). Comentários entram na Spec 11; exclusão na Spec 10; status na Spec 09. Esta spec é a **página dona** desses comportamentos posteriores. O detalhe usa o **mesmo casco** da área (sidebar + conteúdo); o miolo é o caso, não a tabela.
- **Atores:** Morador autenticado. Funcionário autenticado.
- **Descrição do comportamento:** Ao abrir o detalhe de um identificador válido, o sistema mostra, no conteúdo do casco, código visível, título, descrição, categoria, local, **badge de status**, autor (nome, torre/apartamento), data/hora, e as fotos (0 a 5). Fotos visíveis; desejável ampliar. Qualquer morador autenticado vê qualquer ocorrência (não só a própria). Funcionário idem. Se o identificador não existir (ou a ocorrência tiver sido excluída), informa que não encontrou — sem vazar dados. Não autenticado não vê detalhe. Nesta spec ainda não é obrigatório o bloco de comentários, mas o layout do detalhe deve comportá-lo em seguida (Spec 11).
- **Entradas e saídas:**
  - Entrada: identificação da ocorrência + sessão válida.
  - Saída: visualização completa ou mensagem de não encontrada.
- **Dados/entidades envolvidos (conceitual):** Ocorrência completa + fotos + autor.
- **Estados e transições:** Não se aplica além de exibir o status atual.
- **Regras de negócio:** Visibilidade total para morador e funcionário autenticados. Sem edição dos campos da ocorrência neste recorte.
- **Validações:** Sessão válida do papel da área. Ocorrência precisa existir.
- **Fluxo do usuário (passo a passo):**
  1. A partir da lista (ou pós-criação), abre a ocorrência.
  2. Lê todos os campos e vê as fotos.
  3. Se a ocorrência não existe, vê mensagem adequada.
- **Casos de borda e erros:**
  - ID inexistente ou excluído: não encontrada.
  - Sem fotos: detalhe válido, sem galeria vazia confusa (estado “sem fotos”).
  - Sem sessão: redireciona ao login da área.
- **Impacto no existente:** Lista (Spec 07) ganha destino. Specs 09, 10 e 11 ancoram ações nesta tela.
- **Critérios de aceite (Dado/Quando/Então):**
  - Dado uma ocorrência com fotos, quando morador ou funcionário autenticado abre o detalhe, então vê dados, autor, status e as fotos.
  - Dado uma ocorrência sem fotos, quando abre o detalhe, então vê os dados sem exigir imagem.
  - Dado um identificador inexistente, quando tenta abrir, então vê que não foi encontrada.
- **Definição de pronto:** Detalhe fiel à ocorrência nas duas áreas; fotos opcionais bem tratadas; não encontrado tratado.
- **Dependências:** Spec 06 — dados e fotos. Spec 07 — navegação a partir da lista. Specs 01 e 04 — acesso.
- **Fora do escopo desta spec:** Comentários (Spec 11). Troca de status (Spec 09). Exclusão (Spec 10). Editar campos da ocorrência.

### Spec 09 — Alterar status da ocorrência

- **Fase:** Fase 4 — Ocorrências
- **Objetivo (o quê):** Permitir que **somente o funcionário** altere o status entre Aberta, Em andamento e Resolvida, inclusive voltando de Resolvida.
- **Intenção (por quê):** O valor para o condomínio é saber o que ainda precisa de ação. O morador informa; o funcionário conduz o andamento.
- **Contexto:** Detalhe da ocorrência (Spec 08). Morador vê o status mas **não** o altera (confirmado). Reabrir (sair de Resolvida) é permitido e necessário para erro de fechamento.
- **Atores:** Funcionário autenticado (age). Morador autenticado (só visualiza).
- **Descrição do comportamento:** No detalhe, o funcionário escolhe um dos três status e confirma. O sistema grava o novo status e o detalhe/lista passam a mostrar o valor novo. Transições permitidas: qualquer status → qualquer um dos três (incluindo Resolvida → Em andamento e Resolvida → Aberta). O morador, no detalhe da área dele, **não** encontra controle de status. Se a ocorrência estiver Resolvida, isso **não** impede o funcionário de mudar o status de novo. Falha ao gravar mantém o status anterior e avisa.
- **Entradas e saídas:**
  - Entrada: ocorrência + novo status + sessão de funcionário.
  - Saída: ocorrência com status atualizado visível na UI, ou erro.
- **Dados/entidades envolvidos (conceitual):** Ocorrência.status (Aberta | Em andamento | Resolvida). Opcional conceitual: quem mudou e quando — **não é exigido** neste recorte exibir histórico de status.
- **Estados e transições:** Aberta ↔ Em andamento ↔ Resolvida (grafo completo entre os três).
- **Regras de negócio:** Só funcionário altera. Morador nunca altera. Voltar de Resolvida é permitido. Mudar status não apaga fotos, descrição nem (futuros) comentários.
- **Validações:** Status de destino deve ser um dos três. Sessão deve ser de funcionário ativo. Ocorrência deve existir.
- **Fluxo do usuário (passo a passo):**
  1. Funcionário abre o detalhe.
  2. Escolhe o novo status.
  3. Confirma.
  4. Vê o status atualizado; a lista também reflete no próximo carregamento.
- **Casos de borda e erros:**
  - Morador tenta alterar (pela UI não deve conseguir; se tentar mesmo assim, o sistema recusa).
  - Ocorrência inexistente: recusa.
  - Mesmo status de novo: pode aceitar como “sem mudança” sem erro grave.
- **Impacto no existente:** Detalhe e lista mostram status mutável. Specs 10 e 11 usam Resolvida para bloquear o morador.
- **Critérios de aceite (Dado/Quando/Então):**
  - Dado um funcionário no detalhe, quando muda de Aberta para Em andamento, então o status passa a Em andamento.
  - Dado status Resolvida, quando o funcionário escolhe Aberta ou Em andamento, então o status volta para o escolhido.
  - Dado um morador no detalhe, quando visualiza, então não consegue alterar o status.
- **Definição de pronto:** Funcionário muda livremente entre os três status; morador não muda; lista e detalhe acompanham.
- **Dependências:** Spec 01 — sessão funcionário. Spec 08 — detalhe.
- **Fora do escopo desta spec:** Atribuir responsável. Notificar morador da mudança. Histórico de transições. Comentários automáticos ao mudar status.

### Spec 10 — Excluir ocorrência

- **Fase:** Fase 4 — Ocorrências
- **Objetivo (o quê):** Permitir exclusão com regras diferentes: morador só exclui a que **ele criou** e se **não** estiver Resolvida; funcionário exclui qualquer uma.
- **Intenção (por quê):** Morador corrige abertura sem querer, mas não apaga caso já encerrado pela administração. Funcionário limpa lixo ou duplicata em qualquer momento.
- **Contexto:** Detalhe (Spec 08) e, se fizer sentido de uso, a lista. Status vem da Spec 09. Comentários (Spec 11) ainda podem não existir; quando existirem, excluir a ocorrência os remove da visão do usuário (Regra 24). Desejável (e tratado como comportamento desta spec): **pedir confirmação** antes de excluir.
- **Atores:** Morador autenticado (autor). Funcionário autenticado.
- **Descrição do comportamento:** No detalhe, o **autor morador** vê ação de excluir somente se o status não for Resolvida. Outros moradores não veem / não podem excluir. O funcionário sempre vê a ação, inclusive em Resolvida. Ao confirmar, a ocorrência some da lista e o detalhe deixa de abrir (não encontrada). Fotos deixam de ser exibidas. Tentativa sem permissão é recusada. Em Resolvida, o morador autor não consegue excluir nem “alterar” a ocorrência.
- **Entradas e saídas:**
  - Entrada: identificação da ocorrência + sessão + confirmação.
  - Saída sucesso: ocorrência desaparece das listagens; usuário volta à lista.
  - Saída recusa: ocorrência intacta + mensagem de sem permissão ou status impeditivo.
- **Dados/entidades envolvidos (conceitual):** Ocorrência (autor, status). Fotos e comentários vinculados deixam de ser visíveis após a exclusão.
- **Estados e transições:** Existente → (exclusão autorizada e confirmada) → Inexistente para o usuário.
- **Regras de negócio:** Autor + não Resolvida → morador pode. Resolvida → morador não pode. Não autor → morador não pode. Funcionário → sempre pode. Confirmação antes de efetivar.
- **Validações:** Sessão válida. Ocorrência existe. Checagem de autor e status no momento da exclusão (não só na hora de mostrar o botão).
- **Fluxo do usuário (passo a passo):**
  1. Abre o detalhe.
  2. Se tiver permissão, escolhe excluir.
  3. Confirma.
  4. Volta à lista sem aquele item.
- **Casos de borda e erros:**
  - Morador autor + Resolvida: sem ação efetiva; se tentar, recusa.
  - Morador não autor: recusa.
  - Status mudou para Resolvida entre abrir a tela e confirmar: recusa para o morador.
  - Já excluída: não encontrada.
  - Cancelar a confirmação: nada muda.
- **Impacto no existente:** Lista e detalhe perdem o item. Spec 11 deve respeitar que comentários de ocorrência excluída não aparecem.
- **Critérios de aceite (Dado/Quando/Então):**
  - Dado uma ocorrência Aberta ou Em andamento criada pelo morador logado, quando ele confirma a exclusão, então ela some da lista e do detalhe.
  - Dado a mesma ocorrência Resolvida, quando o autor tenta excluir, então o sistema impede e a ocorrência permanece.
  - Dado um funcionário, quando confirma exclusão de qualquer ocorrência (inclusive Resolvida), então ela some.
  - Dado um morador que não é o autor, quando tenta excluir, então o sistema impede.
- **Definição de pronto:** As quatro combinações de permissão acima estão corretas; há confirmação; a lista fica consistente.
- **Dependências:** Spec 08 — detalhe. Spec 09 — status Resolvida. Spec 06 — autoria.
- **Fora do escopo desta spec:** Lixeira / restaurar. Exclusão em massa. Editar em vez de excluir.

### Spec 11 — Comentários na ocorrência

- **Fase:** Fase 5 — Comentários e bloqueios finais
- **Objetivo (o quê):** Permitir conversa abaixo do detalhe da ocorrência: criar, editar (só o autor) e excluir comentários (autor ou funcionário), com indicação de “editado” e bloqueio do morador quando o status for Resolvida.
- **Intenção (por quê):** Vizinhos e administração alinham contexto no mesmo lugar do fato, sem espalhar a conversa fora do sistema.
- **Contexto:** Detalhe da Spec 08. Status da Spec 09. Qualquer morador autenticado comenta em ocorrência **não** Resolvida. Funcionário comenta em **qualquer** status. Demais moradores não editam/excluem comentário alheio. Funcionário não edita comentário alheio.
- **Atores:** Morador autenticado. Funcionário autenticado. Autor do comentário (morador ou funcionário).
- **Descrição do comportamento:** No detalhe, há lista de comentários em ordem cronológica (mais antigos primeiro, conversa natural) ou mais recentes primeiro — **decisão desta spec:** mais **antigos primeiro**, para ler a conversa de cima para baixo. Cada item mostra texto, autor (nome; se for funcionário, deve ficar claro que é da administração), data/hora. Campo para novo comentário: texto obrigatório. Morador só vê o campo se o status **não** for Resolvida; se for Resolvida, vê os comentários existentes mas **não** o campo, com texto explicando que ocorrências resolvidas não recebem comentário de morador. Funcionário sempre vê o campo. Após enviar, o comentário aparece. Só o **autor** pode editar o texto; após editar, exibe **ao lado** a indicação de que **foi editado** (não precisa histórico das versões). O autor ou um funcionário podem excluir o comentário, com confirmação. Se Resolvida, o morador — mesmo autor — **não** edita nem exclui; o funcionário edita somente o próprio comentário e pode excluir qualquer um. Falha ao gravar não some com comentários já existentes.
- **Entradas e saídas:**
  - Entrada criar: texto do comentário + ocorrência + sessão.
  - Entrada editar: texto novo.
  - Entrada excluir: confirmação.
  - Saída: lista de comentários atualizada ou erro de validação/permissão.
- **Dados/entidades envolvidos (conceitual):** Comentário: texto, autor (morador ou funcionário), data/hora de criação, indicador de editado, data/hora da última edição (a data exata da edição pode ser só interna; o obrigatório visível é o selo “editado”).
- **Estados e transições:** Comentário visível → editado (selo “editado”) → ou excluído (some da lista). Ocorrência Resolvida trava ações do morador sobre comentários dessa ocorrência.
- **Regras de negócio:** Texto não vazio. Morador não cria/edita/exclui se Resolvida. Funcionário cria e exclui em qualquer status; edita somente o próprio comentário. Só o autor edita. Autor ou funcionário excluem. Selo “editado” após qualquer edição bem-sucedida. Excluir comentário não exclui a ocorrência.
- **Validações:** Texto obrigatório, não só espaços. Sessão válida. Ocorrência existente. Permissões acima verificadas no servidor, não só escondendo botão.
- **Fluxo do usuário (passo a passo):**
  1. Abre o detalhe.
  2. Lê os comentários.
  3. Se permitido, escreve e envia.
  4. Se for o autor, pode editar. Se for o autor ou um funcionário, pode excluir (com confirmação).
  5. Se editou, vê o selo “editado” ao lado daquele comentário.
- **Casos de borda e erros:**
  - Texto vazio: não envia.
  - Morador em Resolvida tentando criar/editar/excluir: recusa.
  - Morador não autor tentando editar/excluir comentário alheio: recusa.
  - Funcionário tentando editar comentário de outra pessoa: recusa.
  - Ocorrência excluída (Spec 10): não há comentários visíveis.
  - Status mudou para Resolvida enquanto o morador escrevia: recusa o envio.
- **Impacto no existente:** Detalhe (Spec 08) ganha o bloco de conversa. Lista (Spec 07) pode mostrar quantidade (desejável). Regras de Resolvida da Spec 09 passam a afetar conversa, não só exclusão.
- **Critérios de aceite (Dado/Quando/Então):**
  - Dado uma ocorrência não Resolvida, quando um morador autenticado envia um comentário válido, então o comentário aparece para todos que abrirem o detalhe.
  - Dado uma ocorrência Resolvida, quando um morador tenta comentar, então o sistema impede; quando um funcionário comenta, então o comentário é gravado.
  - Dado um comentário, quando o **autor** edita, então o novo texto aparece e o selo “editado” é exibido ao lado.
  - Dado um comentário, quando um funcionário que **não** é o autor tenta editar, então o sistema impede.
  - Dado um comentário, quando outro morador (não autor) tenta editar ou excluir, então o sistema impede.
  - Dado um comentário, quando um funcionário exclui (próprio ou alheio), então o comentário some da lista.
  - Dado ocorrência Resolvida, quando o morador autor do comentário tenta editar ou excluir, então o sistema impede; o funcionário ainda edita só o próprio e pode excluir qualquer um.
- **Definição de pronto:** Criar respeita Resolvida; editar é só do autor; excluir é do autor ou funcionário; selo “editado” visível; confirmação na exclusão do comentário.
- **Dependências:** Spec 08 — detalhe. Spec 09 — status. Spec 01 e Spec 04 — quem é funcionário vs. morador.
- **Fora do escopo desta spec:** Resposta aninhada (thread). Reações. Histórico de versões do texto. Anexar foto no comentário. Notificar o autor da ocorrência.

### Spec 12 — Morador inativo e bloqueios de acesso

- **Fase:** Fase 5 — Comentários e bloqueios finais
- **Objetivo (o quê):** Garantir ponta a ponta que morador desativado não entra e não age, enquanto o histórico que ele já gerou permanece visível para os demais.
- **Intenção (por quê):** Quem deixa o prédio ou perde o direito de uso não continua operando o sistema, mas o condomínio não perde o registro das ocorrências.
- **Contexto:** Desativar/reativar está na Spec 03. Login na Spec 04. Ações nas Specs 06, 10 e 11. Esta spec não cria tela nova: **amarra** os bloqueios em todas as ações de morador.
- **Atores:** Funcionário (desativa/reativa). Morador inativo (tentando usar). Moradores e funcionários ativos (vendo histórico).
- **Descrição do comportamento:** Quando o funcionário desativa um morador: (1) novas tentativas de login da Spec 04 falham com erro genérico; (2) se ainda houver sessão antiga, o sistema não aceita abrir ocorrência, comentar, editar/excluir comentário nem excluir ocorrência — responde como não autorizado; (3) ocorrências e comentários já existentes **continuam** na lista e no detalhe, com o nome do autor como estava. Reativar devolve login e ações, segundo as outras regras (ex.: ainda não comenta se Resolvida). Funcionário inativo já é coberto pela Spec 02; aqui o foco é o **morador**.
- **Entradas e saídas:**
  - Entrada: desativação na Spec 03; tentativas de ação do morador.
  - Saída: recusa de acesso/ação; leitura do histórico intacta para quem está autorizado.
- **Dados/entidades envolvidos (conceitual):** Morador.ativo. Ocorrência e comentário já gravados (imutáveis quanto a “sumir por desativação”).
- **Estados e transições:** Morador ativo → inativo (bloqueio total de ação e login) → ativo de novo (libera login e ações permitidas pelas outras specs).
- **Regras de negócio:** Desativar ≠ apagar histórico. Inativo não autentica. Inativo não muta dados. E-mail do inativo continua único (não cadastrar outro morador com o mesmo e-mail enquanto o registro existir).
- **Validações:** Toda ação de morador verifica “ativo” no momento da ação, não só na hora do login.
- **Fluxo do usuário (passo a passo):**
  1. Funcionário desativa o morador.
  2. Esse morador tenta entrar ou, se já estava dentro, tenta agir.
  3. É bloqueado.
  4. Outro morador ainda vê as ocorrências antigas dele.
  5. Funcionário reativa; o morador volta a entrar.
- **Casos de borda e erros:**
  - Sessão antiga após desativar: qualquer mutação recusada; o ideal é também perder a sessão no próximo carregamento.
  - Reativar e ocorrência Resolvida: pode entrar e ver, mas as regras da Spec 11 continuam (não comenta).
  - Tentar cadastrar novo morador com e-mail de inativo: recusa (e-mail ainda ocupado).
- **Impacto no existente:** Fecha buracos das Specs 03, 04, 06, 10 e 11. Não muda o modelo conceitual, só a consistência das permissões.
- **Critérios de aceite (Dado/Quando/Então):**
  - Dado um morador desativado, quando informa o e-mail na entrada do morador, então não entra.
  - Dado um morador desativado (mesmo com sessão antiga), quando tenta abrir ocorrência, comentar ou excluir, então o sistema recusa.
  - Dado ocorrências criadas por um morador depois desativado, quando outro morador ou funcionário lista/detalha, então essas ocorrências e comentários ainda aparecem.
  - Dado o mesmo morador reativado, quando informa o e-mail, então entra de novo.
- **Definição de pronto:** Desativar corta login e mutações; histórico permanece; reativar restaura o acesso.
- **Dependências:** Spec 03, Spec 04, Spec 06, Spec 10, Spec 11.
- **Fora do escopo desta spec:** Apagar morador de verdade. Transferir ocorrências para outro autor. Desativar funcionário (Spec 02).

## 15. Ordem recomendada de implementação

1. Spec 01 — Login e área restrita do funcionário
2. Spec 02 — Cadastro e gestão de funcionários
3. Spec 03 — Cadastro e gestão de moradores
4. Spec 04 — Acesso do morador por e-mail
5. Spec 05 — Categorias de ocorrência
6. Spec 06 — Abrir ocorrência
7. Spec 07 — Listar e filtrar ocorrências
8. Spec 08 — Ver detalhe da ocorrência
9. Spec 09 — Alterar status da ocorrência
10. Spec 10 — Excluir ocorrência
11. Spec 11 — Comentários na ocorrência
12. Spec 12 — Morador inativo e bloqueios de acesso

Seguir essa ordem evita construir ocorrência sem categoria, lista sem dado, comentário sem detalhe, ou bloqueio de inativo sem as ações para bloquear. Cada spec assume só as anteriores da lista de dependências.

O funcionário inicial da Spec 01 precisa existir antes do primeiro login: preparar esse acesso junto com a Spec 01/02, não deixar para o fim.
