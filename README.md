# Pre Commit

## Ansible roles unused variable finder

This [pre-commit](https://pre-commit.com/) hook can help you find defined variables (in `defaults/main.yml` or `vars/main.yml`) that are not use in the role.

Expand (or create) your `.pre-commit-config.yml` with this section:

```yaml
repos:
  - repo: https://github.com/robertdebock/pre-commit
    rev: v1.1.2
    hooks:
      - id: ansible_role_find_unused_variable
```

## Ansible roles empty files finder

This hook can find empty `defaults/main.yml`, `handlers/main.yml` and `vars/main.yml`.

```yaml
repos:
  - repo: https://github.com/robertdebock/pre-commit
    rev: v1.1.2
    hooks:
      - id: ansible_role_find_empty_files
```
