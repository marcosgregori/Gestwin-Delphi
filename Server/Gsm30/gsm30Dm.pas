
{$TYPEINFO ON}   // Rtti

unit Gsm30Dm;

interface

uses  Windows,
      Messages,
      SysUtils,
      Classes,

      nxllComponent,
      nxsdTableMapperDescriptor,
      nxsdRecordMapperDescriptor,
      nxsdDataDictionary,
      DB,
      nxdb,
      LibUtils,
      DataManager,
      MainData,
      EnterpriseData,
      Sqlset,
      ServerDataModule,

      Gsm10Dm,

      dm_rcl,
      dm_rpr,
      dm_alm,
      dm_art,
      dm_fam,
      dm_lma,
      dm_cls,
      dm_ven,
      dm_tma,
      dm_mov,
      dm_sto,
      dm_fdc,
      dm_fdv,
      dm_eqm,
      dm_fde,
      dm_efe,
      dm_rdr,
      dm_rpf,
      dm_pve,
      dm_vpe,
      dm_cec;

type
  TDataModule30 = class(TServerDataModule)
    Dictionary:TnxeDatabaseDictionary;
    SQLSet: TgxSQLSet;
    DetailSourceTable: TnxeTable;
    MasterSourceTable: TnxeTable;
    SourceTable: TnxeTable;
    TargetTable: TnxeTable;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure DictionaryVerify;
    procedure DictionaryAfterUpdate;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure DictionaryBeforeUpdate;
  private

    FRelacionesClienteModule : TRelacionesClienteModule;
    FRelacionesProveedorModule : TRelacionesProveedorModule;
    FAlmacenModule : TAlmacenModule;
    FArticuloModule : TArticuloModule;
    FFamiliaModule : TFamiliaModule;
    FListaMaterialesModule : TListaMaterialesModule;
    FClaseModule : TClaseModule;
    FVendedorModule : TVendedorModule;
    FTipoMovAlmacenModule : TTipoMovAlmacenModule;
    FMovimientoModule : TMovimientoModule;
    FStockAlmacenModule: TStockAlmacenModule;
    FFacturaComprasModule: TFacturaComprasModule;
    FFacturaVentasModule: TFacturaVentasModule;
    FEquipoMovilModule : TEquipoMovilModule;
    FFormaEnvioModule : TFormaEnvioModule;
    FPreventaModule : TPreventaModule;
    FEfectoModule : TEfectoModule;
    FReconstruccionResultadosModule : TReconstruccionResultadosModule;
    FVentasPeriodicasModule : TVentasPeriodicasModule;
    FCierreComercialModule : TCierreComercialModule;

    CurrentTableName : String;
    TableRecordCount,
    CurrentRecNum,
    LastPercent : LongInt;

    function GetRelacionesClienteModule : TRelacionesClienteModule;
    function GetRelacionesProveedorModule : TRelacionesProveedorModule;
    function GetAlmacenModule : TAlmacenModule;
    function GetArticuloModule : TArticuloModule;
    function GetFamiliaModule : TFamiliaModule;
    function GetListaMaterialesModule : TListaMaterialesModule;
    function GetClaseModule : TClaseModule;
    function GetVendedorModule : TVendedorModule;
    function GetTipoMovAlmacenModule : TTipoMovAlmacenModule;
    function GetMovimientoModule : TMovimientoModule;
    function GetStockAlmacenModule : TStockAlmacenModule;
    function GetFacturaVentasModule : TFacturaVentasModule;
    function GetFacturaComprasModule : TFacturaComprasModule;
    function GetEquipoMovilModule : TEquipoMovilModule;
    function GetFormaEnvioModule : TFormaEnvioModule;
    function GetPreventaModule : TPreventaModule;
    function GetEfectoModule : TEfectoModule;
    function GetReconstruccionResultadosModule : TReconstruccionResultadosModule;
    function GetVentasPeriodicasModule : TVentasPeriodicasModule;
    function GetCierreComercialModule : TCierreComercialModule;

    procedure Ajustes110017;
    procedure Ajustes110022;
    procedure Ajustes110034;
    procedure Ajustes110036;
    procedure Ajustes110040;
    procedure Ajustes110117;
    // procedure Ajustes110125;
    procedure Ajustes110161;

    procedure AjustesPrevios110040;
    procedure AjustesPrevios110050;  

  public

    function GetSQL( Title : String ) : String;

    procedure FreeAlmacenModule;
    procedure FreeArticuloModule;
    procedure FreeClaseModule;
    procedure FreeEfectoModule;
    procedure FreeFacturaComprasModule;
    procedure FreeFacturaVentasModule;
    procedure FreeFamiliaModule;
    procedure FreeListaMaterialesModule;
    procedure FreeMovimientoModule;
    procedure FreeReconstruccionResultadosModule;
    procedure FreeRelacionesClienteModule;
    procedure FreeRelacionesProveedorModule;
    procedure FreeEquipoMovilModule;
    procedure FreeFormaEnvioModule;
    procedure FreePreventaModule;
    procedure FreeStockAlmacenModule;
    procedure FreeTipoMovAlmacenModule;
    procedure FreeVendedorModule;
    procedure FreeVentasPeriodicasModule;
    procedure FreeCierreComercialModule;

    procedure FreeAllDataModules;

    function IsStockAlmacenModuleAssigned : Boolean;
    function IsReconstruccionResultadosModuleAssigned : Boolean;

    // read  write ;

    property RelacionesClienteModule : TRelacionesClienteModule read GetRelacionesClienteModule write FRelacionesClienteModule;
    property RelacionesProveedorModule : TRelacionesProveedorModule read GetRelacionesProveedorModule write FRelacionesProveedorModule;
    property AlmacenModule : TAlmacenModule read GetAlmacenModule write FAlmacenModule;
    property ArticuloModule : TArticuloModule read GetArticuloModule write FArticuloModule;
    property FamiliaModule : TFamiliaModule read GetFamiliaModule write FFamiliaModule;
    property ListaMaterialesModule : TListaMaterialesModule read GetListaMaterialesModule write FListaMaterialesModule;
    property ClaseModule : TClaseModule read GetClaseModule write FClaseModule;
    property VendedorModule : TVendedorModule read GetVendedorModule write FVendedorModule;
    property TipoMovAlmacenModule : TTipoMovAlmacenModule read GetTipoMovAlmacenModule write FTipoMovAlmacenModule;
    property MovimientoModule : TMovimientoModule read GetMovimientoModule write FMovimientoModule;
    property StockAlmacenModule : TStockAlmacenModule read GetStockAlmacenModule write FStockAlmacenModule;
    property FacturaVentasModule : TFacturaVentasModule read GetFacturaVentasModule write FFacturaVentasModule;
    property FacturaComprasModule : TFacturaComprasModule read GetFacturaComprasModule write FFacturaComprasModule;
    property EquipoMovilModule : TEquipoMovilModule read GetEquipoMovilModule write FEquipoMovilModule;
    property FormaEnvioModule : TFormaEnvioModule read GetFormaEnvioModule write FFormaEnvioModule;
    property PreventaModule : TPreventaModule read GetPreventaModule write FPreventaModule;
    property EfectoModule : TEfectoModule read GetEfectoModule write FEfectoModule;
    property ReconstruccionResultadosModule : TReconstruccionResultadosModule read GetReconstruccionResultadosModule write FReconstruccionResultadosModule;
    property VentasPeriodicasModule : TVentasPeriodicasModule read GetVentasPeriodicasModule write FVentasPeriodicasModule;
    property CierreComercialModule : TCierreComercialModule read GetCierreComercialModule write FCierreComercialModule;

  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

{$R *.DFM}

uses    Variants,
        Files,
        nxsdDataDictionaryStrings,

        nxdbBase,
        nxllBde,

        AppManager,
        SessionData,

        Gim00Fields,
        Gim10Fields,
        Gim30Fields,

        Gsm00Dm,

        dmi_mov,
        dmi_fac;

resourceString
        RsMsg2 = 'Se ha producido un error al realizar los ajustes adicionales de las tablas';

procedure TDataModule30.ServerDataModuleCreate(Sender: TObject);
begin
     With SessionDataModule do
       SetupDatabaseDictionary( Dictionary, EnterpriseDataModule.Database );
end;

procedure TDataModule30.ServerDataModuleDestroy(Sender: TObject);
begin
     FSessionDataModule.DictionaryList.Remove( Dictionary );
     SessionDataModule.Dm30 := nil;
end;

procedure TDataModule30.FreeAllDataModules;
begin
     FreeAlmacenModule;
     FreeArticuloModule;
     FreeClaseModule;
     FreeEfectoModule;
     FreeFacturaComprasModule;
     FreeFacturaVentasModule;
     FreeFamiliaModule;
     FreeListaMaterialesModule;
     FreeMovimientoModule;
     FreeReconstruccionResultadosModule;
     FreeRelacionesClienteModule;
     FreeRelacionesProveedorModule;
     FreeEquipoMovilModule;
     FreeFormaEnvioModule;
     FreePreventaModule;
     FreeStockAlmacenModule;
     FreeTipoMovAlmacenModule;
     FreeVendedorModule;
     FreeVentasPeriodicasModule;
     FreeCierreComercialModule;
end;

procedure TDataModule30.Ajustes110017;

var  MovimientoFields : TMovimientoFields;
     LineaMovimientoFields : TLineaMovimientoFields;

begin
     {
     With EnterpriseDataModule do
       try

         ExecQuery( 'UPDATE LineaMovimientoAlmacen SET FechaAplicacion=' + QuotedStr( 'Regularización' ) + ' WHERE Tipo=7', [] );

       except
         SessionDataModule.SendNotification( ntWarning, RsMsg2 );
         end;
       }

     try

       //  Actualizando el campo FechaAplicacion de todas las líneas de documentos de pedidos de venta porque antes no existía.

       MasterSourceTable.TableName := 'Movimiento';
       MasterSourceTable.IndexFieldNames := 'Ejercicio;NroOperacion';

       DetailSourceTable.TableName := 'LineaMovimiento';
       DetailSourceTable.IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina;NroLinea';

       MasterSourceTable.Open;
       DetailSourceTable.Open;

       MovimientoFields := TMovimientoFields.Create( MasterSourceTable );
       LineaMovimientoFields := TLineaMovimientoFields.Create( DetailSourceTable );

       StartSequence( MasterSourceTable );

       MasterSourceTable.First;
       While not MasterSourceTable.Eof do
         begin

         If   MovimientoFields.TipoMovimiento.Value in [ tmPedidoCompra, tmPedidoVenta ]
         then begin

              With MovimientoFields do
                DetailSourceTable.SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallInt, MaxSmallInt ] );

              DetailSourceTable.First;
              While not DetailSourceTable.Eof do
                begin
                DetailSourceTable.Edit;
                LineaMovimientoFields.FechaAplicacion.Value := MovimientoFields.FechaAplicacion.Value;
                DetailSourceTable.Post;
                DetailSourceTable.Next;
                end;

              end;

         IncSequence;

         MasterSourceTable.Next;
         end;

       finally
         MasterSourceTable.Close;
         DetailSourceTable.Close
       end;
end;

procedure TDataModule30.Ajustes110022;
begin
      EnterpriseDataModule.ExecSQLCommand( 'UPDATE VentaPeriodica SET Periodicidad=CASE WHEN Periodicidad=2 THEN 3 WHEN Periodicidad=3 THEN 5 ELSE Periodicidad END' );
end;

procedure TDataModule30.Ajustes110040;
begin
     EnterpriseDataModule.ExecSQLCommand( 'UPDATE Movimiento SET SerieFactura=SerieFactura + CASE WHEN SerieFactura='''' THEN '''' ELSE ''-'' END + TOSTRING( NroFactura ), NroFactura=0 WHERE TipoMovimiento=12 AND NroFactura<>0', True, True, HighSQLTimeout );
end;

procedure TDataModule30.Ajustes110034;

var  ArticuloFields : TArticuloFields;

begin
     try

       MasterSourceTable.TableName := 'Articulo';
       MasterSourceTable.IndexFieldNames := 'Codigo';
       MasterSourceTable.Open;

       ArticuloFields := TArticuloFields.Create( MasterSourceTable );

       StartSequence( MasterSourceTable );

       MasterSourceTable.First;
       While not MasterSourceTable.Eof do
         begin

         MasterSourceTable.Edit;
         ArticuloFields.Tienda_NombreImagen.Value := ValidFileName( ArticuloFields.Codigo.Value );
         MasterSourceTable.Post;

         IncSequence;

         MasterSourceTable.Next;
         end;

       finally
         MasterSourceTable.Close;
       end;
end;

procedure TDataModule30.Ajustes110036;

var  FacturaVentasFields : TFacturaVentasFields;
     FacturaFields : TFacturaFields;
     Percent,
     LastPercent : SmallInt;

begin
     try

       SourceTable.TableName := 'FacturaVentas';
       SourceTable.IndexFieldNames := 'Ejercicio;Serie;NroFactura';
       SourceTable.Open;

       TargetTable.TableName := 'Factura';
       TargetTable.IndexFieldNames := 'Tipo;Ejercicio;Propietario;SerieFactura;NroRegistro';
       TargetTable.Open;

       FacturaVentasFields := TFacturaVentasFields.Create( SourceTable );
       FacturaFields := TFacturaFields.Create( TargetTable );

       StartSequence( SourceTable );

       SourceTable.First;
       While not SourceTable.Eof do
         begin

         If   not TargetTable.FindKey( [ tfFacturaVentas, FacturaVentasFields.Ejercicio.Value, '', FacturaVentasFields.Serie.Value, FacturaVentasFields.NroFactura.Value ] )
         then begin
              TargetTable.Append;

              FacturaFields.Tipo.Value := tfFacturaVentas;
              FacturaFields.Ejercicio.Value := FacturaVentasFields.Ejercicio.Value;
              FacturaFields.Propietario.Value := '';
              FacturaFields.SerieFactura.Value := FacturaVentasFields.Serie.Value;
              FacturaFields.NroRegistro.Value := FacturaVentasFields.NroFactura.Value;

              TargetTable.Post;
              end;

         IncSequence;

         SourceTable.Next;
         end;

       finally
         TargetTable.Close;
         SourceTable.Close;
       end;
end;

procedure TDataModule30.Ajustes110117;

var  CambioPreciosFields : TCambioPreciosFields;

begin
     try

       MasterSourceTable.TableName := 'CambioPrecios';
       MasterSourceTable.IndexFieldNames := 'NroRegistro';
       MasterSourceTable.Open;

       CambioPreciosFields := TCambioPreciosFields.Create( MasterSourceTable );

       StartSequence( MasterSourceTable );

       MasterSourceTable.First;
       While not MasterSourceTable.Eof do
         begin

         MasterSourceTable.Edit;

         With CambioPreciosFields do
           begin

           Origen.Value := 0;
           case PrecioReferencia.Value of
             0 : If   ProveedorOrigen.Value<>''
                 then Origen.Value := 1;
             4 : If   TarifaOrigen.Value<>''
                 then Origen.Value := 1
                 else If  ClienteOrigen.Value<>''
                      then Origen.Value := 2;
             end;

           Destino.Value := 0;
           case PrecioFinal.Value of
             0 : If   ProveedorDestino.Value<>''
                 then Destino.Value := 1;
             1 : If   TarifaDestino.Value<>''
                 then Destino.Value := 1
                 else If  ClienteDestino.Value<>''
                      then Destino.Value := 2;
             end;

           end;

         MasterSourceTable.Post;

         IncSequence;

         MasterSourceTable.Next;
         end;

       finally
         MasterSourceTable.Close;
       end;
end;

{
procedure TDataModule30.Ajustes110125;

var  ClaseFields : TClaseFields;
     NroRegistro : LongInt;

begin
     try

       MasterSourceTable.TableName := 'Clase';
       MasterSourceTable.IndexFieldNames := 'NroClase;Codigo';
       MasterSourceTable.Open;

       ClaseFields := TClaseFields.Create( MasterSourceTable );

       StartSequence( MasterSourceTable );

       NroRegistro := 1;

       MasterSourceTable.SetRange( [ tcClaseA ] );
       MasterSourceTable.First;
       While not MasterSourceTable.Eof do
         begin

         MasterSourceTable.Edit;
         ClaseFields.NroOrden.Value := NroRegistro;
         MasterSourceTable.Post;

         IncSequence;

         Inc( NroRegistro );

         MasterSourceTable.Next;
         end;

       finally
         MasterSourceTable.Close;
       end;
end;
}

procedure TDataModule30.Ajustes110161;

var  FacturaVentasFields : TFacturaVentasFields;
     FacturaComprasFields : TFacturaComprasFields;
     Percent,
     LastPercent : SmallInt;
     TiposIVA : TBytes;

begin

     EnterpriseDataModule.ExecSQLCommand( 'UPDATE TiposIVA SET CodigoPais=''011'' WHERE CodigoPais IS NULL OR CodigoPais='''' ', True, True, HighSQLTimeout );

     {

     // Facturas de compra

     try

       SourceTable.TableName := 'FacturaCompras';
       SourceTable.IndexName := csSeqAccessIndexName;;
       SourceTable.Open;

       FacturaComprasFields := TFacturaComprasFields.Create( SourceTable );

       StartSequence( SourceTable );

       SourceTable.First;
       While not SourceTable.Eof do
         begin

         If   FacturaComprasFields.TipoIVA[ 1 ].Value=0  // Si no es así es porque ya ha sido adaptada
         then begin

              SourceTable.Edit;

              var TipoInx := 1;
              For var Index := 1 to NroMaximoTiposTasas do
                If   FacturaComprasFields.BaseImponible[ Index ].Value<>0.0
                then begin
                     FacturaComprasFields.TipoIVA[ TipoInx ].Value := Index;
                     FacturaComprasFields.BaseImponible[ TipoInx ].Value := FacturaComprasFields.BaseImponible[ Index ].Value;
                     FacturaComprasFields.BaseNoSujetaDto[ TipoInx ].Value := FacturaComprasFields.BaseNoSujetaDto[ Index ].Value;
                     If   TipoInx<Index
                     then begin
                          FacturaComprasFields.BaseImponible[ Index ].Value := 0.0;
                          FacturaComprasFields.BaseNoSujetaDto[ Index ].Value := 0.0;
                          end;
                     Inc( TipoInx );
                     end;

              SourceTable.Post;
              end;

         IncSequence;

         SourceTable.Next;
         end;

       finally
         SourceTable.Close;
       end;

     // Facturas de venta

     try

       SourceTable.TableName := 'FacturaVentas';
       SourceTable.IndexName := csSeqAccessIndexName;;
       SourceTable.Open;

       FacturaVentasFields := TFacturaVentasFields.Create( SourceTable );

       StartSequence( SourceTable );

       SourceTable.First;
       While not SourceTable.Eof do
         begin

         If   FacturaVentasFields.TipoIVA[ 1 ].Value=0
         then begin

              SourceTable.Edit;

              var TipoInx := 1;
              For var Index := 1 to NroMaximoTiposTasas do
                If   FacturaVentasFields.BaseImponible[ Index ].Value<>0.0
                then begin
                     FacturaVentasFields.TipoIVA[ TipoInx ].Value := Index;
                     FacturaVentasFields.BaseImponible[ TipoInx ].Value := FacturaVentasFields.BaseImponible[ Index ].Value;
                     FacturaVentasFields.BaseNoSujetaDto[ TipoInx ].Value := FacturaVentasFields.BaseNoSujetaDto[ Index ].Value;
                     If   TipoInx<Index
                     then begin
                          FacturaVentasFields.BaseImponible[ Index ].Value := 0.0;
                          FacturaVentasFields.BaseNoSujetaDto[ Index ].Value := 0.0;
                          end;
                     Inc( TipoInx );
                     end;

              SourceTable.Post;

              end;

         IncSequence;

         SourceTable.Next;
         end;

       finally
         SourceTable.Close;
       end;
     }

end;

procedure TDataModule30.DictionaryAfterUpdate;
begin
     With SessionDataModule.EnterpriseDataModule do
       begin
       CheckVersionAndExecute( 11, 0,  17, Ajustes110017 );
       CheckVersionAndExecute( 11, 0,  22, Ajustes110022 );
       CheckVersionAndExecute( 11, 0,  34, Ajustes110034 );
       CheckVersionAndExecute( 11, 0,  36, Ajustes110036 );
       CheckVersionAndExecute( 11, 0,  40, Ajustes110040 );
       CheckVersionAndExecute( 11, 0, 117, Ajustes110117 );
       // CheckVersionAndExecute( 11, 0, 125, Ajustes110125 );
       CheckVersionAndExecute( 11, 0, 161, Ajustes110161 );
       end;
end;

procedure TDataModule30.AjustesPrevios110050;

var  I : SmallInt;

     CodigoRutaFields : array[ 1..12 ] of TWideStringField;
     EquipoMovilFields : TEquipoMovilFields;
     RutasEquipoMovilFields : TRutasEquipoMovilFields;

begin

     If   not SessionDataModule.EnterpriseDataModule.Database.TableExists( 'RutasEquipoMovil', '' )
     then try

            SourceTable.Close;
            SourceTable.DatabaseDictionary := Dictionary;
            SourceTable.Database := SessionDataModule.EnterpriseDataModule.Database;
            SourceTable.TableName := 'EquipoMovil';
            SourceTable.IndexName := csSeqAccessIndexName;
            SourceTable.Open;

            EquipoMovilFields := TEquipoMovilFields.Create( SourceTable, {StaticData } False, { Incomplete } True );  // El campo CodigoUsuario puede no existir (dependiendo de la version)

            For I := 1 to 12 do
              CodigoRutaFields[ I ] := TWideStringField( SourceTable.FindField( 'CodigoRuta' + IntToStr( I ) ) );

            TargetTable.Close;
            TargetTable.TableType := ttStandard;
            TargetTable.DatabaseDictionary := Dictionary;
            TargetTable.Database := SessionDataModule.EnterpriseDataModule.Database;
            TargetTable.TableName := 'RutasEquipoMovil';
            TargetTable.IndexName := csSeqAccessIndexName;
            TargetTable.Open;

            RutasEquipoMovilFields := TRutasEquipoMovilFields.Create( TargetTable );

            StartSequence( SourceTable );

            SourceTable.First;
            While not SourceTable.Eof do
              begin

              For I := 1 to 12 do
                If   CodigoRutaFields[ I ].Value<>''
                then begin
                     TargetTable.Append;

                     RutasEquipoMovilFields.NroOrden.Value := I;
                     RutasEquipoMovilFields.CodigoEquipoMovil.Value := EquipoMovilFields.Codigo.Value;
                     RutasEquipoMovilFields.CodigoRuta.Value := CodigoRutaFields[ I ].Value;

                     TargetTable.Post;
                     end;

              IncSequence;

              SourceTable.Next;
              end;


          finally
            SourceTable.Close;
            TargetTable.Close;
            TargetTable.TableType := ttRecover;
            end;

end;

procedure TDataModule30.AjustesPrevios110040;
begin

     // Compruebo si existe el campo Serie, porque es habitual que los técnicos supriman el fichero _DBI para actualizar una base de datos

     SourceTable.Close;
     SourceTable.DatabaseDictionary := Dictionary;
     SourceTable.Database := SessionDataModule.EnterpriseDataModule.Database;
     SourceTable.TableName := 'FacturaCompras';
     SourceTable.IndexName := csSeqAccessIndexName;
     try
       SourceTable.Open;
       If   SourceTable.FindField( 'Serie' )=nil
       then Exit;
     finally
       SourceTable.Close;
       end;

     EnterpriseDataModule.ExecSQLCommand( 'ALTER TABLE FacturaCompras ALTER COLUMN Serie CAST AS NVARCHAR( 40 ) IGNORE', True, True, HighSQLTimeout );
     EnterpriseDataModule.ExecSQLCommand( 'UPDATE FacturaCompras SET Serie=Serie + CASE WHEN Serie='''' THEN '''' ELSE ''-'' END + TOSTRING( NroFactura ), NroFactura=0 WHERE NroFactura<>0', True, True, HighSQLTimeout );
end;

procedure TDataModule30.DictionaryBeforeUpdate;
begin
     With SessionDataModule.EnterpriseDataModule do
       begin
       CheckVersionAndExecute( 11, 0,  40, AjustesPrevios110040 );
       CheckVersionAndExecute( 11, 0,  50, AjustesPrevios110050 );
       end;
end;

procedure TDataModule30.DictionaryVerify;
begin
     //..
end;

function TDataModule30.GetSQL( Title : String ) : String;
begin
     Result := SQLSet.GetSQLText( Title );
end;

function TDataModule30.GetRelacionesClienteModule : TRelacionesClienteModule;
begin
     Result := TRelacionesClienteModule( CheckServerDataModule( EnterpriseDataModule, TRelacionesClienteModule, FRelacionesClienteModule ) );
end;

procedure TDataModule30.FreeRelacionesClienteModule;
begin
     If   Assigned( FRelacionesClienteModule )
     then FRelacionesClienteModule.Free;
     FRelacionesClienteModule := nil;
end;

function TDataModule30.GetRelacionesProveedorModule : TRelacionesProveedorModule;
begin
     Result := TRelacionesProveedorModule( CheckServerDataModule( EnterpriseDataModule, TRelacionesProveedorModule, FRelacionesProveedorModule ) );
end;

procedure TDataModule30.FreeRelacionesProveedorModule;
begin
     If   Assigned( FRelacionesProveedorModule )
     then FRelacionesProveedorModule.Free;
     FRelacionesProveedorModule := nil;
end;

function TDataModule30.GetAlmacenModule : TAlmacenModule;
begin
     Result := TAlmacenModule( CheckServerDataModule( EnterpriseDataModule, TAlmacenModule, FAlmacenModule ) );
end;

procedure TDataModule30.FreeAlmacenModule;
begin
     If   Assigned( FAlmacenModule )
     then FAlmacenModule.Free;
     FAlmacenModule := nil;
end;

function TDataModule30.GetArticuloModule : TArticuloModule;
begin
     Result := TArticuloModule( CheckServerDataModule( EnterpriseDataModule, TArticuloModule, FArticuloModule ) );
end;

procedure TDataModule30.FreeArticuloModule;
begin
     If   Assigned( FArticuloModule )
     then FArticuloModule.Free;
     FArticuloModule := nil;
end;

function TDataModule30.GetFamiliaModule : TFamiliaModule;
begin
     Result := TFamiliaModule( CheckServerDataModule( EnterpriseDataModule, TFamiliaModule, FFamiliaModule ) );
end;

procedure TDataModule30.FreeFamiliaModule;
begin
     If   Assigned( FFamiliaModule )
     then FFamiliaModule.Free;
     FFamiliaModule := nil;
end;

function TDataModule30.GetListaMaterialesModule : TListaMaterialesModule;
begin
     Result := TListaMaterialesModule( CheckServerDataModule( EnterpriseDataModule, TListaMaterialesModule, FListaMaterialesModule ) );
end;

procedure TDataModule30.FreeListaMaterialesModule;
begin
     If   Assigned( FListaMaterialesModule )
     then FListaMaterialesModule.Free;
     FListaMaterialesModule := nil;
end;

function TDataModule30.GetClaseModule : TClaseModule;
begin
     Result := TClaseModule( CheckServerDataModule( EnterpriseDataModule, TClaseModule, FClaseModule ) );
end;

procedure TDataModule30.FreeClaseModule;
begin
     If   Assigned( FClaseModule )
     then FClaseModule.Free;
     FClaseModule := nil;
end;

function TDataModule30.GetVendedorModule : TVendedorModule;
begin
     Result := TVendedorModule( CheckServerDataModule( EnterpriseDataModule, TVendedorModule, FVendedorModule ) );
end;

procedure TDataModule30.FreeVendedorModule;
begin
     If   Assigned( FVendedorModule )
     then FVendedorModule.Free;
     FVendedorModule := nil;
end;

function TDataModule30.GetTipoMovAlmacenModule : TTipoMovAlmacenModule;
begin
     Result := TTipoMovAlmacenModule( CheckServerDataModule( EnterpriseDataModule, TTipoMovAlmacenModule, FTipoMovAlmacenModule ) );
end;

procedure TDataModule30.FreeTipoMovAlmacenModule;
begin
     If   Assigned( FTipoMovAlmacenModule )
     then FTipoMovAlmacenModule.Free;
     FTipoMovAlmacenModule := nil;
end;

function TDataModule30.GetMovimientoModule : TMovimientoModule;
begin
     Result := TMovimientoModule( CheckServerDataModule( EnterpriseDataModule, TMovimientoModule, FMovimientoModule ) );
end;

procedure TDataModule30.FreeMovimientoModule;
begin
     If   Assigned( FMovimientoModule )
     then FMovimientoModule.Free;
     FMovimientoModule := nil;
end;

function TDataModule30.GetStockAlmacenModule : TStockAlmacenModule;
begin
     Result := TStockAlmacenModule( CheckServerDataModule( EnterpriseDataModule, TStockAlmacenModule, FStockAlmacenModule ) );
end;

function TDataModule30.IsStockAlmacenModuleAssigned : Boolean;
begin
     Result := Assigned( FStockAlmacenModule );
end;

procedure TDataModule30.FreeStockAlmacenModule;
begin
     If   Assigned( FStockAlmacenModule )
     then FStockAlmacenModule.Free;
     FStockAlmacenModule := nil;
end;

function TDataModule30.GetFacturaComprasModule : TFacturaComprasModule;
begin
     Result := TFacturaComprasModule( CheckServerDataModule( EnterpriseDataModule, TFacturaComprasModule, FFacturaComprasModule ) );
end;

procedure TDataModule30.FreeFacturaComprasModule;
begin
     If   Assigned( FFacturaComprasModule )
     then FFacturaComprasModule.Free;
     FFacturaComprasModule := nil;
end;

function TDataModule30.GetFacturaVentasModule : TFacturaVentasModule;
begin
     Result := TFacturaVentasModule( CheckServerDataModule( EnterpriseDataModule, TFacturaVentasModule, FFacturaVentasModule ) );
end;

procedure TDataModule30.FreeFacturaVentasModule;
begin
     If   Assigned( FFacturaVentasModule )
     then FFacturaVentasModule.Free;
     FFacturaVentasModule := nil;
end;

function TDataModule30.GetEquipoMovilModule : TEquipoMovilModule;
begin
     Result := TEquipoMovilModule( CheckServerDataModule( EnterpriseDataModule, TEquipoMovilModule, FEquipoMovilModule ) );
end;

procedure TDataModule30.FreeEquipoMovilModule;
begin
     If   Assigned( FEquipoMovilModule )
     then FEquipoMovilModule.Free;
     FEquipoMovilModule := nil;
end;

function TDataModule30.GetFormaEnvioModule : TFormaEnvioModule;
begin
     Result := TFormaEnvioModule( CheckServerDataModule( EnterpriseDataModule, TFormaEnvioModule, FFormaEnvioModule ) );
end;

procedure TDataModule30.FreeFormaEnvioModule;
begin
     If   Assigned( FFormaEnvioModule )
     then FFormaEnvioModule.Free;
     FFormaEnvioModule := nil;
end;

function TDataModule30.GetPreventaModule : TPreventaModule;
begin
     Result := TPreventaModule( CheckServerDataModule( EnterpriseDataModule, TPreventaModule, FPreventaModule ) );
end;

procedure TDataModule30.FreePreventaModule;
begin
     If   Assigned( FPreventaModule )
     then FPreventaModule.Free;
     FPreventaModule := nil;
end;

function TDataModule30.GetEfectoModule : TEfectoModule;
begin
     Result := TEfectoModule( CheckServerDataModule( EnterpriseDataModule, TEfectoModule, FEfectoModule ) );
end;

procedure TDataModule30.FreeEfectoModule;
begin
     If   Assigned( FEfectoModule )
     then FEfectoModule.Free;
     FEfectoModule := nil;
end;

function TDataModule30.IsReconstruccionResultadosModuleAssigned : Boolean;
begin
     Result := Assigned( FReconstruccionResultadosModule );
end;

function TDataModule30.GetReconstruccionResultadosModule : TReconstruccionResultadosModule;
begin
     Result := TReconstruccionResultadosModule( CheckServerDataModule( EnterpriseDataModule, TReconstruccionResultadosModule, FReconstruccionResultadosModule ) );
end;

procedure TDataModule30.FreeReconstruccionResultadosModule;
begin
     If   Assigned( FReconstruccionResultadosModule )
     then FReconstruccionResultadosModule.Free;
     FReconstruccionResultadosModule := nil;
end;

function TDataModule30.GetVentasPeriodicasModule : TVentasPeriodicasModule;
begin
     Result := TVentasPeriodicasModule( CheckServerDataModule( EnterpriseDataModule, TVentasPeriodicasModule, FVentasPeriodicasModule ) );
end;

procedure TDataModule30.FreeVentasPeriodicasModule;
begin
     If   Assigned( FVentasPeriodicasModule )
     then FVentasPeriodicasModule.Free;
     FVentasPeriodicasModule := nil;
end;

function TDataModule30.GetCierreComercialModule : TCierreComercialModule;
begin
     Result := TCierreComercialModule( CheckServerDataModule( EnterpriseDataModule, TCierreComercialModule, FCierreComercialModule ) );
end;

procedure TDataModule30.FreeCierreComercialModule;
begin
     If   Assigned( FCierreComercialModule )
     then FCierreComercialModule.Free;
     FCierreComercialModule := nil;
end;

initialization

end.



