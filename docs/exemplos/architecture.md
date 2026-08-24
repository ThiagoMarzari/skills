# Arquitetura e decisões técnicas

> Última atualização: 2026-08-24

## Stack

| Camada | Tecnologia |
|--------|------------|
| Framework | Next.js 16.3 (App Router, `src/app`) |
| UI | React 19, Tailwind CSS 4, shadcn/ui (`base-nova`) |
| Formulários | React Hook Form + Zod |
| Estado cliente | TanStack React Query |
| Banco / Auth / Storage | Supabase (Postgres, Auth, Storage) |
| Sessão morador | JWT HS256 via `jose` (cookie `resident_session`, 7 dias) |
| Linguagem | TypeScript |

Não há ORM (Prisma/Drizzle). O acesso ao banco é feito via clientes Supabase.

## Estrutura de pastas

```
src/
├── app/                    # Rotas (App Router)
│   ├── page.tsx            # Página inicial (escolha de área)
│   ├── dashboard/          # Área do funcionário
│   │   ├── (auth)/login/
│   │   └── (panel)/        # Ocorrências, moradores, configurações
│   └── morador/            # Área do morador
│       ├── (auth)/login/
│       └── (panel)/        # Ocorrências, nova ocorrência, detalhe
├── components/             # UI compartilhada (shadcn, shells)
├── lib/
│   ├── actions/            # Server Actions compartilhadas (ocorrências)
│   ├── data/               # Queries reutilizáveis (ex.: occurrences.ts)
│   ├── permissions/        # Regras de autorização em código
│   ├── session/            # staff.ts, resident.ts
│   ├── supabase/           # client, server, admin
│   ├── constants.ts
│   └── types.ts
├── hooks/
└── proxy.ts                # Proteção de rotas /dashboard e /morador (Next.js 16+)

supabase/
├── migrations/             # Schema, triggers, RLS, storage
└── seed.sql                # Categorias iniciais
```

### Padrão por página

Cada rota segue a estrutura definida em `.cursor/rules/page-rules.mdc`:

- `page.tsx` — Server Component; busca dados via `_data-access`
- `_components/` — UI (geralmente Client Components)
- `_actions/` — Server Actions com validação Zod
- `_data-access/` — funções de leitura no servidor

## Autenticação e autorização

### Funcionário (staff)

1. Login via Supabase Auth (`signInWithPassword`) em `/dashboard/login`.
2. `proxy.ts` verifica `auth.getUser()` em rotas `/dashboard/*`.
3. `getStaffSession()` confirma registro em `staff` com `is_active = true`.
4. RLS no Postgres permite acesso a `authenticated` somente se `is_active_staff()`.

### Morador (resident)

1. Login em `/morador/login`: valida e-mail em `residents` (ativo) e emite JWT.
2. Cookie httpOnly `resident_session` (7 dias, `RESIDENT_SESSION_SECRET`).
3. `proxy.ts` verifica presença do cookie em rotas `/morador/*`.
4. `getResidentSession()` valida JWT e reconfirma `is_active` no banco.
5. Operações de escrita usam `createAdminClient()` (service role) após validar o JWT — RLS não cobre morador diretamente.

### Permissões em código

`src/lib/permissions/occurrence.ts` centraliza regras como exclusão, comentário e troca de status.

## Banco de dados

### Entidades

| Tabela | Descrição |
|--------|-----------|
| `staff` | Funcionários (PK = `auth.users.id`) |
| `residents` | Moradores (login só por e-mail) |
| `categories` | Categorias de ocorrência |
| `occurrences` | Ocorrências (`public_code`, status, autor) |
| `occurrence_photos` | Fotos (referência ao Storage) |
| `comments` | Comentários (autor staff ou resident) |

### Triggers e constraints (`0003_triggers.sql`)

- `public_code` automático (`OC-` + sequência a partir de 1001)
- E-mail não pode existir em `staff` e `residents` ao mesmo tempo
- Último funcionário ativo não pode ser desativado
- Máximo de 5 fotos por ocorrência

### RLS (`0004_rls.sql`)

Todas as tabelas têm RLS habilitado. Políticas permitem CRUD a `authenticated` quando `is_active_staff()`. Ações do morador passam pelo service role no servidor.

### Storage (`0005_storage.sql`)

Bucket privado `occurrence-photos` (imagens, até 5 MB). Staff lê/escreve via RLS; morador faz upload via service role nas Server Actions.

## Fluxo de dados

```
Usuário → page.tsx (Server)
           ↓ _data-access / lib/data
           ↓ props
         _components (Client)
           ↓ interação
         _actions / lib/actions (Server Action)
           ↓ validação Zod + sessão
           ↓ Supabase (client ou admin)
         revalidatePath → UI atualizada
```


## Shells de layout

- `dashboard-shell.tsx` — sidebar com ocorrências, moradores e configurações (categorias, funcionários).
- `morador-shell.tsx` — sidebar enxuta com lista e botão "Nova ocorrência".

## Documentação relacionada

- [Visão geral do produto](./project-overview.md)
- [PRD](./prd/condominio-app.md)
- [Design](./DESIGN.md)
