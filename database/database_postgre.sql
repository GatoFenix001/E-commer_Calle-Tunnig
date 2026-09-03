-- Empresa
CREATE TABLE empresa (
    id_empresa SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    ruc VARCHAR(20) UNIQUE,
    direccion TEXT,
    telefono VARCHAR(20),
    email VARCHAR(100)
);

-- Sede
CREATE TABLE sede (
    id_sede SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion TEXT,
    id_empresa INT,
    CONSTRAINT fk_sede_empresa FOREIGN KEY (id_empresa) REFERENCES empresa(id_empresa)
);

-- Puesto
CREATE TABLE puesto (
    id_puesto SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT
);

-- Rol
CREATE TABLE rol (
    id_rol SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL,
    descripcion TEXT
);

-- Usuario
CREATE TABLE usuario (
    id_usuario SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password VARCHAR(200) NOT NULL,
    id_rol INT,
    CONSTRAINT fk_usuario_rol FOREIGN KEY (id_rol) REFERENCES rol(id_rol)
);

-- Empleado
CREATE TABLE empleado (
    id_empleado SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    dni VARCHAR(20) UNIQUE,
    telefono VARCHAR(20),
    id_puesto INT,
    id_sede INT,
    CONSTRAINT fk_empleado_puesto FOREIGN KEY (id_puesto) REFERENCES puesto(id_puesto),
    CONSTRAINT fk_empleado_sede FOREIGN KEY (id_sede) REFERENCES sede(id_sede)
);

-- Cliente
CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100),
    dni VARCHAR(20) UNIQUE,
    telefono VARCHAR(20),
    email VARCHAR(100)
);

-- Vehículo
CREATE TABLE vehiculo (
    id_vehiculo SERIAL PRIMARY KEY,
    placa VARCHAR(20) UNIQUE NOT NULL,
    marca VARCHAR(100),
    modelo VARCHAR(100),
    id_cliente INT,
    CONSTRAINT fk_vehiculo_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- Producto
CREATE TABLE producto (
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    precio NUMERIC(10,2) NOT NULL,
    stock INT DEFAULT 0
);

-- Inventario
CREATE TABLE inventario (
    id_inventario SERIAL PRIMARY KEY,
    id_producto INT,
    cantidad INT NOT NULL,
    id_sede INT,
    CONSTRAINT fk_inventario_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    CONSTRAINT fk_inventario_sede FOREIGN KEY (id_sede) REFERENCES sede(id_sede)
);

-- Servicio
CREATE TABLE servicio (
    id_servicio SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    precio NUMERIC(10,2) NOT NULL
);

-- Orden de Trabajo
CREATE TABLE orden_trabajo (
    id_orden SERIAL PRIMARY KEY,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_cliente INT,
    id_vehiculo INT,
    id_empleado INT,
    estado VARCHAR(50) DEFAULT 'Pendiente',
    CONSTRAINT fk_orden_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    CONSTRAINT fk_orden_vehiculo FOREIGN KEY (id_vehiculo) REFERENCES vehiculo(id_vehiculo),
    CONSTRAINT fk_orden_empleado FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);

-- Pedido Cliente
CREATE TABLE pedido_cliente (
    id_pedido SERIAL PRIMARY KEY,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_cliente INT,
    estado VARCHAR(50) DEFAULT 'Pendiente',
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- Cotización
CREATE TABLE cotizacion (
    id_cotizacion SERIAL PRIMARY KEY,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_cliente INT,
    total NUMERIC(12,2),
    CONSTRAINT fk_cotizacion_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- Comprobante
CREATE TABLE comprobante (
    id_comprobante SERIAL PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_cliente INT,
    total NUMERIC(12,2),
    CONSTRAINT fk_comprobante_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- Pago
CREATE TABLE pago (
    id_pago SERIAL PRIMARY KEY,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    monto NUMERIC(12,2) NOT NULL,
    id_comprobante INT,
    CONSTRAINT fk_pago_comprobante FOREIGN KEY (id_comprobante) REFERENCES comprobante(id_comprobante)
);

-- Transferencia
CREATE TABLE transferencia (
    id_transferencia SERIAL PRIMARY KEY,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    origen VARCHAR(100),
    destino VARCHAR(100),
    id_producto INT,
    cantidad INT NOT NULL,
    CONSTRAINT fk_transferencia_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

-- Garantía
CREATE TABLE garantia (
    id_garantia SERIAL PRIMARY KEY,
    descripcion TEXT,
    fecha_inicio DATE,
    fecha_fin DATE,
    id_producto INT,
    id_cliente INT,
    CONSTRAINT fk_garantia_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    CONSTRAINT fk_garantia_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- Proceso de Negocio
CREATE TABLE proceso_negocio (
    id_proceso SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    responsable VARCHAR(100)
);

-- Log Auditoría
CREATE TABLE log_auditoria (
    id_log SERIAL PRIMARY KEY,
    usuario VARCHAR(100),
    accion VARCHAR(200),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
