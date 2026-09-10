# Odin Kittens API

API sencilla en Rails para gestionar kittens.

## Stack

- Ruby
- Rails 8
- SQLite

## Modelo

El recurso `Kitten` expone estos campos:

- `name`
- `age`
- `cuteness`
- `softness`
- `created_at`
- `updated_at`

## Endpoints

La aplicación expone `resources :kittens`, por lo que están disponibles estos endpoints:

| Metodo | Endpoint | Descripcion |
| --- | --- | --- |
| `GET` | `/kittens` | Lista de kittens |
| `POST` | `/kittens` | Crea un kitten |
| `GET` | `/kittens/:id` | Devuelve un kitten |
| `PATCH` | `/kittens/:id` | Actualiza un kitten |
| `PUT` | `/kittens/:id` | Reemplaza o actualiza un kitten |
| `DELETE` | `/kittens/:id` | Elimina un kitten |

## Formato soportado

- JSON

Ejemplos de rutas:

- `/kittens.json`
- `/kittens/1.json`

## Payload de entrada

Para `create` y `update`, los parámetros van dentro de `kitten`:

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

## Respuestas

- `GET /kittens` devuelve la colección de kittens
- `GET /kittens/:id` devuelve un kitten
- `POST /kittens` responde con `201 Created` si se crea correctamente
- `PATCH /kittens/:id` y `PUT /kittens/:id` responden con `200 OK` si actualizan correctamente
- `DELETE /kittens/:id` responde con `204 No Content`
- Los errores de validación o parámetros responden con `422 Unprocessable Content`

## Ejemplos de uso

### Listar kittens

```bash
curl http://localhost:3000/kittens.json
```

Respuesta JSON de ejemplo:

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

### Obtener un kitten

```bash
curl http://localhost:3000/kittens/1.json
```

### Crear un kitten

```bash
curl -X POST http://localhost:3000/kittens.json \
  -H "Content-Type: application/json" \
  -d '{"kitten":{"name":"Milo","age":2,"cuteness":10,"softness":9}}'
```

### Actualizar un kitten

```bash
curl -X PATCH http://localhost:3000/kittens/1.json \
  -H "Content-Type: application/json" \
  -d '{"kitten":{"name":"Luna","softness":10}}'
```

### Eliminar un kitten

```bash
curl -X DELETE http://localhost:3000/kittens/1.json
```

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
