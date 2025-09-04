/*******************************************************************************
 * Selected metadata objects
 * -------------------------
 * Extracted at 29/08/2025 19:24:01
 ******************************************************************************/

/*******************************************************************************
 * Tables
 * ------
 * Extracted at 29/08/2025 19:24:01
 ******************************************************************************/

CREATE TABLE PackingList
  DESCRIPTION 'Data/DataDict File'
(
    Ejercicio SmallInt,
    NroOperacion Integer,
    NroPalets SmallInt,
    TipoContenedor SmallInt,
    NroContenedor NVarChar(20),
    NroPrecinto NVarChar(20)
);

/*******************************************************************************
 * Primary Key Constraints
 * -----------------------
 * Extracted at 29/08/2025 19:24:01
 ******************************************************************************/

ALTER TABLE PackingList ADD CONSTRAINT I_PackingList_1 
  PRIMARY KEY (Ejercicio, NroOperacion);

