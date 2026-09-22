# Delivery

- **Provider:** [github | gitlab | manual]
- **CLI:** [`gh` para GitHub | `glab` para GitLab | `nenhuma` para manual]
- **Reconhecer por:** [trecho da URL do remote ou nome da pasta deste repo]
- **Destinos:** [um branch para GitHub; um ou mais para GitLab; `nenhum` para manual]
- **Branches protegidas contra commit/push direto:** [destinos], `main`, `master`
- **Consumidores:** `delivery` (provedor, destinos e proteções)

Use a configuração **deste** repositório. GitHub exige exatamente um destino; GitLab aceita um ou mais destinos. Front e back têm cada um o próprio `docs/agents/delivery.md`. `manual` não tem destinos, gera apenas checklist e não executa Git/CLI. Sem este arquivo ou com placeholders, `delivery` para e pede `/setup-skills`.
