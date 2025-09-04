/*******************************************************************************
 * Selected metadata objects
 * -------------------------
 * Extracted at 29/08/2025 19:22:48
 ******************************************************************************/

/*******************************************************************************
 * Tables
 * ------
 * Extracted at 29/08/2025 19:22:48
 ******************************************************************************/

CREATE TABLE Actividad
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(3),
    Descripcion NVarChar(30)
);

CREATE TABLE Contacto
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(5),
    Nombre NVarChar(40),
    Domicilio NVarChar(40),
    Localidad NVarChar(30),
    CodigoPais NVarChar(3),
    CodigoProvincia NVarChar(2),
    CodigoPostal NVarChar(3),
    CodigoActividad NVarChar(3),
    PersonaContacto1 NVarChar(40),
    Cargo1 NVarChar(20),
    Movil1 NVarChar(30),
    EMail1 NVarChar(30),
    PersonaContacto2 NVarChar(40),
    Cargo2 NVarChar(20),
    Movil2 NVarChar(30),
    EMail2 NVarChar(30),
    PaginaWeb NVarChar(30),
    PrimerContacto Date,
    UltimoContacto Date,
    Telefono NVarChar(20),
    Fax NVarChar(20),
    Informatizado Boolean,
    ProveedorExterno NVarChar(5),
    Interesado Boolean,
    ProximoContacto Date,
    Notas NCLOB
);

CREATE TABLE ContactoWeb
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(5),
    Nombre NVarChar(40),
    Domicilio NVarChar(40),
    Localidad NVarChar(30),
    CodigoProvincia NVarChar(2),
    CodigoPostal NVarChar(3),
    Empresa NVarChar(40),
    PrimerContacto Date,
    Telefono NVarChar(20),
    EMail NVarChar(60),
    Distribuidor Boolean,
    PersonaContacto NVarChar(40),
    Cargo NVarChar(30),
    CopiaEvaluacion Boolean,
    AplicacionEvaluacion SmallInt,
    InteresadoContable Boolean,
    InteresadoComercial Boolean,
    InteresadoContableComercial Boolean,
    InteresadoTPV Boolean,
    InteresadoPreventa Boolean,
    Comentarios NCLOB,
    Notas NCLOB,
    FechaEnvioDemoVirtualUI Date,
    FechaEnvioEvaluacion Date,
    FechaEnvioRecordatorio Date,
    FechaEnvioOferta Date,
    FechaCompra Date,
    CodigoGestion NVarChar(5)
);

CREATE TABLE LineaTarjetaRegistro
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    NroRegistro Integer,
    NroLinea SmallInt,
    Fecha Date,
    NroSerie BigInt,
    Version SmallInt,
    Release SmallInt,
    NroUsuarios SmallInt,
    FechaCaducidad Date,
    Observaciones NVarChar(80)
);

CREATE TABLE PersonaContacto
  DESCRIPTION 'Data/DataDict File'
  STORAGE ENGINE 'Variable'
(
    Tipo SmallInt NOT NULL,
    Propietario NVarChar(5) NOT NULL,
    NroRegistro SmallInt NOT NULL,
    Nombre NVarChar(40) NOT NULL,
    TelefonoOficina NVarChar(20),
    Movil NVarChar(20),
    TelefonoParticular NVarChar(20),
    Fax NVarChar(20),
    NoLlamar Boolean,
    EMail NVarChar(80),
    FechaNacimiento Date,
    AsignadoA NVarChar(2),
    Observaciones NCLOB
);

CREATE TABLE ProveedorExterno
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(5),
    Nombre NVarChar(40),
    Domicilio NVarChar(40),
    Localidad NVarChar(30),
    CodigoPais NVarChar(3),
    CodigoProvincia NVarChar(2),
    CodigoPostal NVarChar(3)
);

CREATE TABLE RegistroActualizaciones
  DESCRIPTION 'Data/DataDict File'
(
    NroRegistro AutoInc,
    Fecha Timestamp,
    NroSerie BigInt,
    ClaveActivacion BigInt,
    NroRegistroAplicacion Integer,
    NroPrograma SmallInt,
    Version SmallInt,
    Release SmallInt,
    NroUsuarios SmallInt,
    Localizacion NVarChar(128),
    CodigoResultado SmallInt
);

CREATE TABLE RegistroAplicacion
  DESCRIPTION 'Data/DataDict File'
(
    NroRegistro AutoInc,
    Fecha Timestamp,
    Tipo SmallInt,
    CodigoUsuario NVarChar(5),
    Nombre NVarChar(40),
    NroRegistroAplicacion Integer,
    NroPrograma SmallInt,
    Version SmallInt,
    Release SmallInt,
    NroSerie BigInt,
    ClaveActivacion BigInt,
    NroUsuarios SmallInt,
    Localizacion NVarChar(128),
    CodigoResultado SmallInt
);

CREATE TABLE Tarea
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
  STORAGE ENGINE 'Variable'
(
    Ejercicio SmallInt NOT NULL,
    NroTarea Integer NOT NULL,
    Estado SmallInt,
    Fecha Date,
    NroAplicacion SmallInt,
    Modulo SmallInt,
    CodigoCliente NVarChar(5),
    CodigoTecnico NVarChar(2),
    Urgente Boolean,
    Prioridad SmallInt,
    CodigoTipoTarea NVarChar(2),
    Asunto NVarChar(256),
    FechaResolucion Date,
    Tiempo DWord,
    Duracion Time,
    Resolucion NVarChar(256)
);

CREATE TABLE TarjetaRegistro
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    NroRegistro Integer,
    NroSerie BigInt,
    CodigoGestion NVarChar(5),
    Nombre NVarChar(40),
    Domicilio NVarChar(40),
    Localidad NVarChar(30),
    CodigoPais NVarChar(3),
    CodigoProvincia NVarChar(2),
    CodigoPostal NVarChar(3),
    Telefono NVarChar(20),
    Fax NVarChar(20),
    FechaInstalacion Date,
    FechaCaducidad Date,
    CodigoProveedor NVarChar(5),
    Aplicacion SmallInt,
    Version SmallInt,
    Release SmallInt,
    NroUsuarios SmallInt,
    TipoContrato SmallInt DEFAULT 0,
    ModulosOpcionales SmallInt,
    NroFichaVentaPeriodica Integer,
    Anotacion NCLOB
);

CREATE TABLE Tecnico
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(2) NOT NULL,
    Nombre NVarChar(30),
    TelefonoMovil NVarChar(20)
);

CREATE TABLE TipoTarea
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(2) NOT NULL,
    Descripcion NVarChar(30),
    Urgente Boolean
);

/*******************************************************************************
 * Indices
 * -------
 * Extracted at 29/08/2025 19:22:48
 ******************************************************************************/

CREATE UNIQUE INDEX "Index 0"
 ON Actividad(Codigo);

CREATE INDEX "Index 1"
 ON Contacto(CodigoPais, CodigoProvincia LOCALE 3082 USE STRING SORT, CodigoPostal LOCALE 3082 USE STRING SORT, Codigo LOCALE 3082 USE STRING SORT);

CREATE UNIQUE INDEX "Index 2"
 ON Contacto(CodigoActividad, Codigo LOCALE 3082 USE STRING SORT);

CREATE INDEX "Index 3"
 ON Contacto(UltimoContacto);

CREATE INDEX "Index 4"
 ON Contacto(ProximoContacto);

CREATE INDEX "Index 1"
 ON ContactoWeb(CodigoProvincia, CodigoPostal LOCALE 3082 USE STRING SORT, Codigo LOCALE 3082 USE STRING SORT);

CREATE INDEX Index_1
 ON RegistroActualizaciones(NroRegistroAplicacion);

CREATE INDEX Index_2
 ON RegistroAplicacion(Tipo, Fecha);

CREATE INDEX I_Tarea_1
 ON Tarea(Fecha);

CREATE INDEX I_Tarea_2
 ON Tarea(Estado, Fecha);

CREATE INDEX I_Tarea_3
 ON Tarea(CodigoTecnico, Estado, Fecha);

CREATE INDEX I_Tarea_4
 ON Tarea(Fecha, CodigoCliente, CodigoTecnico, CodigoTipoTarea);

CREATE INDEX Index_1
 ON TarjetaRegistro(CodigoGestion, FechaInstalacion);

/*******************************************************************************
 * Primary Key Constraints
 * -----------------------
 * Extracted at 29/08/2025 19:22:48
 ******************************************************************************/

ALTER TABLE Contacto ADD CONSTRAINT "Index 0" 
  PRIMARY KEY (Codigo);

ALTER TABLE ContactoWeb ADD CONSTRAINT "Index 0" 
  PRIMARY KEY (Codigo);

ALTER TABLE LineaTarjetaRegistro ADD CONSTRAINT "Index 0" 
  PRIMARY KEY (NroRegistro, NroLinea);

ALTER TABLE PersonaContacto ADD CONSTRAINT PK_Contacto 
  PRIMARY KEY (Tipo, Propietario, NroRegistro);

ALTER TABLE ProveedorExterno ADD CONSTRAINT "Index 0" 
  PRIMARY KEY (Codigo);

ALTER TABLE RegistroAplicacion ADD CONSTRAINT Index_1 
  PRIMARY KEY (NroRegistro);

ALTER TABLE Tarea ADD CONSTRAINT PK_Tarea 
  PRIMARY KEY (Ejercicio, NroTarea);

ALTER TABLE TarjetaRegistro ADD CONSTRAINT "Index 0" 
  PRIMARY KEY (NroRegistro);

ALTER TABLE Tecnico ADD CONSTRAINT PK_Tecnico 
  PRIMARY KEY (Codigo);

ALTER TABLE TipoTarea ADD CONSTRAINT PK_TipoTarea 
  PRIMARY KEY (Codigo);

