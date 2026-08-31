---
name: documentation-writer
description: Compara a documentação do projeto com o código real e atualiza somente o que estiver desatualizado. Use somente com /documentation-writer.
disable-model-invocation: true
---

# Atualizador de documentação

## Ativação e limite

Use esta skill somente quando o usuário digitar `/documentation-writer`.

Pode criar ou alterar apenas:

- `README.md`;
- `docs/project-overview.md`;
- `docs/architecture.md`.

Leia o código e execute apenas comandos de consulta. Não altere código, instale dependências, execute migrações ou faça mudanças fora dos três documentos.

## Objetivo

Manter a documentação alinhada ao comportamento que existe de fato. O código é a fonte da verdade; documentação antiga, intenção não implementada e suposições não devem ser descritas como realidade.

## Documentos administrados

| Documento | Caminho | Limite |
|---|---|---|
| Visão geral do produto | `docs/project-overview.md` | 90 linhas |
| Arquitetura e decisões técnicas | `docs/architecture.md` | 200 linhas |
| Entrada para quem está chegando | `README.md` | sem limite fixo |

Se um documento não existir, crie-o apenas quando houver conteúdo verificável que justifique sua existência.

## Etapa 1 — Levantar o estado real

1. Leia `README.md`, `AGENTS.md`, `CLAUDE.md` e as regras aplicáveis.
2. Liste a estrutura principal do projeto.
3. Identifique o manifesto de dependências e os comandos disponíveis.
4. Localize código, rotas, autenticação, dados e integrações existentes.
5. Leia os tipos, modelos e módulos centrais relacionados à documentação.
6. Consulte os commits recentes para identificar mudanças relevantes.
7. Leia os documentos administrados que existirem.

Adapte a busca à tecnologia encontrada. Se não houver `src/`, procure outras pastas de código; se não houver Prisma, procure a camada de dados realmente usada.

**Conclua quando:** o comportamento documentado e o comportamento implementado puderem ser comparados com evidências.

## Etapa 2 — Identificar divergências

Para cada documento, procure:

- funcionalidade existente que não está descrita;
- funcionalidade descrita que não existe mais;
- rotas, entidades, camadas ou integrações renomeadas;
- tecnologia, dependência ou comando desatualizado;
- instrução de instalação ou uso que não funciona;
- documento ausente, quando sua criação for necessária;
- excesso do limite de linhas.

Registre cada divergência com o caminho do documento e a evidência no código. Ignore conteúdo que ainda estiver correto.

**Conclua quando:** cada alteração proposta tiver uma causa verificável e nenhuma mudança for baseada apenas em suposição.

## Etapa 3 — Pedir confirmação

Antes de escrever, apresente:

```markdown
## O que está desatualizado

### docs/project-overview.md
- [ ] ...

### docs/architecture.md
- [ ] ...

### README.md
- [ ] ...

Posso aplicar essas atualizações?
```

Liste apenas os documentos que realmente serão alterados. Aguarde confirmação explícita. Se não houver divergências, informe isso e não peça autorização para uma alteração vazia.

## Etapa 4 — Atualizar

Depois da confirmação:

1. aplique somente as mudanças identificadas;
2. preserve seções corretas e o estilo existente;
3. use links relativos;
4. atualize a data somente nos documentos editados, se eles tiverem esse campo;
5. respeite os limites de linhas;
6. não inclua opinião, recomendação de arquitetura ou funcionalidade futura;
7. não copie conteúdo de domínio dos exemplos para este kit.

**Conclua quando:** cada divergência confirmada estiver corrigida e nenhum conteúdo não verificado tiver sido adicionado.

## Validação e entrega

Confira:

- [ ] somente os documentos permitidos foram alterados;
- [ ] cada afirmação pode ser confirmada no código ou na configuração;
- [ ] nenhuma seção correta foi reescrita sem necessidade;
- [ ] os limites de linhas foram respeitados;
- [ ] links e comandos documentados são válidos;
- [ ] a documentação não descreve funcionalidades futuras como existentes.

Informe os arquivos atualizados e um resumo curto das mudanças. Não altere o código para fazer a documentação parecer correta.
