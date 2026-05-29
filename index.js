const express = require('express');
// Importamos el cliente de Redis
const { createClient } = require('redis');
const { Pool } = require('pg');
const cors = require('cors');

const app = express();
const PORT = 3000;

const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'soundwave_db',
    password: 'SQL123',
    port: 5432,
});

// Creamos y conectamos el cliente de Redis
const redisClient = createClient({
    url: 'redis://127.0.0.1:6379'
});

// Escuchamos errores y confirmamos la conexión exitosa
redisClient.on('error', (err) => console.log('Error en Redis Client', err));
redisClient.connect().then(() => console.log('Conectado exitosamente a Redis'));

app.use(cors());
app.use(express.json());

app.get('/api/catalogo', async (req, res) => {
    try {
        // 1. Capturamos qué página pide el frontend (por defecto la pág 1, de a 20 items)
        const page = parseInt(req.query.page) || 1;
        const limit = parseInt(req.query.limit) || 20;
        
        // Calculamos desde dónde empezar a traer datos en la DB (Offset)
        const offset = (page - 1) * limit;
 
        // 2. Creamos una Clave Única para esta página en Redis.
        // Ej: "catalogo:page:1:limit:20"
        const cacheKey = `catalogo:page:${page}:limit:${limit}`;
 
        // 3. INTENTO DE LECTURA (Caché): Le preguntamos a Redis si ya tiene esta página
        const cachedData = await redisClient.get(cacheKey);
 
        if (cachedData) {
            // Si los datos estaban en la RAM
            console.log(`Sirviendo página ${page} desde Redis`);
            return res.json(JSON.parse(cachedData)); 
        }
 
        // 4. Si Redis no los tenía, vamos a buscarlo a PostgreSQL
        console.log(`Sirviendo página ${page} desde PostgreSQL (Disco)`);
        const result = await pool.query(
            'SELECT * FROM obtener_catalogo_completo() LIMIT $1 OFFSET $2', 
            [limit, offset]
        );
 
        // 5. ESCRITURA EN CACHÉ: Guardamos el resultado en Redis para la próxima vez.
        // setEx guarda la clave y le pone un tiempo de vida (TTL) de 60 segundos.
        await redisClient.setEx(cacheKey, 60, JSON.stringify(result.rows));
 
        // 6. Finalmente, devolvemos las 20 canciones al usuario
        res.json(result.rows);
 
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Error interno en el servidor' });
    }
});

app.listen(PORT, () => {
    console.log('-------------------------------------------');
    console.log(`✅ Servidor ON: http://localhost:${PORT}`);
    console.log('-------------------------------------------');
});