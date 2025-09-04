/*******************************************************************************
 * Selected metadata objects
 * -------------------------
 * Extracted at 29/08/2025 19:22:01
 ******************************************************************************/

/*******************************************************************************
 * Tables
 * ------
 * Extracted at 29/08/2025 19:22:01
 ******************************************************************************/

CREATE TABLE RegistroExportacion
  DESCRIPTION 'Data/DataDict File'
(
    TipoDocumento SmallInt,
    Ejercicio SmallInt,
    Serie NVarChar(2),
    NroDocumento Integer,
    NroRegistro SmallInt
);

/*******************************************************************************
 * Indices
 * -------
 * Extracted at 29/08/2025 19:22:01
 ******************************************************************************/

CREATE INDEX "Index 0"
 ON RegistroExportacion(TipoDocumento, Ejercicio, Serie, NroDocumento, NroRegistro);

