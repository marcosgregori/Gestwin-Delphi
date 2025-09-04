
unit dm_cde;

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

  dmi_cde;

type
    TConsolidacionEmpresasService = class( TSessionModule, IConsolidacionEmpresasService )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    public

    procedure EjecutaProceso( Ce1, Ce2, Ce3, Ce4, Ce5, Ce6 : String );

    end;

  TConsolidacionEmpresasModule = class(TServerDataModule)
    SaldosOrigenTable: TnxeTable;
    CuentaOrigenTable: TnxeTable;
    SaldosDestinoTable: TnxeTable;
    CuentaDestinoTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
  private

    SaldosOrigenFields,
    SaldosDestinoFields : TSaldosFields;

    CuentaOrigenFields,
    CuentaDestinoFields : TCuentaFields;

    SaveEmpresaBuffer  : PChar;
    CodigosEmpresasOrigen : array[ 1..6 ] of TWideStringField;


  public

    procedure EjecutaProceso( Ce1, Ce2, Ce3, Ce4, Ce5, Ce6 : String );
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

     dmi_sal,

     dm_sub,
     dm_ast,
     dm_sal;

{$R *.DFM}

resourceString
    RsMsg3   = 'Limpiando los saldos de la Empresa destino (activa)';
    RsMsg4   = 'Procesando la Empresa %s, %s.';
    RsMsg5   = 'Consolidación realizada.';
    RsMsg6   = 'Puede consultar el resultado de la misma mediante los informes de la Empresa activa.';
    RsMsg7   = 'No puede incluir la Empresa activa en la lista de Empresas a consolidar.';
    RsMsg8   = 'Esta Empresa ya ha sido eincluido en la lista.';
    RsMsg9   = 'El directorio [%s] con los datos de la Empresa %s, no existe.';
    RsMsg10  = 'Debe introducir, al menos, 2 Empresas origen.';
    RsMsg11  = 'El proceso se ha interrumpido.'#13'Identifique el problema y reintente la operación.'#13'Los saldos de la Empresa destino (actual) no son válidos.';

var ConsolidacionEmpresasControl : InxClassFactoryControl;

procedure TConsolidacionEmpresasModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm10.ConsolidacionEmpresasModule := nil;
end;

procedure TConsolidacionEmpresasModule.ServerDataModuleCreate(Sender: TObject);
begin
     CuentaDestinoTable.Open;
     SaldosDestinoTable.Open;

     SaldosDestinoFields := TSaldosFields.Create( SaldosDestinoTable );
     CuentaDestinoFields := TCuentaFields.Create( CuentaDestinoTable );
end;

{ TConsolidacionEmpresasService }

procedure TConsolidacionEmpresasService.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

procedure TConsolidacionEmpresasService.EjecutaProceso( Ce1, Ce2, Ce3, Ce4, Ce5, Ce6 : String );
begin
     SessionDataModule.Dm10.ConsolidacionEmpresasModule.EjecutaProceso( Ce1, Ce2, Ce3, Ce4, Ce5, Ce6 );
end;

procedure TConsolidacionEmpresasModule.EjecutaProceso( Ce1, Ce2, Ce3, Ce4, Ce5, Ce6 : String );

var  Index,
     Inx : SmallInt;
     ProcesoCancelado : Boolean;
     CodigoUsuario,
     CodigoEmpresa : String;
     Fecha : TDate;
     CodigosEmpresasOrigen : array[ 1..6 ] of String;

begin

     try

       try

         ProcesoCancelado := False;

         CodigoUsuario := SessionDataModule.CodigoUsuario;
         CodigoEmpresa := SessionDataModule.CodigoEmpresa;
         Fecha := SessionDataModule.FechaHoy;

         SessionDataModule.SendNotification( ntInformation, RsMsg3 );

         With SaldosDestinoTable do
           begin
           SetRange( [ SessionDataModule.Ejercicio, '', '' ], [ SessionDataModule.Ejercicio, HighStrCode, HighStrCode ] );
           First;
           While not Eof do
             begin
             Edit;
             For Index := 0 to 14 do
               begin
               SaldosDestinoFields.Mes[ Index, 1 ].Value := 0.0;
               SaldosDestinoFields.Mes[ Index, 2 ].Value := 0.0;
               end;
             Post;
             Next;
             end;
           end;

         CodigosEmpresasOrigen[ 1 ] := Ce1;
         CodigosEmpresasOrigen[ 2 ] := Ce2;
         CodigosEmpresasOrigen[ 3 ] := Ce3;
         CodigosEmpresasOrigen[ 4 ] := Ce4;
         CodigosEmpresasOrigen[ 5 ] := Ce5;
         CodigosEmpresasOrigen[ 6 ] := Ce6;

         CuentaOrigenTable.Database := EnterpriseDataModule.AuxDatabase;
         SaldosOrigenTable.Database := EnterpriseDataModule.AuxDatabase;

         For Index := 1 to 6 do
           If   not ValueIsEmpty( CodigosEmpresasOrigen[ Index ] )
           then begin

                try

                  // El sistema no tiene en cuenta si los ficheros de la Empresa origen están configurados
                  // como locales/remotos y con localización individual por fichero. El acceso es idéntico para
                  // todos los ficheros

                  CuentaOrigenTable.Close;
                  SaldosOrigenTable.Close;

                  EnterpriseDataModule.AuxDatabase.Close;

                  If   SessionDataModule.Dm00.EmpresaTable.FindKey( [ CodigosEmpresasOrigen[ Index ] ] )
                  then begin

                       With SessionDataModule.Dm00.DmEmpresaFields do
                         EnterpriseDataModule.OpenAuxDatabase( Codigo.Value, DataPath.Value );

                       CuentaOrigenTable.Open;
                       SaldosOrigenTable.Open;

                       SaldosOrigenFields := TSaldosFields.Create( SaldosOrigenTable );
                       CuentaOrigenFields := TCuentaFields.Create( CuentaOrigenTable );

                       With SessionDataModule.Dm00.DmEmpresaFields do
                         ProcesoCancelado := SessionDataModule.SendNotification( ntInformation, Format( RsMsg4, [ Codigo.Value, Nombre.Value ] ) );

                       With SaldosOrigenTable do
                         begin
                         SetRange( [ SessionDataModule.Ejercicio, '', '' ], [ SessionDataModule.Ejercicio, HighStrCode, HighStrCode ] );
                         First;
                         While not Eof do
                           begin
                           If   Length( TrimRight( SaldosOrigenFields.Codigo.Value ) )<>9   { Es un nivel superior }
                           then begin

                                With CuentaOrigenTable do
                                  If   FindKey( [ SaldosOrigenFields.Codigo.Value ] )
                                  then With CuentaDestinoTable do
                                         If   not Findkey( [ SaldosOrigenFields.Codigo.Value ] )
                                         then try
                                                Append;
                                                CopyFields( CuentaOrigenTable );
                                                Post;
                                              except
                                                Cancel;
                                                raise;
                                                end;

                                With SaldosDestinoTable do
                                  try
                                    If   not Findkey( [ SaldosOrigenFields.Ejercicio.Value, SaldosOrigenFields.Codigo.Value, SaldosOrigenFields.CentroCoste.Value ] )
                                    then begin
                                         Append;
                                         CopyFields( SaldosOrigenTable );
                                         Post;
                                         end
                                    else begin
                                         Edit;
                                         For Inx := 0 to 14 do
                                           begin
                                           SaldosDestinoFields.Mes[ Inx, 1 ].Value := SaldosDestinoFields.Mes[ Inx, 1 ].Value + SaldosOrigenFields.Mes[ Inx, 1 ].Value;
                                           SaldosDestinoFields.Mes[ Inx, 2 ].Value := SaldosDestinoFields.Mes[ Inx, 2 ].Value + SaldosOrigenFields.Mes[ Inx, 2 ].Value;
                                           end;
                                         Post;
                                         end;
                                  except
                                    Cancel;
                                    raise;
                                    end;

                                end;

                           Next;
                           end;
                         end;
                       end;

                finally
                  CuentaOrigenTable.Close;
                  SaldosOrigenTable.Close;
                  end;

                end;

         SessionDataModule.SendNotification( ntInformation, RsMsg5 );
         SessionDataModule.SendNotification( ntInformation, RsMsg6 );

         except on E : Exception do
           SessionDataModule.SendNotification( ntError, RsMsg11 );
         end;

       finally
         EnterpriseDataModule.AuxDatabase.Close;
         SessionDataModule.AsignaParametrosTrabajo( CodigoUsuario, CodigoEmpresa, Fecha )
         end;

end;

initialization
    TnxClassFactory.RegisterClass( CLSID_ConsolidacionEmpresasService, TConsolidacionEmpresasService, ConsolidacionEmpresasControl );

end.
