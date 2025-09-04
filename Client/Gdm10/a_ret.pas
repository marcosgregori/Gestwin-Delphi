unit a_ret;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, Buttons, Mask, ExtCtrls, AppContainer,

  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, DB, cxDBData, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, nxdb,
  dxmdaset, cxMaskEdit, cxSpinEdit, cxCheckBox,

  DataManager,

  dm_iva, cxCurrencyEdit, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxLookAndFeels, cxGroupBox, cxLabel, cxDropDownEdit,
  cxIndexedComboBox, cxNavigator, dxDateRanges,

  Gim10Fields,
  AppForms,
  GridTableViewController, cxCalendar,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  dxScrollbarAnnotations, dxUIAClasses;

type
  TMntRetForm = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    ButtonPanel: TgxEditPanel;
    gGridFooter1: TGridTableViewPanel;
    gGridFooterPanel1: TGridTableViewPanelGroupBox;
    gGridFooterPanel2: TGridTableViewPanelGroupBox;
    GridTableViewController1: TGridTableViewController;
    GridTiposIVATable: TnxeTable;
    GridTiposIVADataSource: TDataSource;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridTableView1: TcxGridTableView;
    GridTableView1Column1: TcxGridColumn;
    GridTableView1Column2: TcxGridColumn;
    GridLevel: TcxGridLevel;
    GridViewCodigo: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewIVASoportado: TcxGridDBColumn;
    GridViewCtaSoportado: TcxGridDBColumn;
    GridViewCtaRepercutido: TcxGridDBColumn;
    GridViewLiquidable: TcxGridDBColumn;
    GridViewColumn1: TcxGridDBColumn;
    GridTiposIVATableCodigoRetencion: TSmallintField;
    GridTiposIVATableCodigo: TSmallintField;
    GridTiposIVATableDescripcion: TWideStringField;
    GridTiposIVATableIVASoportado: TBCDField;
    GridTiposIVATableCtaSoportado: TWideStringField;
    GridTiposIVATableIVAREpercutido: TBCDField;
    GridTiposIVATableRERepercutido: TBCDField;
    GridTiposIVATableCtaRepercutido: TWideStringField;
    GridTiposIVATableLiquidable: TBooleanField;
    GridTiposIVATableSobreTotal: TBooleanField;
    KeyPanel: TgxEditPanel;
    Label1: TcxLabel;
    DescripcionPeriodoLabel: TcxLabel;
    TiposIVADataSource: TDataSource;
    FechaAplicacionCtrl: TcxDBDateEdit;
    TiposIVATable: TnxeTable;
    GridTiposIVATableFechaAplicacion: TDateField;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    GridTiposIVATableCodigoPais: TWideStringField;
    procedure FormManagerInitializeForm;
    function FormManagerGetAccessLevel: Smallint;
    procedure GridTiposIVATableNewRecord(DataSet: TDataSet);
    procedure SubcuentaEditRequest(
      Sender: TcxCustomEdit);
    procedure SubcuentaQueryRequest(
      Sender: TcxCustomEdit);
    procedure SubcuentaValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewCtaSoportadoPropertiesEnter(Sender: TcxCustomEdit);
    procedure GridViewCtaRepercutidoPropertiesEnter(Sender: TcxCustomEdit);
    procedure GridTiposIVATableCalcFields(DataSet: TDataSet);
    procedure GridTableViewController1Delete(Sender: TObject);
    procedure PeriodoCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure TiposIVATableUpdateState(DataSet: TDataSet);
    procedure GridTiposIVATableApplyMasterRange(DataSet: TDataSet);
    procedure TiposIVATableSetKey(DataSet: TDataSet);
    procedure TiposIVATableAfterInsert(DataSet: TDataSet);
    procedure TiposIVATableNewRecord(DataSet: TDataSet);
  private

    TiposIVAFields : TTiposIVAFields;

    CopiarRegistros : Boolean;

    procedure ActualizaEstadoVentana;

  public

  end;

var MntRetForm: TMntRetForm;

procedure MntRetenciones( FromAnotherForm : boolean );

implementation

{$R *.DFM}

uses   AppManager,
       DateUtils,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm10Frm,

       dmi_pga,
       dmi_iva,

       dm_pga,
       dm_sub,

       a_sub,

       b_msg,

       cx_sub;

resourceString

     RsMsg4 = '¿Desea copiar los registros de la última fecha de aplicación?';

procedure MntRetenciones( FromAnotherForm : Boolean );
begin
     CreateEditForm( TMntRetForm, MntRetForm, [], TGds10Frm.LibrosIVASection );
     If   Assigned( MntRetForm )
     then MntRetForm.CloseWindowWhenFocusLost := FromAnotherForm;
end;

procedure TMntRetForm.FormManagerInitializeForm;

var  IndicePeriodo : Word;

begin

     Tasa;  // Para forzar la creación de los valores por defecto

     TiposIVAFields := TTiposIVAFields.Create( TiposIVATable );

     With GridTiposIVATableCodigo do
       begin
       MinValue := rgRetenciones + 1;
       MaxValue := rgRetenciones + NroMaximoTiposTasas;
       end;

     SetColumnDecimals( GridViewIVASoportado );

     TiposIVATable.SetDefaultRangeValues( [ LowestDateTime, CodigoEspaña, rgRetenciones ] , [ HighestDateTime, CodigoEspaña, rgRetenciones ] );

     // ActualizaEstadoVentana;
end;

procedure TMntRetForm.ActualizaEstadoVentana;
begin
     // DescripcionPeriodoLabel.Caption := Tasa.DescripcionPeriodo( TiposIVAFields.FechaAplicacion.Value );
end;

procedure TMntRetForm.GridTableViewController1Delete(Sender: TObject);
begin
     If   Assigned( GridView.Controller.FocusedRecord )
     then If   not GridView.Controller.FocusedRecord.IsLast
          then Abort;
end;

procedure TMntRetForm.GridViewCtaRepercutidoPropertiesEnter(Sender: TcxCustomEdit);
begin
     With GridViewCtaRepercutido do
       If   ValueIsEmpty( EditValue )
       then EditValue := '473';
end;

procedure TMntRetForm.GridViewCtaSoportadoPropertiesEnter(Sender: TcxCustomEdit);
begin
     With GridViewCtaSoportado do
       If   ValueIsEmpty( EditValue )
       then EditValue := '4751';
end;

procedure TMntRetForm.PeriodoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     ActualizaEstadoVentana;
end;

procedure TMntRetForm.SubcuentaValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntRetForm.TiposIVATableAfterInsert(DataSet: TDataSet);
begin
     If   ShowNotification( ntQuestion, RsMsg4 )=mrYes
     then try
            OkButton.SetFocus;
            Tasa.CopiaRegistros( Tasa.UltimaFechaAplicacion( TiposIVAFields.FechaAplicacion.Value ), TiposIVAFields.FechaAplicacion.Value, rgRetenciones );
            GridView.DataController.RefreshExternalData;
          except
            TiposIVATable.Cancel;
            end;
end;

procedure TMntRetForm.TiposIVATableNewRecord(DataSet: TDataSet);
begin
     If   TiposIVAFields.CodigoPais.Value=''
     then TiposIVAFields.CodigoPais.Value := CodigoEspaña;
end;

procedure TMntRetForm.TiposIVATableSetKey(DataSet: TDataSet);
begin
     TiposIVAFields.Codigo.Value := rgRetenciones;
end;

procedure TMntRetForm.TiposIVATableUpdateState(DataSet: TDataSet);
begin
     GridTiposIVADataSource.Enabled := TiposIVATable.State<>dsSetKey;
end;

procedure TMntRetForm.SubcuentaQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, True );
end;

procedure TMntRetForm.SubcuentaEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentas( [ Sender.EditingValue ] );
end;

procedure TMntRetForm.GridTiposIVATableApplyMasterRange(DataSet: TDataSet);
begin
     If   GridTiposIVATable.Active
     then GridTiposIVATable.SetRange( [ TiposIVAFields.FechaAplicacion.Value, CodigoEspaña, rgRetenciones + 1 ],
                                      [ TiposIVAFields.FechaAplicacion.Value, CodigoEspaña, rgRetenciones + NroMaximoTiposTasas ] );
end;

procedure TMntRetForm.GridTiposIVATableCalcFields(DataSet: TDataSet);
begin
     GridTiposIVATableCodigoRetencion.Value := GridTiposIVATableCodigo.Value - rgRetenciones;
end;

procedure TMntRetForm.GridTiposIVATableNewRecord(DataSet: TDataSet);
begin
     GridTiposIVATableFechaAplicacion.Value := TiposIVAFields.FechaAplicacion.Value;
     GridTiposIVATableCodigoPais.Value := CodigoEspaña;
     GridTiposIVATableLiquidable.Value := False;  // Desg.
     GridTiposIVATableSobreTotal.Value  := False;
end;

function TMntRetForm.FormManagerGetAccessLevel: Smallint;
begin
     With DataModule00.DmUsuarioFields do
       If   ProgramNumber=pnTPV
       then Result := acCAFicheros.Value
       else Result := acLIFicheros.Value;
end;

end.
