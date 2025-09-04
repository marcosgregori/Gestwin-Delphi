/*******************************************************************************
 * Selected metadata objects
 * -------------------------
 * Extracted at 29/08/2025 19:22:24
 ******************************************************************************/

/*******************************************************************************
 * Tables
 * ------
 * Extracted at 29/08/2025 19:22:24
 ******************************************************************************/

CREATE TABLE AsignacionMaquinas
  DESCRIPTION 'Data/DataDict File'
  STORAGE ENGINE 'Variable'
(
    CodigoMaquinaTipo NVarChar(5) NOT NULL,
    CodigoMaquina NVarChar(5) NOT NULL
);

CREATE TABLE Calendario
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Fecha Date NOT NULL,
    TipoJornada SmallInt NOT NULL,
    TiempoExterno DWord,
    Turno1 SmallInt,
    Turno2 SmallInt,
    Turno3 SmallInt,
    Turno4 SmallInt
);

CREATE TABLE CodigoCoste
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo SmallInt NOT NULL,
    Descripcion NVarChar(30) NOT NULL,
    Tipo SmallInt NOT NULL
);

CREATE TABLE Contenedor
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    NroOrdenFabricacion Integer NOT NULL,
    NroProceso SmallInt NOT NULL,
    CorrectasEntradas Decimal(16, 4),
    CorrectasSalidas Decimal(16, 4),
    DefectuosasEntradas Decimal(16, 4),
    DefectuosasSalidas Decimal(16, 4),
    SubcontratistaEntradas Decimal(16, 4),
    SubcontratistaSalidas Decimal(16, 4),
    MermaExcesoEntradas Decimal(16, 4),
    MermaExcesoSalidas Decimal(16, 4),
    IncorporadasExtraidasEntradas Decimal(16, 4),
    IncorporadasExtraidasSalidas Decimal(16, 4)
);

CREATE TABLE CosteMaquina
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    CodigoMaquina NVarChar(5) NOT NULL,
    NroRegistro SmallInt NOT NULL,
    CodigoCoste SmallInt,
    Coste Decimal(16, 4)
);

CREATE TABLE CosteOperacExternas
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    CodigoSubcontratista NVarChar(5) NOT NULL,
    CodigoOperacion NVarChar(5) NOT NULL,
    NroRegistro SmallInt NOT NULL,
    CodigoArticulo NVarChar(20),
    CodigoClaseA NVarChar(3),
    CodigoClaseB NVarChar(3),
    CodigoClaseC NVarChar(3),
    CosteUnitario Decimal(16, 4)
);

CREATE TABLE CosteOperario
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    CodigoOperario NVarChar(5) NOT NULL,
    NroRegistro SmallInt NOT NULL,
    Turno SmallInt NOT NULL,
    CosteHora Decimal(16, 4)
);

CREATE TABLE Defecto
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo SmallInt NOT NULL,
    Descripcion NVarChar(30) NOT NULL,
    CodigoClaseA NVarChar(3),
    CodigoClaseB NVarChar(3),
    CodigoClaseC NVarChar(3)
);

CREATE TABLE DefectoInformeFabricacion
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    NroOrden Integer NOT NULL,
    NroProceso SmallInt NOT NULL,
    Fecha Date NOT NULL,
    Turno SmallInt NOT NULL,
    NroRegistro SmallInt NOT NULL,
    CodigoDefecto SmallInt,
    Unidades Decimal(16, 4)
);

CREATE TABLE Incidencia
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo SmallInt NOT NULL,
    Descripcion NVarChar(30) NOT NULL
);

CREATE TABLE InformeFabricacion
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    NroOrden Integer NOT NULL,
    NroProceso SmallInt NOT NULL,
    Fecha Date NOT NULL,
    Turno SmallInt NOT NULL,
    Correctas Decimal(16, 4),
    Defectuosas Decimal(16, 4),
    MermaExceso Decimal(16, 4),
    IncorpExtraidas Decimal(16, 4),
    CodigoDefecto SmallInt,
    IncExtClaseA NVarChar(3) DEFAULT EMPTY,
    IncExtClaseB NVarChar(3) DEFAULT EMPTY,
    IncExtClaseC NVarChar(3) DEFAULT EMPTY,
    HoraInicio Time,
    HoraFinalizacion Time,
    Preparacion DWord,
    Fabricacion DWord,
    CodigoIncidencia SmallInt,
    Observaciones NCLOB
);

CREATE TABLE Lanzamiento
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    NroOperacion Integer NOT NULL,
    Fecha Date NOT NULL,
    Tipo SmallInt
);

CREATE TABLE LineaInformeFabricacion
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    NroOrden Integer NOT NULL,
    NroProceso SmallInt NOT NULL,
    Fecha Date NOT NULL,
    Turno SmallInt NOT NULL,
    NroRegistro SmallInt NOT NULL,
    CodigoOperario NVarChar(5)
);

CREATE TABLE LineaLanzamiento
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    NroOperacion Integer NOT NULL,
    NroRegistro SmallInt NOT NULL,
    EjercicioPedido SmallInt,
    NroOperacionPedido Integer,
    CodigoArticulo NVarChar(20),
    CodigoClaseA NVarChar(3),
    CodigoClaseB NVarChar(3),
    CodigoClaseC NVarChar(3),
    Pendiente Decimal(16, 4),
    ServirDeStock Decimal(16, 4),
    Fabricar Decimal(16, 4),
    EjercicioAlbaran SmallInt,
    Serie NVarChar(2),
    NroAlbaran Integer
);

CREATE TABLE LineaOFComponente
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    Tipo SmallInt NOT NULL,
    NroOrden Integer NOT NULL,
    NroProceso SmallInt NOT NULL,
    NroRegistro SmallInt NOT NULL,
    CodigoArticulo NVarChar(20) NOT NULL,
    CodigoClaseA NVarChar(3) DEFAULT EMPTY,
    CodigoClaseB NVarChar(3) DEFAULT EMPTY,
    CodigoClaseC NVarChar(3) DEFAULT EMPTY,
    Lote NVarChar(20),
    CantidadOriginal Double Precision,
    Cantidad Double Precision,
    ConsumoPrevisto Double Precision,
    ConsumoReal Double Precision
);

CREATE TABLE LineaOFOperacion
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    Tipo SmallInt NOT NULL,
    NroOrden Integer NOT NULL,
    NroProceso SmallInt NOT NULL,
    CodigoOperacion NVarChar(5) NOT NULL,
    OperacionExterna Boolean,
    CodigoSubcontratista NVarChar(5),
    CodigoMaquina NVarChar(5),
    Turno SmallInt,
    FechaInicio Date,
    FechaFinalizacion Date,
    Observaciones NVarChar(127)
);

CREATE TABLE LineaOFPedido
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    Tipo SmallInt NOT NULL,
    NroOrden Integer NOT NULL,
    EjercicioPedido SmallInt NOT NULL,
    NroOperacionPedido Integer NOT NULL
);

CREATE TABLE LineaOperacion
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(5),
    NroRegistro SmallInt,
    CodigoOperarioTipo NVarChar(5),
    Cantidad SmallInt
);

CREATE TABLE LineaOrdenAprovisionamiento
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    NroOrden Integer NOT NULL,
    NroRegistro SmallInt NOT NULL,
    CodigoArticulo NVarChar(20) NOT NULL,
    CodigoClaseA NVarChar(3) DEFAULT EMPTY,
    CodigoClaseB NVarChar(3) DEFAULT EMPTY,
    CodigoClaseC NVarChar(3) DEFAULT EMPTY,
    CodigoAlmacen NVarChar(2),
    CantidadOrden Decimal(16, 4),
    Cantidad Decimal(16, 4),
    CodigoProveedor NVarChar(5) NOT NULL,
    EjercicioOrden SmallInt,
    NroOrdenFabricacion Integer,
    EjercicioPedido SmallInt,
    NroOperacionPedido Integer
);

CREATE TABLE Maquina
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(5) NOT NULL,
    Descripcion NVarChar(30) NOT NULL,
    Ubicacion NVarChar(30),
    CodigoMaquinaTipo NVarChar(5) NOT NULL,
    ProcesosSimultaneos SmallInt,
    TurnoActividad1 SmallInt NOT NULL,
    TurnoActividad2 SmallInt,
    TurnoActividad3 SmallInt,
    TurnoActividad4 SmallInt,
    TiempoMinAsignacion DWord,
    TiempoMaxAsignacion DWord
);

CREATE TABLE MaquinaTipo
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(5),
    Descripcion NVarChar(30),
    CosteHora Decimal(16, 4),
    MetodoAsignacion SmallInt
);

CREATE TABLE NotificacionES
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    NroNotificacion Integer NOT NULL,
    EjercicioOrden SmallInt NOT NULL,
    NroOrden Integer NOT NULL,
    NroProceso SmallInt NOT NULL,
    Fecha Date,
    TipoOperacion SmallInt,
    Correctas Decimal(16, 4),
    Defectuosas Decimal(16, 4),
    CodigoDefecto SmallInt,
    MermaExceso Decimal(16, 4),
    IncorpExtraidas Decimal(16, 4),
    IncExtClaseA NVarChar(3),
    IncExtClaseB NVarChar(3),
    IncExtClaseC NVarChar(3),
    Coste Decimal(16, 4),
    Observaciones NVarChar(80)
);

CREATE TABLE OcupacionMaquina
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    CodigoMaquina NVarChar(5) NOT NULL,
    Fecha Date NOT NULL,
    Turno SmallInt NOT NULL,
    Ocupado DWord
);

CREATE TABLE Operacion
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(5),
    Descripcion NVarChar(30),
    Reservado NVarChar(2),
    OperacionExterna Boolean,
    UnidadesTiempo Integer,
    CodigoOperador NVarChar(5),
    Preparacion DWord,
    Fabricacion DWord,
    AlmacenComponentes NVarChar(2),
    AlmacenProdAcabado NVarChar(2)
);

CREATE TABLE OperariosMaquina
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    CodigoMaquina NVarChar(5) NOT NULL,
    Turno SmallInt NOT NULL,
    NroRegistro SmallInt NOT NULL,
    CodigoOperario NVarChar(5) NOT NULL
);

CREATE TABLE OperarioTipo
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(5),
    Descripcion NVarChar(30),
    CosteHora Decimal(16, 4)
);

CREATE TABLE OrdenAprovisionamiento
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    NroOrden Integer NOT NULL,
    Fecha Date,
    FechaRecepcion Date,
    Origen SmallInt,
    EjercicioOrigen SmallInt,
    NroRegistroOrigen Integer
);

CREATE TABLE OrdenFabricacion
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    Tipo SmallInt NOT NULL,
    NroOrden Integer NOT NULL,
    EjercicioPedido SmallInt,
    SeriePedido NVarChar(2),
    NroPedido Integer,
    EjercicioLanzamiento SmallInt,
    NroOperacionLanzamiento Integer,
    CodigoArticulo NVarChar(20),
    CodigoClaseA NVarChar(3) DEFAULT EMPTY,
    CodigoClaseB NVarChar(3) DEFAULT EMPTY,
    CodigoClaseC NVarChar(3) DEFAULT EMPTY,
    Lote NVarChar(20),
    UnidadesAFabricar Decimal(16, 4),
    FechaLanzamiento Date,
    Prioridad SmallInt,
    NroOrdenVinculada Integer,
    Aprovisionamiento Boolean,
    Cerrado Boolean,
    Cargas Integer,
    mDispFabricacion1 Integer,
    mFabricacion Integer,
    mFabricDefectuosa Integer,
    mExtraidoIncorporado Integer,
    Observaciones NCLOB
);

CREATE TABLE ParteIncidencia
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    CodigoMaquina NVarChar(5) NOT NULL,
    Fecha Date NOT NULL,
    Turno SmallInt NOT NULL,
    NroRegistro SmallInt NOT NULL,
    CodigoIncidencia SmallInt,
    HoraInicio Time,
    HoraFinalizacion Time,
    Observaciones NVarChar(80)
);

CREATE TABLE RelacionMateriales
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    CodigoArticulo NVarChar(20),
    CodigoClaseA NVarChar(3) DEFAULT EMPTY,
    CodigoClaseB NVarChar(3) DEFAULT EMPTY,
    CodigoClaseC NVarChar(3) DEFAULT EMPTY,
    Proceso SmallInt,
    NroLinea SmallInt,
    CodigoComponente NVarChar(20),
    ClaseAComponente NVarChar(3),
    ClaseBComponente NVarChar(3),
    ClaseCComponente NVarChar(3),
    Cantidad Double Precision
);

CREATE TABLE RelacionOperaciones
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    CodigoArticulo NVarChar(20),
    CodigoClaseA NVarChar(3) DEFAULT EMPTY,
    CodigoClaseB NVarChar(3) DEFAULT EMPTY,
    CodigoClaseC NVarChar(3) DEFAULT EMPTY,
    Proceso SmallInt,
    CodigoOperacion NVarChar(5),
    TiempoPreparacion DWord,
    TiempoFabricacion DWord,
    UnidadesTiempo Integer,
    Anotacion NCLOB
);

CREATE TABLE SecuenciaAsignacion
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    NroOrdenFabricacion Integer NOT NULL,
    NroProceso SmallInt NOT NULL,
    Segmento SmallInt NOT NULL,
    CodigoMaquina NVarChar(5),
    Fecha Date,
    Turno SmallInt,
    NroOrdenEntrada SmallInt DEFAULT 0,
    Prioridad SmallInt,
    HoraInicio Time,
    Tiempo DWord,
    Cantidad Decimal(16, 4),
    Realizado Boolean DEFAULT FALSE
);

CREATE TABLE Turno
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    NroTurno SmallInt NOT NULL,
    Descripcion NVarChar(30) NOT NULL,
    Inicio1 Time,
    Fin1 Time,
    Inicio2 Time,
    Fin2 Time
);

/*******************************************************************************
 * Indices
 * -------
 * Extracted at 29/08/2025 19:22:25
 ******************************************************************************/

CREATE INDEX Index_1
 ON AsignacionMaquinas(CodigoMaquinaTipo);

CREATE UNIQUE INDEX "Index 0"
 ON Calendario(Fecha);

CREATE UNIQUE INDEX "Index 0"
 ON CodigoCoste(Codigo);

CREATE UNIQUE INDEX "Index 0"
 ON Contenedor(Ejercicio, NroOrdenFabricacion, NroProceso);

CREATE UNIQUE INDEX "Index 0"
 ON CosteMaquina(CodigoMaquina, NroRegistro);

CREATE UNIQUE INDEX "Index 0"
 ON CosteOperacExternas(CodigoSubcontratista, CodigoOperacion LOCALE 3082 USE STRING SORT, NroRegistro);

CREATE INDEX "Index 1"
 ON CosteOperacExternas(CodigoArticulo, CodigoClaseA LOCALE 3082 USE STRING SORT, CodigoClaseB LOCALE 3082 USE STRING SORT, CodigoClaseC LOCALE 3082 USE STRING SORT, CodigoSubcontratista LOCALE 3082 USE STRING SORT, CodigoOperacion LOCALE 3082 USE STRING SORT);

CREATE UNIQUE INDEX Index_0
 ON CosteOperario(CodigoOperario, NroRegistro);

CREATE UNIQUE INDEX Index_1
 ON CosteOperario(CodigoOperario, Turno);

CREATE UNIQUE INDEX "Index 0"
 ON Defecto(Codigo);

CREATE UNIQUE INDEX "Index 0"
 ON DefectoInformeFabricacion(Ejercicio, NroOrden, NroProceso, Fecha, Turno, NroRegistro);

CREATE UNIQUE INDEX "Index 0"
 ON Incidencia(Codigo);

CREATE UNIQUE INDEX "Index 0"
 ON InformeFabricacion(Ejercicio, NroOrden, NroProceso, Fecha, Turno);

CREATE INDEX "Index 1"
 ON InformeFabricacion(Fecha, Turno);

CREATE UNIQUE INDEX "Index 0"
 ON Lanzamiento(Ejercicio, NroOperacion);

CREATE INDEX "Index 1"
 ON Lanzamiento(Fecha);

CREATE UNIQUE INDEX Index_0
 ON LineaInformeFabricacion(Ejercicio, NroOrden, NroProceso, Fecha, Turno, NroRegistro);

CREATE UNIQUE INDEX Index_1
 ON LineaInformeFabricacion(Ejercicio, NroOrden, NroProceso, Fecha, Turno, CodigoOperario);

CREATE UNIQUE INDEX "Index 0"
 ON LineaLanzamiento(Ejercicio, NroOperacion, NroRegistro);

CREATE INDEX "Index 1"
 ON LineaLanzamiento(Ejercicio, NroOperacion, CodigoArticulo LOCALE 3082 USE STRING SORT, CodigoClaseA LOCALE 3082 USE STRING SORT, CodigoClaseB LOCALE 3082 USE STRING SORT, CodigoClaseC LOCALE 3082 USE STRING SORT);

CREATE INDEX "Index 2"
 ON LineaLanzamiento(EjercicioPedido, NroOperacionPedido, CodigoArticulo LOCALE 3082 USE STRING SORT, CodigoClaseA LOCALE 3082 USE STRING SORT, CodigoClaseB LOCALE 3082 USE STRING SORT, CodigoClaseC LOCALE 3082 USE STRING SORT);

CREATE UNIQUE INDEX "Index 0"
 ON LineaOFComponente(Ejercicio, Tipo, NroOrden, NroProceso, NroRegistro);

CREATE UNIQUE INDEX "Index 0"
 ON LineaOFOperacion(Ejercicio, Tipo, NroOrden, NroProceso);

CREATE INDEX "Index 1"
 ON LineaOFOperacion(FechaInicio, CodigoSubcontratista LOCALE 3082 USE STRING SORT);

CREATE INDEX "Index 2"
 ON LineaOFOperacion(FechaInicio);

CREATE INDEX "Index 3"
 ON LineaOFOperacion(FechaFinalizacion);

CREATE UNIQUE INDEX "Index 0"
 ON LineaOFPedido(Ejercicio, Tipo, NroOrden, EjercicioPedido, NroOperacionPedido);

CREATE UNIQUE INDEX "Index 0"
 ON LineaOrdenAprovisionamiento(Ejercicio, NroOrden, NroRegistro);

CREATE INDEX "Index 1"
 ON LineaOrdenAprovisionamiento(Ejercicio, NroOrden, CodigoProveedor LOCALE 3082 USE STRING SORT);

CREATE INDEX "Index 2"
 ON LineaOrdenAprovisionamiento(Ejercicio, NroOrden, CodigoArticulo LOCALE 3082 USE STRING SORT, CodigoClaseA LOCALE 3082 USE STRING SORT, CodigoClaseB LOCALE 3082 USE STRING SORT, CodigoClaseC LOCALE 3082 USE STRING SORT, CodigoAlmacen LOCALE 3082 USE STRING SORT);

CREATE UNIQUE INDEX "Index 0"
 ON Maquina(Codigo);

CREATE INDEX "Index 1"
 ON Maquina(CodigoMaquinaTipo, Codigo LOCALE 3082 USE STRING SORT);

CREATE UNIQUE INDEX "Index 0"
 ON NotificacionES(Ejercicio, NroNotificacion);

CREATE INDEX "Index 1"
 ON NotificacionES(EjercicioOrden, NroOrden, NroProceso);

CREATE UNIQUE INDEX "Index 0"
 ON OcupacionMaquina(CodigoMaquina, Fecha, Turno);

CREATE UNIQUE INDEX "Index 0"
 ON OperariosMaquina(CodigoMaquina, Turno, NroRegistro);

CREATE UNIQUE INDEX "Index 0"
 ON OrdenAprovisionamiento(Ejercicio, NroOrden);

CREATE UNIQUE INDEX "Index 1"
 ON OrdenAprovisionamiento(Origen, EjercicioOrigen, NroRegistroOrigen);

CREATE INDEX "Index 1"
 ON OrdenFabricacion(EjercicioPedido, SeriePedido, NroPedido);

CREATE INDEX "Index 2"
 ON OrdenFabricacion(EjercicioLanzamiento, NroOperacionLanzamiento);

CREATE INDEX "Index 3"
 ON OrdenFabricacion(FechaLanzamiento, CodigoArticulo);

CREATE INDEX "Index 4"
 ON OrdenFabricacion(EjercicioLanzamiento, NroOperacionLanzamiento, CodigoArticulo LOCALE 3082 USE STRING SORT, CodigoClaseA LOCALE 3082 USE STRING SORT, CodigoClaseB LOCALE 3082 USE STRING SORT, CodigoClaseC LOCALE 3082 USE STRING SORT);

CREATE UNIQUE INDEX "Index 0"
 ON ParteIncidencia(CodigoMaquina, Fecha, Turno, NroRegistro);

CREATE INDEX Index1
 ON RelacionMateriales(CodigoComponente, ClaseAComponente, ClaseBComponente, ClaseCComponente);

CREATE UNIQUE INDEX "Index 0"
 ON SecuenciaAsignacion(Ejercicio, NroOrdenFabricacion, NroProceso, Segmento);

CREATE INDEX "Index 1"
 ON SecuenciaAsignacion(CodigoMaquina, Fecha, Turno, NroOrdenEntrada);

CREATE UNIQUE INDEX "Index 2"
 ON SecuenciaAsignacion(Ejercicio, NroOrdenFabricacion, NroProceso, Fecha, Turno);

CREATE INDEX "Index 3"
 ON SecuenciaAsignacion(Fecha, Turno, CodigoMaquina LOCALE 3082 USE STRING SORT, NroOrdenEntrada);

CREATE INDEX "Index 4"
 ON SecuenciaAsignacion(CodigoMaquina, Fecha, Turno, Prioridad, NroOrdenFabricacion);

CREATE UNIQUE INDEX "Index 0"
 ON Turno(NroTurno);

/*******************************************************************************
 * Primary Key Constraints
 * -----------------------
 * Extracted at 29/08/2025 19:22:25
 ******************************************************************************/

ALTER TABLE LineaOperacion ADD CONSTRAINT "Index 0" 
  PRIMARY KEY (Codigo, NroRegistro);

ALTER TABLE MaquinaTipo ADD CONSTRAINT "Index 0" 
  PRIMARY KEY (Codigo);

ALTER TABLE Operacion ADD CONSTRAINT "Index 0" 
  PRIMARY KEY (Codigo);

ALTER TABLE OperarioTipo ADD CONSTRAINT "Index 0" 
  PRIMARY KEY (Codigo);

ALTER TABLE OrdenFabricacion ADD CONSTRAINT "Index 0" 
  PRIMARY KEY (Ejercicio, Tipo, NroOrden);

ALTER TABLE RelacionMateriales ADD CONSTRAINT "Index 0" 
  PRIMARY KEY (CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, Proceso, NroLinea);

ALTER TABLE RelacionOperaciones ADD CONSTRAINT "Index 0" 
  PRIMARY KEY (CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, Proceso);

