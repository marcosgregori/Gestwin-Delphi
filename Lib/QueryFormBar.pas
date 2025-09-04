unit QueryFormBar;

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


type TQueryFormBarFrame = class(TFrame)
       BarManager: TdxBarManager;
       ButtonsBar: TdxBar;
       CancelButton: TdxBarLargeButton;
       PageSettingsButton: TdxBarLargeButton;
       PreviewButton: TdxBarLargeButton;
       PrintButton: TdxBarLargeButton;
       FormatPageButton: TdxBarLargeButton;
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
       FTableView : TcxGridDBTableView;
       FGrid : TcxGrid;

       FPreviewBtnClicked,
       FPrintBtnClicked : Boolean;
       FGridReportLink : TdxGridReportLink;

       procedure DoOnExportToExcel(FileName: String);
       procedure DoOnExportToCSV(FileName: String);
       procedure DoOnExportToHTML(FileName: String);
       procedure DoOnExportToText(FileName: String);
       procedure DoOnExportToXML(FileName: String);

     protected

     public

       constructor Create( AOwnerForm : TgxForm; ATableView : TcxGridDBTableView );
       destructor Destroy; override;

       constructor UpdateScale;
       procedure FullExpand;

       property TableView : TcxGridDBTableView read FTableView;
       property Grid : TcxGrid read FGrid;
     end;

implementation

uses  LibUtils,

      dxDPIAwareUtils,
      cxGridCommon,
      cxGridDBDataDefinitions,
      dxPSCore,
      dxForms,

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

{ TQueryGridFrame }

procedure TQueryFormBarFrame.GuardarItemClick(Sender: TObject);
begin
     //..
end;

procedure TQueryFormBarFrame.LeerItemClick(Sender: TObject);
begin
     //..
end;

procedure TQueryFormBarFrame.PageSettingsButtonClick(Sender: TObject);
begin
     PrintSystemDataModule.ComponentPrinter.PageSetupEx( 0, False, True, FPreviewBtnClicked, FPrintBtnClicked, FGridReportLink );
end;

procedure TQueryFormBarFrame.PersonalizarItemClick(Sender: TObject);
begin
     // TableView.ColumnsCustomizing;
end;

procedure TQueryFormBarFrame.PreviewButtonClick(Sender: TObject);
begin
     PrintSystemDataModule.ComponentPrinter.Preview( False, FGridReportLink );
end;

procedure TQueryFormBarFrame.PrintButtonClick(Sender: TObject);
begin
     PrintSystemDataModule.Print( FGridReportLink );
end;

procedure TQueryFormBarFrame.RefreshButtonClick(Sender: TObject);
begin
     //..
end;

procedure TQueryFormBarFrame.SpeedButton3Click(Sender: TObject);
begin
     Release;
end;

procedure TQueryFormBarFrame.CancelButtonClick(Sender: TObject);
begin
     FOwnerForm.Close;
end;

procedure TQueryFormBarFrame.ColapsarButtonClick(Sender: TObject);
begin
     TableView.DataController.Groups.FullCollapse;
end;

constructor TQueryFormBarFrame.Create( AOwnerForm : TgxForm;
                                       ATableView : TcxGridDBTableView );
begin
     inherited Create( AOwnerForm );

     FOwnerForm := AOwnerForm;

     FTableView := ATableView;
     FGrid := TcxGrid( FTableView.Site.Container );

     FGridReportLink := TdxGridReportLink.Create( Self );
     FGridReportLink.Component := FGrid;
     FGridReportLink.ComponentPrinter := PrintSystemDataModule.ComponentPrinter;

     //  Algunas opciones por defecto que mejoran la presentación inicial del impreso

     FGridReportLink.ShrinkToPageWidth := True;

     //

     dxPSPreviewDialogManager.CurrentPreviewDialogStyle := PreviewDialogStyleInfoName;

end;

destructor TQueryFormBarFrame.Destroy;
begin
     //..
     inherited;
end;

constructor TQueryFormBarFrame.UpdateScale;
begin
     If   AppScaleDPI<>dxDefaultDPI
     then begin
          ChangeScale( AppScaleDPI, dxDefaultDPI );
          // FOwnerForm.UpdateImageLists;
          end;
end;


procedure TQueryFormBarFrame.FullExpand;
begin
     TableView.DataController.Groups.FullExpand;
end;

procedure TQueryFormBarFrame.ExpandirButtonClick(Sender: TObject);
begin
     FullExpand;
end;

procedure TQueryFormBarFrame.ExportarArchivoTextoButtonClick(Sender: TObject);
begin
     ExportarAFichero( DoOnExportToText, 'Archivo de texto (*.txt)|*.txt' );
end;

procedure TQueryFormBarFrame.ExportarFicheroCSVButtonClick(Sender: TObject);
begin
     ExportarAFichero( DoOnExportToCSV, 'Archivo CSV (*.csv)|*.csv' );
end;

procedure TQueryFormBarFrame.ExportarHTMLButtonClick(Sender: TObject);
begin
     ExportarAFichero( DoOnExportToHTML, 'Archivo HTML (*.html)|*.html' );
end;

procedure TQueryFormBarFrame.ExportarTablaExcelButtonClick(Sender: TObject);
begin
     ExportarAFichero( DoOnExportToExcel );
end;

procedure TQueryFormBarFrame.ExportarXMLButtonClick(Sender: TObject);
begin
     ExportarAFichero( DoOnExportToXML );
end;

procedure TQueryFormBarFrame.DoOnExportToXML( FileName : String );
begin
     FileName := ChangeFileExt( FileName, '.xml' );
     ExportGridToXML( FileName, FGrid );
     ProcessFrame.AddMsg( ntLinkInformation, Format( RsMsg4, [ FileName, FileName ] ) );
end;

procedure TQueryFormBarFrame.DoOnExportToText( FileName : String );
begin
     FileName := ChangeFileExt( FileName, '.txt' );
     ExportGridToText( FileName, FGrid );
     ProcessFrame.AddMsg( ntLinkInformation, Format( RsMsg4, [ FileName, FileName ] ) );
end;

procedure TQueryFormBarFrame.DoOnExportToHTML( FileName : String );
begin
     FileName := ChangeFileExt( FileName, '.html' );
     ExportGridToHTML( FileName, FGrid );
     ProcessFrame.AddMsg( ntLinkInformation, Format( RsMsg4, [ FileName, FileName ] ) );
end;

procedure TQueryFormBarFrame.DoOnExportToCSV( FileName : String );
begin
     FileName := ChangeFileExt( FileName, '.csv' );
     ExportGridToCSV( FileName, FGrid );
     ProcessFrame.AddMsg( ntLinkInformation, Format( RsMsg4, [ FileName, FileName ] ) );
end;

procedure TQueryFormBarFrame.DoOnExportToExcel( FileName : String );
begin
     FileName := ChangeFileExt( FileName, '.xls' );
     ExportGridToExcel( FileName, FGrid );
     ProcessFrame.AddMsg( ntLinkInformation, Format( RsMsg4, [ FileName, FileName ] ) );
end;

procedure TQueryFormBarFrame.FormatPageButtonClick(Sender: TObject);
begin
     PrintSystemDataModule.ComponentPrinter.DesignReport( FGridReportLink );
end;

procedure TQueryFormBarFrame.FrameResize(Sender: TObject);
begin
     CollapseBar.DockedLeft := Width;
end;

end.
