
unit l_dir;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  ComCtrls,

  EnterpriseDataAccess,
  Datamanager,
  ReportManager,
  DB,
  nxdb, Menus, cxLookAndFeelPainters, cxButtons, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxDBEdit, cxGraphics, cxMaskEdit, cxDropDownEdit,
  cxIndexedComboBox, cxCheckBox, dxmdaset, cxSpinEdit,

  Gim10Fields,

  dm_sal, dxSkinsCore, cxLookAndFeels, dxSkinsDefaultPainters, cxLabel,
  cxGroupBox, dxUIAClasses;


type
    TrptDirForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    RayadoModernoCtrl: TcxDBCheckBox;
    PeriodoInicialCtrl: TcxDBSpinEdit;
    PeriodoFinalCtrl: TcxDBSpinEdit;
    PrimeraPaginaCtrl: TcxDBSpinEdit;
    PrimerAsientoCtrl: TcxDBSpinEdit;
    PaginadoCtrl: TcxDBCheckBox;
    NivelCtrl: TcxDBIndexedComboBox;
    Report: TgxReportManager;
    SaldosTable: TnxeTable;
    gxRangeBox1: TgxRangeBox;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataPeriodoInicial: TSmallintField;
    DataPeriodoFinal: TSmallintField;
    DataPrimeraPagina: TSmallintField;
    DataRayadoModerno: TBooleanField;
    DataPrimerAsiento: TSmallintField;
    DataNivel: TSmallintField;
    DataPaginado: TBooleanField;
    Label4: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label6: TcxLabel;
    Label7: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    PeriodosNaturalesCtrl: TcxDBCheckBox;
    DataPeriodosNaturales: TBooleanField;
    procedure PeriodoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ReportSetReportName;
    procedure ReportBeforeStart;
    procedure RayadoModernoCtrlPropertiesChange(Sender: TObject);
    private
    procedure SeleccionaRegistros;

    public

      RelacionSaldosTable   : TnxeTable;
      RelacionSaldosFields  : TRelacionSaldosFields;
      SaldosFields          : TSaldosFields;
      
    end;

var
  rptDirForm : TrptDirForm = nil;

procedure DiarioResumenMensual;


implementation

uses   DateUtils,
       LibUtils,

       Gdm10Dm,

       dmi_sal,

       dm_pga,
       dm_sub,

       b_msg;

{$R *.DFM}

procedure DiarioResumenMensual;
begin
     CreateReportForm( TrptDirForm, rptDirForm );
end;

procedure TrptDirForm.initializeForm;
begin
     SaldosFields := TSaldosFields.Create( saldosTable );

     DataPeriodoInicial.Value := 0;
     DataPeriodoFinal.Value := MonthOf( ApplicationContainer.TodayDate );
     DataPeriodosNaturales.Value := True;
     DataNivel.Value := 0;
     DataPrimeraPagina.Value := 1;
     DataPrimerAsiento.Value := 1;
end;

procedure TrptDirForm.SeleccionaRegistros;

var   LongCuenta,
      NroMes,
      NroMesAsiento,
      PeriodoInicial,
      PeriodoFinal,
      I : SmallInt;
      CuentaActual : String;
      SumaDebePeriodo,
      SumaHaberPeriodo : Decimal;
      SumasySaldos : ISumasySaldos;

procedure InsertaRegistro( _NroMes,
                           _Orden : SmallInt;
                           _Debe,
                           _Haber : Decimal );
begin
     With RelacionSaldosFields do
       begin

       RelacionSaldosTable.Append;

       Periodo.Value := _NroMes;
       Cuenta.Value := SaldosFields.Codigo.Value;
       NombrePeriodo.Value := StrMonth( _NroMes, False );
       DescripcionCuenta.Value := dm_sub.Cuenta.Descripcion( Cuenta.Value, False, True );
       Orden.Value := _Orden;
       Debe.Value := _Debe;
       Haber.Value := _Haber;

       RelacionSaldosTable.Post;
       end;

end;

begin

     If   DataNivel.Value=0
     then LongCuenta := 3
     else LongCuenta := 4;

     With SaldosTable do
       begin

       CuentaActual := '';

       SetRange( [ ApplicationContainer.Ejercicio, '', '' ], [ ApplicationContainer.Ejercicio, HighStrCode, HighStrCode ] );

       ApplicationContainer.StartProgression( RecordCount );

       try

         First;
         While not Eof  do
           begin

           ApplicationContainer.ShowProgression;

           If   Length( SaldosFields.Codigo.Value )=LongCuenta   // Sólo cuentas de 3 o 4 dígitos
           then begin

                If   Copy( SaldosFields.Codigo.Value, 1, LongCuenta )<>CuentaActual
                then begin

                     CuentaActual := Copy( SaldosFields.Codigo.Value, 1, LongCuenta );

                     With RelacionSaldosFields do
                       begin

                       NroMes := DataPeriodoInicial.Value;
                       While NroMes<=DataPeriodoFinal.Value do
                         begin

                         NroMesAsiento := NroMes;
                         PeriodoInicial := NroMes;
                         PeriodoFinal := NroMes;

                         If   DataPeriodosNaturales.Value
                         then begin
                              If   NroMes=0
                              then begin
                                   If   DataPeriodoFinal.Value>0                             // Enero también está incluido en la relación
                                   then begin
                                        PeriodoInicial := 0;
                                        PeriodoFinal := 1;
                                        NroMes := 1;                                         // Enero ya está incluido en éste saldo, por lo tanto me lo salto
                                        end;
                                   NroMesAsiento := 1;
                                   end
                              else If   NroMes=12
                                   then begin
                                        If   DataPeriodoFinal.Value>12
                                        then begin
                                             PeriodoInicial := 12;
                                             PeriodoFinal := DataPeriodoFinal.Value;
                                             NroMesAsiento := 12;
                                             NroMes := DataPeriodoFinal.Value;
                                             end
                                        end
                                   else If   ( NroMes=13 ) and ( DataPeriodoFinal.Value=14 )  // El usuario solo ha incluido los periodos 13 y 14 y ha marcado periodos naturales
                                        then begin
                                             PeriodoInicial := 13;
                                             PeriodoFinal := 14;
                                             NroMesAsiento := 12;
                                             NroMes := 14;
                                             end
                                        else If   NroMes=14
                                             then NroMesAsiento := 12;
                              end;

                         SumasySaldos := Saldos.SaldoPeriodo( SaldosFields.Codigo.Value, '', True, ApplicationContainer.Ejercicio, PeriodoInicial, PeriodoFinal, True );

                         SumaDebePeriodo := 0.0;
                         SumaHaberPeriodo := 0.0;
                         For I := PeriodoInicial to PeriodoFinal do
                           begin
                           SumaDebePeriodo := SumaDebePeriodo + SumasySaldos.Debe[ I ];
                           SumaHaberPeriodo := SumaHaberPeriodo + SumasySaldos.Haber[ I ];
                           end;

                         If   SumaDebePeriodo<>0.0
                         then InsertaRegistro( NroMesAsiento, 0, SumaDebePeriodo, 0.0 );

                         If   SumaHaberPeriodo<>0.0
                         then InsertaRegistro( NroMesAsiento, 1, 0.0, SumaHaberPeriodo );

                         Inc( NroMes );
                         end;

                     end;

                  end;

                end;

           Next;
           end;

       finally
         ApplicationContainer.EndProgression;
         end;

       end;

end;

procedure TrptDirForm.FormManagerOkButton;
begin
     Report.Launch;
end;

procedure TrptDirForm.PeriodoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateMonth( Sender, DisplayValue, ErrorText, Error );
end;

procedure TrptDirForm.RayadoModernoCtrlPropertiesChange(Sender: TObject);
begin
     Report.UpdateReportName;
end;

procedure TrptDirForm.ReportBeforeStart;
begin
     With Report do
       begin
       RelacionSaldosTable  := CreateEmptyTable( 'RelacionSaldos', DataModule10.GetSQL( 'RelacionSaldos' ) );
       RelacionSaldosFields := TRelacionSaldosFields.Create( RelacionSaldosTable );

       RelacionSaldosTable.IndexFieldNames := 'Periodo;Orden;Cuenta';

       SeleccionaRegistros;

       SetValue( RsTextoPeriodoInicial, StrMonth( DataPeriodoInicial.Value, False ) );
       SetValue( RsTextoPeriodoFinal, StrMonth( DataPeriodoFinal.Value, False ) );
       end;

end;

procedure TrptDirForm.ReportSetReportName;
begin
     If   DataRayadoModerno.Value
     then Report.FileName := 'dm10\l_dir2'
     else Report.FileName := 'dm10\l_dir1';
end;

end.
