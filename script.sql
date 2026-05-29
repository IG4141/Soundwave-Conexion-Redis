
DROP FUNCTION IF EXISTS obtener_catalogo();
DROP TABLE IF EXISTS cancion_playlist CASCADE;
DROP TABLE IF EXISTS playlist CASCADE;
DROP TABLE IF EXISTS cancion CASCADE;
DROP TABLE IF EXISTS artista CASCADE;
DROP TABLE IF EXISTS genero CASCADE;

CREATE TABLE genero (
    id_genero SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE artista (
    id_artista SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    biografia TEXT,
    nacionalidad VARCHAR(100),
    id_genero INT,
    CONSTRAINT fk_genero_artista FOREIGN KEY (id_genero) REFERENCES genero(id_genero)
);

CREATE TABLE cancion (
    id_cancion SERIAL PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    duracion INT NOT NULL,
    id_artista INT NOT NULL,
    id_genero INT NOT NULL,
    CONSTRAINT fk_artista_cancion FOREIGN KEY (id_artista) REFERENCES artista(id_artista) ON DELETE CASCADE,
    CONSTRAINT fk_genero_cancion FOREIGN KEY (id_genero) REFERENCES genero(id_genero)
);

CREATE TABLE playlist (
    id_playlist SERIAL PRIMARY KEY,
    nombre_usuario VARCHAR(100) NOT NULL,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE cancion_playlist (
    id_playlist INT NOT NULL,
    id_cancion INT NOT NULL,
    PRIMARY KEY (id_playlist, id_cancion),
    CONSTRAINT fk_playlist FOREIGN KEY (id_playlist) REFERENCES playlist(id_playlist) ON DELETE CASCADE,
    CONSTRAINT fk_cancion FOREIGN KEY (id_cancion) REFERENCES cancion(id_cancion) ON DELETE CASCADE
);


INSERT INTO genero (nombre) VALUES ('Rock'), ('Pop'), ('Tango');


INSERT INTO artista (nombre, biografia, nacionalidad, id_genero) VALUES 
('Los Gatos', 'Pioneros del rock de autor en español.', 'Argentina', 1),
('Almendra', 'Banda fundacional de Luis Alberto Spinetta.', 'Argentina', 1),
('Soda Stereo', 'El trío más influyente de Latinoamérica.', 'Argentina', 1),
('Patricio Rey', 'Fenómeno cultural liderado por el Indio Solari.', 'Argentina', 1),
('Sui Generis', 'Dúo acústico de Charly García y Nito Mestre.', 'Argentina', 1),
('Serú Girán', 'La superbanda de los años 70.', 'Argentina', 1),
('Carlos Gardel', 'El Zorzal Criollo, máximo exponente del tango.', 'Argentina', 3),
('León Gieco', 'Cantautor de protesta y folclore-rock.', 'Argentina', 1),
('Astor Piazzolla', 'Revolucionario del tango moderno.', 'Argentina', 3),
('Fito Páez', 'Uno de los grandes solistas del rock-pop.', 'Argentina', 1),
('Mercedes Sosa', 'La voz de América Latina.', 'Argentina', 1),
('Los Abuelos de la Nada', 'Referentes del pop rock ochentoso.', 'Argentina', 2),
('Andrés Calamaro', 'El Salmón, prolífico creador de hits.', 'Argentina', 2),
('Los Fabulosos Cadillacs', 'Fusión de rock, ska y ritmos latinos.', 'Argentina', 1),
('Vox Dei', 'Banda histórica del rock pesado y blues.', 'Argentina', 1),
('Gustavo Cerati', 'Músico, cantautor y genio de la guitarra.', 'Argentina', 2),
('Luis Alberto Spinetta', 'El Flaco, poeta máximo del rock nacional.', 'Argentina', 1),
('Los Enanitos Verdes', 'Grandes del rock melódico.', 'Argentina', 1),
('Memphis la Blusera', 'Referentes del blues en Argentina.', 'Argentina', 1),
('Miguel Mateos', 'Icono del rock-pop de los 80.', 'Argentina', 2),
('Piero', 'Cantautor de música social y pop.', 'Argentina', 2),
('Los Chalchaleros', 'Máximos exponentes del folclore tradicional.', 'Argentina', 1),
('Bersuit Vergarabat', 'Banda de rock alternativo y fusión.', 'Argentina', 1),
('Los Auténticos Decadentes', 'La banda de la alegría.', 'Argentina', 2),
('Charly García', 'El padre del rock nacional moderno.', 'Argentina', 1);


INSERT INTO cancion (titulo, duracion, id_artista, id_genero) VALUES 
('La balsa', 170, (SELECT id_artista FROM artista WHERE nombre='Los Gatos'), 1),
('Muchacha (Ojos de papel)', 225, (SELECT id_artista FROM artista WHERE nombre='Almendra'), 1),
('De música ligera', 212, (SELECT id_artista FROM artista WHERE nombre='Soda Stereo'), 1),
('Ji ji ji', 330, (SELECT id_artista FROM artista WHERE nombre='Patricio Rey'), 1),
('Rasguña las piedras', 184, (SELECT id_artista FROM artista WHERE nombre='Sui Generis'), 1),
('Seminare', 200, (SELECT id_artista FROM artista WHERE nombre='Serú Girán'), 1),
('El día que me quieras', 230, (SELECT id_artista FROM artista WHERE nombre='Carlos Gardel'), 3),
('Sólo le pido a Dios', 290, (SELECT id_artista FROM artista WHERE nombre='León Gieco'), 1),
('Por una cabeza', 160, (SELECT id_artista FROM artista WHERE nombre='Carlos Gardel'), 3),
('Adiós Nonino', 480, (SELECT id_artista FROM artista WHERE nombre='Astor Piazzolla'), 3),
('Persiana americana', 292, (SELECT id_artista FROM artista WHERE nombre='Soda Stereo'), 1),
('11 y 6', 215, (SELECT id_artista FROM artista WHERE nombre='Fito Páez'), 2),
('Alfonsina y el mar', 280, (SELECT id_artista FROM artista WHERE nombre='Mercedes Sosa'), 1),
('Mil horas', 170, (SELECT id_artista FROM artista WHERE nombre='Los Abuelos de la Nada'), 2),
('Flaca', 230, (SELECT id_artista FROM artista WHERE nombre='Andrés Calamaro'), 2),
('Matador', 275, (SELECT id_artista FROM artista WHERE nombre='Los Fabulosos Cadillacs'), 1),
('Presente (El momento en que estás)', 190, (SELECT id_artista FROM artista WHERE nombre='Vox Dei'), 1),
('Crimen', 228, (SELECT id_artista FROM artista WHERE nombre='Gustavo Cerati'), 2),
('Seguir viviendo sin tu amor', 215, (SELECT id_artista FROM artista WHERE nombre='Luis Alberto Spinetta'), 1),
('Lamento boliviano', 220, (SELECT id_artista FROM artista WHERE nombre='Los Enanitos Verdes'), 1),
('Balada para un loco', 285, (SELECT id_artista FROM artista WHERE nombre='Astor Piazzolla'), 3),
('La bifurcada', 240, (SELECT id_artista FROM artista WHERE nombre='Memphis la Blusera'), 1),
('Tirá para arriba', 295, (SELECT id_artista FROM artista WHERE nombre='Miguel Mateos'), 2),
('Mi viejo', 200, (SELECT id_artista FROM artista WHERE nombre='Piero'), 2),
('Zamba de mi esperanza', 185, (SELECT id_artista FROM artista WHERE nombre='Los Chalchaleros'), 1),
('La argentinidad al palo', 320, (SELECT id_artista FROM artista WHERE nombre='Bersuit Vergarabat'), 1),
('Estadio Azteca', 215, (SELECT id_artista FROM artista WHERE nombre='Andrés Calamaro'), 2),
('El murguero', 280, (SELECT id_artista FROM artista WHERE nombre='Los Auténticos Decadentes'), 2),
('Y dale alegría a mi corazón', 255, (SELECT id_artista FROM artista WHERE nombre='Fito Páez'), 1),
('Los dinosaurios', 208, (SELECT id_artista FROM artista WHERE nombre='Charly García'), 1);

INSERT INTO playlist (nombre_usuario, nombre) VALUES ('User_Pro', 'Antología Argentina');
INSERT INTO cancion_playlist (id_playlist, id_cancion) VALUES (1, 1), (1, 2), (1, 3);

CREATE OR REPLACE FUNCTION obtener_catalogo()
RETURNS TABLE (
    titulo VARCHAR,
    duracion INT,
    artista VARCHAR,
    genero VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        c.titulo, 
        c.duracion, 
        a.nombre AS artista, 
        g.nombre AS genero
    FROM cancion c
    INNER JOIN artista a ON c.id_artista = a.id_artista
    INNER JOIN genero g ON c.id_genero = g.id_genero;
END;
$$ LANGUAGE plpgsql;