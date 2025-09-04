/*******************************************************************************
 * Selected metadata objects
 * -------------------------
 * Extracted at 29/08/2025 19:21:33
 ******************************************************************************/

/*******************************************************************************
 * Tables
 * ------
 * Extracted at 29/08/2025 19:21:33
 ******************************************************************************/

CREATE TABLE HojaCarga
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt,
    NroHoja Integer,
    Fecha Date,
    CodigoTransportista NVarChar(2),
    EjercicioReubicacion SmallInt,
    NroOperacionReubicacion Integer,
    NoProcesar Boolean DEFAULT FALSE,
    Procesado Boolean DEFAULT FALSE,
    Anotacion NCLOB
);

CREATE TABLE LineaHojaCarga
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt,
    NroHoja Integer,
    NroLinea SmallInt,
    EjercicioOrigen SmallInt DESCRIPTION 'EjercicioPedido',
    NroOperacionOrigen Integer DESCRIPTION 'NroOperacionPedido',
    NroRegistroOrigen Integer DESCRIPTION 'NroRegistroPedido',
    CodigoAlmacen NVarChar(2),
    Ubicacion NVarChar(6),
    NroCajas Decimal(16, 4),
    Cargado Decimal(16, 4),
    EjercicioDestino SmallInt DESCRIPTION 'EjercicioNroOperacionMovimiento',
    NroOperacionDestino Integer DESCRIPTION 'NroOperacionMovimiento',
    NroRegistroDestino Integer DESCRIPTION 'NroRegistroMovimiento',
    Anotacion NCLOB
);

/*******************************************************************************
 * Indices
 * -------
 * Extracted at 29/08/2025 19:21:33
 ******************************************************************************/

CREATE INDEX "Index 1"
 ON HojaCarga(Fecha);

CREATE INDEX "Index 2"
 ON HojaCarga(CodigoTransportista, Fecha);

CREATE INDEX "Index 3"
 ON HojaCarga(EjercicioReubicacion, NroOperacionReubicacion);

CREATE INDEX I_LineaHojaCarga_2
 ON LineaHojaCarga(NroRegistroOrigen);

CREATE INDEX I_LineaHojaCarga_3
 ON LineaHojaCarga(NroRegistroDestino);

/*******************************************************************************
 * Primary Key Constraints
 * -----------------------
 * Extracted at 29/08/2025 19:21:33
 ******************************************************************************/

ALTER TABLE HojaCarga ADD CONSTRAINT "Index 0" 
  PRIMARY KEY (Ejercicio, NroHoja);

ALTER TABLE LineaHojaCarga ADD CONSTRAINT I_LineaHojaCarga_1 
  PRIMARY KEY (Ejercicio, NroHoja, NroLinea);

