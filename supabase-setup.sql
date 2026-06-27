-- ============================================================
--  DONPISO · Supabase Setup SQL
--  Proyecto: https://jbnfeqrdbxejxhwrpxkt.supabase.co
-- ============================================================

-- 1. CREAR TABLA propiedades
-- ============================================================
CREATE TABLE IF NOT EXISTS propiedades (
  id              UUID        DEFAULT gen_random_uuid() PRIMARY KEY,
  tipo            TEXT        NOT NULL,
  titulo          TEXT        NOT NULL,
  ubicacion       TEXT        NOT NULL,
  precio          NUMERIC     NOT NULL,
  metros          INTEGER,
  habitaciones    INTEGER,
  banos           INTEGER,
  descripcion     TEXT,
  caracteristicas TEXT[],
  imagen_url      TEXT,
  enlace_idealista TEXT,
  destacado       BOOLEAN     DEFAULT false,
  activo          BOOLEAN     DEFAULT true,
  created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- 2. HABILITAR ROW LEVEL SECURITY
-- ============================================================
ALTER TABLE propiedades ENABLE ROW LEVEL SECURITY;

-- 3. POLÍTICAS RLS
-- ============================================================

-- Anónimos: solo pueden leer propiedades activas
CREATE POLICY "Anon puede leer propiedades activas"
  ON propiedades
  FOR SELECT
  TO anon
  USING (activo = true);

-- Autenticados: pueden leer todas (incluidas inactivas)
CREATE POLICY "Autenticado puede leer todas"
  ON propiedades
  FOR SELECT
  TO authenticated
  USING (true);

-- Autenticados: pueden insertar
CREATE POLICY "Autenticado puede insertar"
  ON propiedades
  FOR INSERT
  TO authenticated
  WITH CHECK (true);

-- Autenticados: pueden actualizar
CREATE POLICY "Autenticado puede actualizar"
  ON propiedades
  FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Autenticados: pueden eliminar
CREATE POLICY "Autenticado puede eliminar"
  ON propiedades
  FOR DELETE
  TO authenticated
  USING (true);

-- 4. INSERTAR PROPIEDADES
-- ============================================================

INSERT INTO propiedades
  (tipo, titulo, ubicacion, precio, metros, habitaciones, banos, descripcion, caracteristicas, imagen_url, enlace_idealista, destacado)
VALUES
  (
    'Piso',
    'Piso en venta en Puerto de Garrucha',
    'Puerto de Garrucha, Garrucha (Almería)',
    165000,
    133,
    3,
    2,
    'Precioso apartamento en el centro de Garrucha con orientación este, ascensor comunitario, salón luminoso con balcón y vistas al puerto y la playa. Cocina independiente equipada, 3 dormitorios, terraza comunitaria con vistas al mar y plaza de parking privado.',
    ARRAY['Vistas al mar','Garaje incluido','Ascensor','Terraza','Aire acondicionado','Construido en 2005'],
    'https://img4.idealista.com/blur/WEB_DETAIL/0/id.pro.es.image.master/70/cf/64/1442676250.jpg',
    'https://www.idealista.com/inmueble/109498574/',
    false
  ),
  (
    'Dúplex',
    'Dúplex en venta en Vega de Acá - Nueva Almería',
    'Vega de Acá, Almería',
    290000,
    237,
    4,
    4,
    'Espectacular tríplex de 4 dormitorios en una de las zonas más deseadas de Almería, a minutos de la playa. Distribuido en tres plantas con terraza tipo solárium, garaje espacioso, placas solares, suelo de mármol y calefacción centralizada. Se vende amueblado.',
    ARRAY['Placas solares','Garaje','Terraza solárium','Amueblado','Aire acondicionado','Orientación sur','Construido en 2009'],
    'https://img4.idealista.com/blur/WEB_DETAIL/0/id.pro.es.image.master/21/6e/e5/1430365628.jpg',
    'https://www.idealista.com/inmueble/108909387/',
    false
  ),
  (
    'Chalet adosado',
    'Chalet adosado en venta en Huércal-Overa',
    'Bajo Almanzora, Almería',
    245000,
    246,
    4,
    3,
    'Encantadora vivienda unifamiliar adosada en Huércal-Overa rodeada de servicios. Porche amplio, salón con chimenea, cocina reformada, dormitorio en planta baja, dormitorio principal con baño en suite y terraza con vistas a la montaña. Garaje privado amplio. Se vende completamente amueblada.',
    ARRAY['Amueblado','Chimenea','Garaje','Terraza','Aire acondicionado','Orientación sur-oeste','Construido en 2002'],
    'https://img4.idealista.com/blur/WEB_DETAIL/0/id.pro.es.image.master/05/9b/6b/1436100310.jpg',
    'https://www.idealista.com/inmueble/111423685/',
    false
  ),
  (
    'Chalet adosado',
    'Chalet adosado en venta en Las Marinas, Vera',
    'Las Marinas, Vera (Almería)',
    650000,
    467,
    4,
    2,
    'Exclusivo chalet adosado en primera línea de playa. Vivienda de gran amplitud con 4 dormitorios, estancias luminosas, garaje privado, planta sótano versátil con potencial para segunda vivienda, zona de barbacoa y piscina privada. Vivir donde otros sueñan con estar.',
    ARRAY['Vistas al mar','Piscina privada','1ª línea de playa','Garaje','Zona barbacoa','Terraza','Orientación sur'],
    'https://img4.idealista.com/blur/WEB_DETAIL/0/id.pro.es.image.master/48/b7/23/1421225075.jpg',
    'https://www.idealista.com/inmueble/110969731/',
    true
  ),
  (
    'Piso',
    'Piso en venta en Playa de Garrucha',
    'Playa de Garrucha, Garrucha (Almería)',
    155000,
    76,
    2,
    2,
    'Vivienda ideal como residencia, segunda vivienda o inversión. 2 dormitorios, baño completo y aseo de cortesía, cocina independiente con lavadero y patio interior, salón comedor luminoso con balcón. Lista para entrar a vivir.',
    ARRAY['Ascensor','Balcón','Lista para entrar','Construido en 1990'],
    'https://img4.idealista.com/blur/WEB_DETAIL/0/id.pro.es.image.master/ee/de/c9/1424914057.jpg',
    'https://www.idealista.com/inmueble/111085688/',
    false
  ),
  (
    'Piso',
    'Piso en venta en Turre',
    'Turre, Levante (Almería)',
    115000,
    106,
    3,
    2,
    'Piso amplio con 3 dormitorios luminosos y versátiles, 2 baños completos, cocina independiente ventilada y salón-comedor con luz natural. Incluye plaza de garaje privada y terraza comunitaria. Perfecto para familias o inversores en zona consolidada con todos los servicios.',
    ARRAY['Garaje','Terraza','Ascensor','Aire acondicionado','Orientación sur-oeste','Construido en 2008'],
    'https://img4.idealista.com/blur/WEB_DETAIL/0/id.pro.es.image.master/a8/d3/17/1435088167.jpg',
    'https://www.idealista.com/inmueble/111393838/',
    false
  );
