{$ALIGN OFF}
{$OPTIMIZATION OFF}

unit ApunteIntf;

{ Este fichero ha sido generado automáticamente desde la utilidad de creación de interfaces
  de Gestwin (Gestión de tareas->Procesos->Exportacion a ficheros). }

interface

uses  SysUtils,
      Classes,

      LibUtils,
      DataManager,

      nxllComponent,
      nxllTypes,
      nxivTypes,
      nxrdClass,
      nxrbTypes,
      nxsdTypes,
      nxrbVariantFiler,

      DB,
      SessionIntf,

      Gim10Fields;

const
  CLSID_Apunte : TnxGuid = '{8A7D383C-15A6-4B8E-A58C-5915A9EE201A}';

type

  IApunte = interface( IInvokableRecord )
    [ '{8FB0DA74-5EFC-451B-AEB3-3235EE89A27B}' ] 

    procedure ToDataset( ApunteFields : TApunteFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );
    function GetRemoteCursorID : TnxCursorID;
    procedure SetRemoteCursorID( const Value : TnxCursorID );
    function GetState : TDataSetState;
    procedure SetState( const Value : TDataSetState );

    // Los campos que forman parte de un índice es conveniente que no sean Variants.
    // El resto, sin embargo, pueden ser valores nulos, o el campo no estar definido en el dataset.

    function GetEjercicio : SmallInt;
    function GetNroAsiento : Integer;
    function GetNroApunte : SmallInt;
    function GetFecha : Variant;
    function GetSubcuenta : Variant;
    function GetCentroCoste : Variant;
    function GetCuentaAnalitica : Variant;
    function GetContrapartida : Variant;
    function GetConcepto : Variant;
    function GetDebe : Variant;
    function GetHaber : Variant;
    function GetTipoApunte : Variant;
    function GetPunteo : Variant;
    function GetEjercicioFactura : Variant;
    function GetSerie : Variant;
    function GetPropietario : Variant;
    function GetNroFactura : Variant;
    function GetNroEfecto : Variant;
    function GetBaseImponible : Variant;
    function GetTipo : Variant;
    function GetCuotaIVA : Variant;
    function GetCuotaRE : Variant;
    function GetImporteTotal : Variant;

    procedure SetEjercicio( const Value  : SmallInt );
    procedure SetNroAsiento( const Value  : Integer );
    procedure SetNroApunte( const Value  : SmallInt );
    procedure SetFecha( const Value  : Variant );
    procedure SetSubcuenta( const Value  : Variant );
    procedure SetCentroCoste( const Value  : Variant );
    procedure SetCuentaAnalitica( const Value  : Variant );
    procedure SetContrapartida( const Value  : Variant );
    procedure SetConcepto( const Value  : Variant );
    procedure SetDebe( const Value  : Variant );
    procedure SetHaber( const Value  : Variant );
    procedure SetTipoApunte( const Value  : Variant );
    procedure SetPunteo( const Value  : Variant );
    procedure SetEjercicioFactura( const Value  : Variant );
    procedure SetSerie( const Value  : Variant );
    procedure SetPropietario( const Value  : Variant );
    procedure SetNroFactura( const Value  : Variant );
    procedure SetNroEfecto( const Value  : Variant );
    procedure SetBaseImponible( const Value  : Variant );
    procedure SetTipo( const Value  : Variant );
    procedure SetCuotaIVA( const Value  : Variant );
    procedure SetCuotaRE( const Value  : Variant );
    procedure SetImporteTotal( const Value  : Variant );
    property RemoteCursorID : TnxCursorID read GetRemoteCursorID write SetRemoteCursorID;
    property State : TDatasetState read GetState write SetState;

    property Ejercicio : SmallInt read GetEjercicio write SetEjercicio;
    property NroAsiento : Integer read GetNroAsiento write SetNroAsiento;
    property NroApunte : SmallInt read GetNroApunte write SetNroApunte;
    property Fecha : Variant read GetFecha write SetFecha;
    property Subcuenta : Variant read GetSubcuenta write SetSubcuenta;
    property CentroCoste : Variant read GetCentroCoste write SetCentroCoste;
    property CuentaAnalitica : Variant read GetCuentaAnalitica write SetCuentaAnalitica;
    property Contrapartida : Variant read GetContrapartida write SetContrapartida;
    property Concepto : Variant read GetConcepto write SetConcepto;
    property Debe : Variant read GetDebe write SetDebe;
    property Haber : Variant read GetHaber write SetHaber;
    property TipoApunte : Variant read GetTipoApunte write SetTipoApunte;
    property Punteo : Variant read GetPunteo write SetPunteo;
    property EjercicioFactura : Variant read GetEjercicioFactura write SetEjercicioFactura;
    property Serie : Variant read GetSerie write SetSerie;
    property Propietario : Variant read GetPropietario write SetPropietario;
    property NroFactura : Variant read GetNroFactura write SetNroFactura;
    property NroEfecto : Variant read GetNroEfecto write SetNroEfecto;
    property BaseImponible : Variant read GetBaseImponible write SetBaseImponible;
    property Tipo : Variant read GetTipo write SetTipo;
    property CuotaIVA : Variant read GetCuotaIVA write SetCuotaIVA;
    property CuotaRE : Variant read GetCuotaRE write SetCuotaRE;
    property ImporteTotal : Variant read GetImporteTotal write SetImporteTotal;

    end;

   TApunte = class( TnxClass, InxRemoteableClass, IApunte)
     private

     FRemoteCursorID,
     FState : Variant;

     FEjercicio,
     FNroAsiento,
     FNroApunte,
     FFecha,
     FSubcuenta,
     FCentroCoste,
     FCuentaAnalitica,
     FContrapartida,
     FConcepto,
     FDebe,
     FHaber,
     FTipoApunte,
     FPunteo,
     FEjercicioFactura,
     FSerie,
     FPropietario,
     FNroFactura,
     FNroEfecto,
     FBaseImponible,
     FTipo,
     FCuotaIVA,
     FCuotaRE,
     FImporteTotal : Variant;

     function GetEjercicio : SmallInt;
     function GetNroAsiento : Integer;
     function GetNroApunte : SmallInt;
     function GetFecha : Variant;
     function GetSubcuenta : Variant;
     function GetCentroCoste : Variant;
     function GetCuentaAnalitica : Variant;
     function GetContrapartida : Variant;
     function GetConcepto : Variant;
     function GetDebe : Variant;
     function GetHaber : Variant;
     function GetTipoApunte : Variant;
     function GetPunteo : Variant;
     function GetEjercicioFactura : Variant;
     function GetSerie : Variant;
     function GetPropietario : Variant;
     function GetNroFactura : Variant;
     function GetNroEfecto : Variant;
     function GetBaseImponible : Variant;
     function GetTipo : Variant;
     function GetCuotaIVA : Variant;
     function GetCuotaRE : Variant;
     function GetImporteTotal : Variant;

     procedure SetEjercicio( const Value  : SmallInt );
     procedure SetNroAsiento( const Value  : Integer );
     procedure SetNroApunte( const Value  : SmallInt );
     procedure SetFecha( const Value  : Variant );
     procedure SetSubcuenta( const Value  : Variant );
     procedure SetCentroCoste( const Value  : Variant );
     procedure SetCuentaAnalitica( const Value  : Variant );
     procedure SetContrapartida( const Value  : Variant );
     procedure SetConcepto( const Value  : Variant );
     procedure SetDebe( const Value  : Variant );
     procedure SetHaber( const Value  : Variant );
     procedure SetTipoApunte( const Value  : Variant );
     procedure SetPunteo( const Value  : Variant );
     procedure SetEjercicioFactura( const Value  : Variant );
     procedure SetSerie( const Value  : Variant );
     procedure SetPropietario( const Value  : Variant );
     procedure SetNroFactura( const Value  : Variant );
     procedure SetNroEfecto( const Value  : Variant );
     procedure SetBaseImponible( const Value  : Variant );
     procedure SetTipo( const Value  : Variant );
     procedure SetCuotaIVA( const Value  : Variant );
     procedure SetCuotaRE( const Value  : Variant );
     procedure SetImporteTotal( const Value  : Variant );

     function LoadFromReader( AReader : InxReader ) : HRESULT;
     function SaveToWriter( AWriter : InxWriter ) : HRESULT;

     function GetRemoteCursorID : TnxCursorID;
     procedure SetRemoteCursorID( const Value : TnxCursorID );
     function GetState : TDataSetState;
     procedure SetState( const Value : TDataSetState );
     function GetClassID : TnxGuid;

     public

     constructor Create; reintroduce;

     class function FromDataset( ApunteFields  : TApunteFields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : IApunte;
     procedure ToDataset( ApunteFields : TApunteFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );

     end;

implementation

uses  Variants;

{ TApunte }

constructor TApunte.Create;
begin
     inherited Create( @CLSID_Apunte, nil, nil, False);
     FState := dsInsert;
end;

class function TApunte.FromDataset( ApunteFields : TApunteFields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : IApunte;

var   SaveState : TDataSetState;
      ApplyOldValues : Boolean;

begin
      Result := TApunte.Create;

      With Result do
        begin

        RemoteCursorID := ApunteFields.GetRemoteCursorID;
        State := ApunteFields.Dataset.State;
        SaveState := State;

        ApplyOldValues := OldValues and not ( State in [ dsInsert, dsSetKey ] );
        If   ApplyOldValues
        then ApunteFields.IDataset.SetTempState( dsOldValue );

        try

          Ejercicio := GetFieldAsVariant( ApunteFields.Ejercicio );
          NroAsiento := GetFieldAsVariant( ApunteFields.NroAsiento );
          NroApunte := GetFieldAsVariant( ApunteFields.NroApunte );
          Fecha := GetFieldAsVariant( ApunteFields.Fecha );
          Subcuenta := GetFieldAsVariant( ApunteFields.Subcuenta );
          CentroCoste := GetFieldAsVariant( ApunteFields.CentroCoste );
          CuentaAnalitica := GetFieldAsVariant( ApunteFields.CuentaAnalitica );
          Contrapartida := GetFieldAsVariant( ApunteFields.Contrapartida );
          Concepto := GetFieldAsVariant( ApunteFields.Concepto );
          Debe := GetFieldAsVariant( ApunteFields.Debe );
          Haber := GetFieldAsVariant( ApunteFields.Haber );
          TipoApunte := GetFieldAsVariant( ApunteFields.TipoApunte );
          Punteo := GetFieldAsVariant( ApunteFields.Punteo );
          EjercicioFactura := GetFieldAsVariant( ApunteFields.EjercicioFactura );
          Serie := GetFieldAsVariant( ApunteFields.Serie );
          Propietario := GetFieldAsVariant( ApunteFields.Propietario );
          NroFactura := GetFieldAsVariant( ApunteFields.NroFactura );
          NroEfecto := GetFieldAsVariant( ApunteFields.NroEfecto );
          BaseImponible := GetFieldAsVariant( ApunteFields.BaseImponible );
          Tipo := GetFieldAsVariant( ApunteFields.Tipo );
          CuotaIVA := GetFieldAsVariant( ApunteFields.CuotaIVA );
          CuotaRE := GetFieldAsVariant( ApunteFields.CuotaRE );
          ImporteTotal := GetFieldAsVariant( ApunteFields.ImporteTotal );

        finally
          If   ApplyOldValues
          then ApunteFields.IDataset.RestoreState( SaveState );
        end;
      end;

end;

procedure TApunte.ToDataset( ApunteFields : TApunteFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );
begin
     try

       If   not PreserveState
       then ApunteFields.SetStateFromInterface( FState );

       ApunteFields.Ejercicio.Value := FEjercicio;
       ApunteFields.NroAsiento.Value := FNroAsiento;
       ApunteFields.NroApunte.Value := FNroApunte;

       SetFieldAsVariant( ApunteFields.Fecha, FFecha );
       SetFieldAsVariant( ApunteFields.Subcuenta, FSubcuenta );
       SetFieldAsVariant( ApunteFields.CentroCoste, FCentroCoste );
       SetFieldAsVariant( ApunteFields.CuentaAnalitica, FCuentaAnalitica );
       SetFieldAsVariant( ApunteFields.Contrapartida, FContrapartida );
       SetFieldAsVariant( ApunteFields.Concepto, FConcepto );
       SetFieldAsVariant( ApunteFields.Debe, FDebe );
       SetFieldAsVariant( ApunteFields.Haber, FHaber );
       SetFieldAsVariant( ApunteFields.TipoApunte, FTipoApunte );
       SetFieldAsVariant( ApunteFields.Punteo, FPunteo );
       SetFieldAsVariant( ApunteFields.EjercicioFactura, FEjercicioFactura );
       SetFieldAsVariant( ApunteFields.Serie, FSerie );
       SetFieldAsVariant( ApunteFields.Propietario, FPropietario );
       SetFieldAsVariant( ApunteFields.NroFactura, FNroFactura );
       SetFieldAsVariant( ApunteFields.NroEfecto, FNroEfecto );
       SetFieldAsVariant( ApunteFields.BaseImponible, FBaseImponible );
       SetFieldAsVariant( ApunteFields.Tipo, FTipo );
       SetFieldAsVariant( ApunteFields.CuotaIVA, FCuotaIVA );
       SetFieldAsVariant( ApunteFields.CuotaRE, FCuotaRE );
       SetFieldAsVariant( ApunteFields.ImporteTotal, FImporteTotal );

     except
       ApunteFields.Dataset.Cancel;
       raise;
       end;

end;

function TApunte.LoadFromReader( AReader : InxReader ) : HRESULT;

var VarFlags : TnxVarFlags;

begin
     nxReadVariant( VarFlags, FRemoteCursorID, AReader );
     nxReadVariant( VarFlags, FState, AReader );

     nxReadVariant( VarFlags, FEjercicio, AReader );
     nxReadVariant( VarFlags, FNroAsiento, AReader );
     nxReadVariant( VarFlags, FNroApunte, AReader );
     nxReadVariant( VarFlags, FFecha, AReader );
     nxReadVariant( VarFlags, FSubcuenta, AReader );
     nxReadVariant( VarFlags, FCentroCoste, AReader );
     nxReadVariant( VarFlags, FCuentaAnalitica, AReader );
     nxReadVariant( VarFlags, FContrapartida, AReader );
     nxReadVariant( VarFlags, FConcepto, AReader );
     nxReadVariant( VarFlags, FDebe, AReader );
     nxReadVariant( VarFlags, FHaber, AReader );
     nxReadVariant( VarFlags, FTipoApunte, AReader );
     nxReadVariant( VarFlags, FPunteo, AReader );
     nxReadVariant( VarFlags, FEjercicioFactura, AReader );
     nxReadVariant( VarFlags, FSerie, AReader );
     nxReadVariant( VarFlags, FPropietario, AReader );
     nxReadVariant( VarFlags, FNroFactura, AReader );
     nxReadVariant( VarFlags, FNroEfecto, AReader );
     nxReadVariant( VarFlags, FBaseImponible, AReader );
     nxReadVariant( VarFlags, FTipo, AReader );
     nxReadVariant( VarFlags, FCuotaIVA, AReader );
     nxReadVariant( VarFlags, FCuotaRE, AReader );
     nxReadVariant( VarFlags, FImporteTotal, AReader );

     Result := S_OK;
end;

function TApunte.SaveToWriter( AWriter : InxWriter) : HRESULT;
begin
     nxWriteVariant( FRemoteCursorID, AWriter );
     nxWriteVariant( FState, AWriter );

     nxWriteVariant( FEjercicio, AWriter );
     nxWriteVariant( FNroAsiento, AWriter );
     nxWriteVariant( FNroApunte, AWriter );
     nxWriteVariant( FFecha, AWriter );
     nxWriteVariant( FSubcuenta, AWriter );
     nxWriteVariant( FCentroCoste, AWriter );
     nxWriteVariant( FCuentaAnalitica, AWriter );
     nxWriteVariant( FContrapartida, AWriter );
     nxWriteVariant( FConcepto, AWriter );
     nxWriteVariant( FDebe, AWriter );
     nxWriteVariant( FHaber, AWriter );
     nxWriteVariant( FTipoApunte, AWriter );
     nxWriteVariant( FPunteo, AWriter );
     nxWriteVariant( FEjercicioFactura, AWriter );
     nxWriteVariant( FSerie, AWriter );
     nxWriteVariant( FPropietario, AWriter );
     nxWriteVariant( FNroFactura, AWriter );
     nxWriteVariant( FNroEfecto, AWriter );
     nxWriteVariant( FBaseImponible, AWriter );
     nxWriteVariant( FTipo, AWriter );
     nxWriteVariant( FCuotaIVA, AWriter );
     nxWriteVariant( FCuotaRE, AWriter );
     nxWriteVariant( FImporteTotal, AWriter );
     Result := S_OK;
end;

{ Getters}

function TApunte.GetClassID: TnxGuid;
begin
     Result := CLSID_Apunte;
end;

function TApunte.GetRemoteCursorID: TnxCursorID;
begin
     Result := FRemoteCursorID;
end;

function TApunte.GetState: TDataSetState;
begin
     Result := FState;
end;


function TApunte.GetEjercicio : SmallInt;
begin
     Result := FEjercicio;
end;

function TApunte.GetNroAsiento : Integer;
begin
     Result := FNroAsiento;
end;

function TApunte.GetNroApunte : SmallInt;
begin
     Result := FNroApunte;
end;

function TApunte.GetFecha : Variant;
begin
     Result := FFecha;
end;

function TApunte.GetSubcuenta : Variant;
begin
     Result := FSubcuenta;
end;

function TApunte.GetCentroCoste : Variant;
begin
     Result := FCentroCoste;
end;

function TApunte.GetCuentaAnalitica : Variant;
begin
     Result := FCuentaAnalitica;
end;

function TApunte.GetContrapartida : Variant;
begin
     Result := FContrapartida;
end;

function TApunte.GetConcepto : Variant;
begin
     Result := FConcepto;
end;

function TApunte.GetDebe : Variant;
begin
     Result := FDebe;
end;

function TApunte.GetHaber : Variant;
begin
     Result := FHaber;
end;

function TApunte.GetTipoApunte : Variant;
begin
     Result := FTipoApunte;
end;

function TApunte.GetPunteo : Variant;
begin
     Result := FPunteo;
end;

function TApunte.GetEjercicioFactura : Variant;
begin
     Result := FEjercicioFactura;
end;

function TApunte.GetSerie : Variant;
begin
     Result := FSerie;
end;

function TApunte.GetPropietario : Variant;
begin
     Result := FPropietario;
end;

function TApunte.GetNroFactura : Variant;
begin
     Result := FNroFactura;
end;

function TApunte.GetNroEfecto : Variant;
begin
     Result := FNroEfecto;
end;

function TApunte.GetBaseImponible : Variant;
begin
     Result := FBaseImponible;
end;

function TApunte.GetTipo : Variant;
begin
     Result := FTipo;
end;

function TApunte.GetCuotaIVA : Variant;
begin
     Result := FCuotaIVA;
end;

function TApunte.GetCuotaRE : Variant;
begin
     Result := FCuotaRE;
end;

function TApunte.GetImporteTotal : Variant;
begin
     Result := FImporteTotal;
end;

{ Setters}

procedure TApunte.SetRemoteCursorID( const Value : TnxCursorID );
begin
     FRemoteCursorID := Value;
end;

procedure TApunte.SetState( const Value : TDataSetState );
begin
     FState := Value;
end;


procedure TApunte.SetEjercicio(  const Value : SmallInt );
begin
     FEjercicio := Value;
end;

procedure TApunte.SetNroAsiento(  const Value : Integer );
begin
     FNroAsiento := Value;
end;

procedure TApunte.SetNroApunte(  const Value : SmallInt );
begin
     FNroApunte := Value;
end;

procedure TApunte.SetFecha(  const Value : Variant );
begin
     FFecha := Value;
end;

procedure TApunte.SetSubcuenta(  const Value : Variant );
begin
     FSubcuenta := Value;
end;

procedure TApunte.SetCentroCoste(  const Value : Variant );
begin
     FCentroCoste := Value;
end;

procedure TApunte.SetCuentaAnalitica(  const Value : Variant );
begin
     FCuentaAnalitica := Value;
end;

procedure TApunte.SetContrapartida(  const Value : Variant );
begin
     FContrapartida := Value;
end;

procedure TApunte.SetConcepto(  const Value : Variant );
begin
     FConcepto := Value;
end;

procedure TApunte.SetDebe(  const Value : Variant );
begin
     FDebe := Value;
end;

procedure TApunte.SetHaber(  const Value : Variant );
begin
     FHaber := Value;
end;

procedure TApunte.SetTipoApunte(  const Value : Variant );
begin
     FTipoApunte := Value;
end;

procedure TApunte.SetPunteo(  const Value : Variant );
begin
     FPunteo := Value;
end;

procedure TApunte.SetEjercicioFactura(  const Value : Variant );
begin
     FEjercicioFactura := Value;
end;

procedure TApunte.SetSerie(  const Value : Variant );
begin
     FSerie := Value;
end;

procedure TApunte.SetPropietario(  const Value : Variant );
begin
     FPropietario := Value;
end;

procedure TApunte.SetNroFactura(  const Value : Variant );
begin
     FNroFactura := Value;
end;

procedure TApunte.SetNroEfecto(  const Value : Variant );
begin
     FNroEfecto := Value;
end;

procedure TApunte.SetBaseImponible(  const Value : Variant );
begin
     FBaseImponible := Value;
end;

procedure TApunte.SetTipo(  const Value : Variant );
begin
     FTipo := Value;
end;

procedure TApunte.SetCuotaIVA(  const Value : Variant );
begin
     FCuotaIVA := Value;
end;

procedure TApunte.SetCuotaRE(  const Value : Variant );
begin
     FCuotaRE := Value;
end;

procedure TApunte.SetImporteTotal(  const Value : Variant );
begin
     FImporteTotal := Value;
end;

var ApunteControl : InxClassFactoryControl;

initialization
   nxInvokeRegistry.RegisterInterface( TypeInfo( IApunte ) );

   TnxClassFactory.RegisterClass( CLSID_Apunte, TApunte, ApunteControl );

end.
