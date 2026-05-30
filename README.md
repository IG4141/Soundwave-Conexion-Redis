Ivo Giuliano Cappetto
# SoundWave + Redis

## Implementación

**Problema**: Catálogo de 1000+ canciones en PostgreSQL causa carga lenta y bloqueo del navegador.

**Solución**:

1. **Paginación**: Envío de 20 canciones por página.
2. **Redis Cache-Aside**: Caché en memoria para reducir carga de PostgreSQL a cero en peticiones repetidas.

## Cómo funciona

- Frontend solicita página con parámetros `page` y `limit`
- Backend verifica Redis primero
  - Si existe en caché: retorna desde Redis (instantáneo)
  - Si no existe: consulta PostgreSQL, guarda en Redis (TTL 60s), retorna datos
- Navegación con botones Anterior/Siguiente

## Tecnologías

- Node.js + Express
- PostgreSQL
- Redis (patrón Cache-Aside)
- HTML5 + Bootstrap 5

## Ejecución

```bash
node index.js
```

Luego abrir `index.html` en el navegador.

## Verificación

- Primera carga de página: "Sirviendo página X desde PostgreSQL"
- Navegar y volver:"Sirviendo página X desde Redis"
- Redis Insight: `catalogo:page:X:limit:20` con TTL de 60s
