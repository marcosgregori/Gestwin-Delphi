unit a_tip;

interface

uses StdCtrls, Buttons, Mask, Controls,
  Classes, ExtCtrls, Forms, Tabs,

  AppContainer,

  ComCtrls,
  Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, dxmdaset, cxCurrencyEdit,

  cxCheckBox, cxPC, cxLookAndFeels, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLabel, cxGroupBox, cxNavigator, dxDateRanges,
  AppForms, GridTableViewController, dxScrollbarAnnotations,

  Gim30Fields, cxIntegerEdit, dxUIAClasses;

type
  TMntTipForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    TiposIVAArticuloPaisTable: TnxeTable;
    ArticuloTable: TnxeTable;
    ArticuloDataSource: TDataSource;
    TiposIVAArticuloPaisCachedDataSet: TnxeCachedDataSet;
    TiposIVAArticuloPaisDataSource: TDataSource;
    TiposIVAArticuloPaisQuery: TnxeQuery;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TableViewManager: TGridTableViewController;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    CodigoArticuloCtrl: TcxDBTextEdit;
    Label4: TcxLabel;
    Label3: TcxLabel;
    ArticuloTableCodigo: TWideStringField;
    ArticuloTableDescripcion: TWideStringField;
    TiposIVAArticuloPaisCachedDataSetCodigoPais: TWideStringField;
    TiposIVAArticuloPaisCachedDataSetNombre: TWideStringField;
    TiposIVAArticuloPaisCachedDataSetTipoIVA: TSmallintField;
    GridViewCodigoPais: TcxGridDBColumn;
    GridViewNombre: TcxGridDBColumn;
    GridViewTipoIVA: TcxGridDBColumn;
    TiposIVAArticuloPaisCachedDataSetDescripcion: TWideStringField;
    GridViewDescripcion: TcxGridDBColumn;
    procedure FormManagerInitializeForm;
    procedure TiposIVAArticuloPaisCachedDataSetBeforeEdit(
      DataSet: TDataSet);
    procedure TiposIVAArticuloPaisCachedDataSetBeforePost(
      DataSet: TDataSet);
    procedure ArticuloTableGetRecord(DataSet: TDataSet);
    procedure ArticuloTableRecordChanged(DataSet: TDataSet);
    procedure CodigoArticuloCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewTipoIVAPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure GridViewTipoIVAPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GridViewTipoIVAPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TiposIVAArticuloPaisCachedDataSetCalcFields(
      DataSet: TDataSet);
  private

    FTiposIVATableChanged : Boolean;

  public

    TiposIVAArticuloPaisFields : TTiposIVAArticuloPaisFields;

    ExisteTipoIVA : Boolean;

    procedure UpdateQuery;

  end;

var
  MntTipForm: TMntTipForm = nil;

procedure MntTiposIVAArticuloPais( KeyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,
       LibUtils,

       AppManager,
       Variants,

       Gdm00Dm,
       Gim00Fields,
       Gdm30Frm,

       dmi_iva,

       b_msg,

       dm_iva,
       dm_art,

       a_iva,
       a_art,

       cx_iva,
       cx_art;

procedure MntTiposIVAArticuloPais( KeyValues : array of const );
begin
     CreateEditForm( TMntTipForm, MntTipForm, KeyValues, TGds30Frm.AlmacenSection );
end;

procedure TMntTipForm.FormManagerInitializeForm;
begin
     TiposIVAArticuloPaisFields := TTiposIVAArticuloPaisFields.Create( TiposIVAArticuloPaisTable );
end;

procedure TMntTipForm.GridViewTipoIVAPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTiposIVA( { FromAnotherForm } True );
end;

procedure TMntTipForm.GridViewTipoIVAPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTiposIVA( Sender, siAmbos, ApplicationContainer.TodayDate, TiposIVAArticuloPaisCachedDataSetCodigoPais.Value );
end;

procedure TMntTipForm.GridViewTipoIVAPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Tasa.ValidaTasa( Sender, DisplayValue, ErrorText, Error, siAmbos, ApplicationContainer.TodayDate, TiposIVAArticuloPaisCachedDataSetCodigoPais.Value );
end;

procedure TMntTipForm.ArticuloTableGetRecord(DataSet: TDataSet);
begin
     FTiposIVATableChanged := True;
end;

procedure TMntTipForm.ArticuloTableRecordChanged(DataSet: TDataSet);
begin
     FTiposIVATableChanged := True;
     UpdateQuery;
end;

procedure TMntTipForm.TiposIVAArticuloPaisCachedDataSetBeforeEdit(DataSet: TDataSet);
begin
     ExisteTipoIVA := TiposIVAArticuloPaisTable.FindKey( [ ArticuloTableCodigo.Value, TiposIVAArticuloPaisCachedDataSetCodigoPais.Value ] );
end;

procedure TMntTipForm.TiposIVAArticuloPaisCachedDataSetBeforePost(DataSet: TDataSet);
begin
     If   ValueIsEmpty( TiposIVAArticuloPaisCachedDataSetTipoIVA.Value )
     then begin
          If   ExisteTipoIVA
          then TiposIVAArticuloPaisTable.Delete;
          end
     else With TiposIVAArticuloPaisFields do
            begin

            With TiposIVAArticuloPaisTable do
              If   ExisteTipoIVA
              then Edit
              else Append;

            CodigoArticulo.Value := ArticuloTableCodigo.Value;
            CodigoPais.Value := TiposIVAArticuloPaisCachedDataSetCodigoPais.Value;
            TipoIVA.Value := TiposIVAArticuloPaisCachedDataSetTipoIVA.Value;

            TiposIVAArticuloPaisTable.Post;
            end;

end;

procedure TMntTipForm.TiposIVAArticuloPaisCachedDataSetCalcFields(DataSet: TDataSet);
begin
     If   TiposIVAArticuloPaisCachedDataSetTipoIVA.Value<>0
     then TiposIVAArticuloPaisCachedDataSetDescripcion.Value := Tasa.DescripcionTasa( fsiAmbos, TiposIVAArticuloPaisCachedDataSetCodigoPais.Value, TiposIVAArticuloPaisCachedDataSetTipoIVA.Value );
end;

procedure TMntTipForm.CodigoArticuloCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntArticulos( [ Sender.EditingValue ] );
end;

procedure TMntTipForm.CodigoArticuloCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scVentas, False, Sender );
end;

procedure TMntTipForm.CodigoArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean );
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTipForm.UpdateQuery;

var   DataSourceEnabled : Boolean;

begin
     With TiposIVAArticuloPaisCachedDataSet do
       If   FormManager.FormInitialized
       then begin
            DataSourceEnabled := ArticuloTable.State in [ dsBrowse, dsEdit ];
            If   DataSourceEnabled
            then begin
                 If   FTiposIVATableChanged
                 then begin
                      Close;
                      With TiposIVAArticuloPaisQuery do
                        Params.ParamByName( 'CodigoArticulo' ).Value := ArticuloTableCodigo.Value;
                      Open;
                      FTiposIVATableChanged := False;
                      TiposIVAArticuloPaisDataSource.Enabled := True;
                      end;
                 end
            else TiposIVAArticuloPaisDataSource.Enabled := False;
            end;
end;

end.

