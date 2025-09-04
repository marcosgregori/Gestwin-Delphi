
unit l_rem;

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
    TRptRemForm = class(TgxForm)
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

var RptRemForm : TRptRemForm = nil;

procedure ListadoRemesas;


implementation

uses   cx_rem;

{$R *.DFM}

procedure ListadoRemesas;
begin
     CreateReportForm( TRptRemForm, RptRemForm );
end;

procedure TRptRemForm.InitializeForm;
begin
     DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
     DataNroRemesaInicial.Value := 1;
     DataNroRemesaFinal.Value := 99999999;
     DataEstado.Value := 0;
end;

procedure TRptRemForm.NroFacturaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaRemesas( Sender, srTodas );
end;

procedure TRptRemForm.FormManagerOkButton;
begin
     Enabled := False;

     With Report do
       try
         Load;

         ConsultaQuery := GetQuery( 'Consulta' );
         If   Assigned( ConsultaQuery )
         then With ConsultaQuery do
                begin

                SQL.Text := 'SELECT Remesa.*, Cuenta.Descripcion FROM Remesa LEFT JOIN Cuenta ON ( SubcuentaEntidad=Cuenta.Codigo ) WHERE';

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
         SetValueFields( Data );
         Start;
         
       except on E : Exception do Cancel( E );
         end;
end;

end.
