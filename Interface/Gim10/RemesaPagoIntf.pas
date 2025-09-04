{$ALIGN OFF}
{$OPTIMIZATION OFF}

unit RemesaPagoIntf;

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
  CLSID_RemesaPago : TnxGuid = '{9F48A173-FE85-4B90-AB90-72334A2FAA2E}';

type

  IRemesaPago = interface( IInvokableRecord )
    [ '{8B092AEA-7C72-43F0-B11B-4F5B47FD763A}' ] 

    procedure ToDataset( RemesaPagoFields : TRemesaPagoFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );
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
    function GetSubcuentaProveedor : Variant;
    function GetFechaVtoInicial : Variant;
    function GetFechaVtoFinal : Variant;
    function GetImporteGastos : Variant;
    function GetEstado : Variant;
    function GetTipoOrden : Variant;
    function GetCodigoOrden : Variant;
    function GetFechaPago : Variant;
    function GetNroAsientoPago : Variant;

    procedure SetEjercicio( const Value  : SmallInt );
    procedure SetNroRemesa( const Value  : Integer );
    procedure SetFecha( const Value  : Variant );
    procedure SetSubcuentaEntidad( const Value  : Variant );
    procedure SetSubcuentaProveedor( const Value  : Variant );
    procedure SetFechaVtoInicial( const Value  : Variant );
    procedure SetFechaVtoFinal( const Value  : Variant );
    procedure SetImporteGastos( const Value  : Variant );
    procedure SetEstado( const Value  : Variant );
    procedure SetTipoOrden( const Value  : Variant );
    procedure SetCodigoOrden( const Value  : Variant );
    procedure SetFechaPago( const Value  : Variant );
    procedure SetNroAsientoPago( const Value  : Variant );
    property RemoteCursorID : TnxCursorID read GetRemoteCursorID write SetRemoteCursorID;
    property State : TDatasetState read GetState write SetState;

    property Ejercicio : SmallInt read GetEjercicio write SetEjercicio;
    property NroRemesa : Integer read GetNroRemesa write SetNroRemesa;
    property Fecha : Variant read GetFecha write SetFecha;
    property SubcuentaEntidad : Variant read GetSubcuentaEntidad write SetSubcuentaEntidad;
    property SubcuentaProveedor : Variant read GetSubcuentaProveedor write SetSubcuentaProveedor;
    property FechaVtoInicial : Variant read GetFechaVtoInicial write SetFechaVtoInicial;
    property FechaVtoFinal : Variant read GetFechaVtoFinal write SetFechaVtoFinal;
    property ImporteGastos : Variant read GetImporteGastos write SetImporteGastos;
    property Estado : Variant read GetEstado write SetEstado;
    property TipoOrden : Variant read GetTipoOrden write SetTipoOrden;
    property CodigoOrden : Variant read GetCodigoOrden write SetCodigoOrden;
    property FechaPago : Variant read GetFechaPago write SetFechaPago;
    property NroAsientoPago : Variant read GetNroAsientoPago write SetNroAsientoPago;

    end;

   TRemesaPago = class( TnxClass, InxRemoteableClass, IRemesaPago)
     private

     FRemoteCursorID,
     FState : Variant;

     FEjercicio,
     FNroRemesa,
     FFecha,
     FSubcuentaEntidad,
     FSubcuentaProveedor,
     FFechaVtoInicial,
     FFechaVtoFinal,
     FImporteGastos,
     FEstado,
     FTipoOrden,
     FCodigoOrden,
     FFechaPago,
     FNroAsientoPago : Variant;

     function GetEjercicio : SmallInt;
     function GetNroRemesa : Integer;
     function GetFecha : Variant;
     function GetSubcuentaEntidad : Variant;
     function GetSubcuentaProveedor : Variant;
     function GetFechaVtoInicial : Variant;
     function GetFechaVtoFinal : Variant;
     function GetImporteGastos : Variant;
     function GetEstado : Variant;
     function GetTipoOrden : Variant;
     function GetCodigoOrden : Variant;
     function GetFechaPago : Variant;
     function GetNroAsientoPago : Variant;

     procedure SetEjercicio( const Value  : SmallInt );
     procedure SetNroRemesa( const Value  : Integer );
     procedure SetFecha( const Value  : Variant );
     procedure SetSubcuentaEntidad( const Value  : Variant );
     procedure SetSubcuentaProveedor( const Value  : Variant );
     procedure SetFechaVtoInicial( const Value  : Variant );
     procedure SetFechaVtoFinal( const Value  : Variant );
     procedure SetImporteGastos( const Value  : Variant );
     procedure SetEstado( const Value  : Variant );
     procedure SetTipoOrden( const Value  : Variant );
     procedure SetCodigoOrden( const Value  : Variant );
     procedure SetFechaPago( const Value  : Variant );
     procedure SetNroAsientoPago( const Value  : Variant );

     function LoadFromReader( AReader : InxReader ) : HRESULT;
     function SaveToWriter( AWriter : InxWriter ) : HRESULT;

     function GetRemoteCursorID : TnxCursorID;
     procedure SetRemoteCursorID( const Value : TnxCursorID );
     function GetState : TDataSetState;
     procedure SetState( const Value : TDataSetState );
     function GetClassID : TnxGuid;

     public

     constructor Create; reintroduce;

     class function FromDataset( RemesaPagoFields  : TRemesaPagoFields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : IRemesaPago;
     procedure ToDataset( RemesaPagoFields : TRemesaPagoFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );

     end;

implementation

uses  Variants;

{ TRemesaPago }

constructor TRemesaPago.Create;
begin
     inherited Create( @CLSID_RemesaPago, nil, nil, False);
     FState := dsInsert;
end;

class function TRemesaPago.FromDataset( RemesaPagoFields : TRemesaPagoFields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : IRemesaPago;

var   SaveState : TDataSetState;
      ApplyOldValues : Boolean;

begin
      Result := TRemesaPago.Create;

      With Result do
        begin

        RemoteCursorID := RemesaPagoFields.GetRemoteCursorID;
        State := RemesaPagoFields.Dataset.State;
        SaveState := State;

        ApplyOldValues := OldValues and not ( State in [ dsInsert, dsSetKey ] );
        If   ApplyOldValues
        then RemesaPagoFields.IDataset.SetTempState( dsOldValue );

        try

          Ejercicio := GetFieldAsVariant( RemesaPagoFields.Ejercicio );
          NroRemesa := GetFieldAsVariant( RemesaPagoFields.NroRemesa );
          Fecha := GetFieldAsVariant( RemesaPagoFields.Fecha );
          SubcuentaEntidad := GetFieldAsVariant( RemesaPagoFields.SubcuentaEntidad );
          SubcuentaProveedor := GetFieldAsVariant( RemesaPagoFields.SubcuentaProveedor );
          FechaVtoInicial := GetFieldAsVariant( RemesaPagoFields.FechaVtoInicial );
          FechaVtoFinal := GetFieldAsVariant( RemesaPagoFields.FechaVtoFinal );
          ImporteGastos := GetFieldAsVariant( RemesaPagoFields.ImporteGastos );
          Estado := GetFieldAsVariant( RemesaPagoFields.Estado );
          TipoOrden := GetFieldAsVariant( RemesaPagoFields.TipoOrden );
          CodigoOrden := GetFieldAsVariant( RemesaPagoFields.CodigoOrden );
          FechaPago := GetFieldAsVariant( RemesaPagoFields.FechaPago );
          NroAsientoPago := GetFieldAsVariant( RemesaPagoFields.NroAsientoPago );

        finally
          If   ApplyOldValues
          then RemesaPagoFields.IDataset.RestoreState( SaveState );
        end;
      end;

end;

procedure TRemesaPago.ToDataset( RemesaPagoFields : TRemesaPagoFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );
begin
     try

       If   not PreserveState
       then RemesaPagoFields.SetStateFromInterface( FState );

       RemesaPagoFields.Ejercicio.Value := FEjercicio;
       RemesaPagoFields.NroRemesa.Value := FNroRemesa;

       SetFieldAsVariant( RemesaPagoFields.Fecha, FFecha );
       SetFieldAsVariant( RemesaPagoFields.SubcuentaEntidad, FSubcuentaEntidad );
       SetFieldAsVariant( RemesaPagoFields.SubcuentaProveedor, FSubcuentaProveedor );
       SetFieldAsVariant( RemesaPagoFields.FechaVtoInicial, FFechaVtoInicial );
       SetFieldAsVariant( RemesaPagoFields.FechaVtoFinal, FFechaVtoFinal );
       SetFieldAsVariant( RemesaPagoFields.ImporteGastos, FImporteGastos );
       SetFieldAsVariant( RemesaPagoFields.Estado, FEstado );
       SetFieldAsVariant( RemesaPagoFields.TipoOrden, FTipoOrden );
       SetFieldAsVariant( RemesaPagoFields.CodigoOrden, FCodigoOrden );
       SetFieldAsVariant( RemesaPagoFields.FechaPago, FFechaPago );
       SetFieldAsVariant( RemesaPagoFields.NroAsientoPago, FNroAsientoPago );

     except
       RemesaPagoFields.Dataset.Cancel;
       raise;
       end;

end;

function TRemesaPago.LoadFromReader( AReader : InxReader ) : HRESULT;

var VarFlags : TnxVarFlags;

begin
     nxReadVariant( VarFlags, FRemoteCursorID, AReader );
     nxReadVariant( VarFlags, FState, AReader );

     nxReadVariant( VarFlags, FEjercicio, AReader );
     nxReadVariant( VarFlags, FNroRemesa, AReader );
     nxReadVariant( VarFlags, FFecha, AReader );
     nxReadVariant( VarFlags, FSubcuentaEntidad, AReader );
     nxReadVariant( VarFlags, FSubcuentaProveedor, AReader );
     nxReadVariant( VarFlags, FFechaVtoInicial, AReader );
     nxReadVariant( VarFlags, FFechaVtoFinal, AReader );
     nxReadVariant( VarFlags, FImporteGastos, AReader );
     nxReadVariant( VarFlags, FEstado, AReader );
     nxReadVariant( VarFlags, FTipoOrden, AReader );
     nxReadVariant( VarFlags, FCodigoOrden, AReader );
     nxReadVariant( VarFlags, FFechaPago, AReader );
     nxReadVariant( VarFlags, FNroAsientoPago, AReader );

     Result := S_OK;
end;

function TRemesaPago.SaveToWriter( AWriter : InxWriter) : HRESULT;
begin
     nxWriteVariant( FRemoteCursorID, AWriter );
     nxWriteVariant( FState, AWriter );

     nxWriteVariant( FEjercicio, AWriter );
     nxWriteVariant( FNroRemesa, AWriter );
     nxWriteVariant( FFecha, AWriter );
     nxWriteVariant( FSubcuentaEntidad, AWriter );
     nxWriteVariant( FSubcuentaProveedor, AWriter );
     nxWriteVariant( FFechaVtoInicial, AWriter );
     nxWriteVariant( FFechaVtoFinal, AWriter );
     nxWriteVariant( FImporteGastos, AWriter );
     nxWriteVariant( FEstado, AWriter );
     nxWriteVariant( FTipoOrden, AWriter );
     nxWriteVariant( FCodigoOrden, AWriter );
     nxWriteVariant( FFechaPago, AWriter );
     nxWriteVariant( FNroAsientoPago, AWriter );
     Result := S_OK;
end;

{ Getters}

function TRemesaPago.GetClassID: TnxGuid;
begin
     Result := CLSID_RemesaPago;
end;

function TRemesaPago.GetRemoteCursorID: TnxCursorID;
begin
     Result := FRemoteCursorID;
end;

function TRemesaPago.GetState: TDataSetState;
begin
     Result := FState;
end;


function TRemesaPago.GetEjercicio : SmallInt;
begin
     Result := FEjercicio;
end;

function TRemesaPago.GetNroRemesa : Integer;
begin
     Result := FNroRemesa;
end;

function TRemesaPago.GetFecha : Variant;
begin
     Result := FFecha;
end;

function TRemesaPago.GetSubcuentaEntidad : Variant;
begin
     Result := FSubcuentaEntidad;
end;

function TRemesaPago.GetSubcuentaProveedor : Variant;
begin
     Result := FSubcuentaProveedor;
end;

function TRemesaPago.GetFechaVtoInicial : Variant;
begin
     Result := FFechaVtoInicial;
end;

function TRemesaPago.GetFechaVtoFinal : Variant;
begin
     Result := FFechaVtoFinal;
end;

function TRemesaPago.GetImporteGastos : Variant;
begin
     Result := FImporteGastos;
end;

function TRemesaPago.GetEstado : Variant;
begin
     Result := FEstado;
end;

function TRemesaPago.GetTipoOrden : Variant;
begin
     Result := FTipoOrden;
end;

function TRemesaPago.GetCodigoOrden : Variant;
begin
     Result := FCodigoOrden;
end;

function TRemesaPago.GetFechaPago : Variant;
begin
     Result := FFechaPago;
end;

function TRemesaPago.GetNroAsientoPago : Variant;
begin
     Result := FNroAsientoPago;
end;

{ Setters}

procedure TRemesaPago.SetRemoteCursorID( const Value : TnxCursorID );
begin
     FRemoteCursorID := Value;
end;

procedure TRemesaPago.SetState( const Value : TDataSetState );
begin
     FState := Value;
end;


procedure TRemesaPago.SetEjercicio(  const Value : SmallInt );
begin
     FEjercicio := Value;
end;

procedure TRemesaPago.SetNroRemesa(  const Value : Integer );
begin
     FNroRemesa := Value;
end;

procedure TRemesaPago.SetFecha(  const Value : Variant );
begin
     FFecha := Value;
end;

procedure TRemesaPago.SetSubcuentaEntidad(  const Value : Variant );
begin
     FSubcuentaEntidad := Value;
end;

procedure TRemesaPago.SetSubcuentaProveedor(  const Value : Variant );
begin
     FSubcuentaProveedor := Value;
end;

procedure TRemesaPago.SetFechaVtoInicial(  const Value : Variant );
begin
     FFechaVtoInicial := Value;
end;

procedure TRemesaPago.SetFechaVtoFinal(  const Value : Variant );
begin
     FFechaVtoFinal := Value;
end;

procedure TRemesaPago.SetImporteGastos(  const Value : Variant );
begin
     FImporteGastos := Value;
end;

procedure TRemesaPago.SetEstado(  const Value : Variant );
begin
     FEstado := Value;
end;

procedure TRemesaPago.SetTipoOrden(  const Value : Variant );
begin
     FTipoOrden := Value;
end;

procedure TRemesaPago.SetCodigoOrden(  const Value : Variant );
begin
     FCodigoOrden := Value;
end;

procedure TRemesaPago.SetFechaPago(  const Value : Variant );
begin
     FFechaPago := Value;
end;

procedure TRemesaPago.SetNroAsientoPago(  const Value : Variant );
begin
     FNroAsientoPago := Value;
end;

var RemesaPagoControl : InxClassFactoryControl;

initialization
   nxInvokeRegistry.RegisterInterface( TypeInfo( IRemesaPago ) );

   TnxClassFactory.RegisterClass( CLSID_RemesaPago, TRemesaPago, RemesaPagoControl );

end.
