unit b_ddb;

interface

uses StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics, Generics.Collections,

     cxStyles,
     cxCustomData,
     cxGraphics,
     cxFilter,
     cxData,
     cxDataStorage,
     cxEdit,
     DB,
     cxDBData,
     nxdb,
     DataManager,
     EnterpriseDataAccess,
     cxGridLevel,
     cxClasses,
     cxControls,
     cxGridCustomView,
     cxGridBandedTableView,
     cxGridDBBandedTableView,
     cxGrid, DBCtrls, Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox,

     cxRichEdit, cxContainer, cxDBEdit, dxmdaset, dxSkinsCore, dxSkinsDefaultPainters,
     dxSkinscxPCPainter, cxLookAndFeels, cxLabel, cxGroupBox, cxDBLabel, cxNavigator,
     dxBevel, dxDateRanges, dxScrollbarAnnotations, cxGridCustomTableView, cxGridTableView,
     cxTextEdit, cxCurrencyEdit, dxSVGImage, cxImage, dxGDIPlusClasses,
     cxCheckComboBox, cxGridDBTableView, System.ImageList, Vcl.ImgList, cxImageList, dxUIAClasses,

     AppContainer,
     AppForms,
     GridTableViewController,

     Gim10Fields,
     Gim30Fields,
     Gim105Fields,

     dmi_mov,

     dm_mov;

type

  TcxCheckBoxsArray = Array of TcxCheckBox;
  TcxCustomCurrencyEditArray = Array of TcxCustomCurrencyEdit;

  TBoxDdbForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DesgloseBultosLineaTable: TnxeTable;
    DesgloseBultosLineaDataSource: TDataSource;
    DataPanel: TgxEditPanel;
    Label10: TcxLabel;
    ArticuloLabel: TcxLabel;
    DescripcionArticuloLabel: TcxLabel;
    TopPanel: TcxGroupBox;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    GridViewNroBulto: TcxGridDBColumn;
    GridViewMetrosBrutos: TcxGridDBColumn;
    GridViewMetrosNetos: TcxGridDBColumn;
    GridViewPesoBruto: TcxGridDBColumn;
    GridViewPesoNeto: TcxGridDBColumn;
    TableViewManager: TGridTableViewController;
    DesgloseBultosLineaTableEjercicio: TSmallintField;
    DesgloseBultosLineaTableNroOperacion: TIntegerField;
    DesgloseBultosLineaTableNroBulto: TSmallintField;
    DesgloseBultosLineaTableNroRegistroLinea: TIntegerField;
    DesgloseBultosLineaTableMetrosBrutos: TBCDField;
    DesgloseBultosLineaTableMetrosNetos: TBCDField;
    DesgloseBultosLineaTablePesoBruto: TBCDField;
    DesgloseBultosLineaTablePesoNeto: TBCDField;
    DesgloseBultosLineaTableBancada: TWideStringField;
    GridViewBarcada: TcxGridDBColumn;
    procedure FormManagerCreateForm;
    procedure FormManagerDestroyForm;
    procedure FormManagerOkButton;
    procedure FormManagerPreparedForm;
    procedure DesgloseBultosLineaTableNewRecord(DataSet: TDataSet);
  private

    DesgloseBultosLineaFields : TDesgloseBultosLineaFields;

  protected

  class var LineaMovimientoFields : TLineaMovimientoFields;

  public
  class procedure EditaDesgloseBultosLinea( Sender : TObject );

  end;

var BoxDdbForm: TBoxDdbForm = nil;

implementation

{$R *.DFM}

uses   Variants,
       Math,

       SysUtils,
       LibUtils,
       AppManager,

       Gdm00Dm,
       Gim00Fields,

       dm_cli,
       dm_art,

       a_mve,
       e_mov,

       b_msg;

{
resourceString
       RsMsg1 = 'Ha hecho modificaciones en la valoración';
       RsMsg2 = '¿Está seguro de que desea cancelar la edición del registro?';
}

class procedure TBoxDdbForm.EditaDesgloseBultosLinea( Sender : TObject );
begin
     TBoxDdbForm.LineaMovimientoFields := MntMveForm[ tmVenta ].LineaMovimientoFields;

     CreateEditForm( TBoxDdbForm, BoxDdbForm );
end;

procedure TBoxDdbForm.DesgloseBultosLineaTableNewRecord(DataSet: TDataSet);
begin
     With DesgloseBultosLineaFields do
       begin
       Ejercicio.value := LineaMovimientoFields.Ejercicio.Value;
       NroOperacion.Value := LineaMovimientoFields.NroOperacion.Value;
       NroRegistroLinea.Value := LineaMovimientoFields.NroRegistro.Value;
       end;
end;


procedure TBoxDdbForm.FormManagerCreateForm;
begin

     Grid.Hint := SeleccioneLasLineasHintMsg;

     DesgloseBultosLineaFields := TDesgloseBultosLineaFields.Create( DesgloseBultosLineaTable );

     With DataModule00.DmEmpresaFields do
       begin
       SetColumnsDecimals( [ GridViewMetrosBrutos, GridViewMetrosNetos ], Ventas_DecCantidad.Value );
       SetColumnsDecimals( [ GridViewPesoBruto, GridViewPesoNeto ], 2 );
       end;

     SetFieldRange( DesgloseBultosLineaTableNroBulto );

     With LineaMovimientoFields do
       begin
       DesgloseBultosLineaTable.SetRange( [ NroRegistro.Value ] );
       ArticuloLabel.Caption := CodigoArticulo.Value;
       DescripcionArticuloLabel.Caption := Descripcion.Value;
       end;

end;

procedure TBoxDdbForm.FormManagerDestroyForm;
begin
     DesgloseBultosLineaTable.Cancel;
end;

procedure TBoxDdbForm.FormManagerOkButton;
begin
     //..
end;

procedure TBoxDdbForm.FormManagerPreparedForm;
begin
     //..
end;


end.
