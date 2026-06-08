# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Structure

Two independent projects, each with its own git repository:

```
expence-tracker/
├── docker-compose.yml   # PostgreSQL 16-alpine for local dev
├── frontend/            # Next.js 16 + App Router + Tailwind CSS v4
└── backend/             # Java 21 + Spring Boot 3.5 + Spring Data JPA + Flyway
```

All work happens inside `frontend/` or `backend/`. The root contains only infrastructure.

## Local database

```bash
docker compose up -d    # start PostgreSQL on port 5432
docker compose down     # stop
```

Credentials: `postgresql://postgres:postgres@localhost:5432/expense_tracker`

## Frontend (`frontend/`)

**Stack:** Next.js 16, React 19, TypeScript 5.6, Tailwind CSS v4, ESLint 9

```bash
yarn install
yarn dev      # http://localhost:3000
yarn build
yarn lint
```

**Tailwind v4** — CSS-first configuration, no `tailwind.config.js`:
- Import: `@import "tailwindcss"` in `src/app/globals.css`
- PostCSS plugin: `@tailwindcss/postcss` (not the old `tailwindcss` plugin)
- `postcss.config.mjs` configures it

**App Router** — all pages live in `src/app/`. Use `layout.tsx` / `page.tsx` conventions.

## Backend (`backend/`)

**Stack:** Java 21 LTS, Spring Boot 3.5.x, Spring Data JPA (Hibernate 6), Flyway 10, springdoc-openapi 2.8, Lombok, Maven 3.9 (wrapper)

```bash
./mvnw spring-boot:run            # http://localhost:8080 (dev)
./mvnw package -DskipTests        # build fat JAR → target/
./mvnw package && java -jar target/*.jar  # production run
./mvnw test                       # run tests
```

**Swagger UI:** `http://localhost:8080/swagger-ui.html`  
**OpenAPI JSON:** `http://localhost:8080/v3/api-docs`

**Database migrations:** Flyway SQL-файлы в `src/main/resources/db/migration/`.  
Naming convention: `V{version}__{description}.sql` (e.g. `V1__create_users_table.sql`).

**Environment variables** (можно задать в shell или `.env` + передать через `-D`):

| Variable | Default | Description |
|---|---|---|
| `DATABASE_URL` | `jdbc:postgresql://localhost:5432/expense_tracker` | JDBC URL |
| `DB_USER` | `postgres` | DB username |
| `DB_PASSWORD` | `postgres` | DB password |

**Maven Wrapper** (`mvnw`) включён в репо — локальная установка Maven не нужна.

## Plans

All implementation plans must be saved to `.claude/plans/`.

**Naming convention:** `YYYY-MM-DD_<prefix>_<feature-slug>.md`

| Prefix | Scope |
|---|---|
| `be` | backend |
| `fe` | frontend |
| `infra` | infrastructure (Docker, CI, etc.) |

Examples:
```
2026-06-07_be_spring-boot.md
2026-06-10_be_auth-jwt.md
2026-06-10_fe_auth-login-page.md
2026-06-15_fe_expense-list.md
```

By default: use **Opus** model for plan preparation, use **Sonnet** model for plan implementation.

**Important:** plan mode may suggest an auto-generated filename — always rename the file to match the naming convention above before writing content.

## Git workflow

- **Feature branches**: cut a new branch from `main` for every change (features, bugfixes, infra, config, docs); name the branch after the plan filename without the `.md` extension (e.g. `2026-06-08_infra_git-workflow`, `2026-06-10_be_auth-jwt`).
- **Atomic commits**: commit each completed logical change separately so diffs stay readable in an IDE. Avoid large "WIP" commits.
- **MR summary**: when a feature is ready, prepare a short bullet-list summary of what the MR delivers. Use `gh pr create` with a `## Summary` section in the body.
- **No local merge**: never merge an MR locally — merges are performed on the remote (GitHub/GitLab UI or CI).

## Key architectural decisions

- **Layered architecture**: `controller` → `service` → `repository` → `entity`. DTO-классы отделены от Entity.
- **Schema management**: Hibernate `ddl-auto: validate` — схему создаёт и изменяет только Flyway; Hibernate лишь проверяет соответствие.
- **ORM**: Spring Data JPA + Hibernate 6. Репозитории наследуют `JpaRepository<T, ID>`. Сложные запросы — через `@Query(JPQL)` или `nativeQuery=true`.
- **Boilerplate**: Lombok (`@Data`, `@Builder`, `@RequiredArgsConstructor`) для entity и DTO.
- **No shared packages**: frontend и backend не разделяют код.
- **Frontend**: Yarn Berry (Yarn 4) с `nodeLinker: node-modules` для совместимости с Next.js.
