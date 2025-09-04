{$ALIGN OFF}
{$OPTIMIZATION OFF}

unit FacturaVentasIntf;

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
  CLSID_FacturaVentas : TnxGuid = '{FC54622F-00EC-43DF-AF13-13D0866B0C68}';

type

  IFacturaVentas = interface( IInvokableRecord )
    [ '{0B2F200A-E559-44FC-93D3-1FEDB21AD738}' ] 

    procedure ToDataset( FacturaVentasFields : TFacturaVentasFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );
    function GetRemoteCursorID : TnxCursorID;
    procedure SetRemoteCursorID( const Value : TnxCursorID );
    function GetState : TDataSetState;
    procedure SetState( const Value : TDataSetState );

    // Los campos que forman parte de un índice es conveniente que no sean Variants.
    // El resto, sin embargo, pueden ser valores nulos, o el campo no estar definido en el dataset.

    function GetEjercicio : SmallInt;
    function GetSerie : String;
    function GetNroFactura : Integer;
    function GetCodigoCliente : Variant;
    function GetFecha : Variant;
    function GetNroRegistroPresentacion : Variant;
    function GetGrupoFacturacion : Variant;
    function GetCodigoVendedor : Variant;
    function GetRegistroAuxiliar : Variant;
    function GetCodigoFormaCobro : Variant;
    function GetOrganismoPublico : Variant;
    function GetOrganoProponente : Variant;
    function GetNumeroExpediente : Variant;
    function GetNumeroContrato : Variant;
    function GetReferenciaOperacion : Variant;
    function GetServicioPrestadoTemporalmente : Variant;
    function GetInicioPeriodoFacturacion : Variant;
    function GetFinPeriodoFacturacion : Variant;
    function GetSubvencionada : Variant;
    function GetImporteSubvencion : Variant;
    function GetDiaCobro1 : Variant;
    function GetDiaCobro2 : Variant;
    function GetDescuentoPP : Variant;
    function GetImporteDtoPP : Variant;
    function GetDescuentoES : Variant;
    function GetImporteDtoES : Variant;
    function GetTipoComision : Variant;
    function GetCosteArticulos : Variant;
    function GetBrutoArticulos : Variant;
    function GetDescuentosArticulos : Variant;
    function GetDescuentosClientes : Variant;
    function GetImportePuntoVerde : Variant;
    function GetImporteContribucionRAP : Variant;
    function GetNetoFactura : Variant;
    function GetNetoFacturaRetencion : Variant;
    function GetBaseCalculoRetencion : Variant;
    function GetTipoRetencion : Variant;
    function GetImporteRetencion : Variant;
    function GetRecargoFinanciero : Variant;
    function GetImporteRecFinanciero : Variant;
    function GetCuotaIVA : Variant;
    function GetCuotaRE : Variant;
    function GetComision : Variant;
    function GetPortes : Variant;
    function GetTotalFactura : Variant;
    function GetInversionSujetoPasivo : Variant;
    function GetTotalACuenta : Variant;
    function GetTraspasada : Variant;
    function GetFechaValor : Variant;
    function GetFechaEnvioPorCorreo : Variant;
    function GetAnotacion : Variant;
    function GetPresentada  : Variant;
    function GetAnulada : Variant;
    function GetHuella : Variant;

    procedure SetEjercicio( const Value  : SmallInt );
    procedure SetSerie( const Value  : String );
    procedure SetNroFactura( const Value  : Integer );
    procedure SetCodigoCliente( const Value  : Variant );
    procedure SetFecha( const Value  : Variant );
    procedure SetNroRegistroPresentacion( const Value  : Variant );
    procedure SetGrupoFacturacion( const Value  : Variant );
    procedure SetCodigoVendedor( const Value  : Variant );
    procedure SetRegistroAuxiliar( const Value  : Variant );
    procedure SetCodigoFormaCobro( const Value  : Variant );
    procedure SetOrganismoPublico( const Value  : Variant );
    procedure SetOrganoProponente( const Value  : Variant );
    procedure SetNumeroExpediente( const Value  : Variant );
    procedure SetNumeroContrato( const Value  : Variant );
    procedure SetReferenciaOperacion( const Value  : Variant );
    procedure SetServicioPrestadoTemporalmente( const Value  : Variant );
    procedure SetInicioPeriodoFacturacion( const Value  : Variant );
    procedure SetFinPeriodoFacturacion( const Value  : Variant );
    procedure SetSubvencionada( const Value  : Variant );
    procedure SetImporteSubvencion( const Value  : Variant );
    procedure SetDiaCobro1( const Value  : Variant );
    procedure SetDiaCobro2( const Value  : Variant );
    procedure SetDescuentoPP( const Value  : Variant );
    procedure SetImporteDtoPP( const Value  : Variant );
    procedure SetDescuentoES( const Value  : Variant );
    procedure SetImporteDtoES( const Value  : Variant );
    procedure SetTipoComision( const Value  : Variant );
    procedure SetCosteArticulos( const Value  : Variant );
    procedure SetBrutoArticulos( const Value  : Variant );
    procedure SetDescuentosArticulos( const Value  : Variant );
    procedure SetDescuentosClientes( const Value  : Variant );
    procedure SetImportePuntoVerde( const Value  : Variant );
    procedure SetImporteContribucionRAP( const Value  : Variant );
    procedure SetNetoFactura( const Value  : Variant );
    procedure SetNetoFacturaRetencion( const Value  : Variant );
    procedure SetBaseCalculoRetencion( const Value  : Variant );
    procedure SetTipoRetencion( const Value  : Variant );
    procedure SetImporteRetencion( const Value  : Variant );
    procedure SetRecargoFinanciero( const Value  : Variant );
    procedure SetImporteRecFinanciero( const Value  : Variant );
    procedure SetCuotaIVA( const Value  : Variant );
    procedure SetCuotaRE( const Value  : Variant );
    procedure SetComision( const Value  : Variant );
    procedure SetPortes( const Value  : Variant );
    procedure SetTotalFactura( const Value  : Variant );
    procedure SetInversionSujetoPasivo( const Value  : Variant );
    procedure SetTotalACuenta( const Value  : Variant );
    procedure SetTraspasada( const Value  : Variant );
    procedure SetFechaValor( const Value  : Variant );
    procedure SetFechaEnvioPorCorreo( const Value  : Variant );
    procedure SetAnotacion( const Value : Variant );
    procedure SetPresentada( const Value : Variant );
    procedure SetAnulada( const Value : Variant );
    procedure SetHuella( const Value : Variant );

    property RemoteCursorID : TnxCursorID read GetRemoteCursorID write SetRemoteCursorID;
    property State : TDatasetState read GetState write SetState;

    property Ejercicio : SmallInt read GetEjercicio write SetEjercicio;
    property Serie : String read GetSerie write SetSerie;
    property NroFactura : Integer read GetNroFactura write SetNroFactura;
    property CodigoCliente : Variant read GetCodigoCliente write SetCodigoCliente;
    property Fecha : Variant read GetFecha write SetFecha;
    property NroRegistroPresentacion : Variant read GetNroRegistroPresentacion write SetNroRegistroPresentacion;
    property GrupoFacturacion : Variant read GetGrupoFacturacion write SetGrupoFacturacion;
    property CodigoVendedor : Variant read GetCodigoVendedor write SetCodigoVendedor;
    property RegistroAuxiliar : Variant read GetRegistroAuxiliar write SetRegistroAuxiliar;
    property CodigoFormaCobro : Variant read GetCodigoFormaCobro write SetCodigoFormaCobro;
    property OrganismoPublico : Variant read GetOrganismoPublico write SetOrganismoPublico;
    property OrganoProponente : Variant read GetOrganoProponente write SetOrganoProponente;
    property NumeroExpediente : Variant read GetNumeroExpediente write SetNumeroExpediente;
    property NumeroContrato : Variant read GetNumeroContrato write SetNumeroContrato;
    property ReferenciaOperacion : Variant read GetReferenciaOperacion write SetReferenciaOperacion;
    property ServicioPrestadoTemporalmente : Variant read GetServicioPrestadoTemporalmente write SetServicioPrestadoTemporalmente;
    property InicioPeriodoFacturacion : Variant read GetInicioPeriodoFacturacion write SetInicioPeriodoFacturacion;
    property FinPeriodoFacturacion : Variant read GetFinPeriodoFacturacion write SetFinPeriodoFacturacion;
    property Subvencionada : Variant read GetSubvencionada write SetSubvencionada;
    property ImporteSubvencion : Variant read GetImporteSubvencion write SetImporteSubvencion;
    property DiaCobro1 : Variant read GetDiaCobro1 write SetDiaCobro1;
    property DiaCobro2 : Variant read GetDiaCobro2 write SetDiaCobro2;
    property DescuentoPP : Variant read GetDescuentoPP write SetDescuentoPP;
    property ImporteDtoPP : Variant read GetImporteDtoPP write SetImporteDtoPP;
    property DescuentoES : Variant read GetDescuentoES write SetDescuentoES;
    property ImporteDtoES : Variant read GetImporteDtoES write SetImporteDtoES;
    property TipoComision : Variant read GetTipoComision write SetTipoComision;
    property CosteArticulos : Variant read GetCosteArticulos write SetCosteArticulos;
    property BrutoArticulos : Variant read GetBrutoArticulos write SetBrutoArticulos;
    property DescuentosArticulos : Variant read GetDescuentosArticulos write SetDescuentosArticulos;
    property DescuentosClientes : Variant read GetDescuentosClientes write SetDescuentosClientes;
    property ImportePuntoVerde : Variant read GetImportePuntoVerde write SetImportePuntoVerde;
    property ImporteContribucionRAP : Variant read GetImporteContribucionRAP write SetImporteContribucionRAP;
    property NetoFactura : Variant read GetNetoFactura write SetNetoFactura;
    property NetoFacturaRetencion : Variant read GetNetoFacturaRetencion write SetNetoFacturaRetencion;
    property BaseCalculoRetencion : Variant read GetBaseCalculoRetencion write SetBaseCalculoRetencion;
    property TipoRetencion : Variant read GetTipoRetencion write SetTipoRetencion;
    property ImporteRetencion : Variant read GetImporteRetencion write SetImporteRetencion;
    property RecargoFinanciero : Variant read GetRecargoFinanciero write SetRecargoFinanciero;
    property ImporteRecFinanciero : Variant read GetImporteRecFinanciero write SetImporteRecFinanciero;
    property CuotaIVA : Variant read GetCuotaIVA write SetCuotaIVA;
    property CuotaRE : Variant read GetCuotaRE write SetCuotaRE;
    property Comision : Variant read GetComision write SetComision;
    property Portes : Variant read GetPortes write SetPortes;
    property TotalFactura : Variant read GetTotalFactura write SetTotalFactura;
    property InversionSujetoPasivo : Variant read GetInversionSujetoPasivo write SetInversionSujetoPasivo;
    property TotalACuenta : Variant read GetTotalACuenta write SetTotalACuenta;
    property Traspasada : Variant read GetTraspasada write SetTraspasada;
    property FechaValor : Variant read GetFechaValor write SetFechaValor;
    property FechaEnvioPorCorreo : Variant read GetFechaEnvioPorCorreo write SetFechaEnvioPorCorreo;
    property Anotacion : Variant read GetAnotacion write SetAnotacion;
    property Presentada : Variant read GetPresentada write SetPresentada;
    property Anulada : Variant read GetAnulada write SetAnulada;
    property Huella : Variant read GetHuella write SetHuella;

    end;

   TFacturaVentas = class( TnxClass, InxRemoteableClass, IFacturaVentas)
     private

     FRemoteCursorID,
     FState : Variant;

     FEjercicio,
     FSerie,
     FNroFactura,
     FCodigoCliente,
     FFecha,
     FNroRegistroPresentacion,
     FGrupoFacturacion,
     FCodigoVendedor,
     FRegistroAuxiliar,
     FCodigoFormaCobro,
     FOrganismoPublico,
     FOrganoProponente,
     FNumeroExpediente,
     FNumeroContrato,
     FReferenciaOperacion,
     FServicioPrestadoTemporalmente,
     FInicioPeriodoFacturacion,
     FFinPeriodoFacturacion,
     FSubvencionada,
     FImporteSubvencion,
     FDiaCobro1,
     FDiaCobro2,
     FDescuentoPP,
     FImporteDtoPP,
     FDescuentoES,
     FImporteDtoES,
     FTipoComision,
     FCosteArticulos,
     FBrutoArticulos,
     FDescuentosArticulos,
     FDescuentosClientes,
     FImportePuntoVerde,
     FImporteContribucionRAP,
     FNetoFactura,
     FNetoFacturaRetencion : Variant;
     FBaseCalculoRetencion,
     FTipoRetencion,
     FImporteRetencion,
     FRecargoFinanciero,
     FImporteRecFinanciero,
     FCuotaIVA,
     FCuotaRE,
     FComision,
     FPortes,
     FTotalFactura,
     FInversionSujetoPasivo,
     FTotalACuenta,
     FTraspasada,
     FFechaValor,
     FFechaEnvioPorCorreo,
     FAnotacion,
     FPresentada,
     FAnulada,
     FHuella : Variant;

     function GetEjercicio : SmallInt;
     function GetSerie : String;
     function GetNroFactura : Integer;
     function GetCodigoCliente : Variant;
     function GetFecha : Variant;
     function GetNroRegistroPresentacion : Variant;
     function GetGrupoFacturacion : Variant;
     function GetCodigoVendedor : Variant;
     function GetRegistroAuxiliar : Variant;
     function GetCodigoFormaCobro : Variant;
     function GetOrganismoPublico : Variant;
     function GetOrganoProponente : Variant;
     function GetNumeroExpediente : Variant;
     function GetNumeroContrato : Variant;
     function GetReferenciaOperacion : Variant;
     function GetServicioPrestadoTemporalmente : Variant;
     function GetInicioPeriodoFacturacion : Variant;
     function GetFinPeriodoFacturacion : Variant;
     function GetSubvencionada : Variant;
     function GetImporteSubvencion : Variant;
     function GetDiaCobro1 : Variant;
     function GetDiaCobro2 : Variant;
     function GetDescuentoPP : Variant;
     function GetImporteDtoPP : Variant;
     function GetDescuentoES : Variant;
     function GetImporteDtoES : Variant;
     function GetTipoComision : Variant;
     function GetCosteArticulos : Variant;
     function GetBrutoArticulos : Variant;
     function GetDescuentosArticulos : Variant;
     function GetDescuentosClientes : Variant;
     function GetImportePuntoVerde : Variant;
     function GetImporteContribucionRAP : Variant;
     function GetNetoFactura : Variant;
     function GetNetoFacturaRetencion : Variant;
     function GetBaseCalculoRetencion : Variant;
     function GetTipoRetencion : Variant;
     function GetImporteRetencion : Variant;
     function GetRecargoFinanciero : Variant;
     function GetImporteRecFinanciero : Variant;
     function GetCuotaIVA : Variant;
     function GetCuotaRE : Variant;
     function GetComision : Variant;
     function GetPortes : Variant;
     function GetTotalFactura : Variant;
     function GetInversionSujetoPasivo : Variant;
     function GetTotalACuenta : Variant;
     function GetTraspasada : Variant;
     function GetFechaValor : Variant;
     function GetFechaEnvioPorCorreo : Variant;
     function GetAnotacion : Variant;
     function GetPresentada : Variant;
     function GetAnulada : Variant;
     function GetHuella : Variant;

     procedure SetEjercicio( const Value  : SmallInt );
     procedure SetSerie( const Value  : String );
     procedure SetNroFactura( const Value  : Integer );
     procedure SetCodigoCliente( const Value  : Variant );
     procedure SetFecha( const Value  : Variant );
     procedure SetNroRegistroPresentacion( const Value  : Variant );
     procedure SetGrupoFacturacion( const Value  : Variant );
     procedure SetCodigoVendedor( const Value  : Variant );
     procedure SetRegistroAuxiliar( const Value  : Variant );
     procedure SetCodigoFormaCobro( const Value  : Variant );
     procedure SetOrganismoPublico( const Value  : Variant );
     procedure SetOrganoProponente( const Value  : Variant );
     procedure SetNumeroExpediente( const Value  : Variant );
     procedure SetNumeroContrato( const Value  : Variant );
     procedure SetReferenciaOperacion( const Value  : Variant );
     procedure SetServicioPrestadoTemporalmente( const Value  : Variant );
     procedure SetInicioPeriodoFacturacion( const Value  : Variant );
     procedure SetFinPeriodoFacturacion( const Value  : Variant );
     procedure SetSubvencionada( const Value  : Variant );
     procedure SetImporteSubvencion( const Value  : Variant );
     procedure SetDiaCobro1( const Value  : Variant );
     procedure SetDiaCobro2( const Value  : Variant );
     procedure SetDescuentoPP( const Value  : Variant );
     procedure SetImporteDtoPP( const Value  : Variant );
     procedure SetDescuentoES( const Value  : Variant );
     procedure SetImporteDtoES( const Value  : Variant );
     procedure SetTipoComision( const Value  : Variant );
     procedure SetCosteArticulos( const Value  : Variant );
     procedure SetBrutoArticulos( const Value  : Variant );
     procedure SetDescuentosArticulos( const Value  : Variant );
     procedure SetDescuentosClientes( const Value  : Variant );
     procedure SetImportePuntoVerde( const Value  : Variant );
     procedure SetImporteContribucionRAP( const Value  : Variant );
     procedure SetNetoFactura( const Value  : Variant );
     procedure SetNetoFacturaRetencion( const Value  : Variant );
     procedure SetBaseCalculoRetencion( const Value  : Variant );
     procedure SetTipoRetencion( const Value  : Variant );
     procedure SetImporteRetencion( const Value  : Variant );
     procedure SetRecargoFinanciero( const Value  : Variant );
     procedure SetImporteRecFinanciero( const Value  : Variant );
     procedure SetCuotaIVA( const Value  : Variant );
     procedure SetCuotaRE( const Value  : Variant );
     procedure SetComision( const Value  : Variant );
     procedure SetPortes( const Value  : Variant );
     procedure SetTotalFactura( const Value  : Variant );
     procedure SetInversionSujetoPasivo( const Value  : Variant );
     procedure SetTotalACuenta( const Value  : Variant );
     procedure SetTraspasada( const Value  : Variant );
     procedure SetFechaValor( const Value  : Variant );
     procedure SetFechaEnvioPorCorreo( const Value  : Variant );
     procedure SetAnotacion( const Value  : Variant );
     procedure SetPresentada( const Value  : Variant );
     procedure SetAnulada( const Value  : Variant );
     procedure SetHuella( const Value  : Variant );

     function LoadFromReader( AReader : InxReader ) : HRESULT;
     function SaveToWriter( AWriter : InxWriter ) : HRESULT;

     function GetRemoteCursorID : TnxCursorID;
     procedure SetRemoteCursorID( const Value : TnxCursorID );
     function GetState : TDataSetState;
     procedure SetState( const Value : TDataSetState );
     function GetClassID : TnxGuid;

     public

     constructor Create; reintroduce;

     class function FromDataset( FacturaVentasFields  : TFacturaVentasFields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : IFacturaVentas;
     procedure ToDataset( FacturaVentasFields : TFacturaVentasFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );

     end;

implementation

uses  Variants;

{ TFacturaVentas }

constructor TFacturaVentas.Create;
begin
     inherited Create( @CLSID_FacturaVentas, nil, nil, False);
     FState := dsInsert;
end;

class function TFacturaVentas.FromDataset( FacturaVentasFields : TFacturaVentasFields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : IFacturaVentas;

var   SaveState : TDataSetState;
      ApplyOldValues : Boolean;

begin
      Result := TFacturaVentas.Create;

      With Result do
        begin

        RemoteCursorID := FacturaVentasFields.GetRemoteCursorID;
        State := FacturaVentasFields.Dataset.State;
        SaveState := State;

        ApplyOldValues := OldValues and not ( State in [ dsInsert, dsSetKey ] );
        If   ApplyOldValues
        then FacturaVentasFields.IDataset.SetTempState( dsOldValue );

        try

          Ejercicio := GetFieldAsVariant( FacturaVentasFields.Ejercicio );
          Serie := GetFieldAsVariant( FacturaVentasFields.Serie );
          NroFactura := GetFieldAsVariant( FacturaVentasFields.NroFactura );
          CodigoCliente := GetFieldAsVariant( FacturaVentasFields.CodigoCliente );
          Fecha := GetFieldAsVariant( FacturaVentasFields.Fecha );
          NroRegistroPresentacion := GetFieldAsVariant( FacturaVentasFields.NroRegistroPresentacion );
          GrupoFacturacion := GetFieldAsVariant( FacturaVentasFields.GrupoFacturacion );
          CodigoVendedor := GetFieldAsVariant( FacturaVentasFields.CodigoVendedor );
          RegistroAuxiliar := GetFieldAsVariant( FacturaVentasFields.RegistroAuxiliar );
          CodigoFormaCobro := GetFieldAsVariant( FacturaVentasFields.CodigoFormaCobro );
          OrganismoPublico := GetFieldAsVariant( FacturaVentasFields.OrganismoPublico );
          OrganoProponente := GetFieldAsVariant( FacturaVentasFields.OrganoProponente );
          NumeroExpediente := GetFieldAsVariant( FacturaVentasFields.NumeroExpediente );
          NumeroContrato := GetFieldAsVariant( FacturaVentasFields.NumeroContrato );
          ReferenciaOperacion := GetFieldAsVariant( FacturaVentasFields.ReferenciaOperacion );
          ServicioPrestadoTemporalmente := GetFieldAsVariant( FacturaVentasFields.ServicioPrestadoTemporalmente );
          InicioPeriodoFacturacion := GetFieldAsVariant( FacturaVentasFields.InicioPeriodoFacturacion );
          FinPeriodoFacturacion := GetFieldAsVariant( FacturaVentasFields.FinPeriodoFacturacion );
          Subvencionada := GetFieldAsVariant( FacturaVentasFields.Subvencionada );
          ImporteSubvencion := GetFieldAsVariant( FacturaVentasFields.ImporteSubvencion );
          DiaCobro1 := GetFieldAsVariant( FacturaVentasFields.DiaCobro1 );
          DiaCobro2 := GetFieldAsVariant( FacturaVentasFields.DiaCobro2 );
          DescuentoPP := GetFieldAsVariant( FacturaVentasFields.DescuentoPP );
          ImporteDtoPP := GetFieldAsVariant( FacturaVentasFields.ImporteDtoPP );
          DescuentoES := GetFieldAsVariant( FacturaVentasFields.DescuentoES );
          ImporteDtoES := GetFieldAsVariant( FacturaVentasFields.ImporteDtoES );
          TipoComision := GetFieldAsVariant( FacturaVentasFields.TipoComision );
          CosteArticulos := GetFieldAsVariant( FacturaVentasFields.CosteArticulos );
          BrutoArticulos := GetFieldAsVariant( FacturaVentasFields.BrutoArticulos );
          DescuentosArticulos := GetFieldAsVariant( FacturaVentasFields.DescuentosArticulos );
          DescuentosClientes := GetFieldAsVariant( FacturaVentasFields.DescuentosClientes );
          ImportePuntoVerde := GetFieldAsVariant( FacturaVentasFields.ImportePuntoVerde );
          ImporteContribucionRAP := GetFieldAsVariant( FacturaVentasFields.ImporteContribucionRAP );
          NetoFactura := GetFieldAsVariant( FacturaVentasFields.NetoFactura );
          NetoFacturaRetencion := GetFieldAsVariant( FacturaVentasFields.NetoFacturaRetencion );
          BaseCalculoRetencion := GetFieldAsVariant( FacturaVentasFields.BaseCalculoRetencion );
          TipoRetencion := GetFieldAsVariant( FacturaVentasFields.TipoRetencion );
          ImporteRetencion := GetFieldAsVariant( FacturaVentasFields.ImporteRetencion );
          RecargoFinanciero := GetFieldAsVariant( FacturaVentasFields.RecargoFinanciero );
          ImporteRecFinanciero := GetFieldAsVariant( FacturaVentasFields.ImporteRecFinanciero );
          CuotaIVA := GetFieldAsVariant( FacturaVentasFields.CuotaIVA );
          CuotaRE := GetFieldAsVariant( FacturaVentasFields.CuotaRE );
          Comision := GetFieldAsVariant( FacturaVentasFields.Comision );
          Portes := GetFieldAsVariant( FacturaVentasFields.Portes );
          TotalFactura := GetFieldAsVariant( FacturaVentasFields.TotalFactura );
          InversionSujetoPasivo := GetFieldAsVariant( FacturaVentasFields.InversionSujetoPasivo );
          TotalACuenta := GetFieldAsVariant( FacturaVentasFields.TotalACuenta );
          Traspasada := GetFieldAsVariant( FacturaVentasFields.Traspasada );
          FechaValor := GetFieldAsVariant( FacturaVentasFields.FechaValor );
          FechaEnvioPorCorreo := GetFieldAsVariant( FacturaVentasFields.FechaEnvioPorCorreo );

          If   ReadBlobs
          then Anotacion := GetFieldAsVariant( FacturaVentasFields.Anotacion )
          else Anotacion := '';

          Presentada := GetFieldAsVariant( FacturaVentasFields.Presentada );
          Anulada := GetFieldAsVariant( FacturaVentasFields.Anulada );
          Huella := GetFieldAsVariant( FacturaVentasFields.Huella );

        finally
          If   ApplyOldValues
          then FacturaVentasFields.IDataset.RestoreState( SaveState );
        end;
      end;

end;

procedure TFacturaVentas.ToDataset( FacturaVentasFields : TFacturaVentasFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );
begin
     try

       If   not PreserveState
       then FacturaVentasFields.SetStateFromInterface( FState );

       FacturaVentasFields.Ejercicio.Value := FEjercicio;
       FacturaVentasFields.Serie.Value := FSerie;
       FacturaVentasFields.NroFactura.Value := FNroFactura;

       SetFieldAsVariant( FacturaVentasFields.CodigoCliente, FCodigoCliente );
       SetFieldAsVariant( FacturaVentasFields.Fecha, FFecha );
       SetFieldAsVariant( FacturaVentasFields.NroRegistroPresentacion, FNroRegistroPresentacion );
       SetFieldAsVariant( FacturaVentasFields.GrupoFacturacion, FGrupoFacturacion );
       SetFieldAsVariant( FacturaVentasFields.CodigoVendedor, FCodigoVendedor );
       SetFieldAsVariant( FacturaVentasFields.RegistroAuxiliar, FRegistroAuxiliar );
       SetFieldAsVariant( FacturaVentasFields.CodigoFormaCobro, FCodigoFormaCobro );
       SetFieldAsVariant( FacturaVentasFields.OrganismoPublico, FOrganismoPublico );
       SetFieldAsVariant( FacturaVentasFields.OrganoProponente, FOrganoProponente );
       SetFieldAsVariant( FacturaVentasFields.NumeroExpediente, FNumeroExpediente );
       SetFieldAsVariant( FacturaVentasFields.NumeroContrato, FNumeroContrato );
       SetFieldAsVariant( FacturaVentasFields.ReferenciaOperacion, FReferenciaOperacion );
       SetFieldAsVariant( FacturaVentasFields.ServicioPrestadoTemporalmente, FServicioPrestadoTemporalmente );
       SetFieldAsVariant( FacturaVentasFields.InicioPeriodoFacturacion, FInicioPeriodoFacturacion );
       SetFieldAsVariant( FacturaVentasFields.FinPeriodoFacturacion, FFinPeriodoFacturacion );
       SetFieldAsVariant( FacturaVentasFields.Subvencionada, FSubvencionada );
       SetFieldAsVariant( FacturaVentasFields.ImporteSubvencion, FImporteSubvencion );
       SetFieldAsVariant( FacturaVentasFields.DiaCobro1, FDiaCobro1 );
       SetFieldAsVariant( FacturaVentasFields.DiaCobro2, FDiaCobro2 );
       SetFieldAsVariant( FacturaVentasFields.DescuentoPP, FDescuentoPP );
       SetFieldAsVariant( FacturaVentasFields.ImporteDtoPP, FImporteDtoPP );
       SetFieldAsVariant( FacturaVentasFields.DescuentoES, FDescuentoES );
       SetFieldAsVariant( FacturaVentasFields.ImporteDtoES, FImporteDtoES );
       SetFieldAsVariant( FacturaVentasFields.TipoComision, FTipoComision );
       SetFieldAsVariant( FacturaVentasFields.CosteArticulos, FCosteArticulos );
       SetFieldAsVariant( FacturaVentasFields.BrutoArticulos, FBrutoArticulos );
       SetFieldAsVariant( FacturaVentasFields.DescuentosArticulos, FDescuentosArticulos );
       SetFieldAsVariant( FacturaVentasFields.DescuentosClientes, FDescuentosClientes );
       SetFieldAsVariant( FacturaVentasFields.ImportePuntoVerde, FImportePuntoVerde );
       SetFieldAsVariant( FacturaVentasFields.ImporteContribucionRAP, FImporteContribucionRAP );
       SetFieldAsVariant( FacturaVentasFields.NetoFactura, FNetoFactura );
       SetFieldAsVariant( FacturaVentasFields.NetoFacturaRetencion, FNetoFacturaRetencion );
       SetFieldAsVariant( FacturaVentasFields.BaseCalculoRetencion, FBaseCalculoRetencion );
       SetFieldAsVariant( FacturaVentasFields.TipoRetencion, FTipoRetencion );
       SetFieldAsVariant( FacturaVentasFields.ImporteRetencion, FImporteRetencion );
       SetFieldAsVariant( FacturaVentasFields.RecargoFinanciero, FRecargoFinanciero );
       SetFieldAsVariant( FacturaVentasFields.ImporteRecFinanciero, FImporteRecFinanciero );
       SetFieldAsVariant( FacturaVentasFields.CuotaIVA, FCuotaIVA );
       SetFieldAsVariant( FacturaVentasFields.CuotaRE, FCuotaRE );
       SetFieldAsVariant( FacturaVentasFields.Comision, FComision );
       SetFieldAsVariant( FacturaVentasFields.Portes, FPortes );
       SetFieldAsVariant( FacturaVentasFields.TotalFactura, FTotalFactura );
       SetFieldAsVariant( FacturaVentasFields.InversionSujetoPasivo, FInversionSujetoPasivo );
       SetFieldAsVariant( FacturaVentasFields.TotalACuenta, FTotalACuenta );
       SetFieldAsVariant( FacturaVentasFields.Traspasada, FTraspasada );
       SetFieldAsVariant( FacturaVentasFields.FechaValor, FFechaValor );
       SetFieldAsVariant( FacturaVentasFields.FechaEnvioPorCorreo, FFechaEnvioPorCorreo );

       If   ReadBlobs
       then SetFieldAsVariant( FacturaVentasFields.Anotacion, FAnotacion )
       else FacturaVentasFields.Anotacion.Clear;

       SetFieldAsVariant( FacturaVentasFields.Presentada, FPresentada );
       SetFieldAsVariant( FacturaVentasFields.Anulada, FAnulada );
       SetFieldAsVariant( FacturaVentasFields.Huella, FHuella );

     except
       FacturaVentasFields.Dataset.Cancel;
       raise;
       end;

end;

function TFacturaVentas.LoadFromReader( AReader : InxReader ) : HRESULT;

var VarFlags : TnxVarFlags;

begin
     nxReadVariant( VarFlags, FRemoteCursorID, AReader );
     nxReadVariant( VarFlags, FState, AReader );

     nxReadVariant( VarFlags, FEjercicio, AReader );
     nxReadVariant( VarFlags, FSerie, AReader );
     nxReadVariant( VarFlags, FNroFactura, AReader );
     nxReadVariant( VarFlags, FCodigoCliente, AReader );
     nxReadVariant( VarFlags, FFecha, AReader );
     nxReadVariant( VarFlags, FNroRegistroPresentacion, AReader );
     nxReadVariant( VarFlags, FGrupoFacturacion, AReader );
     nxReadVariant( VarFlags, FCodigoVendedor, AReader );
     nxReadVariant( VarFlags, FRegistroAuxiliar, AReader );
     nxReadVariant( VarFlags, FCodigoFormaCobro, AReader );
     nxReadVariant( VarFlags, FOrganismoPublico, AReader );
     nxReadVariant( VarFlags, FOrganoProponente, AReader );
     nxReadVariant( VarFlags, FNumeroExpediente, AReader );
     nxReadVariant( VarFlags, FNumeroContrato, AReader );
     nxReadVariant( VarFlags, FReferenciaOperacion, AReader );
     nxReadVariant( VarFlags, FServicioPrestadoTemporalmente, AReader );
     nxReadVariant( VarFlags, FInicioPeriodoFacturacion, AReader );
     nxReadVariant( VarFlags, FFinPeriodoFacturacion, AReader );
     nxReadVariant( VarFlags, FSubvencionada, AReader );
     nxReadVariant( VarFlags, FImporteSubvencion, AReader );
     nxReadVariant( VarFlags, FDiaCobro1, AReader );
     nxReadVariant( VarFlags, FDiaCobro2, AReader );
     nxReadVariant( VarFlags, FDescuentoPP, AReader );
     nxReadVariant( VarFlags, FImporteDtoPP, AReader );
     nxReadVariant( VarFlags, FDescuentoES, AReader );
     nxReadVariant( VarFlags, FImporteDtoES, AReader );
     nxReadVariant( VarFlags, FTipoComision, AReader );
     nxReadVariant( VarFlags, FCosteArticulos, AReader );
     nxReadVariant( VarFlags, FBrutoArticulos, AReader );
     nxReadVariant( VarFlags, FDescuentosArticulos, AReader );
     nxReadVariant( VarFlags, FDescuentosClientes, AReader );
     nxReadVariant( VarFlags, FImportePuntoVerde, AReader );
     nxReadVariant( VarFlags, FImporteContribucionRAP, AReader );
     nxReadVariant( VarFlags, FNetoFactura, AReader );
     nxReadVariant( VarFlags, FNetoFacturaRetencion, AReader );
     nxReadVariant( VarFlags, FBaseCalculoRetencion, AReader );
     nxReadVariant( VarFlags, FTipoRetencion, AReader );
     nxReadVariant( VarFlags, FImporteRetencion, AReader );
     nxReadVariant( VarFlags, FRecargoFinanciero, AReader );
     nxReadVariant( VarFlags, FImporteRecFinanciero, AReader );
     nxReadVariant( VarFlags, FCuotaIVA, AReader );
     nxReadVariant( VarFlags, FCuotaRE, AReader );
     nxReadVariant( VarFlags, FComision, AReader );
     nxReadVariant( VarFlags, FPortes, AReader );
     nxReadVariant( VarFlags, FTotalFactura, AReader );
     nxReadVariant( VarFlags, FInversionSujetoPasivo, AReader );
     nxReadVariant( VarFlags, FTotalACuenta, AReader );
     nxReadVariant( VarFlags, FTraspasada, AReader );
     nxReadVariant( VarFlags, FFechaValor, AReader );
     nxReadVariant( VarFlags, FFechaEnvioPorCorreo, AReader );
     nxReadVariant( VarFlags, FAnotacion, AReader );
     nxReadVariant( VarFlags, FPresentada, AReader );
     nxReadVariant( VarFlags, FAnulada, AReader );
     nxReadVariant( VarFlags, FHuella, AReader );

     Result := S_OK;
end;

function TFacturaVentas.SaveToWriter( AWriter : InxWriter) : HRESULT;
begin
     nxWriteVariant( FRemoteCursorID, AWriter );
     nxWriteVariant( FState, AWriter );

     nxWriteVariant( FEjercicio, AWriter );
     nxWriteVariant( FSerie, AWriter );
     nxWriteVariant( FNroFactura, AWriter );
     nxWriteVariant( FCodigoCliente, AWriter );
     nxWriteVariant( FFecha, AWriter );
     nxWriteVariant( FNroRegistroPresentacion, AWriter );
     nxWriteVariant( FGrupoFacturacion, AWriter );
     nxWriteVariant( FCodigoVendedor, AWriter );
     nxWriteVariant( FRegistroAuxiliar, AWriter );
     nxWriteVariant( FCodigoFormaCobro, AWriter );
     nxWriteVariant( FOrganismoPublico, AWriter );
     nxWriteVariant( FOrganoProponente, AWriter );
     nxWriteVariant( FNumeroExpediente, AWriter );
     nxWriteVariant( FNumeroContrato, AWriter );
     nxWriteVariant( FReferenciaOperacion, AWriter );
     nxWriteVariant( FServicioPrestadoTemporalmente, AWriter );
     nxWriteVariant( FInicioPeriodoFacturacion, AWriter );
     nxWriteVariant( FFinPeriodoFacturacion, AWriter );
     nxWriteVariant( FSubvencionada, AWriter );
     nxWriteVariant( FImporteSubvencion, AWriter );
     nxWriteVariant( FDiaCobro1, AWriter );
     nxWriteVariant( FDiaCobro2, AWriter );
     nxWriteVariant( FDescuentoPP, AWriter );
     nxWriteVariant( FImporteDtoPP, AWriter );
     nxWriteVariant( FDescuentoES, AWriter );
     nxWriteVariant( FImporteDtoES, AWriter );
     nxWriteVariant( FTipoComision, AWriter );
     nxWriteVariant( FCosteArticulos, AWriter );
     nxWriteVariant( FBrutoArticulos, AWriter );
     nxWriteVariant( FDescuentosArticulos, AWriter );
     nxWriteVariant( FDescuentosClientes, AWriter );
     nxWriteVariant( FImportePuntoVerde, AWriter );
     nxWriteVariant( FImporteContribucionRAP, AWriter );
     nxWriteVariant( FNetoFactura, AWriter );
     nxWriteVariant( FNetoFacturaRetencion, AWriter );
     nxWriteVariant( FBaseCalculoRetencion, AWriter );
     nxWriteVariant( FTipoRetencion, AWriter );
     nxWriteVariant( FImporteRetencion, AWriter );
     nxWriteVariant( FRecargoFinanciero, AWriter );
     nxWriteVariant( FImporteRecFinanciero, AWriter );
     nxWriteVariant( FCuotaIVA, AWriter );
     nxWriteVariant( FCuotaRE, AWriter );
     nxWriteVariant( FComision, AWriter );
     nxWriteVariant( FPortes, AWriter );
     nxWriteVariant( FTotalFactura, AWriter );
     nxWriteVariant( FInversionSujetoPasivo, AWriter );
     nxWriteVariant( FTotalACuenta, AWriter );
     nxWriteVariant( FTraspasada, AWriter );
     nxWriteVariant( FFechaValor, AWriter );
     nxWriteVariant( FFechaEnvioPorCorreo, AWriter );
     nxWriteVariant( FAnotacion, AWriter );
     nxWriteVariant( FPresentada, AWriter );
     nxWriteVariant( FAnulada, AWriter );
     nxWriteVariant( FHuella, AWriter );

     Result := S_OK;
end;

{ Getters}

function TFacturaVentas.GetClassID: TnxGuid;
begin
     Result := CLSID_FacturaVentas;
end;

function TFacturaVentas.GetRemoteCursorID: TnxCursorID;
begin
     Result := FRemoteCursorID;
end;

function TFacturaVentas.GetState: TDataSetState;
begin
     Result := FState;
end;


function TFacturaVentas.GetEjercicio : SmallInt;
begin
     Result := FEjercicio;
end;

function TFacturaVentas.GetSerie : String;
begin
     Result := FSerie;
end;

function TFacturaVentas.GetNroFactura : Integer;
begin
     Result := FNroFactura;
end;

function TFacturaVentas.GetCodigoCliente : Variant;
begin
     Result := FCodigoCliente;
end;

function TFacturaVentas.GetFecha : Variant;
begin
     Result := FFecha;
end;

function TFacturaVentas.GetNroRegistroPresentacion : Variant;
begin
     Result := FNroRegistroPresentacion;
end;

function TFacturaVentas.GetGrupoFacturacion : Variant;
begin
     Result := FGrupoFacturacion;
end;

function TFacturaVentas.GetCodigoVendedor : Variant;
begin
     Result := FCodigoVendedor;
end;

function TFacturaVentas.GetRegistroAuxiliar : Variant;
begin
     Result := FRegistroAuxiliar;
end;

function TFacturaVentas.GetCodigoFormaCobro : Variant;
begin
     Result := FCodigoFormaCobro;
end;

function TFacturaVentas.GetOrganismoPublico : Variant;
begin
     Result := FOrganismoPublico;
end;

function TFacturaVentas.GetOrganoProponente : Variant;
begin
     Result := FOrganoProponente;
end;

function TFacturaVentas.GetNumeroExpediente : Variant;
begin
     Result := FNumeroExpediente;
end;

function TFacturaVentas.GetNumeroContrato : Variant;
begin
     Result := FNumeroContrato;
end;

function TFacturaVentas.GetReferenciaOperacion : Variant;
begin
     Result := FReferenciaOperacion;
end;

function TFacturaVentas.GetServicioPrestadoTemporalmente : Variant;
begin
     Result := FServicioPrestadoTemporalmente;
end;

function TFacturaVentas.GetInicioPeriodoFacturacion : Variant;
begin
     Result := FInicioPeriodoFacturacion;
end;

function TFacturaVentas.GetFinPeriodoFacturacion : Variant;
begin
     Result := FFinPeriodoFacturacion;
end;

function TFacturaVentas.GetSubvencionada : Variant;
begin
     Result := FSubvencionada;
end;

function TFacturaVentas.GetImporteSubvencion : Variant;
begin
     Result := FImporteSubvencion;
end;

function TFacturaVentas.GetDiaCobro1 : Variant;
begin
     Result := FDiaCobro1;
end;

function TFacturaVentas.GetDiaCobro2 : Variant;
begin
     Result := FDiaCobro2;
end;

function TFacturaVentas.GetDescuentoPP : Variant;
begin
     Result := FDescuentoPP;
end;

function TFacturaVentas.GetImporteDtoPP : Variant;
begin
     Result := FImporteDtoPP;
end;

function TFacturaVentas.GetDescuentoES : Variant;
begin
     Result := FDescuentoES;
end;

function TFacturaVentas.GetImporteDtoES : Variant;
begin
     Result := FImporteDtoES;
end;

function TFacturaVentas.GetTipoComision : Variant;
begin
     Result := FTipoComision;
end;

function TFacturaVentas.GetCosteArticulos : Variant;
begin
     Result := FCosteArticulos;
end;

function TFacturaVentas.GetBrutoArticulos : Variant;
begin
     Result := FBrutoArticulos;
end;

function TFacturaVentas.GetDescuentosArticulos : Variant;
begin
     Result := FDescuentosArticulos;
end;

function TFacturaVentas.GetDescuentosClientes : Variant;
begin
     Result := FDescuentosClientes;
end;

function TFacturaVentas.GetImportePuntoVerde : Variant;
begin
     Result := FImportePuntoVerde;
end;

function TFacturaVentas.GetImporteContribucionRAP : Variant;
begin
     Result := FImporteContribucionRAP;
end;

function TFacturaVentas.GetNetoFactura : Variant;
begin
     Result := FNetoFactura;
end;

function TFacturaVentas.GetNetoFacturaRetencion : Variant;
begin
     Result := FNetoFacturaRetencion;
end;

function TFacturaVentas.GetBaseCalculoRetencion : Variant;
begin
     Result := FBaseCalculoRetencion;
end;

function TFacturaVentas.GetTipoRetencion : Variant;
begin
     Result := FTipoRetencion;
end;

function TFacturaVentas.GetImporteRetencion : Variant;
begin
     Result := FImporteRetencion;
end;

function TFacturaVentas.GetRecargoFinanciero : Variant;
begin
     Result := FRecargoFinanciero;
end;

function TFacturaVentas.GetImporteRecFinanciero : Variant;
begin
     Result := FImporteRecFinanciero;
end;

function TFacturaVentas.GetCuotaIVA : Variant;
begin
     Result := FCuotaIVA;
end;

function TFacturaVentas.GetCuotaRE : Variant;
begin
     Result := FCuotaRE;
end;

function TFacturaVentas.GetComision : Variant;
begin
     Result := FComision;
end;

function TFacturaVentas.GetPortes : Variant;
begin
     Result := FPortes;
end;

function TFacturaVentas.GetTotalFactura : Variant;
begin
     Result := FTotalFactura;
end;

function TFacturaVentas.GetInversionSujetoPasivo : Variant;
begin
     Result := FInversionSujetoPasivo;
end;

function TFacturaVentas.GetTotalACuenta : Variant;
begin
     Result := FTotalACuenta;
end;

function TFacturaVentas.GetTraspasada : Variant;
begin
     Result := FTraspasada;
end;

function TFacturaVentas.GetFechaValor : Variant;
begin
     Result := FFechaValor;
end;

function TFacturaVentas.GetFechaEnvioPorCorreo : Variant;
begin
     Result := FFechaEnvioPorCorreo;
end;

function TFacturaVentas.GetAnotacion : Variant;
begin
     Result := FAnotacion;
end;

function TFacturaVentas.GetPresentada : Variant;
begin
     Result := FPresentada;
end;

function TFacturaVentas.GetAnulada : Variant;
begin
     Result := FAnulada;
end;

function TFacturaVentas.GetHuella : Variant;
begin
     Result := FHuella;
end;

{ Setters}

procedure TFacturaVentas.SetRemoteCursorID( const Value : TnxCursorID );
begin
     FRemoteCursorID := Value;
end;

procedure TFacturaVentas.SetState( const Value : TDataSetState );
begin
     FState := Value;
end;


procedure TFacturaVentas.SetEjercicio(  const Value : SmallInt );
begin
     FEjercicio := Value;
end;

procedure TFacturaVentas.SetSerie(  const Value : String );
begin
     FSerie := Value;
end;

procedure TFacturaVentas.SetNroFactura(  const Value : Integer );
begin
     FNroFactura := Value;
end;

procedure TFacturaVentas.SetCodigoCliente(  const Value : Variant );
begin
     FCodigoCliente := Value;
end;

procedure TFacturaVentas.SetFecha(  const Value : Variant );
begin
     FFecha := Value;
end;

procedure TFacturaVentas.SetNroRegistroPresentacion(  const Value : Variant );
begin
     FNroRegistroPresentacion := Value;
end;

procedure TFacturaVentas.SetGrupoFacturacion(  const Value : Variant );
begin
     FGrupoFacturacion := Value;
end;

procedure TFacturaVentas.SetCodigoVendedor(  const Value : Variant );
begin
     FCodigoVendedor := Value;
end;

procedure TFacturaVentas.SetRegistroAuxiliar(  const Value : Variant );
begin
     FRegistroAuxiliar := Value;
end;

procedure TFacturaVentas.SetCodigoFormaCobro(  const Value : Variant );
begin
     FCodigoFormaCobro := Value;
end;

procedure TFacturaVentas.SetOrganismoPublico(  const Value : Variant );
begin
     FOrganismoPublico := Value;
end;

procedure TFacturaVentas.SetOrganoProponente(  const Value : Variant );
begin
     FOrganoProponente := Value;
end;

procedure TFacturaVentas.SetNumeroExpediente(  const Value : Variant );
begin
     FNumeroExpediente := Value;
end;

procedure TFacturaVentas.SetNumeroContrato(  const Value : Variant );
begin
     FNumeroContrato := Value;
end;

procedure TFacturaVentas.SetReferenciaOperacion(  const Value : Variant );
begin
     FReferenciaOperacion := Value;
end;

procedure TFacturaVentas.SetServicioPrestadoTemporalmente(  const Value : Variant );
begin
     FServicioPrestadoTemporalmente := Value;
end;

procedure TFacturaVentas.SetInicioPeriodoFacturacion(  const Value : Variant );
begin
     FInicioPeriodoFacturacion := Value;
end;

procedure TFacturaVentas.SetFinPeriodoFacturacion(  const Value : Variant );
begin
     FFinPeriodoFacturacion := Value;
end;

procedure TFacturaVentas.SetSubvencionada(  const Value : Variant );
begin
     FSubvencionada := Value;
end;

procedure TFacturaVentas.SetImporteSubvencion(  const Value : Variant );
begin
     FImporteSubvencion := Value;
end;

procedure TFacturaVentas.SetDiaCobro1(  const Value : Variant );
begin
     FDiaCobro1 := Value;
end;

procedure TFacturaVentas.SetDiaCobro2(  const Value : Variant );
begin
     FDiaCobro2 := Value;
end;

procedure TFacturaVentas.SetDescuentoPP(  const Value : Variant );
begin
     FDescuentoPP := Value;
end;

procedure TFacturaVentas.SetImporteDtoPP(  const Value : Variant );
begin
     FImporteDtoPP := Value;
end;

procedure TFacturaVentas.SetDescuentoES(  const Value : Variant );
begin
     FDescuentoES := Value;
end;

procedure TFacturaVentas.SetImporteDtoES(  const Value : Variant );
begin
     FImporteDtoES := Value;
end;

procedure TFacturaVentas.SetTipoComision(  const Value : Variant );
begin
     FTipoComision := Value;
end;

procedure TFacturaVentas.SetCosteArticulos(  const Value : Variant );
begin
     FCosteArticulos := Value;
end;

procedure TFacturaVentas.SetBrutoArticulos(  const Value : Variant );
begin
     FBrutoArticulos := Value;
end;

procedure TFacturaVentas.SetDescuentosArticulos(  const Value : Variant );
begin
     FDescuentosArticulos := Value;
end;

procedure TFacturaVentas.SetDescuentosClientes(  const Value : Variant );
begin
     FDescuentosClientes := Value;
end;

procedure TFacturaVentas.SetImportePuntoVerde(  const Value : Variant );
begin
     FImportePuntoVerde := Value;
end;

procedure TFacturaVentas.SetImporteContribucionRAP(  const Value : Variant );
begin
     FImporteContribucionRAP := Value;
end;

procedure TFacturaVentas.SetNetoFactura(  const Value : Variant );
begin
     FNetoFactura := Value;
end;

procedure TFacturaVentas.SetNetoFacturaRetencion(  const Value : Variant );
begin
     FNetoFacturaRetencion := Value;
end;

procedure TFacturaVentas.SetBaseCalculoRetencion(  const Value : Variant );
begin
     FBaseCalculoRetencion := Value;
end;

procedure TFacturaVentas.SetTipoRetencion(  const Value : Variant );
begin
     FTipoRetencion := Value;
end;

procedure TFacturaVentas.SetImporteRetencion(  const Value : Variant );
begin
     FImporteRetencion := Value;
end;

procedure TFacturaVentas.SetRecargoFinanciero(  const Value : Variant );
begin
     FRecargoFinanciero := Value;
end;

procedure TFacturaVentas.SetImporteRecFinanciero(  const Value : Variant );
begin
     FImporteRecFinanciero := Value;
end;

procedure TFacturaVentas.SetCuotaIVA(  const Value : Variant );
begin
     FCuotaIVA := Value;
end;

procedure TFacturaVentas.SetCuotaRE(  const Value : Variant );
begin
     FCuotaRE := Value;
end;

procedure TFacturaVentas.SetComision(  const Value : Variant );
begin
     FComision := Value;
end;

procedure TFacturaVentas.SetPortes(  const Value : Variant );
begin
     FPortes := Value;
end;

procedure TFacturaVentas.SetTotalFactura(  const Value : Variant );
begin
     FTotalFactura := Value;
end;

procedure TFacturaVentas.SetInversionSujetoPasivo(  const Value : Variant );
begin
     FInversionSujetoPasivo := Value;
end;

procedure TFacturaVentas.SetTotalACuenta(  const Value : Variant );
begin
     FTotalACuenta := Value;
end;

procedure TFacturaVentas.SetTraspasada(  const Value : Variant );
begin
     FTraspasada := Value;
end;

procedure TFacturaVentas.SetFechaValor(  const Value : Variant );
begin
     FFechaValor := Value;
end;

procedure TFacturaVentas.SetFechaEnvioPorCorreo(  const Value : Variant );
begin
     FFechaEnvioPorCorreo := Value;
end;

procedure TFacturaVentas.SetAnotacion(  const Value : Variant );
begin
     FAnotacion := Value;
end;

procedure TFacturaVentas.SetPresentada(  const Value : Variant );
begin
     FPresentada := Value;
end;

procedure TFacturaVentas.SetAnulada(  const Value : Variant );
begin
     FAnulada := Value;
end;

procedure TFacturaVentas.SetHuella(  const Value : Variant );
begin
     FHuella := Value;
end;

var FacturaVentasControl : InxClassFactoryControl;

initialization
   nxInvokeRegistry.RegisterInterface( TypeInfo( IFacturaVentas ) );

   TnxClassFactory.RegisterClass( CLSID_FacturaVentas, TFacturaVentas, FacturaVentasControl );

end.
