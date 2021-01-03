# Pre Commit

## Ansible roles unused variable finder

This [pre-commit](https://pre-commit.com/) hook can help you find defined variables (in `defaults/main.yml` or `vars/main.yml`) that are not use in the role.

Expand (or create) your `.pre-commit-config.yml` with this section:

```yaml
- repo: https://github.com/robertdebock/pre-commit
  # Optionally, you can refer to a specific release. If not defined, `master` is used.
  # rev: 1.0.0
  hooks:
    - id: ansible_role_find_unused_variable
```
