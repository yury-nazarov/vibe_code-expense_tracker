# План: унифицировать именование веток с конвенцией планов

> Примечание: plan mode задаёт автогенерированное имя файла — после выхода из plan mode переименовать в `2026-06-08_infra_git-workflow-naming.md`.

## Контекст

Текущее правило в CLAUDE.md называет ветки произвольным slug'ом (например, `git-workflow-rules`).
Планы при этом используют строгую конвенцию `YYYY-MM-DD_<prefix>_<feature-slug>`.
Пользователь хочет, чтобы имя ветки всегда совпадало с именем соответствующего плана (без расширения `.md`), что даёт однозначную связь между веткой и планом.

## Изменения

### 1. CLAUDE.md — обновить раздел Git workflow

Заменить текущую строку:
```
- **Feature branches**: cut a new branch from `main` for every change (features, bugfixes, infra, config, docs); name the branch after the change slug (e.g. `auth-jwt`, `expense-list`, `git-workflow-rules`).
```
На:
```
- **Feature branches**: cut a new branch from `main` for every change (features, bugfixes, infra, config, docs); name the branch after the plan filename without the `.md` extension (e.g. `2026-06-08_infra_git-workflow`, `2026-06-10_be_auth-jwt`).
```

Файл: `/Users/yury/Documents/AI/PS_Claude/expence-tracker/CLAUDE.md`

### 2. Переименовать текущую ветку

Существующая ветка `git-workflow-rules` → `2026-06-08_infra_git-workflow`
(соответствует плану `2026-06-08_infra_git-workflow.md`)

```bash
git branch -m git-workflow-rules 2026-06-08_infra_git-workflow
```

## Проверка

- `git branch` показывает ветку `2026-06-08_infra_git-workflow`
- В CLAUDE.md раздел **Git workflow** содержит обновлённую строку с примерами по конвенции
