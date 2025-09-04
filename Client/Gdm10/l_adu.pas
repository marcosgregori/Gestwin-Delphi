

unit l_adu;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,

  Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  ReportManager, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxDBEdit, dxmdaset,

  Gim10Fields,

  dm_sal, cxCheckBox, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics,
  cxLookAndFeels, cxLabel, cxGroupBox;


type
    TRptAduForm = class(TgxForm)
    FormManager: TgxFormManager;
    report: TgxReportManager;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataVencimientoInicial: TDateField;
    DataVencimientoFinal: TDateField;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DataPanel: TgxEditPanel;
    VencimientoInicialCtrl: TcxDBDateEdit;
    VencimientoFinalCtrl: TcxDBDateEdit;
    AgruparPorClienteCtrl: TcxDBCheckBox;
    DataAgruparPorCliente: TBooleanField;
    gxRangeBox1: TgxRangeBox;
    Label3: TcxLabel;
    DataExcluirRevisados: TBooleanField;
    cxGroupBox1: TcxGroupBox;
    ExcluirRevisadosCtrl: TcxDBCheckBox;
    ExcluirAceptadosCtrl: TcxDBCheckBox;
    DataExcluirAceptados: TBooleanField;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure reportBeforeStart;
    private
    function ConstruyeConsulta: String;
    public

    end;

var RptAduForm : TRptAduForm = nil;

procedure ListadoAntiguedadDeuda;


implementation

uses   LibUtils,
       QueryGrid,

       EnterpriseDataAccess,

       dm_sub,
       dm_ecc,

       q_adu;

{$R *.DFM}

procedure ListadoAntiguedadDeuda;
begin
     CreateReportForm( TRptAduForm, RptAduForm );
end;

procedure TRptAduForm.InitializeForm;
begin
     DataVencimientoInicial.Value := EncodeDate( ApplicationContainer.Ejercicio - 1, 1, 1 );
     DataVencimientoFinal.Value := ApplicationContainer.TodayDate;

     DataAgruparPorCliente.Value := True;
end;

procedure TRptAduForm.reportBeforeStart;
begin
     Report.SetSQLExpression( ConstruyeConsulta );
end;

function TRptAduForm.ConstruyeConsulta : String;

var   SQLText : String;

begin
     SQLText := 'SELECT EfectoCobrar.*, ' +
                '       Cuenta.Descripcion AS Nombre, ' +
                '       ( CAST( ( ' + FloatToStr( ApplicationContainer.TodayDate ) + ' - CAST( EfectoCobrar.FechaVencimiento AS FLOAT ) ) AS INTEGER ) ) AS Dias ' +
                'FROM   EfectoCobrar ' +
                '       LEFT JOIN Cuenta ON ( Cuenta.Codigo=EfectoCobrar.SubcuentaCliente ) ' +
                '       LEFT JOIN Remesa ON ( Remesa.Ejercicio=EfectoCobrar.EjercicioRemesa AND Remesa.NroRemesa=EfectoCobrar.NroRemesa ) ' +
                'WHERE  ( FechaVencimiento BETWEEN <VencimientoInicial> AND <VencimientoFinal> ) AND ' +
                '       ( EfectoCobrar.Importe>0.0 ) AND ' +
                '       NOT ( ( ( EfectoCobrar.NroRemesa IS NULL OR EfectoCobrar.NroRemesa=0 ) AND NOT EfectoCobrar.FechaCobro IS NULL ) OR ' +
                '             ( NOT ( EfectoCobrar.NroRemesa IS NULL OR EfectoCobrar.NroRemesa=0 ) AND ( Remesa.Estado<>0 OR EfectoCobrar.Cancelado OR EfectoCobrar.Impagado ) ) )';

     If   DataExcluirAceptados.Value
     then StrAdd( SQLText, ' AND ( EfectoCobrar.NroRemesa IS NULL OR EfectoCobrar.NroRemesa=0 OR Remesa.Estado<>4 ) ' );

     If   DataExcluirRevisados.Value
     then StrAdd( SQLText, ' AND NOT EfectoCobrar.Revisado ' );

     If   DataAgruparPorCliente.Value
     then StrAdd( SQLText, ' ORDER BY SubcuentaCliente, FechaVencimiento' )
     else StrAdd( SQLText, ' ORDER BY FechaVencimiento' );

     SetSQLVars( SQLText, Data );

     Result := SQLText;
end;

procedure TRptAduForm.FormManagerOkButton;
begin
     If   FormManager.GridOutputField.Value
     then RejillaAntiguedadDeuda( ConstruyeConsulta, DataAgruparPorCliente.Value )
     else Report.Launch;
end;

end.

