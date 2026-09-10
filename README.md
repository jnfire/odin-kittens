# Odin Kittens API

API REST en Rails para gestionar kittens con autenticación por token.

## Stack

- Ruby
- Rails 8
- SQLite
- bcrypt para contraseñas

## Modelos

### User

El recurso `User` expone estos campos:

- `id`
- `email`
- `password_digest`
- `auth_token_digest`
- `auth_token_created_at`
- `created_at`
- `updated_at`

### Kitten

El recurso `Kitten` expone estos campos:

- `id`
- `name`
- `age`
- `cuteness`
- `softness`
- `created_at`
- `updated_at`

## Endpoints

### Autenticación

| Metodo | Endpoint | Descripcion |
| --- | --- | --- |
| `POST` | `/signup` | Crea un usuario |
| `POST` | `/login` | Devuelve un token de acceso |
| `DELETE` | `/logout` | Invalida el token actual |

### Kittens

| Metodo | Endpoint | Descripcion |
| --- | --- | --- |
| `GET` | `/kittens` | Lista de kittens |
| `POST` | `/kittens` | Crea un kitten (requiere token) |
| `GET` | `/kittens/:id` | Devuelve un kitten |
| `PATCH` | `/kittens/:id` | Actualiza un kitten (requiere token) |
| `PUT` | `/kittens/:id` | Reemplaza o actualiza un kitten (requiere token) |
| `DELETE` | `/kittens/:id` | Elimina un kitten (requiere token) |

## Formato soportado

- JSON

## Autenticación

La API usa un token basado en cabecera HTTP:

```http
Authorization: Bearer <token>
```

Los endpoints protegidos requieren ese header.

## Payloads

### Signup

```json
{
  "user": {
    "email": "test@example.com",
    "password": "secret123",
    "password_confirmation": "secret123"
  }
}
```

### Login

```json
{
  "email": "test@example.com",
  "password": "secret123"
}
```

### Kitten

Para crear o actualizar un kitten:

```json
{
  "kitten": {
    "name": "Milo",
    "age": 2,
    "cuteness": 10,
    "softness": 9
  }
}
```

## Ejemplos de uso

### 1. Crear usuario

```bash
curl -X POST http://localhost:3000/signup \
  -H "Content-Type: application/json" \
  -d '{
    "user": {
      "email": "test@example.com",
      "password": "secret123",
      "password_confirmation": "secret123"
    }
  }'
```

Respuesta esperada:

```json
{
  "id": 1,
  "email": "test@example.com"
}
```

### 2. Login

```bash
curl -X POST http://localhost:3000/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "secret123"
  }'
```

Respuesta esperada:

```json
{
  "token": "abc123..."
}
```

### 3. Listar kittens

```bash
curl http://localhost:3000/kittens
```

Respuesta esperada:

```json
[
  {
    "id": 1,
    "name": "Milo",
    "age": 2,
    "cuteness": 10,
    "softness": 9,
    "created_at": "2026-09-10T06:00:00.000Z",
    "updated_at": "2026-09-10T06:00:00.000Z",
    "url": "http://localhost:3000/kittens/1.json"
  }
]
```

### 4. Crear un kitten autenticado

```bash
curl -X POST http://localhost:3000/kittens \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer abc123..." \
  -d '{
    "kitten": {
      "name": "Milo",
      "age": 2,
      "cuteness": 10,
      "softness": 9
    }
  }'
```

Respuesta esperada:

```json
{
  "id": 1,
  "name": "Milo",
  "age": 2,
  "cuteness": 10,
  "softness": 9,
  "created_at": "2026-09-10T06:00:00.000Z",
  "updated_at": "2026-09-10T06:00:00.000Z",
  "url": "http://localhost:3000/kittens/1.json"
}
```

### 5. Actualizar un kitten autenticado

```bash
curl -X PATCH http://localhost:3000/kittens/1 \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer abc123..." \
  -d '{
    "kitten": {
      "name": "Luna",
      "softness": 10
    }
  }'
```

### 6. Eliminar un kitten autenticado

```bash
curl -X DELETE http://localhost:3000/kittens/1 \
  -H "Authorization: Bearer abc123..."
```

Respuesta esperada:

```http
HTTP/1.1 204 No Content
```

### 7. Logout

```bash
curl -X DELETE http://localhost:3000/logout \
  -H "Authorization: Bearer abc123..."
```

Respuesta esperada:

```http
HTTP/1.1 204 No Content
```

## Códigos de respuesta

- `200 OK`: operación correcta en lectura o actualización
- `201 Created`: creación correcta
- `204 No Content`: eliminación o logout correcto
- `401 Unauthorized`: token faltante o inválido
- `422 Unprocessable Entity`: validación fallida

## Puesta en marcha

1. Instala dependencias:

   ```bash
   bundle install
   ```

2. Ejecuta las migraciones:

   ```bash
   bundle exec rails db:migrate
   ```

3. Arranca el servidor:

   ```bash
   bundle exec rails server
   ```

## Tests

Para ejecutar los tests del controlador:

```bash
bundle exec rails test test/controllers/kittens_controller_test.rb
```
