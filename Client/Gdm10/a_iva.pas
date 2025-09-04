unit a_iva;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, Buttons, Mask, ExtCtrls, AppContainer,

  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, DB, cxDBData, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, nxdb, dxmdaset, cxMaskEdit, cxSpinEdit, cxCheckBox,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxDropDownEdit, cxIndexedComboBox, cxGroupBox, cxLookAndFeels, cxLabel,
  cxNavigator, dxDateRanges, cxCalendar, cxDataControllerConditionalFormattingRulesManagerDialog,
  dxScrollbarAnnotations,

  DataManager,
  AppForms,
  GridTableViewController,

  Gim10Fields,
  dmi_iva,

  dm_iva, dxUIAClasses;

type
  TMntIvaForm = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    ButtonPanel: TgxEditPanel;
    GridHeader: TGridTableViewPanel;
    gGridFooterPanel1: TGridTableViewPanelGroupBox;
    gGridFooterPanel2: TGridTableViewPanelGroupBox;
    Panel1: TcxGroupBox;
    TipoManualCtrl: TcxDBSpinEdit;
    TipoPortesCtrl: TcxDBSpinEdit;
    GridTableViewController: TGridTableViewController;
    MemData: TgxMemData;
    MemDataSource: TDataSource;
    MemDataTipoManual: TSmallintField;
    MemDataTipoPortes: TSmallintField;
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
    GridViewIVAREpercutido: TcxGridDBColumn;
    GridViewRERepercutido: TcxGridDBColumn;
    GridViewCtaRepercutido: TcxGridDBColumn;
    GridViewLiquidable: TcxGridDBColumn;
    GridViewSuplidos: TcxGridDBColumn;
    FechaAplicacionPanel: TcxGroupBox;
    CapLineasManualesLabel: TcxLabel;
    DescTipoManualLabel: TcxLabel;
    CapPortesLabel: TcxLabel;
    DescTipoPortes: TcxLabel;
    FechaAplicacionCtrl: TcxDBDateEdit;
    Label1: TcxLabel;
    TiposIVADataSource: TDataSource;
    TiposIVATable: TnxeTable;
    GridTiposIVATable: TnxeTable;
    GridTiposIVATableFechaAplicacion: TDateField;
    GridTiposIVATableCodigo: TSmallintField;
    GridTiposIVATableCodigoRetencion: TSmallintField;
    GridTiposIVATableDescripcion: TWideStringField;
    GridTiposIVATableIVASoportado: TBCDField;
    GridTiposIVATableCtaSoportado: TWideStringField;
    GridTiposIVATableIVAREpercutido: TBCDField;
    GridTiposIVATableRERepercutido: TBCDField;
    GridTiposIVATableCtaRepercutido: TWideStringField;
    GridTiposIVATableLiquidable: TBooleanField;
    GridTiposIVATableSobreTotal: TBooleanField;
    GridTiposIVADataSource: TDataSource;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    CodigoPaisPanel: TcxGroupBox;
    PaisCtrl: TcxDBTextEdit;
    Label8: TcxLabel;
    DescPaisLabel: TcxLabel;
    GridTiposIVATableCodigoPais: TWideStringField;
    KeyPanel: TgxEditPanel;
    TopPanel: TcxGroupBox;
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
    procedure TipoIVAValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridTableViewControllerDelete(Sender: TObject);
    procedure TiposIVATableSetKey(DataSet: TDataSet);
    procedure GridTiposIVATableApplyMasterRange(DataSet: TDataSet);
    procedure TiposIVATableGetRecord(DataSet: TDataSet);
    procedure TiposIVATableBeforePost(DataSet: TDataSet);
    procedure TiposIVATableUpdateState(DataSet: TDataSet);
    procedure TiposIVATableBeforeDelete(DataSet: TDataSet);
    procedure PaisCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure PaisCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure PaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure TiposIVATableAfterInsert(DataSet: TDataSet);
    procedure GridTiposIVATableBeforeDelete(DataSet: TDataSet);
    procedure TiposIVATableNewRecord(DataSet: TDataSet);
    procedure DataPanelEnter(Sender: TObject);
  private

    TablaTiposVacia : Boolean;

    procedure ActualizaTiposGlobales;
  public

	  TiposIVAFields : TTiposIVAFields;

  end;

var MntIvaForm: TMntIvaForm;

procedure MntTiposIVA( FromAnotherForm : boolean );

implementation

{$R *.DFM}

uses   LibUtils,
       DateUtils,

       AppManager,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm10Frm,

       dmi_pga,

       dm_pai,
       dm_prv,
       dm_pga,
       dm_sub,

       a_pai,
       a_prv,
       a_sub,

       b_msg,

       cx_pai,
       cx_prv,
       cx_sub;

resourceString
      RsMsg1 = 'Suplidos y otras cantidades que no deben ser incluidas en la declaración anual de operaciones con terceras personas (Modelo 347)';
      RsMsg2 = 'Debe suprimir las líneas de forma ordenada.';
      RsMsg3 = 'En la tabla de tipos de I.V.A. no pueden existir huecos entre tipos definidos.'#13'Suprima los registros empezando por el último de la lista.';
      RsMsg4 = '¿Desea copiar los registros de la última fecha de aplicación?';

procedure MntTiposIVA( FromAnotherForm : Boolean );
begin
     CreateEditForm( TMntIVAForm, MntIvaForm, [], TGds10Frm.LibrosIVASection );
     If   Assigned( MntIvaForm )
     then MntIvaForm.CloseWindowWhenFocusLost := FromAnotherForm;
end;

procedure TMntIvaForm.FormManagerInitializeForm;

var  CodigoPaisInicial,
     CodigoPaisFinal : String;

begin

     TiposIVAFields := TTiposIVAFields.Create( TiposIVATable );

     MemData.Open;
     MemData.Append;

     TipoPortesCtrl.Enabled := ProgramNumber>pnContable;

     SetColumnsDecimals( [ GridViewIVASoportado, GridViewIVAREpercutido ] );
     SetColumnDecimals( GridViewRERepercutido, 3 );

     //** Está también indicado en el componente, pero si se regenera la lista de campos se pierde y siempre se me olvida

     With GridTiposIVATableCodigo do
       begin
       MinValue := rgTiposIVA + 1;
       MaxValue := rgTiposIVA + NroMaximoTiposTasas;
       end;

       With DataModule00.DmEmpresaFields do
         SetupPanelableCtrl( PaisCtrl, Contable_VentasOnlineIntracomunitarias.Value, { AdjustFormHeight } True, KeyPanel );

     var CodigoInicial := CodigoEspaña;
     var CodigoFinal := CodigoEspaña;

     If   DataModule00.DmEmpresaFields.Contable_VentasOnlineIntracomunitarias.Value
     then begin
          CodigoInicial := '';
          CodigoFinal := HighStrCode;
          end;

     TiposIVATable.SetDefaultRangeValues( [ LowestDateTime, CodigoInicial, rgTiposIVA ] , [ HighestDateTime, CodigoFinal, rgTiposIVA ] );

end;


procedure TMntIvaForm.GridTableViewControllerDelete(Sender: TObject);
begin
     If   Assigned( GridView.Controller.FocusedRecord )
     then If   not GridView.Controller.FocusedRecord.IsLast
          then begin
               ShowNotification( ntStop, RsMsg2, RsMsg3 );
               Abort;
               end;
end;

procedure TMntIvaForm.GridViewCtaRepercutidoPropertiesEnter(Sender: TcxCustomEdit);
begin
     With GridViewCtaRepercutido do
       If   ValueIsEmpty( EditValue )
       then EditValue := '477';
end;

procedure TMntIvaForm.GridViewCtaSoportadoPropertiesEnter(Sender: TcxCustomEdit);
begin
     With GridViewCtaSoportado do
       If   ValueIsEmpty( EditValue )
       then EditValue := '472';
end;

procedure TMntIvaForm.PaisCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntPaises( [ Sender.EditingValue ] );
end;

procedure TMntIvaForm.PaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaPaises( Sender );
end;

procedure TMntIvaForm.PaisCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Pais.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntIvaForm.SubcuentaValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntIvaForm.SubcuentaQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, True );
end;

procedure TMntIvaForm.SubcuentaEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentas( [ Sender.EditingValue ] );
end;

procedure TMntIvaForm.TipoIVAValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then Sender.ClearDescription
     else Tasa.ValidaTasa( Sender, DisplayValue, ErrorText, Error, siAmbos, TiposIVAFields.FechaAplicacion.Value, TiposIVAFields.CodigoPais.Value );
end;

procedure TMntIvaForm.TiposIVATableAfterInsert(DataSet: TDataSet);
begin
     If   ( TiposIVAFields.FechaAplicacion.Value<>0 ) and
          ( ShowNotification( ntQuestion, RsMsg4 )=mrYes )
     then try

            OkButton.SetFocus;

            TablaTiposVacia := not Tasa.CopiaRegistros( Tasa.UltimaFechaAplicacion( TiposIVAFields.FechaAplicacion.Value ),
                                                        TiposIVAFields.FechaAplicacion.Value,
                                                        rgTiposIVA,
                                                        TiposIVAFields.CodigoPais.Value );

          except
            TiposIVATable.Cancel;
            end;

end;

procedure TMntIvaForm.TiposIVATableBeforeDelete(DataSet: TDataSet);
begin
     Tasa.SuprimeTipoIVAGlobal( TiposIVAFields.FechaAplicacion.Value, TiposIVAFields.CodigoPais.Value, rgTipoIVAManual );
     Tasa.SuprimeTipoIVAGlobal( TiposIVAFields.FechaAplicacion.Value, TiposIVAFields.CodigoPais.Value, rgTipoIVAPortes );
end;

procedure TMntIvaForm.TiposIVATableBeforePost(DataSet: TDataSet);
begin
     If   TiposIVATable.State<>dsInsert
     then ActualizaTiposGlobales;
end;

procedure TMntIvaForm.ActualizaTiposGlobales;
begin
     Tasa.GuardaTipoIVAGlobal( TiposIVAFields.FechaAplicacion.Value, TiposIVAFields.CodigoPais.Value, rgTipoIVAManual, MemDataTipoManual.Value );
     Tasa.GuardaTipoIVAGlobal( TiposIVAFields.FechaAplicacion.Value, TiposIVAFields.CodigoPais.Value, rgTipoIVAPortes, MemDataTipoPortes.Value );
     MemData.Modified := False;
end;

procedure TMntIvaForm.TiposIVATableGetRecord(DataSet: TDataSet);
begin
     MemData.DisableControls;
     try

       // Si no existe ningún tipo de I.V.A. asignar por defecto el valor 1 para el tipo manual y los portes
       // provoca que no se pueda salir de los campos sin limpiar los valores

       If   TablaTiposVacia
       then begin
            MemDataTipoManual.Clear;
            MemDataTipoPortes.Clear;
            end
       else begin
            MemDataTipoManual.Value := Tasa.TipoIVAGlobal( TiposIVAFields.FechaAplicacion.Value, TiposIVAFields.CodigoPais.Value, rgTipoIVAManual );
            MemDataTipoPortes.Value := Tasa.TipoIVAGlobal( TiposIVAFields.FechaAplicacion.Value, TiposIVAFields.CodigoPais.Value, rgTipoIVAPortes );
            end;

     finally
       MemData.EnableControls;
       MemData.Modified := False;
       end;
end;

procedure TMntIvaForm.TiposIVATableNewRecord(DataSet: TDataSet);
begin
     If   TiposIVAFields.CodigoPais.Value=''
     then TiposIVAFields.CodigoPais.Value := CodigoEspaña;
end;

procedure TMntIvaForm.TiposIVATableSetKey(DataSet: TDataSet);
begin
     TiposIVAFields.Codigo.Value := rgTiposIVA;
     With MemData do
       begin
       Edit;
       ClearFields;
       end;
     FormManager.ValidateDataArea( faData, False );
end;

procedure TMntIvaForm.TiposIVATableUpdateState(DataSet: TDataSet);
begin
     GridTiposIVADataSource.Enabled := TiposIVATable.State<>dsSetKey;
end;

procedure TMntIvaForm.GridTiposIVATableApplyMasterRange(DataSet: TDataSet);
begin
     If   GridTiposIVATable.Active
     then GridTiposIVATable.SetRange( [ TiposIVAFields.FechaAplicacion.Value, TiposIVAFields.CodigoPais.Value, rgTiposIVA + 1 ],
                                      [ TiposIVAFields.FechaAplicacion.Value, TiposIVAFields.CodigoPais.Value, rgTiposIVA + NroMaximoTiposTasas ] );
end;

procedure TMntIvaForm.GridTiposIVATableBeforeDelete(DataSet: TDataSet);
begin
     If   GridTiposIVATableCodigo.Value=MemDataTipoManual.Value
     then MemDataTipoManual.Value := 1;
     If   GridTiposIVATableCodigo.Value=MemDataTipoPortes.Value
     then MemDataTipoPortes.Value := 1;
     If   MemData.Modified
     then begin
          ValidateEditControls( [ TipoManualCtrl, TipoPortesCtrl ] );
          ActualizaTiposGlobales;
          end;
end;

procedure TMntIvaForm.GridTiposIVATableNewRecord(DataSet: TDataSet);
begin
     GridTiposIVATableFechaAplicacion.Value := TiposIVAFields.FechaAplicacion.Value;
     GridTiposIVATableCodigoPais.Value := TiposIVAFields.CodigoPais.Value;
     GridTiposIVATableLiquidable.Value := True;
end;

procedure TMntIvaForm.DataPanelEnter(Sender: TObject);
begin
     If   TablaTiposVacia
     then begin
          TablaTiposVacia := False;
          Grid.SetFocus;
          end;
end;

function TMntIvaForm.FormManagerGetAccessLevel: Smallint;
begin
     With DataModule00.DmUsuarioFields do
       If   ProgramNumber=pnTPV
       then Result := acCAFicheros.Value
       else Result := acLIFicheros.Value;
end;

end.
