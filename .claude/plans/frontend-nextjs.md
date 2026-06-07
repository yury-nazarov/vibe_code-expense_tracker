# Frontend: Next.js

## Стек и версии

| Технология | Версия | Назначение |
|---|---|---|
| Next.js | **16.x** | React-фреймворк, App Router, SSR/SSG |
| React | **19.x** | UI-библиотека |
| TypeScript | **5.6.x** | Типизация |
| Tailwind CSS | **4.x** | CSS-утилиты, CSS-first конфигурация |
| ESLint | **9.x** | Линтер (flat config) |
| Yarn | **1.22.x (Classic)** | Пакетный менеджер |

---

## Структура проекта

```
frontend/
├── package.json
├── next.config.ts           # reactStrictMode: true
├── tsconfig.json
├── postcss.config.mjs       # @tailwindcss/postcss
├── eslint.config.mjs        # next/core-web-vitals + next/typescript
├── .env.example             # NEXT_PUBLIC_API_URL
├── .nvmrc                   # Node 20.18.0
└── src/
    └── app/                 # App Router
        ├── globals.css      # @import "tailwindcss"
        ├── layout.tsx       # RootLayout, metadata, lang="ru"
        └── page.tsx         # Домашняя страница
```

---

## Конфигурации

### TypeScript (`tsconfig.json`)

```json
{
  "module": "ESNext",
  "moduleResolution": "Bundler",
  "target": "ES2022",
  "jsx": "react-jsx",
  "strict": true,
  "noEmit": true,
  "paths": { "@/*": ["./src/*"] }
}
```

### Tailwind CSS v4

CSS-first конфигурация — без `tailwind.config.js`:
- Единственный импорт: `@import "tailwindcss"` в `globals.css`
- PostCSS-плагин: `@tailwindcss/postcss` (не старый `tailwindcss`)
- Конфиг: `postcss.config.mjs`

### ESLint (flat config)

`eslint.config.mjs` расширяет `next/core-web-vitals` + `next/typescript`.  
Запуск: `yarn lint`.

---

## Команды

```bash
yarn install          # установка зависимостей
yarn dev              # http://localhost:3000 (hot reload)
yarn build            # production-сборка → .next/
yarn start            # запуск production-сборки
yarn lint             # ESLint
```

---

## Переменные окружения

Файл `.env.local` (не коммитится):

| Переменная | Значение для dev |
|---|---|
| `NEXT_PUBLIC_API_URL` | `http://localhost:8080` |

> `.env.example` содержит устаревший порт `3001` — нужно обновить на `8080` (текущий порт Spring Boot backend).

---

## Архитектурные соглашения

- **App Router** — все страницы в `src/app/`. Конвенции: `layout.tsx`, `page.tsx`, `loading.tsx`, `error.tsx`.
- **Path alias** — `@/` → `src/`. Использовать везде вместо относительных путей.
- **Server / Client Components** — по умолчанию компоненты серверные. `"use client"` добавлять только при необходимости (хуки, браузерные API, интерактивность).
- **Типизация** — строгий режим (`strict: true`). Не использовать `any`.
- **Стили** — только Tailwind-утилиты. Кастомные CSS-переменные при необходимости добавлять через `@theme` в `globals.css`.

---

## Верификация

```bash
cd frontend
yarn install
yarn dev

open http://localhost:3000
yarn build                     # должен завершиться без ошибок
yarn lint                      # должен завершиться без предупреждений
```
