
unit dm_sdp119;

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
  dxGDIPlusClasses,
  cxClasses,
  cxGraphics,

  clJSON,
  clURIUtils,
  clEncoder,
  clUtils,

  Gim00Fields,
  Gim10Fields,
  Gim30Fields,

  dmi_sto,

  dm_art,
  dm_rea,
  dm_sto;


type

  TSuministroPedidosModule = class(TDataModule)
    DmArticuloTable: TnxeTable;
    DmMovimientoTable: TnxeTable;
    DmLineaMovimientoTable: TnxeTable;
    DmClienteTable: TnxeTable;
    DmClaseTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure RESTClientError(Sender: TObject; ErrorCode: Integer; Fatal, Remote: Boolean);

  private

    FNombreUsuario,
    FPassword : String;

    FErrorCode : Integer;
    FErrorMessage : String;

    FFunctionURL,
    FToken : String;
    FHTTPResult : Integer;
    FParameters : TclJsonObject;

    DmArticuloFields : TArticuloFields;
    DmArticulosRelacionadosFields : TArticulosRelacionadosFields;
    DmClaseFields : TClaseFields;
    DmMovimientoFields : TMovimientoFields;
    DmLineaMovimientoFields : TLineaMovimientoFields;
    DmClienteFields : TClienteFields;
    DmTiposIVAFields : TTiposIVAFields;

    SerieFacturacionFields : TSerieFacturacionFields;
    TiposIVAFields : TTiposIVAFields;
    ClienteFields : TClienteFields;
    ArticuloFields : TArticuloFields;
    RegistroActualizacionFields : TRegistroActualizacionFields;

    function RetornosAHtml(Value: String): String;
    function HtmlATexto(Value: String): String;

   protected

     procedure DoOnEnviarButtonClick( Sender : TObject );
     procedure DoOnPresentacionPedidos( Sender : TObject );

     class procedure PresentacionPedidos( Sender : TObject );
     class procedure ConfiguracionAUNA( Sender : TObject );

   public

    function EnviaPedido( Propietario, Serie : String; NroPedido : LongInt ) : Boolean;

    property NombreUsuario : String read FNombreUsuario write FNombreUsuario;
    property Password : String read FPassword write FPassword;
  end;

function  SuministroPedidos : TSuministroPedidosModule;
procedure ActualizaParametrosSuministroPedidos;

const rgPedidosCLCMarcilla = 100;  // CUIDADO  : existen tipos de registro de otros módulos. Por ejemplo, dm_rea207 utiliza el rango 0..8.

      ncrParametrosSuministroPedidos = 'SuministroPedidos119';

      ncrNombreUsuario = 'NombreUsuario';
      ncrPassword = 'Password';

implementation

uses Variants,

     StrUtils,
     DateUtils,
     TextConvert,

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

     dmi_mov,

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

var  SuministroPedidosModule : TSuministroPedidosModule = nil;

procedure ActualizaParametrosSuministroPedidos;
begin
     If   Assigned( SuministroPedidosModule )
     then With SuministroPedidosModule do
            begin
            Registro.ClavePadre := CodigoEmpresaActual + '.' + ncrParametrosSuministroPedidos;
            NombreUsuario := Registro.ObtenValorString( ncrNombreUsuario );
            Password := Registro.ObtenValorString( ncrPassword );
            end;
end;

{ --- }

function SuministroPedidos : TSuministroPedidosModule;
begin
     CreateDataModule( TSuministroPedidosModule, SuministroPedidosModule );
     Result := SuministroPedidosModule;
end;

class procedure TSuministroPedidosModule.PresentacionPedidos( Sender : TObject );
begin
     RegistroPresentacionPedidos;
end;

class procedure TSuministroPedidosModule.ConfiguracionAUNA( Sender: TObject);
begin
     MntConfiguracionAUNA;
end;

procedure TSuministroPedidosModule.DataModuleCreate(Sender: TObject);
begin

     DmArticuloFields := TArticuloFields.Create( DmArticuloTable );
     DmClaseFields := TClaseFields.Create( DmClaseTable );
     DmMovimientoFields := TMovimientoFields.Create( DmMovimientoTable );
     DmLineaMovimientoFields := TLineaMovimientoFields.Create( DmLineaMovimientoTable );
     DmClienteFields := TClienteFields.Create( DmClienteTable );

     SerieFacturacionFields := TSerieFacturacionFields.Create( Self );
     TiposIVAFields := TTiposIVAFields.Create( Self );
     ClienteFields := TClienteFields.Create( Self );
     ArticuloFields := TArticuloFields.Create( Self );

     FParameters := TclJsonObject.Create;

     ActualizaParametrosSuministroPedidos;
end;

procedure TSuministroPedidosModule.DataModuleDestroy(Sender: TObject);
begin
     FParameters.Free;
     SuministroPedidosModule := nil;
end;

{ --------- }

procedure TSuministroPedidosModule.RESTClientError(Sender: TObject; ErrorCode: Integer; Fatal, Remote: Boolean);
begin
     FErrorCode := ErrorCode;
     FErrorMessage := '';  // TODO:
end;

function TSuministroPedidosModule.RetornosAHtml( Value : String ) : String;

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

function TSuministroPedidosModule.HtmlATexto( Value : String ) : String;

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

function TSuministroPedidosModule.EnviaPedido( Propietario,
                                               Serie     : String;
                                               NroPedido : LongInt ) : Boolean;

var  Observaciones,
     CodigoArticulo,
     CodigoRegistro : String;
     NroLinea : SmallInt;
     Host,
     TextoRespuesta,
     RequestBody : String;
     NotificationType  : TNotificationType;
     RegistroActualizacionFields : TRegistroActualizacionFields;

begin

     Result := False;

     // TipoMovimiento;Ejercicio;Propietario;Serie;NroDocumento
     If   DmMovimientoTable.FindKey( [ tmPedidoCompra, ApplicationContainer.Ejercicio, Propietario, Serie, NroPedido ] )
     then begin

          Host := 'https://www.clcmarcilla.com';
          If   NombreUsuario=''
          then NombreUsuario := 'PRUEBA';
          If   Password=''
          then Password := 'FY5C*7';

          RequestBody := '';
          try

            StrAdd( RequestBody, '<REFERE>' + IntToStr( DmMovimientoFields.NroDocumento.Value ) + '</REFERE>' );
            StrAdd( RequestBody, '<FECENT>' + StrFormatDate( DmMovimientoFields.FechaAplicacion.Value ) + '</FCENT>' );

            If   DmMovimientoFields.Anotacion.Value<>''
            then begin
                 Observaciones := TextConverter.ToPlainText( DmMovimientoFields.Anotacion.Value );
                 Observaciones := StrRemoveChars( Observaciones, [ '''', '"', '<', '>' ] );
                 end;

            StrAdd( RequestBody, '<OBSERV>' + Observaciones + '</OBSERV>' );
            StrAdd( RequestBody, '<TIPENT>P</TIPENT>' );  // Esperar a portes pagados

            NroLinea := 1;
            With DmLineaMovimientoTable do
              begin
              // Ejercicio;NroOperacion;NroPagina;NroLinea
              With DmMovimientoFields do
                SetRange( [ Ejercicio.Value, NroOperacion.Value ] );
              First;
              While not Eof do
                begin

                Articulo.Obten( DmLineaMovimientoFields.CodigoArticulo.Value, ArticuloFields );

                StrAdd( RequestBody, '<DOCLIN_' + IntToStr( NroLinea ) + '>' );

                If   ArticuloFields.CampoLibre2.Value=''
                then CodigoArticulo := DmLineaMovimientoFields.CodigoArticulo.Value
                else CodigoArticulo := ArticuloFields.CampoLibre2.Value;

                StrAdd( RequestBody, '<CODART>' + CodigoArticulo + '</CODART>' );

                {
                CodigoArticuloEquivalente := '';
                If   DataModule00.DmEmpresaFields.Articulo_ArticulosRelacionados.Value
                then If   Articulo.ObtenArticuloRelacionado( DmLineaMovimientoFields.CodigoArticulo.Value, traEquivalentes, 1, ArticuloFields )
                     then CodigoArticuloEquivalente := ArticuloFields.Codigo.Value;
                AddXMLTextElement( LineElement, 'CODEQI', CodigoArticuloEquivalente );
                }
                StrAdd( RequestBody, '<UNIDAD>' + StrFormat( DmLineaMovimientoFields.Cantidad.Value, DataModule00.DmEmpresaFields.Compras_DecCantidad.Value ) + '</UNIDAD>' );
                {
                If   DmLineaMovimientoFields.Precio.Value<>0.0
                then AddXMLTextElement( LineElement, 'PREASO', StrFormat( DmLineaMovimientoFields.Precio.Value, DataModule00.DmEmpresaFields.Compras_DecPrecio.Value ) );
                If   DmLineaMovimientoFields.Descuento.Value<>0.0
                then AddXMLTextElement( LineElement, 'DTOASO', StrFormat( DmLineaMovimientoFields.Descuento.Value, DataModule00.DmEmpresaFields.Compras_DecDto.Value ) );
                }

                StrAdd( RequestBody, '</DOCLIN_' + IntToStr( NroLinea ) + '>' );

                Inc( NroLinea );
                Next;
                end;

              end;

            RequestBody := 'USU=' + NombreUsuario + '&' +
                           'PSW=' + Password + '&' +
                           'XMLDOC=' + URLEncode( RequestBody );

            try

              Result := RestRpc.Post( Host + '/api/cap.cfm', RequestBody );

              If   Result
              then TextoRespuesta := RestRpc.ResponseText
              else case RestRpc.Http.StatusCode of
                     204 : TextoRespuesta := 'Respuesta vacía / Sin resultados';
                     304 : TextoRespuesta := 'No modificado / Respuesta en cache (<5s)';
                     401 : TextoRespuesta := 'Credenciales incorrectas';
                     500 : TextoRespuesta := 'Error en el servidor de CLC Marcilla';
                     else TextoRespuesta := 'Error no definido';
                     end;

              CodigoRegistro :=  Propietario + RightPad( Serie, 2 ) + StrIntPadded( NroPedido, 8 );

              RegistroActualizacionFields := RegistroActualizacion.Edita( rgPedidosCLCMarcilla, CodigoRegistro );

              RegistroActualizacionFields.FechaActualizacion.Value := Now;
              RegistroActualizacionFields.Ejercicio.Value := DmMovimientoFields.Ejercicio.Value;
              RegistroActualizacionFields.Serie.Value := DmMovimientoFields.Serie.Value;
              RegistroActualizacionFields.NroDocumento.Value := DmMovimientoFields.NroDocumento.Value;
              RegistroActualizacionFields.Id.Value := DmMovimientoFields.NroOperacion.Value;
              RegistroActualizacionFields.Resultado.Value := HtmlATexto( TextoRespuesta );

              RegistroActualizacionFields.DatasetPost;

              If   Result
              then NotificationType := TNotificationType.ntInformation
              else NotificationType := TNotificationType.ntError;

              ShowNotification( NotificationType, 'Respuesta', RetornosAHtml( TextoRespuesta ) );

            except on E : Exception do
              FErrorMessage := E.Message;
              end;

          finally

            end;

          end;

end;

procedure TSuministroPedidosModule.DoOnEnviarButtonClick( Sender : TObject );
begin
     With MntMcoForm[ tmPedidoCompra] do
       If   EnviaPedido( MovimientoFields.Propietario.Value,
                         MovimientoFields.Serie.Value,
                         MovimientoFields.NroDocumento.Value )
       then begin
            MovimientoFields.Suministrado.Value := True;
            FormManager.PostCurrentRecord;
            end;
end;

procedure TSuministroPedidosModule.DoOnPresentacionPedidos( Sender: TObject );
begin
     RegistroPresentacionPedidos;
end;

procedure SetupMantenimientoPedidos;
begin
     If   Assigned( MntMcoForm[ tmPedidoCompra ] ) and ( TipoMovimientoCreado=tmPedidoCompra )
     then With MntMcoForm[ tmPedidoCompra ] do
            begin
            EnviarButton.OnClick := SuministroPedidosModule.DoOnEnviarButtonClick;
            SetButtonVisible( EnviarButton, True );
            end;
end;

procedure SectionSetup;
begin
     If   Assigned( Gds00Frm )
     then With Gds00Frm do
            begin
            var BarButton := AddBarButtonItem( ConfiguracionEmpresasItem, 'AUNA', False );
            BarButton.Glyph.Assign( ApplicationForms.AUNAImage.Picture.Graphic );
            BarButton.Glyph.SourceHeight := 16;
            BarButton.Glyph.SourceWidth := 16;
            BarButton.OnClick := TSuministroPedidosModule.ConfiguracionAUNA;
            end;

     If   Assigned( Gds30Frm )
     then With Gds30Frm do
            begin
            var BarButton := AddBarButtonItem( PedidosCompraItem, 'Registro de presentación de pedidos (CLC Marcilla)', False, 1 );
            BarButton.OnClick := TSuministroPedidosModule.PresentacionPedidos;
            end;
end;

procedure InicializaSuministroPedidos;
begin
     SuministroPedidos;
end;

initialization

   AddProcedure( imOptionalSectionModule, 119, SectionSetup );

   // AddProcedure( imGetParamConf, 0, ActualizaParametrosSuministroPedidos );

   AddProcedure( imOnEnterpriseAccess, 0, InicializaSuministroPedidos );
   AddProcedure( imOnCreateComponent, idMntMcoForm, SetupMantenimientoPedidos );

end.
