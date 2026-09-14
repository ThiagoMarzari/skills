# Delivery

- **Host:** GitLab
- **CLI:** `glab`
- **Papel:** [front | back | único]
- **Reconhecer por:** [trecho da URL do remote ou nome da pasta deste repo]
- **Base sandbox:** [nome da branch]
- **Base release:** [nome da branch]
- **Branches protegidas contra commit/push direto:** [sandbox], [release], `main`, `master`
- **Consumidores:** `fecha-a-task` (Etapa 1 — resolver bases)

Os targets permitidos para MR são **Base sandbox** e **Base release**; a proteção acima impede apenas commit/push direto nessas branches.

Preencha com os nomes **deste** repositório. Front e back têm cada um o próprio `docs/agents/delivery.md`. Sem este arquivo, `fecha-a-task` para e pede `/setup-skills`.
