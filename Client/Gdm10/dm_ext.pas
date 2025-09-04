
unit dm_ext;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,

  AppContainer,
  AppForms,
  DB,
  nxdb,
  DataManager,
  EnterpriseDataAccess,
  ReportManager,

  Gim00Fields,
  Gim10Fields;

type  TParametrosExtracto = record
        CodigoInicial,
        CodigoFinal           : String;
        SeleccionCentroCoste  : SmallInt;   // 0 = Todos
        CtroCoste             : String;
        FechaInicial,
        FechaFinal            : TDateTime;
        TipoFormato           : SmallInt;
        MostrarPunteo         : Boolean;
        Punteo                : SmallInt;  // 0 = Todos, 1 = Punteados, 2 = Pendientes
        NoArrastrarSumas,
        SoloConSaldo,
        DirectoImpresora      : Boolean;
        end;

  TExtractoModule = class(TDataModule)
    DmApunteQuery: TnxeQuery;
    procedure DataModuleDestroy(Sender: TObject);

  private

    CabeceraExtractoTable,
    LineaExtractoTable : TnxeTable;

    CabeceraExtractoFields : TCabeceraExtractoFields;
    LineaExtractoFields : TLineaExtractoFields;
    DmApunteFields : TApunteFields;

  public
    ParametrosExtracto : TParametrosExtracto;

    procedure ImprimeExtracto( Report : TgxReportManager; var ParametrosExtracto : TParametrosExtracto );
  end;

var  ExtractoModule: TExtractoModule = nil;

function Extracto : TExtractoModule;

implementation

uses LibUtils,
     AppManager,

     Gdm00Dm,
     Gdm10Dm,

     dmi_sal,

     dm_sal,
     dm_sub,
     dm_cco;


{$R *.DFM}

resourceString
     RsMsg1  = 'Extractos de subcuentas';

function Extracto : TExtractoModule;
begin
     CreateDataModule( TExtractoModule, ExtractoModule );
     Result := ExtractoModule;
end;

procedure TExtractoModule.ImprimeExtracto(     Report             : TgxReportManager;
                                           var ParametrosExtracto : TParametrosExtracto );

procedure SeleccionaRegistros;

var   SubcuentaActual : String;
      SaldoSubcuenta : Decimal;
	  Incluir : Boolean;
      SumasySaldos : ISumasySaldos;

function ApunteValido : Boolean;
begin
     With ParametrosExtracto do
       Result := ( ( SeleccionCentroCoste=0 ) or ( CtroCoste=DmApunteFields.CentroCoste.Value ) ) and
                 ( ( Punteo=0 ) or ( ( Punteo=1 ) and DmApunteFields.Punteo.Value ) or ( ( Punteo=2 ) and not DmApunteFields.Punteo.Value ) );
end;

begin

     With ParametrosExtracto, DmApunteQuery do
       try

         CabeceraExtractoTable.BeginBatchAppend( 5 * 1024 * 1024 );
         LineaExtractoTable.BeginBatchAppend( 15 * 1024 * 1024 );

         SubcuentaActual := '';

         Close;
         SQL.Text := SQLVarsFormat( 'SELECT * From Apunte WHERE ( Subcuenta BETWEEN ? AND ? ) AND ( Fecha BETWEEN ? AND ? ) ORDER BY Subcuenta, Fecha',
                                    [ CodigoInicial, CodigoFinal, FechaInicial, FechaFinal ] );
         Open;
         DmApunteFields := TApunteFields.Create( DmApunteQuery );

         ApplicationContainer.StartProgression( RecordCount );

         First;
         While not Eof  do
           begin

           If   ApunteValido
           then begin

                SubcuentaActual := DmApunteFields.Subcuenta.Value;

                {
                With DmApunteFields do
                  SumasySaldos := Saldos.SaldoFecha( Subcuenta.Value, CentroCoste.Value, SeleccionCentroCoste=0, Fecha.Value, NroAsiento.Value, NroApunte.Value, False );

                }

                If   SoloConSaldo
                then With DmApunteFields do
                       Incluir := Saldos.SaldoFecha( Subcuenta.Value, CentroCoste.Value, SeleccionCentroCoste=0, FechaFinal, MaxLongint, MaxSmallint, True ).Saldo<>0.0
                else Incluir := True;

                If   Incluir
                then begin

                     If   NoArrastrarSumas
                     then SaldoSubcuenta := 0.0
                     else With DmApunteFields do
                            begin
                            SumasySaldos := Saldos.SaldoFecha( Subcuenta.Value, CentroCoste.Value, SeleccionCentroCoste=0, Fecha.Value, NroAsiento.Value, NroApunte.Value, False );
                            SaldoSubcuenta := SumasySaldos.Saldo;
                            end;

                     With CabeceraExtractoFields do
                       begin

                       CabeceraExtractoTable.Append;

                       Subcuenta.Value := SubcuentaActual;
                       CentroCoste.Value := DmApunteFields.CentroCoste.Value;

                       If   not NoArrastrarSumas
                       then begin
                            Debe.Value := SumasySaldos.SumaDebe;
                            Haber.Value := SumasySaldos.SumaHaber;
                            Saldo.Value := SaldoSubcuenta;
                            end;

                       DescripcionSubcuenta.Value := Cuenta.Descripcion( DmApunteFields.Subcuenta.Value, True, False );
                       If   DmApunteFields.CentroCoste.Value<>''
                       then DescripcionCentroCoste.Value := dm_cco.CentroCoste.Descripcion( DmApunteFields.CentroCoste.Value, True );

                       CabeceraExtractoTable.Post;
                       end;

                     While not Eof and ( SubcuentaActual=DmApunteFields.Subcuenta.Value ) do
                       begin

                       If   ApunteValido
                       then With LineaExtractoFields do
                              begin

                              LineaExtractoTable.Append;

                              Subcuenta.Value := SubcuentaActual;
                              CentroCoste.Value := DmApunteFields.CentroCoste.Value;
                              Contrapartida.Value := DmApunteFields.contrapartida.Value;
                              Fecha.Value := DmApunteFields.Fecha.Value;
                              Ejercicio.Value := DmApunteFields.Ejercicio.Value;
                              NroAsiento.Value := DmApunteFields.NroAsiento.Value;
                              NroApunte.Value := DmApunteFields.NroApunte.Value;

                              DescripcionContrapartida.Value  := Cuenta.Descripcion( DmApunteFields.Contrapartida.Value, True, False );
                              Concepto.Value := DmApunteFields.Concepto.Value;

                              Debe.Value := DmApunteFields.Debe.Value;
                              Haber.Value := DmApunteFields.Haber.Value;

                              DecAdd ( SaldoSubcuenta, DmApunteFields.Debe.Value - DmApunteFields.Haber.Value );

                              Saldo.Value := SaldoSubcuenta;

                              LineaExtractoTable.Post;
                              end;

                       ApplicationContainer.ShowProgression;
                       Next;
                       end;

                     end
                else begin
                     ApplicationContainer.ShowProgression;
                     Next;
                     end;

                end
           else begin
                ApplicationContainer.ShowProgression;
                Next;
                end;

           end;

       finally
         Close;

         LineaExtractoTable.EndBatchAppend;
         CabeceraExtractoTable.EndBatchAppend;

         end;

     ApplicationContainer.EndProgression;

end;

begin
     With Report do
       try

         Load;

         ToPrinter := ParametrosExtracto.DirectoImpresora;
         Title := RsMsg1;

         CabeceraExtractoTable := CreateEmptyTable( 'Cabecera', DataModule10.GetSQL( 'CabeceraExtracto' ) );
         CabeceraExtractoFields := TCabeceraExtractoFields.Create( CabeceraExtractoTable );

         LineaExtractoTable := CreateEmptyTable( 'Lineas', DataModule10.GetSQL( 'LineasExtracto' ) );
         LineaExtractoFields := TLineaExtractoFields.Create( LineaExtractoTable );

         SeleccionaRegistros;

         SetValue( RsCentrosCoste, DataModule00.DmEmpresaFields.Contable_CtrosCoste.Value );

         With ParametrosExtracto do
           begin
           SetValue( RsCodigoInicial, CodigoInicial );
           SetValue( RsCodigoFinal, CodigoFinal );
           SetValue( RsSeleccionCentroCoste, SeleccionCentroCoste );
           SetValue( RsCentroCoste, CtroCoste );
           SetValue( RsTipoFormato, TipoFormato );
           SetValue( RsNoArrastrarSumas, NoArrastrarSumas );
           SetValue( RsFechaInicial, FechaInicial );
           SetValue( RsFechaFinal, FechaFinal );
           SetValue( RsPunteo, Punteo );
           end;

         Start;

         Detach;   // Para que no sea suprimido si el usuario genera otro informe

       except on E : Exception do
         Cancel( E );
         end;
end;


procedure TExtractoModule.DataModuleDestroy( Sender: TObject );
begin
     ExtractoModule := nil;
end;

end.

