unit f_fpv105;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppContainer, StdCtrls, ExtCtrls, Menus, DB,

  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxLookAndFeelPainters,
  cxButtons, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, nxdb, cxCurrencyEdit,

  Gdm105Dm, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter, cxGroupBox, cxLookAndFeels,
  cxNavigator, dxDateRanges, cxDataControllerConditionalFormattingRulesManagerDialog, dxScrollbarAnnotations,

  GridTableViewController,

  AppForms,
  DataManager;

type
  TFpvFrame = class(TFrame)
    BackPanel: TcxGroupBox;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TableViewManager: TGridTableViewController;
    VendedoresData: TDataSource;
    GridViewCodigoVendedor: TcxGridDBColumn;
    GridViewNombre: TcxGridDBColumn;
    GridViewComision: TcxGridDBColumn;
    VendedoresFacturaTable: TnxeTable;
    VendedoresFacturaTableEjercicio: TSmallintField;
    VendedoresFacturaTableSerie: TWideStringField;
    VendedoresFacturaTableNroFactura: TIntegerField;
    VendedoresFacturaTableNroRegistro: TSmallintField;
    VendedoresFacturaTableCodigoVendedor: TWideStringField;
    VendedoresFacturaTableNombre: TWideStringField;
    GridViewImporteBase: TcxGridDBColumn;
    VendedoresFacturaTableImporte: TBCDField;
    GridViewImporte: TcxGridDBColumn;
    VendedoresFacturaTableImporteBase: TBCDField;
    VendedoresFacturaTableComision: TBCDField;
    procedure GridViewCodigoVendedorPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCodigoVendedorPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCodigoVendedorPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure VendedoresFacturaTableCalcFields(DataSet: TDataSet);
    procedure VendedoresFacturaTableAfterOpen(DataSet: TDataSet);
    procedure VendedoresFacturaTableAfterInsert(DataSet: TDataSet);
  private
    VendedoresFacturaFields : TVendedoresFacturaFields;
  public

  end;

var FpvFrame : TFpvFrame = nil;

implementation

uses EnterpriseDataAccess,
     AppManager,

     Gim30Fields,
     Gdm30Frm,

     dm_ven,
     dm_fdv,

     cx_ven,

     a_ven,
     a_fdv;

{$R *.dfm}

resourceString
     rsMsg1 = 'Vendedores';

procedure SetupMntFdvForm;

var Df : Integer;

begin
     If   Assigned( MntFdvForm )
     then With MntFdvForm do
            begin

            // Ocultando los componentes existentes

            Codigo_VendedorCtrl.Visible := False;
            ComisionCaptionLabel.Visible := False;
            TipoComisionCtrl.Visible := False;
            PorcentajeComisionLabel.Visible := False;
            ImporteComisionBox.Visible := False;

            VendedorCaptionLabel.Caption := RsMsg1;

            FpvFrame := TFpvFrame.Create( MntFdvForm );

            With FpvFrame do
              begin

              SetColumnDecimals( GridViewComision, 2 );
              SetColumnsDecimals( [ GridViewImporteBase, GridViewImporte ] );

              With VendedoresFacturaTable do
                begin
                MasterSource := FacturaVentasDataSource;
                MasterFields := 'Ejercicio;Serie;NroFactura';
                // Open;
                end;

              FpvFrame.BackPanel.Parent := VendedorPanel;

              end;

            TopPanel.Height := FpvFrame.Height;

            PlaceForm( MntFdvForm );
            end;
end;

procedure TFpvFrame.GridViewCodigoVendedorPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntVendedores( [ Sender.EditingValue ] );
end;

procedure TFpvFrame.GridViewCodigoVendedorPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender );
end;

procedure TFpvFrame.GridViewCodigoVendedorPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Vendedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TFpvFrame.VendedoresFacturaTableAfterInsert(DataSet: TDataSet);
begin
     With MntFdvForm.FacturaVentasFields do     
       VendedoresFacturaTableImporteBase.Value := NetoFactura.Value - DescuentosClientes.Value;
end;

procedure TFpvFrame.VendedoresFacturaTableAfterOpen(DataSet: TDataSet);
begin
     VendedoresFacturaFields := TVendedoresFacturaFields.Create( VendedoresFacturaTable );
end;

procedure TFpvFrame.VendedoresFacturaTableCalcFields(DataSet: TDataSet);
begin
     If   not ValueIsEmpty( VendedoresFacturaTableCodigoVendedor.Value )
     then VendedoresFacturaTableNombre.Value := Vendedor.Descripcion( VendedoresFacturaTableCodigoVendedor.Value, False );
     VendedoresFacturaTableImporte.Value := ( VendedoresFacturaTableImporteBase.Value * VendedoresFacturaTableComision.Value ) / 100.0;
end;

initialization
   AddProcedure( imOnCreateComponent, idMntFdvForm, SetupMntFdvForm );

end.
