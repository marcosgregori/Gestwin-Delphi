{$ALIGN OFF}
{$OPTIMIZATION OFF}

unit EfectoCobrarIntf;

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
  CLSID_EfectoCobrar : TnxGuid = '{D8D36C31-DEBD-4B06-9273-FC00880B4EAE}';

type

  IEfectoCobrar = interface( IInvokableRecord )
    [ '{29102D56-F924-4424-ADE0-BF6B1B0BBAC3}' ] 

    procedure ToDataset( EfectoCobrarFields : TEfectoCobrarFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );
    function GetRemoteCursorID : TnxCursorID;
    procedure SetRemoteCursorID( const Value : TnxCursorID );
    function GetState : TDataSetState;
    procedure SetState( const Value : TDataSetState );

    // Los campos que forman parte de un índice es conveniente que no sean Variants.
    // El resto, sin embargo, pueden ser valores nulos, o el campo no estar definido en el dataset.

    function GetEjercicio : SmallInt;
    function GetSerie : String;
    function GetNroFactura : Integer;
    function GetNroEfecto : SmallInt;
    function GetSubcuentaCliente : Variant;
    function GetSubcuentaEntidad : Variant;
    function GetFechaVencimiento : Variant;
    function GetFechaCobro : Variant;
    function GetConcepto : Variant;
    function GetEjercicioRemesa : Variant;
    function GetNroRemesa : Variant;
    function GetImporte : Variant;
    function GetImporteCobrado : Variant;
    function GetConceptoCobro : Variant;
    function GetCodigoCliente : Variant;
    function GetVendedor : Variant;
    function GetGrupoFacturacion : Variant;
    function GetRevisado : Variant;
    function GetImpagado : Variant;
    function GetCancelado : Variant;
    function GetVolverAEmitir : Variant;
    function GetNroEfectoReemitido : Variant;
    function GetFechaLibramiento : Variant;
    function GetFechaEmision : Variant;
    function GetFormaDePago : Variant;
    function GetDiferenciaCambio : Variant;
    function GetGenerarEfectoDiferencia : Variant;
    function GetSubcuentaDiferencia : Variant;
    function GetNroEfectoDiferencia : Variant;
    function GetGastosGestion : Variant;
    function GetGastosDevolucion : Variant;
    function GetSubcuentaGastos : Variant;
    function GetNroAsientoCartera : Variant;
    function GetNroAsientoCobro : Variant;
    function GetFechaDescuento : Variant;
    function GetNroAsientoDescuento : Variant;
    function GetFechaCancelacion : Variant;
    function GetNroAstoCancelacion : Variant;
    function GetFechaImpagado : Variant;
    function GetNroAsientoImpagado : Variant;
    function GetAnotacion : Variant;

    procedure SetEjercicio( const Value  : SmallInt );
    procedure SetSerie( const Value  : String );
    procedure SetNroFactura( const Value  : Integer );
    procedure SetNroEfecto( const Value  : SmallInt );
    procedure SetSubcuentaCliente( const Value  : Variant );
    procedure SetSubcuentaEntidad( const Value  : Variant );
    procedure SetFechaVencimiento( const Value  : Variant );
    procedure SetFechaCobro( const Value  : Variant );
    procedure SetConcepto( const Value  : Variant );
    procedure SetEjercicioRemesa( const Value  : Variant );
    procedure SetNroRemesa( const Value  : Variant );
    procedure SetImporte( const Value  : Variant );
    procedure SetImporteCobrado( const Value  : Variant );
    procedure SetConceptoCobro( const Value  : Variant );
    procedure SetCodigoCliente( const Value  : Variant );
    procedure SetVendedor( const Value  : Variant );
    procedure SetGrupoFacturacion( const Value  : Variant );
    procedure SetRevisado( const Value  : Variant );
    procedure SetImpagado( const Value  : Variant );
    procedure SetCancelado( const Value  : Variant );
    procedure SetVolverAEmitir( const Value  : Variant );
    procedure SetNroEfectoReemitido( const Value  : Variant );
    procedure SetFechaLibramiento( const Value  : Variant );
    procedure SetFechaEmision( const Value  : Variant );
    procedure SetFormaDePago( const Value  : Variant );
    procedure SetDiferenciaCambio( const Value  : Variant );
    procedure SetGenerarEfectoDiferencia( const Value  : Variant );
    procedure SetSubcuentaDiferencia( const Value  : Variant );
    procedure SetNroEfectoDiferencia( const Value  : Variant );
    procedure SetGastosGestion( const Value  : Variant );
    procedure SetGastosDevolucion( const Value  : Variant );
    procedure SetSubcuentaGastos( const Value  : Variant );
    procedure SetNroAsientoCartera( const Value  : Variant );
    procedure SetNroAsientoCobro( const Value  : Variant );
    procedure SetFechaDescuento( const Value  : Variant );
    procedure SetNroAsientoDescuento( const Value  : Variant );
    procedure SetFechaCancelacion( const Value  : Variant );
    procedure SetNroAstoCancelacion( const Value  : Variant );
    procedure SetFechaImpagado( const Value  : Variant );
    procedure SetNroAsientoImpagado( const Value  : Variant );
    procedure SetAnotacion( const Value  : Variant );
    property RemoteCursorID : TnxCursorID read GetRemoteCursorID write SetRemoteCursorID;
    property State : TDatasetState read GetState write SetState;

    property Ejercicio : SmallInt read GetEjercicio write SetEjercicio;
    property Serie : String read GetSerie write SetSerie;
    property NroFactura : Integer read GetNroFactura write SetNroFactura;
    property NroEfecto : SmallInt read GetNroEfecto write SetNroEfecto;
    property SubcuentaCliente : Variant read GetSubcuentaCliente write SetSubcuentaCliente;
    property SubcuentaEntidad : Variant read GetSubcuentaEntidad write SetSubcuentaEntidad;
    property FechaVencimiento : Variant read GetFechaVencimiento write SetFechaVencimiento;
    property FechaCobro : Variant read GetFechaCobro write SetFechaCobro;
    property Concepto : Variant read GetConcepto write SetConcepto;
    property EjercicioRemesa : Variant read GetEjercicioRemesa write SetEjercicioRemesa;
    property NroRemesa : Variant read GetNroRemesa write SetNroRemesa;
    property Importe : Variant read GetImporte write SetImporte;
    property ImporteCobrado : Variant read GetImporteCobrado write SetImporteCobrado;
    property ConceptoCobro : Variant read GetConceptoCobro write SetConceptoCobro;
    property CodigoCliente : Variant read GetCodigoCliente write SetCodigoCliente;
    property Vendedor : Variant read GetVendedor write SetVendedor;
    property GrupoFacturacion : Variant read GetGrupoFacturacion write SetGrupoFacturacion;
    property Revisado : Variant read GetRevisado write SetRevisado;
    property Impagado : Variant read GetImpagado write SetImpagado;
    property Cancelado : Variant read GetCancelado write SetCancelado;
    property VolverAEmitir : Variant read GetVolverAEmitir write SetVolverAEmitir;
    property NroEfectoReemitido : Variant read GetNroEfectoReemitido write SetNroEfectoReemitido;
    property FechaLibramiento : Variant read GetFechaLibramiento write SetFechaLibramiento;
    property FechaEmision : Variant read GetFechaEmision write SetFechaEmision;
    property FormaDePago : Variant read GetFormaDePago write SetFormaDePago;
    property DiferenciaCambio : Variant read GetDiferenciaCambio write SetDiferenciaCambio;
    property GenerarEfectoDiferencia : Variant read GetGenerarEfectoDiferencia write SetGenerarEfectoDiferencia;
    property SubcuentaDiferencia : Variant read GetSubcuentaDiferencia write SetSubcuentaDiferencia;
    property NroEfectoDiferencia : Variant read GetNroEfectoDiferencia write SetNroEfectoDiferencia;
    property GastosGestion : Variant read GetGastosGestion write SetGastosGestion;
    property GastosDevolucion : Variant read GetGastosDevolucion write SetGastosDevolucion;
    property SubcuentaGastos : Variant read GetSubcuentaGastos write SetSubcuentaGastos;
    property NroAsientoCartera : Variant read GetNroAsientoCartera write SetNroAsientoCartera;
    property NroAsientoCobro : Variant read GetNroAsientoCobro write SetNroAsientoCobro;
    property FechaDescuento : Variant read GetFechaDescuento write SetFechaDescuento;
    property NroAsientoDescuento : Variant read GetNroAsientoDescuento write SetNroAsientoDescuento;
    property FechaCancelacion : Variant read GetFechaCancelacion write SetFechaCancelacion;
    property NroAstoCancelacion : Variant read GetNroAstoCancelacion write SetNroAstoCancelacion;
    property FechaImpagado : Variant read GetFechaImpagado write SetFechaImpagado;
    property NroAsientoImpagado : Variant read GetNroAsientoImpagado write SetNroAsientoImpagado;
    property Anotacion : Variant read GetAnotacion write SetAnotacion;

    end;

   TEfectoCobrar = class( TnxClass, InxRemoteableClass, IEfectoCobrar)
     private

     FRemoteCursorID,
     FState : Variant;

     FEjercicio,
     FSerie,
     FNroFactura,
     FNroEfecto,
     FSubcuentaCliente,
     FSubcuentaEntidad,
     FFechaVencimiento,
     FFechaCobro,
     FConcepto,
     FEjercicioRemesa,
     FNroRemesa,
     FImporte,
     FImporteCobrado,
     FConceptoCobro,
     FCodigoCliente,
     FVendedor,
     FGrupoFacturacion,
     FRevisado,
     FImpagado,
     FCancelado,
     FVolverAEmitir,
     FNroEfectoReemitido,
     FFechaLibramiento,
     FFechaEmision,
     FFormaDePago,
     FDiferenciaCambio,
     FGenerarEfectoDiferencia,
     FSubcuentaDiferencia,
     FNroEfectoDiferencia,
     FGastosGestion,
     FGastosDevolucion,
     FSubcuentaGastos,
     FNroAsientoCartera,
     FNroAsientoCobro,
     FFechaDescuento,
     FNroAsientoDescuento,
     FFechaCancelacion,
     FNroAstoCancelacion,
     FFechaImpagado,
     FNroAsientoImpagado,
     FAnotacion : Variant;

     function GetEjercicio : SmallInt;
     function GetSerie : String;
     function GetNroFactura : Integer;
     function GetNroEfecto : SmallInt;
     function GetSubcuentaCliente : Variant;
     function GetSubcuentaEntidad : Variant;
     function GetFechaVencimiento : Variant;
     function GetFechaCobro : Variant;
     function GetConcepto : Variant;
     function GetEjercicioRemesa : Variant;
     function GetNroRemesa : Variant;
     function GetImporte : Variant;
     function GetImporteCobrado : Variant;
     function GetConceptoCobro : Variant;
     function GetCodigoCliente : Variant;
     function GetVendedor : Variant;
     function GetGrupoFacturacion : Variant;
     function GetRevisado : Variant;
     function GetImpagado : Variant;
     function GetCancelado : Variant;
     function GetVolverAEmitir : Variant;
     function GetNroEfectoReemitido : Variant;
     function GetFechaLibramiento : Variant;
     function GetFechaEmision : Variant;
     function GetFormaDePago : Variant;
     function GetDiferenciaCambio : Variant;
     function GetGenerarEfectoDiferencia : Variant;
     function GetSubcuentaDiferencia : Variant;
     function GetNroEfectoDiferencia : Variant;
     function GetGastosGestion : Variant;
     function GetGastosDevolucion : Variant;
     function GetSubcuentaGastos : Variant;
     function GetNroAsientoCartera : Variant;
     function GetNroAsientoCobro : Variant;
     function GetFechaDescuento : Variant;
     function GetNroAsientoDescuento : Variant;
     function GetFechaCancelacion : Variant;
     function GetNroAstoCancelacion : Variant;
     function GetFechaImpagado : Variant;
     function GetNroAsientoImpagado : Variant;
     function GetAnotacion : Variant;

     procedure SetEjercicio( const Value  : SmallInt );
     procedure SetSerie( const Value  : String );
     procedure SetNroFactura( const Value  : Integer );
     procedure SetNroEfecto( const Value  : SmallInt );
     procedure SetSubcuentaCliente( const Value  : Variant );
     procedure SetSubcuentaEntidad( const Value  : Variant );
     procedure SetFechaVencimiento( const Value  : Variant );
     procedure SetFechaCobro( const Value  : Variant );
     procedure SetConcepto( const Value  : Variant );
     procedure SetEjercicioRemesa( const Value  : Variant );
     procedure SetNroRemesa( const Value  : Variant );
     procedure SetImporte( const Value  : Variant );
     procedure SetImporteCobrado( const Value  : Variant );
     procedure SetConceptoCobro( const Value  : Variant );
     procedure SetCodigoCliente( const Value  : Variant );
     procedure SetVendedor( const Value  : Variant );
     procedure SetGrupoFacturacion( const Value  : Variant );
     procedure SetRevisado( const Value  : Variant );
     procedure SetImpagado( const Value  : Variant );
     procedure SetCancelado( const Value  : Variant );
     procedure SetVolverAEmitir( const Value  : Variant );
     procedure SetNroEfectoReemitido( const Value  : Variant );
     procedure SetFechaLibramiento( const Value  : Variant );
     procedure SetFechaEmision( const Value  : Variant );
     procedure SetFormaDePago( const Value  : Variant );
     procedure SetDiferenciaCambio( const Value  : Variant );
     procedure SetGenerarEfectoDiferencia( const Value  : Variant );
     procedure SetSubcuentaDiferencia( const Value  : Variant );
     procedure SetNroEfectoDiferencia( const Value  : Variant );
     procedure SetGastosGestion( const Value  : Variant );
     procedure SetGastosDevolucion( const Value  : Variant );
     procedure SetSubcuentaGastos( const Value  : Variant );
     procedure SetNroAsientoCartera( const Value  : Variant );
     procedure SetNroAsientoCobro( const Value  : Variant );
     procedure SetFechaDescuento( const Value  : Variant );
     procedure SetNroAsientoDescuento( const Value  : Variant );
     procedure SetFechaCancelacion( const Value  : Variant );
     procedure SetNroAstoCancelacion( const Value  : Variant );
     procedure SetFechaImpagado( const Value  : Variant );
     procedure SetNroAsientoImpagado( const Value  : Variant );
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

     class function FromDataset( EfectoCobrarFields  : TEfectoCobrarFields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : IEfectoCobrar;
     procedure ToDataset( EfectoCobrarFields : TEfectoCobrarFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );

     end;

implementation

uses  Variants;

{ TEfectoCobrar }

constructor TEfectoCobrar.Create;
begin
     inherited Create( @CLSID_EfectoCobrar, nil, nil, False);
     FState := dsInsert;
end;

class function TEfectoCobrar.FromDataset( EfectoCobrarFields : TEfectoCobrarFields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : IEfectoCobrar;

var   SaveState : TDataSetState;
      ApplyOldValues : Boolean;

begin
      Result := TEfectoCobrar.Create;

      With Result do
        begin

        RemoteCursorID := EfectoCobrarFields.GetRemoteCursorID;
        State := EfectoCobrarFields.Dataset.State;
        SaveState := State;

        ApplyOldValues := OldValues and not ( State in [ dsInsert, dsSetKey ] );
        If   ApplyOldValues
        then EfectoCobrarFields.IDataset.SetTempState( dsOldValue );

        try

          Ejercicio := GetFieldAsVariant( EfectoCobrarFields.Ejercicio );
          Serie := GetFieldAsVariant( EfectoCobrarFields.Serie );
          NroFactura := GetFieldAsVariant( EfectoCobrarFields.NroFactura );
          NroEfecto := GetFieldAsVariant( EfectoCobrarFields.NroEfecto );
          SubcuentaCliente := GetFieldAsVariant( EfectoCobrarFields.SubcuentaCliente );
          SubcuentaEntidad := GetFieldAsVariant( EfectoCobrarFields.SubcuentaEntidad );
          FechaVencimiento := GetFieldAsVariant( EfectoCobrarFields.FechaVencimiento );
          FechaCobro := GetFieldAsVariant( EfectoCobrarFields.FechaCobro );
          Concepto := GetFieldAsVariant( EfectoCobrarFields.Concepto );
          EjercicioRemesa := GetFieldAsVariant( EfectoCobrarFields.EjercicioRemesa );
          NroRemesa := GetFieldAsVariant( EfectoCobrarFields.NroRemesa );
          Importe := GetFieldAsVariant( EfectoCobrarFields.Importe );
          ImporteCobrado := GetFieldAsVariant( EfectoCobrarFields.ImporteCobrado );
          ConceptoCobro := GetFieldAsVariant( EfectoCobrarFields.ConceptoCobro );
          CodigoCliente := GetFieldAsVariant( EfectoCobrarFields.CodigoCliente );
          Vendedor := GetFieldAsVariant( EfectoCobrarFields.Vendedor );
          GrupoFacturacion := GetFieldAsVariant( EfectoCobrarFields.GrupoFacturacion );
          Revisado := GetFieldAsVariant( EfectoCobrarFields.Revisado );
          Impagado := GetFieldAsVariant( EfectoCobrarFields.Impagado );
          Cancelado := GetFieldAsVariant( EfectoCobrarFields.Cancelado );
          VolverAEmitir := GetFieldAsVariant( EfectoCobrarFields.VolverAEmitir );
          NroEfectoReemitido := GetFieldAsVariant( EfectoCobrarFields.NroEfectoReemitido );
          FechaLibramiento := GetFieldAsVariant( EfectoCobrarFields.FechaLibramiento );
          FechaEmision := GetFieldAsVariant( EfectoCobrarFields.FechaEmision );
          FormaDePago := GetFieldAsVariant( EfectoCobrarFields.FormaDePago );
          DiferenciaCambio := GetFieldAsVariant( EfectoCobrarFields.DiferenciaCambio );
          GenerarEfectoDiferencia := GetFieldAsVariant( EfectoCobrarFields.GenerarEfectoDiferencia );
          SubcuentaDiferencia := GetFieldAsVariant( EfectoCobrarFields.SubcuentaDiferencia );
          NroEfectoDiferencia := GetFieldAsVariant( EfectoCobrarFields.NroEfectoDiferencia );
          GastosGestion := GetFieldAsVariant( EfectoCobrarFields.GastosGestion );
          GastosDevolucion := GetFieldAsVariant( EfectoCobrarFields.GastosDevolucion );
          SubcuentaGastos := GetFieldAsVariant( EfectoCobrarFields.SubcuentaGastos );
          NroAsientoCartera := GetFieldAsVariant( EfectoCobrarFields.NroAsientoCartera );
          NroAsientoCobro := GetFieldAsVariant( EfectoCobrarFields.NroAsientoCobro );
          FechaDescuento := GetFieldAsVariant( EfectoCobrarFields.FechaDescuento );
          NroAsientoDescuento := GetFieldAsVariant( EfectoCobrarFields.NroAsientoDescuento );
          FechaCancelacion := GetFieldAsVariant( EfectoCobrarFields.FechaCancelacion );
          NroAstoCancelacion := GetFieldAsVariant( EfectoCobrarFields.NroAstoCancelacion );
          FechaImpagado := GetFieldAsVariant( EfectoCobrarFields.FechaImpagado );
          NroAsientoImpagado := GetFieldAsVariant( EfectoCobrarFields.NroAsientoImpagado );

          If   ReadBlobs
          then Anotacion := GetFieldAsVariant( EfectoCobrarFields.Anotacion )
          else Anotacion := '';

        finally
          If   ApplyOldValues
          then EfectoCobrarFields.IDataset.RestoreState( SaveState );
        end;
      end;

end;

procedure TEfectoCobrar.ToDataset( EfectoCobrarFields : TEfectoCobrarFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );
begin
     try

       If   not PreserveState
       then EfectoCobrarFields.SetStateFromInterface( FState );

       EfectoCobrarFields.Ejercicio.Value := FEjercicio;
       EfectoCobrarFields.Serie.Value := FSerie;
       EfectoCobrarFields.NroFactura.Value := FNroFactura;
       EfectoCobrarFields.NroEfecto.Value := FNroEfecto;

       SetFieldAsVariant( EfectoCobrarFields.SubcuentaCliente, FSubcuentaCliente );
       SetFieldAsVariant( EfectoCobrarFields.SubcuentaEntidad, FSubcuentaEntidad );
       SetFieldAsVariant( EfectoCobrarFields.FechaVencimiento, FFechaVencimiento );
       SetFieldAsVariant( EfectoCobrarFields.FechaCobro, FFechaCobro );
       SetFieldAsVariant( EfectoCobrarFields.Concepto, FConcepto );
       SetFieldAsVariant( EfectoCobrarFields.EjercicioRemesa, FEjercicioRemesa );
       SetFieldAsVariant( EfectoCobrarFields.NroRemesa, FNroRemesa );
       SetFieldAsVariant( EfectoCobrarFields.Importe, FImporte );
       SetFieldAsVariant( EfectoCobrarFields.ImporteCobrado, FImporteCobrado );
       SetFieldAsVariant( EfectoCobrarFields.ConceptoCobro, FConceptoCobro );
       SetFieldAsVariant( EfectoCobrarFields.CodigoCliente, FCodigoCliente );
       SetFieldAsVariant( EfectoCobrarFields.Vendedor, FVendedor );
       SetFieldAsVariant( EfectoCobrarFields.GrupoFacturacion, FGrupoFacturacion );
       SetFieldAsVariant( EfectoCobrarFields.Revisado, FRevisado );
       SetFieldAsVariant( EfectoCobrarFields.Impagado, FImpagado );
       SetFieldAsVariant( EfectoCobrarFields.Cancelado, FCancelado );
       SetFieldAsVariant( EfectoCobrarFields.VolverAEmitir, FVolverAEmitir );
       SetFieldAsVariant( EfectoCobrarFields.NroEfectoReemitido, FNroEfectoReemitido );
       SetFieldAsVariant( EfectoCobrarFields.FechaLibramiento, FFechaLibramiento );
       SetFieldAsVariant( EfectoCobrarFields.FechaEmision, FFechaEmision );
       SetFieldAsVariant( EfectoCobrarFields.FormaDePago, FFormaDePago );
       SetFieldAsVariant( EfectoCobrarFields.DiferenciaCambio, FDiferenciaCambio );
       SetFieldAsVariant( EfectoCobrarFields.GenerarEfectoDiferencia, FGenerarEfectoDiferencia );
       SetFieldAsVariant( EfectoCobrarFields.SubcuentaDiferencia, FSubcuentaDiferencia );
       SetFieldAsVariant( EfectoCobrarFields.NroEfectoDiferencia, FNroEfectoDiferencia );
       SetFieldAsVariant( EfectoCobrarFields.GastosGestion, FGastosGestion );
       SetFieldAsVariant( EfectoCobrarFields.GastosDevolucion, FGastosDevolucion );
       SetFieldAsVariant( EfectoCobrarFields.SubcuentaGastos, FSubcuentaGastos );
       SetFieldAsVariant( EfectoCobrarFields.NroAsientoCartera, FNroAsientoCartera );
       SetFieldAsVariant( EfectoCobrarFields.NroAsientoCobro, FNroAsientoCobro );
       SetFieldAsVariant( EfectoCobrarFields.FechaDescuento, FFechaDescuento );
       SetFieldAsVariant( EfectoCobrarFields.NroAsientoDescuento, FNroAsientoDescuento );
       SetFieldAsVariant( EfectoCobrarFields.FechaCancelacion, FFechaCancelacion );
       SetFieldAsVariant( EfectoCobrarFields.NroAstoCancelacion, FNroAstoCancelacion );
       SetFieldAsVariant( EfectoCobrarFields.FechaImpagado, FFechaImpagado );
       SetFieldAsVariant( EfectoCobrarFields.NroAsientoImpagado, FNroAsientoImpagado );

       If   ReadBlobs
       then SetFieldAsVariant( EfectoCobrarFields.Anotacion, FAnotacion )
       else EfectoCobrarFields.Anotacion.Clear;

     except
       EfectoCobrarFields.Dataset.Cancel;
       raise;
       end;

end;

function TEfectoCobrar.LoadFromReader( AReader : InxReader ) : HRESULT;

var VarFlags : TnxVarFlags;

begin
     nxReadVariant( VarFlags, FRemoteCursorID, AReader );
     nxReadVariant( VarFlags, FState, AReader );

     nxReadVariant( VarFlags, FEjercicio, AReader );
     nxReadVariant( VarFlags, FSerie, AReader );
     nxReadVariant( VarFlags, FNroFactura, AReader );
     nxReadVariant( VarFlags, FNroEfecto, AReader );
     nxReadVariant( VarFlags, FSubcuentaCliente, AReader );
     nxReadVariant( VarFlags, FSubcuentaEntidad, AReader );
     nxReadVariant( VarFlags, FFechaVencimiento, AReader );
     nxReadVariant( VarFlags, FFechaCobro, AReader );
     nxReadVariant( VarFlags, FConcepto, AReader );
     nxReadVariant( VarFlags, FEjercicioRemesa, AReader );
     nxReadVariant( VarFlags, FNroRemesa, AReader );
     nxReadVariant( VarFlags, FImporte, AReader );
     nxReadVariant( VarFlags, FImporteCobrado, AReader );
     nxReadVariant( VarFlags, FConceptoCobro, AReader );
     nxReadVariant( VarFlags, FCodigoCliente, AReader );
     nxReadVariant( VarFlags, FVendedor, AReader );
     nxReadVariant( VarFlags, FGrupoFacturacion, AReader );
     nxReadVariant( VarFlags, FRevisado, AReader );
     nxReadVariant( VarFlags, FImpagado, AReader );
     nxReadVariant( VarFlags, FCancelado, AReader );
     nxReadVariant( VarFlags, FVolverAEmitir, AReader );
     nxReadVariant( VarFlags, FNroEfectoReemitido, AReader );
     nxReadVariant( VarFlags, FFechaLibramiento, AReader );
     nxReadVariant( VarFlags, FFechaEmision, AReader );
     nxReadVariant( VarFlags, FFormaDePago, AReader );
     nxReadVariant( VarFlags, FDiferenciaCambio, AReader );
     nxReadVariant( VarFlags, FGenerarEfectoDiferencia, AReader );
     nxReadVariant( VarFlags, FSubcuentaDiferencia, AReader );
     nxReadVariant( VarFlags, FNroEfectoDiferencia, AReader );
     nxReadVariant( VarFlags, FGastosGestion, AReader );
     nxReadVariant( VarFlags, FGastosDevolucion, AReader );
     nxReadVariant( VarFlags, FSubcuentaGastos, AReader );
     nxReadVariant( VarFlags, FNroAsientoCartera, AReader );
     nxReadVariant( VarFlags, FNroAsientoCobro, AReader );
     nxReadVariant( VarFlags, FFechaDescuento, AReader );
     nxReadVariant( VarFlags, FNroAsientoDescuento, AReader );
     nxReadVariant( VarFlags, FFechaCancelacion, AReader );
     nxReadVariant( VarFlags, FNroAstoCancelacion, AReader );
     nxReadVariant( VarFlags, FFechaImpagado, AReader );
     nxReadVariant( VarFlags, FNroAsientoImpagado, AReader );
     nxReadVariant( VarFlags, FAnotacion, AReader );

     Result := S_OK;
end;

function TEfectoCobrar.SaveToWriter( AWriter : InxWriter) : HRESULT;
begin
     nxWriteVariant( FRemoteCursorID, AWriter );
     nxWriteVariant( FState, AWriter );

     nxWriteVariant( FEjercicio, AWriter );
     nxWriteVariant( FSerie, AWriter );
     nxWriteVariant( FNroFactura, AWriter );
     nxWriteVariant( FNroEfecto, AWriter );
     nxWriteVariant( FSubcuentaCliente, AWriter );
     nxWriteVariant( FSubcuentaEntidad, AWriter );
     nxWriteVariant( FFechaVencimiento, AWriter );
     nxWriteVariant( FFechaCobro, AWriter );
     nxWriteVariant( FConcepto, AWriter );
     nxWriteVariant( FEjercicioRemesa, AWriter );
     nxWriteVariant( FNroRemesa, AWriter );
     nxWriteVariant( FImporte, AWriter );
     nxWriteVariant( FImporteCobrado, AWriter );
     nxWriteVariant( FConceptoCobro, AWriter );
     nxWriteVariant( FCodigoCliente, AWriter );
     nxWriteVariant( FVendedor, AWriter );
     nxWriteVariant( FGrupoFacturacion, AWriter );
     nxWriteVariant( FRevisado, AWriter );
     nxWriteVariant( FImpagado, AWriter );
     nxWriteVariant( FCancelado, AWriter );
     nxWriteVariant( FVolverAEmitir, AWriter );
     nxWriteVariant( FNroEfectoReemitido, AWriter );
     nxWriteVariant( FFechaLibramiento, AWriter );
     nxWriteVariant( FFechaEmision, AWriter );
     nxWriteVariant( FFormaDePago, AWriter );
     nxWriteVariant( FDiferenciaCambio, AWriter );
     nxWriteVariant( FGenerarEfectoDiferencia, AWriter );
     nxWriteVariant( FSubcuentaDiferencia, AWriter );
     nxWriteVariant( FNroEfectoDiferencia, AWriter );
     nxWriteVariant( FGastosGestion, AWriter );
     nxWriteVariant( FGastosDevolucion, AWriter );
     nxWriteVariant( FSubcuentaGastos, AWriter );
     nxWriteVariant( FNroAsientoCartera, AWriter );
     nxWriteVariant( FNroAsientoCobro, AWriter );
     nxWriteVariant( FFechaDescuento, AWriter );
     nxWriteVariant( FNroAsientoDescuento, AWriter );
     nxWriteVariant( FFechaCancelacion, AWriter );
     nxWriteVariant( FNroAstoCancelacion, AWriter );
     nxWriteVariant( FFechaImpagado, AWriter );
     nxWriteVariant( FNroAsientoImpagado, AWriter );
     nxWriteVariant( FAnotacion, AWriter );
     Result := S_OK;
end;

{ Getters}

function TEfectoCobrar.GetClassID: TnxGuid;
begin
     Result := CLSID_EfectoCobrar;
end;

function TEfectoCobrar.GetRemoteCursorID: TnxCursorID;
begin
     Result := FRemoteCursorID;
end;

function TEfectoCobrar.GetState: TDataSetState;
begin
     Result := FState;
end;


function TEfectoCobrar.GetEjercicio : SmallInt;
begin
     Result := FEjercicio;
end;

function TEfectoCobrar.GetSerie : String;
begin
     Result := FSerie;
end;

function TEfectoCobrar.GetNroFactura : Integer;
begin
     Result := FNroFactura;
end;

function TEfectoCobrar.GetNroEfecto : SmallInt;
begin
     Result := FNroEfecto;
end;

function TEfectoCobrar.GetSubcuentaCliente : Variant;
begin
     Result := FSubcuentaCliente;
end;

function TEfectoCobrar.GetSubcuentaEntidad : Variant;
begin
     Result := FSubcuentaEntidad;
end;

function TEfectoCobrar.GetFechaVencimiento : Variant;
begin
     Result := FFechaVencimiento;
end;

function TEfectoCobrar.GetFechaCobro : Variant;
begin
     Result := FFechaCobro;
end;

function TEfectoCobrar.GetConcepto : Variant;
begin
     Result := FConcepto;
end;

function TEfectoCobrar.GetEjercicioRemesa : Variant;
begin
     Result := FEjercicioRemesa;
end;

function TEfectoCobrar.GetNroRemesa : Variant;
begin
     Result := FNroRemesa;
end;

function TEfectoCobrar.GetImporte : Variant;
begin
     Result := FImporte;
end;

function TEfectoCobrar.GetImporteCobrado : Variant;
begin
     Result := FImporteCobrado;
end;

function TEfectoCobrar.GetConceptoCobro : Variant;
begin
     Result := FConceptoCobro;
end;

function TEfectoCobrar.GetCodigoCliente : Variant;
begin
     Result := FCodigoCliente;
end;

function TEfectoCobrar.GetVendedor : Variant;
begin
     Result := FVendedor;
end;

function TEfectoCobrar.GetGrupoFacturacion : Variant;
begin
     Result := FGrupoFacturacion;
end;

function TEfectoCobrar.GetRevisado : Variant;
begin
     Result := FRevisado;
end;

function TEfectoCobrar.GetImpagado : Variant;
begin
     Result := FImpagado;
end;

function TEfectoCobrar.GetCancelado : Variant;
begin
     Result := FCancelado;
end;

function TEfectoCobrar.GetVolverAEmitir : Variant;
begin
     Result := FVolverAEmitir;
end;

function TEfectoCobrar.GetNroEfectoReemitido : Variant;
begin
     Result := FNroEfectoReemitido;
end;

function TEfectoCobrar.GetFechaLibramiento : Variant;
begin
     Result := FFechaLibramiento;
end;

function TEfectoCobrar.GetFechaEmision : Variant;
begin
     Result := FFechaEmision;
end;

function TEfectoCobrar.GetFormaDePago : Variant;
begin
     Result := FFormaDePago;
end;

function TEfectoCobrar.GetDiferenciaCambio : Variant;
begin
     Result := FDiferenciaCambio;
end;

function TEfectoCobrar.GetGenerarEfectoDiferencia : Variant;
begin
     Result := FGenerarEfectoDiferencia;
end;

function TEfectoCobrar.GetSubcuentaDiferencia : Variant;
begin
     Result := FSubcuentaDiferencia;
end;

function TEfectoCobrar.GetNroEfectoDiferencia : Variant;
begin
     Result := FNroEfectoDiferencia;
end;

function TEfectoCobrar.GetGastosGestion : Variant;
begin
     Result := FGastosGestion;
end;

function TEfectoCobrar.GetGastosDevolucion : Variant;
begin
     Result := FGastosDevolucion;
end;

function TEfectoCobrar.GetSubcuentaGastos : Variant;
begin
     Result := FSubcuentaGastos;
end;

function TEfectoCobrar.GetNroAsientoCartera : Variant;
begin
     Result := FNroAsientoCartera;
end;

function TEfectoCobrar.GetNroAsientoCobro : Variant;
begin
     Result := FNroAsientoCobro;
end;

function TEfectoCobrar.GetFechaDescuento : Variant;
begin
     Result := FFechaDescuento;
end;

function TEfectoCobrar.GetNroAsientoDescuento : Variant;
begin
     Result := FNroAsientoDescuento;
end;

function TEfectoCobrar.GetFechaCancelacion : Variant;
begin
     Result := FFechaCancelacion;
end;

function TEfectoCobrar.GetNroAstoCancelacion : Variant;
begin
     Result := FNroAstoCancelacion;
end;

function TEfectoCobrar.GetFechaImpagado : Variant;
begin
     Result := FFechaImpagado;
end;

function TEfectoCobrar.GetNroAsientoImpagado : Variant;
begin
     Result := FNroAsientoImpagado;
end;

function TEfectoCobrar.GetAnotacion : Variant;
begin
     Result := FAnotacion;
end;

{ Setters}

procedure TEfectoCobrar.SetRemoteCursorID( const Value : TnxCursorID );
begin
     FRemoteCursorID := Value;
end;

procedure TEfectoCobrar.SetState( const Value : TDataSetState );
begin
     FState := Value;
end;


procedure TEfectoCobrar.SetEjercicio(  const Value : SmallInt );
begin
     FEjercicio := Value;
end;

procedure TEfectoCobrar.SetSerie(  const Value : String );
begin
     FSerie := Value;
end;

procedure TEfectoCobrar.SetNroFactura(  const Value : Integer );
begin
     FNroFactura := Value;
end;

procedure TEfectoCobrar.SetNroEfecto(  const Value : SmallInt );
begin
     FNroEfecto := Value;
end;

procedure TEfectoCobrar.SetSubcuentaCliente(  const Value : Variant );
begin
     FSubcuentaCliente := Value;
end;

procedure TEfectoCobrar.SetSubcuentaEntidad(  const Value : Variant );
begin
     FSubcuentaEntidad := Value;
end;

procedure TEfectoCobrar.SetFechaVencimiento(  const Value : Variant );
begin
     FFechaVencimiento := Value;
end;

procedure TEfectoCobrar.SetFechaCobro(  const Value : Variant );
begin
     FFechaCobro := Value;
end;

procedure TEfectoCobrar.SetConcepto(  const Value : Variant );
begin
     FConcepto := Value;
end;

procedure TEfectoCobrar.SetEjercicioRemesa(  const Value : Variant );
begin
     FEjercicioRemesa := Value;
end;

procedure TEfectoCobrar.SetNroRemesa(  const Value : Variant );
begin
     FNroRemesa := Value;
end;

procedure TEfectoCobrar.SetImporte(  const Value : Variant );
begin
     FImporte := Value;
end;

procedure TEfectoCobrar.SetImporteCobrado(  const Value : Variant );
begin
     FImporteCobrado := Value;
end;

procedure TEfectoCobrar.SetConceptoCobro(  const Value : Variant );
begin
     FConceptoCobro := Value;
end;

procedure TEfectoCobrar.SetCodigoCliente(  const Value : Variant );
begin
     FCodigoCliente := Value;
end;

procedure TEfectoCobrar.SetVendedor(  const Value : Variant );
begin
     FVendedor := Value;
end;

procedure TEfectoCobrar.SetGrupoFacturacion(  const Value : Variant );
begin
     FGrupoFacturacion := Value;
end;

procedure TEfectoCobrar.SetRevisado(  const Value : Variant );
begin
     FRevisado := Value;
end;

procedure TEfectoCobrar.SetImpagado(  const Value : Variant );
begin
     FImpagado := Value;
end;

procedure TEfectoCobrar.SetCancelado(  const Value : Variant );
begin
     FCancelado := Value;
end;

procedure TEfectoCobrar.SetVolverAEmitir(  const Value : Variant );
begin
     FVolverAEmitir := Value;
end;

procedure TEfectoCobrar.SetNroEfectoReemitido(  const Value : Variant );
begin
     FNroEfectoReemitido := Value;
end;

procedure TEfectoCobrar.SetFechaLibramiento(  const Value : Variant );
begin
     FFechaLibramiento := Value;
end;

procedure TEfectoCobrar.SetFechaEmision(  const Value : Variant );
begin
     FFechaEmision := Value;
end;

procedure TEfectoCobrar.SetFormaDePago(  const Value : Variant );
begin
     FFormaDePago := Value;
end;

procedure TEfectoCobrar.SetDiferenciaCambio(  const Value : Variant );
begin
     FDiferenciaCambio := Value;
end;

procedure TEfectoCobrar.SetGenerarEfectoDiferencia(  const Value : Variant );
begin
     FGenerarEfectoDiferencia := Value;
end;

procedure TEfectoCobrar.SetSubcuentaDiferencia(  const Value : Variant );
begin
     FSubcuentaDiferencia := Value;
end;

procedure TEfectoCobrar.SetNroEfectoDiferencia(  const Value : Variant );
begin
     FNroEfectoDiferencia := Value;
end;

procedure TEfectoCobrar.SetGastosGestion(  const Value : Variant );
begin
     FGastosGestion := Value;
end;

procedure TEfectoCobrar.SetGastosDevolucion(  const Value : Variant );
begin
     FGastosDevolucion := Value;
end;

procedure TEfectoCobrar.SetSubcuentaGastos(  const Value : Variant );
begin
     FSubcuentaGastos := Value;
end;

procedure TEfectoCobrar.SetNroAsientoCartera(  const Value : Variant );
begin
     FNroAsientoCartera := Value;
end;

procedure TEfectoCobrar.SetNroAsientoCobro(  const Value : Variant );
begin
     FNroAsientoCobro := Value;
end;

procedure TEfectoCobrar.SetFechaDescuento(  const Value : Variant );
begin
     FFechaDescuento := Value;
end;

procedure TEfectoCobrar.SetNroAsientoDescuento(  const Value : Variant );
begin
     FNroAsientoDescuento := Value;
end;

procedure TEfectoCobrar.SetFechaCancelacion(  const Value : Variant );
begin
     FFechaCancelacion := Value;
end;

procedure TEfectoCobrar.SetNroAstoCancelacion(  const Value : Variant );
begin
     FNroAstoCancelacion := Value;
end;

procedure TEfectoCobrar.SetFechaImpagado(  const Value : Variant );
begin
     FFechaImpagado := Value;
end;

procedure TEfectoCobrar.SetNroAsientoImpagado(  const Value : Variant );
begin
     FNroAsientoImpagado := Value;
end;

procedure TEfectoCobrar.SetAnotacion(  const Value : Variant );
begin
     FAnotacion := Value;
end;

var EfectoCobrarControl : InxClassFactoryControl;

initialization
   nxInvokeRegistry.RegisterInterface( TypeInfo( IEfectoCobrar ) );

   TnxClassFactory.RegisterClass( CLSID_EfectoCobrar, TEfectoCobrar, EfectoCobrarControl );

end.
