{$ALIGN OFF}
{$OPTIMIZATION OFF}

unit FacturaComprasIntf;

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

      Gim10Fields,
      Gim30Fields;

const
  CLSID_FacturaCompras : TnxGuid = '{AEE7FC95-DEEF-45BF-9C4D-480BC4D8CBFE}';

type

  IFacturaCompras = interface( IInvokableRecord )
    [ '{BA45FDBA-9056-4821-A7A9-72D7691141FA}' ] 

    procedure ToDataset( FacturaComprasFields : TFacturaComprasFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );
    function GetRemoteCursorID : TnxCursorID;
    procedure SetRemoteCursorID( const Value : TnxCursorID );
    function GetState : TDataSetState;
    procedure SetState( const Value : TDataSetState );

    // Los campos que forman parte de un índice es conveniente que no sean Variants.
    // El resto, sin embargo, pueden ser valores nulos, o el campo no estar definido en el dataset.

    function GetEjercicio : SmallInt;
    function GetProveedor : String;
    function GetSerieNroFactura : String;
    function GetFechaRecepcion : Variant;
    function GetFecha : Variant;
    function GetBrutoArticulos : Variant;
    function GetDescuentoArticulos : Variant;
    function GetDescuentoProveedores : Variant;
    function GetImportePuntoVerde : Variant;
    function GetNetoFactura : Variant;
    function GetNetoFacturaRetencion : Variant;
    function GetOrigen : Variant;
    function GetBaseCalculoRetencion : Variant;
    function GetTipoRetencion : Variant;
    function GetImporteRetencion : Variant;
    function GetRecargoFinanciero : Variant;
    function GetImporteRecFinanciero : Variant;
    function GetCuotaIVA : Variant;
    function GetPortes : Variant;
    function GetTotalFactura : Variant;
    function GetDescuentoPP : Variant;
    function GetImporteDtoPP : Variant;
    function GetDescuentoES : Variant;
    function GetImporteDtoES : Variant;
    function GetCodigoFormaPago : Variant;
    function GetDiaPago1 : Variant;
    function GetDiaPago2 : Variant;
    function GetNroRegistro : Variant;
    function GetTraspasada : Variant;
    function GetPagoBloqueado : Variant;
    function GetMotivoBloqueoPago : Variant;
    function GetAnotacion : Variant;

    procedure SetEjercicio( const Value  : SmallInt );
    procedure SetProveedor( const Value  : String );
    procedure SetSerieNroFactura( const Value  : String );
    procedure SetFechaRecepcion( const Value  : Variant );
    procedure SetFecha( const Value  : Variant );
    procedure SetBrutoArticulos( const Value  : Variant );
    procedure SetDescuentoArticulos( const Value  : Variant );
    procedure SetDescuentoProveedores( const Value  : Variant );
    procedure SetImportePuntoVerde( const Value  : Variant );
    procedure SetNetoFactura( const Value  : Variant );
    procedure SetNetoFacturaRetencion( const Value  : Variant );
    procedure SetOrigen( const Value  : Variant );
    procedure SetBaseCalculoRetencion( const Value  : Variant );
    procedure SetTipoRetencion( const Value  : Variant );
    procedure SetImporteRetencion( const Value  : Variant );
    procedure SetRecargoFinanciero( const Value  : Variant );
    procedure SetImporteRecFinanciero( const Value  : Variant );
    procedure SetCuotaIVA( const Value  : Variant );
    procedure SetPortes( const Value  : Variant );
    procedure SetTotalFactura( const Value  : Variant );
    procedure SetDescuentoPP( const Value  : Variant );
    procedure SetImporteDtoPP( const Value  : Variant );
    procedure SetDescuentoES( const Value  : Variant );
    procedure SetImporteDtoES( const Value  : Variant );
    procedure SetCodigoFormaPago( const Value  : Variant );
    procedure SetDiaPago1( const Value  : Variant );
    procedure SetDiaPago2( const Value  : Variant );
    procedure SetNroRegistro( const Value  : Variant );
    procedure SetTraspasada( const Value  : Variant );
    procedure SetPagoBloqueado( const Value  : Variant );
    procedure SetMotivoBloqueoPago( const Value  : Variant );
    procedure SetAnotacion( const Value  : Variant );
    property RemoteCursorID : TnxCursorID read GetRemoteCursorID write SetRemoteCursorID;
    property State : TDatasetState read GetState write SetState;

    property Ejercicio : SmallInt read GetEjercicio write SetEjercicio;
    property Proveedor : String read GetProveedor write SetProveedor;
    property SerieNroFactura : String read GetSerieNroFactura write SetSerieNroFactura;
    property FechaRecepcion : Variant read GetFechaRecepcion write SetFechaRecepcion;
    property Fecha : Variant read GetFecha write SetFecha;
    property BrutoArticulos : Variant read GetBrutoArticulos write SetBrutoArticulos;
    property DescuentoArticulos : Variant read GetDescuentoArticulos write SetDescuentoArticulos;
    property DescuentoProveedores : Variant read GetDescuentoProveedores write SetDescuentoProveedores;
    property ImportePuntoVerde : Variant read GetImportePuntoVerde write SetImportePuntoVerde;
    property NetoFactura : Variant read GetNetoFactura write SetNetoFactura;
    property NetoFacturaRetencion : Variant read GetNetoFacturaRetencion write SetNetoFacturaRetencion;
    property Origen : Variant read GetOrigen write SetOrigen;
    property BaseCalculoRetencion : Variant read GetBaseCalculoRetencion write SetBaseCalculoRetencion;
    property TipoRetencion : Variant read GetTipoRetencion write SetTipoRetencion;
    property ImporteRetencion : Variant read GetImporteRetencion write SetImporteRetencion;
    property RecargoFinanciero : Variant read GetRecargoFinanciero write SetRecargoFinanciero;
    property ImporteRecFinanciero : Variant read GetImporteRecFinanciero write SetImporteRecFinanciero;
    property CuotaIVA : Variant read GetCuotaIVA write SetCuotaIVA;
    property Portes : Variant read GetPortes write SetPortes;
    property TotalFactura : Variant read GetTotalFactura write SetTotalFactura;
    property DescuentoPP : Variant read GetDescuentoPP write SetDescuentoPP;
    property ImporteDtoPP : Variant read GetImporteDtoPP write SetImporteDtoPP;
    property DescuentoES : Variant read GetDescuentoES write SetDescuentoES;
    property ImporteDtoES : Variant read GetImporteDtoES write SetImporteDtoES;
    property CodigoFormaPago : Variant read GetCodigoFormaPago write SetCodigoFormaPago;
    property DiaPago1 : Variant read GetDiaPago1 write SetDiaPago1;
    property DiaPago2 : Variant read GetDiaPago2 write SetDiaPago2;
    property NroRegistro : Variant read GetNroRegistro write SetNroRegistro;
    property Traspasada : Variant read GetTraspasada write SetTraspasada;
    property PagoBloqueado : Variant read GetPagoBloqueado write SetPagoBloqueado;
    property MotivoBloqueoPago : Variant read GetMotivoBloqueoPago write SetMotivoBloqueoPago;
    property Anotacion : Variant read GetAnotacion write SetAnotacion;

    end;

   TFacturaCompras = class( TnxClass, InxRemoteableClass, IFacturaCompras)
     private

     FRemoteCursorID,
     FState : Variant;

     FEjercicio,
     FProveedor,
     FSerieNroFactura,
     FFechaRecepcion,
     FFecha,
     FBrutoArticulos,
     FDescuentoArticulos,
     FDescuentoProveedores,
     FImportePuntoVerde,
     FNetoFactura,
     FNetoFacturaRetencion,
     FOrigen : Variant;
     FBaseCalculoRetencion,
     FTipoRetencion,
     FImporteRetencion,
     FRecargoFinanciero,
     FImporteRecFinanciero,
     FCuotaIVA,
     FPortes,
     FTotalFactura,
     FDescuentoPP,
     FImporteDtoPP,
     FDescuentoES,
     FImporteDtoES,
     FCodigoFormaPago,
     FDiaPago1,
     FDiaPago2,
     FNroRegistro,
     FTraspasada,
     FPagoBloqueado,
     FMotivoBloqueoPago,
     FAnotacion : Variant;

     function GetEjercicio : SmallInt;
     function GetProveedor : String;
     function GetSerieNroFactura : String;
     function GetFechaRecepcion : Variant;
     function GetFecha : Variant;
     function GetBrutoArticulos : Variant;
     function GetDescuentoArticulos : Variant;
     function GetDescuentoProveedores : Variant;
     function GetImportePuntoVerde : Variant;
     function GetNetoFactura : Variant;
     function GetNetoFacturaRetencion : Variant;
     function GetOrigen : Variant;
     function GetBaseCalculoRetencion : Variant;
     function GetTipoRetencion : Variant;
     function GetImporteRetencion : Variant;
     function GetRecargoFinanciero : Variant;
     function GetImporteRecFinanciero : Variant;
     function GetCuotaIVA : Variant;
     function GetPortes : Variant;
     function GetTotalFactura : Variant;
     function GetDescuentoPP : Variant;
     function GetImporteDtoPP : Variant;
     function GetDescuentoES : Variant;
     function GetImporteDtoES : Variant;
     function GetCodigoFormaPago : Variant;
     function GetDiaPago1 : Variant;
     function GetDiaPago2 : Variant;
     function GetNroRegistro : Variant;
     function GetTraspasada : Variant;
     function GetPagoBloqueado : Variant;
     function GetMotivoBloqueoPago : Variant;
     function GetAnotacion : Variant;

     procedure SetEjercicio( const Value  : SmallInt );
     procedure SetProveedor( const Value  : String );
     procedure SetSerieNroFactura( const Value  : String );
     procedure SetFechaRecepcion( const Value  : Variant );
     procedure SetFecha( const Value  : Variant );
     procedure SetBrutoArticulos( const Value  : Variant );
     procedure SetDescuentoArticulos( const Value  : Variant );
     procedure SetDescuentoProveedores( const Value  : Variant );
     procedure SetImportePuntoVerde( const Value  : Variant );
     procedure SetNetoFactura( const Value  : Variant );
     procedure SetNetoFacturaRetencion( const Value  : Variant );
     procedure SetOrigen( const Value  : Variant );
     procedure SetBaseCalculoRetencion( const Value  : Variant );
     procedure SetTipoRetencion( const Value  : Variant );
     procedure SetImporteRetencion( const Value  : Variant );
     procedure SetRecargoFinanciero( const Value  : Variant );
     procedure SetImporteRecFinanciero( const Value  : Variant );
     procedure SetCuotaIVA( const Value  : Variant );
     procedure SetPortes( const Value  : Variant );
     procedure SetTotalFactura( const Value  : Variant );
     procedure SetDescuentoPP( const Value  : Variant );
     procedure SetImporteDtoPP( const Value  : Variant );
     procedure SetDescuentoES( const Value  : Variant );
     procedure SetImporteDtoES( const Value  : Variant );
     procedure SetCodigoFormaPago( const Value  : Variant );
     procedure SetDiaPago1( const Value  : Variant );
     procedure SetDiaPago2( const Value  : Variant );
     procedure SetNroRegistro( const Value  : Variant );
     procedure SetTraspasada( const Value  : Variant );
     procedure SetPagoBloqueado( const Value  : Variant );
     procedure SetMotivoBloqueoPago( const Value  : Variant );
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

     class function FromDataset( FacturaComprasFields  : TFacturaComprasFields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : IFacturaCompras;
     procedure ToDataset( FacturaComprasFields : TFacturaComprasFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );

     end;

implementation

uses  Variants;

{ TFacturaCompras }

constructor TFacturaCompras.Create;
begin
     inherited Create( @CLSID_FacturaCompras, nil, nil, False);
     FState := dsInsert;
end;

class function TFacturaCompras.FromDataset( FacturaComprasFields : TFacturaComprasFields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : IFacturaCompras;

var   SaveState : TDataSetState;
      ApplyOldValues : Boolean;

begin
      Result := TFacturaCompras.Create;

      With Result do
        begin

        RemoteCursorID := FacturaComprasFields.GetRemoteCursorID;
        State := FacturaComprasFields.Dataset.State;
        SaveState := State;

        ApplyOldValues := OldValues and not ( State in [ dsInsert, dsSetKey ] );
        If   ApplyOldValues
        then FacturaComprasFields.IDataset.SetTempState( dsOldValue );

        try

          Ejercicio := GetFieldAsVariant( FacturaComprasFields.Ejercicio );
          Proveedor := GetFieldAsVariant( FacturaComprasFields.Proveedor );
          SerieNroFactura := GetFieldAsVariant( FacturaComprasFields.SerieNroFactura );
          FechaRecepcion := GetFieldAsVariant( FacturaComprasFields.FechaRecepcion );
          Fecha := GetFieldAsVariant( FacturaComprasFields.Fecha );
          BrutoArticulos := GetFieldAsVariant( FacturaComprasFields.BrutoArticulos );
          DescuentoArticulos := GetFieldAsVariant( FacturaComprasFields.DescuentoArticulos );
          DescuentoProveedores := GetFieldAsVariant( FacturaComprasFields.DescuentoProveedores );
          ImportePuntoVerde := GetFieldAsVariant( FacturaComprasFields.ImportePuntoVerde );
          NetoFactura := GetFieldAsVariant( FacturaComprasFields.NetoFactura );
          NetoFacturaRetencion := GetFieldAsVariant( FacturaComprasFields.NetoFacturaRetencion );
          Origen := GetFieldAsVariant( FacturaComprasFields.Origen );
          BaseCalculoRetencion := GetFieldAsVariant( FacturaComprasFields.BaseCalculoRetencion );
          TipoRetencion := GetFieldAsVariant( FacturaComprasFields.TipoRetencion );
          ImporteRetencion := GetFieldAsVariant( FacturaComprasFields.ImporteRetencion );
          RecargoFinanciero := GetFieldAsVariant( FacturaComprasFields.RecargoFinanciero );
          ImporteRecFinanciero := GetFieldAsVariant( FacturaComprasFields.ImporteRecFinanciero );
          CuotaIVA := GetFieldAsVariant( FacturaComprasFields.CuotaIVA );
          Portes := GetFieldAsVariant( FacturaComprasFields.Portes );
          TotalFactura := GetFieldAsVariant( FacturaComprasFields.TotalFactura );
          DescuentoPP := GetFieldAsVariant( FacturaComprasFields.DescuentoPP );
          ImporteDtoPP := GetFieldAsVariant( FacturaComprasFields.ImporteDtoPP );
          DescuentoES := GetFieldAsVariant( FacturaComprasFields.DescuentoES );
          ImporteDtoES := GetFieldAsVariant( FacturaComprasFields.ImporteDtoES );
          CodigoFormaPago := GetFieldAsVariant( FacturaComprasFields.CodigoFormaPago );
          DiaPago1 := GetFieldAsVariant( FacturaComprasFields.DiaPago1 );
          DiaPago2 := GetFieldAsVariant( FacturaComprasFields.DiaPago2 );
          NroRegistro := GetFieldAsVariant( FacturaComprasFields.NroRegistro );
          Traspasada := GetFieldAsVariant( FacturaComprasFields.Traspasada );
          PagoBloqueado := GetFieldAsVariant( FacturaComprasFields.PagoBloqueado );

          If   ReadBlobs
          then begin
               MotivoBloqueoPago := GetFieldAsVariant( FacturaComprasFields.MotivoBloqueoPago );
               Anotacion := GetFieldAsVariant( FacturaComprasFields.Anotacion );
               end
          else begin
               MotivoBloqueoPago := '';
               Anotacion := '';
               end;

        finally
          If   ApplyOldValues
          then FacturaComprasFields.IDataset.RestoreState( SaveState );
        end;
      end;

end;

procedure TFacturaCompras.ToDataset( FacturaComprasFields : TFacturaComprasFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );
begin
     try

       If   not PreserveState
       then FacturaComprasFields.SetStateFromInterface( FState );

       FacturaComprasFields.Ejercicio.Value := FEjercicio;
       FacturaComprasFields.Proveedor.Value := FProveedor;
       FacturaComprasFields.SerieNroFactura.Value := FSerieNroFactura;

       SetFieldAsVariant( FacturaComprasFields.FechaRecepcion, FFechaRecepcion );
       SetFieldAsVariant( FacturaComprasFields.Fecha, FFecha );
       SetFieldAsVariant( FacturaComprasFields.BrutoArticulos, FBrutoArticulos );
       SetFieldAsVariant( FacturaComprasFields.DescuentoArticulos, FDescuentoArticulos );
       SetFieldAsVariant( FacturaComprasFields.DescuentoProveedores, FDescuentoProveedores );
       SetFieldAsVariant( FacturaComprasFields.ImportePuntoVerde, FImportePuntoVerde );
       SetFieldAsVariant( FacturaComprasFields.NetoFactura, FNetoFactura );
       SetFieldAsVariant( FacturaComprasFields.NetoFacturaRetencion, FNetoFacturaRetencion );
       SetFieldAsVariant( FacturaComprasFields.Origen, FOrigen );
       SetFieldAsVariant( FacturaComprasFields.BaseCalculoRetencion, FBaseCalculoRetencion );
       SetFieldAsVariant( FacturaComprasFields.TipoRetencion, FTipoRetencion );
       SetFieldAsVariant( FacturaComprasFields.ImporteRetencion, FImporteRetencion );
       SetFieldAsVariant( FacturaComprasFields.RecargoFinanciero, FRecargoFinanciero );
       SetFieldAsVariant( FacturaComprasFields.ImporteRecFinanciero, FImporteRecFinanciero );
       SetFieldAsVariant( FacturaComprasFields.CuotaIVA, FCuotaIVA );
       SetFieldAsVariant( FacturaComprasFields.Portes, FPortes );
       SetFieldAsVariant( FacturaComprasFields.TotalFactura, FTotalFactura );
       SetFieldAsVariant( FacturaComprasFields.DescuentoPP, FDescuentoPP );
       SetFieldAsVariant( FacturaComprasFields.ImporteDtoPP, FImporteDtoPP );
       SetFieldAsVariant( FacturaComprasFields.DescuentoES, FDescuentoES );
       SetFieldAsVariant( FacturaComprasFields.ImporteDtoES, FImporteDtoES );
       SetFieldAsVariant( FacturaComprasFields.CodigoFormaPago, FCodigoFormaPago );
       SetFieldAsVariant( FacturaComprasFields.DiaPago1, FDiaPago1 );
       SetFieldAsVariant( FacturaComprasFields.DiaPago2, FDiaPago2 );
       SetFieldAsVariant( FacturaComprasFields.NroRegistro, FNroRegistro );
       SetFieldAsVariant( FacturaComprasFields.Traspasada, FTraspasada );
       SetFieldAsVariant( FacturaComprasFields.PagoBloqueado, FPagoBloqueado );

       If   ReadBlobs
       then begin
            SetFieldAsVariant( FacturaComprasFields.MotivoBloqueoPago, FMotivoBloqueoPago );
            SetFieldAsVariant( FacturaComprasFields.Anotacion, FAnotacion );
            end
       else begin
            FacturaComprasFields.MotivoBloqueoPago.Clear;
            FacturaComprasFields.Anotacion.Clear;
            end;;

     except
       FacturaComprasFields.Dataset.Cancel;
       raise;
       end;

end;

function TFacturaCompras.LoadFromReader( AReader : InxReader ) : HRESULT;

var VarFlags : TnxVarFlags;

begin
     nxReadVariant( VarFlags, FRemoteCursorID, AReader );
     nxReadVariant( VarFlags, FState, AReader );

     nxReadVariant( VarFlags, FEjercicio, AReader );
     nxReadVariant( VarFlags, FProveedor, AReader );
     nxReadVariant( VarFlags, FSerieNroFactura, AReader );
     nxReadVariant( VarFlags, FFechaRecepcion, AReader );
     nxReadVariant( VarFlags, FFecha, AReader );
     nxReadVariant( VarFlags, FBrutoArticulos, AReader );
     nxReadVariant( VarFlags, FDescuentoArticulos, AReader );
     nxReadVariant( VarFlags, FDescuentoProveedores, AReader );
     nxReadVariant( VarFlags, FImportePuntoVerde, AReader );
     nxReadVariant( VarFlags, FNetoFactura, AReader );
     nxReadVariant( VarFlags, FNetoFacturaRetencion, AReader );
     nxReadVariant( VarFlags, FOrigen, AReader );
     nxReadVariant( VarFlags, FBaseCalculoRetencion, AReader );
     nxReadVariant( VarFlags, FTipoRetencion, AReader );
     nxReadVariant( VarFlags, FImporteRetencion, AReader );
     nxReadVariant( VarFlags, FRecargoFinanciero, AReader );
     nxReadVariant( VarFlags, FImporteRecFinanciero, AReader );
     nxReadVariant( VarFlags, FCuotaIVA, AReader );
     nxReadVariant( VarFlags, FPortes, AReader );
     nxReadVariant( VarFlags, FTotalFactura, AReader );
     nxReadVariant( VarFlags, FDescuentoPP, AReader );
     nxReadVariant( VarFlags, FImporteDtoPP, AReader );
     nxReadVariant( VarFlags, FDescuentoES, AReader );
     nxReadVariant( VarFlags, FImporteDtoES, AReader );
     nxReadVariant( VarFlags, FCodigoFormaPago, AReader );
     nxReadVariant( VarFlags, FDiaPago1, AReader );
     nxReadVariant( VarFlags, FDiaPago2, AReader );
     nxReadVariant( VarFlags, FNroRegistro, AReader );
     nxReadVariant( VarFlags, FTraspasada, AReader );
     nxReadVariant( VarFlags, FPagoBloqueado, AReader );
     nxReadVariant( VarFlags, FMotivoBloqueoPago, AReader );
     nxReadVariant( VarFlags, FAnotacion, AReader );

     Result := S_OK;
end;

function TFacturaCompras.SaveToWriter( AWriter : InxWriter) : HRESULT;
begin
     nxWriteVariant( FRemoteCursorID, AWriter );
     nxWriteVariant( FState, AWriter );

     nxWriteVariant( FEjercicio, AWriter );
     nxWriteVariant( FProveedor, AWriter );
     nxWriteVariant( FSerieNroFactura, AWriter );
     nxWriteVariant( FFechaRecepcion, AWriter );
     nxWriteVariant( FFecha, AWriter );
     nxWriteVariant( FBrutoArticulos, AWriter );
     nxWriteVariant( FDescuentoArticulos, AWriter );
     nxWriteVariant( FDescuentoProveedores, AWriter );
     nxWriteVariant( FImportePuntoVerde, AWriter );
     nxWriteVariant( FNetoFactura, AWriter );
     nxWriteVariant( FNetoFacturaRetencion, AWriter );
     nxWriteVariant( FOrigen, AWriter );
     nxWriteVariant( FBaseCalculoRetencion, AWriter );
     nxWriteVariant( FTipoRetencion, AWriter );
     nxWriteVariant( FImporteRetencion, AWriter );
     nxWriteVariant( FRecargoFinanciero, AWriter );
     nxWriteVariant( FImporteRecFinanciero, AWriter );
     nxWriteVariant( FCuotaIVA, AWriter );
     nxWriteVariant( FPortes, AWriter );
     nxWriteVariant( FTotalFactura, AWriter );
     nxWriteVariant( FDescuentoPP, AWriter );
     nxWriteVariant( FImporteDtoPP, AWriter );
     nxWriteVariant( FDescuentoES, AWriter );
     nxWriteVariant( FImporteDtoES, AWriter );
     nxWriteVariant( FCodigoFormaPago, AWriter );
     nxWriteVariant( FDiaPago1, AWriter );
     nxWriteVariant( FDiaPago2, AWriter );
     nxWriteVariant( FNroRegistro, AWriter );
     nxWriteVariant( FTraspasada, AWriter );
     nxWriteVariant( FPagoBloqueado, AWriter );
     nxWriteVariant( FMotivoBloqueoPago, AWriter );
     nxWriteVariant( FAnotacion, AWriter );
     Result := S_OK;
end;

{ Getters}

function TFacturaCompras.GetClassID: TnxGuid;
begin
     Result := CLSID_FacturaCompras;
end;

function TFacturaCompras.GetRemoteCursorID: TnxCursorID;
begin
     Result := FRemoteCursorID;
end;

function TFacturaCompras.GetState: TDataSetState;
begin
     Result := FState;
end;


function TFacturaCompras.GetEjercicio : SmallInt;
begin
     Result := FEjercicio;
end;

function TFacturaCompras.GetProveedor : String;
begin
     Result := FProveedor;
end;

function TFacturaCompras.GetSerieNroFactura : String;
begin
     Result := FSerieNroFactura;
end;

function TFacturaCompras.GetFechaRecepcion : Variant;
begin
     Result := FFechaRecepcion;
end;

function TFacturaCompras.GetFecha : Variant;
begin
     Result := FFecha;
end;

function TFacturaCompras.GetBrutoArticulos : Variant;
begin
     Result := FBrutoArticulos;
end;

function TFacturaCompras.GetDescuentoArticulos : Variant;
begin
     Result := FDescuentoArticulos;
end;

function TFacturaCompras.GetDescuentoProveedores : Variant;
begin
     Result := FDescuentoProveedores;
end;

function TFacturaCompras.GetImportePuntoVerde : Variant;
begin
     Result := FImportePuntoVerde;
end;

function TFacturaCompras.GetNetoFactura : Variant;
begin
     Result := FNetoFactura;
end;

function TFacturaCompras.GetNetoFacturaRetencion : Variant;
begin
     Result := FNetoFacturaRetencion;
end;

function TFacturaCompras.GetOrigen : Variant;
begin
     Result := FOrigen;
end;

function TFacturaCompras.GetBaseCalculoRetencion : Variant;
begin
     Result := FBaseCalculoRetencion;
end;

function TFacturaCompras.GetTipoRetencion : Variant;
begin
     Result := FTipoRetencion;
end;

function TFacturaCompras.GetImporteRetencion : Variant;
begin
     Result := FImporteRetencion;
end;

function TFacturaCompras.GetRecargoFinanciero : Variant;
begin
     Result := FRecargoFinanciero;
end;

function TFacturaCompras.GetImporteRecFinanciero : Variant;
begin
     Result := FImporteRecFinanciero;
end;

function TFacturaCompras.GetCuotaIVA : Variant;
begin
     Result := FCuotaIVA;
end;

function TFacturaCompras.GetPortes : Variant;
begin
     Result := FPortes;
end;

function TFacturaCompras.GetTotalFactura : Variant;
begin
     Result := FTotalFactura;
end;

function TFacturaCompras.GetDescuentoPP : Variant;
begin
     Result := FDescuentoPP;
end;

function TFacturaCompras.GetImporteDtoPP : Variant;
begin
     Result := FImporteDtoPP;
end;

function TFacturaCompras.GetDescuentoES : Variant;
begin
     Result := FDescuentoES;
end;

function TFacturaCompras.GetImporteDtoES : Variant;
begin
     Result := FImporteDtoES;
end;

function TFacturaCompras.GetCodigoFormaPago : Variant;
begin
     Result := FCodigoFormaPago;
end;

function TFacturaCompras.GetDiaPago1 : Variant;
begin
     Result := FDiaPago1;
end;

function TFacturaCompras.GetDiaPago2 : Variant;
begin
     Result := FDiaPago2;
end;

function TFacturaCompras.GetNroRegistro : Variant;
begin
     Result := FNroRegistro;
end;

function TFacturaCompras.GetTraspasada : Variant;
begin
     Result := FTraspasada;
end;

function TFacturaCompras.GetPagoBloqueado : Variant;
begin
     Result := FPagoBloqueado;
end;

function TFacturaCompras.GetMotivoBloqueoPago : Variant;
begin
     Result := FMotivoBloqueoPago;
end;

function TFacturaCompras.GetAnotacion : Variant;
begin
     Result := FAnotacion;
end;

{ Setters}

procedure TFacturaCompras.SetRemoteCursorID( const Value : TnxCursorID );
begin
     FRemoteCursorID := Value;
end;

procedure TFacturaCompras.SetState( const Value : TDataSetState );
begin
     FState := Value;
end;


procedure TFacturaCompras.SetEjercicio(  const Value : SmallInt );
begin
     FEjercicio := Value;
end;

procedure TFacturaCompras.SetProveedor(  const Value : String );
begin
     FProveedor := Value;
end;

procedure TFacturaCompras.SetSerieNroFactura(  const Value : String );
begin
     FSerieNroFactura := Value;
end;

procedure TFacturaCompras.SetFechaRecepcion(  const Value : Variant );
begin
     FFechaRecepcion := Value;
end;

procedure TFacturaCompras.SetFecha(  const Value : Variant );
begin
     FFecha := Value;
end;

procedure TFacturaCompras.SetBrutoArticulos(  const Value : Variant );
begin
     FBrutoArticulos := Value;
end;

procedure TFacturaCompras.SetDescuentoArticulos(  const Value : Variant );
begin
     FDescuentoArticulos := Value;
end;

procedure TFacturaCompras.SetDescuentoProveedores(  const Value : Variant );
begin
     FDescuentoProveedores := Value;
end;

procedure TFacturaCompras.SetImportePuntoVerde(  const Value : Variant );
begin
     FImportePuntoVerde := Value;
end;

procedure TFacturaCompras.SetNetoFactura(  const Value : Variant );
begin
     FNetoFactura := Value;
end;

procedure TFacturaCompras.SetNetoFacturaRetencion(  const Value : Variant );
begin
     FNetoFacturaRetencion := Value;
end;

procedure TFacturaCompras.SetOrigen(  const Value : Variant );
begin
     FOrigen := Value;
end;

procedure TFacturaCompras.SetBaseCalculoRetencion(  const Value : Variant );
begin
     FBaseCalculoRetencion := Value;
end;

procedure TFacturaCompras.SetTipoRetencion(  const Value : Variant );
begin
     FTipoRetencion := Value;
end;

procedure TFacturaCompras.SetImporteRetencion(  const Value : Variant );
begin
     FImporteRetencion := Value;
end;

procedure TFacturaCompras.SetRecargoFinanciero(  const Value : Variant );
begin
     FRecargoFinanciero := Value;
end;

procedure TFacturaCompras.SetImporteRecFinanciero(  const Value : Variant );
begin
     FImporteRecFinanciero := Value;
end;

procedure TFacturaCompras.SetCuotaIVA(  const Value : Variant );
begin
     FCuotaIVA := Value;
end;

procedure TFacturaCompras.SetPortes(  const Value : Variant );
begin
     FPortes := Value;
end;

procedure TFacturaCompras.SetTotalFactura(  const Value : Variant );
begin
     FTotalFactura := Value;
end;

procedure TFacturaCompras.SetDescuentoPP(  const Value : Variant );
begin
     FDescuentoPP := Value;
end;

procedure TFacturaCompras.SetImporteDtoPP(  const Value : Variant );
begin
     FImporteDtoPP := Value;
end;

procedure TFacturaCompras.SetDescuentoES(  const Value : Variant );
begin
     FDescuentoES := Value;
end;

procedure TFacturaCompras.SetImporteDtoES(  const Value : Variant );
begin
     FImporteDtoES := Value;
end;

procedure TFacturaCompras.SetCodigoFormaPago(  const Value : Variant );
begin
     FCodigoFormaPago := Value;
end;

procedure TFacturaCompras.SetDiaPago1(  const Value : Variant );
begin
     FDiaPago1 := Value;
end;

procedure TFacturaCompras.SetDiaPago2(  const Value : Variant );
begin
     FDiaPago2 := Value;
end;

procedure TFacturaCompras.SetNroRegistro(  const Value : Variant );
begin
     FNroRegistro := Value;
end;

procedure TFacturaCompras.SetTraspasada(  const Value : Variant );
begin
     FTraspasada := Value;
end;

procedure TFacturaCompras.SetPagoBloqueado(  const Value : Variant );
begin
     FPagoBloqueado := Value;
end;

procedure TFacturaCompras.SetMotivoBloqueoPago(  const Value : Variant );
begin
     FMotivoBloqueoPago := Value;
end;

procedure TFacturaCompras.SetAnotacion(  const Value : Variant );
begin
     FAnotacion := Value;
end;

var FacturaComprasControl : InxClassFactoryControl;

initialization
   nxInvokeRegistry.RegisterInterface( TypeInfo( IFacturaCompras ) );

   TnxClassFactory.RegisterClass( CLSID_FacturaCompras, TFacturaCompras, FacturaComprasControl );

end.
