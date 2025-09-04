
unit dm_sst119;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,

  Generics.Collections,

  LibUtils,
  AppForms,
  AppContainer,

  DB,
  nxdb,

  DataManager,
  cxEdit,
  cxEditRepositoryItems,

  clJSON,
  clURIUtils,
  clEncoder,
  clUtils,

  Gim00Fields,
  Gim10Fields,
  Gim30Fields,

  Gim119Fields,

  dmi_sto,

  dm_art,
  dm_rea,
  dm_sto;


type

  TListaAlmacenesArray = array[ 1..3 ] of Boolean;

  TSuministroStocksModule = class(TDataModule)
    DmSocioAUNATable: TnxeTable;
    DmAlmacenAUNATable: TnxeTable;
    dmStockTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure RestRpcError(Sender: TObject; ErrorCode: Integer; Fatal, Remote: Boolean);

  private

    FHost,
    FAPIKey,
    FIdSocio : String;
    FIdAlmacen : array[ 1..3 ] of String;
    FCodigoAlmacen : array[ 1..3 ] of String;

    FErrorCode : Integer;
    FErrorMessage : String;

    FFunctionURL,
    FToken : String;
    FParameters : TclJSONObject;

    DecimalFormatSettings : TFormatSettings;

    DmStockFields : TStockFields;
    DmSocioAUNAFields : TSocioAUNAFields;
    DmAlmacenAUNAFields : TAlmacenAUNAFields;

    DsArticuloFields : TArticuloFields;

    RegistroActualizacionFields : TRegistroActualizacionFields;

    function ObtenMensajeError( HTTPResult : Integer ) : String;
    function RetornosAHtml(Value: String): String;
    function HtmlATexto(Value: String): String;
    function DescripcionSocio( IdSocio: String; NotificaSiNoExiste: Boolean = True ) : String;
    function DescripcionAlmacen( IdSocio, IdAlmacen : String; NotificaSiNoExiste : Boolean = True ) : String;
    function GetCodigoAlmacen(Index : SmallInt ): String;
    function GetIdAlmacen(Index: SmallInt): String;
    procedure SetCodigoAlmacen(Index : SmallInt; const Value: String);
    procedure SetIdAlmacen(Index: SmallInt; const Value: String);

   protected

     procedure DoOnPublicacionStock( Sender : TObject );

     class procedure PublicacionStock( Sender : TObject );

   public

    procedure CompruebaFicherosGlobales( ForzarActualizacion : Boolean = False );
    function PublicaStock( ListaAlmacenes : TListaAlmacenesArray ) : Boolean;
    function ObtenEmpresas : Boolean;
    function ObtenAlmacenes : Boolean;
    function ConsultaStock( IdAUNA : String; Data : TgxMemData ) : Boolean;

    property Host : String read FHost write FHost;
    property APIKey : String read FAPIKey write FAPIKey;
    property IdSocio : String read FIdSocio write FIdSocio;
    property IdAlmacen[ Index : SmallInt ] : String read GetIdAlmacen write SetIdAlmacen;
    property CodigoAlmacen[ Index : SmallInt ] : String read GetCodigoAlmacen write SetCodigoAlmacen;
  end;

function  SuministroStocks : TSuministroStocksModule;
procedure ActualizaParametrosSuministroStocks;

const rgPubicacionStocksAUNA = 101;  // CUIDADO  : existen tipos de registro de otros módulos. Por ejemplo, dm_rea207 utiliza el rango 0..8.

      ncrParametrosSuministroStocks = 'SuministroStocks119';

      ncrAPIKey = 'APIKey';
      ncrIdSocio = 'IdSocio';
      ncrIdAlmacen= 'IdAlmacen';
      ncrCodigoAlmacen= 'CodigoAlmacen';

implementation

uses Variants,

     StrUtils,
     DateUtils,

     SBTypes,
     SBEncoding,
     SBStreams,
     SBXMLUtils,

     EnterpriseDataAccess,
     AppManager,
     NexusRpcData,
     RestRpcData,

     Gdm00Dm,

     Gdm00Frm,
     Gdm30Frm,

     a_mco,
     b_rea119,
     b_pst119,

     dmi_mov,

     dm_iex,
     dm_alm,
     dm_reg,
     dm_cli,
     dm_mov,

     a_pde119,

     f_prg;

{$R *.DFM}

resourceString
      RsMsg1  = '';

const
      HTTP_RESULT_OK    = 200;
      HTTP_RESULT_VOID  = 204;
      HTTP_RESULT_IC    = 401;
      HTTP_RESULT_ERROR = 500;

var  SuministroStocksModule : TSuministroStocksModule = nil;

procedure ActualizaParametrosSuministroStocks;
begin
     If   Assigned( SuministroStocksModule )
     then With SuministroStocksModule do
            begin
            Registro.ClavePadre := CodigoEmpresaActual + '.' + ncrParametrosSuministroStocks;
            APIKey := Registro.ObtenValorString( ncrAPIKey );
            IdSocio := Registro.ObtenValorString( ncrIdSocio );
            For var I := 1 to 3 do
              begin
              FIdAlmacen[ I ] := Registro.ObtenValorString( ncrIdAlmacen + IntToStr( I ) );
              FCodigoAlmacen[ I ] := Registro.ObtenValorString( ncrCodigoAlmacen + IntToStr( I ) );
              end;
            end;
end;

{ --- }

function SuministroStocks : TSuministroStocksModule;
begin
     CreateDataModule( TSuministroStocksModule, SuministroStocksModule );
     Result := SuministroStocksModule;
end;

class procedure TSuministroStocksModule.PublicacionStock( Sender : TObject );
begin
     PublicacionStocksAUNA;
end;

procedure TSuministroStocksModule.DataModuleCreate(Sender: TObject);
begin

     DmStockFields := TStockFields.Create( DmStockTable );
     DmSocioAUNAFields := TSocioAUNAFields.Create( DmSocioAUNATable );
     DmAlmacenAUNAFields := TAlmacenAUNAFields.Create( DmAlmacenAUNATable );

     DsArticuloFields := TArticuloFields.Create( Self );


     FParameters := TclJSONObject.Create;

     DecimalFormatSettings := TFormatSettings.Create;
     DecimalFormatSettings.DecimalSeparator := '.';

     ActualizaParametrosSuministroStocks;

     Host := 'https://api.aunabase.com';
     If   APIKey=''
     then APIKey := 'd2fc689b-9c0e-11e9-b6f8-005056b03ae4';
     If   IdSocio=''
     then IdSocio := '8400';

     RestRpc.Authorization := APIKey;
     // RestRpc.Http.ContentType := JSONContentType;

end;

procedure TSuministroStocksModule.DataModuleDestroy(Sender: TObject);
begin
     FParameters.Free;
     SuministroStocksModule := nil;
end;

{ --------- }

procedure TSuministroStocksModule.RestRpcError(Sender: TObject; ErrorCode: Integer; Fatal, Remote: Boolean);
begin
     FErrorCode := ErrorCode;
     FErrorMessage := '';  // TODO:
end;

function TSuministroStocksModule.RetornosAHtml( Value : String ) : String;

var  Inx : SmallInt;

begin
     try
       Inx := 1;
       While Inx<Length( Value ) do
          begin
          If   Value[ Inx ] = #$D
          then begin
               Delete( Value, Inx, 1 );
               If   Inx=1  // Quito el retorno de carro del principio
               then Continue
               else begin
                    Insert( '<BR>', Value, Inx );
                    Inc( Inx, 4 );
                    end;
               end;
          Inc( Inx );
          end;
     except
       end;
     Result := StringReplace( Value, 'R1>', 'B>', [ rfReplaceAll, rfIgnoreCase ] ); // Convierto el tag <R1></R1> en un fragmento en negrita
end;

procedure TSuministroStocksModule.SetCodigoAlmacen( Index : SmallInt; const Value: String);
begin
     If   Index in  [ 1..3 ]
     then FCodigoAlmacen[ Index ] := Value;
end;

procedure TSuministroStocksModule.SetIdAlmacen( Index: SmallInt; const Value: String);
begin
     If   Index in  [ 1..3 ]
     then FIdAlmacen[ Index ] := Value;
end;

function TSuministroStocksModule.HtmlATexto( Value : String ) : String;

var  Inx : SmallInt;

begin
     try
       If   Value[ 1 ] = #$D
       then Delete( Value, 1, 1 );
       Inx := 1;
       While Inx<Length( Value ) do
          begin
          If   Value[ Inx ] = '<'
          then begin
               While ( Inx<Length( Value ) ) and ( Value[ Inx ] <> '>' ) do
                 Delete( Value, Inx, 1 );
               Delete( Value, Inx, 1 );
               Continue;
               end;
          Inc( Inx );
          end;
     except
       end;
     Result := Value;
end;

function TSuministroStocksModule.ObtenMensajeError( HTTPResult : Integer ) : String;
begin
     case HTTPResult of
       204 : Result := 'Respuesta vacía / Sin resultados';
       400 : Result := 'Petición incorrecta, parámetros incorrectos.';
       401 : Result := 'Credenciales incorrectas';
       404 : Result := 'Endpoint inexistente';
       500 : Result := 'Error interno del servidor';
       else  Result := 'Error no definido';
       end;
end;

function TSuministroStocksModule.PublicaStock( ListaAlmacenes : TListaAlmacenesArray ) : Boolean;

var StockRequest,
    StockResponse : TclJSONArray;
    StockObject : TclJSONObject;
    StockClassId : String;
    TotalCount : Integer;
    ResultOk : Boolean;
    IndiceAlmacen : SmallInt;

    ExistenciasArticulo : IExistenciasArticulo;

    TextoRespuesta : String;
    // RegistroActualizacionFields : TRegistroActualizacionFields;

    Precio,
    Descuento : Decimal;

    CodigoActual,
    TextoTipoActualizacion : String;
    SaveDecimalSeparator : Char;

begin

     Result := False;

     try

       SaveDecimalSeparator := FormatSettings.DecimalSeparator;
       FormatSettings.DecimalSeparator := '.';

       try

         For IndiceAlmacen := 1 to 3 do
           If   ListaAlmacenes[ IndiceAlmacen ]
           then begin
                ShowNotification( ntHeader, CodigoAlmacen[ IndiceAlmacen ] + ', ' +  Almacen.Descripcion( CodigoAlmacen[ IndiceAlmacen ] ) );
                CodigoActual := '';
                // Ejercicio;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;LoteFabricacion;Ubicacion;CodigoAlmacen
                With DmStockTable do
                  begin
                  SetRange( [ ApplicationContainer.Ejercicio ] );
                  First;
                  While not Eof do
                    begin

                    // No utilizan clases

                    If   CodigoActual<>DmStockFields.CodigoArticulo.Value { + DmStockFields.CodigoClaseA.Value + DmStockFields.CodigoClaseB.Value + DmStockFields.CodigoClaseC.Value }
                    then begin

                         CodigoActual := DmStockFields.CodigoArticulo.Value { + DmStockFields.CodigoClaseA.Value + DmStockFields.CodigoClaseB.Value + DmStockFields.CodigoClaseC.Value };

                         // Articulos que deben subirse

                         If   Articulo.Obten( DmStockFields.CodigoArticulo.Value, DsArticuloFields ) and
                              DsArticuloFields.CampoLibre9.Value and ( DsArticuloFields.CampoLibre15.Value<>'' )
                         then begin

                              ShowNotification( ntInformation, DsArticuloFields.Codigo.Value + ', ' + DsArticuloFields.Descripcion.Value );

                              ExistenciasArticulo := StockAlmacen.ObtenStock( DsArticuloFields.Codigo.Value, True, '', '', '', True, '', { TodosLosAlmacenes } False, CodigoAlmacen[ IndiceAlmacen ], True, '', True, ApplicationContainer.Ejercicio, 0, 12 );

                              Movimiento.ObtenUltimoPrecioComprayDescuento( DsArticuloFields.Codigo.Value,
                                                                            Now,
                                                                            Precio,
                                                                            Descuento );

                              StockRequest := TclJSONArray.Create;

                              try

                                If   ExistenciasArticulo.SumaExistencias.Saldo<=0.0
                                then TextoTipoActualizacion := 'B'
                                else TextoTipoActualizacion := '';

                                StockObject := TclJSONObject.Create;

                                StockObject.AddString( 'idalma', IdAlmacen[ IndiceAlmacen ] );
                                StockObject.AddString( 'idarti', DsArticuloFields.CampoLibre15.Value );
                                StockObject.AddString( 'tipcod', 'A' );
                                StockObject.AddString( 'dispon', StrFormat( ExistenciasArticulo.SumaExistencias.Saldo, 2 ) );
                                StockObject.AddString( 'pdtent', StrFormat( ExistenciasArticulo.SumaExistencias.PendienteServir, 2 ) );
                                StockObject.AddString( 'pdtrec', StrFormat( ExistenciasArticulo.SumaExistencias.PendienteRecibir, 2 ) );
                                StockObject.AddString( 'premed', StrFormat( ExistenciasArticulo.CosteMedio, 2 ) );
                                StockObject.AddString( 'ultpco', StrFormat( Precio, 2 ) );
                                StockObject.AddString( 'ultdtc', StrFormat( Descuento, 2 ) );
                                StockObject.AddString( 'univen', StrFormat( DsArticuloFields.UnidadesPrecioCompra.Value, 0 ) );
                                StockObject.AddString( 'estado', '' );
                                StockObject.AddString( 'tipact', TextoTipoActualizacion );

                                StockRequest.Add( StockObject );

                                Result := RestRpc.Post( Host + '/v2/vstock', StockRequest );
                                Result := Result or ( RestRpc.Http.StatusCode=201 );

                                TextoRespuesta := '';

                                If   Result
                                then begin
                                     StockResponse := RestRpc.ResponseJSON as TclJSONArray;
                                     If   StockResponse.Count>0
                                     then begin

                                          // De momento no necesito para nada la respuesta

                                          end;

                                     // Tampoco es que resulte útil por ahora registrar las subidas, pero bueno

                                     RegistroActualizacionFields := RegistroActualizacion.Edita( rgPubicacionStocksAUNA, DsArticuloFields.Codigo.Value );
                                     RegistroActualizacionFields.FechaActualizacion.Value := Now;
                                     RegistroActualizacionFields.Codigo.Value := DsArticuloFields.Codigo.Value;
                                     RegistroActualizacionFields.DatasetPost;

                                     end
                                else begin
                                     TextoRespuesta := ObtenMensajeError( RestRpc.Http.StatusCode );
                                     ShowNotification( TNotificationType.ntError,
                                                       'Error. Articulo : ' + DsArticuloFields.Codigo.Value + ', ' + DsArticuloFields.Descripcion.Value,
                                                       RetornosAHtml( TextoRespuesta ) );
                                     // Abort;
                                     end;

                              finally
                                FreeAndNil( StockRequest );
                                end;

                              end;
                         end;

                    Next;
                    end;

                  end;
                end;
              except on E : Exception do
                begin
                FErrorMessage := E.Message;
                ShowNotification( TNotificationType.ntError, 'Se ha producido un error.', FErrorMessage );
                end;
              end;

     finally
       FormatSettings.DecimalSeparator := SaveDecimalSeparator;
       end;

end;

function TSuministroStocksModule.DescripcionSocio( IdSocio            : String;
                                                   NotificaSiNoExiste : Boolean = True ) : String;
begin
     GetRelationDescription( DmSocioAUNATable, [ IdSocio ], Result, NotificaSiNoExiste );
end;

function TSuministroStocksModule.DescripcionAlmacen( IdSocio,
                                                     IdAlmacen          : String;
                                                     NotificaSiNoExiste : Boolean = True ) : String;
begin
     GetRelationDescription( DmAlmacenAUNATable, [ IdSocio, IdAlmacen ], Result, NotificaSiNoExiste );
end;

function TSuministroStocksModule.ObtenEmpresas : Boolean;

var EmpresasResponse : TclJSONArray;
    EmpresaObject : TclJSONObject;
    ResultOk : Boolean;
    TextoRespuesta : String;

begin

     Result := False;

     try

       EmpresasResponse := nil;

       Result := RestRpc.Get( Host + '/v2/empresas' );

       TextoRespuesta := '';

       If   Result
       then begin
            EmpresasResponse := RestRpc.ResponseJSON as TclJSONArray;
            If   EmpresasResponse.Count>0
            then begin
                 DmSocioAUNATable.DeleteRecords;
                 For var I := 0 to EmpresasResponse.Count- 1 do
                   begin
                   EmpresaObject := EmpresasResponse.Items[ I ] as TclJSONObject;

                   DmSocioAUNATable.Append;

                   DmSocioAUNAFields.IdSocio.Value  := EmpresaObject.ValueByName( 'idsoci' );
                   DmSocioAUNAFields.Nombre.Value  := EmpresaObject.ValueByName( 'nombre' );
                   DmSocioAUNAFields.CIF.Value  := EmpresaObject.ValueByName( 'numfis' );

                   DmSocioAUNATable.Post;

                   end;
                 end;

            Result := True;
            end
       else begin
            TextoRespuesta := ObtenMensajeError( RestRpc.Http.StatusCode );
            // ShowNotification( TNotificationType.ntError, 'Error', RetornosAHtml( TextoRespuesta ) );
            end;

     finally
       FreeAndNil( EmpresasResponse );
       end;

end;

function TSuministroStocksModule.ObtenAlmacenes : Boolean;

var  AlmacenesResponse : TclJSONArray;
     AlmacenObject : TclJSONObject;
     ResultOk : Boolean;
     TextoRespuesta : String;

begin

     Result := False;

     try

       AlmacenesResponse := nil;

       Result := RestRpc.Get( Host + '/v2/almacenes' );

       TextoRespuesta := '';

       If   Result
       then begin
            AlmacenesResponse := RestRpc.ResponseJSON as TclJSONArray;
            If   AlmacenesResponse.Count>0
            then begin
                 DmAlmacenAUNATable.DeleteRecords;
                 For var I := 0 to AlmacenesResponse.Count - 1 do
                   begin
                   AlmacenObject := AlmacenesResponse.Items[ I ] as TclJSONObject;

                   DmAlmacenAUNATable.Append;

                   DmAlmacenAUNAFields.IdSocio.Value  := AlmacenObject.ValueByName( 'idsoci' );
                   DmAlmacenAUNAFields.IdAlmacen.Value  := AlmacenObject.ValueByName( 'idalma' );
                   DmAlmacenAUNAFields.Nombre.Value  := AlmacenObject.ValueByName( 'nombre' );

                   DmAlmacenAUNATable.Post;

                   end;
                 end;

            Result := True;
            end
       else begin
            TextoRespuesta := ObtenMensajeError( RestRpc.Http.StatusCode );
            // ShowNotification( TNotificationType.ntError, 'Error', RetornosAHtml( TextoRespuesta ) );
            end;

     finally
       FreeAndNil( AlmacenesResponse );
       end;

end;

procedure TSuministroStocksModule.CompruebaFicherosGlobales( ForzarActualizacion : Boolean = False );
begin
     If   ForzarActualizacion or ( DmSocioAUNATable.RecordCount=0 )
     then ObtenEmpresas;
     If   ForzarActualizacion or ( DmAlmacenAUNATable.RecordCount=0 )
     then ObtenAlmacenes;
end;

function TSuministroStocksModule.ConsultaStock( IdAUNA : String;
                                                Data   : TgxMemData ) : Boolean;

var StockResponse,
    ArticlesResponse : TclJSONArray;
    ArticleObject : TclJSONObject;
    ResultOk : Boolean;
    TextoRespuesta : String;

    idsoci,
    idalma,
    idarti,
    dispon,
    pdtent,
    pdtrec,
    premed,
    ultpco,
    ultdtc,
    univen,
    estado,
    fecact : String;

begin

     Result := False;

     try

       StockResponse := nil;

       Result := RestRpc.Get( Host + '/v2/vstock?idarti=' + IdAUNA );
       TextoRespuesta := '';
       If   Result
       then begin
            StockResponse := RestRpc.ResponseJSON as TclJSONArray;
            If   StockResponse.Count>0
            then begin
                 ArticlesResponse := StockResponse.Items[ 0 ] as TclJSONArray;
                 If   ArticlesResponse.Count>0
                 then begin
                      For var I := 0 to ArticlesResponse.Count - 1 do
                        begin
                        ArticleObject := ArticlesResponse.Items[ I ] as TclJSONObject;

                        idsoci := ArticleObject.ValueByName( 'idsoci' );
                        idalma := ArticleObject.ValueByName( 'idalma' );
                        idarti := ArticleObject.ValueByName( 'idarti' );
                        dispon := ArticleObject.ValueByName( 'dispon' );
                        pdtent := ArticleObject.ValueByName( 'pdtent' );
                        pdtrec := ArticleObject.ValueByName( 'pdtrec' );
                        estado := ArticleObject.ValueByName( 'estado' );
                        fecact := ArticleObject.ValueByName( 'fecact' );

                        If   StrToIntDef( idsoci, 0 )>10   // No son socios y almacenes de prueba
                        then begin

                             Data.Append;

                             Data.FieldValues[ 'IdSocio' ] := idsoci;
                             Data.FieldValues[ 'NombreSocio' ] := DescripcionSocio( idsoci );
                             Data.FieldValues[ 'IdAlmacen' ] := idalma;
                             Data.FieldValues[ 'NombreAlmacen' ] := DescripcionAlmacen( idsoci, idalma );
                             Data.FieldValues[ 'Disponible' ] := StrToCurrDef( dispon, 0, DecimalFormatSettings );
                             Data.FieldValues[ 'PendienteServir' ] := StrToCurrDef( pdtent, 0, DecimalFormatSettings );
                             Data.FieldValues[ 'PendienteRecibir' ] := StrToCurrDef( pdtrec, 0, DecimalFormatSettings );
                             Data.FieldValues[ 'Estado' ] := estado;
                             Data.FieldValues[ 'FechaUltActualizacion' ] := StrTSToDateTime( fecact );

                             Data.Post;

                             end;

                        end;
                      end;
                 end;

            Result := True;
            end
       else begin
            TextoRespuesta := ObtenMensajeError( RestRpc.Http.StatusCode );
            ShowNotification( TNotificationType.ntError, 'No se ha podido obtener la información', RetornosAHtml( TextoRespuesta ) );
            end;

     finally
       FreeAndNil( StockResponse );
       end;

end;

procedure TSuministroStocksModule.DoOnPublicacionStock( Sender: TObject );
begin
     //
end;

function TSuministroStocksModule.GetCodigoAlmacen( Index : SmallInt ): String;
begin
     If   Index in  [ 1..3 ]
     then Result := FCodigoAlmacen[ Index ]
     else Result := '';
end;

function TSuministroStocksModule.GetIdAlmacen(Index: SmallInt): String;
begin
     If   Index in  [ 1..3 ]
     then Result := FIdAlmacen[ Index ]
     else Result := '';
end;

procedure SectionSetup;
begin
     If   Assigned( Gds30Frm )
     then With Gds30Frm do
            begin
            var BarButton := AddBarButtonItem( ProcesosAlmacenMenuItem, 'Publicación del stock (AUNA)', True );
            BarButton.Glyph.Assign( ApplicationForms.AUNAImage.Picture.Graphic );
            BarButton.Glyph.SourceHeight := 16;
            BarButton.Glyph.SourceWidth := 16;
            BarButton.OnClick := TSuministroStocksModule.PublicacionStock;
            end;
end;

procedure InicializaSuministroStocks;
begin     
     SuministroStocks;
end;

initialization

   AddProcedure( imOptionalSectionModule, 119, SectionSetup );

   // AddProcedure( imGetParamConf, 0, ActualizaParametrosSuministroStocks );

   AddProcedure( imOnEnterpriseAccess, 0, InicializaSuministroStocks );

end.
