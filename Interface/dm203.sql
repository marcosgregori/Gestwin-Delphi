/*******************************************************************************
 * Selected metadata objects
 * -------------------------
 * Extracted at 29/08/2025 19:23:39
 ******************************************************************************/

/*******************************************************************************
 * Tables
 * ------
 * Extracted at 29/08/2025 19:23:39
 ******************************************************************************/

CREATE TABLE StockEnvases
  DESCRIPTION 'Data/DataDict File'
(
    Propietario NVarChar(5),
    TipoEnvase SmallInt DEFAULT 0,
    CodigoEnvase NVarChar(3),
    Cantidad Decimal(16, 4)
);

/*******************************************************************************
 * Primary Key Constraints
 * -----------------------
 * Extracted at 29/08/2025 19:23:39
 ******************************************************************************/

ALTER TABLE StockEnvases ADD CONSTRAINT I_Envases_1 
  PRIMARY KEY (Propietario, TipoEnvase, CodigoEnvase);

