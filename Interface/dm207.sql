/*******************************************************************************
 * Selected metadata objects
 * -------------------------
 * Extracted at 29/08/2025 19:24:23
 ******************************************************************************/

/*******************************************************************************
 * Tables
 * ------
 * Extracted at 29/08/2025 19:24:23
 ******************************************************************************/

CREATE TABLE Categoria
  DESCRIPTION 'Data/DataDict File'
  STORAGE ENGINE 'Variable'
(
    Id AutoInc,
    Codigo NVarChar(5),
    Nombre NVarChar(40),
    CodigoPadre NVarChar(5),
    DespuesDeCodigo NVarChar(5),
    Descripcion NVarChar(256),
    CodigoFamilia NVarChar(6),
    Activo Boolean
);

CREATE TABLE CategoriasArticulo
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    CodigoArticulo NVarChar(20) NOT NULL,
    NroOrden SmallInt NOT NULL,
    CodigoCategoria NVarChar(5) NOT NULL DESCRIPTION 'CodigoClaseA'
);

/*******************************************************************************
 * Indices
 * -------
 * Extracted at 29/08/2025 19:24:23
 ******************************************************************************/

CREATE INDEX Index_2
 ON Categoria(CodigoFamilia, Codigo);

CREATE INDEX Index_2
 ON CategoriasArticulo(CodigoCategoria, CodigoArticulo);

/*******************************************************************************
 * Primary Key Constraints
 * -----------------------
 * Extracted at 29/08/2025 19:24:23
 ******************************************************************************/

ALTER TABLE Categoria ADD CONSTRAINT Index_1 
  PRIMARY KEY (Codigo);

ALTER TABLE CategoriasArticulo ADD CONSTRAINT Index_1 
  PRIMARY KEY (CodigoArticulo, NroOrden, CodigoCategoria);

