
unit l_fcg;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  ComCtrls,

  ReportManager, Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox,
  cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, DB, dxmdaset, DataManager, cxGraphics,
  cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters, cxLabel, cxGroupBox;


type
    TrptFcgForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    AgruparPorProveedorCtrl: TcxDBCheckBox;
    Data: TgxMemData;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
    DataSource: TDataSource;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataAgruparPorProveedor: TBooleanField;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    Label4: TcxLabel;
    Label1: TcxLabel;
    Label7: TcxLabel;
    Label3: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure FechaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

    public

    end;

var
  rptFcgForm : TrptFcgForm = nil;

procedure ListadoFacturasRecibidas;


implementation

uses   Gim00Fields,
       Gim10Fields,
       Gdm00Dm,

       dm_sub,

       b_msg,

       cx_sub;

{$R *.DFM}

procedure ListadoFacturasRecibidas;
begin
     CreateReportForm( TrptFcgForm, RptFcgForm );
end;

procedure TrptFcgForm.InitializeForm;
begin
     DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
     DataCodigoInicial.Value := '400000000';
     DataCodigoFinal.Value := '419999999';
     DataAgruparPorProveedor.Value := True;
end;

procedure TrptFcgForm.CodigoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TrptFcgForm.FechaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error );
end;

procedure TrptFcgForm.FormManagerOkButton;

procedure ConstruyeConsulta;

var   SQLString,
      SQLSeleccion,
      SQLOrdenacion  : String;

begin

     With Report, ReportManagerDataModule do
       begin

       SQLSeleccion  := SQLFormat( '( Fecha BETWEEN %s AND %s ) AND ( Propietario BETWEEN %s AND %s )', [ DataFechaInicial, DataFechaFinal, DataCodigoInicial, DataCodigoFinal ] );

       If   DataAgruparPorProveedor.Value
       then SQLOrdenacion := 'Propietario, Fecha, NroAsiento, NroApunte' 
       else SQLOrdenacion := 'Fecha, NroAsiento, NroApunte';

       SQLString := SQLSet.GetSQLText( 'Diario' );

       SetSQLVar( SQLString, 'Seleccion', SQLSeleccion );
       SetSQLVar( SQLString, 'Ordenacion', SQLOrdenacion );

       SetSQLExpression( SQLString );
       end;

end;

begin
     Enabled := False;
     With report do
       try
         Load;
         ConstruyeConsulta;
         SetValue( RsCentrosCoste, DataModule00.DmEmpresaFields.Contable_CtrosCoste.Value );
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

procedure TrptFcgForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender );
end;

end.
