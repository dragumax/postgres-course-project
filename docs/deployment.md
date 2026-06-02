# Развёртывание

1. Установить Docker и Git.
2. Клонировать репозиторий.
3. Создать `secrets/db_password.txt`, `secrets/db_user.txt`, `secrets/db_name.txt` (содержимое – одна строка).
4. `cd deploy && docker compose up -d`
5. Проверить: `docker compose exec postgres pg_isready -U $(cat ../secrets/db_user.txt)`
