unit b_cds119;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes, Windows, ExtCtrls,
  Graphics, ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox, cxDBEdit,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxHeader, DB, dxmdaset,
  Grids, dxSkinsCore, cxGraphics, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox, cxStyles,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, cxDBLabel,

  LibUtils,
  AppForms,
  AppContainer,
  DataManager,
  nxdb,

  Gim30Fields;

type
  TBoxCds119Form = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoArticuloCtrl: TcxDBTextEdit;
    DataPanel: TgxEditPanel;
    Data: TgxMemData;
    DataCodigoArticulo: TWideStringField;
    DataSource: TDataSource;
    AlmacenTable: TnxeTable;
    codigoCtrlCaption: TcxLabel;
    DescArticuloLabel: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    GridData: TgxMemData;
    GridDataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    GridDataIdAlmacen: TStringField;
    GridDataDisponible: TBCDField;
    GridDataPendienteServir: TBCDField;
    GridDataPendienteRecibir: TBCDField;
    GridDataEstado: TStringField;
    GridDataFechaUltActualizacion: TDateField;
    TableViewIdAlmacen: TcxGridDBColumn;
    TableViewDisponible: TcxGridDBColumn;
    TableViewPendienteServir: TcxGridDBColumn;
    TableViewPendienteRecibir: TcxGridDBColumn;
    TableViewEstado: TcxGridDBColumn;
    TableViewFechaUltActualizacion: TcxGridDBColumn;
    cxLabel1: TcxLabel;
    IdArticuloLabel: TcxDBLabel;
    DataIdArticulo: TStringField;
    GridDataIdSocio: TStringField;
    TableViewIdSocio: TcxGridDBColumn;
    GridDataNombreSocio: TStringField;
    GridDataNombreAlmacen: TStringField;
    TableViewNombreSocio: TcxGridDBColumn;
    TableViewNombreAlmacen: TcxGridDBColumn;
    procedure FormManagerReportRequest;
    procedure FormManagerInitializeForm;
    procedure FormManagerFocusedAreaChanged;
    procedure CodigoArticuloCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
  private

    DsArticuloFields : TArticuloFields;

  public

    AcumuladoExistencias : Decimal;

    class procedure ConsultaExistenciasAUNA( Sender : TObject );
  end;

var  BoxCds119Form: TBoxCds119Form = nil;

implementation

{$R *.DFM}

uses   Math,
       SysUtils,

       AppManager,

       Gdm00Dm,

       Gdm30Frm,

       dmi_sto,

       dm_art,
       dm_sst119,

       a_art,
       a_cls,
       a_alm,
       a_ubi,

       cx_art,
       cx_alm,
       cx_ubi,
       cx_cls1,

       l_eda;

resourceString
       RsMsg1  = 'Este artículo no tiene asignado un Id de AUNA';

class procedure TBoxCds119Form.ConsultaExistenciasAUNA( Sender : TObject );
begin
     CreateEditForm( TBoxCds119Form, BoxCds119Form );
end;

procedure TBoxCds119Form.FormManagerReportRequest;
begin
     ListadoExistenciasArticulos;
end;

procedure TBoxCds119Form.FormManagerInitializeForm;
begin

     DsArticuloFields := TArticuloFields.Create( Self );

     With DataModule00.DmEmpresaFields do
       begin
       SetColumnsDecimals( [ TableViewDisponible, TableViewPendienteServir, TableViewPendienteRecibir ], Compras_DecCantidad.Value );
       end;

     SuministroStocks.CompruebaFicherosGlobales;

     GridData.Active := True;
end;

procedure TBoxCds119Form.CodigoArticuloCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntArticulos( [ Sender.EditingValue ] );
end;

procedure TBoxCds119Form.FormManagerFocusedAreaChanged;
begin
     GridDataSource.Enabled := False;
     If   FormManager.DataAreaFocused
     then begin
          GridData.DeleteAllRecords;
          If   SuministroStocks.ConsultaStock( DsArticuloFields.CampoLibre15.Value, GridData )
          then GridDataSource.Enabled := True;
          end;

end;

procedure TBoxCds119Form.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, False, Sender );
end;

procedure TBoxCds119Form.CodigoArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     IdArticuloLabel.Caption := '';
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, DsArticuloFields );
     If   not Error
     then If   DsArticuloFields.CampoLibre9.Value
          then IdArticuloLabel.Caption := DsArticuloFields.CampoLibre15.Value
          else begin
               ErrorText := RsMsg1;
               Error := True;
               end;
end;

procedure SetupConsultaStocks;
begin
    If   Assigned( Gds30Frm )
     then With Gds30Frm do
            begin
            var BarButton := AddBarButtonItem( ExistenciasItem, 'Consulta de stocks AUNA', True );
            BarButton.Glyph.Assign( ApplicationForms.AUNAImage.Picture.Graphic );
            BarButton.Glyph.SourceHeight := 16;
            BarButton.Glyph.SourceWidth := 16;
            BarButton.OnClick := TBoxCds119Form.ConsultaExistenciasAUNA;
            end;

end;

initialization
  AddProcedure( imOptionalSectionModule, 119, SetupConsultaStocks );

end.




