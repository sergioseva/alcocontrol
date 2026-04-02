-- 1. Crear tabla de testimonios
CREATE TABLE testimonios (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre TEXT NOT NULL,
  ciudad TEXT NOT NULL,
  tipo TEXT NOT NULL DEFAULT 'conductor',
  texto TEXT NOT NULL,
  estado TEXT NOT NULL DEFAULT 'pendiente',
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 2. Habilitar Row Level Security
ALTER TABLE testimonios ENABLE ROW LEVEL SECURITY;

-- 3. Cualquiera puede leer testimonios aprobados
CREATE POLICY "Leer aprobados" ON testimonios
  FOR SELECT USING (estado = 'aprobado');

-- 4. Cualquiera puede enviar un testimonio (siempre entra como pendiente)
CREATE POLICY "Insertar pendiente" ON testimonios
  FOR INSERT WITH CHECK (estado = 'pendiente');

-- 5. Insertar los testimonios de ejemplo
INSERT INTO testimonios (nombre, ciudad, tipo, texto, estado, created_at) VALUES
  ('Rodrigo M.', 'Gualeguaychú', 'conductor', 'Estuve 45 minutos en la fila en el puente el sábado pasado. Era noche de temporada, lleno de turistas. Todos sobrios. El control siguió hasta la medianoche pero los chicos que iban al boliche después de la 1 entraron sin problema.', 'aprobado', '2025-03-15'),
  ('Marcela, bar El Almacén', 'Gualeguaychú', 'negocio', 'Nos avisaron que había control en la entrada de la ciudad ese fin de semana largo. Teníamos el salón completo reservado. Cancelaron el 60% de las mesas. No hay forma de recuperar eso. Y encima, cuántos positivos hicieron? Nadie te dice.', 'aprobado', '2025-02-02'),
  ('Turista cordobés', 'Córdoba (visitando)', 'turista', 'Primera vez en la ciudad, fuimos con mi familia. En la salida el domingo a la noche, dos horas de cola. Los chicos dormidos en el auto. Cuando llegué al control, "todo bien, siga". Listo. La próxima vamos a San Martín de los Andes.', 'aprobado', '2025-01-22');

-- 6. Moderador autenticado puede leer TODOS los testimonios (pendientes incluidos)
CREATE POLICY "Moderador lee todo" ON testimonios
  FOR SELECT TO authenticated USING (true);

-- 7. Moderador autenticado puede cambiar estado (aprobar/rechazar)
CREATE POLICY "Moderador modera" ON testimonios
  FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
