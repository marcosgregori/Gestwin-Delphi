
unit dm_tar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AppContainer,

  AppForms, DB, nxdb, DataManager,

  Gim90Fields;


type
  TTareaModule = class(TDataModule)
    DmTareaTable: TnxeTable;
    procedure tareaModuleDestroy(Sender: TObject);
    procedure tareaModuleCreate(Sender: TObject);
  private
    CountChecked : Boolean;
  public

    DmTareaFields  : TTareaFields;

    function ProximoNroTarea : LongInt;

  end;

var
  TareaModule: TTareaModule = nil;


function  Tarea : TTareaModule;

implementation

uses AppManager,
     DataAccess,
     NexusRpcData,

     dmi_cnd,
     
     dm_cnd,
     dm_pga;

{$R *.DFM}

function Tarea : TTareaModule;
begin
     CreateDataModule( TTareaModule, TareaModule );
     result := TareaModule;
end;

procedure TTareaModule.TareaModuleDestroy(Sender: TObject);
begin
     TareaModule := nil;
end;

procedure TTareaModule.TareaModuleCreate(Sender: TObject);
begin
     DmTareaFields := TTareaFields.Create( DmTareaTable );
end;

function TTareaModule.ProximoNroTarea : LongInt;

var  ValorActual : LongInt;

begin

     ValorActual := 0;

     If   not CountChecked and ( NexusRpc.SessionCount<=1 ) 
     then With DmTareaTable do
            begin
            IndexFieldNames := 'Ejercicio;NroTarea';
            If   FindEqualLast( [ ApplicationContainer.Ejercicio ] )
            then ValorActual := DmTareaFields.NroTarea.Value + 1
            else ValorActual := 2;
            CountChecked := True;
            end;

     ValorActual := Contadores.Incrementa( cnTarea, ApplicationContainer.Ejercicio, '', ValorActual, 2 );

     Result := ValorActual;

end;

initialization

   // Si la aplicación contiene el módulo de gestión interna es porque es la aplicación de Winstation
   
   UnProtectedApp := True;
   SpEvaluation := False;
   Sp64BitsServer := True;
   
end.
