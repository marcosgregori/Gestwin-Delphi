unit f_cpv105;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppContainer, StdCtrls, ExtCtrls,

  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,

  Menus,
  cxLookAndFeelPainters,
  cxButtons,

  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  nxdb, DataManager, cxCurrencyEdit, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxGroupBox, cxLookAndFeels,
  cxNavigator, dxDateRanges,

  AppForms,
  GridTableViewController,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  dxScrollbarAnnotations, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinFoggy, GestwinWhiteSkin, dxSkinPumpkin, dxSkinSeven,
  dxSkinSpringTime, dxSkinSummer2008, dxSkinValentine, dxSkinXmas2008Blue, GestwinSkin,
  dxUIAClasses;

type
  TCpvFrame = class(TFrame)
    BackPanel: TcxGroupBox;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TableViewManager: TGridTableViewController;
    VendedoresData: TDataSource;
    GridViewCodigoVendedor: TcxGridDBColumn;
    GridViewNombre: TcxGridDBColumn;
    GridViewComision: TcxGridDBColumn;
    VendedoresClienteTable: TnxeTable;
    VendedoresClienteTableCodigoCliente: TWideStringField;
    VendedoresClienteTableNroRegistro: TSmallintField;
    VendedoresClienteTableCodigoVendedor: TWideStringField;
    VendedoresClienteTableNombre: TWideStringField;
    VendedoresClienteTableComision: TBCDField;
    procedure GridViewCodigoVendedorPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCodigoVendedorPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCodigoVendedorPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure VendedoresClienteTableCalcFields(DataSet: TDataSet);
  private

  protected
  class procedure ImpresionOrdenesFabricacion( Sender : TObject );
  public

  end;

implementation

uses dxBar,

     EnterpriseDataAccess,
     AppManager,

     Gdm30Dm,
     Gdm30Frm,
     Gim30Fields,

     dmi_mov,

     dm_ven,
     dm_mov,

     cx_ven,

     a_ven,
     a_cli,
     r_mov,

     f_cli;

{$R *.dfm}

resourceString
     RsMsg1 = 'Vendedores';
     RsMsg2 = 'Impresión de órdenes de fabricación';

procedure SetupMenu;
begin
     If   Assigned( Gds30Frm )
     then With Gds30Frm do
            begin
            ImpresionOrdenesFabricacionItem.Visible := ivAlways;
            ImpresionOrdenesFabricacionItem.OnClick := TCpvFrame.ImpresionOrdenesFabricacion;
            end;
end;

procedure SetupMntCliFrame;

const PanelHeight = 104;

var   CpvFrame : TCpvFrame;
      Vh : Integer;

begin
     If   Assigned( MntCliFrame )
     then With MntCliFrame do
            begin

            VendedorCtrl.Enabled := False;
            VendedorCtrl.Visible := False;
            DescVendedorLabel.Visible := False;
            VendedorCaptionLabel.Caption := RsMsg1;

            CpvFrame := TCpvFrame.Create( MntCliForm );

            With CpvFrame do
              begin
              SetColumnDecimals( GridViewComision, 2 );
              With VendedoresClienteTable do
                begin
                MasterSource := MntCliForm.ClienteDataSource;
                // Open;
                end;
              end;

            Vh := PanelHeight - VendedorPanel.Height;
            VendedorPanel.Height := ScaledToCurrent( PanelHeight + 4 );

            With CpvFrame.BackPanel do
              begin
              Left := ScaledToCurrent( 140 );
              Top := 0;
              Height := ScaledToCurrent( PanelHeight );
              Parent := VendedorPanel;
              end;

            // CpvFrame.Parent := VendedorPanel;

            With MntCliForm do
              begin
              // PageControl.Constraints.MinHeight := ScaledToCurrent( 385 );
              Height := ScaledToCurrent( Height + Vh + 8 );
              end;

            end;
end;

class procedure TCpvFrame.ImpresionOrdenesFabricacion( Sender : TObject );
begin
     ImpresionMovimientos( True, tmPedidoVenta );
     If   Assigned( RptMovForm )
     then With RptMovForm do
            begin
            Caption := RsMsg2;
            FormatoCtrl.Enabled := False;
            Report.FileName := 'dm105\i_ofb';
            Report.OnSetReportName := nil;
            end;
end;

procedure TCpvFrame.GridViewCodigoVendedorPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntVendedores( [ Sender.EditingValue ] );
end;

procedure TCpvFrame.GridViewCodigoVendedorPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender );
end;

procedure TCpvFrame.GridViewCodigoVendedorPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Vendedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TCpvFrame.VendedoresClienteTableCalcFields(DataSet: TDataSet);
begin
     If   not ValueIsEmpty( VendedoresClienteTableCodigoVendedor.Value )
     then VendedoresClienteTableNombre.Value := Vendedor.Descripcion( VendedoresClienteTableCodigoVendedor.Value, False );
end;

initialization

   AddProcedure( imOnEnterpriseAccess, 0, SetupMenu );

   AddProcedure( imOnCreateComponent, idMntCliFrame, SetupMntCliFrame );

end.

