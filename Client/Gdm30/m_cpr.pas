unit m_cpr;

interface

uses
  SysUtils, Classes,

  DataManager,
  AppContainer,
  DB,
  nxDB,

  Gim30Fields,
  SQLSet,
  QueryGrid,

  dmi_sto;

type
  TCprQueryModule = class(TPersistentQueryModule)
    SQLSet: TgxSQLSet;
    procedure PersistentQueryModuleUpdate(Sender: TObject);
    procedure PersistentQueryModuleInitialize(Sender: TObject);
  private

  protected

  public
      CarteraArticulosFields : TCarteraArticulosFields;
      SQLText : String;

      Desglosar,
      FechaEntrega : Boolean;
      Agrupacion : SmallInt;

  end;

function VistaPendienteRecibir( ParamsDataset : TgxMemData ) : TCprQueryModule;

implementation

uses  LibUtils,
      ReportManager,

      dm_sto;

{$R *.dfm}

function VistaPendienteRecibir( ParamsDataset : TgxMemData ) : TCprQueryModule;

var  CprQueryModule : TCprQueryModule;

begin
     CprQueryModule := nil;
     CreatePersistentQueryModule( TCprQueryModule, CprQueryModule, ParamsDataset );
     Result := CprQueryModule;
end;

procedure TCprQueryModule.PersistentQueryModuleInitialize(Sender: TObject);
begin

     Desglosar := ParamValues[ 'Desglosar' ];
     Agrupacion := ParamValues[ 'Agrupacion' ];
     FechaEntrega := ParamValues[ 'FechaEntrega' ];

     If   Desglosar
     then begin
          SQLText := SQLSet.GetSQLText( 'Detalle' );
          case Agrupacion of
             0 : StrAdd( SQLText, SQLSet.GetSQLText( 'Detalle_OrdenPropietario' ) );
             1 : StrAdd( SQLText, SQLSet.GetSQLText( 'Detalle_OrdenArticulo' ) );
             end;
          end
     else SQLText := SQLSet.GetSQLText( 'AcumuladoArticulo' );

     If   FechaEntrega
     then SQLText := StringReplace( SQLText, '<Fecha>', 'LineaMovimiento.FechaAplicacion', [] )
     else SQLText := StringReplace( SQLText, '<Fecha>', 'LineaMovimiento.Fecha', [] );

     SetSQLVars( SQLText, Params );

end;

procedure TCprQueryModule.PersistentQueryModuleUpdate(Sender: TObject);

var  ExistenciasArticulo : IExistenciasArticulo;

begin

     CreateQueryTable( 'CarteraArticulos', SQLText, [], QueryTable );

     If   Assigned( QueryTable )
     then With QueryTable do
            begin

            Open;

            CarteraArticulosFields := TCarteraArticulosFields.Create( QueryTable );

            If   not Desglosar
            then try

                    ApplicationContainer.StartProgression( RecordCount );

                    First;
                    While not Eof do
                      begin

                      Edit;

                      ExistenciasArticulo := StockAlmacen.ObtenStock( CarteraArticulosFields.CodigoArticulo.Value,
                                                                      False,
                                                                      CarteraArticulosFields.CodigoClaseA.Value,
                                                                      CarteraArticulosFields.CodigoClaseB.Value,
                                                                      CarteraArticulosFields.CodigoClaseC.Value,
                                                                      True,
                                                                      '',
                                                                      False,
                                                                      CarteraArticulosFields.CodigoAlmacen.Value,
                                                                      True,
                                                                      '',
                                                                      False,
                                                                      ApplicationContainer.Ejercicio,
                                                                      0,
                                                                      ApplicationContainer.NroMesFinal );

                      With ExistenciasArticulo.SumaExistencias do
                        begin
                        CarteraArticulosFields.Existencias.Value := Saldo;
                        CarteraArticulosFields.ExistenciasVirtuales.Value := PendienteRecibir + Saldo - PendienteServir;
                        end;

                      Post;

                      ApplicationContainer.ShowProgression;

                      Next;
                      end;

                  finally
                    ApplicationContainer.EndProgression;
                    end;

       end;

end;

end.
