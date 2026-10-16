# Delivery

- **Provider:** [github | gitlab]
- **CLI:** [`gh` para GitHub | `glab` para GitLab]
- **Reconhecer por:** [trecho da URL do remote ou nome da pasta deste repo]
- **Destinos:** [um branch para GitHub; um ou mais para GitLab]
- **Branches protegidas contra commit/push direto:** [destinos], `main`, `master`
- **Consumidores:** `tm-delivery` (provedor, destinos e proteções)

Use a configuração **deste** repositório. GitHub exige exatamente um destino; GitLab aceita um ou mais destinos. Front e back têm cada um o próprio `docs/agents/delivery.md`. Sem este arquivo ou com placeholders, `tm-delivery` para e pede `/tm-setup-skills`.
