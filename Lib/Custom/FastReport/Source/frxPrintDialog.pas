
{ ******************************************

              FastReport v5.0
          NX enduser components

  Creado por : Marcos Gregori Forestier

  ****************************************** }

unit frxPrintDialog;

interface

{$I frx.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, frxCtrls, ExtCtrls, Buttons, ComCtrls, frxClass,
  AppForms, Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxCheckBox, cxRadioGroup, cxTextEdit, cxMaskEdit,
  cxSpinEdit, cxGraphics, cxDropDownEdit, cxImageComboBox, ImgList,
  dxSkinsCore, dxSkinsDefaultPainters, dxGDIPlusClasses, cxImage,
  cxLookAndFeels, LibUtils, AppContainer, cxGroupBox, cxLabel, System.ImageList, cxImageList
{$IFDEF Delphi6}
, Variants
{$ENDIF};


type
  TfrxPrintDialog = class(TgxForm)
    PropButton: TgBitBtn;
    FileDlg: TSaveDialog;
    CloseButton: TgBitBtn;
    OkButton: TgBitBtn;
    Image1: TcxImage;
    PrinterImageList: TcxImageList;
    EditPanel: TgxEditPanel;
    DescrL: TcxLabel;
    CopiesL: TcxLabel;
    PrintL: TcxLabel;
    Label1: TcxLabel;
    PrintPagesCB: TcxComboBox;
    PrintersCB: TcxImageComboBox;
    AllRB: TcxRadioButton;
    CurPageRB: TcxRadioButton;
    PageNumbersRB: TcxRadioButton;
    PageNumbersE: TcxTextEdit;
    CopiesE: TcxSpinEdit;
    CollateCB: TcxCheckBox;
    FileCB: TcxCheckBox;
    ReverseCB: TcxCheckBox;
    PrintCB: TcxCheckBox;
    progressPanel: TcxGroupBox;
    progressLabel: TcxLabel;
    GenerateLabel: TcxLabel;
    underlineCB: TcxCheckBox;
    PagPageSizeCB: TcxComboBox;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    Label5: TcxLabel;
    procedure PropButtonClick(Sender: TObject);
    procedure PrintersCBClick(Sender: TObject);
    procedure PageNumbersRBClick(Sender: TObject);
    procedure CollateLClick(Sender: TObject);
    procedure PageNumbersEEnter(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PrintCBClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    // procedure PrintModeCBClick(Sender: TObject);
  private
    OldIndex: Integer;
    FProgressionStarted : Boolean;
  public
    AReport: TfrxReport;
    ADuplexMode: TfrxDuplexMode;
    procedure StartProgression;
    procedure EndProgression;
    procedure ShowProgression( Value : string = '' );
    procedure EnablePrintControls( Value : Boolean );
  end;


var   PrnReport        : TfrxReport = nil;
      PrnToPrinter     : Boolean    = False;
      PrnFromPreview   : Boolean    = False;
      PrnLockPrinter   : Boolean    = False;

      FirstPageAdded   : Boolean = False;
      FirstPagePrinted : Boolean = False;
      PrintCanceled    : Boolean = False;

      PrintDialog      : TfrxPrintDialog = nil;

procedure SetPrintReportOptions( AReport : TfrxReport; AToPrinter, AFromPreview : Boolean; ALockPrinter : Boolean = False );
function SetReportPageSize( AReport : TfrxReport; PageSize : String ) : Integer;

implementation

{$R *.DFM}

uses frxPrinter,
     Printers,
     frxUtils,
     frxGraphicUtils,
     frxRes,

     AppManager,

     b_msg;

resourceString  rsMsg1 = '¿Esta seguro de que desea cancelar la generación del informe?.';
                rsMsg2 = 'Obteniendo los datos ...';


procedure SetPrintReportOptions( AReport      : TfrxReport;
                                 AToPrinter,
                                 AFromPreview : Boolean;
                                 ALockPrinter : Boolean = False );
begin
     PrnReport := AReport;
     PrnToPrinter := AToPrinter;
     PrnFromPreview := AFromPreview;
     PrnLockPrinter := ALockPrinter;
     FirstPageAdded := False;
     FirstPagePrinted := False;
end;

function SetReportPageSize( AReport  : TfrxReport;
                            PageSize : String ) : Integer;

var  Index : Integer;
                          
begin
     Result := FrxPrinters.Printer.PaperNameToNumber( PageSize );
     If   ( Result<>0 ) and ( Result<>256 )
     then With AReport do
            For Index := 1 to PagesCount - 1 do
              With TfrxReportPage( Pages[ Index ] ) do
                 If   BaseName='Page'
                 then PaperSize := Result;
end;

procedure TfrxPrintDialog.FormShow(Sender: TObject);

var  ImageComboboxItem : TcxImageComboboxItem;
     Index,
     PageSizeNumber : Integer;

begin

     CopiesE.EditValue := AReport.PrintOptions.Copies;
     CollateCB.Checked := AReport.PrintOptions.Collate;
     PageNumbersE.Text := AReport.PrintOptions.PageNumbers;
     If   AReport.PrintOptions.PageNumbers<>''
     then PageNumbersRB.Checked := True;
     PrintPagesCB.ItemIndex := Integer(AReport.PrintOptions.PrintPages);
     ReverseCB.Checked := AReport.PrintOptions.Reverse;

     With PrintersCB.Properties.Items do
       For Index := 0 to FrxPrinters.Printers.Count - 1 do
         With PrintersCB.Properties.Items do
           begin
           ImageComboboxItem := PrintersCB.Properties.Items.Add;
           With ImageComboBoxItem do
             begin
             Description := FrxPrinters.Printers.Strings[ Index ];
             ImageIndex := 0;
             Value := Index;
             end;
           end;

     // FrxPrinters.PrinterIndex := -1; // Siempre la impresora por defecto

     With PrintersCB do
       If   ( FrxPrinters.PrinterIndex<0 ) or ( FrxPrinters.PrinterIndex>Properties.Items.Count - 1 )
       then ItemIndex := 0
       else ItemIndex := FrxPrinters.PrinterIndex;

     PrintersCBClick(nil);

     If   AReport.PagesCount>1
     then begin
          PageSizeNumber := TfrxReportPage( AReport.Pages[ 1 ] ).PaperSize;
          PagPageSizeCB.ItemIndex := FrxPrinters.Printer.PaperIndex( PageSizeNumber );
          end;

     OldIndex := FrxPrinters.PrinterIndex;
     PrintPagesCB.ItemIndex := 0;

     If   PrnLockPrinter
     then PrnToPrinter := True;

     PrintCB.Checked := PrnToPrinter;
     PrintCBClick( nil );
     PrintCB.Enabled := not PrnFromPreview and not PrnLockPrinter;

     UnderlineCB.Checked := ApplicationContainer.ReportUnderline;

     {
     If   PrintCB.Enabled
     then ActiveControl := PrintCB
     else ActiveControl := CopiesE;
     }
     
     PrintDialog := Self;

     PrintCanceled := False;
end;

procedure TfrxPrintDialog.FormCreate(Sender: TObject);
begin
     PropButton.Enabled := not VirtualUIApp;
end;

procedure TfrxPrintDialog.FormHide(Sender: TObject);
begin
    try
        If   ( ModalResult<>mrOk ) or not Assigned( PrnReport )
        then begin
             FrxPrinters.PrinterIndex := OldIndex;
             If   not PrnFromPreview and
                  Assigned( PrnReport ) and
                  not Assigned( PrnReport.Designer )
             then FreeAndNil( PrnReport );
             end
        else begin

             // Enabled := False;

             ApplicationContainer.ReportUnderline := UnderlineCB.Checked;
             AReport.PrintOptions.Copies := StrToInt( CopiesE.Text );
             AReport.PrintOptions.Collate := CollateCB.Checked;
             If   AllRB.Checked
             then AReport.PrintOptions.PageNumbers := ''
             else If   CurPageRB.Checked
                  then AReport.PrintOptions.PageNumbers := IntToStr( AReport.PreviewPages.CurPreviewPage )
                  else AReport.PrintOptions.PageNumbers := PageNumbersE.Text;

             //* 09.03.2010  Los parámetros Duplex, PrintMode y PrintOnSheet no se fijan porque se utilizan siempre los que el usuario
             //              ha definido en el report.

             AReport.PrintOptions.PrintPages := TfrxPrintPages(PrintPagesCB.ItemIndex);
             ADuplexMode := AReport.PrintOptions.Duplex; // ADuplexMode := TfrxDuplexMode(DuplexCB.ItemIndex);
             AReport.PrintOptions.Reverse := ReverseCB.Checked;

             SetReportPageSize( AReport, PagPageSizeCB.Text );

             try
               PrnReport.Variables[ 'SubrayarLineas' ] := ApplicationContainer.ReportUnderline;
             except
               end;

             PrnToPrinter := PrintCB.Checked;

             If   PrnToPrinter
             then begin
                  With PrnReport do
                    If   not PrnFromPreview
                    then With PrnReport do
                           begin
                           OldStyleProgress := True;
                           PrepareReport;
                           If   Terminated
                           then begin
                                ModalResult := mrCancel;
                                Exit;
                                end
                           else ModalResult := mrOk;
                           end;
                  FrxPrinters.Printer.FileName := '';
                  If   FileCB.Checked
                  then If   FileDlg.Execute
                       then FrxPrinters.Printer.FileName := ChangeFileExt( FileDlg.FileName, '.prn' )
                       else ModalResult := mrCancel;
                  end
             else begin
                  PrnReport.ShowReport( True );
                  ModalResult := mrCancel;
                  end;
             end;
    finally
      PrnReport := nil;
      PrintDialog := nil;
      end;
end;

procedure TfrxPrintDialog.PropButtonClick(Sender: TObject);
begin
     FrxPrinters.Printer.PropertiesDlg;
end;

procedure TfrxPrintDialog.PrintersCBClick(Sender: TObject);

var SaveSheet: Integer;

begin
     If   PagPageSizeCB.ItemIndex<=0
     then SaveSheet := -1
     else SaveSheet := FrxPrinters.Printer.PaperNameToNumber( PagPageSizeCB.Text );

     FrxPrinters.PrinterIndex := PrintersCB.ItemIndex;

     With PagPageSizeCB.Properties do
       begin
       Items := FrxPrinters.Printer.Papers;
       Items.Delete(FrxPrinters.Printer.PaperIndex(256));
       Items.Insert(0, frxResources.Get('pgDefault'));
       end;

     If   ( SaveSheet<>-1 ) and ( FrxPrinters.Printer.PaperIndex( SaveSheet )<>-1 )
     then begin
          PagPageSizeCB.ItemIndex := FrxPrinters.Printer.PaperIndex( SaveSheet ) + 1;
          If   FrxPrinters.Printer.PaperIndex(256) < FrxPrinters.Printer.PaperIndex( SaveSheet )
          then PagPageSizeCB.ItemIndex := PagPageSizeCB.ItemIndex - 1
          end
     else PagPageSizeCB.ItemIndex := 0
end;

{
procedure TfrxPrintDialog.PrintModeCBClick(Sender: TObject);

var  DefaultMode: Boolean;

begin
     DefaultMode := PrintModeCB.ItemIndex = 0;
     If   DefaultMode
     then PagPageSizeCB.ItemIndex := 0;
     PagPageSizeCB.Enabled := not DefaultMode;
     If   not DefaultMode and (PagPageSizeCB.ItemIndex = 0)
     then PagPageSizeCB.ItemIndex := FrxPrinters.Printer.PaperIndex( DMPAPER_A4 );
end;
}

procedure TfrxPrintDialog.PageNumbersEEnter(Sender: TObject);
begin
  PageNumbersRB.Checked := True;
end;

procedure TfrxPrintDialog.PageNumbersRBClick(Sender: TObject);
begin
  PageNumbersE.SetFocus;
end;

procedure TfrxPrintDialog.CollateLClick(Sender: TObject);
begin
  CollateCB.Checked := not CollateCB.Checked;
end;

procedure TfrxPrintDialog.EnablePrintControls( Value : Boolean );
begin
     // PrintersCB.Enabled    := Value;
     PropButton.Enabled := Value;
     FileCB.Enabled := Value;
     ReverseCB.Enabled := Value;
     AllRB.Enabled := Value;
     CurPageRB.Enabled := Value and PrnFromPreview;
     PageNumbersRB.Enabled := Value;
     PageNumbersE.Enabled := Value;
     CopiesE.Enabled := Value;
     PrintPAgesCB.Enabled := Value;
     CollateCB.Enabled := Value;
     UnderlineCB.Enabled := Value;

     CopiesL.Enabled := Value;
     PrintL.Enabled := Value;

end;

procedure TfrxPrintDialog.PrintCBClick(Sender: TObject);
begin
     EnablePrintControls( PrintCB.Checked );
end;

procedure TfrxPrintDialog.StartProgression;
begin

     If   not FProgressionStarted
     then begin

          FProgressionStarted := True;

          GenerateLabel.Visible := True;
          progressLabel.Visible := True;

          CloseButton.GlyphBitmap := gmCancel;
          CloseButton.Caption := '&Cancelar';
          CloseButton.SetFocus;

          OkButton.Enabled := False;

          PrintCB.Enabled := False;

          EnablePrintControls( False );

          Application.ProcessMessages;
          end;
end;

procedure TfrxPrintDialog.EndProgression;
begin

     If   FProgressionStarted
     then begin

          FProgressionStarted := False;

          GenerateLabel.Visible := False;
          progressLabel.Visible := False;

          OkButton.Enabled := True;

          CloseButton.GlyphBitmap := gmClose;
          CloseButton.Caption := '&Cerrar';

          EnablePrintControls( PrintCB.Checked );
          PrintCB.Enabled := True;

          Application.ProcessMessages;
          end;
end;

procedure TfrxPrintDialog.ShowProgression( Value : string = '' );
begin
     progressLabel.Caption := Value;
     Application.ProcessMessages;
end;

procedure TfrxPrintDialog.CloseButtonClick(Sender: TObject);
begin
     If   FProgressionStarted
     then begin
          If   ShowNotification( ntQuestionWarning, RsMsg1 )=mrYes
          then begin
               PrnReport.Terminated := True;
               EndProgression;
               end
          else exit;
          end;
     PrintCanceled := True;
     ModalResult   := mrCancel;
end;

end.
