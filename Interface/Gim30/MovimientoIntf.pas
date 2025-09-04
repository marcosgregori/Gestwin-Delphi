{$ALIGN OFF}
{$OPTIMIZATION OFF}

unit MovimientoIntf;

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

      Gim30Fields;

const
  CLSID_Movimiento : TnxGuid = '{438ADBBB-FC3C-415F-BF2A-56FA93CAF0AF}';

type

  IMovimiento = interface( IInvokableRecord )
    [ '{7409E184-8149-4F12-AD36-AA014F25F791}' ] 

    procedure ToDataset( MovimientoFields : TMovimientoFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );
    function GetRemoteCursorID : TnxCursorID;
    procedure SetRemoteCursorID( const Value : TnxCursorID );
    function GetState : TDataSetState;
    procedure SetState( const Value : TDataSetState );

    // Los campos que forman parte de un índice es conveniente que no sean Variants.
    // El resto, sin embargo, pueden ser valores nulos, o el campo no estar definido en el dataset.

    function GetEjercicio : SmallInt;
    function GetNroOperacion : Integer;
    function GetTipoMovimiento : SmallInt;
    function GetPropietario : Variant;
    function GetSerie : Variant;
    function GetNroDocumento : Variant;
    function GetUUID : Variant;
    function GetFecha : Variant;
    function GetFechaAplicacion : Variant;
    function GetFechaEmision : Variant;
    function GetFechaAuxiliar : Variant;
    function GetGrupoFacturacion : Variant;
    function GetRegistroAuxiliar : Variant;
    function GetCodigoVendedor : Variant;
    function GetCodigoOperario : Variant;
    function GetCentroCoste : Variant;
    function GetFormaEnvio : Variant;
    function GetEjercicioFactura : Variant;
    function GetPropietarioFactura : Variant;
    function GetSerieFactura : Variant;
    function GetNroFactura : Variant;
    function GetNoFacturar : Variant;
    function GetFacturado : Variant;
    function GetTraspasado : Variant;
    function GetAnulado : Variant;
    function GetOrigen : Variant;
    function GetOpcion : Variant;
    function GetEjercicioOrigen : Variant;
    function GetNroOperacionOrigen : Variant;
    function GetNroDocumentoPropietario : Variant;
    function GetEntregaACuenta : Variant;
    function GetEntregaEfectivo : Variant;
    function GetCodigoTransportista : Variant;
    function GetIVAIncluido : Variant;
    function GetPortes : Variant;
    function GetCodigoFormaCobro : Variant;
    function GetOrganismoPublico : Variant;
    function GetSituacion : Variant;
    function GetDescripcionMovimiento : Variant;
    function GetCampoLibre( Index : SmallInt ) : Variant;
    function GetTipoVentaPeriodica : Variant;
    function GetCreado : Variant;
    function GetRevisado : Variant;
    function GetSuministrado : Variant;
    function GetFechaEnvioPorCorreo : Variant;
    function GetAnotacion : Variant;
    function GetFirma : Variant;

    procedure SetEjercicio( const Value  : SmallInt );
    procedure SetNroOperacion( const Value  : Integer );
    procedure SetTipoMovimiento( const Value  : SmallInt );
    procedure SetPropietario( const Value  : Variant );
    procedure SetSerie( const Value  : Variant );
    procedure SetNroDocumento( const Value  : Variant );
    procedure SetUUID( const Value  : Variant );
    procedure SetFecha( const Value  : Variant );
    procedure SetFechaAplicacion( const Value  : Variant );
    procedure SetFechaEmision( const Value  : Variant );
    procedure SetFechaAuxiliar( const Value  : Variant );
    procedure SetGrupoFacturacion( const Value  : Variant );
    procedure SetRegistroAuxiliar( const Value  : Variant );
    procedure SetCodigoVendedor( const Value  : Variant );
    procedure SetCodigoOperario( const Value  : Variant );
    procedure SetCentroCoste( const Value  : Variant );
    procedure SetFormaEnvio( const Value  : Variant );
    procedure SetEjercicioFactura( const Value  : Variant );
    procedure SetPropietarioFactura( const Value  : Variant );
    procedure SetSerieFactura( const Value  : Variant );
    procedure SetNroFactura( const Value  : Variant );
    procedure SetNoFacturar( const Value  : Variant );
    procedure SetFacturado( const Value  : Variant );
    procedure SetTraspasado( const Value  : Variant );
    procedure SetAnulado( const Value  : Variant );
    procedure SetOrigen( const Value  : Variant );
    procedure SetOpcion( const Value  : Variant );
    procedure SetEjercicioOrigen( const Value  : Variant );
    procedure SetNroOperacionOrigen( const Value  : Variant );
    procedure SetNroDocumentoPropietario( const Value  : Variant );
    procedure SetEntregaACuenta( const Value  : Variant );
    procedure SetEntregaEfectivo( const Value  : Variant );
    procedure SetCodigoTransportista( const Value  : Variant );
    procedure SetIVAIncluido( const Value  : Variant );
    procedure SetPortes( const Value  : Variant );
    procedure SetCodigoFormaCobro( const Value  : Variant );
    procedure SetOrganismoPublico( const Value  : Variant );
    procedure SetSituacion( const Value  : Variant );
    procedure SetDescripcionMovimiento( const Value  : Variant );
    procedure SetCampoLibre( Index : SmallInt; const Value  : Variant );
    procedure SetTipoVentaPeriodica( const Value  : Variant );
    procedure SetCreado( const Value  : Variant );
    procedure SetRevisado( const Value  : Variant );
    procedure SetSuministrado( const Value  : Variant );
    procedure SetFechaEnvioPorCorreo( const Value  : Variant );
    procedure SetAnotacion( const Value  : Variant );
    procedure SetFirma( const Value  : Variant );
    property RemoteCursorID : TnxCursorID read GetRemoteCursorID write SetRemoteCursorID;
    property State : TDatasetState read GetState write SetState;

    property Ejercicio : SmallInt read GetEjercicio write SetEjercicio;
    property NroOperacion : Integer read GetNroOperacion write SetNroOperacion;
    property TipoMovimiento : SmallInt read GetTipoMovimiento write SetTipoMovimiento;
    property Propietario : Variant read GetPropietario write SetPropietario;
    property Serie : Variant read GetSerie write SetSerie;
    property NroDocumento : Variant read GetNroDocumento write SetNroDocumento;
    property UUID : Variant read GetUUID write SetUUID;
    property Fecha : Variant read GetFecha write SetFecha;
    property FechaAplicacion : Variant read GetFechaAplicacion write SetFechaAplicacion;
    property FechaEmision : Variant read GetFechaEmision write SetFechaEmision;
    property FechaAuxiliar : Variant read GetFechaAuxiliar write SetFechaAuxiliar;
    property GrupoFacturacion : Variant read GetGrupoFacturacion write SetGrupoFacturacion;
    property RegistroAuxiliar : Variant read GetRegistroAuxiliar write SetRegistroAuxiliar;
    property CodigoVendedor : Variant read GetCodigoVendedor write SetCodigoVendedor;
    property CodigoOperario : Variant read GetCodigoOperario write SetCodigoOperario;
    property CentroCoste : Variant read GetCentroCoste write SetCentroCoste;
    property FormaEnvio : Variant read GetFormaEnvio write SetFormaEnvio;
    property EjercicioFactura : Variant read GetEjercicioFactura write SetEjercicioFactura;
    property PropietarioFactura : Variant read GetPropietarioFactura write SetPropietarioFactura;
    property SerieFactura : Variant read GetSerieFactura write SetSerieFactura;
    property NroFactura : Variant read GetNroFactura write SetNroFactura;
    property NoFacturar : Variant read GetNoFacturar write SetNoFacturar;
    property Facturado : Variant read GetFacturado write SetFacturado;
    property Traspasado : Variant read GetTraspasado write SetTraspasado;
    property Anulado : Variant read GetAnulado write SetAnulado;
    property Origen : Variant read GetOrigen write SetOrigen;
    property Opcion : Variant read GetOpcion write SetOpcion;
    property EjercicioOrigen : Variant read GetEjercicioOrigen write SetEjercicioOrigen;
    property NroOperacionOrigen : Variant read GetNroOperacionOrigen write SetNroOperacionOrigen;
    property NroDocumentoPropietario : Variant read GetNroDocumentoPropietario write SetNroDocumentoPropietario;
    property EntregaACuenta : Variant read GetEntregaACuenta write SetEntregaACuenta;
    property EntregaEfectivo : Variant read GetEntregaEfectivo write SetEntregaEfectivo;
    property CodigoTransportista : Variant read GetCodigoTransportista write SetCodigoTransportista;
    property IVAIncluido : Variant read GetIVAIncluido write SetIVAIncluido;
    property Portes : Variant read GetPortes write SetPortes;
    property CodigoFormaCobro : Variant read GetCodigoFormaCobro write SetCodigoFormaCobro;
    property OrganismoPublico : Variant read GetOrganismoPublico write SetOrganismoPublico;
    property Situacion : Variant read GetSituacion write SetSituacion;
    property DescripcionMovimiento : Variant read GetDescripcionMovimiento write SetDescripcionMovimiento;
    property CampoLibre[ Index : SmallInt ] : Variant read GetCampoLibre write SetCampoLibre;
    property TipoVentaPeriodica : Variant read GetTipoVentaPeriodica write SetTipoVentaPeriodica;
    property Creado : Variant read GetCreado write SetCreado;
    property Revisado : Variant read GetRevisado write SetRevisado;
    property Suministrado : Variant read GetSuministrado write SetSuministrado;
    property FechaEnvioPorCorreo : Variant read GetFechaEnvioPorCorreo write SetFechaEnvioPorCorreo;
    property Anotacion : Variant read GetAnotacion write SetAnotacion;
    property Firma : Variant read GetFirma write SetFirma;

    end;

   TMovimiento = class( TnxClass, InxRemoteableClass, IMovimiento)
     private

     FRemoteCursorID,
     FState : Variant;

     FEjercicio,
     FNroOperacion,
     FTipoMovimiento,
     FPropietario,
     FSerie,
     FNroDocumento,
     FUUID,
     FFecha,
     FFechaAplicacion,
     FFechaEmision,
     FFechaAuxiliar,
     FGrupoFacturacion,
     FRegistroAuxiliar,
     FCodigoVendedor,
     FCodigoOperario,
     FCentroCoste,
     FFormaEnvio,
     FEjercicioFactura,
     FPropietarioFactura,
     FSerieFactura,
     FNroFactura,
     FNoFacturar,
     FFacturado,
     FTraspasado,
     FAnulado,
     FOrigen,
     FOpcion,
     FEjercicioOrigen,
     FNroOperacionOrigen,
     FNroDocumentoPropietario,
     FEntregaACuenta,
     FEntregaEfectivo,
     FCodigoTransportista,
     FIVAIncluido,
     FPortes,
     FCodigoFormaCobro,
     FOrganismoPublico,
     FSituacion,
     FDescripcionMovimiento : Variant;
     FCampoLibre : Array[ 1..5 ] of Variant;
     FTipoVentaPeriodica,
     FCreado,
     FRevisado,
     FSuministrado,
     FFechaEnvioPorCorreo,
     FAnotacion,
     FFirma : Variant;

     function GetEjercicio : SmallInt;
     function GetNroOperacion : Integer;
     function GetTipoMovimiento : SmallInt;
     function GetPropietario : Variant;
     function GetSerie : Variant;
     function GetNroDocumento : Variant;
     function GetUUID : Variant;
     function GetFecha : Variant;
     function GetFechaAplicacion : Variant;
     function GetFechaEmision : Variant;
     function GetFechaAuxiliar : Variant;
     function GetGrupoFacturacion : Variant;
     function GetRegistroAuxiliar : Variant;
     function GetCodigoVendedor : Variant;
     function GetCodigoOperario : Variant;
     function GetCentroCoste : Variant;
     function GetFormaEnvio : Variant;
     function GetEjercicioFactura : Variant;
     function GetPropietarioFactura : Variant;
     function GetSerieFactura : Variant;
     function GetNroFactura : Variant;
     function GetNoFacturar : Variant;
     function GetFacturado : Variant;
     function GetTraspasado : Variant;
     function GetAnulado : Variant;
     function GetOrigen : Variant;
     function GetOpcion : Variant;
     function GetEjercicioOrigen : Variant;
     function GetNroOperacionOrigen : Variant;
     function GetNroDocumentoPropietario : Variant;
     function GetEntregaACuenta : Variant;
     function GetEntregaEfectivo : Variant;
     function GetCodigoTransportista : Variant;
     function GetIVAIncluido : Variant;
     function GetPortes : Variant;
     function GetCodigoFormaCobro : Variant;
     function GetOrganismoPublico : Variant;
     function GetSituacion : Variant;
     function GetDescripcionMovimiento : Variant;
     function GetCampoLibre( Index : SmallInt ) : Variant;
     function GetTipoVentaPeriodica : Variant;
     function GetCreado : Variant;
     function GetRevisado : Variant;
     function GetSuministrado : Variant;
     function GetFechaEnvioPorCorreo : Variant;
     function GetAnotacion : Variant;
     function GetFirma : Variant;

     procedure SetEjercicio( const Value  : SmallInt );
     procedure SetNroOperacion( const Value  : Integer );
     procedure SetTipoMovimiento( const Value  : SmallInt );
     procedure SetPropietario( const Value  : Variant );
     procedure SetSerie( const Value  : Variant );
     procedure SetNroDocumento( const Value  : Variant );
     procedure SetUUID( const Value  : Variant );
     procedure SetFecha( const Value  : Variant );
     procedure SetFechaAplicacion( const Value  : Variant );
     procedure SetFechaEmision( const Value  : Variant );
     procedure SetFechaAuxiliar( const Value  : Variant );
     procedure SetGrupoFacturacion( const Value  : Variant );
     procedure SetRegistroAuxiliar( const Value  : Variant );
     procedure SetCodigoVendedor( const Value  : Variant );
     procedure SetCodigoOperario( const Value  : Variant );
     procedure SetCentroCoste( const Value  : Variant );
     procedure SetFormaEnvio( const Value  : Variant );
     procedure SetEjercicioFactura( const Value  : Variant );
     procedure SetPropietarioFactura( const Value  : Variant );
     procedure SetSerieFactura( const Value  : Variant );
     procedure SetNroFactura( const Value  : Variant );
     procedure SetNoFacturar( const Value  : Variant );
     procedure SetFacturado( const Value  : Variant );
     procedure SetTraspasado( const Value  : Variant );
     procedure SetAnulado( const Value  : Variant );
     procedure SetOrigen( const Value  : Variant );
     procedure SetOpcion( const Value  : Variant );
     procedure SetEjercicioOrigen( const Value  : Variant );
     procedure SetNroOperacionOrigen( const Value  : Variant );
     procedure SetNroDocumentoPropietario( const Value  : Variant );
     procedure SetEntregaACuenta( const Value  : Variant );
     procedure SetEntregaEfectivo( const Value  : Variant );
     procedure SetCodigoTransportista( const Value  : Variant );
     procedure SetIVAIncluido( const Value  : Variant );
     procedure SetPortes( const Value  : Variant );
     procedure SetCodigoFormaCobro( const Value  : Variant );
     procedure SetOrganismoPublico( const Value  : Variant );
     procedure SetSituacion( const Value  : Variant );
     procedure SetDescripcionMovimiento( const Value  : Variant );
     procedure SetCampoLibre( Index : SmallInt; const Value  : Variant );
     procedure SetTipoVentaPeriodica( const Value  : Variant );
     procedure SetCreado( const Value  : Variant );
     procedure SetRevisado( const Value  : Variant );
     procedure SetSuministrado( const Value  : Variant );
     procedure SetFechaEnvioPorCorreo( const Value  : Variant );
     procedure SetAnotacion( const Value  : Variant );
     procedure SetFirma( const Value  : Variant );

     function LoadFromReader( AReader : InxReader ) : HRESULT;
     function SaveToWriter( AWriter : InxWriter ) : HRESULT;

     function GetRemoteCursorID : TnxCursorID;
     procedure SetRemoteCursorID( const Value : TnxCursorID );
     function GetState : TDataSetState;
     procedure SetState( const Value : TDataSetState );
     function GetClassID : TnxGuid;

     public

     constructor Create; reintroduce;

     class function FromDataset( MovimientoFields  : TMovimientoFields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : IMovimiento;
     procedure ToDataset( MovimientoFields : TMovimientoFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );

     end;

implementation

uses  Variants;

{ TMovimiento }

constructor TMovimiento.Create;
begin
     inherited Create( @CLSID_Movimiento, nil, nil, False);
     FState := dsInsert;
end;

class function TMovimiento.FromDataset( MovimientoFields : TMovimientoFields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : IMovimiento;

var   SaveState : TDataSetState;
      ApplyOldValues : Boolean;

begin
      Result := TMovimiento.Create;

      With Result do
        begin

        RemoteCursorID := MovimientoFields.GetRemoteCursorID;
        State := MovimientoFields.Dataset.State;
        SaveState := State;

        ApplyOldValues := OldValues and not ( State in [ dsInsert, dsSetKey ] );
        If   ApplyOldValues
        then MovimientoFields.IDataset.SetTempState( dsOldValue );

        try

          Ejercicio := GetFieldAsVariant( MovimientoFields.Ejercicio );
          NroOperacion := GetFieldAsVariant( MovimientoFields.NroOperacion );
          TipoMovimiento := GetFieldAsVariant( MovimientoFields.TipoMovimiento );
          Propietario := GetFieldAsVariant( MovimientoFields.Propietario );
          Serie := GetFieldAsVariant( MovimientoFields.Serie );
          NroDocumento := GetFieldAsVariant( MovimientoFields.NroDocumento );
          UUID := GetFieldAsVariant( MovimientoFields.UUID );
          Fecha := GetFieldAsVariant( MovimientoFields.Fecha );
          FechaAplicacion := GetFieldAsVariant( MovimientoFields.FechaAplicacion );
          FechaEmision := GetFieldAsVariant( MovimientoFields.FechaEmision );
          FechaAuxiliar := GetFieldAsVariant( MovimientoFields.FechaAuxiliar );
          GrupoFacturacion := GetFieldAsVariant( MovimientoFields.GrupoFacturacion );
          RegistroAuxiliar := GetFieldAsVariant( MovimientoFields.RegistroAuxiliar );
          CodigoVendedor := GetFieldAsVariant( MovimientoFields.CodigoVendedor );
          CodigoOperario := GetFieldAsVariant( MovimientoFields.CodigoOperario );
          CentroCoste := GetFieldAsVariant( MovimientoFields.CentroCoste );
          FormaEnvio := GetFieldAsVariant( MovimientoFields.FormaEnvio );
          EjercicioFactura := GetFieldAsVariant( MovimientoFields.EjercicioFactura );
          PropietarioFactura := GetFieldAsVariant( MovimientoFields.PropietarioFactura );
          SerieFactura := GetFieldAsVariant( MovimientoFields.SerieFactura );
          NroFactura := GetFieldAsVariant( MovimientoFields.NroFactura );
          NoFacturar := GetFieldAsVariant( MovimientoFields.NoFacturar );
          Facturado := GetFieldAsVariant( MovimientoFields.Facturado );
          Traspasado := GetFieldAsVariant( MovimientoFields.Traspasado );
          Anulado := GetFieldAsVariant( MovimientoFields.Anulado );
          Origen := GetFieldAsVariant( MovimientoFields.Origen );
          Opcion := GetFieldAsVariant( MovimientoFields.Opcion );
          EjercicioOrigen := GetFieldAsVariant( MovimientoFields.EjercicioOrigen );
          NroOperacionOrigen := GetFieldAsVariant( MovimientoFields.NroOperacionOrigen );
          NroDocumentoPropietario := GetFieldAsVariant( MovimientoFields.NroDocumentoPropietario );
          EntregaACuenta := GetFieldAsVariant( MovimientoFields.EntregaACuenta );
          EntregaEfectivo := GetFieldAsVariant( MovimientoFields.EntregaEfectivo );
          CodigoTransportista := GetFieldAsVariant( MovimientoFields.CodigoTransportista );
          IVAIncluido := GetFieldAsVariant( MovimientoFields.IVAIncluido );
          Portes := GetFieldAsVariant( MovimientoFields.Portes );
          CodigoFormaCobro := GetFieldAsVariant( MovimientoFields.CodigoFormaCobro );
          OrganismoPublico := GetFieldAsVariant( MovimientoFields.OrganismoPublico );
          Situacion := GetFieldAsVariant( MovimientoFields.Situacion );
          DescripcionMovimiento := GetFieldAsVariant( MovimientoFields.DescripcionMovimiento );
          For var Inx := 1 to 5 do 
            CampoLibre[ Inx ] := GetFieldAsVariant( MovimientoFields.CampoLibre[ Inx ] );
          TipoVentaPeriodica := GetFieldAsVariant( MovimientoFields.TipoVentaPeriodica );
          Creado := GetFieldAsVariant( MovimientoFields.Creado );
          Revisado := GetFieldAsVariant( MovimientoFields.Revisado );
          Suministrado := GetFieldAsVariant( MovimientoFields.Suministrado );
          FechaEnvioPorCorreo := GetFieldAsVariant( MovimientoFields.FechaEnvioPorCorreo );

          If   ReadBlobs
          then begin
               Anotacion := GetFieldAsVariant( MovimientoFields.Anotacion );
               Firma := GetFieldAsVariant( MovimientoFields.Firma );
               end
          else begin
               Anotacion := '';
               Firma := '';
               end;;

        finally
          If   ApplyOldValues
          then MovimientoFields.IDataset.RestoreState( SaveState );
        end;
      end;

end;

procedure TMovimiento.ToDataset( MovimientoFields : TMovimientoFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );
begin
     try

       If   not PreserveState
       then MovimientoFields.SetStateFromInterface( FState );

       MovimientoFields.Ejercicio.Value := FEjercicio;
       MovimientoFields.NroOperacion.Value := FNroOperacion;

       If   VarToStr( FUUID )=''
       then FUUID := GetGuid.ToString;

       SetFieldAsVariant( MovimientoFields.TipoMovimiento, FTipoMovimiento );
       SetFieldAsVariant( MovimientoFields.Propietario, FPropietario );
       SetFieldAsVariant( MovimientoFields.Serie, FSerie );
       SetFieldAsVariant( MovimientoFields.NroDocumento, FNroDocumento );
       SetFieldAsVariant( MovimientoFields.UUID, FUUID );
       SetFieldAsVariant( MovimientoFields.Fecha, FFecha );
       SetFieldAsVariant( MovimientoFields.FechaAplicacion, FFechaAplicacion );
       SetFieldAsVariant( MovimientoFields.FechaEmision, FFechaEmision );
       SetFieldAsVariant( MovimientoFields.FechaAuxiliar, FFechaAuxiliar );
       SetFieldAsVariant( MovimientoFields.GrupoFacturacion, FGrupoFacturacion );
       SetFieldAsVariant( MovimientoFields.RegistroAuxiliar, FRegistroAuxiliar );
       SetFieldAsVariant( MovimientoFields.CodigoVendedor, FCodigoVendedor );
       SetFieldAsVariant( MovimientoFields.CodigoOperario, FCodigoOperario );
       SetFieldAsVariant( MovimientoFields.CentroCoste, FCentroCoste );
       SetFieldAsVariant( MovimientoFields.FormaEnvio, FFormaEnvio );
       SetFieldAsVariant( MovimientoFields.EjercicioFactura, FEjercicioFactura );
       SetFieldAsVariant( MovimientoFields.PropietarioFactura, FPropietarioFactura );
       SetFieldAsVariant( MovimientoFields.SerieFactura, FSerieFactura );
       SetFieldAsVariant( MovimientoFields.NroFactura, FNroFactura );
       SetFieldAsVariant( MovimientoFields.NoFacturar, FNoFacturar );
       SetFieldAsVariant( MovimientoFields.Facturado, FFacturado );
       SetFieldAsVariant( MovimientoFields.Traspasado, FTraspasado );
       SetFieldAsVariant( MovimientoFields.Anulado, FAnulado );
       SetFieldAsVariant( MovimientoFields.Origen, FOrigen );
       SetFieldAsVariant( MovimientoFields.Opcion, FOpcion );
       SetFieldAsVariant( MovimientoFields.EjercicioOrigen, FEjercicioOrigen );
       SetFieldAsVariant( MovimientoFields.NroOperacionOrigen, FNroOperacionOrigen );
       SetFieldAsVariant( MovimientoFields.NroDocumentoPropietario, FNroDocumentoPropietario );
       SetFieldAsVariant( MovimientoFields.EntregaACuenta, FEntregaACuenta );
       SetFieldAsVariant( MovimientoFields.EntregaEfectivo, FEntregaEfectivo );
       SetFieldAsVariant( MovimientoFields.CodigoTransportista, FCodigoTransportista );
       SetFieldAsVariant( MovimientoFields.IVAIncluido, FIVAIncluido );
       SetFieldAsVariant( MovimientoFields.Portes, FPortes );
       SetFieldAsVariant( MovimientoFields.CodigoFormaCobro, FCodigoFormaCobro );
       SetFieldAsVariant( MovimientoFields.OrganismoPublico, FOrganismoPublico );
       SetFieldAsVariant( MovimientoFields.Situacion, FSituacion );
       SetFieldAsVariant( MovimientoFields.DescripcionMovimiento, FDescripcionMovimiento );
       For var Inx := 1 to 5 do 
         SetFieldAsVariant( MovimientoFields.CampoLibre[ Inx ], FCampoLibre[ Inx ] );
       SetFieldAsVariant( MovimientoFields.TipoVentaPeriodica, FTipoVentaPeriodica );
       SetFieldAsVariant( MovimientoFields.Creado, FCreado );
       SetFieldAsVariant( MovimientoFields.Revisado, FRevisado );
       SetFieldAsVariant( MovimientoFields.Suministrado, FSuministrado );
       SetFieldAsVariant( MovimientoFields.FechaEnvioPorCorreo, FFechaEnvioPorCorreo );

       If   ReadBlobs
       then begin
            SetFieldAsVariant( MovimientoFields.Anotacion, FAnotacion );
            SetFieldAsVariant( MovimientoFields.Firma, FFirma );
            end
       else begin
            MovimientoFields.Anotacion.Clear;
            MovimientoFields.Firma.Clear;
            end;

     except
       MovimientoFields.Dataset.Cancel;
       raise;
       end;

end;

function TMovimiento.LoadFromReader( AReader : InxReader ) : HRESULT;

var VarFlags : TnxVarFlags;

begin
     nxReadVariant( VarFlags, FRemoteCursorID, AReader );
     nxReadVariant( VarFlags, FState, AReader );

     nxReadVariant( VarFlags, FEjercicio, AReader );
     nxReadVariant( VarFlags, FNroOperacion, AReader );
     nxReadVariant( VarFlags, FTipoMovimiento, AReader );
     nxReadVariant( VarFlags, FPropietario, AReader );
     nxReadVariant( VarFlags, FSerie, AReader );
     nxReadVariant( VarFlags, FNroDocumento, AReader );
     nxReadVariant( VarFlags, FUUID, AReader );
     nxReadVariant( VarFlags, FFecha, AReader );
     nxReadVariant( VarFlags, FFechaAplicacion, AReader );
     nxReadVariant( VarFlags, FFechaEmision, AReader );
     nxReadVariant( VarFlags, FFechaAuxiliar, AReader );
     nxReadVariant( VarFlags, FGrupoFacturacion, AReader );
     nxReadVariant( VarFlags, FRegistroAuxiliar, AReader );
     nxReadVariant( VarFlags, FCodigoVendedor, AReader );
     nxReadVariant( VarFlags, FCodigoOperario, AReader );
     nxReadVariant( VarFlags, FCentroCoste, AReader );
     nxReadVariant( VarFlags, FFormaEnvio, AReader );
     nxReadVariant( VarFlags, FEjercicioFactura, AReader );
     nxReadVariant( VarFlags, FPropietarioFactura, AReader );
     nxReadVariant( VarFlags, FSerieFactura, AReader );
     nxReadVariant( VarFlags, FNroFactura, AReader );
     nxReadVariant( VarFlags, FNoFacturar, AReader );
     nxReadVariant( VarFlags, FFacturado, AReader );
     nxReadVariant( VarFlags, FTraspasado, AReader );
     nxReadVariant( VarFlags, FAnulado, AReader );
     nxReadVariant( VarFlags, FOrigen, AReader );
     nxReadVariant( VarFlags, FOpcion, AReader );
     nxReadVariant( VarFlags, FEjercicioOrigen, AReader );
     nxReadVariant( VarFlags, FNroOperacionOrigen, AReader );
     nxReadVariant( VarFlags, FNroDocumentoPropietario, AReader );
     nxReadVariant( VarFlags, FEntregaACuenta, AReader );
     nxReadVariant( VarFlags, FEntregaEfectivo, AReader );
     nxReadVariant( VarFlags, FCodigoTransportista, AReader );
     nxReadVariant( VarFlags, FIVAIncluido, AReader );
     nxReadVariant( VarFlags, FPortes, AReader );
     nxReadVariant( VarFlags, FCodigoFormaCobro, AReader );
     nxReadVariant( VarFlags, FOrganismoPublico, AReader );
     nxReadVariant( VarFlags, FSituacion, AReader );
     nxReadVariant( VarFlags, FDescripcionMovimiento, AReader );
     For var Inx := 1 to 5 do 
       nxReadVariant( VarFlags, FCampoLibre[ Inx ], AReader );
     nxReadVariant( VarFlags, FTipoVentaPeriodica, AReader );
     nxReadVariant( VarFlags, FCreado, AReader );
     nxReadVariant( VarFlags, FRevisado, AReader );
     nxReadVariant( VarFlags, FSuministrado, AReader );
     nxReadVariant( VarFlags, FFechaEnvioPorCorreo, AReader );
     nxReadVariant( VarFlags, FAnotacion, AReader );
     nxReadVariant( VarFlags, FFirma, AReader );

     Result := S_OK;
end;

function TMovimiento.SaveToWriter( AWriter : InxWriter) : HRESULT;
begin
     nxWriteVariant( FRemoteCursorID, AWriter );
     nxWriteVariant( FState, AWriter );

     nxWriteVariant( FEjercicio, AWriter );
     nxWriteVariant( FNroOperacion, AWriter );
     nxWriteVariant( FTipoMovimiento, AWriter );
     nxWriteVariant( FPropietario, AWriter );
     nxWriteVariant( FSerie, AWriter );
     nxWriteVariant( FNroDocumento, AWriter );
     nxWriteVariant( FUUID, AWriter );
     nxWriteVariant( FFecha, AWriter );
     nxWriteVariant( FFechaAplicacion, AWriter );
     nxWriteVariant( FFechaEmision, AWriter );
     nxWriteVariant( FFechaAuxiliar, AWriter );
     nxWriteVariant( FGrupoFacturacion, AWriter );
     nxWriteVariant( FRegistroAuxiliar, AWriter );
     nxWriteVariant( FCodigoVendedor, AWriter );
     nxWriteVariant( FCodigoOperario, AWriter );
     nxWriteVariant( FCentroCoste, AWriter );
     nxWriteVariant( FFormaEnvio, AWriter );
     nxWriteVariant( FEjercicioFactura, AWriter );
     nxWriteVariant( FPropietarioFactura, AWriter );
     nxWriteVariant( FSerieFactura, AWriter );
     nxWriteVariant( FNroFactura, AWriter );
     nxWriteVariant( FNoFacturar, AWriter );
     nxWriteVariant( FFacturado, AWriter );
     nxWriteVariant( FTraspasado, AWriter );
     nxWriteVariant( FAnulado, AWriter );
     nxWriteVariant( FOrigen, AWriter );
     nxWriteVariant( FOpcion, AWriter );
     nxWriteVariant( FEjercicioOrigen, AWriter );
     nxWriteVariant( FNroOperacionOrigen, AWriter );
     nxWriteVariant( FNroDocumentoPropietario, AWriter );
     nxWriteVariant( FEntregaACuenta, AWriter );
     nxWriteVariant( FEntregaEfectivo, AWriter );
     nxWriteVariant( FCodigoTransportista, AWriter );
     nxWriteVariant( FIVAIncluido, AWriter );
     nxWriteVariant( FPortes, AWriter );
     nxWriteVariant( FCodigoFormaCobro, AWriter );
     nxWriteVariant( FOrganismoPublico, AWriter );
     nxWriteVariant( FSituacion, AWriter );
     nxWriteVariant( FDescripcionMovimiento, AWriter );
     For var Inx := 1 to 5 do 
       nxWriteVariant( FCampoLibre[ Inx ], AWriter );
     nxWriteVariant( FTipoVentaPeriodica, AWriter );
     nxWriteVariant( FCreado, AWriter );
     nxWriteVariant( FRevisado, AWriter );
     nxWriteVariant( FSuministrado, AWriter );
     nxWriteVariant( FFechaEnvioPorCorreo, AWriter );
     nxWriteVariant( FAnotacion, AWriter );
     nxWriteVariant( FFirma, AWriter );
     Result := S_OK;
end;

{ Getters}

function TMovimiento.GetClassID: TnxGuid;
begin
     Result := CLSID_Movimiento;
end;

function TMovimiento.GetRemoteCursorID: TnxCursorID;
begin
     Result := FRemoteCursorID;
end;

function TMovimiento.GetState: TDataSetState;
begin
     Result := FState;
end;


function TMovimiento.GetEjercicio : SmallInt;
begin
     Result := FEjercicio;
end;

function TMovimiento.GetNroOperacion : Integer;
begin
     Result := FNroOperacion;
end;

function TMovimiento.GetTipoMovimiento: SmallInt;
begin
     Result := FTipoMovimiento;
end;

function TMovimiento.GetPropietario : Variant;
begin
     Result := FPropietario;
end;

function TMovimiento.GetSerie : Variant;
begin
     Result := FSerie;
end;

function TMovimiento.GetNroDocumento : Variant;
begin
     Result := FNroDocumento;
end;

function TMovimiento.GetUUID : Variant;
begin
     Result := FUUID;
end;

function TMovimiento.GetFecha : Variant;
begin
     Result := FFecha;
end;

function TMovimiento.GetFechaAplicacion : Variant;
begin
     Result := FFechaAplicacion;
end;

function TMovimiento.GetFechaEmision : Variant;
begin
     Result := FFechaEmision;
end;

function TMovimiento.GetFechaAuxiliar : Variant;
begin
     Result := FFechaAuxiliar;
end;

function TMovimiento.GetGrupoFacturacion : Variant;
begin
     Result := FGrupoFacturacion;
end;

function TMovimiento.GetRegistroAuxiliar : Variant;
begin
     Result := FRegistroAuxiliar;
end;

function TMovimiento.GetCodigoVendedor : Variant;
begin
     Result := FCodigoVendedor;
end;

function TMovimiento.GetCodigoOperario : Variant;
begin
     Result := FCodigoOperario;
end;

function TMovimiento.GetCentroCoste : Variant;
begin
     Result := FCentroCoste;
end;

function TMovimiento.GetFormaEnvio : Variant;
begin
     Result := FFormaEnvio;
end;

function TMovimiento.GetEjercicioFactura : Variant;
begin
     Result := FEjercicioFactura;
end;

function TMovimiento.GetPropietarioFactura : Variant;
begin
     Result := FPropietarioFactura;
end;

function TMovimiento.GetSerieFactura : Variant;
begin
     Result := FSerieFactura;
end;

function TMovimiento.GetNroFactura : Variant;
begin
     Result := FNroFactura;
end;

function TMovimiento.GetNoFacturar : Variant;
begin
     Result := FNoFacturar;
end;

function TMovimiento.GetFacturado : Variant;
begin
     Result := FFacturado;
end;

function TMovimiento.GetTraspasado : Variant;
begin
     Result := FTraspasado;
end;

function TMovimiento.GetAnulado : Variant;
begin
     Result := FAnulado;
end;

function TMovimiento.GetOrigen : Variant;
begin
     Result := FOrigen;
end;

function TMovimiento.GetOpcion : Variant;
begin
     Result := FOpcion;
end;

function TMovimiento.GetEjercicioOrigen : Variant;
begin
     Result := FEjercicioOrigen;
end;

function TMovimiento.GetNroOperacionOrigen : Variant;
begin
     Result := FNroOperacionOrigen;
end;

function TMovimiento.GetNroDocumentoPropietario : Variant;
begin
     Result := FNroDocumentoPropietario;
end;

function TMovimiento.GetEntregaACuenta : Variant;
begin
     Result := FEntregaACuenta;
end;

function TMovimiento.GetEntregaEfectivo : Variant;
begin
     Result := FEntregaEfectivo;
end;

function TMovimiento.GetCodigoTransportista : Variant;
begin
     Result := FCodigoTransportista;
end;

function TMovimiento.GetIVAIncluido : Variant;
begin
     Result := FIVAIncluido;
end;

function TMovimiento.GetPortes : Variant;
begin
     Result := FPortes;
end;

function TMovimiento.GetCodigoFormaCobro : Variant;
begin
     Result := FCodigoFormaCobro;
end;

function TMovimiento.GetOrganismoPublico : Variant;
begin
     Result := FOrganismoPublico;
end;

function TMovimiento.GetSituacion : Variant;
begin
     Result := FSituacion;
end;

function TMovimiento.GetDescripcionMovimiento : Variant;
begin
     Result := FDescripcionMovimiento;
end;

function TMovimiento.GetCampoLibre( Index : SmallInt ) : Variant;
begin
     Result := FCampoLibre[ Index ];
end;

function TMovimiento.GetTipoVentaPeriodica : Variant;
begin
     Result := FTipoVentaPeriodica;
end;

function TMovimiento.GetCreado : Variant;
begin
     Result := FCreado;
end;

function TMovimiento.GetRevisado : Variant;
begin
     Result := FRevisado;
end;

function TMovimiento.GetSuministrado : Variant;
begin
     Result := FSuministrado;
end;

function TMovimiento.GetFechaEnvioPorCorreo : Variant;
begin
     Result := FFechaEnvioPorCorreo;
end;

function TMovimiento.GetAnotacion : Variant;
begin
     Result := FAnotacion;
end;

function TMovimiento.GetFirma : Variant;
begin
     Result := FFirma;
end;

{ Setters}

procedure TMovimiento.SetRemoteCursorID( const Value : TnxCursorID );
begin
     FRemoteCursorID := Value;
end;

procedure TMovimiento.SetState( const Value : TDataSetState );
begin
     FState := Value;
end;


procedure TMovimiento.SetEjercicio(  const Value : SmallInt );
begin
     FEjercicio := Value;
end;

procedure TMovimiento.SetNroOperacion(  const Value : Integer );
begin
     FNroOperacion := Value;
end;

procedure TMovimiento.SetTipoMovimiento(const Value: SmallInt);
begin
     FTipoMovimiento := Value;
end;

procedure TMovimiento.SetPropietario(  const Value : Variant );
begin
     FPropietario := Value;
end;

procedure TMovimiento.SetSerie(  const Value : Variant );
begin
     FSerie := Value;
end;

procedure TMovimiento.SetNroDocumento(  const Value : Variant );
begin
     FNroDocumento := Value;
end;

procedure TMovimiento.SetUUID(  const Value : Variant );
begin
     FUUID := Value;
end;

procedure TMovimiento.SetFecha(  const Value : Variant );
begin
     FFecha := Value;
end;

procedure TMovimiento.SetFechaAplicacion(  const Value : Variant );
begin
     FFechaAplicacion := Value;
end;

procedure TMovimiento.SetFechaEmision(  const Value : Variant );
begin
     FFechaEmision := Value;
end;

procedure TMovimiento.SetFechaAuxiliar(  const Value : Variant );
begin
     FFechaAuxiliar := Value;
end;

procedure TMovimiento.SetGrupoFacturacion(  const Value : Variant );
begin
     FGrupoFacturacion := Value;
end;

procedure TMovimiento.SetRegistroAuxiliar(  const Value : Variant );
begin
     FRegistroAuxiliar := Value;
end;

procedure TMovimiento.SetCodigoVendedor(  const Value : Variant );
begin
     FCodigoVendedor := Value;
end;

procedure TMovimiento.SetCodigoOperario(  const Value : Variant );
begin
     FCodigoOperario := Value;
end;

procedure TMovimiento.SetCentroCoste(  const Value : Variant );
begin
     FCentroCoste := Value;
end;

procedure TMovimiento.SetFormaEnvio(  const Value : Variant );
begin
     FFormaEnvio := Value;
end;

procedure TMovimiento.SetEjercicioFactura(  const Value : Variant );
begin
     FEjercicioFactura := Value;
end;

procedure TMovimiento.SetPropietarioFactura(  const Value : Variant );
begin
     FPropietarioFactura := Value;
end;

procedure TMovimiento.SetSerieFactura(  const Value : Variant );
begin
     FSerieFactura := Value;
end;

procedure TMovimiento.SetNroFactura(  const Value : Variant );
begin
     FNroFactura := Value;
end;

procedure TMovimiento.SetNoFacturar(  const Value : Variant );
begin
     FNoFacturar := Value;
end;

procedure TMovimiento.SetFacturado(  const Value : Variant );
begin
     FFacturado := Value;
end;

procedure TMovimiento.SetTraspasado(  const Value : Variant );
begin
     FTraspasado := Value;
end;

procedure TMovimiento.SetAnulado(  const Value : Variant );
begin
     FAnulado := Value;
end;

procedure TMovimiento.SetOrigen(  const Value : Variant );
begin
     FOrigen := Value;
end;

procedure TMovimiento.SetOpcion(  const Value : Variant );
begin
     FOpcion := Value;
end;

procedure TMovimiento.SetEjercicioOrigen(  const Value : Variant );
begin
     FEjercicioOrigen := Value;
end;

procedure TMovimiento.SetNroOperacionOrigen(  const Value : Variant );
begin
     FNroOperacionOrigen := Value;
end;

procedure TMovimiento.SetNroDocumentoPropietario(  const Value : Variant );
begin
     FNroDocumentoPropietario := Value;
end;

procedure TMovimiento.SetEntregaACuenta(  const Value : Variant );
begin
     FEntregaACuenta := Value;
end;

procedure TMovimiento.SetEntregaEfectivo(  const Value : Variant );
begin
     FEntregaEfectivo := Value;
end;

procedure TMovimiento.SetCodigoTransportista(  const Value : Variant );
begin
     FCodigoTransportista := Value;
end;

procedure TMovimiento.SetIVAIncluido(  const Value : Variant );
begin
     FIVAIncluido := Value;
end;

procedure TMovimiento.SetPortes(  const Value : Variant );
begin
     FPortes := Value;
end;

procedure TMovimiento.SetCodigoFormaCobro(  const Value : Variant );
begin
     FCodigoFormaCobro := Value;
end;

procedure TMovimiento.SetOrganismoPublico(  const Value : Variant );
begin
     FOrganismoPublico := Value;
end;

procedure TMovimiento.SetSituacion(  const Value : Variant );
begin
     FSituacion := Value;
end;

procedure TMovimiento.SetDescripcionMovimiento(  const Value : Variant );
begin
     FDescripcionMovimiento := Value;
end;

procedure TMovimiento.SetCampoLibre( Index : SmallInt; const Value : Variant );
begin
     FCampoLibre[ Index ] := Value;
end;

procedure TMovimiento.SetTipoVentaPeriodica(  const Value : Variant );
begin
     FTipoVentaPeriodica := Value;
end;

procedure TMovimiento.SetCreado(  const Value : Variant );
begin
     FCreado := Value;
end;

procedure TMovimiento.SetRevisado(  const Value : Variant );
begin
     FRevisado := Value;
end;

procedure TMovimiento.SetSuministrado(  const Value : Variant );
begin
     FSuministrado := Value;
end;

procedure TMovimiento.SetFechaEnvioPorCorreo(  const Value : Variant );
begin
     FFechaEnvioPorCorreo := Value;
end;

procedure TMovimiento.SetAnotacion(  const Value : Variant );
begin
     FAnotacion := Value;
end;

procedure TMovimiento.SetFirma(  const Value : Variant );
begin
     FFirma := Value;
end;

var MovimientoControl : InxClassFactoryControl;

initialization
   nxInvokeRegistry.RegisterInterface( TypeInfo( IMovimiento ) );

   TnxClassFactory.RegisterClass( CLSID_Movimiento, TMovimiento, MovimientoControl );

end.
