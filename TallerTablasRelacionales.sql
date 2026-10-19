CREATE TABLE libros (
    codigo VARCHAR(5) PRIMARY KEY,
    titulo VARCHAR(50) NOT NULL,
    paginas INT NOT NULL
);

CREATE TABLE autores (
    id INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    pais VARCHAR(30) NOT NULL
);

CREATE TABLE libro_autor (
    la_libro_codigo_fk VARCHAR(5) NOT NULL,
    la_autor_id_fk INT NOT NULL,
    anio_publicacion INT NOT NULL,
    PRIMARY KEY (la_libro_codigo_fk, la_autor_id_fk),
    CONSTRAINT fk_libro FOREIGN KEY (la_libro_codigo_fk) REFERENCES libros(codigo) ON DELETE CASCADE,
    CONSTRAINT fk_autor FOREIGN KEY (la_autor_id_fk) REFERENCES autores(id) ON DELETE CASCADE
);

INSERT INTO libros (codigo, titulo, paginas) VALUES 
('L001', 'Cien años de soledad', 417),
('L002', 'El principito', 96),
('L003', 'Crimen y castigo', 671),
('L004', 'La sombra del viento', 576);

INSERT INTO autores (id, nombre, pais) VALUES 
(1, 'Gabriel García Márquez', 'Colombia'),
(2, 'Antoine de Saint-Exupéry', 'Francia'),
(3, 'Fiódor Dostoyevski', 'Rusia');

INSERT INTO libro_autor (la_libro_codigo_fk, la_autor_id_fk, anio_publicacion) VALUES 
('L001', 1, 1967),
('L002', 2, 1943),
('L003', 3, 1866),
('L004', 1, 2001),
('L001', 3, 2022);

SELECT l.titulo, a.nombre, a.pais, la.anio_publicacion
FROM libro_autor la
INNER JOIN libros l ON la.la_libro_codigo_fk = l.codigo
INNER JOIN autores a ON la.la_autor_id_fk = a.id;

SELECT DISTINCT l.titulo, la.anio_publicacion
FROM libro_autor la
INNER JOIN libros l ON la.la_libro_codigo_fk = l.codigo
WHERE la.anio_publicacion > 2020;

SELECT * FROM autores 
WHERE pais = 'Colombia';

SELECT l.titulo, la.anio_publicacion
FROM libro_autor la
INNER JOIN libros l ON la.la_libro_codigo_fk = l.codigo
ORDER BY la.anio_publicacion DESC;

SELECT a.nombre, COUNT(la.la_libro_codigo_fk) AS total_libros
FROM autores a
LEFT JOIN libro_autor la ON a.id = la.la_autor_id_fk
GROUP BY a.id, a.nombre;

ALTER TABLE libros ADD COLUMN precio DOUBLE PRECISION;

UPDATE libros SET precio = 19.99 WHERE codigo = 'L001';
UPDATE libros SET precio = 12.50 WHERE codigo = 'L002';
UPDATE libros SET precio = 25.00 WHERE codigo = 'L003';

SELECT titulo, precio 
FROM libros 
WHERE precio IS NOT NULL;