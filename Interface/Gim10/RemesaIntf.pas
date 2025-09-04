{$ALIGN OFF}
{$OPTIMIZATION OFF}

unit RemesaIntf;

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
  CLSID_Remesa : TnxGuid = '{4784D9CC-C95F-423A-B4DD-B9E530852879}';

type

  IRemesa = interface( IInvokableRecord )
    [ '{B3BED3FF-C0BD-4601-AAE5-99328D4555DE}' ] 

    procedure ToDataset( RemesaFields : TRemesaFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );
    function GetRemoteCursorID : TnxCursorID;
    procedure SetRemoteCursorID( const Value : TnxCursorID );
    function GetState : TDataSetState;
    procedure SetState( const Value : TDataSetState );

    // Los campos que forman parte de un índice es conveniente que no sean Variants.
    // El resto, sin embargo, pueden ser valores nulos, o el campo no estar definido en el dataset.

    function GetEjercicio : SmallInt;
    function GetNroRemesa : Integer;
    function GetFecha : Variant;
    function GetSubcuentaEntidad : Variant;
    function GetFechaVtoInicial : Variant;
    function GetFechaVtoFinal : Variant;
    function GetImporteGastos : Variant;
    function GetEstado : Variant;
    function GetTipoOrden : Variant;
    function GetCodigoOrden : Variant;
    function GetFechaCobro : Variant;
    function GetNroAsientoCobro : Variant;
    function GetFechaAceptacion : Variant;
    function GetNroAsientoAceptacion : Variant;
    function GetFechaDescuento : Variant;
    function GetNroAstoDescuento1 : Variant;
    function GetNroAstoDescuento2 : Variant;
    function GetFechaCancelacion : Variant;
    function GetNroAstoCancelacion : Variant;

    procedure SetEjercicio( const Value  : SmallInt );
    procedure SetNroRemesa( const Value  : Integer );
    procedure SetFecha( const Value  : Variant );
    procedure SetSubcuentaEntidad( const Value  : Variant );
    procedure SetFechaVtoInicial( const Value  : Variant );
    procedure SetFechaVtoFinal( const Value  : Variant );
    procedure SetImporteGastos( const Value  : Variant );
    procedure SetEstado( const Value  : Variant );
    procedure SetTipoOrden( const Value  : Variant );
    procedure SetCodigoOrden( const Value  : Variant );
    procedure SetFechaCobro( const Value  : Variant );
    procedure SetNroAsientoCobro( const Value  : Variant );
    procedure SetFechaAceptacion( const Value  : Variant );
    procedure SetNroAsientoAceptacion( const Value  : Variant );
    procedure SetFechaDescuento( const Value  : Variant );
    procedure SetNroAstoDescuento1( const Value  : Variant );
    procedure SetNroAstoDescuento2( const Value  : Variant );
    procedure SetFechaCancelacion( const Value  : Variant );
    procedure SetNroAstoCancelacion( const Value  : Variant );
    property RemoteCursorID : TnxCursorID read GetRemoteCursorID write SetRemoteCursorID;
    property State : TDatasetState read GetState write SetState;

    property Ejercicio : SmallInt read GetEjercicio write SetEjercicio;
    property NroRemesa : Integer read GetNroRemesa write SetNroRemesa;
    property Fecha : Variant read GetFecha write SetFecha;
    property SubcuentaEntidad : Variant read GetSubcuentaEntidad write SetSubcuentaEntidad;
    property FechaVtoInicial : Variant read GetFechaVtoInicial write SetFechaVtoInicial;
    property FechaVtoFinal : Variant read GetFechaVtoFinal write SetFechaVtoFinal;
    property ImporteGastos : Variant read GetImporteGastos write SetImporteGastos;
    property Estado : Variant read GetEstado write SetEstado;
    property TipoOrden : Variant read GetTipoOrden write SetTipoOrden;
    property CodigoOrden : Variant read GetCodigoOrden write SetCodigoOrden;
    property FechaCobro : Variant read GetFechaCobro write SetFechaCobro;
    property NroAsientoCobro : Variant read GetNroAsientoCobro write SetNroAsientoCobro;
    property FechaAceptacion : Variant read GetFechaAceptacion write SetFechaAceptacion;
    property NroAsientoAceptacion : Variant read GetNroAsientoAceptacion write SetNroAsientoAceptacion;
    property FechaDescuento : Variant read GetFechaDescuento write SetFechaDescuento;
    property NroAstoDescuento1 : Variant read GetNroAstoDescuento1 write SetNroAstoDescuento1;
    property NroAstoDescuento2 : Variant read GetNroAstoDescuento2 write SetNroAstoDescuento2;
    property FechaCancelacion : Variant read GetFechaCancelacion write SetFechaCancelacion;
    property NroAstoCancelacion : Variant read GetNroAstoCancelacion write SetNroAstoCancelacion;

    end;

   TRemesa = class( TnxClass, InxRemoteableClass, IRemesa)
     private

     FRemoteCursorID,
     FState : Variant;

     FEjercicio,
     FNroRemesa,
     FFecha,
     FSubcuentaEntidad,
     FFechaVtoInicial,
     FFechaVtoFinal,
     FImporteGastos,
     FEstado,
     FTipoOrden,
     FCodigoOrden,
     FFechaCobro,
     FNroAsientoCobro,
     FFechaAceptacion,
     FNroAsientoAceptacion,
     FFechaDescuento,
     FNroAstoDescuento1,
     FNroAstoDescuento2,
     FFechaCancelacion,
     FNroAstoCancelacion : Variant;

     function GetEjercicio : SmallInt;
     function GetNroRemesa : Integer;
     function GetFecha : Variant;
     function GetSubcuentaEntidad : Variant;
     function GetFechaVtoInicial : Variant;
     function GetFechaVtoFinal : Variant;
     function GetImporteGastos : Variant;
     function GetEstado : Variant;
     function GetTipoOrden : Variant;
     function GetCodigoOrden : Variant;
     function GetFechaCobro : Variant;
     function GetNroAsientoCobro : Variant;
     function GetFechaAceptacion : Variant;
     function GetNroAsientoAceptacion : Variant;
     function GetFechaDescuento : Variant;
     function GetNroAstoDescuento1 : Variant;
     function GetNroAstoDescuento2 : Variant;
     function GetFechaCancelacion : Variant;
     function GetNroAstoCancelacion : Variant;

     procedure SetEjercicio( const Value  : SmallInt );
     procedure SetNroRemesa( const Value  : Integer );
     procedure SetFecha( const Value  : Variant );
     procedure SetSubcuentaEntidad( const Value  : Variant );
     procedure SetFechaVtoInicial( const Value  : Variant );
     procedure SetFechaVtoFinal( const Value  : Variant );
     procedure SetImporteGastos( const Value  : Variant );
     procedure SetEstado( const Value  : Variant );
     procedure SetTipoOrden( const Value  : Variant );
     procedure SetCodigoOrden( const Value  : Variant );
     procedure SetFechaCobro( const Value  : Variant );
     procedure SetNroAsientoCobro( const Value  : Variant );
     procedure SetFechaAceptacion( const Value  : Variant );
     procedure SetNroAsientoAceptacion( const Value  : Variant );
     procedure SetFechaDescuento( const Value  : Variant );
     procedure SetNroAstoDescuento1( const Value  : Variant );
     procedure SetNroAstoDescuento2( const Value  : Variant );
     procedure SetFechaCancelacion( const Value  : Variant );
     procedure SetNroAstoCancelacion( const Value  : Variant );

     function LoadFromReader( AReader : InxReader ) : HRESULT;
     function SaveToWriter( AWriter : InxWriter ) : HRESULT;

     function GetRemoteCursorID : TnxCursorID;
     procedure SetRemoteCursorID( const Value : TnxCursorID );
     function GetState : TDataSetState;
     procedure SetState( const Value : TDataSetState );
     function GetClassID : TnxGuid;

     public

     constructor Create; reintroduce;

     class function FromDataset( RemesaFields  : TRemesaFields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : IRemesa;
     procedure ToDataset( RemesaFields : TRemesaFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );

     end;

implementation

uses  Variants;

{ TRemesa }

constructor TRemesa.Create;
begin
     inherited Create( @CLSID_Remesa, nil, nil, False);
     FState := dsInsert;
end;

class function TRemesa.FromDataset( RemesaFields : TRemesaFields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : IRemesa;

var   SaveState : TDataSetState;
      ApplyOldValues : Boolean;

begin
      Result := TRemesa.Create;

      With Result do
        begin

        RemoteCursorID := RemesaFields.GetRemoteCursorID;
        State := RemesaFields.Dataset.State;
        SaveState := State;

        ApplyOldValues := OldValues and not ( State in [ dsInsert, dsSetKey ] );
        If   ApplyOldValues
        then RemesaFields.IDataset.SetTempState( dsOldValue );

        try

          Ejercicio := GetFieldAsVariant( RemesaFields.Ejercicio );
          NroRemesa := GetFieldAsVariant( RemesaFields.NroRemesa );
          Fecha := GetFieldAsVariant( RemesaFields.Fecha );
          SubcuentaEntidad := GetFieldAsVariant( RemesaFields.SubcuentaEntidad );
          FechaVtoInicial := GetFieldAsVariant( RemesaFields.FechaVtoInicial );
          FechaVtoFinal := GetFieldAsVariant( RemesaFields.FechaVtoFinal );
          ImporteGastos := GetFieldAsVariant( RemesaFields.ImporteGastos );
          Estado := GetFieldAsVariant( RemesaFields.Estado );
          TipoOrden := GetFieldAsVariant( RemesaFields.TipoOrden );
          CodigoOrden := GetFieldAsVariant( RemesaFields.CodigoOrden );
          FechaCobro := GetFieldAsVariant( RemesaFields.FechaCobro );
          NroAsientoCobro := GetFieldAsVariant( RemesaFields.NroAsientoCobro );
          FechaAceptacion := GetFieldAsVariant( RemesaFields.FechaAceptacion );
          NroAsientoAceptacion := GetFieldAsVariant( RemesaFields.NroAsientoAceptacion );
          FechaDescuento := GetFieldAsVariant( RemesaFields.FechaDescuento );
          NroAstoDescuento1 := GetFieldAsVariant( RemesaFields.NroAstoDescuento1 );
          NroAstoDescuento2 := GetFieldAsVariant( RemesaFields.NroAstoDescuento2 );
          FechaCancelacion := GetFieldAsVariant( RemesaFields.FechaCancelacion );
          NroAstoCancelacion := GetFieldAsVariant( RemesaFields.NroAstoCancelacion );

        finally
          If   ApplyOldValues
          then RemesaFields.IDataset.RestoreState( SaveState );
        end;
      end;

end;

procedure TRemesa.ToDataset( RemesaFields : TRemesaFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );
begin
     try

       If   not PreserveState
       then RemesaFields.SetStateFromInterface( FState );

       RemesaFields.Ejercicio.Value := FEjercicio;
       RemesaFields.NroRemesa.Value := FNroRemesa;

       SetFieldAsVariant( RemesaFields.Fecha, FFecha );
       SetFieldAsVariant( RemesaFields.SubcuentaEntidad, FSubcuentaEntidad );
       SetFieldAsVariant( RemesaFields.FechaVtoInicial, FFechaVtoInicial );
       SetFieldAsVariant( RemesaFields.FechaVtoFinal, FFechaVtoFinal );
       SetFieldAsVariant( RemesaFields.ImporteGastos, FImporteGastos );
       SetFieldAsVariant( RemesaFields.Estado, FEstado );
       SetFieldAsVariant( RemesaFields.TipoOrden, FTipoOrden );
       SetFieldAsVariant( RemesaFields.CodigoOrden, FCodigoOrden );
       SetFieldAsVariant( RemesaFields.FechaCobro, FFechaCobro );
       SetFieldAsVariant( RemesaFields.NroAsientoCobro, FNroAsientoCobro );
       SetFieldAsVariant( RemesaFields.FechaAceptacion, FFechaAceptacion );
       SetFieldAsVariant( RemesaFields.NroAsientoAceptacion, FNroAsientoAceptacion );
       SetFieldAsVariant( RemesaFields.FechaDescuento, FFechaDescuento );
       SetFieldAsVariant( RemesaFields.NroAstoDescuento1, FNroAstoDescuento1 );
       SetFieldAsVariant( RemesaFields.NroAstoDescuento2, FNroAstoDescuento2 );
       SetFieldAsVariant( RemesaFields.FechaCancelacion, FFechaCancelacion );
       SetFieldAsVariant( RemesaFields.NroAstoCancelacion, FNroAstoCancelacion );

     except
       RemesaFields.Dataset.Cancel;
       raise;
       end;

end;

function TRemesa.LoadFromReader( AReader : InxReader ) : HRESULT;

var VarFlags : TnxVarFlags;

begin
     nxReadVariant( VarFlags, FRemoteCursorID, AReader );
     nxReadVariant( VarFlags, FState, AReader );

     nxReadVariant( VarFlags, FEjercicio, AReader );
     nxReadVariant( VarFlags, FNroRemesa, AReader );
     nxReadVariant( VarFlags, FFecha, AReader );
     nxReadVariant( VarFlags, FSubcuentaEntidad, AReader );
     nxReadVariant( VarFlags, FFechaVtoInicial, AReader );
     nxReadVariant( VarFlags, FFechaVtoFinal, AReader );
     nxReadVariant( VarFlags, FImporteGastos, AReader );
     nxReadVariant( VarFlags, FEstado, AReader );
     nxReadVariant( VarFlags, FTipoOrden, AReader );
     nxReadVariant( VarFlags, FCodigoOrden, AReader );
     nxReadVariant( VarFlags, FFechaCobro, AReader );
     nxReadVariant( VarFlags, FNroAsientoCobro, AReader );
     nxReadVariant( VarFlags, FFechaAceptacion, AReader );
     nxReadVariant( VarFlags, FNroAsientoAceptacion, AReader );
     nxReadVariant( VarFlags, FFechaDescuento, AReader );
     nxReadVariant( VarFlags, FNroAstoDescuento1, AReader );
     nxReadVariant( VarFlags, FNroAstoDescuento2, AReader );
     nxReadVariant( VarFlags, FFechaCancelacion, AReader );
     nxReadVariant( VarFlags, FNroAstoCancelacion, AReader );

     Result := S_OK;
end;

function TRemesa.SaveToWriter( AWriter : InxWriter) : HRESULT;
begin
     nxWriteVariant( FRemoteCursorID, AWriter );
     nxWriteVariant( FState, AWriter );

     nxWriteVariant( FEjercicio, AWriter );
     nxWriteVariant( FNroRemesa, AWriter );
     nxWriteVariant( FFecha, AWriter );
     nxWriteVariant( FSubcuentaEntidad, AWriter );
     nxWriteVariant( FFechaVtoInicial, AWriter );
     nxWriteVariant( FFechaVtoFinal, AWriter );
     nxWriteVariant( FImporteGastos, AWriter );
     nxWriteVariant( FEstado, AWriter );
     nxWriteVariant( FTipoOrden, AWriter );
     nxWriteVariant( FCodigoOrden, AWriter );
     nxWriteVariant( FFechaCobro, AWriter );
     nxWriteVariant( FNroAsientoCobro, AWriter );
     nxWriteVariant( FFechaAceptacion, AWriter );
     nxWriteVariant( FNroAsientoAceptacion, AWriter );
     nxWriteVariant( FFechaDescuento, AWriter );
     nxWriteVariant( FNroAstoDescuento1, AWriter );
     nxWriteVariant( FNroAstoDescuento2, AWriter );
     nxWriteVariant( FFechaCancelacion, AWriter );
     nxWriteVariant( FNroAstoCancelacion, AWriter );
     Result := S_OK;
end;

{ Getters}

function TRemesa.GetClassID: TnxGuid;
begin
     Result := CLSID_Remesa;
end;

function TRemesa.GetRemoteCursorID: TnxCursorID;
begin
     Result := FRemoteCursorID;
end;

function TRemesa.GetState: TDataSetState;
begin
     Result := FState;
end;


function TRemesa.GetEjercicio : SmallInt;
begin
     Result := FEjercicio;
end;

function TRemesa.GetNroRemesa : Integer;
begin
     Result := FNroRemesa;
end;

function TRemesa.GetFecha : Variant;
begin
     Result := FFecha;
end;

function TRemesa.GetSubcuentaEntidad : Variant;
begin
     Result := FSubcuentaEntidad;
end;

function TRemesa.GetFechaVtoInicial : Variant;
begin
     Result := FFechaVtoInicial;
end;

function TRemesa.GetFechaVtoFinal : Variant;
begin
     Result := FFechaVtoFinal;
end;

function TRemesa.GetImporteGastos : Variant;
begin
     Result := FImporteGastos;
end;

function TRemesa.GetEstado : Variant;
begin
     Result := FEstado;
end;

function TRemesa.GetTipoOrden : Variant;
begin
     Result := FTipoOrden;
end;

function TRemesa.GetCodigoOrden : Variant;
begin
     Result := FCodigoOrden;
end;

function TRemesa.GetFechaCobro : Variant;
begin
     Result := FFechaCobro;
end;

function TRemesa.GetNroAsientoCobro : Variant;
begin
     Result := FNroAsientoCobro;
end;

function TRemesa.GetFechaAceptacion : Variant;
begin
     Result := FFechaAceptacion;
end;

function TRemesa.GetNroAsientoAceptacion : Variant;
begin
     Result := FNroAsientoAceptacion;
end;

function TRemesa.GetFechaDescuento : Variant;
begin
     Result := FFechaDescuento;
end;

function TRemesa.GetNroAstoDescuento1 : Variant;
begin
     Result := FNroAstoDescuento1;
end;

function TRemesa.GetNroAstoDescuento2 : Variant;
begin
     Result := FNroAstoDescuento2;
end;

function TRemesa.GetFechaCancelacion : Variant;
begin
     Result := FFechaCancelacion;
end;

function TRemesa.GetNroAstoCancelacion : Variant;
begin
     Result := FNroAstoCancelacion;
end;

{ Setters}

procedure TRemesa.SetRemoteCursorID( const Value : TnxCursorID );
begin
     FRemoteCursorID := Value;
end;

procedure TRemesa.SetState( const Value : TDataSetState );
begin
     FState := Value;
end;


procedure TRemesa.SetEjercicio(  const Value : SmallInt );
begin
     FEjercicio := Value;
end;

procedure TRemesa.SetNroRemesa(  const Value : Integer );
begin
     FNroRemesa := Value;
end;

procedure TRemesa.SetFecha(  const Value : Variant );
begin
     FFecha := Value;
end;

procedure TRemesa.SetSubcuentaEntidad(  const Value : Variant );
begin
     FSubcuentaEntidad := Value;
end;

procedure TRemesa.SetFechaVtoInicial(  const Value : Variant );
begin
     FFechaVtoInicial := Value;
end;

procedure TRemesa.SetFechaVtoFinal(  const Value : Variant );
begin
     FFechaVtoFinal := Value;
end;

procedure TRemesa.SetImporteGastos(  const Value : Variant );
begin
     FImporteGastos := Value;
end;

procedure TRemesa.SetEstado(  const Value : Variant );
begin
     FEstado := Value;
end;

procedure TRemesa.SetTipoOrden(  const Value : Variant );
begin
     FTipoOrden := Value;
end;

procedure TRemesa.SetCodigoOrden(  const Value : Variant );
begin
     FCodigoOrden := Value;
end;

procedure TRemesa.SetFechaCobro(  const Value : Variant );
begin
     FFechaCobro := Value;
end;

procedure TRemesa.SetNroAsientoCobro(  const Value : Variant );
begin
     FNroAsientoCobro := Value;
end;

procedure TRemesa.SetFechaAceptacion(  const Value : Variant );
begin
     FFechaAceptacion := Value;
end;

procedure TRemesa.SetNroAsientoAceptacion(  const Value : Variant );
begin
     FNroAsientoAceptacion := Value;
end;

procedure TRemesa.SetFechaDescuento(  const Value : Variant );
begin
     FFechaDescuento := Value;
end;

procedure TRemesa.SetNroAstoDescuento1(  const Value : Variant );
begin
     FNroAstoDescuento1 := Value;
end;

procedure TRemesa.SetNroAstoDescuento2(  const Value : Variant );
begin
     FNroAstoDescuento2 := Value;
end;

procedure TRemesa.SetFechaCancelacion(  const Value : Variant );
begin
     FFechaCancelacion := Value;
end;

procedure TRemesa.SetNroAstoCancelacion(  const Value : Variant );
begin
     FNroAstoCancelacion := Value;
end;

var RemesaControl : InxClassFactoryControl;

initialization
   nxInvokeRegistry.RegisterInterface( TypeInfo( IRemesa ) );

   TnxClassFactory.RegisterClass( CLSID_Remesa, TRemesa, RemesaControl );

end.
