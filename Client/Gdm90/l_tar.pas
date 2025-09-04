unit l_tar;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  Menus, cxLookAndFeelPainters, cxGraphics, ReportManager,
  cxDBEdit, cxCheckBox, cxDropDownEdit, cxIndexedComboBox, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxCalendar, cxButtons, DB,
  dxmdaset, DataManager, cxLookAndFeels, dxSkinsCore,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox;

type
    TRptTarForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    SituacionCtrl: TcxDBIndexedComboBox;
    UrgentesCtrl: TcxDBCheckBox;
    CodigoTecnicoCtrl: TcxDBTextEdit;
    gxRangeBox1: TgxRangeBox;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataFechaFinal: TDateField;
    DataFechaInicial: TDateField;
    DataSituacion: TSmallintField;
    DataCodigoTecnico: TWideStringField;
    DataSoloUrgentes: TBooleanField;
    DataAgruparPorResolucion: TBooleanField;
    AgruparPorResolucionCtrl: TcxDBCheckBox;
    Label2: TcxLabel;
    Label1: TcxLabel;
    DescTecnicoLabel: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure CodigoTecnicoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoTecnicoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SituacionCtrlPropertiesEditValueChanged(Sender: TObject);
    private

    public
    end;

var  RptTarForm: TRptTarForm = nil;

procedure ListadoTareas( UnaSituacion    : byte;
                         UnCodigoTecnico : String );


implementation

uses   DateUtils,
       LibUtils,

       Gdm10Dm,
       Gdm90Dm,

       dm_tec,

       cx_tec;

{$R *.DFM}

var   Situacion : Byte;
      CodigoTecnico : String;

procedure ListadoTareas( UnaSituacion    : byte;
                         UnCodigoTecnico : String );
begin
     Situacion := UnaSituacion;
     CodigoTecnico := UnCodigoTecnico;
     CreateEditForm( TRptTarForm, RptTarForm );
end;

procedure TRptTarForm.InitializeForm;
begin
     DataFechaInicial.Value := IncDay( ApplicationContainer.TodayDate, -180 );
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
     DataCodigoTecnico.Value := CodigoTecnico;
     DataSoloUrgentes.Value := False;
     DataSituacion.Value := Situacion;
end;

procedure TRptTarForm.SituacionCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With CodigoTecnicoCtrl do
       begin
       Enabled := SituacionCtrl.ItemIndex in [ 2, 3 ];
       If   Enabled
       then SetFocus
       else Clear;
       end;
     With AgruparPorResolucionCtrl do
       begin
       Enabled := SituacionCtrl.ItemIndex in [ 1, 3 ];
       If   not Enabled
       then Checked := False;
       end;
end;

procedure TRptTarForm.FormManagerOkButton;

var  Consulta : TnxeQuery;
     SQLText,
     SQLSelect : String;

begin
     With Report do
       try
         Load;
         SetValueFields( Data );

         If   DataAgruparPorResolucion.Value
         then SQLText := GetSQLText( 'Agrupado' )
         else SQLText := GetSQLText( 'Simple' );

         SetSQLVar( SQLText, DataFechaInicial );
         SetSQLVar( SQLText, DataFechaFinal );

         SQLSelect := '';
         If   DataSituacion.Value in [ 2, 3 ]
         then SQLSelect := SQLFormat( ' AND CodigoTecnico=%s ', [ DataCodigoTecnico ] );

         Case DataSituacion.Value of
           0, 2 : StrAdd( SQLSelect, ' AND Estado=0 ' );
           1, 3 : StrAdd( SQLSelect, ' AND Estado=1 ' );
           end;

         If   DataSoloUrgentes.Value
         then StrAdd( SQLSelect, ' AND Urgente ' );

         SetSQLVar( SQLText, 'Estado', SQLSelect );

         Consulta := GetQuery;
         If   Assigned( Consulta )
         then Consulta.SQL.Text := SQLText; 

         SetValue( 'TextoSituacion', SituacionCtrl.Text );
         SetValue( 'NombreTecnico', DescTecnicoLabel.Caption );
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptTarForm.CodigoTecnicoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTecnicos( Sender );
end;

procedure TRptTarForm.CodigoTecnicoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Tecnico.Valida( Sender, DisplayValue, ErrorText, Error );
end;

end.
