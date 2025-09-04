unit b_rai;

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
  dxPScxGridLnk,

  Gdm30Dm, cxLabel, cxDBLabel, dxmdaset, cxLookAndFeels, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxGroupBox, cxPC, cxCalendar,
  cxPCdxBarPopupMenu, dxBarBuiltInMenu, cxNavigator, dxDateRanges, AppForms,
  GridTableViewController, dxScrollbarAnnotations;

type
  TBrwRaiForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    RegistroAplicacionTable: TnxeTable;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    RegistroAplicacionDataSource: TDataSource;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataAplicacion: TWideStringField;
    DataVersion: TSmallintField;
    DataRelease: TSmallintField;
    DataTextoEstado: TWideStringField;
    DataEstado: TSmallintField;
    DataNroRegistro: TIntegerField;
    PageControl: TcxPageControl;
    ActualizacionesTabSheet: TcxTabSheet;
    ActualizacionesGrid: TcxGrid;
    ActualizacionesTableView: TcxGridDBTableView;
    ActualizacionesTableViewFecha: TcxGridDBColumn;
    ActualizacionesTableViewNroSerie: TcxGridDBColumn;
    ActualizacionesTableViewLocalizacion: TcxGridDBColumn;
    ActualizacionesTableViewNroRegistroAplicacion: TcxGridDBColumn;
    ActualizacionesTableViewNroAplicacion: TcxGridDBColumn;
    ActualizacionesTableViewVersion: TcxGridDBColumn;
    ActualizacionesTableViewRelease: TcxGridDBColumn;
    ActualizacionesTableViewNroUsuarios: TcxGridDBColumn;
    ActualizacionesTableViewCodigoResultado: TcxGridDBColumn;
    ActualizacionesTableViewTextoResultado: TcxGridDBColumn;
    ActualizacionesGridLevel: TcxGridLevel;
    cxTabSheet1: TcxTabSheet;
    LicenciasGrid: TcxGrid;
    LicenciasTableView: TcxGridDBTableView;
    LicenciasTableViewFecha: TcxGridDBColumn;
    LicenciasTableViewTipo: TcxGridDBColumn;
    LicenciasTableViewCodigoUsuario: TcxGridDBColumn;
    LicenciasTableViewNombre: TcxGridDBColumn;
    LicenciasTableViewNroRegistroAplicacion: TcxGridDBColumn;
    LicenciasTableViewNroPrograma: TcxGridDBColumn;
    LicenciasTableViewVersion: TcxGridDBColumn;
    LicenciasTableViewRelease: TcxGridDBColumn;
    LicenciasTableViewNroSerie: TcxGridDBColumn;
    LicenciasTableViewNroUsuarios: TcxGridDBColumn;
    LicenciasTableViewCodigoResultado: TcxGridDBColumn;
    LicenciasTableViewTextoResultado: TcxGridDBColumn;
    LicenciasGridLevel: TcxGridLevel;
    RegistroActualizacionesDataSource: TDataSource;
    RegistroActualizacionesTable: TnxeTable;
    ActualizarButton: TgBitBtn;
    TableViewManager: TGridTableViewController;
    RegistroAplicacionTableNroRegistro: TUnsignedAutoIncField;
    RegistroAplicacionTableFecha: TDateTimeField;
    RegistroAplicacionTableTipo: TSmallintField;
    RegistroAplicacionTableCodigoUsuario: TWideStringField;
    RegistroAplicacionTableNombre: TWideStringField;
    RegistroAplicacionTableNroRegistroAplicacion: TIntegerField;
    RegistroAplicacionTableNroPrograma: TSmallintField;
    RegistroAplicacionTableVersion: TSmallintField;
    RegistroAplicacionTableRelease: TSmallintField;
    RegistroAplicacionTableNroSerie: TLargeintField;
    RegistroAplicacionTableClaveActivacion: TLargeintField;
    RegistroAplicacionTableNroUsuarios: TSmallintField;
    RegistroAplicacionTableLocalizacion: TWideStringField;
    RegistroAplicacionTableCodigoResultado: TSmallintField;
    procedure FormManagerInitializeForm;
    procedure ActualizarButtonClick(Sender: TObject);
    procedure ActualizacionesTableViewTextoResultadoGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure LicenciasTableViewTextoResultadoGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure ActualizacionesTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure FormManagerShowForm;
    procedure FormManagerReportRequest;
    procedure TableViewManagerUserSelection(Sender: TObject; var AHandled: Boolean);
  private
    FActualizacionesGridReportLink,
    FLicenciasGridReportLink : TdxGridReportLink;
    procedure UpdateGrids;
  public

  end;

var  BrwRaiForm: TBrwRaiForm = nil;

procedure RelacionActualizaciones( KeyValues : array of const );

implementation

{$R *.DFM}

uses   Variants,
       SysUtils,

       dxPSCore,

       LibUtils,
       PrintSystem,
       PrintPreviewWindow,

       EnterpriseDataAccess,
       SuscriptionConsts,
       Gdm00Dm,

       dm_cli,
       dm_tdr,

       a_cli,
       a_tdr,

       cx_cli;

procedure RelacionActualizaciones( KeyValues : array of const );
begin
     CreateEditForm( TBrwRaiForm, BrwRaiForm, KeyValues );
end;

procedure TBrwRaiForm.ActualizarButtonClick(Sender: TObject);
begin
     UpdateGrids;
end;

procedure TBrwRaiForm.FormManagerInitializeForm;
begin
     dxPSPreviewDialogManager.CurrentPreviewDialogStyle := PreviewDialogStyleInfoName;  // Solo por si acaso

     FActualizacionesGridReportLink := TdxGridReportLink.Create( Self );
     FActualizacionesGridReportLink.Component := ActualizacionesGrid;
     FActualizacionesGridReportLink.ComponentPrinter := PrintSystemDataModule.ComponentPrinter;

     FLicenciasGridReportLink := TdxGridReportLink.Create( Self );
     FLicenciasGridReportLink.Component := LicenciasGrid;
     FLicenciasGridReportLink.ComponentPrinter := PrintSystemDataModule.ComponentPrinter;

end;

procedure TBrwRaiForm.FormManagerReportRequest;
begin
     case PageControl.ActivePageIndex of
       0 : PrintSystemDataModule.ComponentPrinter.Preview( False, FActualizacionesGridReportLink );
       1 : PrintSystemDataModule.ComponentPrinter.Preview( False, FLicenciasGridReportLink );
     end;
end;

procedure TBrwRaiForm.FormManagerShowForm;
begin
     LicenciasTableView.DataController.GotoLast;
     ActualizacionesTableView.DataController.GotoLast;
end;

procedure TBrwRaiForm.ActualizacionesTableViewCustomDrawCell(     Sender    : TcxCustomGridTableView;
                                                                  ACanvas   : TcxCanvas;
                                                                  AViewInfo : TcxGridTableDataCellViewInfo;
                                                              var ADone     : Boolean );
begin
     If   VarToSmallInt( AViewInfo.GridRecord.Values[ ActualizacionesTableViewCodigoResultado.Index ] )<>CCL_CORRECTA
     then begin
          ACanvas.Brush.Color := clLightRed;
          If   AViewInfo.Selected
          then ACanvas.Font.Color := clWindowText;
          end;
end;

procedure TBrwRaiForm.ActualizacionesTableViewTextoResultadoGetDisplayText(      Sender  : TcxCustomGridTableItem;
                                                                                 ARecord : TcxCustomGridRecord;
                                                                             var AText   : string );
var  Resultado : SmallInt;

begin
     try
       Resultado := ARecord.Values[ ActualizacionesTableViewCodigoResultado.Index ];
       If   Resultado in [ CCL_ERROR..CCL_ERRORINTERNO ]
       then AText := TextoEstadoSuscripcion[ Resultado ];
     except
       end;
end;

procedure TBrwRaiForm.LicenciasTableViewTextoResultadoGetDisplayText(     Sender  : TcxCustomGridTableItem;
                                                                          ARecord : TcxCustomGridRecord;
                                                                      var AText   : string );
var  Resultado : SmallInt;

begin
     try
       Resultado := ARecord.Values[ LicenciasTableViewCodigoResultado.Index ];
       If   Resultado in [ CCL_ERROR..CCL_ERRORINTERNO ]
       then AText := TextoEstadoSuscripcion[ Resultado ];
     except
       end;
end;

procedure TBrwRaiForm.TableViewManagerUserSelection(Sender: TObject; var AHandled: Boolean);
begin
     MntTarjetasRegistro( [ RegistroAplicacionTableNroRegistroAplicacion.Value ] );
end;

procedure TBrwRaiForm.UpdateGrids;
begin
     With LicenciasTableView.DataController do
       begin
       RefreshExternalData;
       GotoLast;
       end;

     With ActualizacionesTableView.DataController do
       begin
       RefreshExternalData;
       GotoLast;
       end;
end;


end.

