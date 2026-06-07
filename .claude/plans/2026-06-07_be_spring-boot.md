# Backend: Java / Spring Boot

## Стек и версии

| Технология | Версия | Обоснование |
|---|---|---|
| Java | **21 LTS** | Актуальный Long-Term Support релиз; требуется Spring Boot 3.x |
| Spring Boot | **3.5.x** | Последний стабильный (май 2025); включает Spring 6.2 |
| Spring Data JPA + Hibernate 6 | входит в Boot BOM | ORM-стандарт Spring; CRUD-репозитории без boilerplate |
| springdoc-openapi | **2.8.x** | Поддерживает Spring Boot 3.x и OpenAPI 3.1 |
| Flyway | **10.x** | Включён в Spring Boot 3.5 BOM; управляет схемой SQL-миграциями |
| Maven | **3.9.x (wrapper)** | Wrapper в репо — локальная установка не нужна |
| Lombok | **1.18.x** | Убирает boilerplate для entity/DTO; входит в Spring Boot BOM |

### Почему Spring Data JPA + Hibernate, а не jOOQ/JDBI

Expense-трекер — CRUD с умеренно сложными выборками (по дате, категории, пользователю). Spring Data JPA покрывает это через:
- `JpaRepository<T, ID>` — стандартные операции без кода
- Derived query methods (`findByUserIdAndDateBetween`)
- `@Query(JPQL)` для нетривиальных выборок
- Нативный SQL через `@Query(nativeQuery=true)` если нужно

---

## Структура backend/

```
backend/
├── pom.xml
├── .mvn/wrapper/
│   └── maven-wrapper.properties
├── mvnw / mvnw.cmd
├── src/
│   ├── main/
│   │   ├── java/expensetracker/
│   │   │   ├── ExpenseTrackerApplication.java   # @SpringBootApplication
│   │   │   └── controller/
│   │   │       └── HealthController.java        # GET /api/health → {status:"ok"}
│   │   └── resources/
│   │       ├── application.yml
│   │       └── db/migration/                    # Flyway SQL-миграции
│   └── test/
│       └── java/expensetracker/
│           └── ExpenseTrackerApplicationTests.java
└── .gitignore
```

---

## pom.xml — зависимости

```xml
<parent>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-parent</artifactId>
  <version>3.5.0</version>
</parent>

spring-boot-starter-web                          <!-- REST, Jackson -->
spring-boot-starter-data-jpa                     <!-- Spring Data JPA + Hibernate 6 -->
postgresql (runtime)                             <!-- JDBC-драйвер -->
flyway-core + flyway-database-postgresql         <!-- миграции схемы -->
springdoc-openapi-starter-webmvc-ui:2.8.8        <!-- Swagger UI + OpenAPI 3.1 -->
lombok                                           <!-- @Data, @Builder, @RequiredArgsConstructor -->
spring-boot-starter-test (test)                  <!-- JUnit 5, Mockito, AssertJ -->
```

### Слои приложения

```
controller/   →   @RestController, DTO, @Valid
service/      →   @Service, бизнес-логика
repository/   →   extends JpaRepository<Entity, Long>
entity/       →   @Entity, @Table — Hibernate-маппинг таблиц
dto/          →   record / @Data Lombok для request/response
```

---

## application.yml

```yaml
server:
  port: 8080

spring:
  datasource:
    url: ${DATABASE_URL:jdbc:postgresql://localhost:5432/expense_tracker}
    username: ${DB_USER:postgres}
    password: ${DB_PASSWORD:postgres}
  jpa:
    hibernate:
      ddl-auto: validate        # Flyway управляет схемой
  flyway:
    enabled: true
    locations: classpath:db/migration

springdoc:
  swagger-ui:
    path: /swagger-ui.html
  api-docs:
    path: /v3/api-docs
```

---

## Команды

```bash
./mvnw spring-boot:run            # запуск в dev-режиме
./mvnw test                       # тесты
./mvnw package -DskipTests        # сборка fat JAR → target/
```

- **Swagger UI:** `http://localhost:8080/swagger-ui.html`
- **Миграции:** `src/main/resources/db/migration/V{N}__{description}.sql`
- **Env vars:** `DATABASE_URL`, `DB_USER`, `DB_PASSWORD`

---

## Верификация

```bash
docker compose up -d
cd backend && ./mvnw spring-boot:run

curl http://localhost:8080/api/health
# → {"status":"ok"}

open http://localhost:8080/swagger-ui.html
```
