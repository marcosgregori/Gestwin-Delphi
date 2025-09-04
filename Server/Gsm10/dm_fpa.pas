
unit dm_fpa;

interface

uses
  Windows, Messages, SysUtils, Classes, 
  DB,
  nxdb,
  DataManager,

  Gim10Fields,
  ServerDataModule;


type
  TFormaPagoModule = class(TServerDataModule)
    DmFormaPagoTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
  private

  public

    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean = True ) : string;
    function  Obten( Codigo : String; FormaPagoFields : TFormaPagoFields ) : Boolean;

  end;

  // Tipos de documento

const   tdLetraCambio = 1;
        tdRecibo = 2;
        tdChequeBancarioPagare = 3;
        tdTransferencia = 4;
        tdPagoCertificado = 5;
        tdConfirming = 6;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses AppManager,

     EnterpriseData,

     Gim00Fields,
     SessionData;

{$R *.DFM}

resourceString
     RsMsg1 = 'La forma de pago de código [%s] ha sido dada de baja.';

procedure TFormaPagoModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm10.FormaPagoModule := nil;
end;

function TFormaPagoModule.Descripcion( Codigo             : String;
                                       NotificaSiNoExiste : Boolean = True ) : String;
begin
     Result := '';
     If   DmFormaPagoTable.FindKey( [ Codigo ] )
     then Result := DmFormaPagoTable.FieldValues[ RsDescripcion ]
     else If   NotificaSiNoExiste
          then Result := RsRegistroInexistente;
end;

function TFormaPagoModule.Obten( Codigo          : String;
                                 FormaPagoFields : TFormaPagoFields ) : Boolean;
begin
     Result := DmFormaPagoTable.FindKey( [ Codigo ] );
     FormaPagoFields.Update( DmFormaPagoTable );
end;

end.
