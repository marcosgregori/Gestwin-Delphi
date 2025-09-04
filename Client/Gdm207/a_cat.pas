unit a_cat;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,
  DB,
  nxdb,

  DataManager, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  Graphics, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxMaskEdit, cxEditRepositoryItems, Menus,
  cxLookAndFeelPainters, cxButtons, cxSpinEdit, dxSkinsCore,
  cxLookAndFeels, dxSkinsDefaultPainters, cxLabel, cxGroupBox,
  cxDropDownEdit, cxIndexedComboBox, cxMemo,

  Gim207Fields,
  cxCheckBox,
  Spring;

type
  TMntCatForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    dataPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    CategoriaTable: TnxeTable;
    DataSource: TDataSource;
    NombreCtrl: TcxDBTextEdit;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    cxLabel2: TcxLabel;
    DescSuperiorLabel: TcxLabel;
    cxDBCheckBox1: TcxDBCheckBox;
    CodigoCtrl: TcxDBTextEdit;
    CodigoPadreCtrl: TcxDBTextEdit;
    CategoriaAuxTable: TnxeTable;
    procedure CodigoQueryRequest(Sender: TcxCustomEdit);
    procedure FormManagerReportRequest;
    procedure CodigoPadreQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoPadreValidate(Sender: TcxCustomEdit;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerInitializeForm;
    procedure CategoriaTableBeforePost(DataSet: TDataSet);
    procedure CategoriaTableNewRecord(DataSet: TDataSet);
    procedure CodigoFamiliaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure CodigoFamiliaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoFamiliaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
  private
    FOnCategoriaBeforePost : Event<TDataSetNotifyEvent>;
  public
    CategoriaFields,
    CategoriaAuxFields : TCategoriaFields;
    property OnCategoriaBeforePost : Event<TDataSetNotifyEvent> read FOnCategoriaBeforePost write FOnCategoriaBeforePost;
  end;

var  MntCatForm: TMntCatForm = nil;

procedure MntCategorias( KeyValues : array of const );

implementation

{$R *.DFM}

uses   Windows,
       Variants,
       SysUtils,
       LibUtils,
       EnterpriseDataAccess,

       Gim30Fields,
       Gdm30Frm,

       dm_cat,
       dm_fam,

       a_fam,

       cx_cat,
       cx_fam,

       l_cat;

resourceString
       RsMsg1  = 'Una categoría no puede descender de sí misma o tener un nivel superior al de su categoría padre.';
       RsMsg2  = '<Ninguna>';
       RsMsg3  = 'Esta familia ya ha sido asignada a la categoría %s, %s.';

procedure MntCategorias( keyValues : array of const );
begin
     CreateEditForm( TMntCatForm, MntCatForm, KeyValues, TGds30Frm.AlmacenSection );
end;

procedure TMntCatForm.FormManagerInitializeForm;
begin
     ID := idMntCatForm;
     CategoriaFields := TCategoriaFields.Create( CategoriaTable );
     CategoriaAuxFields := TCategoriaFields.Create( CategoriaAuxTable );
     CodigoCtrl.Properties.ValidChars := CleanCodeCharSet;
end;

procedure TMntCatForm.FormManagerReportRequest;
begin
     ListadoCategorias;
end;

procedure TMntCatForm.CategoriaTableNewRecord(DataSet: TDataSet);
begin
     CategoriaFields.Activo.Value := True;
end;

procedure TMntCatForm.CodigoFamiliaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntFamilias( [ Sender.EditingValue ] );
end;

procedure TMntCatForm.CodigoFamiliaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFamilias( Sender );
end;

procedure TMntCatForm.CodigoFamiliaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then Sender.Description := RsMsg2
     else begin
          Familia.Valida( Sender, DisplayValue, ErrorText, Error );
          If   not Error
          then begin
               var CodigoFamilia := VarToStr( DisplayValue );
               If   CategoriaAuxTable.FindEqualFirst( [ CodigoFamilia ] )
               then If   CategoriaAuxFields.Codigo.Value<>CategoriaFields.Codigo.Value
                    then begin
                         Error := True;
                         ErrorText := Format( RsMsg3, [ CategoriaAuxFields.Codigo.Value, CategoriaAuxFields.Nombre.Value ] );
                         end;
               end;
          end;
end;

procedure TMntCatForm.CodigoPadreQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCategorias( Sender );
end;

procedure TMntCatForm.CodigoPadreValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  NivelCategoria,
     NivelPadre : SmallInt;

begin
     If   ValueIsEmpty( DisplayValue )
     then CodigoPadreCtrl.Description := RsMsg2
     else begin
          NivelPadre := Categoria.Nivel( DisplayValue );
          NivelCategoria := Categoria.Nivel( CategoriaFields.Codigo.Value );
          If   ( DisplayValue=CategoriaFields.Codigo.Value ) or
               ( ( NivelCategoria>0 ) and ( NivelPadre>NivelCategoria ) )
          then begin
               Error := True;
               ErrorText := RsMsg1;
               end
          else Categoria.Valida( Sender, DisplayValue, ErrorText, Error );
          end;
end;

procedure TMntCatForm.CategoriaTableBeforePost(DataSet: TDataSet);
begin
     FOnCategoriaBeforePost.Invoke( Dataset );
end;

procedure TMntCatForm.CodigoQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCategorias( Sender, qgsLinked );
end;

end.

