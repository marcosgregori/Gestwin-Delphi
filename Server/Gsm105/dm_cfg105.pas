
unit dm_cfg105;

interface

uses
  Windows, Messages, SysUtils, Classes,
  LibUtils,
  DB,
  Nxdb,
  DataManager,
  ServerDataModule,
  SessionIntf,

  Gim10Fields,
  Gim30Fields,
  Gim105Fields,

  dmi_cfg105;

type

    TConfiguracion105Service = class( TSessionModule, IConfiguracion105Service )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    public

      procedure Inicializa;
    end;

  TConfiguracion105Module = class(TServerDataModule)
    VendedoresFacturaTable: TnxeTable;
    VendedoresClienteTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
  private

    VendedoresClienteFields : TVendedoresClienteFields;
    VendedoresFacturaFields : TVendedoresFacturaFields;


    procedure DoOnGeneraFactura;
    procedure DoOnSuprimeRelacionesFactura( FacturaVentasFields : TFacturaVentasFields );

  public

    procedure Inicializa;
    end;


implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses DateUtils,

     nxrbTypes,
     nxrdClass,
     nxsdDataDictionaryStrings,

     AppManager,
     EnterpriseData,

     Gim00Fields,

     SessionData,

     Gsm105Dm,

     dmi_mov,

     dm_fdv;

{$R *.DFM}

procedure TConfiguracion105Module.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm105.Configuracion105Module := nil;
end;

procedure TConfiguracion105Module.ServerDataModuleCreate(Sender: TObject);
begin
     VendedoresClienteFields := TVendedoresClienteFields.Create( VendedoresClienteTable );
     VendedoresFacturaFields := TVendedoresFacturaFields.Create( VendedoresFacturaTable );
end;

procedure TConfiguracion105Module.Inicializa;
begin
     SessionDataModule.Dm30.FacturaVentasModule.OnGeneraFactura := DoOnGeneraFactura;
     SessionDataModule.Dm30.FacturaVentasModule.OnSuprimeRelacionesFactura := DoOnSuprimeRelacionesFactura;
end;

{ TConfiguracion105Service }

procedure TConfiguracion105Service.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

procedure TConfiguracion105Service.Inicializa;
begin
     SessionDataModule.Dm105.Configuracion105Module.Inicializa;
end;

procedure TConfiguracion105Module.DoOnGeneraFactura;

var  NroRegistroActual : SmallInt;

begin
     With SessionDataModule.Dm30.FacturaVentasModule, VendedoresClienteTable do
       begin
       Open; // Por si acaso
       NroRegistroActual := 1;
       SetRange( [ DrFacturaVentasFields.CodigoCliente.Value, 1 ], [ DrFacturaVentasFields.CodigoCliente.Value, MaxSmallInt ] );
       First;
       While not Eof do
         begin

         With VendedoresFacturaTable do
           try
            Append;
             With VendedoresFacturaFields do
               begin
               Ejercicio.Value := DrFacturaVentasFields.Ejercicio.Value;
               Serie.Value := DrFacturaVentasFields.Serie.Value;
               NroFactura.Value := DrFacturaVentasFields.NroFactura.Value;
               NroRegistro.Value := NroRegistroActual;
               CodigoVendedor.Value := VendedoresClienteFields.CodigoVendedor.Value;
               ImporteBase.Value := DrFacturaVentasFields.NetoFactura.Value - DrFacturaVentasFields.DescuentosClientes.Value;
               Comision.Value := VendedoresClienteFields.Comision.Value;
               end;
             Post;
           except
             Cancel;
             raise;
             end;
         Inc( NroRegistroActual );
         Next;
         end;
       end;
end;

procedure TConfiguracion105Module.DoOnSuprimeRelacionesFactura( FacturaVentasFields : TFacturaVentasFields );
begin
     With FacturaVentasFields do
        EnterpriseDataModule.ExecSQLCommand( Format( 'DELETE FROM VendedoresFactura WHERE Ejercicio=%d AND Serie=%s AND NroFactura=%d',
                                             [ Ejercicio.Value, QuotedStr( Serie.Value ), NroFactura.Value ] ) );
end;

var Configuracion105Control : InxClassFactoryControl;

initialization
    TnxClassFactory.RegisterClass( CLSID_Configuracion105Service, TConfiguracion105Service, Configuracion105Control );

end.
