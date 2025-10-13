

-- Insertar categorías por defecto
INSERT INTO categorias_productos (nombre, descripcion) VALUES
('Cortinas', 'Cortinas personalizadas de todo tipo'),
('Velos', 'Velos decorativos personalizados'),
('Persianas', 'Persianas de toda clase'),
('Toldillos', 'Toldillos antimosquitos'),
('Accesorios', 'Accesorios varios para instalación'),
('Soportes', 'Soportes y rieles para cortinas y persianas');

-- Insertar usuario administrador por defecto
-- Password: admin (debe cambiarse)
INSERT INTO usuarios (nombre_usuario, nombre_completo, email, password, rol) VALUES
('admin', 'Administrador del Sistema', 'admin@example.com', 'admin', 'administrador');

