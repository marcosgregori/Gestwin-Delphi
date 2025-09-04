unit dm_rpf;

interface

uses
  Windows, Messages, SysUtils, Classes,

  LibUtils,

  DB,
  nxdb,
  DataManager,
  ServerDataModule,
  SessionIntf,

  Gim10Fields,

  dmi_rpf;

type

   TRegistroPresentacionService = class( TSessionModule, IRegistroPresentacionService )
     private

     protected

     procedure AssignSession( const SessionID : Integer ); override;

     end;

  TRegistroPresentacionModule = class(TServerDataModule)
    DmRegistroPresentacionTable: TnxeTable;
    DmRegistroPresentacionAuxTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
  private

    FEntornoPruebasVerifactu,
    FEntornoVerifactu : Boolean;

    DmRegistroPresentacionFields,
    DmRegistroPresentacionAuxFields : TRegistroPresentacionFields;

    TipoRegistroActual : TTipoRegistroPresentacion;

  public

    function GetEntornoVerifactu : Boolean;
    function GetEntornoPruebasVerifactu : Boolean;

    function ObtenRegistroPresentacion( TipoRegistro               : TTipoRegistroPresentacion;
                                        Propietario,
                                        Serie                      : String;
                                        NroFactura                 : LongInt;
                                        RegistroPresentacionFields : TRegistroPresentacionFields = nil ) : Boolean;

    function ObtenEstadoPresentacionSii( TipoRegistro : TTipoRegistroPresentacion;
                                         Propietario,
                                         Serie        : String;
                                         NroFactura   : Integer ) : TEstadoPresentacionSii;

    function ObtenEstadoPresentacionVerifactu(     Serie              : String;
                                                   NroFactura         : Integer;
                                               out EstadoPresentacion : TEstadoPresentacionVerifactu;
                                               out Estadoregistro     : TEstadoregistroVerifactu ) : Boolean;

    property EntornoPruebasVerifactu : Boolean read GetEntornoPruebasVerifactu;
    property EntornoVerifactu : Boolean read GetEntornoVerifactu;

  end;


implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses Variants,
     ProcID,
     AppManager,
     EnterpriseData,
     SessionData,

     nxrdClass,
     nxrbTypes,

     Gim00Fields,

     dmi_cnd,

     dm_cnd;

{$R *.DFM}

{ RegistroPresentacionModule }

procedure TRegistroPresentacionModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmRegistroPresentacionFields := TRegistroPresentacionFields.Create( DmRegistroPresentacionTable );
     DmRegistroPresentacionAuxFields := TRegistroPresentacionFields.Create( DmRegistroPresentacionAuxTable );
end;

procedure TRegistroPresentacionModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm10.RegistroPresentacionModule := nil;
end;

function TRegistroPresentacionModule.GetEntornoPruebasVerifactu : Boolean;
begin
     // Cuando entre en vigor se podrá eliminar esta comprobación, porque los usuarios no podrán usar el entorno de pruebas (para evitar disgustos)
     Result := not ( SessionDataModule.SuministroInmediatoInformacion and SessionDataModule.EmpresaFields.Contable_SII.Value ) and
              ( ( SessionDataModule.EmpresaFields.Ventas_EntornoPruebasVerifactu.Value and ( Now<EncodeDate( 2026, 1, 1 ) ) ) );
end;

function TRegistroPresentacionModule.GetEntornoVerifactu : Boolean;
begin
     Result := ( not ( SessionDataModule.SuministroInmediatoInformacion and SessionDataModule.EmpresaFields.Contable_SII.Value ) and
               ( EntornoPruebasVerifactu or ( Now>=EncodeDate( 2026, 1, 1 ) ) ) );
end;

function TRegistroPresentacionModule.ObtenRegistroPresentacion( TipoRegistro               : TTipoRegistroPresentacion;
                                                                Propietario,
                                                                Serie                      : String;
                                                                NroFactura                 : LongInt;
                                                                RegistroPresentacionFields : TRegistroPresentacionFields = nil ) : Boolean;
begin
     DmRegistroPresentacionTable.IndexFieldNames := 'Tipo;Ejercicio;Propietario;Serie;NroFactura;NroEfecto';
     Result := DmRegistroPresentacionTable.FindKey( [ Ord( TipoRegistro ), SessionDataModule.Ejercicio, Propietario, Serie, NroFactura, NroEfectoRegistroFactura ] );
     If   Assigned( RegistroPresentacionFields )
     then RegistroPresentacionFields.Update( DmRegistroPresentacionTable );
end;

function TRegistroPresentacionModule.ObtenEstadoPresentacionSii( TipoRegistro : TTipoRegistroPresentacion;
                                                                 Propietario,
                                                                 Serie        : String;
                                                                 NroFactura   : Integer ) : TEstadoPresentacionSii;
begin
     Result := erpPendiente;
     If   ObtenRegistroPresentacion( TipoRegistro, Propietario, Serie, NroFactura )
     then Result := TEstadoPresentacionSii( DmRegistroPresentacionFields.EstadoPresentacion.Value );
end;

function TRegistroPresentacionModule.ObtenEstadoPresentacionVerifactu(     Serie              : String;
                                                                           NroFactura         : Integer;
                                                                       out EstadoPresentacion : TEstadoPresentacionVerifactu;
                                                                       out Estadoregistro     : TEstadoregistroVerifactu ) : Boolean;
begin
     Result := ObtenRegistroPresentacion( rpFacturaEmitidaVerifactu, '', Serie, NroFactura );
     If   Result
     then begin
          EstadoPresentacion := TEstadoPresentacionVerifactu( DmRegistroPresentacionFields.EstadoPresentacion.Value );
          EstadoRegistro := TEstadoregistroVerifactu( DmRegistroPresentacionFields.EstadoRegistro.Value );
          end;
end;

{ TRegistroPresentacionService }

procedure TRegistroPresentacionService.AssignSession( const SessionID : Integer );
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

var RegistroPresentacionControl : InxClassFactoryControl;

initialization
   TnxClassFactory.RegisterClass( CLSID_RegistroPresentacionService, TRegistroPresentacionService, RegistroPresentacionControl );

end.
