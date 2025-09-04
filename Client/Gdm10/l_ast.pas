unit l_ast;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,

  Gdm00Dm,
  Gdm10Dm,

  Datamanager,
  nxDB,
  Mask,
  ComCtrls,
  ReportManager,

  DB,
  sqlset, Menus, cxLookAndFeelPainters, cxButtons, cxSpinEdit, cxDBEdit,
  cxCheckBox, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxPC, cxControls, dxmdaset,

  dm_sal, dxSkinsCore, dxSkinscxPCPainter, dxSkinsDefaultPainters,
  cxGraphics, cxLookAndFeels, cxLabel, f_grd, cxGroupBox,
  cxPCdxBarPopupMenu, dxBarBuiltInMenu;


type
    TRptAstForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    TabSheet2: TcxTabSheet;
    AsientoInicialCtrl: TcxDBTextEdit;
    AsientoFinalCtrl: TcxDBTextEdit;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    DescuadradosCtrl: TcxDBCheckBox;
    TipoAsientoCtrl: TcxDBSpinEdit;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataNroAsientoInicial: TIntegerField;
    DataNroAsientoFinal: TIntegerField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataTipoAsiento: TSmallintField;
    DataDescuadrados: TBooleanField;
    Label3: TcxLabel;
    Label6: TcxLabel;
    desTipoAstoLabel: TcxLabel;
    Label1: TcxLabel;
    Label4: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure AsientoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure TipoAsientoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TipoAsientoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure FormManagerPreparedForm;
    procedure ReportBeforeStart;
    private
    function ConstruyeConsulta: String;

    protected
    class var
      NroAsiento : LongInt;
      EnviarARejilla : Boolean;
    public

    end;

var
  RptAstForm : TRptAstForm = nil;

procedure ListadoAsientos( NroAsiento     : LongInt;
                           EnviarARejilla : Boolean = False );


implementation

uses   LibUtils,

       cxCustomData,
       cxGridTableView,
       cxGridDBTableView,
       cxDBData,

       EnterpriseDataAccess,
       Gim10Fields,

       dm_pga,
       dm_ast,
       dm_tas,
       dm_sub,

       b_msg,

       cx_ast,
       cx_tas,

       q_ast;

{$R *.DFM}

resourceString
       RsMsg1 = 'Rejilla de asientos';

procedure ListadoAsientos( NroAsiento     : LongInt;
                           EnviarARejilla : Boolean = False );
begin
     TRptAstForm.NroAsiento := NroAsiento;
     TRptAstForm.EnviarARejilla := EnviarARejilla;
     CreateReportForm( TRptAstForm, RptAstForm );
end;

procedure TRptAstForm.InitializeForm;
begin
     If   EnviarARejilla
     then Caption := RsMsg1;

     If   NroAsiento=0
     then begin
          DataNroAsientoInicial.Value := 1;
          DataNroAsientoFinal.Value := 9999999;
          end
     else begin
          DataNroAsientoInicial.Value := NroAsiento;
          DataNroAsientoFinal.Value := NroAsiento;
          end;

     DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;

end;

procedure TRptAstForm.ReportBeforeStart;

var  St : String;

begin
     With Report do
       begin
       SetSQLExpression( ConstruyeConsulta );

       SetValue( RsCentrosCoste, DataModule00.DmEmpresaFields.Contable_CtrosCoste.Value );
       SetValue( RsSeleccion, PageControl.ActivePage.PageIndex  );
       If   DataTipoAsiento.Value=0
       then St := ''
       else St := IntToStr( DataTipoAsiento.Value ) + ', ';
       St := St + TipoAsiento.Descripcion( DataTipoAsiento.Value );
       SetValue( 'DescTipoAsiento', St );
       end;

end;

procedure TRptAstForm.TipoAsientoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTiposAsiento( Sender );
end;

procedure TRptAstForm.TipoAsientoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     TipoAsiento.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptAstForm.AsientoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAsientos( Sender );
end;

function TRptAstForm.ConstruyeConsulta : String;

var   SQLSeleccion,
      SQLString,
      SQLOrder,
      SQLSeleccionTipoAsiento : String;

begin
     case PageControl.ActivePage.TabIndex of
       0 : begin
           SQLSeleccion := SQLFormat( 'Apunte.Ejercicio=%d AND Apunte.NroAsiento BETWEEN %s AND %s', [ ApplicationContainer.Ejercicio, DataNroAsientoInicial, DataNroAsientoFinal ] );
           SQLOrder := 'ORDER BY Ejercicio, NroAsiento, NroApunte';
           end;
       1 : begin
           SQLSeleccion := SQLFormat( 'Apunte.Fecha BETWEEN %s AND %s', [ DataFechaInicial, DataFechaFinal ] );
           SQLOrder := 'ORDER BY Fecha, NroAsiento, NroApunte';
           end;
       end;

     With Report do
       If   DataDescuadrados.Value
       then SQLString := SQLSet.GetSQLText( 'Descuadre' )
       else SQLString := SQLSet.GetSQLText( 'Diario' );

     If   DataTipoAsiento.Value=0
     then SQLSeleccionTipoAsiento := ''
     else SQLSeleccionTipoAsiento := SQLFormat( ' WHERE Asiento.TipoAsiento=%s', [ DataTipoAsiento ] );

     SetSQLVar( SQLString, 'Seleccion', SQLSeleccion );
     SetSQLVar( SQLString, 'SeleccionTipoAsiento', SQLSeleccionTipoAsiento );

     StrAdd( SQLString, SQLOrder );

     Result := SQLString;

end;

procedure TRptAstForm.FormManagerOkButton;
begin
     If   FormManager.GridOutputField.Value
     then RejillaAsientos( ConstruyeConsulta )
     else Report.Launch;
end;

procedure TRptAstForm.FormManagerPreparedForm;
begin
     If   ( NroAsiento=0 ) or EnviarARejilla
     then PageControl.ActivePageIndex := 1;
     If   EnviarARejilla
     then FormManager.GridOutputField.Value := True;
end;

end.



