
unit l_cpn;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  LibUtils,
  DataManager,
  ReportManager,

  Mask,
  ComCtrls,

  dm_sal, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxSpinEdit, cxDBEdit,
  dxmdaset, cxGraphics, cxDropDownEdit, cxIndexedComboBox, cxCheckBox,

  Gim00Fields,
  Gim10Fields, dxSkinsCore, dxSkinsDefaultPainters, cxLookAndFeels, cxLabel,
  cxGroupBox, AppContainer;

const NroMaximoColumnas = 14;
      NroMaximoFilas = 30;

type
    TTipoOperacionSaldo = ( osSaldoDeudor, osSaldoAcreedor, osSumaDebe, osSumaHaber );
    TTipoPeriodoSaldo = ( psApertura, psEjercicio, psRegularizacion, psCierre );

    TTituloArray = array[ 1..15 ] of TWideStringField;
    TValorArray = array[ 1..15 ] of TBCDField;

    TEstadoCambiosFields = class( TnxeDatasetFields)
     public
       Nivel : TSmallIntField;
       Titulo : TTituloArray;
       Valor : TValorArray;       
     end;

    TRptCpnForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    Data: TgxMemData;
    DataSource: TDataSource;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure FormManagerOkButton;
    procedure ReportBeforeStart;
    private
    procedure SeleccionaRegistros;

    public

      EstadoCambiosTable : TnxeTable;
      EstadoCambiosFields : TEstadoCambiosFields;

      SaldosFields : TSaldosFields;

      Fichero : Text;
      FicheroAbierto : Boolean;

      Linea : String;
      VariableList : TStringList;

      TituloColumna : array[ 0..NroMaximoColumnas ] of String;
      TituloFila : array[ 0..NroMaximoFilas ] of String;
      CasillaFila : array[ 0..NroMaximoFilas ] of String;
      EjercicioFila : array[ 0..NroMaximoFilas ] of SmallInt;
      PeriodoFila : array[ 0..NroMaximoFilas ] of Char;
      NivelFila : array[ 0..NroMaximoFilas ] of SmallInt;
      OperacionCelda : array[ 0..NroMaximoFilas, 0..NroMaximoColumnas ] of String;
      ValorCelda : array[ 0..NroMaximoFilas, 0..NroMaximoColumnas ] of Decimal;

      end;

var  RptCpnForm : TRptCpnForm = nil;

procedure EstadoCambiosPatrimonio;


implementation

uses   Files,
       DateUtils,
       AppManager,
       EnterpriseDataAccess,

       dmi_sal,

       dm_pga,
       dm_ast,

       b_msg;

{$R *.DFM}

resourceString
       RsMsg1  = 'No consigo abrir el fichero de configuracion.';
       RsMsg2  = 'Por algún motivo el fichero [%s] no es accesible. Revise su instalación';
       RsMsg3  = 'ESTADO DE CAMBIOS EN EL PATRIMONIO NETO';
       RsMsg4  = 'La cabecera del fichero de configuracion es incorrecta.';
       RsMsg5  = 'Si ha modificado el fichero CPN_2008.RCF, reviselo.';

procedure EstadoCambiosPatrimonio;
begin
     CreateReportForm( TRptCpnForm, RptCpnForm );
end;

// TRptCpnForm

procedure TRptCpnForm.SeleccionaRegistros;

Var  DocumentoList,
     LineaList,
     CuentasList,
     OperacionList : TStringList;
     CabeceraPendiente,
     IncluyeTotales : Boolean;
     NroColumnas,
     NroFilas,
     NroColumna,
     NroFila,
     NroFilaOperacion,
     NroOperacion,
     UltimoNroColumna,
     I, IOp, R : SmallInt;
     Paso,
     Periodo,
     Nivel,
     Pe,
     EjercicioOperacion,
     PeriodoInicial,
     PeriodoFinal : SmallInt;
     Operacion,
     OperacionFila,
     NombreVariable,
     TextoTitulo : String;
     EjercicioMostrado,
     EjercicioCalculo : SmallInt;
     TipoOperacionSaldo : TTipoOperacionSaldo;
     TipoPeriodoSaldo : TTipoPeriodoSaldo;
     TextoCuenta : String;
     CalculoSaldo : Char;
     SumaDebe,
     SumaHaber,
     SaldoOperacion : Decimal;
     SumasySaldos : ISumasySaldos;

procedure InsertaRegistro( Nivel   : SmallInt;
                           Titulos : array of String;
                           Valores : array of Decimal );

var  Index : SmallInt;
     StrValue : String;

begin

       EstadoCambiosTable.Append;

       EstadoCambiosFields.Nivel.Value := Nivel;

       For Index := 0 to High( Titulos ) do
         EstadoCambiosFields.Titulo[ Index + 1 ].Value := Titulos[ Index ];

       For Index := 0 to High( Valores ) do
         EstadoCambiosFields.Valor[ Index + 1 ].Value := Valores[ Index ];

       EstadoCambiosTable.Post;

       ApplicationContainer.ShowProgression;

end;

procedure AbreficheroConfiguracion;

Var Nombrefichero,
    Path : String;

begin

     Nombrefichero := 'CPN_2008.RCF';

     Path := ReportManagerDataModule.GetReportLocation( Nombrefichero, CodigoEmpresaActual, dtReportSchema );

     AssignFile( Fichero, Path );
     Reset( Fichero );
     If   IOResult<>0
     then begin
          ShowNotification( ntError, RsMsg1, Format( RsMsg2, [ Path ] ) );
          Abort;
          end;

     ReadLine( Fichero, Linea );
     If   Linea<>RsMsg3
     then begin
          CloseFile( Fichero );
          ShowNotification( ntError, RsMsg4, RsMsg5 );
          Abort;
          end;

     FicheroAbierto := True;
end;

begin
     try
       ApplicationContainer.StartProgression;

       AbreficheroConfiguracion;

       CabeceraPendiente := True;

       // Limpiando los arrays (se puede cancelar el listado y volver a emitir)

       FillChar( TituloColumna, SizeOf( TituloColumna ), #0 );
       FillChar( TituloFila, SizeOf( TituloFila ), #0 );
       FillChar( EjercicioFila, SizeOf( EjercicioFila ), #0 );
       FillChar( PeriodoFila, SizeOf( PeriodoFila ), #0 );
       FillChar( NivelFila, SizeOf( NivelFila ), #0 );
       FillChar( OperacionCelda, SizeOf( OperacionCelda ), #0 );
       FillChar( ValorCelda, SizeOf( ValorCelda ), #0 );

       try

         OperacionList := TStringList.Create;
         ReadLine( Fichero, Linea );
         Linea := TrimRight( Linea );
         NroColumnas := 0;
         NroFila := 0;
         IncluyeTotales := False;

         // Primero relleno los arrays

         While not Eof( Fichero ) do
           begin

           If   ( Linea<>'' ) and ( Copy( Linea, 1, 1 )<>';' ) //  Es un comentario
           then begin
                LineaList := TStringList.Create;
                ExtractStringList( Linea, LineaList, True, '|' );
                If    LineaList.Count>4
                then If   CabeceraPendiente
                     then begin
                          NroColumnas := LineaList.Count;
                          For I := 0 to NroColumnas - 1 do
                            TituloColumna[ I ] := Trim( LineaList.Strings[ I ] );
                          If   NroColumnas<NroMaximoColumnas
                          then begin
                               TituloColumna[ NroColumnas ] := 'Total';
                               IncluyeTotales := True;
                               Inc( NroColumnas );
                               end;
                          CabeceraPendiente := False;
                          end
                     else begin

                          // La columna 0 contiene el número de línea, solo útil para el usuario que quiera modificar el formato

                          EjercicioFila[ NroFila ] := StrToInt( Trim( LineaList.Strings[ 1 ] ) );
                          PeriodoFila[ NroFila ] := StrToChar( Trim( LineaList.Strings[ 2 ] ) );
                          NivelFila[ NroFila ] := StrToInt( Trim( LineaList.Strings[ 3 ] ) );
                          CasillaFila[ NroFila ] := Trim( LineaList.Strings[ 4 ] );
                          TituloFila[ NroFila ] := Trim( LineaList.Strings[ 5 ] );
                          If   LineaList.Count=7   // Es una línea de calculo único
                          then begin
                               OperacionFila := Trim( LineaList.Strings[ 6 ] );
                               For I := 0 to NroColumnas - 1 do
                                 OperacionCelda[ NroFila, I ] := OperacionFila;
                               end
                          else For I := 6 to LineaList.Count - 1 do
                                 OperacionCelda[ NroFila, I - 6 ] := Trim( LineaList.Strings[ I ] );
                          Inc( NroFila );
                          end;

                end;
           ReadLine( Fichero, Linea );
           ApplicationContainer.ShowProgression;
           end;

         NroFilas := NroFila;
         UltimoNroColumna := NroColumnas - 1;
         If   IncluyeTotales
         then Dec( UltimoNroColumna );

         // y, luego, "culculo" el contenido bien "culculao"

         For Paso := 1 to 2 do
           For NroFila := 0 to NroFilas - 1 do
             begin
             If   Paso=2  // La segunda pasada, el momento de las operaciones entre celdas
             then begin
                  For NroColumna := 0 to UltimoNroColumna do
                    begin
                    Operacion := OperacionCelda[ NroFila, NroColumna ];
                    If   Copy( Operacion, 1, 1 )='='   // El indicativo de que es una operación
                    then begin
                         ExtractStringList( Copy( Operacion, 2, MaxSmallint ), OperacionList, True, '+' );
                         For NroOperacion := 0 to OperacionList.Count - 1 do
                           begin
                           NroFilaOperacion := StrToInt( OperacionList.Strings[ NroOperacion ] ) - 1;   // Empiezan en 1
                           DecAdd( ValorCelda[ NroFila, NroColumna ], ValorCelda[ NroFilaOperacion, NroColumna ] );
                           end;
                         end;
                       end;
                  end
             else begin

                  EjercicioOperacion := ApplicationContainer.Ejercicio;

                  case PeriodoFila[ NroFila ] of
                     'A' : TipoPeriodoSaldo := psApertura;
                     'R' : TipoPeriodoSaldo := psRegularizacion;
                     'C' : TipoPeriodoSaldo := psCierre;
                     else  TipoPeriodoSaldo := psEjercicio;
                            end;

                  EjercicioOperacion := ApplicationContainer.Ejercicio - EjercicioFila[ NroFila ];

                       For NroColumna := 0 to UltimoNroColumna do
                         If   OperacionCelda[ NroFila, NroColumna ]<>''
                         then begin
                              ExtractStringList( OperacionCelda[ NroFila, NroColumna ], OperacionList, True, ',' );
                              For NroOperacion := 0 to OperacionList.Count - 1 do
                                begin
                                TipoOperacionSaldo := osSaldoAcreedor;
                                Operacion := OperacionList.Strings[ NroOperacion ];
                                Pe := Pos( '.', Operacion );
                                If   Pe=0
                                then TextoCuenta := Operacion
                                else begin    // Tiene un especificador de tipo de saldo
                                     TextoCuenta := Copy( Operacion, 1, Pe - 1 );
                                     IF   Pe<Length( Operacion )
                                     then begin
                                          CalculoSaldo := Operacion[ Pe + 1 ];
                                          case CalculoSaldo of
                                            'H' : TipoOperacionSaldo := osSaldoAcreedor;
                                            'D' : TipoOperacionSaldo := osSaldoDeudor;
                                            'd' : TipoOperacionSaldo := osSumaDebe;
                                            'h' : TipoOperacionSaldo := osSumaHaber;
                                            end;
                                          end;
                                     end;

                                //* 26.04.2010 Modificados los tipos de operación osSumaDebe y osSumaHaber
                                //             para que no incluya los saldos de apertura.

                           If   TipoPeriodoSaldo=psApertura
                           then begin
                                SumasySaldos := Saldos.SaldoApertura( TextoCuenta, '', True, EjercicioOperacion );
                                SumaDebe := SumasySaldos.SumaDebe;
                                SumaHaber := SumasySaldos.SumaHaber;
                                end
                           else begin
                                
                                case TipoPeriodoSaldo of
                                  psEjercicio      : begin
                                                     PeriodoInicial := 0;
                                                     PeriodoFinal := 12;
                                                     end;
                                  psRegularizacion : begin
                                                     PeriodoInicial := 13;
                                                     PeriodoFinal := 13;
                                                     end;
                                  psCierre         : begin
                                                     PeriodoInicial := 14;
                                                     PeriodoFinal := 14;
                                                     end;
                                  end;

                                SumasySaldos := Saldos.SaldoPeriodo( TextoCuenta, '', True, EjercicioOperacion, PeriodoInicial, PeriodoFinal, True );

                                SumaDebe := SumasySaldos.SumaDebe;
                                SumaHaber := SumasySaldos.SumaHaber;

                                If   TipoPeriodoSaldo=psEjercicio
                                then begin
                                     SumaDebe := SumaDebe - SumasySaldos.SumaDebeInicial;
                                     SumaHaber := SumaHaber - SumasySaldos.SumaHaberInicial;
                                     end;

                                end;

                                case TipoOperacionSaldo of
                                  osSaldoDeudor   : SaldoOperacion := SumaDebe - SumaHaber;
                                  osSaldoAcreedor : SaldoOperacion := SumaHaber - SumaDebe;
                                  osSumaDebe      : SaldoOperacion := SumaDebe;
                                  osSumaHaber     : SaldoOperacion := SumaHaber;
                                  end;

                                DecAdd( ValorCelda[ NroFila, NroColumna ], SaldoOperacion );

                                end;
                              end;
                       end;
             ApplicationContainer.ShowProgression;
             end;

         If   IncluyeTotales
         then For NroFila := 0 to NroFilas - 1 do
                For NroColumna := 0 to NroColumnas - 2 do
                  DecAdd( ValorCelda[ NroFila, NroColumnas - 1 ], ValorCelda[ NroFila, NroColumna ] );

         InsertaRegistro( 0, TituloColumna, [] );

         For NroFila := 0 to NroFilas - 1 do
           begin
           TextoTitulo := TituloFila[ NroFila ];
           Pe := Pos( '%', TextoTitulo );
           If   Pe<>0
           then begin
                Periodo := StrToInt( Copy( TextoTitulo, Pe + 1, 1 ) );
                EjercicioOperacion := ApplicationContainer.Ejercicio - Periodo;
                TextoTitulo[ Pe + 1 ] := 'd';
                TextoTitulo := Format( TextoTitulo, [ EjercicioOperacion ] );
                end;
                
           TituloFila[ NroFila ] := TextoTitulo;

           InsertaRegistro( NivelFila[ NroFila ], TituloFila[ NroFila ], ValorCelda[ NroFila ] );
           end;

       finally
         OperacionList.Free;
         CloseFile( Fichero );
         IOCheck( IoResult );
         end;

     finally
       ApplicationContainer.EndProgression;
       end;
end;

procedure TRptCpnForm.FormManagerOkButton;
begin
     Report.Launch;
end;

procedure TRptCpnForm.ReportBeforeStart;
begin
     EstadoCambiosTable  := Report.CreateEmptyTable( 'EstadoCambios' );
     EstadoCambiosFields := TEstadoCambiosFields.Create( EstadoCambiosTable );
     SeleccionaRegistros;
     Report.SetValue( 'FechaCierre', ApplicationContainer.LastDayOfYearDate );
end;

end.
