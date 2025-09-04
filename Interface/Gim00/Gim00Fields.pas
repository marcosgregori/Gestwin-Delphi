{$ALIGN OFF} {$OPTIMIZATION OFF}

unit Gim00Fields;

interface

uses  System.UITypes,
      SBTypes,

      DB,
      DataManager;

{$TYPEINFO ON}   // Rtti

const  // Identificadores de ventanas

       idDashboard   = 0100;

       idMntUsrForm  = 0120;

       CodigoEspaña  = '011';     // El código por defecto para España

type

  TCodigoPostalFields = class( TnxeDatasetFields)
     public
       CodigoPais : TWideStringField;
       CodigoProvincia : TWideStringField;
       Codigo : TWideStringField;
       Nombre : TWideStringField;
     end;

     TConfiguracionFields = class( TnxeDatasetFields)
     public
       Aplicacion : TSmallIntField;
       Tipo : TSmallIntField;
       Codigo : TWideStringField;
       Data : TBlobField;
     end;

     TConfiguracionCorreoFields = class( TnxeDatasetFields)
     public
       Id : TUnsignedAutoIncField;
       CodigoEmpresa : TWideStringField;
       CodigoUsuario : TWideStringField;
       ServidorSMTP : TWideStringField;
       PuertoSMTP : TSmallIntField;
       SeguridadSMTP : TSmallIntField;
       TipoServidorCorreoEntrante : TSmallIntField;
       ServidorPOP3IMAP : TWideStringField;
       PuertoPOP3IMAP : TSmallIntField;
       SeguridadPOP3IMAP : TSmallIntField;
       Usuario : TWideStringField;
       Password : TWideStringField;
       Direccion : TWideStringField;
       Firma : TWideMemoField;
       AccesoOAuthPOP3IMAP : TBooleanField;
       AccesoOAuthSMTP : TBooleanField;
       ProveedorOAuth : TSmallIntField;
       IDCliente : TWideStringField;
       IDInquilino : TWideStringField;
       ClaveSecreta : TWideStringField;
       UsuarioOAuth : TWideStringField;
       end;

     TContadoresFields = class( TnxeDatasetFields)
     public
       CodigoEmpresa : TWideStringField;
       Tipo : TSmallIntField;
       Ejercicio : TSmallIntField;
       Codigo : TWideStringField;
       Valor : TIntegerField;
     end;

     TCorreoFields = class( TnxeDatasetFields)
       CodigoEmpresa : TWideStringField;
       CodigoUsuario : TWideStringField;
       Carpeta : TSmallIntField;
       Tipo : TSmallIntField;
       ID : TUnsignedAutoIncField;
       Asunto,
       Remitente,
       Destinatario : TWideStringField;
       Fecha : TDateField;
       Hora : TTimeField;
       FechaProceso : TDateField;
       HoraProceso : TTimeField;
       Parametros : TWideMemoField;
       Adjunto : TBlobField;
     end;

     TDiarioProcesosFields = class( TnxeDatasetFields)
     public
       CodigoEmpresa : TWideStringField;
       CodigoUsuario : TWideStringField;
       Tipo : TSmallIntField;
       Opcion : TSmallIntField;
       Fecha : TDateField;
       Hora : TTimeField;
       Descripcion : TWideStringField;
       Informacion : TWideMemoField;
     end;

     TDireccionCorreoFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       Nombre : TWideStringField;
       EsUnGrupo : TBooleanField;
       EMail : TWideStringField;
       Grupo : TWideStringField;
     end;

     TDivisaFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       Descripcion : TWideStringField;
       PrecisionRedondeo : TFloatField;
       CambioFijo : TBooleanField;
       TipoCambio : TFloatField;
     end;

     TEntidadFinancieraFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       Sucursal : TWideStringField;
       Nombre : TWideStringField;
       Localidad : TWideStringField;
       BIC : TWideStringField;
     end;

     TEjercicioFields = class( TnxeDatasetFields)
     public
       Ejercicio : TSmallIntField;
       MesCambioImpositivo : TSmallIntField;
     end;

     TInmovilizado_CampoLibreArray = Array[ 1..4 ] of TWideStringField;
     TInmovilizado_CampoLibObligArray = Array[ 1..4 ] of TBooleanField;
     TNombreCampoLibreArray = Array[ 1..10 ] of TWideStringField;
     TCliente_CampoLibreArray = Array[ 1..4 ] of TWideStringField;
     TCliente_CampoLibObligArray = Array[ 1..4 ] of TBooleanField;
     TProveedor_CampoLibArray = Array[ 1..4 ] of TWideStringField;
     TProveedor_CampoLibObligArray = Array[ 1..4 ] of TBooleanField;
     TProveedor_CampoAuxArray = Array[ 1..10 ] of TWideStringField;
     TArticulo_ExisteClaseArray = Array[ 1..3 ] of TBooleanField;
     TArticulo_NombreClaseArray = Array[ 1..3 ] of TWideStringField;
     TArticulo_CampoLibreArray = Array[ 1..16 ] of TWideStringField;
     TArticulo_CampoLibObligArray = Array[ 1..16 ] of TBooleanField;
     TDocumento_CampoLibreArray = Array[ 1..5 ] of TWideStringField;
     TDocumento_CampoLibObligArray = Array[ 1..5 ] of TBooleanField;
     TLineas_CampoLibreArray = Array[ 1..5 ] of TWideStringField;
     TLineas_CampoLibreObligArray = Array[ 1..5 ] of TBooleanField;
     TLineas_CampoLibrePosArray = Array[ 1..5 ] of TSmallIntField;

     TEmpresaFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       Nombre : TWideStringField;
       Domicilio : TWideStringField;
       Localidad : TWideStringField;
       CodigoPais : TWideStringField;
       CodigoProvincia : TWideStringField;
       CodigoPostal : TWideStringField;
       NIF : TWideStringField;
       Telefono : TWideStringField;
       Fax : TWideStringField;
       CodigoEAN : TWideStringField;
       DataPath : TWideStringField;
       RemoteDataPath : TWideStringField;
       ComprobarDatosRemotos : TBooleanField;
       DataServer : TWideStringField;
       FTPPath : TWideStringField;
       DiasLaborables : TIntegerField;
       InicioJornadaLaboral : TTimeField;
       FinJornadaLaboral : TTimeField;
       RegimenEspecialCriterioCaja : TBooleanField;
       PersonaConQuienRelacionarse : TWideStringField;
       Registro_Libro : TWideStringField;
       Registro_RegistroMercantil : TWideStringField;
       Registro_Hoja : TWideStringField;
       Registro_Folio : TWideStringField;
       Registro_Seccion : TWideStringField;
       Registro_Tomo : TWideStringField;
       Registro_OtrosDatos : TWideStringField;
       Compras_UltNroFra : TIntegerField;
       Compras_DecCantidad : TSmallIntField;
       Compras_DecPrecio : TSmallIntField;
       Compras_DecDto : TSmallIntField;
       Compras_DecCajas : TSmallIntField;
       Compras_VerStock : TBooleanField;
       Compras_EmitirFras : TBooleanField;
       Compras_Cantidades : TSmallIntField;
       Compras_NombreCajas : TWideStringField;
       Compras_EditarBultosAlbaran : TBooleanField;
       Compras_NombreBultos : TWideStringField;
       Compras_Calculo : TSmallIntField;
       Compras_RedImpNeto : TBooleanField;
       Compras_ActTarifas : TBooleanField;
       Compras_Ubicaciones : TBooleanField;
       Compras_NrosSerie : TBooleanField;
       Compras_Divisas : TBooleanField;
       Compras_AlmacenDefec : TWideStringField;
       Compras_UtilizarPrecioOfertas : TBooleanField;
       Compras_CamposLibres : TBooleanField;
       Compras_CampoLibre : TDocumento_CampoLibreArray;
       Compras_CampoLibreObligatorio : TDocumento_CampoLibObligArray;
       Compras_CamposLibresLineas : TBooleanField;
       Compras_CampoLibreLineas : TLineas_CampoLibreArray;
       Compras_CampoLibreLineasOblig : TLineas_CampoLibreObligArray;
       Compras_CampoLibreLineasPos : TLineas_CampoLibrePosArray;
       Compras_Operarios : TBooleanField;
       Compras_FechaRecepcionPorLinea: TBooleanField;
       Compras_FechaCaducidad : TBooleanField;
       Ventas_ContMovCaja : TBooleanField;
       Ventas_DecCantidad : TSmallIntField;
       Ventas_DecPrecio : TSmallIntField;
       Ventas_DecRecargo : TSmallIntField;
       Ventas_DecDto : TSmallIntField;
       Ventas_DecCajas : TSmallIntField;
       Ventas_VerStock : TBooleanField;
       Ventas_DtoPrevio : TBooleanField;
       Ventas_PagosPedido : TBooleanField;
       Ventas_SeriesPedido : TBooleanField;
       Ventas_Cantidades : TSmallIntField;
       Ventas_NombreCajas : TWideStringField;
       Ventas_Calculo : TSmallIntField;
       Ventas_RedImpNeto : TBooleanField;
       Ventas_Ubicaciones : TBooleanField;
       Ventas_NrosSerie : TBooleanField;
       Ventas_SerieDefecto : TWideStringField;
       Ventas_AlmacenDefec : TWideStringField;
       Ventas_RiesgoPedido : TBooleanField;
       Ventas_RiesgoAlbaran : TBooleanField;
       Ventas_Transportista : TBooleanField;
       Ventas_CompCorrDoc : TBooleanField;
       Ventas_Recargos : TBooleanField;
       Ventas_NombreRecargos : TWideStringField;
       Ventas_MostrarRentabilidad : TBooleanField;
       Ventas_PreAutoVenta : TSmallIntField;
       Ventas_CamposLibres : TBooleanField;
       Ventas_CampoLibre : TDocumento_CampoLibreArray;
       Ventas_CampoLibreObligatorio : TDocumento_CampoLibObligArray;
       Ventas_CamposLibresLineas : TBooleanField;
       Ventas_CampoLibreLineas : TLineas_CampoLibreArray;
       Ventas_CampoLibreLineasOblig : TLineas_CampoLibreObligArray;
       Ventas_CampoLibreLineasPos : TLineas_CampoLibrePosArray;
       Ventas_CampoLibreLineasComp : TBooleanField;
       Ventas_Divisas : TBooleanField;
       Ventas_DocumentosPaginados : TBooleanField;
       Ventas_NombrePaginas : TWideStringField;
       Ventas_EditarBultosAlbaran : TBooleanField;
       Ventas_NombreBultos : TWideStringField;
       Ventas_ContenedoresSonPallets : TBooleanField;
       Ventas_Operarios : TBooleanField;
       Ventas_NombreOperarios : TWideStringField;
       Ventas_MostrarDireccionOperarios : TBooleanField;
       Ventas_CampoOperarios : TNombreCampoLibreArray;
       Ventas_FormaEnvio : TBooleanField;
       Ventas_RegularizarPedidosServidos : TBooleanField;
       Ventas_DocumentosSinIVAIncluido : TBooleanField;
       Ventas_FechaEntregaPorLinea: TBooleanField;
       Ventas_FechaCaducidad : TBooleanField;
       Ventas_MostrarLotesPedido : TBooleanField;
       Ventas_LotesObligatorios : TBooleanField;
       Ventas_GestionSubvenciones : TBooleanField;
       Ventas_EntornoPruebasVerifactu : TBooleanField;
       Ventas_TiposIVAModificables : TBooleanField;
       Stock_MultiAlmacen : TBooleanField;
       Stock_AltasFabric : TBooleanField;
       Stock_LotesProductos : TBooleanField;
       Stock_TrazabilidadPorLotes : TBooleanField;
       Stock_CosteEntradaPorLote : TBooleanField;
       Stock_Ubicaciones : TBooleanField;
       Stock_AlmacenDefecto : TWideStringField;
       Stock_AlmacenPrev : TWideStringField;
       Stock_AvisoStock : TBooleanField;
       Stock_ImpSalidasSinStock : TBooleanField;
       Stock_AvisoBajoMinimos : TBooleanField;
       Stock_IncluirPrecioComponentes : TBooleanField;
       Stock_ImpedirPendienteEnExceso : TBooleanField;
       Stock_TiposLineaMovimiento : TBooleanField;
       Stock_Operarios : TBooleanField;  // Operarios en los movimientos de almacén
       Contable_MesInicial : TSmallIntField;
       Contable_CtrosCoste : TBooleanField;
       Contable_NroRegistro : TBooleanField;
       Contable_Retenciones : TBooleanField;
       Contable_BloqueoTrim : TBooleanField;
       Contable_Divisas : TBooleanField;
       Contable_NroRegAstos : TBooleanField;
       Contable_NoUsarExistencias : TBooleanField;
       Contable_DesglosarCtasCobros : TBooleanField;
       Contable_VentasOnlineIntracomunitarias : TBooleanField;
       Contable_SII : TBooleanField;
       Contable_EntornoPruebasSII : TBooleanField;
       Inmovilizado_CamposLibres : TBooleanField;
       Inmovilizado_CampoLibre : TInmovilizado_CampoLibreArray;
       Inmovilizado_CampoLibOblig : TInmovilizado_CampoLibObligArray;
       Cliente_RegAuxiliar : TBooleanField;
       Cliente_NombreRegAuxiliar : TWideStringField;
       Cliente_DireccionAuxiliar : TBooleanField;
       Cliente_CampoAux : TNombreCampoLibreArray;
       Cliente_GruposFac : TBooleanField;
       Cliente_TarCodigo : TBooleanField;
       Cliente_TarCantidadMinima : TBooleanField;
       Cliente_TarConsumo : TBooleanField;
       Cliente_Referencias : TBooleanField;
       Cliente_VenPeriodica : TBooleanField;
       Cliente_CamposLibres : TBooleanField;
       Cliente_CampoLibre : TCliente_CampoLibreArray;
       Cliente_CampoLibOblig : TCliente_CampoLibObligArray;
       Cliente_CanalSerie : TBooleanField;
       Cliente_DtosTarifas : TBooleanField;
       Cliente_Localizacion : TBooleanField;
       Proveedor_CampLibre : TBooleanField;
       Proveedor_CampoLib : TProveedor_CampoLibArray;
       Proveedor_CampoLibOblig : TProveedor_CampoLibObligArray;
       Proveedor_Grupos : TBooleanField;
       Proveedor_RegAuxiliar : TBooleanField;
       Proveedor_NombreRegAuxiliar : TWideStringField;
       Proveedor_CampoAux : TProveedor_CampoAuxArray;
       Articulo_Cajas : TBooleanField;
       Articulo_Pallets : TBooleanField;
       Articulo_Bultos : TBooleanField;
       Articulo_ExisteClase : TArticulo_ExisteClaseArray;
       Articulo_NombreClase : TArticulo_NombreClaseArray;
       Articulo_TarifaClase : TBooleanField;
       Articulo_PuntoVerde : TBooleanField;
       Articulo_ContribucionRAPRepercutida : TBooleanField;
       Articulo_PreciosIVA : TBooleanField;
       Articulo_UnidadesPorPrecio: TBooleanField;
       Articulo_CamposLibres : TBooleanField;
       Articulo_CampoLibre : TArticulo_CampoLibreArray;
       Articulo_CampoLibOblig : TArticulo_CampoLibObligArray;
       Articulo_CampoLib9Agrupacion : TBooleanField;
       Articulo_SoloCodificados : TBooleanField;
       Articulo_MargenSobrePrecioCompra : TBooleanField;
       Articulo_DtosCompraEnMargenes : TBooleanField;
       Articulo_EditarMedidas : TBooleanField;
       Articulo_Envase : TSmallIntField;
       Articulo_TipoEnvase : TSmallIntField;
       Articulo_Contenedor : TSmallIntField;
       Articulo_TipoContenedor : TSmallIntField;
       Articulo_PermitirModificarPeso : TBooleanField;
       Articulo_StockMinMaxPorAlmacen : TBooleanField;
       Articulo_ArticulosRelacionados : TBooleanField;
       Vendedor_ComPorCli : TBooleanField;
       Resultados_ReconstruirPeriodicamente : TBooleanField;
     end;

     TEstructuraFicheroFields = class( TnxeDatasetFields)
     public
       Fichero : TSmallIntField;
       NroRegistro : TSmallIntField;
       Descripcion : TWideStringField;
       FicheroExterno : TWideStringField;
       DecimalImplicito : TBooleanField;
       Formato : TSmallIntField;
       Separador : TWideStringField;
       Script : TWideMemoField;
     end;

     TFicherosFields = class( TnxeDatasetFields)
     public
       CodigoEmpresa : TWideStringField;
       NombreFichero : TWideStringField;
       Localizacion : TSmallIntField;
       Comentario : TWideStringField;
     end;

     TInformeExternoFields = class( TnxeDatasetFields)
     public
       TipoDocumento : TSmallIntField;
       NroRegistro : TSmallIntField;
       Descripcion : TWideStringField;
       TipoFichero : TSmallIntField;
       Fichero : TWideStringField;
       Empresa : TWideStringField;
       Usuario : TWideStringField;
       Seccion : TSmallIntField;
       Impresora : TWideStringField;
       Pagina : TWideStringField;
       Informacion : TWideMemoField;
     end;

     TLineaEstructFicheroFields = class( TnxeDatasetFields)
     public
       Fichero : TSmallIntField;
       NroRegistro : TSmallIntField;
       NroLinea : TSmallIntField;
       Campo : TWideStringField;
       Inicio : TSmallIntField;
       Longitud : TSmallIntField;
       Constante : TWideStringField;
       Automatico : TBooleanField;
       Decimales : TSmallIntField;
       Incluir : TBooleanField;
       Prueba : TWideStringField;
     end;

     TNotificacionFields = class( TnxeDatasetFields)
     public
       Grupo : TSmallIntField;
       Texto : TWideStringField;
     end;

     TPaisFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       Nombre : TWideStringField;
       CodigoISO2 : TWideStringField;
       CodigoISO3 : TWideStringField;
       Intracomunitario : TBooleanField;
     end;

     TPlanificadorFields = class( TnxeDatasetFields)
       ID : TUnsignedAutoIncField;
       IDPadre : TIntegerField;
       IDRecurso : TWideStringField;
       IDEvento : TWideStringField;
       InicioActual : TDateTimeField;
       FinalActual : TDateTimeField;
       Titulo : TWideStringField;
       TipoDeEvento : TIntegerField;
       Inicio : TDateTimeField;
       Final : TDateTimeField;
       ColorEtiqueta : TIntegerField;
       Lugar : TWideStringField;
       Mensaje : TWideStringField;
       Opciones : TIntegerField;
       IndiceRecurrencia : TIntegerField;
       InformacionRecurrencia : TBlobField;
       FechaRecordatorio : TDateTimeField;
       MinutosAntesEmpezarRecordatorio : TIntegerField;
       DatosRecordatorio : TBlobField;
       Estado : TIntegerField;
       TareaCompletada : TIntegerField;
       TareaIndice : TIntegerField;
       TareaEnlaces : TBlobField;
       TareaEstado : TIntegerField;
     end;

     TRecursosPlanificadorFields = class( TnxeDatasetFields)
       Id : TUnsignedAutoIncField;
       Color : TIntegerField;
       IndiceImagen : TIntegerField;
       Nombre : TWideStringField;
       end;

     TCodigoArray = array[ 1..8 ] of TWideStringField;
     TOperacionArray = array[ 1..3 ] of TSmallIntField;
     TOpcionArray = array[ 1..3 ] of TBooleanField;

     TPlantillaGraficoFields = class( TnxeDatasetFields )
     public
       Tipo : TSmallIntField;
       NroOperacion : TIntegerField;
       NroRegistro : TSmallIntField;
       Descripcion : TWideStringField;
       Ejercicio : TSmallIntField;
       Codigo : TCodigoArray;
       Operacion : TOperacionArray;
       Opcion : TOpcionArray;
       Grafico : TWideMemoField;
     end;

     TProvinciaFields = class( TnxeDatasetFields )
     public
       CodigoPais : TWideStringField;
       Codigo : TWideStringField;
       Nombre : TWideStringField;
     end;

     TRegistroFields = class( TnxeDatasetFields )
       Id : TUnsignedAutoIncField;
       IdPadre : TLongWordField;
       Clave : TWideStringField;
       Valor : TWideStringField;
       Blob : TWideMemoField;
       end;

     TRelacionFields = class( TnxeDatasetFields )
     public
       NroRegistro : TIntegerField;
       CodigoEntero : TIntegerField;
       CodigoTexto : TWideStringField;
     end;

     TReport2Fields = class( TnxeDatasetFields)
     public
       NroRegistro : TIntegerField;
       CodigoEntero : TIntegerField;
       CodigoTexto : TWideStringField;
       Texto : TWideStringField;
     end;

     TTipoCambioFields = class( TnxeDatasetFields)
     public
       Fecha : TDateField;
       CodigoDivisa : TWideStringField;
       TipoCambio : TFloatField;
     end;

     TUsuarioFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       Nombre : TWideStringField;
       Password : TIntegerField;
       CodigoEmpresa : TWideStringField;
       NoSuprimir : TBooleanField;
       NoModificarDocumentos : TBooleanField;
       VentanaInicio : TSmallIntField;
       BordesRectos : TBooleanField;
       EstiloPersonalizado : TBooleanField;
       Decoracion : TSmallIntField;
       UsarPieles : TBooleanField;
       NombrePiel : TWideStringField;
       NombrePaleta : TWideStringField;
       SimularTab : TBooleanField;
       GestorVentanasTDI : TBooleanField;
       MaximizarVentanasEdicion : TBooleanField;
       NoCerrarVentanasConEsc : TBooleanField;
       ConsultasIzquierda : TBooleanField;
       TecladoNumerico : TBooleanField;
       AlertasPermanentes : TBooleanField;
       PosicionAlertas : TSmallIntField;
       Planificador : TBooleanField;
       PanelControl : TBooleanField;
       DesactivarNotificaciones : TBooleanField;
       BuzonesCorreo : TBooleanField;
       FuenteAnotaciones : TWideStringField;
       TamanoFuenteAnotaciones : TSmallIntField;
       ModoTactil : TBooleanField;
       TamanoModoTactil : TSmallIntField;
       DisposicionVentanas : TSmallIntField;
       ModoRenderizado : TSmallIntField;
       Compras_OcultarPrecios : TBooleanField;
       Compras_MostrarStock : TBooleanField;
       Compras_AlmacenDefecto : TWideStringField;
       Compras_RestringirAlmacen : TBooleanField;
       Ventas_SerieDefecto : TWideStringField;
       Ventas_RestringirSerie : TBooleanField;
       Ventas_AlmacenDefecto : TWideStringField;
       Ventas_RestringirAlmacen : TBooleanField;
       Ventas_VendedorDefecto : TWideStringField;
       Ventas_RestringirVendedor : TBooleanField;
       Ventas_MostrarStock : TBooleanField;
       Ventas_MostrarRiesgoPedidos : TBooleanField;
       Ventas_MostrarRiesgoAlbaranes : TBooleanField;
       Ventas_MostrarRentabilidad : TBooleanField;
       Ventas_DesactivarTabletaFirma : TBooleanField;
       Tienda_Administrador : TBooleanField;
       Tienda_NombreUsuario : TWideStringField;
       Tienda_Password : TWideStringField;
       GestorCredito : TBooleanField;
       AcGC : TSmallIntField;
       AcGCFicheros : TSmallIntField;
       AcGCAsientos : TSmallIntField;
       AcGCListados : TSmallIntField;
       AcGCProcesos : TSmallIntField;
       AcLI : TSmallIntField;
       AcLIFicheros : TSmallIntField;
       AcPC : TSmallIntField;
       AcPCFicheros : TSmallIntField;
       AcEI : TSmallIntField;
       AcEIFicheros : TSmallIntField;
       AcCO : TSmallIntField;
       AcCOFicheros : TSmallIntField;
       AcCOProveedores : TSmallIntField;
       AcCOTarifas : TSmallIntField;
       AcCOFormasPago : TSmallIntField;
       AcCORelaciones : TSmallIntField;
       AcCOMovimientos : TSmallIntField;              
       AcCOOfertas : TSmallIntField;
       AcCOPedidos : TSmallIntField;
       AcCOAlbaranes : TSmallIntField;
       AcCOProcesos : TSmallIntField;
       AcVE : TSmallIntField;
       AcVEFicheros : TSmallIntField;
       AcVEClientes : TSmallIntField;
       AcVEVendedores : TSmallIntField;
       AcVESeries : TSmallIntField;
       AcVETarifas : TSmallIntField;
       AcVEFormasCobro : TSmallIntField;
       AcVERelaciones : TSmallIntField;
       AcVEProcesos : TSmallIntField;
       AcVETiendaVirtual : TSmallIntField;
       AcAL : TSmallIntField;
       AcALFicheros : TSmallIntField;
       AcALArticulos : TSmallIntField;
       AcALListasMateriales : TSmallIntField;
       AcALAlmacenes : TSmallIntField;
       AcALTiposMovimiento : TSmallIntField;
       AcALFormatos : TSmallIntField;
       AcALProcesos : TSmallIntField;
       AcALCambioPrecios : TSmallIntField;
       AcRE : TSmallIntField;
       AcGP : TSmallIntField;
       AcGPFicheros : TSmallIntField;
       AcGPRelaciones : TSmallIntField;
       AcGPOperarios : TSmallIntField;
       AcGPMaquinas : TSmallIntField;
       AcGPOperaciones : TSmallIntField;
       AcGPTurnos : TSmallIntField;
       AcGPPrevision : TSmallIntField;
       AcGPLanzamiento : TSmallIntField;
       AcGPSeguimiento : TSmallIntField;
       AcGPNotificaciones : TSmallIntField;
       AcGPProcesos : TSmallIntField;
       AcCA : TSmallIntField;
       AcCAFicheros : TSmallIntField;
       AcCACaja : TSmallIntField;
       AcCAListados : TSmallIntField;
       AcCAProcesos : TSmallIntField;
       AcCAArqueo : TSmallIntField;
       AcCAPrecios : TSmallIntField;
       AcCADescuentos : TSmallIntField;
       AcProcesosCriticos : TSmallIntField;
       AcModificacionInformes : TSmallIntField;
       AcEdicionInformes : TSmallIntField;
     end;

     TParametrosRec      = array[ 1..1024 ] of Byte;
     TParametrosLWRec    = array[ 1..256 ] of LongWord;
     TArrayCampo         = array[ 1..11 ] of SmallInt;

     // TParametrosBlobRec no es un registro de fichero, es el TBlobMemoRec de TConfiguracionRec

     // Los parámetos obsoletos precedidos de _ se utilizan en los módulos de adaptación desde versiones
     // anteriores. Cuando se elimine la adaptación se podrá eliminar el parámetro.

      TParametrosGlbRec = packed record

        _DesactivarNotificaciones,
        _Planificador,
        _BuzonesCorreo,
        _SimularTab                : Boolean;
        LocalizacionWebSoporte     : SmallInt;
        RegistrarCambiosFicheros   : Boolean;

        Version                    : String[ 8 ];  // 11000086  ComparableVersion sin Build
        Reservado3                 : array[ 1..24 ] of Byte;

        EditorInformes             : Boolean;
        TiempoEsperaSQL,
        MetodoContadores           : SmallInt;
        Reservado,
        SubrayadoLineas            : Boolean;
        CompresionDatosRemotos     : SmallInt;
        ColorBarraTituloInforme    : TColorRef;

        Reservado4                 : array[ 1..15 ] of Byte;

        PuertoSMTP                 : SmallInt;
        _ConexionSeguraSMTP        : Boolean;   // Obsoletos
        _ConexionSeguraPOP3IMAP    : Boolean;
        SeguridadSMTP,
        SeguridadPOP3IMAP          : SmallInt;

        Reservado5                 : array[ 1..15 ] of Byte;

        PuertoPOP3IMAP             : SmallInt;
        UsuarioCorreo              : String[ 40 ];
        PasswordCorreo             : String[ 20 ];
        _TDI,
        _MaximizarVentanasEdicion  : Boolean;
        ColorTrazoFirma            : TColorRef;  // Cardinal (4 bytes)

        _ModoTactil                : Boolean;
        _TamañoModoTactil          : SmallInt;

        TipoServidorEntrante       : SmallInt;
		    Reservado6                 : array[ 0..3 ] of Byte;

        EmpresaDemostracionActualizada,
        NoPreguntarCopiasSeguridad : Boolean;
        NroCopiasInternas          : Byte;
        _ConsultasIzquierda,
        _TecladoNumerico,
        OcultarVentanaPresentacion : Boolean;

        ServidorSMTP               : String[ 60 ];
        ServidorPOP3IMAP           : String[ 60 ];
        DireccionCorreo            : String[ 80 ];

        BarraNavegacion            : Boolean;

        AccesoFTP                  : Boolean;     // Si es True se accede utilizando el protocolo FTP
        HostFTP                    : String[ 40 ];
        PathServidorDatos          : String[ 128 ];
        UsuarioFTP                 : String[ 40 ];
        PasswordFTP                : String[ 20 ];

        _FuenteAnotaciones         : String[ 30 ];
        _TamañoFuenteAnotaciones   : SmallInt;

        PDFComprimido,
        PDFFondo,
        PDFOptimizadoImpresion     : Boolean;
        PDFNivelCompresion         : SmallInt;

        _AlertasPermanentes        : Boolean;
        _PosicionAlertas           : Byte;

        Reservado7                 : array[ 0..1 ] of Byte;

        MostrarOpcionesMenu,
        _AnotacionesTextoSimple,

        PDFFuentesEmbebidas        : Boolean;

        FirmaCorreo                : String[ 255 ];
        end;

      TParametrosUsrRec = packed record
        case Byte of
          0 : ( Parametros                 : TParametrosRec );
          1 : ( Reservado                  : SmallInt;
                PathFicheroDatosCapturador : String[ 60 ]   );
          end;

      TParametrosBackupRec = packed record
        case Byte of
          0 : ( Parametros          : TParametrosRec );
          1 : ( TodasLasEmpresas,
                EnviarFicheros      : Boolean;
                PathDestino         : String[ 128 ]  );
        end;

      TTipoAccesoCertificadoSistema = ( acCurrentUser, acLocalMachine );

      TParametrosSeguridadRec = packed record
        case Byte of
          0 : ( Parametros          : TParametrosRec );
          1 : ( CertificadoSistema  : Boolean;

                Fichero             : String[ 128 ];
                PalabraPaso         : String[ 30 ];

                // TMessageDigest160 : Hash del certificado del sistema seleccionado por el usuario

                HashCertificado    : TMessageDigest160;
                TipoFirma          : SmallInt;
                NombreAutor        : String[ 40 ];
                AlmacenDocumentos  : String[ 128 ];
                TipoAcceso         : TTipoAccesoCertificadoSistema;
                UsarAutoFirma      : Boolean );
        end;

implementation

end.
