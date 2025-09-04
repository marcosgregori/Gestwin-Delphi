
unit dm_sdf;

interface

uses
  Windows, Messages, SysUtils, Classes,

  DB, nxdb,

  DataManager,
  ServerDataModule,

  Gim00Fields,
  Gim10Fields;

type
  TSerieFacturacionModule = class(TServerDataModule)
    DmSerieFacturacionTable: TnxeTable;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure ServerDataModuleDestroy(Sender: TObject);
  private

  public

    DmSerieFacturacionFields : TSerieFacturacionFields;

    EmpresaFields : TEmpresaFields;
    EmpresaDestinoDiferente : Boolean;

    function  Descripcion( Codigo : String ) : String;
    function  Obten( Codigo : String; SerieFacturacionFields : TSerieFacturacionFields = nil ) : Boolean;

    function ObtenSeriePorDefecto : String;
    procedure CompletaSerieGenerica( SerieFacturacionFields : TSerieFacturacionFields = nil );

    function CompruebaEmpresaDestino : Boolean;
    procedure AbreEmpresaAuxiliar;
    procedure CierraEmpresaAuxiliar;
  end;

resourceString

     RsMsg1  = 'La serie de facturación de código [%s] ha sido dada de baja.';
     RsMsg2  = 'El formato de factura de la serie [%s] ha sido dado de baja.';
     RsMsg3  = 'Solucione el problema o imprima la factura con otro formato de impreso.';
     RsMsg4  = 'La empresa destino de código [%s] no existe.';
     RsMsg5  = 'Se cancela el proceso en curso. Los datos quedan tal y como estaban antes de intentar el proceso.';
     RsMsg6  = 'Tiene restringido el uso de esta serie de facturación.';

     rsSerieGenerica  = '<Serie genérica>';


implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses LibUtils,

     AppManager,

     SessionData,

     Gsm00Dm;

{$R *.DFM}

procedure TSerieFacturacionModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmSerieFacturacionFields := TSerieFacturacionFields.Create( DmSerieFacturacionTable );
     EmpresaFields := TEmpresaFields.Create( Self );
end;

procedure TSerieFacturacionModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm10.SerieFacturacionModule := nil;
end;

function TSerieFacturacionModule.ObtenSeriePorDefecto : String;
begin
     With SessionDataModule do
       If   UsuarioFields.Ventas_SerieDefecto.Value=''
       then Result := EmpresaFields.Ventas_SerieDefecto.Value
       else Result := UsuarioFields.Ventas_SerieDefecto.Value;
end;

procedure TSerieFacturacionModule.CompletaSerieGenerica( SerieFacturacionFields : TSerieFacturacionFields = nil );

var  SerieFacturacionTable : TnxeTable;

begin

     If   Assigned( SerieFacturacionFields ) and ( SerieFacturacionFields.Dataset is TnxeTable )
     then SerieFacturacionTable := SerieFacturacionFields.Table
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
              Descripcion.Value := rsSerieGenerica;
              Afectar_Stock.Value := True;
              Contabilizar.Value := True;
              end;
            Post;
            end;
end;

function TSerieFacturacionModule.Descripcion( Codigo : String ) : String;
begin
     Result := '';
     If   DmSerieFacturacionTable.FindKey( [ Codigo ] )
     then Result := DmSerieFacturacionFields.Descripcion.Value;
end;

function  TSerieFacturacionModule.Obten( Codigo                 : String;
                                         SerieFacturacionFields : TSerieFacturacionFields = nil ) : Boolean;
begin
     Result := DmSerieFacturacionTable.FindKey( [ Codigo ] );
     If   not Result
     then If   Codigo=''
          then begin
               CompletaSerieGenerica( DmSerieFacturacionFields );
               Result := True;
               end;
     If   Assigned( SerieFacturacionFields )
     then SerieFacturacionFields.Update( DmSerieFacturacionTable );
end;

function TSerieFacturacionModule.CompruebaEmpresaDestino : Boolean;
begin
     EmpresaDestinoDiferente := ( DmSerieFacturacionFields.Empresa_Destino.Value<>'' ) and ( DmSerieFacturacionFields.Empresa_Destino.Value<>SessionDataModule.CodigoEmpresa );
     Result := EmpresaDestinoDiferente;
end;

procedure TSerieFacturacionModule.AbreEmpresaAuxiliar;
begin
     CompruebaEmpresaDestino;
     EnterpriseDataModule.AuxDatabase.Close;
     If   EmpresaDestinoDiferente
     then begin
          If   SessionDataModule.Dm00.EmpresaModule.Obten( DmSerieFacturacionFields.Empresa_Destino.Value, EmpresaFields )
          then EnterpriseDataModule.OpenAuxDatabase( EmpresaFields.Codigo.Value, EmpresaFields.DataPath.Value )
            else begin
                 SessionDataModule.SendNotification( ntStop, RsMsg4, RsMsg5 );
                 Abort;
                 end;
          EnterpriseDataModule.AuxDatabase.Open;
          end;
     // else MainDataModule.SetUserAuxDataPath( DataModule00.DmEmpresaFields.Codigo.Value, DataModule00.DmEmpresaFields.DataPath.Value );
end;

procedure TSerieFacturacionModule.CierraEmpresaAuxiliar;
begin
     EnterpriseDataModule.AuxDatabase.Close;
end;

end.

