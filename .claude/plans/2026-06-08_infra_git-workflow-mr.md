# План: зафиксировать правила оформления MR и создать текущий MR

> Примечание: после выхода из plan mode переименовать файл в `2026-06-08_infra_git-workflow-mr.md`.

## Контекст

Ветка `2026-06-08_infra_git-workflow` запушена в origin, MR не создан.
Пользователь хочет: (1) зафиксировать в CLAUDE.md правила оформления MR, чтобы они соблюдались при каждом MR; (2) создать текущий MR по этим правилам.

## Изменения

### 1. CLAUDE.md — обновить раздел Git workflow

Заменить строку про MR summary:
```
- **MR summary**: when a feature is ready, prepare a short bullet-list summary of what the MR delivers. Use `gh pr create` with a `## Summary` section in the body.
```
На расширенную:
```
- **MR title**: must match the branch name (e.g. `2026-06-08_infra_git-workflow`).
- **MR description**: use `gh pr create` with a `## Summary` section — a short bullet list of what the MR delivers.
```

Файл: `/Users/yury/Documents/AI/PS_Claude/expence-tracker/CLAUDE.md`

### 2. Создать MR на GitHub

```bash
gh pr create \
  --title "2026-06-08_infra_git-workflow" \
  --base main \
  --body "## Summary

- Добавлен раздел **Git workflow** в CLAUDE.md: feature-ветка для каждого изменения, атомарные коммиты, MR через \`gh pr create\`, без локального слияния
- Имя ветки унифицировано с конвенцией плана: \`YYYY-MM-DD_<prefix>_<feature-slug>\`
- Title MR = имя ветки; Description содержит раздел \`## Summary\`
- Добавлена инструкция переименовывать автогенерированный файл плана по конвенции"
```

### 3. Зафиксировать изменения CLAUDE.md коммитом в текущую ветку

## Проверка

- `gh pr view` показывает title = `2026-06-08_infra_git-workflow` и корректный Summary
- CLAUDE.md содержит правила про title и description MR
