
unit l_hdc;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,

     AppContainer,
     Gim30Fields,
     ComCtrls,
     DB,
     DataManager,
     ReportManager, Menus, cxLookAndFeelPainters, cxButtons, cxGraphics,
     cxMaskEdit, cxDropDownEdit, cxDBEdit, cxCheckBox, cxControls,
     cxContainer, cxEdit, cxTextEdit, cxPC, dxmdaset, cxCalendar,
     cxIndexedComboBox,

     dm_mov,

     cxGroupBox,
     cxRadioGroup,
     dxSkinsCore,
     dxSkinscxPCPainter,
     cxLookAndFeels,
     cxLabel, dxSkinsDefaultPainters, cxPCdxBarPopupMenu, dxBarBuiltInMenu;


type
    TRptHdcForm = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    Report: TgxReportManager;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataNroHojaInicial: TIntegerField;
    DataNroHojaFinal: TIntegerField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataTransportistaInicial: TWideStringField;
    DataTransportistaFinal: TWideStringField;
    Panel1: TcxGroupBox;
    PageControl1: TcxPageControl;
    TabSheet1: TcxTabSheet;
    gxRangeBox2: TgxRangeBox;
    NroHojaInicialCtrl: TcxDBTextEdit;
    NroHojaFinalCtrl: TcxDBTextEdit;
    TabSheet2: TcxTabSheet;
    gxRangeBox1: TgxRangeBox;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    gxRangeBox7: TgxRangeBox;
    TransportistaInicialCtrl: TcxDBTextEdit;
    TransportistaFinalCtrl: TcxDBTextEdit;
    Label5: TcxLabel;
    Label17: TcxLabel;
    Label21: TcxLabel;
    Label22: TcxLabel;
    Label9: TcxLabel;
    Label6: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DataClienteInicial: TStringField;
    DataClienteFinal: TStringField;
    gxRangeBox5: TgxRangeBox;
    ClienteInicialCtrl: TcxDBTextEdit;
    ClienteFinalCtrl: TcxDBTextEdit;
    Label3: TcxLabel;
    Label11: TcxLabel;
    Label12: TcxLabel;
    Label7: TcxLabel;
    AgrupacionCtrl: TcxDBRadioGroup;
    DataAgrupacion: TSmallintField;
    DataAgrupar: TBooleanField;
    AgruparCtrl: TcxDBCheckBox;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure HojaCargaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure TransportistaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure TransportistaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure AgruparCtrlPropertiesChange(Sender: TObject);
    protected
    class var
      NroHoja : LongInt;
    public

    end;

var  RptHdcForm: TRptHdcForm = nil;

procedure ListadoHojasCarga( NroHoja : LongInt );


implementation

uses   SysUtils,
       LibUtils,
       Variants,
       DateUtils,

       Gim00Fields,

       dm_tra,
       dm_cls,
       dm_fdv,
       dm_cli,

       cx_hdc,
       cx_tra,
       cx_cli;

{$R *.DFM}

procedure ListadoHojasCarga( NroHoja : LongInt );
begin
     TRptHdcForm.NroHoja := NroHoja;
     CreateReportForm( TRptHdcForm, RptHdcForm, [] );
end;

procedure TRptHdcForm.InitializeForm;
begin
     DataNroHojaInicial.Value := NroHoja;
     DataNroHojaFinal.Value := NroHoja;
     DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
     DataTransportistaFinal.Value := HighStrCode;
     DataClienteFinal.Value := HighStrCode;
     DataAgrupar.Value := False;
     DataAgrupacion.Value := 0;
end;

procedure TRptHdcForm.AgruparCtrlPropertiesChange(Sender: TObject);
begin
     AgrupacionCtrl.Enabled := AgruparCtrl.Checked;
end;

procedure TRptHdcForm.ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TRptHdcForm.ClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptHdcForm.FormManagerOkButton;

procedure ConstruyeConsulta;

var   SQLString,
      SQLSeleccion,
      SQLOrdenacion : String;
      Consulta : TnxeQuery;

begin

     With Report, ReportManagerDataModule do
       begin

       Consulta := GetQuery;
       If   Assigned( Consulta )
       then begin
            SQLString := SQLSet.GetSQLText;
            case PageControl1.ActivePageIndex of
              0 : begin
                  StrAdd( SQLSeleccion, SQLFormat( ' HojaCarga.Ejercicio=%d AND HojaCarga.NroHoja BETWEEN %s AND %s', [ ApplicationContainer.Ejercicio, DataNroHojaInicial, DataNroHojaFinal ] ) );
                  SQLOrdenacion := 'NroHoja, NroRegistro';
                  end;
              1 : begin
                  StrAdd( SQLSeleccion, SQLFormat( ' HojaCarga.Fecha BETWEEN %s AND %s', [ DataFechaInicial, DataFechaFinal ] ) );
                  SQLOrdenacion := 'Fecha, NroHoja, NroRegistro';
                  end;
              end;

            StrAdd( SQLSeleccion, SQLFormat( ' AND HojaCarga.CodigoTransportista BETWEEN %s AND %s', [ DataTransportistaInicial, DataTransportistaFinal ] ) );
            StrAdd( SQLSeleccion, SQLFormat( ' AND Movimiento.Propietario BETWEEN %s AND %s', [ DataClienteInicial, DataClienteFinal ] ) );

            If   DataAgrupar.Value
            then case  DataAgrupacion.Value of
                    0 : SQLOrdenacion := 'HojasCarga.CodigoTransportista, NroHoja, NroRegistro';
                    1 : SQLOrdenacion := 'HojasCarga.Propietario, NroHoja, NroRegistro';
                    end;

            SetSQLVar( SQLString, 'Seleccion', SQLSeleccion );
            SetSQLVar( SQLString, 'Ordenacion', SQLOrdenacion );

            Consulta.SQL.Text := SQLString;
            end;

       end;
end;

begin
     With Report do
       try
         Load;
         ConstruyeConsulta;
         SetValue( RsSeleccion, PageControl1.ActivePageIndex );
         Clase.SetReportTitles( Report, 4 );
         FacturaVentas.FijaDecimalesInforme( Report );
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptHdcForm.HojaCargaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaHojasCarga( Sender );
end;

procedure TRptHdcForm.TransportistaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTransportistas( Sender );
end;

procedure TRptHdcForm.TransportistaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Transportista.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

end.

