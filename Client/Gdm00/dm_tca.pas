unit dm_tca;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  cxEdit,

  AppContainer,
  AppForms, DB, nxdb, DataManager,

  Gim00Fields;


type
  TTipoCambioModule = class(TDataModule)
    DmTipoCambioTable: TnxeTable;
    DmTipoCambioTableFecha: TDateField;
    DmTipoCambioTableCodigoDivisa: TWideStringField;
    DmTipoCambioTableTipoCambio: TFloatField;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    DsDivisaFields : TDivisaFields;
  public
    procedure Valida( CodigoDivisa : String; Fecha : TDateTime; var TipoDeCambio : Double; EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; IsInfoControl : Boolean = False ); overload;
    function  Obten( CodigoDivisa : String; Fecha : TDateTime; var TipoCambio : Double ) : Boolean;
  end;

var  TipoCambioModule: TTipoCambioModule = nil;


function  TipoCambio : TTipoCambioModule;

implementation

uses Variants,
     LibUtils,
     DataAccess,
     AppManager,

     dm_cdi;

{$R *.DFM}

resourceString
    RsMsg1 = 'No se ha fijado un tipo de cambio de la moneda en la fecha indicada.';
    RsMsg2 = 'Utilice la tecla de edición [F3] para acceder al mantenimiento de tipos de cambio y fijarlo.';

function TipoCambio : TTipoCambioModule;
begin
     CreateDataModule( TTipoCambioModule, TipoCambioModule );
     Result := TipoCambioModule;
end;

procedure TTipoCambioModule.DataModuleDestroy(Sender: TObject);
begin
     TipoCambioModule := nil;
end;

procedure TTipoCambioModule.Valida(     CodigoDivisa  : String;
                                        Fecha         : TDateTime;
                                    var TipoDeCambio  : Double;
                                        EditControl    : TcxCustomEdit;
                                    var DisplayValue  : Variant;
                                    var ErrorText     : TCaption;
                                    var Error         : Boolean;
                                        IsInfoControl : Boolean);

var  PrecioDivisa : Decimal;

begin
     PrecioDivisa := VarToDecimal( DisplayValue );
     If   ( PrecioDivisa<>0.0 ) and not Obten( CodigoDivisa, Fecha, TipoDeCambio )
     then begin
          Error := True;
          ErrorText := JoinMessage( RsMsg1, RsMsg2 );
          end;
end;

procedure TTipoCambioModule.DataModuleCreate(Sender: TObject);
begin
     DsDivisaFields := TDivisaFields.Create( Self );
end;

function TTipoCambioModule.Obten(     CodigoDivisa : String;
                                      Fecha        : TDateTime;
                                  var TipoCambio   : Double ) : Boolean;
begin
     TipoCambio := 0.0;
     Result := False;
     If   CodigoDivisa<>''
     then If   Divisa.Obten( CodigoDivisa, DsDivisaFields, True )
          then If   DsDivisaFields.CambioFijo.Value
               then begin
                    TipoCambio := DsDivisaFields.TipoCambio.Value;
                    Result := True;
                    end
               else If   DmTipoCambioTable.FindKey( [ Fecha, CodigoDivisa ] )
                    then begin
                         TipoCambio := DmTipoCambioTableTipoCambio.Value;
                         Result := True;
                         end;
end;

end.
