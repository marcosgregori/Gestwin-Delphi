unit dm_cnd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AppContainer,
  LibUtils,
  AppForms,

  Gim00Fields, 

  dmi_cnd,
  
  DB, 
  nxdb, 
  DataManager;


type
  
  TComprobacionRegistroEvent = function( ValorActual : LongInt ) : Boolean of object;

  TContadoresModule = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private

    ContadoresService : IContadoresService;
    
  public
  
    function LimpiaStack : Integer;    
    procedure RetiraValor( UnTipoContador : TTipoContador; UnEjercicio : SmallInt; UnCodigo : String = ''; ValorActual : LongInt = 0 );
    function Incrementa( UnTipoContador : TTipoContador; UnEjercicio : SmallInt; UnCodigo : String = ''; ValorActual : LongInt = 0; ValorInicial : LongInt = 1; ValorMaximo : LongInt = MaxInt ) : LongInt;
    function ExisteValor( UnTipoContador : TTipoContador; UnEjercicio : SmallInt; UnCodigo : String = ''; ValorActual : LongInt = 0 ) : Boolean;
    procedure Fija( UnTipoContador : TTipoContador; UnEjercicio : SmallInt; UnCodigo : String; UnValor : LongInt );    
    
  end;

var  ContadoresModule: TContadoresModule = nil;

function  Contadores : TContadoresModule;

implementation

uses nxllBde,
     nxdbBase,

     AppManager,
     DataAccess,
     NexusRpcData,

     b_msg,

     dm_pga;

{$R *.DFM}

resourceString
       RsMsg1  = 'El número del documento es demasiado alto.';
       RsMsg2  = 'El valor debe ser inferior a %d (%d dígitos).';

function Contadores : TContadoresModule;
begin
     CreateDataModule( TContadoresModule, ContadoresModule );
     Result := ContadoresModule;
end;

procedure TContadoresModule.DataModuleCreate(Sender: TObject);
begin
     NexusRpc.CreateRemoteInstance( CLSID_ContadoresService, IContadoresService, ContadoresService );
end;

procedure TContadoresModule.DataModuleDestroy(Sender: TObject);
begin
     ContadoresModule := nil;
end;

function TContadoresModule.ExisteValor(UnTipoContador: TTipoContador; UnEjercicio: SmallInt; UnCodigo: String; ValorActual: LongInt): Boolean;
begin
     Result := ContadoresService.ExisteValor( UnTipoContador, UnEjercicio, UnCodigo, ValorActual );
end;

procedure TContadoresModule.Fija(UnTipoContador: TTipoContador; UnEjercicio: SmallInt; UnCodigo: String; UnValor: LongInt);
begin
     ContadoresService.Fija( UnTipoContador, UnEjercicio, UnCodigo, UnValor );
end;

function TContadoresModule.Incrementa(UnTipoContador: TTipoContador; UnEjercicio: SmallInt; UnCodigo: String; ValorActual, ValorInicial, ValorMaximo: LongInt): LongInt;
begin
     Result := ContadoresService.Incrementa( UnTipoContador, UnEjercicio, UnCodigo, ValorActual, ValorInicial, ValorMaximo );
end;

function TContadoresModule.LimpiaStack : Integer;
begin
     Result := ContadoresService.LimpiaStack;
end;

procedure TContadoresModule.RetiraValor(UnTipoContador: TTipoContador; UnEjercicio: SmallInt; UnCodigo: String; ValorActual: LongInt);
begin
     ContadoresService.RetiraValor( UnTipoContador, UnEjercicio, UnCodigo, ValorActual );
end;
 
// Funciones adicionales

procedure CompruebaValorMaximo( Valor       : LongInt;
                                ValorMaximo : LongInt = 99999999 );
begin
     If   Valor>ValorMaximo
     then begin
          ShowNotification( ntExceptionError, RsMsg1, Format( RsMsg2, [ ValorMaximo, Length( IntToStr( ValorMaximo ) ) ] ) );
          Abort;
          end;
end;

end.
