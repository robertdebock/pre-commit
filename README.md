# Pre Commit

## Recommended configuration

Have all checks run:

```yaml
repos:
   - repo: https://github.com/robertdebock/pre-commit
     rev: v1.4.5
     hooks:
       - id: ansible_role_find_unused_variable
       - id: ansible_role_find_empty_files
       - id: ansible_role_find_empty_directories
       - id: ansible_role_fix_readability
       - id: ansible_role_find_undefined_handlers
       - id: ansible_role_find_unquoted_values
```

You can also select single checks, read futher for more details.

## Ansible roles unused variable finder

This [pre-commit](https://pre-commit.com/) hook can help you find defined variables (in `defaults/main.yml` or `vars/main.yml`) that are not used in the role.

Expand (or create) your `.pre-commit-config.yml` with this section:

```yaml
repos:
  - repo: https://github.com/robertdebock/pre-commit
    rev: v1.4.5
    hooks:
      - id: ansible_role_find_unused_variable
```

## Ansible roles empty files finder

This hook can find empty `defaults/main.yml`, `handlers/main.yml` and `vars/main.yml` files.

```yaml
repos:
  - repo: https://github.com/robertdebock/pre-commit
    rev: v1.4.5
    hooks:
      - id: ansible_role_find_empty_files
```

## Ansible roles empty directory finder

This hook can find empty directories.

```yaml
repos:
  - repo: https://github.com/robertdebock/pre-commit
    rev: v1.4.5
    hooks:
      - id: ansible_role_find_empty_directory
```

## Ansible roles readability fixer

This hook can improve readability.

```yaml
repos:
  - repo: https://github.com/robertdebock/pre-commit
    rev: v1.4.5
    hooks:
      - id: ansible_role_fix_readability
```

## Ansible roles find undefined handler

This hook can find undefined handlers.

```yaml
repos:
  - repo: https://github.com/robertdebock/pre-commit
    rev: v1.4.5
    hooks:
      - id: ansible_role_find_undefined_handlers
```

## Ansible roles find unquoted values

This hook can find unquoted values.

```yaml
repos:
  - repo: https://github.com/robertdebock/pre-commit
    rev: v1.4.5
    hooks:
      - id: ansible_role_find_unquoted_values
```
