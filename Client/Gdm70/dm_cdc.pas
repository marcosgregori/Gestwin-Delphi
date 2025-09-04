
unit dm_cdc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  cxEdit,

  DB, nxDB,

  AppContainer,
  AppForms,
  DataManager,

  Gim70Fields;

type
  TCodigoCosteModule = class(TDataModule)
    DmCodigoCosteTable: TnxeTable;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private

  public

    DmCodigoCosteFields  : TCodigoCosteFields;

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; IsInfoControl : Boolean = False );
    function Descripcion( Value : SmallInt; NotificaSiNoExiste : Boolean = True ) : String;
    function Obten( Value : SmallInt; NotificaSiNoExiste : Boolean = False ) : boolean;
    function TextoTipo( Tipo : SmallInt ) : String;
  end;

var CodigoCosteModule: TCodigoCosteModule = nil;


function  CodigoCoste : TCodigoCosteModule;

const   ccCosteHora = 0;
        ccCosteFijoProceso = 1;

implementation

uses LibUtils,
     Variants,
     EnterpriseDataAccess,
     AppManager,

     Gim00Fields;

{$R *.DFM}

resourceString
     RsMsg1 = 'No existe un codigo de coste con este código|Puede consultar los existentes pulsando [F4].';
     RsMsg2 = 'El codigo de coste número %d ha sido dado de baja.';

function CodigoCoste : TCodigoCosteModule;
begin
     CreateDataModule( TCodigoCosteModule, CodigoCosteModule );
     Result := CodigoCosteModule;
end;

procedure TCodigoCosteModule.DataModuleDestroy( Sender : TObject );
begin
     CodigoCosteModule := nil;
end;

procedure TCodigoCosteModule.Valida(     EditControl   : TcxCustomEdit;
                                     var DisplayValue  : Variant;
                                     var ErrorText     : TCaption;
                                     var Error         : Boolean;
                                         IsInfoControl : Boolean = False );
begin
     ValidateRelation( EditControl, DmCodigoCosteTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, RsDescripcion, IsInfoControl );
end;

function TCodigoCosteModule.Descripcion( Value : SmallInt; NotificaSiNoExiste : Boolean = True ) : String;
begin
     Result := '';
     If   DmCodigoCosteTable.FindKey( [ Value ] )
     then Result := DmCodigoCosteFields.Descripcion.Value
     else If   NotificaSiNoExiste
          then Result := RsRegistroInexistente;
end;

function TCodigoCosteModule.TextoTipo( Tipo : SmallInt ) : String;

const TextoTipo : array[ ccCosteHora..ccCosteFijoProceso ] of String = ( 'Coste por hora', 'Coste fijo por proceso' );

begin
     If   Tipo in [ ccCosteHora..ccCosteFijoProceso ]
     then Result := TextoTipo[ Tipo ]
     else Result := RsInexistente;
end;
function TCodigoCosteModule.Obten( Value              : SmallInt;
                                   NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmCodigoCosteTable.FindKey( [ Value ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg2, [ Value ] ), '' );
          Abort;
          end;
end;

procedure TCodigoCosteModule.DataModuleCreate(Sender: TObject);
begin
     DmCodigoCosteFields := TCodigoCosteFields.Create( DmCodigoCosteTable );
end;

end.
