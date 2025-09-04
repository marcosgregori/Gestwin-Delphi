unit f_sec;

interface

uses
  Windows, Messages, SysUtils, Classes,

  BaseSessionData;

type
  TDatasetOperation = ( dsoCreate, dsoUpdate, dsoClear );
  TUpdateDataEvent = procedure( const NroOrden : SmallInt; const NroMes : SmallInt ) of object;

  TSecuenciaMes = class
  private

    FSessionDataModule : TBaseSessionDataModule;
    FMesInicial,
    FMesFinal,
    FMesActual : Word;
    FFin : Boolean;

  public

    constructor Create( ASessionDataModule : TBaseSessionDataModule );

    procedure Reset( MesInicial, MesFinal : SmallInt );
    function MesValido( NroMes : Word ) : Boolean;
    function UltimoMes : Boolean;
    procedure IncrementaMes( var FMesActual : Word );

    property MesInicial : Word read FMesInicial;
    property MesFinal : Word read FMesFinal;
    property MesActual : Word read FMesActual;
    property Fin : Boolean read FFin;

  end;

implementation

uses    DB,
        DateUtils,
        LibUtils,
        AppManager;

procedure TSecuenciaMes.Reset( MesInicial, MesFinal : SmallInt );
begin
     FMesInicial := MesInicial;
     FMesFinal := MesFinal;
     FMesActual := MesInicial;
     FFin := False;
end;

constructor TSecuenciaMes.Create( ASessionDataModule: TBaseSessionDataModule);
begin
     inherited Create;
     FSessionDataModule := ASessionDataModule;
end;

function TSecuenciaMes.MesValido( NroMes : Word ) : Boolean;
begin
     If   FSessionDataModule.NroMesInicial=1
     then Result := NroMes in [ FMesInicial..FMesFinal ]
     else If   FMesInicial<FSessionDataModule.NroMesInicial     // Está en el rango 1..NroMesFinal
          then Result := NroMes in [ 1..FMesFinal ]
          else If   FMesFinal<FMesInicial
               then Result := ( NroMes in [ FMesInicial..12 ] ) or ( NroMes in [ 1..FMesFinal ] )
               else Result := NroMes in [ FMesInicial..FMesFinal ]
end;

function TSecuenciaMes.UltimoMes : Boolean;
begin

    Result := False;

    If   not FFin
    then begin
         If   FMesInicial<>FMesFinal
         then begin
              IncrementaMes( FMesActual );
              If   FMesActual=FMesFinal
              then FFin := True;
              end
         else Result := True;
         end
    else Result := True;
end;

procedure TSecuenciaMes.IncrementaMes( var FMesActual : Word );
begin
     Inc( FMesActual );
     If   FMesActual=13
     then FMesActual := 1
     else If   FMesActual=1
          then FMesActual := FSessionDataModule.NroMesInicial;
end;

end.
