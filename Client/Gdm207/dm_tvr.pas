unit dm_tvr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppContainer, StdCtrls, ExtCtrls, DB, AppForms, nxdb, cxEdit,

  dxTokenEdit,

  DataManager,

  Gim00Fields,
  Gim10Fields,
  Gim30Fields,
  Gim207Fields,

  dmi_iva,
  dmi_sdt,

  clJSON;

type

  TTiendaVirtualModule = class(TDataModule)
    DmTarifaVentasTable: TnxeTable;
    DmClaseTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);

  private

    DmClaseFields : TClaseFields;
    DmTarifaVentasFields : TTarifaVentasFields;

    FToken : String;

    procedure DoOnSuprimeReferenciasArticulo( const CodigoArticulo : String );
    procedure DoOnCodigoCategoriaEditRequest( Sender: TcxCustomEdit );
    procedure DoOnCodigoCategoriaQueryRequest( Sender: TcxCustomEdit );
    procedure DoOnCodigoCategoriaValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure DoOnCodigoCategoriaTokenAdd( Sender: TObject; const ATokenText: string; AToken: TdxTokenEditToken; var AAllow: Boolean );

    procedure DoClienteBeforePost(Dataset: TDataset);
    procedure DoTarifaClienteArticuloModified( const Value : String );
    procedure DoTarifaClienteFamiliaModified( const Value : String );
    procedure DoTarifaCodigoTarifaClaseModified( const Value : String );
    procedure DoTarifasVentaArticuloModified( const Value : String );
    function DoGetTarifaClaseSQLCommand( Dataset : TDataset ) : String;
    procedure DoRejillaArticuloBeforePost( Dataset : TDataset );
    procedure DoCategoriaBeforePost(Dataset : TDataset);
    procedure DoClaseABeforeInsert(Dataset: TDataset);
    procedure DoClaseABeforePost(Dataset: TDataset);
    procedure DoClaseBBeforeInsert(Dataset: TDataset);
    procedure DoClaseBBeforePost(Dataset: TDataset);

    procedure ClaseAModificada;
    procedure ClaseBModificada;

  protected

    FLastAccess : TDateTime;
    FNombreCategoriaRaiz : String;
    FImagenesExternas : Boolean;
    FDirectorioImagenes,
    FFormatoImagenes : String;
    FNoPublicarArticulosSinImagen,
    FNoPublicarArticulosSinPrecio,
    FPreciosConDescuentoPrevio,
    FCamposLibresComoAtributos : Boolean;
    FAtributoPorcentajeDescuento,
    FNombreAtributo1 : String;
    FPreciosConIVAIncluido : Boolean;   // Los precios en la tienda son con IVA incluido
    FPublicarArticulosAlmacenSeleccionado : Boolean;
    FPublicarClasesComo : SmallInt;
    FUnidadesSonCajas : Boolean;

    FGrupoNombre : array[ 0..LastCustomerGroupIndex ] of String;
    FGrupoCodigoTarifa : array[ 0..LastCustomerGroupIndex ] of String;
    FGrupoModeloImpositivo : array[ 0..LastCustomerGroupIndex ] of SmallInt;
    FGrupoConIVAIncluido : array[ 0..LastCustomerGroupIndex ] of Boolean;
    FGrupoSerie : array[ 0..LastCustomerGroupIndex ] of String;

    FCodigoFormaCobro,
    FPlantillaCodigoCliente : String;
    FSeleccionAlmacen : SmallInt;
    FCodigoAlmacen : String;
    FPreciosPorCliente : Boolean;

    FAplicarPreciosyDtos : Boolean;
    FEstadoPedidosADescargar,
    FEstadoPedidosEnviados : String;

    FCodigoArticuloField : TField;

  public

    function ObtenGroupId( IndiceGrupo : SmallInt ) : Integer; overload;
    function ObtenGroupId( CodigoTarifa : String; ModeloImpositivo : TModeloIVACliente ) : Integer; overload;

    procedure ArticuloModificado( CodigoArticulo : String; ImagenModificada : Boolean = False );

    property Token : String read FToken;

  end;

var TiendaVirtualModule : TTiendaVirtualModule = nil;

function TiendaVirtual : TTiendaVirtualModule;

procedure InicializaModuloTiendaVirtual;

implementation

uses LibUtils,
     DateUtils,

     EnterpriseDataAccess,
     AppManager,
     RestRpcData,

     Gdm00Dm,
     Gdm00Frm,
     Gdm30Frm,

     f_cnf207,

     dm_pga,
     dm_reg,
     dm_cat,
     dm_cls,
     dm_ptv,
     dm_rea,
     dm_rea207,
     dm_art,
     dm_mov,
     dm_sto,

     a_pde207,
     a_usr,
     a_cls,
     a_cat,
     a_art,
     m_art,
     a_cli,
     a_tla,
     a_tlf,
     a_tct,
     a_tva,

     cx_cat,

     b_2fa,
     b_sdt207;

{$R *.dfm}

resourceString
     RsMsg1 = '%s disponibles';
     RsMsg2 = 'La clase de código %s tiene la misma descripción.';
     RsMsg3 = 'Magento no permite publicar variantes de un atributo con descripciones idénticas.';

function TiendaVirtual : TTiendaVirtualModule;
begin
     CreateDataModule( TTiendaVirtualModule, TiendaVirtualModule );
     Result := TiendaVirtualModule;
end;

{ TTiendaVirtualModule }

function TTiendaVirtualModule.ObtenGroupId( IndiceGrupo : SmallInt ): Integer;

var I : SmallInt;

begin
     Result := RegistroActualizacionTienda.ObtenId( rgaCustomerGroup, IntToStr( IndiceGrupo ) );
end;

function TTiendaVirtualModule.ObtenGroupId( CodigoTarifa     : String;
                                            ModeloImpositivo : TModeloIVACliente ) : Integer;

var  I : SmallInt;

begin
     Result := -1;
     For I := 0 to LastCustomerGroupIndex do
       If   ( ParametrosTiendaVirtual.GrupoCodigoTarifa[ I ]=CodigoTarifa ) and
            ( ParametrosTiendaVirtual.GrupoModeloImpositivo[ I ]=ModeloImpositivo )
       then begin
            Result := RegistroActualizacionTienda.ObtenCustomerGroupId( I );
            Break;
            end;
end;

procedure TTiendaVirtualModule.DataModuleCreate(Sender: TObject);
begin
     DmClaseFields := TClaseFields.Create( DmClaseTable );
     DmTarifaVentasFields := TTarifaVentasFields.Create( DmTarifaVentasTable );

     Articulo.OnSuprimeReferenciasArticulo.Add( DoOnSuprimeReferenciasArticulo );
end;

procedure TTiendaVirtualModule.DataModuleDestroy(Sender: TObject);
begin
     If   Assigned( ArticuloModule )
     then ArticuloModule.OnSuprimeReferenciasArticulo.Remove( DoOnSuprimeReferenciasArticulo );

     TiendaVirtualModule := nil;
end;

procedure TTiendaVirtualModule.DoOnSuprimeReferenciasArticulo( const CodigoArticulo : String );

var  QuotedCodigoArticulo : String;

begin
     try

       QuotedCodigoArticulo := QuotedStr( CodigoArticulo );

       With EnterpriseDataModule do
         begin
         ExecQuery( 'DELETE FROM CategoriasArticulo WHERE CodigoArticulo=' + QuotedCodigoArticulo );
         end;

     except on E : Exception do
       ShowException( E, Self );
       end;
end;

procedure TTiendaVirtualModule.DoOnCodigoCategoriaQueryRequest( Sender : TcxCustomEdit );
begin
     ConsultaCategorias( Sender );
end;

procedure TTiendaVirtualModule.DoOnCodigoCategoriaValidate(Sender: TcxCustomEdit;var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Categoria.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TTiendaVirtualModule.DoOnCodigoCategoriaTokenAdd(       Sender     : TObject;
                                                            const ATokenText : String;
                                                                  AToken     : TdxTokenEditToken;
                                                            var   AAllow     : Boolean );

var  ATokenValue : TcxEditValue;
     ErrorText : TCaption;
     Error : Boolean;

begin
     ATokenValue := ATokenText;
     Categoria.Valida( TcxCustomEdit( Sender ), ATokenValue, ErrorText, Error );
     If   Error
     then ShowHintMsg( RsgMsg311, RsgMsg312 );
     AAllow := not Error;
end;


procedure TTiendaVirtualModule.DoOnCodigoCategoriaEditRequest( Sender: TcxCustomEdit );
begin
     MntCategorias( [ Sender.EditValue ] );
end;

procedure TTiendaVirtualModule.ArticuloModificado( CodigoArticulo   : String;
                                                   ImagenModificada : Boolean = False );

var  ListaElementos : TListaArticulos;

begin

     RegistroActualizacionTienda.Modificado( rgaArticulo, CodigoArticulo, ImagenModificada );

     If   Articulo.EsUnArticuloAgrupado( CodigoArticulo )
     then try
            ListaElementos := TListaArticulos.Create;
            If   Articulo.ObtenGrupoArticulos( CodigoArticulo, ListaElementos )
            then For var CodigoElemento in ListaElementos do
                   RegistroActualizacionTienda.Modificado( rgaArticulo, CodigoElemento );
          finally
            ListaElementos.Free;
            end;

     // Si se modifica el artículo también hay que actualizar las posibles tarifas que lo contienen (puede incluso haber cambiado el Id del artículo)

     If   ParametrosTiendaVirtual.PreciosPorCliente
     then With DmTarifaVentasTable do
            begin
            SetRange( [ CodigoArticulo, rtvClienteArticulo ] );
            First;
            While not Eof do
              begin
              RegistroActualizacionTienda.Modificado( rgaTarifaCliente, DmTarifaVentasFields.CodigoTarifa.Value );
              Next;
              end;
            end;
end;

procedure TTiendaVirtualModule.DoTarifaClienteArticuloModified( const Value : String );
begin
     RegistroActualizacionTienda.Modificado( rgaTarifaCliente, { CodigoCliente } Value );
end;

procedure TTiendaVirtualModule.DoTarifaClienteFamiliaModified( const Value : String );
begin
     RegistroActualizacionTienda.Modificado( rgaTarifaFamilia, { CodigoCliente } Value );
end;

function TTiendaVirtualModule.DoGetTarifaClaseSQLCommand( Dataset : TDataset ) : String;

var  SQLTarifaClaseText : String;

begin

     With MntTctForm, TarifaClaseQuery do
       begin

       case NroClaseActiva of
         tcClaseA : SQLTarifaClaseText := 'LEFT JOIN TarifaClase ON ( Seccion=3 AND CodigoPropietario=' + QuotedStr( DataCodigoTarifa.Value ) + ' AND TarifaClase.CodigoArticulo=' + QuotedStr( DataCodigoArticulo.Value ) + 'AND TarifaClase.ClaseA=ClasesArticulo.CodigoClase AND TarifaClase.ClaseB=' + rsEmptyQuotes + ' AND TarifaClase.ClaseC=' + rsEmptyQuotes + ' ) ';
         tcClaseB : SQLTarifaClaseText := 'LEFT JOIN TarifaClase ON ( Seccion=3 AND CodigoPropietario=' + QuotedStr( DataCodigoTarifa.Value ) + ' AND TarifaClase.CodigoArticulo=' + QuotedStr( DataCodigoArticulo.Value ) + 'AND TarifaClase.ClaseA=' + QuotedStr( DataCodigoClaseA.Value ) + ' AND TarifaClase.ClaseB=ClasesArticulo.CodigoClase AND TarifaClase.ClaseC=' + rsEmptyQuotes + ' ) ';
         tcClaseC : SQLTarifaClaseText := 'LEFT JOIN TarifaClase ON ( Seccion=3 AND CodigoPropietario=' + QuotedStr( DataCodigoTarifa.Value ) + ' AND TarifaClase.CodigoArticulo=' + QuotedStr( DataCodigoArticulo.Value ) + 'AND TarifaClase.ClaseA=' + QuotedStr( DataCodigoClaseA.Value ) + ' AND TarifaClase.ClaseB=' + QuotedStr( DataCodigoClaseB.Value ) + ' AND TarifaClase.ClaseC=ClasesArticulo.CodigoClase ';
         end;

       Result := 'SELECT Clase.Codigo, Clase.NroClase, Clase.Descripcion, TarifaClase.Precio, TarifaClase.Descuento ' +
                 'FROM ClasesArticulo ' +
                 'LEFT JOIN Clase ON ( ClasesArticulo.CodigoClase=Clase.Codigo ) ' +
                 SQLTarifaClaseText +
                 'WHERE ClasesArticulo.CodigoArticulo=' + QuotedStr( DataCodigoArticulo.Value ) + ' AND ClasesArticulo.NroClase= ' + IntToStr( NroClaseActiva ) +
                 'ORDER BY Clase.Codigo';
       end;

end;

procedure TTiendaVirtualModule.DoTarifaCodigoTarifaClaseModified( const Value : String );
begin
     ArticuloModificado( Value );
end;

procedure TTiendaVirtualModule.DoTarifasVentaArticuloModified( const Value : String );
begin
     ArticuloModificado( Value );
end;


procedure TTiendaVirtualModule.DoRejillaArticuloBeforePost( Dataset : TDataset );
begin
     If   Assigned( FCodigoArticuloField )
     then RegistroActualizacionTienda.Modificado( rgaArticulo, FCodigoArticuloField.Value, False );
end;

procedure TTiendaVirtualModule.DoClaseABeforeInsert(Dataset: TDataset);
begin
     ClaseAModificada;
end;

procedure TTiendaVirtualModule.DoClaseABeforePost(Dataset: TDataset);
begin

     // Magento identifica las variantes de un atributo por su descripción, no su código, por lo
     // que no pueden haber dos clases con la misma descripción.

     var Descripcion := MntClsForm[ tcClaseA ].ClaseFields.Descripcion.Value;

     var Existe := DmClaseTable.FindKey( [ tcClaseA, Descripcion ] );
     If   Existe and ( DmClaseFields.Codigo.Value=MntClsForm[ tcClaseA ].ClaseFields.Codigo.Value )
     then begin
          DmClaseTable.Next;
          Existe := not DmClaseTable.Eof and ( DmClaseFields.Descripcion.Value=Descripcion )
          end;

     If   Existe
     then begin
          ShowHintMsg( Format( RsMsg2, [ DmClaseFields.Codigo.Value ] ), RsMsg3 );
          Abort;
          end;

     ClaseAModificada;
end;

procedure TTiendaVirtualModule.ClaseAModificada;
begin
     RegistroActualizacionTienda.Modificado( rgaClase,
                                            MntClsForm[ tcClaseA ].ClaseFields.Codigo.Value + '-' +
                                            IntToStr( MntClsForm[ tcClaseA ].ClaseFields.NroClase.Value ) );
end;

procedure TTiendaVirtualModule.DoClaseBBeforeInsert(Dataset: TDataset);
begin
     ClaseBModificada;
end;

procedure TTiendaVirtualModule.DoClaseBBeforePost(Dataset: TDataset);
begin
     var Descripcion := MntClsForm[ tcClaseB ].ClaseFields.Descripcion.Value;

     var Existe := DmClaseTable.FindKey( [ tcClaseB, Descripcion ] );

     If   Existe and ( DmClaseFields.Codigo.Value=MntClsForm[ tcClaseB ].ClaseFields.Codigo.Value )
     then begin
          DmClaseTable.Next;
          Existe := not DmClaseTable.Eof and ( DmClaseFields.Descripcion.Value=Descripcion )
          end;

     If   Existe
     then begin
          ShowHintMsg( Format( RsMsg2, [ DmClaseFields.Codigo.Value ] ), RsMsg3 );
          Abort;
          end;

     ClaseBModificada;
end;

procedure TTiendaVirtualModule.ClaseBModificada;
begin
     RegistroActualizacionTienda.Modificado( rgaClase,
                                            MntClsForm[ tcClaseB ].ClaseFields.Codigo.Value + '-' +
                                            IntToStr( MntClsForm[ tcClaseB ].ClaseFields.NroClase.Value ) );
end;

procedure TTiendaVirtualModule.DoClienteBeforePost( Dataset : TDataset );
begin
     RegistroActualizacionTienda.Modificado( rgaCliente, MntCliForm.ClienteFields.Codigo.Value );
end;

procedure TTiendaVirtualModule.DoCategoriaBeforePost( Dataset : TDataset );
begin
     RegistroActualizacionTienda.Modificado( rgaCategoria, MntCatForm.CategoriaFields.Codigo.Value );
end;

procedure SetupMantenimientoClaseA;
begin
     If   Assigned( TiendaVirtualModule ) and
          Assigned( MntClsForm[ tcClaseA ] ) and
          ( MntClsFormNroClase=tcClaseA )
     then With MntClsForm[ tcClaseA ] do
            begin
            OnClaseBeforeInsert.Add( TiendaVirtualModule.DoClaseABeforeInsert );
            OnClaseBeforePost.Add( TiendaVirtualModule.DoClaseABeforePost );
            end;
end;

procedure SetupMantenimientoClaseB;
begin
     If   Assigned( TiendaVirtualModule ) and
          Assigned( MntClsForm[ tcClaseB ] ) and
          ( MntClsFormNroClase=tcClaseB )
     then With MntClsForm[ tcClaseB ] do
            begin
            OnClaseBeforeInsert.Add( TiendaVirtualModule.DoClaseBBeforeInsert );
            OnClaseBeforePost.Add( TiendaVirtualModule.DoClaseBBeforePost );
            end;
end;

procedure SetupRejillaArticulos;
begin
     If   Assigned( TiendaVirtualModule ) and
          Assigned( EdcArtForm )
     then With TiendaVirtualModule do
            begin
            FCodigoArticuloField := EdcArtForm.EditableGridFrame.Query.FieldByName( 'Codigo' );
            EdcArtForm.EditableGridFrame.Query.BeforePost := DoRejillaArticuloBeforePost;
            end;
end;

procedure SetupMantenimientoClientes;
begin
     If   Assigned( TiendaVirtualModule ) and
          Assigned( MntCliForm )
     then With TiendaVirtualModule do
            MntCliForm.OnClienteBeforePost.Add( DoClienteBeforePost );
end;

procedure SetupMantenimientoCategorias;
begin
     If   Assigned( TiendaVirtualModule ) and
          Assigned( MntCatForm )
     then MntCatForm.OnCategoriaBeforePost.Add( TiendaVirtualModule.DoCategoriaBeforePost );
end;

procedure SetupMntTarifasClienteArticulo;
begin
     If   Assigned( TiendaVirtualModule ) and
          Assigned( MntTlaForm )
     then MntTlaForm.OnTarifaClienteArticuloModified.Add( TiendaVirtualModule.DoTarifaClienteArticuloModified );
end;

procedure SetupMntTarifasClienteFamilia;
begin
     If   Assigned( TiendaVirtualModule ) and
          Assigned( MntTlfForm )
     then MntTlfForm.OnTarifaClienteFamiliaModified.Add( TiendaVirtualModule.DoTarifaClienteFamiliaModified );
end;

procedure SetupMntTarifasCodigoTarifaClase;
begin
     If   Assigned( TiendaVirtualModule ) and
          Assigned( MntTctForm )
     then begin
          MntTctForm.OnGetSQLCommand.Add( TiendaVirtualModule.DoGetTarifaClaseSQLCommand );
          MntTctForm.OnTarifaCodigoTarifaClaseModified.Add( TiendaVirtualModule.DoTarifaCodigoTarifaClaseModified );
          end;
end;

procedure SetupMntTarifasVentaArticulo;
begin
     If   Assigned( TiendaVirtualModule ) and
          Assigned( MntTvaForm )
     then MntTvaForm.OnTarifasVentaArticuloModified.Add( TiendaVirtualModule.DoTarifasVentaArticuloModified );
end;


procedure InicializaModuloTiendaVirtual;
begin
     TiendaVirtual;
end;

initialization

   AddProcedure( imOnEnterpriseAccess, 0, InicializaModuloTiendaVirtual );

   AddProcedure( imOnCreateComponent, idMntClsForm, SetupMantenimientoClaseA );
   AddProcedure( imOnCreateComponent, idMntClsForm, SetupMantenimientoClaseB );
   AddProcedure( imOnCreateComponent, idEdcArtForm, SetupRejillaArticulos );
   AddProcedure( imOnCreateComponent, idMntCatForm, SetupMantenimientoCategorias );
   AddProcedure( imOnCreateComponent, idMntCliForm, SetupMantenimientoClientes );
   AddProcedure( imOnCreateComponent, idMntTlfForm, SetupMntTarifasClienteFamilia );
   AddProcedure( imOnCreateComponent, idMntTlaForm, SetupMntTarifasClienteArticulo);
   AddProcedure( imOnCreateComponent, idMntTctForm, SetupMntTarifasCodigoTarifaClase );
   AddProcedure( imOnCreateComponent, idMntTvaForm, SetupMntTarifasVentaArticulo );

end.


