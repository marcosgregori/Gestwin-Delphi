
unit dm_sdf;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, cxEdit,
  AppContainer,
  AppForms,

  DB, nxdb, DataManager,

  Gim00Fields,
  Gim10Fields,
  dm_ine;

type
  TSerieFacturacionModule = class(TDataModule)
    DmSerieFacturacionTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private

   DmSerieFacturacionFields : TSerieFacturacionFields;
   DsEmpresaFields : TEmpresaFields;

  public

    EmpresaDestinoDiferente : Boolean;

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean; SerieFacturacionFields : TSerieFacturacionFields = nil; IsInfoControl : Boolean = False );
    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean  = True ) : String;
    function  Obten( Codigo : String; SerieFacturacionFields : TSerieFacturacionFields = nil; NotificaSiNoExiste : Boolean = False ) : Boolean;

    function ObtenSeriePorDefecto : String;

    function FijaSeriePorDefecto( EditControl : TcxCustomEdit ) : Boolean; overload;
    function FijaSeriePorDefecto( SerieField : TWideStringField ) : Boolean; overload;
    procedure AplicaRestriccionSerie( EditControl : TcxCustomEdit );

    function  ObtenFormatoDefecto( ModeloImpreso : TModeloImpreso; Serie : String ) : SmallInt;
    procedure CompletaSerieGenerica( SerieFacturacionFields : TSerieFacturacionFields = nil );   

    function CompruebaEmpresaDestino : Boolean;
    procedure AbreEmpresaAuxiliar;
    procedure CierraEmpresaAuxiliar;
  end;

var SerieFacturacionModule: TSerieFacturacionModule = nil;

resourceString
     rsSerieGenerica  = '<Serie genérica>';

function SerieFacturacion : TSerieFacturacionModule;

implementation

uses LibUtils,
     AppManager,
     EnterpriseDataAccess,

     Gdm00Dm,

     dm_emp,

     b_msg;

{$R *.DFM}

resourceString
     RsMsg1  = 'La serie de facturación de código [%s] ha sido dada de baja.';
     RsMsg2  = 'El formato de %s de la serie [%s] ha sido dado de baja.';
     RsMsg3  = 'Solucione el problema o imprima la factura con otro formato de impreso.';
     RsMsg4  = 'La empresa destino de código [%s] no existe.';
     RsMsg5  = 'Se cancela el proceso en curso. Los datos quedan tal y como estaban antes de intentar el proceso.';
     RsMsg6  = 'Tiene restringido el uso de esta serie de facturación.';

function SerieFacturacion : TSerieFacturacionModule;
begin
     CreateDataModule( TSerieFacturacionModule, SerieFacturacionModule );
     Result := SerieFacturacionModule;
end;

procedure TSerieFacturacionModule.DataModuleCreate(Sender: TObject);
begin
     DmSerieFacturacionFields := TSerieFacturacionFields.Create( DmSerieFacturacionTable );
     DsEmpresaFields := TEmpresaFields.Create( Self );
end;
procedure TSerieFacturacionModule.DataModuleDestroy(Sender: TObject);
begin
     SerieFacturacionModule := nil;
end;

procedure TSerieFacturacionModule.CompletaSerieGenerica( SerieFacturacionFields : TSerieFacturacionFields = nil );

var  SerieFacturacionTable : TnxeTable;

begin

     If   Assigned( SerieFacturacionFields ) and not SerieFacturacionFields.Initialized
     then SerieFacturacionFields.Clear( DmSerieFacturacionTable );

     If   Assigned( SerieFacturacionFields ) and ( SerieFacturacionFields.Dataset is TnxeTable )
     then SerieFacturacionTable := TnxeTable( SerieFacturacionFields.Dataset )
     else begin
          SerieFacturacionTable := DmSerieFacturacionTable;
          SerieFacturacionFields := DmSerieFacturacionFields;
          end;

     With SerieFacturacionTable do
       If   not FindKey( [ '' ] )
       then begin
            Append;
            With SerieFacturacionFields do
              begin
              Codigo.Value := '';
              Descripcion.Value := RsSerieGenerica;
              Afectar_Stock.Value := True;
              Contabilizar.Value := True;
              end;
            Post;
            end;

end;

procedure TSerieFacturacionModule.Valida(     EditControl            : TcxCustomEdit;
                                          var DisplayValue           : Variant;
                                          var ErrorText              : TCaption;
                                          var Error                  : Boolean;
                                              SerieFacturacionFields : TSerieFacturacionFields = nil;
                                              IsInfoControl          : Boolean = False );
begin

     If   DataModule00.DmUsuarioFields.Ventas_RestringirSerie.Value
     then If   DisplayValue<>DataModule00.DmUsuarioFields.Ventas_SerieDefecto.Value
          then begin
               Error := True;
               ErrorText := RsMsg6;
               Exit;
               end;

     If   ValueIsEmpty( DisplayValue )
     then begin
          CompletaSerieGenerica( SerieFacturacionFields );
          If   Assigned( SerieFacturacionFields )
          then SerieFacturacionFields.Update( DmSerieFacturacionTable );
          If   Assigned( EditControl )
          then EditControl.Description := RsSerieGenerica;
          end
     else ValidateRelationEx( EditControl, DmSerieFacturacionTable, [ DisplayValue ], DisplayValue, ErrorText, Error, SerieFacturacionFields, RsDescripcion, IsInfoControl );

end;

function TSerieFacturacionModule.Descripcion( Codigo             : String;
                                              NotificaSiNoExiste : Boolean = True ) : String;
begin
     GetRelationDescription( DmSerieFacturacionTable, [ Codigo ], Result, NotificaSiNoExiste, RsDescripcion );
end;

function  TSerieFacturacionModule.Obten( Codigo                 : String;
                                         SerieFacturacionFields : TSerieFacturacionFields = nil;
                                         NotificaSiNoExiste     : Boolean = False ) : Boolean;
begin

     Result := DmSerieFacturacionTable.FindKey( [ Codigo ] );
     If   not Result
     then If   Codigo=''
          then begin
               CompletaSerieGenerica( DmSerieFacturacionFields );
               Result := True;
               end
          else If   NotificaSiNoExiste
               then begin
                    ShowNotification( ntStop, Format( RsMsg1, [ Codigo ] ) );
                    Abort;
                    end;

     If   Assigned( SerieFacturacionFields )
     then SerieFacturacionFields.Update( DmSerieFacturacionTable );

end;

function TSerieFacturacionModule.ObtenSeriePorDefecto : String;
begin
     With DataModule00 do
       If   DmUsuarioFields.Ventas_SerieDefecto.Value=''
       then Result := DmEmpresaFields.Ventas_SerieDefecto.Value
       else Result := DmUsuarioFields.Ventas_SerieDefecto.Value;
end;

function TSerieFacturacionModule.FijaSeriePorDefecto( SerieField : TWideStringField ) : Boolean;
begin
     SerieField.Value := ObtenSeriePorDefecto;
     Result := SerieField.Value<>'';
end;

function TSerieFacturacionModule.FijaSeriePorDefecto( EditControl : TcxCustomEdit ) : Boolean;
begin
     Result := False;
     With EditControl do
       If   ValueIsEmpty( EditValue )
       then begin
            EditValue := ObtenSeriePorDefecto;
            Result := True;
            end;
end;

procedure TSerieFacturacionModule.AplicaRestriccionSerie( EditControl : TcxCustomEdit );
begin
     If   DataModule00.DmUsuarioFields.Ventas_RestringirSerie.Value
     then begin
          EditControl.PostEditValue( SerieFacturacion.ObtenSeriePorDefecto );
          EditControl.Enabled := False;
          end;
end;

//* 22.02.2002 Extraño lugar para situar este procedimiento, pero bueno.

function TSerieFacturacionModule.ObtenFormatoDefecto( ModeloImpreso : TModeloImpreso;
                                                      Serie         : String ) : SmallInt;

var   Formato : SmallInt;

begin
    Formato := InformeExterno.ObtenFormatoUsuario( ModeloImpreso );
    If   Formato=0
    then begin

         Obten( Serie );

         var TextoDocumento := 'documento';

         case ModeloImpreso of
           impPedidosVenta :
             begin
             Formato := DmSerieFacturacionFields.FormatoPedido.Value;
             TextoDocumento := 'pedido';
             end;
           impAlbaranesVenta :
             begin
             Formato := DmSerieFacturacionFields.FormatoAlbaran.Value;
             TextoDocumento := 'albarán';
             end;
           impFacturasVenta :
             begin
             Formato := DmSerieFacturacionFields.FormatoFactura.Value;
             TextoDocumento := 'factura';
             end;

           end;

         If   Formato<>0
         then With InformeExterno do
                If   DmInformeExternoTable.FindKey( [ Ord( ModeloImpreso ), Formato ] )
                then InformeExterno.FijaFormato
                else begin
                     ShowNotification( ntWarning, Format( RsMsg2, [ TextoDocumento, Serie ] ), RsMsg3 );
                     Abort;
                     end;
         end;
    Result := Formato;
end;

function TSerieFacturacionModule.CompruebaEmpresaDestino : Boolean;
begin
     EmpresaDestinoDiferente := ( DmSerieFacturacionFields.Empresa_Destino.Value<>'' ) and ( DmSerieFacturacionFields.Empresa_Destino.Value<>CodigoEmpresaActual );
     Result := EmpresaDestinoDiferente;
end;

procedure TSerieFacturacionModule.AbreEmpresaAuxiliar;
begin
     CompruebaEmpresaDestino;
     EnterpriseDataModule.UserAuxDatabase.Close;
     If   EmpresaDestinoDiferente
     then begin
          If   Empresa.Obten( DmSerieFacturacionFields.Empresa_Destino.Value, DsEmpresaFields )
          then EnterpriseDataModule.SetUserAuxDataPath( DsEmpresaFields.Codigo.Value, DsEmpresaFields.DataPath.Value )
          else begin
               ShowNotification( ntStop, RsMsg4, RsMsg5 );
               Abort;
               end;
          EnterpriseDataModule.UserAuxDatabase.Open;
          end;
     // else DataAccessModule.SetUserAuxDataPath( DataModule00.DmEmpresaFields.Codigo.Value, DataModule00.DmEmpresaFields.DataPath.Value );
end;

procedure TSerieFacturacionModule.CierraEmpresaAuxiliar;
begin
     CloseAllDataModules;
     EnterpriseDataModule.UserAuxDatabase.Close;
end;

end.

