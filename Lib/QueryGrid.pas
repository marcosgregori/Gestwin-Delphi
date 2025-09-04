unit QueryGrid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, Generics.Collections,
  cxDataStorage, cxEdit, DB, cxDBData, nxdb, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGrid, Menus, Buttons, ExtCtrls, cxGridDBTableView,
  cxCurrencyEdit, cxLookAndFeelPainters, StdCtrls, cxButtons, AppContainer,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter, cxContainer,
  cxGroupBox, DataManager, cxLookAndFeels, dxPScxGridLnk,
  dxSkinsdxBarPainter, cxBarEditItem, dxBar, cxExport, cxGridExportLink,
  cxNavigator, AppForms, GridTableViewController, dxDateRanges,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  dxScrollbarAnnotations;


type TPersistentQueryModuleClass = class of TPersistentQueryModule;

     TPersistentQueryModule = class( TDataModule )
     private
       FQueryTable : TnxeTable;
       FParams : TDictionary< String, Variant>;
       FOnInitialize,
       FOnUpdate : TNotifyEvent;

       function GetParamValue( const Name: string ) : Variant;

     public

       constructor Create( AOwner : TComponent ); override;
       destructor Destroy; override;

       procedure Initialize( Table : TnxeTable ); virtual;
       procedure Update; virtual;

       property QueryTable : TnxeTable read FQueryTable;
       property Params : TDictionary< String, Variant> read FParams;
       property ParamValues[ const Name: string ] : Variant read GetParamValue;

     published
       property OnInitialize : TNotifyEvent read FOnInitialize write FOnInitialize;
       property OnUpdate : TNotifyEvent read FOnUpdate write FOnUpdate;
       end;

     TQueryGridFrame = class(TFrame)
       Query: TnxeQuery;
       DataSource: TDataSource;
       BarManager: TdxBarManager;
       ButtonsBar: TdxBar;
       CancelButton: TdxBarLargeButton;
       PageSettingsButton: TdxBarLargeButton;
       PreviewButton: TdxBarLargeButton;
       PrintButton: TdxBarLargeButton;
       FormatPageButton: TdxBarLargeButton;
       Grid: TcxGrid;
       GridView: TcxGridDBTableView;
       GridLevel: TcxGridLevel;
       GridTableViewController: TGridTableViewController;
       ExpandirButton: TdxBarLargeButton;
       ColapsarButton: TdxBarLargeButton;
       CollapseBar: TdxBar;
       ExportarButton: TdxBarLargeButton;
       ExportPopupMenu: TdxBarPopupMenu;
       ExportarTablaExcelButton: TdxBarLargeButton;
       ExportarFicheroCSVButton: TdxBarLargeButton;
       ExportarHTMLButton: TdxBarLargeButton;
       ExportarArchivoTextoButton: TdxBarLargeButton;
       ExportarXMLButton: TdxBarLargeButton;
       procedure SpeedButton3Click(Sender: TObject);
       procedure PersonalizarItemClick(Sender: TObject);
       procedure LeerItemClick(Sender: TObject);
       procedure GuardarItemClick(Sender: TObject);
       procedure TableViewDataControllerFilterChanged(Sender: TObject);
       procedure ExpandirButtonClick(Sender: TObject);
       procedure ColapsarButtonClick(Sender: TObject);
       procedure PreviewButtonClick(Sender: TObject);
       procedure PrintButtonClick(Sender: TObject);
       procedure PageSettingsButtonClick(Sender: TObject);
       procedure FormatPageButtonClick(Sender: TObject);
       procedure CancelButtonClick(Sender: TObject);
       procedure FrameResize(Sender: TObject);
       procedure RefreshButtonClick(Sender: TObject);
       procedure ExportarTablaExcelButtonClick(Sender: TObject);
       procedure ExportarFicheroCSVButtonClick(Sender: TObject);
       procedure ExportarHTMLButtonClick(Sender: TObject);
       procedure ExportarArchivoTextoButtonClick(Sender: TObject);
       procedure ExportarXMLButtonClick(Sender: TObject);

     private

       FOwnerForm : TgxForm;

       FCurrentGroupIndex : SmallInt;
       FPreviewBtnClicked,
       FPrintBtnClicked : Boolean;
       FGridReportLink : TdxGridReportLink;
       FUsesQuery : Boolean;
       FSQLText : String;

       function RecordButtonEvent( AnAppSpeedBtn : TSpeedBtnTag ) : Boolean;
       procedure DoOnExportToExcel(FileName: String);
       procedure DoOnExportToCSV(FileName: String);
       procedure DoOnExportToHTML(FileName: String);
       procedure DoOnExportToText(FileName: String);
       procedure DoOnExportToXML(FileName: String);

     protected

       FPersistentQueryModule : TPersistentQueryModule;

     public

       destructor Destroy; override;

       // procedure CreateItems( ADataset : TnxDataset = nil );

       procedure Setup( PersistentQueryModule : TPersistentQueryModule; AQueryTable : TnxeTable ); overload;
       procedure Setup( ASQLText : String ); overload;
       procedure Setup; overload;

       function CreateColumn(FieldName : String; ACaption : String = ''; AWidth: SmallInt = 0; IsVisible: Boolean = True ): TcxGridDBColumn;

       // function SetupColumn( FieldName : String; ACaption : String = ''; AWidth : SmallInt = 0; IsVisible : Boolean = True ) : TcxGridDBColumn;
       function AddDefaultGroupSummaryItem( AColumn : TcxGridDBColumn; AFieldName : String = '' ) : TcxGridDBTableSummaryItem;
       procedure AddDefaultGroupSummaryItems( Columns : array of TcxGridDBColumn );
       procedure AddGroupIndex( AColumn : TcxGridDBColumn; AGroupIndex : SmallInt = -1 );
       procedure AddGroupsIndex( Columns : array of TcxGridDBColumn; AGroupIndex : SmallInt = -1 );
       procedure FullExpand;

     end;

procedure CreatePersistentQueryModule( ModuleClass : TPersistentQueryModuleClass; var Reference; ParamsDataset : TgxMemData = nil );

implementation

uses  LibUtils,

      cxGridCommon,
      cxGridDBDataDefinitions,
      dxPSCore,

      PrintSystem,
      PrintPreviewWindow,


      AppManager,
      EnterpriseDataAccess,

      b_msg,
      b_exp,

      f_prg;

{$R *.dfm}

resourceString
      RsMsg1  = 'Si cierra la ventana se cerrará también la vista previa.';
      RsMsg2  = '¿Confirma que desea cerrar la ventana de todas formas?' ;
      RsMsg3  = 'Debe situarse sobre un TgxForm.';
      RsMsg4  = 'Creado el fichero : <a href="%s">%s</a>.';

procedure CreatePersistentQueryModule(     ModuleClass   : TPersistentQueryModuleClass;
                                       var Reference;
                                           ParamsDataset : TgxMemData = nil );

var  Instance : TComponent;

begin
     If   ReleasingApplication
     then begin
          Application.Terminate;
          Abort;
          end
     else begin
          Instance := TComponent( ModuleClass.NewInstance );
          TComponent( Reference ) := Instance;
          try
            Instance.Create( Application.MainForm );
            If   DatabaseUpdateRequested
            then Abort
            else DatasetToParamValues( ParamsDataset, TPersistentQueryModule( Reference ).Params );
          except on E : Exception do
            begin
            If   Assigned( Instance )
            then With Instance do
                   If   not ( csDestroying in ComponentState )
                   then Free;
            ShowException( E, nil );
            Abort;
            end;
            end;
         end;
end;

{ TPersistentQueryModule }

constructor TPersistentQueryModule.Create(AOwner: TComponent);
begin
     inherited;
     FParams := TDictionary< String, Variant>.Create;
     // DatasetToParamValues( ParamsDataset, TPersistentQueryModule( Reference ).Params );
end;

destructor TPersistentQueryModule.Destroy;
begin
     FParams.Free;
     inherited;
end;

function TPersistentQueryModule.GetParamValue( const Name: string ): Variant;
begin
     Result := FParams.Items[ Name ];
end;

procedure TPersistentQueryModule.Initialize( Table : TnxeTable);
begin
     FQueryTable := Table;
     If   Assigned( FOnInitialize )
     then FOnInitialize( Self );
end;

procedure TPersistentQueryModule.Update;
begin
     If   Assigned( FQueryTable )
     then try
            FQueryTable.DisableControls;
            If   Assigned( FOnUpdate )
            then FOnUpdate( Self );
          finally
            FQueryTable.EnableControls;
            end;
end;

{ TQueryGridFrame }

procedure TQueryGridFrame.Setup( PersistentQueryModule : TPersistentQueryModule;
                                 AQueryTable           : TnxeTable );
begin
     Setup;
     FPersistentQueryModule := PersistentQueryModule;
     DataSource.Dataset := AQueryTable;
     If   Assigned( FPersistentQueryModule )
     then With FPersistentQueryModule do
            begin
            Initialize( AQueryTable );
            Update;
            end;
end;

procedure TQueryGridFrame.Setup( ASQLText : String );
begin
     Setup;
     FUsesQuery := True;
     FSQLText := ASQLText;
     With Query do
       begin
       SQL.Text := FSQLText;
       Open;
       end;
end;

procedure TQueryGridFrame.Setup;
begin
     If   not ( Owner is TgxForm )
     then raise Exception.Create( RsMsg3 );

     FOwnerForm := TgxForm( Owner );

     FOwnerForm.Icon := ApplicationForms.QueryIcon.Picture.Icon;
     SendMessage( FOwnerForm.Handle, WM_SETICON, ICON_BIG, FOwnerForm.Icon.Handle );
            
     FGridReportLink := TdxGridReportLink.Create( Self );
     FGridReportLink.Component := Grid;
     FGridReportLink.ComponentPrinter := PrintSystemDataModule.ComponentPrinter;

     dxPSPreviewDialogManager.CurrentPreviewDialogStyle := PreviewDialogStyleInfoName;

     GridTableViewController.RecordButtonLink.OnRecordButtonEvent := RecordButtonEvent;

end;

function TQueryGridFrame.AddDefaultGroupSummaryItem( AColumn    : TcxGridDBColumn;
                                                     AFieldName : String = '' ) : TcxGridDBTableSummaryItem;

begin
     Result := TcxGridDBTableSummaryItem( GridView.DataController.Summary.DefaultGroupSummaryItems.Add );
     With Result do
        begin
        BeginUpdate;
        try
          Column := AColumn;
          FieldName := AFieldName;
          Kind := skSum;
          Position := spFooter;
        finally
          EndUpdate;
          end;
        end;
end;

procedure TQueryGridFrame.AddGroupIndex( AColumn     : TcxGridDBColumn;
                                         AGroupIndex : SmallInt = -1 );
begin
     With AColumn do
       begin
       If   AGroupIndex=-1
       then begin
            GroupIndex := FCurrentGroupIndex;
            Inc( FCurrentGroupIndex );
            end
       else GroupIndex := AGroupIndex;
       Visible := False;
       end;

end;

procedure TQueryGridFrame.AddGroupsIndex( Columns     : array of TcxGridDBColumn;
                                          AGroupIndex : SmallInt = -1 );

var  I : SmallInt;

begin
     For I := 0 to High( Columns ) do
       AddGroupIndex( Columns[ I ], AGroupIndex );
end;

procedure TQueryGridFrame.TableViewDataControllerFilterChanged(Sender: TObject);

var  FilterEnabled : Boolean;

begin
     With GridView.DataController do
       begin
       FilterEnabled := not( Filter.IsEmpty or not Filter.Active );
       Groups.FullExpand;
       end;
     ApplicationContainer.EnableRecordButtons( True, True, FilterEnabled );
end;

function TQueryGridFrame.CreateColumn( FieldName   : String;
                                       ACaption    : String = '';
                                       AWidth      : SmallInt = 0;
                                       IsVisible   : Boolean = True  ) : TcxGridDBColumn;
begin
     With GridView do
       begin
       BeginUpdate;
       DataController.BeginUpdateFields;
       try
         Result := CreateColumn;
         With Result do
           begin
           Name := CreateUniqueName( Owner, GridView, Result, ScxGridPrefixName, FieldName );
           DataBinding.FieldName := FieldName;
           If   ACaption<>''
           then Caption := ACaption;
           If   AWidth<>0
           then Width := AWidth;
           Visible := IsVisible;
           end;
       finally
         DataController.EndUpdateFields;
         EndUpdate;
         end;
       end;
end;

procedure TQueryGridFrame.GuardarItemClick(Sender: TObject);
begin
     //..
end;

procedure TQueryGridFrame.LeerItemClick(Sender: TObject);
begin
     //..
end;

procedure TQueryGridFrame.PageSettingsButtonClick(Sender: TObject);
begin
     PrintSystemDataModule.ComponentPrinter.PageSetupEx( 0, False, True, FPreviewBtnClicked, FPrintBtnClicked, FGridReportLink );
end;

procedure TQueryGridFrame.PersonalizarItemClick(Sender: TObject);
begin
     // GridView.ColumnsCustomizing;
end;

procedure TQueryGridFrame.PreviewButtonClick(Sender: TObject);
begin
     PrintSystemDataModule.ComponentPrinter.Preview( False, FGridReportLink );
end;

procedure TQueryGridFrame.PrintButtonClick(Sender: TObject);
begin
     PrintSystemDataModule.Print( FGridReportLink );
end;

function TQueryGridFrame.RecordButtonEvent( AnAppSpeedBtn : TSpeedBtnTag ) : Boolean;
begin
     Result := False;
     case AnAppSpeedBtn of
       sbnRefreshRec :
         begin
         DataSource.Enabled := False;
         Application.ProcessMessages;
         If   Assigned( FPersistentQueryModule )
         then FPersistentQueryModule.Update
         else If   FUsesQuery
              then Query.RefreshQuery;
         // Si se produce cualquier exception no se reactiva el DataSourse. Que el usuario vuelva a refrescar el dataset
         DataSource.Enabled := True;
         GridView.DataController.Groups.FullExpand;
         Grid.SetFocus;
         Result := True;
         end;
       end;
end;

procedure TQueryGridFrame.RefreshButtonClick(Sender: TObject);
begin
     //..
end;

procedure TQueryGridFrame.SpeedButton3Click(Sender: TObject);
begin
     Release;
end;

procedure TQueryGridFrame.AddDefaultGroupSummaryItems( Columns : array of TcxGridDBColumn );

var  I : SmallInt;

begin
     For I := 0 to High( Columns ) do
       AddDefaultGroupSummaryItem( Columns[ I ] );
end;

procedure TQueryGridFrame.CancelButtonClick(Sender: TObject);
begin
     FOwnerForm.Close;
end;

procedure TQueryGridFrame.ColapsarButtonClick(Sender: TObject);
begin
     GridView.DataController.Groups.FullCollapse;
end;

destructor TQueryGridFrame.Destroy;
begin
     FreeAndNil( FPersistentQueryModule );
     inherited;
end;

procedure TQueryGridFrame.FullExpand;
begin
     GridView.DataController.Groups.FullExpand;
end;

procedure TQueryGridFrame.ExpandirButtonClick(Sender: TObject);
begin
     FullExpand;
end;

procedure TQueryGridFrame.ExportarArchivoTextoButtonClick(Sender: TObject);
begin
     ExportarAFichero( DoOnExportToText, 'Archivo de texto (*.txt)|*.txt' );
end;

procedure TQueryGridFrame.ExportarFicheroCSVButtonClick(Sender: TObject);
begin
     ExportarAFichero( DoOnExportToCSV, 'Archivo CSV (*.csv)|*.csv' );
end;

procedure TQueryGridFrame.ExportarHTMLButtonClick(Sender: TObject);
begin
     ExportarAFichero( DoOnExportToHTML, 'Archivo HTML (*.html)|*.html' );
end;

procedure TQueryGridFrame.ExportarTablaExcelButtonClick(Sender: TObject);
begin
     ExportarAFichero( DoOnExportToExcel );
end;

procedure TQueryGridFrame.ExportarXMLButtonClick(Sender: TObject);
begin
     ExportarAFichero( DoOnExportToXML );
end;

procedure TQueryGridFrame.DoOnExportToXML( FileName : String );
begin
     FileName := ChangeFileExt( FileName, '.xml' );
     ExportGridToXML( FileName, Grid );
     ProcessFrame.AddMsg( ntLinkInformation, Format( RsMsg4, [ FileName, FileName ] ) );
end;

procedure TQueryGridFrame.DoOnExportToText( FileName : String );
begin
     FileName := ChangeFileExt( FileName, '.txt' );
     ExportGridToText( FileName, Grid );
     ProcessFrame.AddMsg( ntLinkInformation, Format( RsMsg4, [ FileName, FileName ] ) );
end;

procedure TQueryGridFrame.DoOnExportToHTML( FileName : String );
begin
     FileName := ChangeFileExt( FileName, '.html' );
     ExportGridToHTML( FileName, Grid );
     ProcessFrame.AddMsg( ntLinkInformation, Format( RsMsg4, [ FileName, FileName ] ) );
end;

procedure TQueryGridFrame.DoOnExportToCSV( FileName : String );
begin
     FileName := ChangeFileExt( FileName, '.csv' );
     ExportGridToCSV( FileName, Grid );
     ProcessFrame.AddMsg( ntLinkInformation, Format( RsMsg4, [ FileName, FileName ] ) );
end;

procedure TQueryGridFrame.DoOnExportToExcel( FileName : String );
begin
     FileName := ChangeFileExt( FileName, '.xls' );
     ExportGridToExcel( FileName, Grid );
     ProcessFrame.AddMsg( ntLinkInformation, Format( RsMsg4, [ FileName, FileName ] ) );
end;

procedure TQueryGridFrame.FormatPageButtonClick(Sender: TObject);
begin
     PrintSystemDataModule.ComponentPrinter.DesignReport( FGridReportLink );
end;

procedure TQueryGridFrame.FrameResize(Sender: TObject);
begin
     CollapseBar.DockedLeft := Width;
end;

end.
