
unit dm_rdip;

interface

uses
  Windows, Messages, SysUtils, Classes,

  DB,
  nxdb,
  DataManager,
  ServerDataModule,
  LibUtils,
  SessionIntf,

  Spring,

  Gim30Fields,
  Gim70Fields,

  dmi_rdip;

type

   TReconstruccionDatosInternosService = class( TSessionModule, IReconstruccionDatosInternosService )
     protected

     procedure AssignSession( const SessionID : Integer ); override;

     procedure Reconstruccion;
     end;

   TReasignacionNroRegistroEvent = procedure( NroRegistroAnterior, NroRegistroActual : LongWord ) of object;

   TReconstruccionDatosInternosModule = class(TServerDataModule)
    DmNotificacionESTable: TnxeTable;
    DmSecuenciaAsignacionTable: TnxeTable;
    DmLineaOFComponenteTable: TnxeTable;
    DmLineaOFOperacionTable: TnxeTable;
    DmOperacionTable: TnxeTable;
    DmOrdenFabricacionTable: TnxeTable;
    DmInformeFabricacionTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
  private

    DmSecuenciaAsignacionFields : TSecuenciaAsignacionFields;
    DmOrdenFabricacionFields : TOrdenFabricacionFields;
    DmLineaOFComponenteFields : TLineaOFComponenteFields;
    DmLineaOFOperacionFields : TLineaOFOperacionFields;
    DmOperacionFields : TOperacionFields;
    DmDefectoFields : TDefectoFields;
    DmInformeFabricacionFields : TInformeFabricacionFields;
    DmNotificacionESFields : TNotificacionESFields;

  public
    procedure Reconstruccion;
  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses Variants,
     nxllTypes,
     DateUtils,

     nxrdClass,
     nxrbTypes,

     dmi_cpr,
     dmi_odf,

     AppManager,
     EnterpriseData,
     SessionData;

{$R *.DFM}

resourceString
     RsMsg1   = 'Se ha producido un error durante el proceso de recontrucción de datos.'#13 +
                'Los datos pueden estar en una situación inconsistente. Antes de utilizar la aplicación ES NECESARIO que realice de nuevo este proceso.';
     RsMsg3   = 'Realizando la reconstrucción de stocks de fabricación.';
     RsMsg4   = 'Componentes en órdenes de fabricación ...';
     RsMsg5   = 'Orden nº %d';
     RsMsg6   = 'Proceso realizado satisfactoriamente.';
     RsMsg7   = 'Procesando informes de fabricación ...';
     RsMsg8   = 'Orden %d - %d, Proceso %d, Fecha %s, turno %d';
     RsMsg9   = 'Revisando las tareas ...';
     RsMsg10  = 'Procesando notificaciones de entrada y salida ...';
     RsMsg11  = 'Notificacion nº %d';

procedure TReconstruccionDatosInternosModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmOrdenFabricacionFields := TOrdenFabricacionFields.Create( DmOrdenFabricacionTable );
     DmLineaOFComponenteFields := TLineaOFComponenteFields.Create( DmLineaOFComponenteTable );
     DmLineaOFOperacionFields := TLineaOFOperacionFields.Create( DmLineaOFOperacionTable );
     DmInformeFabricacionFields := TInformeFabricacionFields.Create( DmInformeFabricacionTable );
     DmSecuenciaAsignacionFields := TSecuenciaAsignacionFields.Create( DmSecuenciaAsignacionTable );
     DmOperacionFields := TOperacionFields.Create( DmOperacionTable );
     DmNotificacionESFields := TNotificacionESFields.Create( DmNotificacionESTable );
end;

procedure TReconstruccionDatosInternosModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm70.ReconstruccionDatosInternosModule := nil;
end;

procedure TReconstruccionDatosInternosModule.Reconstruccion;

procedure ProcesaOrdenes;
begin

     SessionDataModule.SendNotification( ntInformation, RsMsg4 );

     With DmOrdenFabricacionTable do
       begin
       First;
       While not Eof  do
         begin
         SessionDataModule.SendNotification( ntRecord, Format( RsMsg5, [ DmOrdenFabricacionFields.NroOrden.Value ] ) );
         SessionDataModule.Dm70.ContenedorModule.Actualiza( DmOrdenFabricacionFields.EjercicioLanzamiento.Value,
                                                            DmOrdenFabricacionFields.NroOrden.Value,
                                                            0,
                                                            cnProductoCorrecto,
                                                            DmOrdenFabricacionFields.UnidadesAFabricar.Value,
                                                            False );
         Next;
         end;
       end;
end;

procedure ProcesaInformes;
begin
     SessionDataModule.SendNotification( ntInformation, RsMsg7 );

     With DmInformeFabricacionTable do
       begin
       First;
       While not Eof do
         begin

         With DmInformeFabricacionFields do
           SessionDataModule.SendNotification( ntRecord, Format( RsMsg8, [ Ejercicio.Value, NroOrden.Value, NroProceso.Value, StrFormatDate( Fecha.Value, dfDefault ), Turno.Value ] ) );

         If   DmOrdenFabricacionTable.FindKey( [ DmInformeFabricacionFields.Ejercicio.Value, moOrden, DmInformeFabricacionFields.NroOrden.Value ] )
         then SessionDataModule.Dm70.InformeFabricacionModule.ActualizaReferenciasRegistro( DmOrdenFabricacionFields, DmInformeFabricacionFields, False );

         Next;
         end;

       end;
end;

procedure ProcesaNotificaciones;
begin
     SessionDataModule.SendNotification( ntInformation, RsMsg10 );

     With DmNotificacionESTable do
       begin
       First;
       While not Eof do
         begin

         SessionDataModule.SendNotification( ntRecord, format( RsMsg11, [ DmNotificacionESFields.nroNotificacion ] ) );

         If   DmOrdenFabricacionTable.FindKey( [ DmNotificacionESFields.Ejercicio.Value, moOrden, DmNotificacionESFields.NroOrden.Value ] )
         then SessionDataModule.Dm70.ContenedorModule.ActualizaReferenciasNotificacionES( DmOrdenFabricacionFields, DmNotificacionESFields, False );

         Next;
         end;

       end;
end;

procedure RepasaSecuenciaAsignacion;

var  RealmenteRealizado : Boolean;

begin
     SessionDataModule.SendNotification( ntInformation, RsMsg9 );

     With DmSecuenciaAsignacionTable do
       begin
       First;
       While not Eof do
          begin

          With DmSecuenciaAsignacionFields do
            begin

            SessionDataModule.SendNotification( ntRecord, Format( RsMsg8, [ Ejercicio.Value, NroOrdenFabricacion.Value, NroProceso.Value, StrFormatDate( Fecha.Value, dfDefault ), Turno.Value ] ) );

            RealmenteRealizado := DmInformeFabricacionTable.FindKey( [ Ejercicio.Value, NroOrdenFabricacion.Value, NroProceso.Value, Fecha.Value, Turno.Value ] );
            If   Realizado.Value<>RealmenteRealizado
            then try
                   Edit;
                   Realizado.Value := RealmenteRealizado;
                   Post;
                 except
                   Cancel;
                   raise;
                   end;

            end;

          Next;
          end;

       end;

end;

begin

     SessionDataModule.SendNotification( ntInformation, RsMsg3 );

     // Borro el fichero de stocks de fabricacion

     try

       SessionDataModule.Dm70.ContenedorModule.LimpiaEjercicio( SessionDataModule.Ejercicio );

       RepasaSecuenciaAsignacion;
       ProcesaOrdenes;
       ProcesaInformes;
       ProcesaNotificaciones;

       SessionDataModule.SendNotification( ntInformation, RsMsg6 );
     except
       SessionDataModule.SendNotification( ntError, RsMsg1 );
       end;

end;

{ TReconstruccionDatosInternosService }

procedure TReconstruccionDatosInternosService.AssignSession( const SessionID : Integer );
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

procedure TReconstruccionDatosInternosService.Reconstruccion;
begin
     SessionDataModule.Dm70.ReconstruccionDatosInternosModule.Reconstruccion;
end;

var ReconstruccionDatosInternosControl : InxClassFactoryControl;

initialization
   TnxClassFactory.RegisterClass( CLSID_ReconstruccionDatosInternosService, TReconstruccionDatosInternosService, ReconstruccionDatosInternosControl );

end.





