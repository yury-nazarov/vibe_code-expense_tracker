# expense-tracker

Трекер расходов. Два независимых проекта и общий Docker Compose для локальной БД.

## Стек

| Проект | Технологии |
|---|---|
| [frontend/](./frontend/) | Next.js 16, React 19, TypeScript 5.6, Tailwind CSS v4 |
| [backend/](./backend/) | Java 21, Spring Boot 3.5, Spring Data JPA, Flyway, PostgreSQL, Swagger (springdoc-openapi 2.8) |

## Архитектура

```
frontend/   →   Next.js (App Router)   →   порт 3000
backend/    →   Spring Boot REST API   →   порт 8080
                    │
            PostgreSQL 16 (Docker)     →   порт 5432
```

Backend построен по слоям: `controller → service → repository → entity`. Схемой БД управляет Flyway (SQL-миграции); Hibernate работает в режиме `validate`.

## Запуск для разработки

### 1. База данных

```bash
docker compose up -d
```

### 2. Backend

```bash
cd backend
./mvnw spring-boot:run
```

- API: `http://localhost:8080`
- Swagger UI: `http://localhost:8080/swagger-ui.html`

Переменные окружения (значения по умолчанию подходят для локального запуска):

| Переменная | По умолчанию |
|---|---|
| `DATABASE_URL` | `jdbc:postgresql://localhost:5432/expense_tracker` |
| `DB_USER` | `postgres` |
| `DB_PASSWORD` | `postgres` |

### 3. Frontend

```bash
cd frontend
yarn install
yarn dev
```

- Приложение: `http://localhost:3000`

## Остановка

```bash
docker compose down
```
