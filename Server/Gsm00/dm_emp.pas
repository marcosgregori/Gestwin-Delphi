unit dm_emp;

interface

uses
  Windows, Messages, SysUtils, Classes,

  DB,
  nxdb,
  DataManager,
  ServerDataModule,

  Gim00Fields;


type
  TEmpresaModule = class(TServerDataModule)
    DmEmpresaTable: TnxeTable;
    DmFicherosTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
  private

  public

    DmEmpresaFields  : TEmpresaFields;

    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean ) : String;
    function  Obten( Codigo : String; EmpresaFields : TEmpresaFields = nil ) : Boolean;

    procedure InicializaRegistroEmpresa(EmpresaFields: TEmpresaFields; SoloDatosPlanificador : Boolean = False );

    {
    procedure ActualizaFicherosRemotos;
    procedure CompruebaFicherosRemotos;
    }
  end;

resourceString

     RsMsg1   = 'Copia de ficheros remotos';
     RsMsg2   = 'Ficheros :';
     RsMsg3   = 'El fichero [%s] no ha podido ser copiado porque esta siendo utilizado por otro usuario.';
     RsMsg4   = 'Asegúrese de que ningún usuario utiliza el fichero y reintente el proceso.';
     RsMsg5   = 'El fichero [%s] no existe en su localización remota. Se conservará la copia local del mismo.';
     RsMsg6   = 'No está definida la localización remota de los ficheros.';
     RsMsg7   = 'El path remoto a los datos se fija en la ventana ''Localización de los ficheros de datos''.'#13'Debe indicar el camino completo a los datos remotos y éste no debe coincidir con la localización local de los mismos.';
     RsMsg8   = 'Actualización de ficheros remotos.';
     RsMsg9   = '¿Desea actualizar los ficheros remotos de la Empresa?';
     RsMsg10  = 'Esta Empresa utiliza ficheros que se copian desde una ubicacion alternativa.'#13'Si no desea actualizar ahora esos ficheros, puede trabajar con la copia existente, que es la última que utilizó.';

     RsMsgPGC1 = '¿Esta seguro de que desea actualizar la contabilidad de esta Empresa al PGC 2008?';
     RsMsgPGC2 = 'El proceso de actualización es irreversible.'#13'Es aconsejable que haga copias de seguridad de sus datos antes de realizarlo.';
     RsMsgPGC3 = 'MUY IMPORTANTE : antes de realizar el proceso de adaptación debe asegurarse de que dispone de una versión actualizada de GESTWIN. Utilice el programa de ''''Actualización en línea'''' para comprobarlo.';

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses Files,
     LibUtils,
     AppManager,

     SessionData,

     dm_pai,
     dm_cnd;

{$R *.dfm}

procedure TEmpresaModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmEmpresaFields := TEmpresaFields.Create( DmEmpresaTable );
end;

procedure TEmpresaModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm00.EmpresaModule := nil;
end;

function  TEmpresaModule.Obten( Codigo        : String;
                                EmpresaFields : TEmpresaFields = nil ) : Boolean;
begin
     Result := DmEmpresaTable.FindKey( [ Codigo ] );
     If   Assigned( EmpresaFields )
     then EmpresaFields.Update( DmEmpresaTable );
end;

function TEmpresaModule.Descripcion( Codigo : String; NotificaSiNoExiste : Boolean ) : String;
begin
     Result := '';
     If   DmEmpresaTable.FindKey( [ Codigo ] )
     then Result := DmEmpresaFields.Nombre.Value
     else If   NotificaSiNoExiste
          then Result := RsRegistroInexistente;
end;

{
procedure TEmpresaModule.CompruebaFicherosRemotos;
begin
     If   SessionDataModule.EmpresaFields.ComprobarDatosRemotos.Value
     then If   not SessionDataModule.SendNotification( ntQuestionWarning, RsMsg9, RsMsg10 )
          then ActualizaFicherosRemotos;
end;

procedure TEmpresaModule.ActualizaFicherosRemotos;

var  TableIndex : SmallInt;
     FileName,
     LocalFileName,
     RemoteFileName : string;
     TableNames : TStrings;
     FicherosFields : TFicherosFields;

begin
     With SessionDataModule do
       If   ( EmpresaFields.RemoteDataPath.Value='' ) or ( EmpresaFields.DataPath.Value=EmpresaFields.RemoteDataPath.Value )
       then SendNotification( ntStop, RsMsg6, RsMsg7 )
       else begin
            // CompruebaAccesoLocal;
            try

              SendNotification( ntInformation, RsMsg2 );

              With DmFicherosTable do
                begin

                Open;
                FicherosFields := TFicherosFields.Create( DmFicherosTable );
                TableNames := TStringList.Create;

                try

                  SessionDataModule.GetTableNames( TableNames );

                  With TableNames do
                      For TableIndex := TableNames.Count - 1 downto 0 do
                        begin
                        FileName := Strings[ TableIndex ];
                        If   FindKey( [ SessionDataModule.CodigoEmpresa, FileName ] )
                        then If   FicherosFields.Localizacion.Value=1   // Actualización remota
                             then begin

                                  RemoteFileName := AddPathDelim( EnterpriseDataModule.UserRemoteDataPath ) + FileName + '.nx1';
                                  LocalFileName := AddPathDelim( EnterpriseDataModule.UserDataPath ) + FileName + '.nx1';

                                  If   SendNotification( ntRecord, RemoteFileName + #13 + FileName )  // Canceled
                                  then Abort;

                                  If   FileExists( RemoteFileName )
                                  then begin
                                       If   IsFileAccesible( RemoteFileName )
                                       then try
                                              CopyFile( RemoteFileName, LocalFileName );
                                              SendNotification( ntInformation, FileName );
                                            except
                                              end
                                       else begin
                                            SendNotification( ntError, Format( RsMsg3, [ RemoteFileName ] ) );
                                            SendNotification( ntError, RsMsg4 );
                                            Abort;
                                            end;
                                       end
                                  else SendNotification( ntWarning, Format( RsMsg5, [ RemoteFileName ] ) );

                                  end;
                        end;

                finally
                  TableNames.Free;
                  Close;
                  end;
                end;

            except on E : Exception do
              SessionDataModule.SendNotification( ntError, ExceptionMessage( E ) );
              end;

            end;
end;

}

procedure TEmpresaModule.InicializaRegistroEmpresa( EmpresaFields         : TEmpresaFields;
                                                    SoloDatosPlanificador : Boolean = False );
begin
     With EmpresaFields do
       begin

       If   not SoloDatosPlanificador
       then begin
            CodigoPais.Value := CodigoEspaña;
            Contable_MesInicial.Value := 1;

            Stock_AltasFabric.Value := True;

            Compras_DecPrecio.Value := DecimalesMoneda;
            Compras_Cantidades.Value := 0;
            Compras_Calculo.Value := 0;

            Ventas_DecPrecio.Value := DecimalesMoneda;
            Ventas_DecRecargo.Value := DecimalesMoneda;
            Ventas_Cantidades.Value := 0;
            Ventas_Calculo.Value := 0;
            Ventas_PreAutoVenta.Value := 0;
            end;

       If   InicioJornadaLaboral.Value=0
       then InicioJornadaLaboral.Value := EncodeTime( 9, 0, 0, 0 );
       If   FinJornadaLaboral.Value=0
       then FinJornadaLaboral.Value := EncodeTime( 20, 0, 0, 0 );
       If   DiasLaborables.Value=0
       then DiasLaborables.Value := 31;  // Se guarda como bits activos o inactivos dentro de un integer (Lunes a Domingo)
       end;
end;

end.
