# План: добавить правила Git-workflow в CLAUDE.md

## Контекст

Пользователь хочет зафиксировать единый Git-процесс для разработки фич: ветки под каждую фичу, атомарные коммиты и соглашение об оформлении MR. Правила нужно добавить в CLAUDE.md, чтобы Claude Code автоматически их придерживался.

## Изменение

Добавить новый раздел **Git workflow** в `CLAUDE.md` — после раздела **Plans**, перед **Key architectural decisions** — со следующими правилами:

1. **Ветки** — каждая новая фича разрабатывается в отдельной ветке, отрезанной от `main`; название ветки совпадает со slug фичи (например, `auth-jwt`, `expense-list`).
2. **Атомарные коммиты** — каждое завершённое логическое изменение оформляется отдельным коммитом, чтобы diff был читаем в IDE. Мегакоммиты типа «WIP» недопустимы.
3. **Подготовка MR** — когда фича готова, формируется краткое summary (список пунктов) с описанием того, что несёт MR. Используется `gh pr create` с секцией `## Summary` в теле.
4. **Не мержить локально** — MR никогда не мержится локально; слияние происходит на удалённом сервере (GitHub/GitLab UI или CI).

## Файл для изменения

`/Users/yury/Documents/AI/PS_Claude/expence-tracker/CLAUDE.md`

Вставить после строки 92 (`By default: use **Opus** model for plan preparation, use **Sonnet** model for plan implementation.`):

```markdown
## Git workflow

- **Feature branches**: cut a new branch from `main` for every feature; name the branch after the feature slug (e.g. `auth-jwt`, `expense-list`).
- **Atomic commits**: commit each completed logical change separately so diffs stay readable in an IDE. Avoid large "WIP" commits.
- **MR summary**: when a feature is ready, prepare a short bullet-list summary of what the MR delivers. Use `gh pr create` with a `## Summary` section in the body.
- **No local merge**: never merge an MR locally — merges are performed on the remote (GitHub/GitLab UI or CI).
```

## Проверка

Прочитать обновлённый `CLAUDE.md` и убедиться, что новый раздел присутствует и корректно расположен между **Plans** и **Key architectural decisions**.
