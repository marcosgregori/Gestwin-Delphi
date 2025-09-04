
unit dm_fpa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,
  AppContainer,
  AppForms,

  DB,
  nxdb,
  DataManager,

  Gim10Fields;


type
  TFormaPagoModule = class(TDataModule)
    DmFormaPagoTable: TnxeTable;
    procedure FormaPagoModuleDestroy(Sender: TObject);
  private

  public

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean; IsInfoControl : Boolean = False );
    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean = True ) : string;
    function  Obten( Codigo : String; FormaPagoFields : TFormaPagoFields = nil; NotificaSiNoExiste : Boolean = False ) : Boolean;
  end;

var
  FormaPagoModule: TFormaPagoModule = nil;


function  FormaPago : TFormaPagoModule;

        // Tipos de documento

const   tdLetraCambio = 1;
        tdRecibo = 2;
        tdChequeBancarioPagare = 3;
        tdTransferencia = 4;
        tdPagoCertificado = 5;
        tdConfirming = 6;

implementation

uses AppManager,

     EnterpriseDataAccess,

     Gim00Fields,

     b_msg;

{$R *.DFM}

resourceString
     rsMsg1 = 'La forma de pago de código [%s] ha sido dada de baja.';

function FormaPago : TFormaPagoModule;
begin
     CreateDataModule( TFormaPagoModule, FormaPagoModule );
     Result := FormaPagoModule;
end;

procedure TFormaPagoModule.FormaPagoModuleDestroy(Sender: TObject);
begin
     FormaPagoModule := nil;
end;

procedure TFormaPagoModule.Valida(      EditControl    : TcxCustomEdit;
                                    var DisplayValue   : Variant;
                                    var ErrorText      : TCaption;
                                    var Error          : Boolean;
                                        IsInfoControl  : Boolean = False );
begin
     ValidateRelationEx( EditControl, DmFormaPagoTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, RsDescripcion, IsInfoControl );
end;

function TFormaPagoModule.Descripcion( Codigo             : String;
                                       NotificaSiNoExiste : Boolean = True ) : String;
begin
     GetRelationDescription( DmFormaPagoTable, [ Codigo ],  Result, NotificaSiNoExiste, RsDescripcion );
end;

function TFormaPagoModule.Obten( Codigo             : String;
                                 FormaPagoFields    : TFormaPagoFields = nil;
                                 NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmFormaPagoTable.FindKey( [ Codigo ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg1, [ Codigo ] ), '' );
          Abort;
          end;
     If   Assigned( FormaPagoFields )
     then FormaPagoFields.Update( DmFormaPagoTable );
end;


end.
