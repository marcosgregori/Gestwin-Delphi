unit dm_maq;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,
  AppContainer,

  AppForms,

  Datamanager,
  DB,
  nxdb,

  Gim70Fields,

  dmi_maq;


type
  TMaquinaModule = class(TDataModule)
    DmMaquinaTable: TnxeTable;
    DmOcupacionMaquinaTable: TnxeTable;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);

  private

    MaquinaService : IMaquinaService;

  public

    DmMaquinaFields  : TMaquinaFields;
    DmOcupacionMaquinaFields : TOcupacionMaquinaFields;

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; IsInfoControl : Boolean = False; MaquinaFields : TMaquinaFields = nil );
    function Obten( Codigo : String; MaquinaFields : TMaquinaFields = nil; NotificaSiNoExiste : Boolean = False ) : Boolean;
    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean = True ) : String;

    function HayTareasPendientes( Fecha : TDate ) : Boolean;
    procedure OrdenaSecuenciaTurno( CodigoMaquina : String; Fecha : TDate; Turno : SmallInt; Reordenar : Boolean = False );
    procedure OrdenaSecuenciaOrdenFabricacion( Ejercicio : SmallInt; NroOrden : LongInt );
    procedure ObtenRegistroOcupacion( CodigoMaquina : String; Fecha : TDate; Turno : SmallInt; OcupacionMaquinaFields : TOcupacionMaquinaFields );

  end;

var MaquinaModule: TMaquinaModule = nil;


function  Maquina : TMaquinaModule;

implementation

uses AppManager,
     EnterpriseDataAccess,
     NexusRpcData;

{$R *.DFM}

resourceString
     RsMsg1  = 'La máquina de código [%s] ha sido dada de baja.';

function Maquina : TMaquinaModule;
begin
     CreateDataModule( TMaquinaModule, MaquinaModule );
     Result := MaquinaModule;
end;

procedure TMaquinaModule.DataModuleCreate(Sender: TObject);
begin
     DmMaquinaFields :=  TMaquinaFields.Create( DmMaquinaTable );
     DmOcupacionMaquinaFields := TOcupacionMaquinaFields.Create( DmOcupacionMaquinaTable );

     NexusRpc.CreateRemoteInstance( CLSID_MaquinaService, IMaquinaService, MaquinaService );
end;

procedure TMaquinaModule.DataModuleDestroy(Sender: TObject);
begin
     MaquinaModule := nil;
end;

procedure TMaquinaModule.Valida(     EditControl   : TcxCustomEdit;
                                 var DisplayValue  : Variant;
                                 var ErrorText     : TCaption;
                                 var Error         : Boolean;
                                     IsInfoControl : Boolean = False;
                                     MaquinaFields : TMaquinaFields = nil );
begin
     ValidateRelation( EditControl, DmMaquinaTable, [ DisplayValue ], DisplayValue, ErrorText, Error, MaquinaFields, RsDescripcion, IsInfoControl );
end;

function  TMaquinaModule.Obten( Codigo             : String;
                                MaquinaFields      : TMaquinaFields = nil;
                                NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmMaquinaTable.FindKey( [ Codigo ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg1, [ Codigo ] ), '' );
          Abort;
          end;
     If   Assigned( MaquinaFields )
     then MaquinaFields.Update( DmMaquinaTable );
end;

function TMaquinaModule.Descripcion( Codigo             : String;
                                     NotificaSiNoExiste : Boolean = True ) : String;
begin
     Result := '';
     If   DmMaquinaTable.FindKey( [ Codigo ] )
     then Result := DmMaquinaFields.Descripcion.Value
     else If   NotificaSiNoExiste
          then Result := RsRegistroInexistente;
end;

procedure TMaquinaModule.ObtenRegistroOcupacion( CodigoMaquina          : String;
                                                 Fecha                  : TDate;
                                                 Turno                  : SmallInt;
                                                 OcupacionMaquinaFields : TOcupacionMaquinaFields );
begin
     With DmOcupacionMaquinaTable do
        If   not FindKey( [ CodigoMaquina, Fecha, Turno ] )
        then begin
             Append;
             DmOcupacionMaquinaFields.CodigoMaquina.Value := CodigoMaquina;
             DmOcupacionMaquinaFields.Fecha.Value := Fecha;
             DmOcupacionMaquinaFields.Turno.Value := Turno;
             Browse;
             end;
     OcupacionMaquinaFields.Update( DmOcupacionMaquinaTable );
end;

//  MaquinaService

function TMaquinaModule.HayTareasPendientes( Fecha : TDate ): Boolean;
begin
     Result := MaquinaService.HayTareasPendientes( Fecha );
end;

procedure TMaquinaModule.OrdenaSecuenciaOrdenFabricacion( Ejercicio : SmallInt; NroOrden : LongInt );
begin
     MaquinaService.OrdenaSecuenciaOrdenFabricacion( Ejercicio, NroOrden );
end;

procedure TMaquinaModule.OrdenaSecuenciaTurno(CodigoMaquina: String; Fecha : TDate; Turno : SmallInt; Reordenar : Boolean = False );
begin
     MaquinaService.OrdenaSecuenciaTurno( CodigoMaquina, Fecha, Turno, Reordenar );
end;

end.
