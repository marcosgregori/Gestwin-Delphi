{$ALIGN OFF}
{$OPTIMIZATION OFF}

unit EfectoPagarIntf;

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
  CLSID_EfectoPagar : TnxGuid = '{168CF547-43EE-44ED-A38B-CEFE0B7C34F4}';

type

  IEfectoPagar = interface( IInvokableRecord )
    [ '{EDE613FD-3950-4344-AE6D-CC5B6ABBFEE0}' ] 

    procedure ToDataset( EfectoPagarFields : TEfectoPagarFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );
    function GetRemoteCursorID : TnxCursorID;
    procedure SetRemoteCursorID( const Value : TnxCursorID );
    function GetState : TDataSetState;
    procedure SetState( const Value : TDataSetState );

    // Los campos que forman parte de un índice es conveniente que no sean Variants.
    // El resto, sin embargo, pueden ser valores nulos, o el campo no estar definido en el dataset.

    function GetEjercicio : SmallInt;
    function GetSubcuentaProveedor : String;
    function GetSerie : String;
    function GetNroFactura : Integer;
    function GetNroEfecto : SmallInt;
    function GetSubcuentaEntidad : Variant;
    function GetFechaVencimiento : Variant;
    function GetFechaPago : Variant;
    function GetConcepto : Variant;
    function GetImporte : Variant;
    function GetImportePagado : Variant;
    function GetConceptoPago : Variant;
    function GetCodigoProveedor : Variant;
    function GetFechaLibramiento : Variant;
    function GetFechaEmision : Variant;
    function GetFormaDePago : Variant;
    function GetDiferenciaCambio : Variant;
    function GetGenerarEfectoDiferencia : Variant;
    function GetSubcuentaDiferencia : Variant;
    function GetGastosGestion : Variant;
    function GetSubcuentaGastos : Variant;
    function GetNroAsiento : Variant;
    function GetEjercicioRemesa : Variant;
    function GetNroRemesa : Variant;
    function GetRevisado : Variant;
    function GetAnotacion : Variant;

    procedure SetEjercicio( const Value  : SmallInt );
    procedure SetSubcuentaProveedor( const Value  : String );
    procedure SetSerie( const Value  : String );
    procedure SetNroFactura( const Value  : Integer );
    procedure SetNroEfecto( const Value  : SmallInt );
    procedure SetSubcuentaEntidad( const Value  : Variant );
    procedure SetFechaVencimiento( const Value  : Variant );
    procedure SetFechaPago( const Value  : Variant );
    procedure SetConcepto( const Value  : Variant );
    procedure SetImporte( const Value  : Variant );
    procedure SetImportePagado( const Value  : Variant );
    procedure SetConceptoPago( const Value  : Variant );
    procedure SetCodigoProveedor( const Value  : Variant );
    procedure SetFechaLibramiento( const Value  : Variant );
    procedure SetFechaEmision( const Value  : Variant );
    procedure SetFormaDePago( const Value  : Variant );
    procedure SetDiferenciaCambio( const Value  : Variant );
    procedure SetGenerarEfectoDiferencia( const Value  : Variant );
    procedure SetSubcuentaDiferencia( const Value  : Variant );
    procedure SetGastosGestion( const Value  : Variant );
    procedure SetSubcuentaGastos( const Value  : Variant );
    procedure SetNroAsiento( const Value  : Variant );
    procedure SetEjercicioRemesa( const Value  : Variant );
    procedure SetNroRemesa( const Value  : Variant );
    procedure SetRevisado( const Value  : Variant );
    procedure SetAnotacion( const Value  : Variant );
    property RemoteCursorID : TnxCursorID read GetRemoteCursorID write SetRemoteCursorID;
    property State : TDatasetState read GetState write SetState;

    property Ejercicio : SmallInt read GetEjercicio write SetEjercicio;
    property SubcuentaProveedor : String read GetSubcuentaProveedor write SetSubcuentaProveedor;
    property Serie : String read GetSerie write SetSerie;
    property NroFactura : Integer read GetNroFactura write SetNroFactura;
    property NroEfecto : SmallInt read GetNroEfecto write SetNroEfecto;
    property SubcuentaEntidad : Variant read GetSubcuentaEntidad write SetSubcuentaEntidad;
    property FechaVencimiento : Variant read GetFechaVencimiento write SetFechaVencimiento;
    property FechaPago : Variant read GetFechaPago write SetFechaPago;
    property Concepto : Variant read GetConcepto write SetConcepto;
    property Importe : Variant read GetImporte write SetImporte;
    property ImportePagado : Variant read GetImportePagado write SetImportePagado;
    property ConceptoPago : Variant read GetConceptoPago write SetConceptoPago;
    property CodigoProveedor : Variant read GetCodigoProveedor write SetCodigoProveedor;
    property FechaLibramiento : Variant read GetFechaLibramiento write SetFechaLibramiento;
    property FechaEmision : Variant read GetFechaEmision write SetFechaEmision;
    property FormaDePago : Variant read GetFormaDePago write SetFormaDePago;
    property DiferenciaCambio : Variant read GetDiferenciaCambio write SetDiferenciaCambio;
    property GenerarEfectoDiferencia : Variant read GetGenerarEfectoDiferencia write SetGenerarEfectoDiferencia;
    property SubcuentaDiferencia : Variant read GetSubcuentaDiferencia write SetSubcuentaDiferencia;
    property GastosGestion : Variant read GetGastosGestion write SetGastosGestion;
    property SubcuentaGastos : Variant read GetSubcuentaGastos write SetSubcuentaGastos;
    property NroAsiento : Variant read GetNroAsiento write SetNroAsiento;
    property EjercicioRemesa : Variant read GetEjercicioRemesa write SetEjercicioRemesa;
    property NroRemesa : Variant read GetNroRemesa write SetNroRemesa;
    property Revisado : Variant read GetRevisado write SetRevisado;
    property Anotacion : Variant read GetAnotacion write SetAnotacion;

    end;

   TEfectoPagar = class( TnxClass, InxRemoteableClass, IEfectoPagar)
     private

     FRemoteCursorID,
     FState : Variant;

     FEjercicio,
     FSubcuentaProveedor,
     FSerie,
     FNroFactura,
     FNroEfecto,
     FSubcuentaEntidad,
     FFechaVencimiento,
     FFechaPago,
     FConcepto,
     FImporte,
     FImportePagado,
     FConceptoPago,
     FCodigoProveedor,
     FFechaLibramiento,
     FFechaEmision,
     FFormaDePago,
     FDiferenciaCambio,
     FGenerarEfectoDiferencia,
     FSubcuentaDiferencia,
     FGastosGestion,
     FSubcuentaGastos,
     FNroAsiento,
     FEjercicioRemesa,
     FNroRemesa,
     FRevisado,
     FAnotacion : Variant;

     function GetEjercicio : SmallInt;
     function GetSubcuentaProveedor : String;
     function GetSerie : String;
     function GetNroFactura : Integer;
     function GetNroEfecto : SmallInt;
     function GetSubcuentaEntidad : Variant;
     function GetFechaVencimiento : Variant;
     function GetFechaPago : Variant;
     function GetConcepto : Variant;
     function GetImporte : Variant;
     function GetImportePagado : Variant;
     function GetConceptoPago : Variant;
     function GetCodigoProveedor : Variant;
     function GetFechaLibramiento : Variant;
     function GetFechaEmision : Variant;
     function GetFormaDePago : Variant;
     function GetDiferenciaCambio : Variant;
     function GetGenerarEfectoDiferencia : Variant;
     function GetSubcuentaDiferencia : Variant;
     function GetGastosGestion : Variant;
     function GetSubcuentaGastos : Variant;
     function GetNroAsiento : Variant;
     function GetEjercicioRemesa : Variant;
     function GetNroRemesa : Variant;
     function GetRevisado : Variant;
     function GetAnotacion : Variant;

     procedure SetEjercicio( const Value  : SmallInt );
     procedure SetSubcuentaProveedor( const Value  : String );
     procedure SetSerie( const Value  : String );
     procedure SetNroFactura( const Value  : Integer );
     procedure SetNroEfecto( const Value  : SmallInt );
     procedure SetSubcuentaEntidad( const Value  : Variant );
     procedure SetFechaVencimiento( const Value  : Variant );
     procedure SetFechaPago( const Value  : Variant );
     procedure SetConcepto( const Value  : Variant );
     procedure SetImporte( const Value  : Variant );
     procedure SetImportePagado( const Value  : Variant );
     procedure SetConceptoPago( const Value  : Variant );
     procedure SetCodigoProveedor( const Value  : Variant );
     procedure SetFechaLibramiento( const Value  : Variant );
     procedure SetFechaEmision( const Value  : Variant );
     procedure SetFormaDePago( const Value  : Variant );
     procedure SetDiferenciaCambio( const Value  : Variant );
     procedure SetGenerarEfectoDiferencia( const Value  : Variant );
     procedure SetSubcuentaDiferencia( const Value  : Variant );
     procedure SetGastosGestion( const Value  : Variant );
     procedure SetSubcuentaGastos( const Value  : Variant );
     procedure SetNroAsiento( const Value  : Variant );
     procedure SetEjercicioRemesa( const Value  : Variant );
     procedure SetNroRemesa( const Value  : Variant );
     procedure SetRevisado( const Value  : Variant );
     procedure SetAnotacion( const Value  : Variant );

     function LoadFromReader( AReader : InxReader ) : HRESULT;
     function SaveToWriter( AWriter : InxWriter ) : HRESULT;

     function GetRemoteCursorID : TnxCursorID;
     procedure SetRemoteCursorID( const Value : TnxCursorID );
     function GetState : TDataSetState;
     procedure SetState( const Value : TDataSetState );
     function GetClassID : TnxGuid;

     public

     constructor Create; reintroduce;

     class function FromDataset( EfectoPagarFields  : TEfectoPagarFields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : IEfectoPagar;
     procedure ToDataset( EfectoPagarFields : TEfectoPagarFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );

     end;

implementation

uses  Variants;

{ TEfectoPagar }

constructor TEfectoPagar.Create;
begin
     inherited Create( @CLSID_EfectoPagar, nil, nil, False);
     FState := dsInsert;
end;

class function TEfectoPagar.FromDataset( EfectoPagarFields : TEfectoPagarFields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : IEfectoPagar;

var   SaveState : TDataSetState;
      ApplyOldValues : Boolean;

begin
      Result := TEfectoPagar.Create;

      With Result do
        begin

        RemoteCursorID := EfectoPagarFields.GetRemoteCursorID;
        State := EfectoPagarFields.Dataset.State;
        SaveState := State;

        ApplyOldValues := OldValues and not ( State in [ dsInsert, dsSetKey ] );
        If   ApplyOldValues
        then EfectoPagarFields.IDataset.SetTempState( dsOldValue );

        try

          Ejercicio := GetFieldAsVariant( EfectoPagarFields.Ejercicio );
          SubcuentaProveedor := GetFieldAsVariant( EfectoPagarFields.SubcuentaProveedor );
          Serie := GetFieldAsVariant( EfectoPagarFields.Serie );
          NroFactura := GetFieldAsVariant( EfectoPagarFields.NroFactura );
          NroEfecto := GetFieldAsVariant( EfectoPagarFields.NroEfecto );
          SubcuentaEntidad := GetFieldAsVariant( EfectoPagarFields.SubcuentaEntidad );
          FechaVencimiento := GetFieldAsVariant( EfectoPagarFields.FechaVencimiento );
          FechaPago := GetFieldAsVariant( EfectoPagarFields.FechaPago );
          Concepto := GetFieldAsVariant( EfectoPagarFields.Concepto );
          Importe := GetFieldAsVariant( EfectoPagarFields.Importe );
          ImportePagado := GetFieldAsVariant( EfectoPagarFields.ImportePagado );
          ConceptoPago := GetFieldAsVariant( EfectoPagarFields.ConceptoPago );
          CodigoProveedor := GetFieldAsVariant( EfectoPagarFields.CodigoProveedor );
          FechaLibramiento := GetFieldAsVariant( EfectoPagarFields.FechaLibramiento );
          FechaEmision := GetFieldAsVariant( EfectoPagarFields.FechaEmision );
          FormaDePago := GetFieldAsVariant( EfectoPagarFields.FormaDePago );
          DiferenciaCambio := GetFieldAsVariant( EfectoPagarFields.DiferenciaCambio );
          GenerarEfectoDiferencia := GetFieldAsVariant( EfectoPagarFields.GenerarEfectoDiferencia );
          SubcuentaDiferencia := GetFieldAsVariant( EfectoPagarFields.SubcuentaDiferencia );
          GastosGestion := GetFieldAsVariant( EfectoPagarFields.GastosGestion );
          SubcuentaGastos := GetFieldAsVariant( EfectoPagarFields.SubcuentaGastos );
          NroAsiento := GetFieldAsVariant( EfectoPagarFields.NroAsiento );
          EjercicioRemesa := GetFieldAsVariant( EfectoPagarFields.EjercicioRemesa );
          NroRemesa := GetFieldAsVariant( EfectoPagarFields.NroRemesa );
          Revisado := GetFieldAsVariant( EfectoPagarFields.Revisado );

          If   ReadBlobs
          then Anotacion := GetFieldAsVariant( EfectoPagarFields.Anotacion )
          else Anotacion := '';

        finally
          If   ApplyOldValues
          then EfectoPagarFields.IDataset.RestoreState( SaveState );
        end;
      end;

end;

procedure TEfectoPagar.ToDataset( EfectoPagarFields : TEfectoPagarFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );
begin
     try

       If   not PreserveState
       then EfectoPagarFields.SetStateFromInterface( FState );

       EfectoPagarFields.Ejercicio.Value := FEjercicio;
       EfectoPagarFields.SubcuentaProveedor.Value := FSubcuentaProveedor;
       EfectoPagarFields.Serie.Value := FSerie;
       EfectoPagarFields.NroFactura.Value := FNroFactura;
       EfectoPagarFields.NroEfecto.Value := FNroEfecto;

       SetFieldAsVariant( EfectoPagarFields.SubcuentaEntidad, FSubcuentaEntidad );
       SetFieldAsVariant( EfectoPagarFields.FechaVencimiento, FFechaVencimiento );
       SetFieldAsVariant( EfectoPagarFields.FechaPago, FFechaPago );
       SetFieldAsVariant( EfectoPagarFields.Concepto, FConcepto );
       SetFieldAsVariant( EfectoPagarFields.Importe, FImporte );
       SetFieldAsVariant( EfectoPagarFields.ImportePagado, FImportePagado );
       SetFieldAsVariant( EfectoPagarFields.ConceptoPago, FConceptoPago );
       SetFieldAsVariant( EfectoPagarFields.CodigoProveedor, FCodigoProveedor );
       SetFieldAsVariant( EfectoPagarFields.FechaLibramiento, FFechaLibramiento );
       SetFieldAsVariant( EfectoPagarFields.FechaEmision, FFechaEmision );
       SetFieldAsVariant( EfectoPagarFields.FormaDePago, FFormaDePago );
       SetFieldAsVariant( EfectoPagarFields.DiferenciaCambio, FDiferenciaCambio );
       SetFieldAsVariant( EfectoPagarFields.GenerarEfectoDiferencia, FGenerarEfectoDiferencia );
       SetFieldAsVariant( EfectoPagarFields.SubcuentaDiferencia, FSubcuentaDiferencia );
       SetFieldAsVariant( EfectoPagarFields.GastosGestion, FGastosGestion );
       SetFieldAsVariant( EfectoPagarFields.SubcuentaGastos, FSubcuentaGastos );
       SetFieldAsVariant( EfectoPagarFields.NroAsiento, FNroAsiento );
       SetFieldAsVariant( EfectoPagarFields.EjercicioRemesa, FEjercicioRemesa );
       SetFieldAsVariant( EfectoPagarFields.NroRemesa, FNroRemesa );
       SetFieldAsVariant( EfectoPagarFields.Revisado, FRevisado );

       If   ReadBlobs
       then SetFieldAsVariant( EfectoPagarFields.Anotacion, FAnotacion )
       else EfectoPagarFields.Anotacion.Clear;

     except
       EfectoPagarFields.Dataset.Cancel;
       raise;
       end;

end;

function TEfectoPagar.LoadFromReader( AReader : InxReader ) : HRESULT;

var VarFlags : TnxVarFlags;

begin
     nxReadVariant( VarFlags, FRemoteCursorID, AReader );
     nxReadVariant( VarFlags, FState, AReader );

     nxReadVariant( VarFlags, FEjercicio, AReader );
     nxReadVariant( VarFlags, FSubcuentaProveedor, AReader );
     nxReadVariant( VarFlags, FSerie, AReader );
     nxReadVariant( VarFlags, FNroFactura, AReader );
     nxReadVariant( VarFlags, FNroEfecto, AReader );
     nxReadVariant( VarFlags, FSubcuentaEntidad, AReader );
     nxReadVariant( VarFlags, FFechaVencimiento, AReader );
     nxReadVariant( VarFlags, FFechaPago, AReader );
     nxReadVariant( VarFlags, FConcepto, AReader );
     nxReadVariant( VarFlags, FImporte, AReader );
     nxReadVariant( VarFlags, FImportePagado, AReader );
     nxReadVariant( VarFlags, FConceptoPago, AReader );
     nxReadVariant( VarFlags, FCodigoProveedor, AReader );
     nxReadVariant( VarFlags, FFechaLibramiento, AReader );
     nxReadVariant( VarFlags, FFechaEmision, AReader );
     nxReadVariant( VarFlags, FFormaDePago, AReader );
     nxReadVariant( VarFlags, FDiferenciaCambio, AReader );
     nxReadVariant( VarFlags, FGenerarEfectoDiferencia, AReader );
     nxReadVariant( VarFlags, FSubcuentaDiferencia, AReader );
     nxReadVariant( VarFlags, FGastosGestion, AReader );
     nxReadVariant( VarFlags, FSubcuentaGastos, AReader );
     nxReadVariant( VarFlags, FNroAsiento, AReader );
     nxReadVariant( VarFlags, FEjercicioRemesa, AReader );
     nxReadVariant( VarFlags, FNroRemesa, AReader );
     nxReadVariant( VarFlags, FRevisado, AReader );
     nxReadVariant( VarFlags, FAnotacion, AReader );

     Result := S_OK;
end;

function TEfectoPagar.SaveToWriter( AWriter : InxWriter) : HRESULT;
begin
     nxWriteVariant( FRemoteCursorID, AWriter );
     nxWriteVariant( FState, AWriter );

     nxWriteVariant( FEjercicio, AWriter );
     nxWriteVariant( FSubcuentaProveedor, AWriter );
     nxWriteVariant( FSerie, AWriter );
     nxWriteVariant( FNroFactura, AWriter );
     nxWriteVariant( FNroEfecto, AWriter );
     nxWriteVariant( FSubcuentaEntidad, AWriter );
     nxWriteVariant( FFechaVencimiento, AWriter );
     nxWriteVariant( FFechaPago, AWriter );
     nxWriteVariant( FConcepto, AWriter );
     nxWriteVariant( FImporte, AWriter );
     nxWriteVariant( FImportePagado, AWriter );
     nxWriteVariant( FConceptoPago, AWriter );
     nxWriteVariant( FCodigoProveedor, AWriter );
     nxWriteVariant( FFechaLibramiento, AWriter );
     nxWriteVariant( FFechaEmision, AWriter );
     nxWriteVariant( FFormaDePago, AWriter );
     nxWriteVariant( FDiferenciaCambio, AWriter );
     nxWriteVariant( FGenerarEfectoDiferencia, AWriter );
     nxWriteVariant( FSubcuentaDiferencia, AWriter );
     nxWriteVariant( FGastosGestion, AWriter );
     nxWriteVariant( FSubcuentaGastos, AWriter );
     nxWriteVariant( FNroAsiento, AWriter );
     nxWriteVariant( FEjercicioRemesa, AWriter );
     nxWriteVariant( FNroRemesa, AWriter );
     nxWriteVariant( FRevisado, AWriter );
     nxWriteVariant( FAnotacion, AWriter );
     Result := S_OK;
end;

{ Getters}

function TEfectoPagar.GetClassID: TnxGuid;
begin
     Result := CLSID_EfectoPagar;
end;

function TEfectoPagar.GetRemoteCursorID: TnxCursorID;
begin
     Result := FRemoteCursorID;
end;

function TEfectoPagar.GetState: TDataSetState;
begin
     Result := FState;
end;


function TEfectoPagar.GetEjercicio : SmallInt;
begin
     Result := FEjercicio;
end;

function TEfectoPagar.GetSubcuentaProveedor : String;
begin
     Result := FSubcuentaProveedor;
end;

function TEfectoPagar.GetSerie : String;
begin
     Result := FSerie;
end;

function TEfectoPagar.GetNroFactura : Integer;
begin
     Result := FNroFactura;
end;

function TEfectoPagar.GetNroEfecto : SmallInt;
begin
     Result := FNroEfecto;
end;

function TEfectoPagar.GetSubcuentaEntidad : Variant;
begin
     Result := FSubcuentaEntidad;
end;

function TEfectoPagar.GetFechaVencimiento : Variant;
begin
     Result := FFechaVencimiento;
end;

function TEfectoPagar.GetFechaPago : Variant;
begin
     Result := FFechaPago;
end;

function TEfectoPagar.GetConcepto : Variant;
begin
     Result := FConcepto;
end;

function TEfectoPagar.GetImporte : Variant;
begin
     Result := FImporte;
end;

function TEfectoPagar.GetImportePagado : Variant;
begin
     Result := FImportePagado;
end;

function TEfectoPagar.GetConceptoPago : Variant;
begin
     Result := FConceptoPago;
end;

function TEfectoPagar.GetCodigoProveedor : Variant;
begin
     Result := FCodigoProveedor;
end;

function TEfectoPagar.GetFechaLibramiento : Variant;
begin
     Result := FFechaLibramiento;
end;

function TEfectoPagar.GetFechaEmision : Variant;
begin
     Result := FFechaEmision;
end;

function TEfectoPagar.GetFormaDePago : Variant;
begin
     Result := FFormaDePago;
end;

function TEfectoPagar.GetDiferenciaCambio : Variant;
begin
     Result := FDiferenciaCambio;
end;

function TEfectoPagar.GetGenerarEfectoDiferencia : Variant;
begin
     Result := FGenerarEfectoDiferencia;
end;

function TEfectoPagar.GetSubcuentaDiferencia : Variant;
begin
     Result := FSubcuentaDiferencia;
end;

function TEfectoPagar.GetGastosGestion : Variant;
begin
     Result := FGastosGestion;
end;

function TEfectoPagar.GetSubcuentaGastos : Variant;
begin
     Result := FSubcuentaGastos;
end;

function TEfectoPagar.GetNroAsiento : Variant;
begin
     Result := FNroAsiento;
end;

function TEfectoPagar.GetEjercicioRemesa : Variant;
begin
     Result := FEjercicioRemesa;
end;

function TEfectoPagar.GetNroRemesa : Variant;
begin
     Result := FNroRemesa;
end;

function TEfectoPagar.GetRevisado : Variant;
begin
     Result := FRevisado;
end;

function TEfectoPagar.GetAnotacion : Variant;
begin
     Result := FAnotacion;
end;

{ Setters}

procedure TEfectoPagar.SetRemoteCursorID( const Value : TnxCursorID );
begin
     FRemoteCursorID := Value;
end;

procedure TEfectoPagar.SetState( const Value : TDataSetState );
begin
     FState := Value;
end;


procedure TEfectoPagar.SetEjercicio(  const Value : SmallInt );
begin
     FEjercicio := Value;
end;

procedure TEfectoPagar.SetSubcuentaProveedor(  const Value : String );
begin
     FSubcuentaProveedor := Value;
end;

procedure TEfectoPagar.SetSerie(  const Value : String );
begin
     FSerie := Value;
end;

procedure TEfectoPagar.SetNroFactura(  const Value : Integer );
begin
     FNroFactura := Value;
end;

procedure TEfectoPagar.SetNroEfecto(  const Value : SmallInt );
begin
     FNroEfecto := Value;
end;

procedure TEfectoPagar.SetSubcuentaEntidad(  const Value : Variant );
begin
     FSubcuentaEntidad := Value;
end;

procedure TEfectoPagar.SetFechaVencimiento(  const Value : Variant );
begin
     FFechaVencimiento := Value;
end;

procedure TEfectoPagar.SetFechaPago(  const Value : Variant );
begin
     FFechaPago := Value;
end;

procedure TEfectoPagar.SetConcepto(  const Value : Variant );
begin
     FConcepto := Value;
end;

procedure TEfectoPagar.SetImporte(  const Value : Variant );
begin
     FImporte := Value;
end;

procedure TEfectoPagar.SetImportePagado(  const Value : Variant );
begin
     FImportePagado := Value;
end;

procedure TEfectoPagar.SetConceptoPago(  const Value : Variant );
begin
     FConceptoPago := Value;
end;

procedure TEfectoPagar.SetCodigoProveedor(  const Value : Variant );
begin
     FCodigoProveedor := Value;
end;

procedure TEfectoPagar.SetFechaLibramiento(  const Value : Variant );
begin
     FFechaLibramiento := Value;
end;

procedure TEfectoPagar.SetFechaEmision(  const Value : Variant );
begin
     FFechaEmision := Value;
end;

procedure TEfectoPagar.SetFormaDePago(  const Value : Variant );
begin
     FFormaDePago := Value;
end;

procedure TEfectoPagar.SetDiferenciaCambio(  const Value : Variant );
begin
     FDiferenciaCambio := Value;
end;

procedure TEfectoPagar.SetGenerarEfectoDiferencia(  const Value : Variant );
begin
     FGenerarEfectoDiferencia := Value;
end;

procedure TEfectoPagar.SetSubcuentaDiferencia(  const Value : Variant );
begin
     FSubcuentaDiferencia := Value;
end;

procedure TEfectoPagar.SetGastosGestion(  const Value : Variant );
begin
     FGastosGestion := Value;
end;

procedure TEfectoPagar.SetSubcuentaGastos(  const Value : Variant );
begin
     FSubcuentaGastos := Value;
end;

procedure TEfectoPagar.SetNroAsiento(  const Value : Variant );
begin
     FNroAsiento := Value;
end;

procedure TEfectoPagar.SetEjercicioRemesa(  const Value : Variant );
begin
     FEjercicioRemesa := Value;
end;

procedure TEfectoPagar.SetNroRemesa(  const Value : Variant );
begin
     FNroRemesa := Value;
end;

procedure TEfectoPagar.SetRevisado(  const Value : Variant );
begin
     FRevisado := Value;
end;

procedure TEfectoPagar.SetAnotacion(  const Value : Variant );
begin
     FAnotacion := Value;
end;

var EfectoPagarControl : InxClassFactoryControl;

initialization
   nxInvokeRegistry.RegisterInterface( TypeInfo( IEfectoPagar ) );

   TnxClassFactory.RegisterClass( CLSID_EfectoPagar, TEfectoPagar, EfectoPagarControl );

end.
