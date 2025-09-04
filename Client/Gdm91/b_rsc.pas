unit b_rsc;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes, Windows,
  ExtCtrls, Graphics, ComCtrls,
  AppContainer,
  DataManager,
  dm_art, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,

  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,

  Gdm30Dm, cxLabel, cxDBLabel, dxmdaset, cxLookAndFeels, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxGroupBox, cxNavigator,
  dxDateRanges, AppForms, GridTableViewController;

type
  TBrwRscForm = class(TgxForm)
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    ClienteTable: TnxeTable;
    ClienteDataSource: TDataSource;
    TableViewManager: TGridTableViewController;
    ClienteTableCodigo: TWideStringField;
    ClienteTableNombre: TWideStringField;
    cxDBLabel1: TcxDBLabel;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    TableViewAplicacion: TcxGridDBColumn;
    TableViewVersion: TcxGridDBColumn;
    TableViewRelease: TcxGridDBColumn;
    TableViewTextoEstado: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataAplicacion: TWideStringField;
    DataVersion: TSmallintField;
    DataRelease: TSmallintField;
    DataTextoEstado: TWideStringField;
    ClienteTableVendedor: TWideStringField;
    DataEstado: TSmallintField;
    TableViewEstado: TcxGridDBColumn;
    DataNroRegistro: TIntegerField;
    TableViewNroRegistro: TcxGridDBColumn;
    Label10: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure FormManagerInitializeForm;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure ClienteTableUpdateState(DataSet: TDataSet);
    procedure FormManagerFocusedAreaChanged;
    procedure TableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure ClienteTableGetRecord(DataSet: TDataSet);
    procedure TableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
  private
    procedure MuestraRelacion;
  public

  end;

var  BrwRscForm: TBrwRscForm = nil;

procedure RelacionSuscripciones( KeyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,
       LibUtils,
       EnterpriseDataAccess,
       SuscriptionConsts,
       Gdm00Dm,

       dm_cli,
       dm_tdr,

       a_cli,
       a_tdr,

       cx_cli;

procedure RelacionSuscripciones( KeyValues : array of const );
begin
     CreateEditForm( TBrwRscForm, BrwRscForm, KeyValues );
end;

procedure TBrwRscForm.FormManagerFocusedAreaChanged;
begin
     If   FormManager.DataAreaFocused
     then MuestraRelacion;
end;

procedure TBrwRscForm.FormManagerInitializeForm;
begin
     //
end;

procedure TBrwRscForm.TableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
begin
     MntTarjetasRegistro( [ TableViewNroRegistro.EditValue ] );
end;

procedure TBrwRscForm.ClienteTableGetRecord(DataSet: TDataSet);
begin
     MuestraRelacion;
end;

procedure TBrwRscForm.ClienteTableUpdateState(DataSet: TDataSet);
begin
     DataSource.Enabled := ClienteTable.State in [ dsBrowse, dsEdit ];
end;

procedure TBrwRscForm.CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] );
end;

procedure TBrwRscForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TBrwRscForm.MuestraRelacion;

var  LicenciasList : TLicenciasList;
     Index : SmallInt;
     LicenciaValida : Boolean;

begin
     DataSource.Enabled := False;

     With Data do
       begin
       Open;
       While not Eof do
         Delete;
       end;
       
     If   ClienteTableVendedor.Value=CodigoVendedorSuscripcion
     then try
            LicenciaValida := False;
            LicenciasList := TLicenciasList.Create;
            TarjetaRegistro.ObtenLicencias( ClienteTableCodigo.Value, LicenciasList );
            With LicenciasList do
              For Index := 0 to Count - 1 do
                 With Items[ Index ] do
                   With Data do
                     begin
                     Append;
                     DataNroRegistro.Value := NroRegistro;
                     DataAplicacion.Value := TextoAplicacion[ NroPrograma ];
                     DataVersion.Value := Version;
                     DataRelease.Value := Release;
                     DataEstado.Value := Estado;
                     If   Estado in [ CCL_ERROR..CCL_PENDIENTECOBRO ]
                     then DataTextoEstado.Value := TextoEstadoSuscripcion[ Estado ]
                     else DataTextoEstado.Value := RsErrorComprobacion;
                     If   Estado=CCL_CORRECTA
                     then LicenciaValida := True;
                     Post;
                     end;

            DataSource.Enabled := True;
          finally
            LicenciasList.Free;
            If   not LicenciaValida
            then begin

                 end;
            end;
end;

procedure TBrwRscForm.TableViewCustomDrawCell(     Sender    : TcxCustomGridTableView;
                                                   ACanvas   : TcxCanvas;
                                                   AViewInfo : TcxGridTableDataCellViewInfo;
                                               var ADone     : Boolean );
begin
     If   not AViewInfo.Selected
     then With AViewInfo.GridRecord do
            If   VarToInteger( Values[ TableViewEstado.Index ] )<>CCL_CORRECTA
            then ACanvas.Brush.Color := clLightRed;
end;

end.

