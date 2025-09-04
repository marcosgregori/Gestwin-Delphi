
unit l_rdp;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  ComCtrls,

  Menus, cxLookAndFeelPainters, cxButtons, cxGraphics,
  cxDropDownEdit, cxDBEdit, cxIndexedComboBox, cxMaskEdit, cxCalendar,
  cxControls, cxContainer, cxEdit, cxTextEdit, ReportManager, DB, dxmdaset,
  DataManager, cxPC, cxLookAndFeels, dxSkinsCore, dxSkinscxPCPainter,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox, cxPCdxBarPopupMenu,
  dxBarBuiltInMenu;


type
    TRptRdpForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    TabSheet2: TcxTabSheet;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    NroFacturaInicialCtrl: TcxDBTextEdit;
    NroFacturaFinalCtrl: TcxDBTextEdit;
    EstadoCtrl: TcxDBIndexedComboBox;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataNroRemesaInicial: TIntegerField;
    DataNroRemesaFinal: TIntegerField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataEstado: TSmallintField;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    Label3: TcxLabel;
    Label4: TcxLabel;
    Label1: TcxLabel;
    Label8: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure NroFacturaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    private

    public
      ConsultaQuery : TnxeQuery;
    end;

var RptRdpForm : TRptRdpForm = nil;

procedure ListadoRemesasPago;


implementation

uses   cx_rdp;

{$R *.DFM}

procedure ListadoRemesasPago;
begin
     CreateReportForm( TRptRdpForm, RptRdpForm );
end;

procedure TRptRdpForm.InitializeForm;
begin
     DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
     DataNroRemesaInicial.Value := 1;
     DataNroRemesaFinal.Value := 99999999;
     DataEstado.Value := 0;
end;

procedure TRptRdpForm.NroFacturaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaRemesasPago( Sender, srpTodas );
end;

procedure TRptRdpForm.FormManagerOkButton;
begin

     With Report do
       try
         Load;

         ConsultaQuery := GetQuery( 'Consulta' );
         If   Assigned( ConsultaQuery )
         then With ConsultaQuery do
                begin

                SQL.Text := 'SELECT RemesaPago.*, Cuenta.Descripcion FROM RemesaPago LEFT JOIN Cuenta ON ( SubcuentaEntidad=Cuenta.Codigo ) WHERE';

                case PageControl.ActivePageIndex of
                  0 : SQL.Add( SQLFormat( 'Ejercicio=%d AND NroRemesa BETWEEN %s AND %s', [ ApplicationContainer.Ejercicio, DataNroRemesaInicial, DataNroRemesaFinal ] ) );
                  1 : SQL.Add( SQLFormat( 'Fecha BETWEEN %s AND %s', [ DataFechaInicial, DataFechaFinal ] ) );
                  end;

                If   DataEstado.Value>0
                then SQL.Add( SQLFormat( 'AND Estado=%d', [ DataEstado.Value - 1 ] ) );

                case PageControl.ActivePageIndex of
                  0 : SQL.Add( 'ORDER BY Ejercicio, NroRemesa' );
                  1 : SQL.Add( 'ORDER BY Fecha, NroRemesa' );
                  end;

                end;

         SetValue( rsSeleccion, PageControl.ActivePageIndex );
         SetValue( 'TextoEstado', EstadoCtrl.Text );

         Start;

       except on E : Exception do Cancel( E );
         end;
end;

end.
