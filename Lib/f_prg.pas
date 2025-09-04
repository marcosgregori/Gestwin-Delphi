unit f_prg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Vcl.Menus,
  Dialogs, DB, cxControls, cxContainer, cxEdit, cxGroupBox, cxRadioGroup, cxDBEdit,
  cxGraphics, StdCtrls, cxTextEdit, cxMaskEdit, cxDropDownEdit, ExtCtrls,
  dxSkinsCore, cxLookAndFeelPainters, cxCheckBox, dxGDIPlusClasses, cxLookAndFeels,
  cxProgressBar, Grids, ImgList, System.ImageList, cxImageList,
  dxSkinsDefaultPainters, cxImage, cxLabel, dxmdaset, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator, dxDateRanges, dxScrollbarAnnotations,
  cxImageComboBox, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxClasses, cxGridCustomView, cxGrid, cxDBData, cxGridDBTableView,
  dxFormattedLabel, dxPScxGridLnk, dxPSCore,

  AppManager,
  AppContainer,
  DataManager,
  LibUtils,
  AppForms, dxUIAClasses;

type
  TProcessFrame = class(TFrame)
    ImageList: TcxImageList;
    MessagesPanel: TcxGroupBox;
    Panel3: TcxGroupBox;
    Image1: TcxImage;
    Panel4: TcxGroupBox;
    HeaderLabel: TdxFormattedLabel;
    Shape1: TShape;
    PopupMenu: TPopupMenu;
    CopiarItem: TMenuItem;
    ImprimirItem: TMenuItem;
    N1: TMenuItem;
    ProgressBar: TcxProgressBar;
    cxGroupBox1: TcxGroupBox;
    PercentLabel: TcxLabel;
    MessagesData: TgxMemData;
    MessagesDataMessage: TStringField;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    TableViewIcon: TcxGridColumn;
    TableViewMessage: TcxGridColumn;
    GridLevel: TcxGridLevel;
    MessagesDataNotificationType: TSmallintField;
    MessagesDataSource: TDataSource;
    StyleRepository: TcxStyleRepository;
    Style1: TcxStyle;
    procedure ImprimirItemClick(Sender: TObject);
    procedure CopiarItemClick(Sender: TObject);
    procedure TableViewKeyPress(Sender: TObject; var Key: Char);
    procedure TableViewMessagePropertiesHyperlinkClick(Sender: TObject;
      AArgs: TdxHyperlinkClickEventArgs);
  private

    FCurrentClientWidth : LongInt;
    FProcessCaption : String;
    FLastNotificationType,
    FLastIconMessageType : TNotificationType;
    FOnExecuteProcess : TSimpleEvent;
    FRecordMessage : String;
    FMessageRowCount,
    FRecordRow,
    FSelectedRow : SmallInt;
    FLogMsg : String;
    FMarqueeMode : Boolean;
    FGridReportLink : TdxGridReportLink;

    a, stc, fa, s : String;
    xs, ys, hl, ml: Integer;
    mr : TRect;

    function OpenLink( const Link : String ) : Boolean;

  public

    Ended,
    ShutDown,
    Canceled,
    Warning,
    Error : Boolean;

    FlagA,
    FlagB,
    FlagC : Boolean;


    constructor Create( AOwner : TComponent ); override;
    destructor Destroy; override;

    procedure AddMsg( NotificationType : TNotificationType; St : String; LogError : Boolean = True; BoldText : Boolean = False; ShowIcon : Boolean = True );
    procedure AddRecordMsg( St : String );
    procedure AddSeparator;
    procedure ShowProgressBar( MarqueeMode : Boolean = False; AMaxValue : LongInt = 100 );
    procedure IncProgressBar;
    procedure SetProgressBarPercent( Value : SmallInt );
    procedure HideProgressBar;
    procedure CheckCanceled;

    procedure Print;

    property OnExecuteProcess : TSimpleEvent read FOnExecuteProcess write FOnExecuteProcess;
    property RecordMessage : String read FRecordMessage write FRecordMessage;
    property LastNotificationType : TNotificationType read FLastNotificationType;
    property LastIconMessageType : TNotificationType read FLastIconMessageType;
    property LogMsg : String read FLogMsg;
    property MarqueeMode : Boolean read FMarqueeMode;
  end;

// Solo hay una activa en un momento determinado

var ProcessFrame : TProcessFrame = nil;

implementation

{$R *.dfm}

uses ShellApi,
     Printers,
     Files,
     ClipBrd,
     PrintSystem,

     b_msg;

type   TMessageInfo = record
         case byte of
          0 : ( Value : LongInt );
          1 : ( NotificationType : TNotificationType;
                IconVisible,
                BoldText : Boolean );
         end;

resourceString
       RsMsg2 = 'Procesando : ';
       RsMsg3 = 'No se ha podido localizar el fichero.';
       RsMsg4 = 'Compruebe que tiene derechos de acceso a la carpeta y que el fichero [B]%s[/B] existe.';
       RsMsg5 = 'Información sobre el proceso realizado.';
       RsMsg6 = 'El contenido de la ventana de proceso ha sido enviado a la impresora activa.';

constructor TProcessFrame.Create( AOwner : TComponent );
begin
     inherited;

     FRecordMessage := RsMsg2;
     FMessageRowCount := 1;
     ProcessFrame := Self;
     MessagesData.Open;

     FGridReportLink := TdxGridReportLink.Create( Self );
     FGridReportLink.Component := Grid;
     FGridReportLink.ComponentPrinter := PrintSystemDataModule.ComponentPrinter;

     FGridReportLink.ShowPageHeader := False;
     FGridReportLink.ShowPageRowHeader := False;
     FGridReportLink.ShowPageFooter := False;
     {
     FGridReportLink.SupportedCustomDraw := True;
     FGridReportLink.OnCustomDrawFilterBar := DoOnCustomDrawFilterBar;
     }
end;

destructor TProcessFrame.Destroy;
begin
     ProcessFrame := nil;
     inherited;
end;

procedure TProcessFrame.CopiarItemClick(Sender: TObject);
begin
     If   Assigned( TableView.Controller.FocusedRow )
     then Clipboard.AsText := TableView.Controller.FocusedRow.Values[ TableViewMessage.Index ];
end;

procedure TProcessFrame.ImprimirItemClick(Sender: TObject);
begin
     Print;
end;

procedure TProcessFrame.Print;
begin
     PrintSystemDataModule.Print( FGridReportLink );
end;

procedure TProcessFrame.AddMsg( NotificationType : TNotificationType;
                                St               : String;
                                LogError         : Boolean = True;
                                BoldText         : Boolean = False;
                                ShowIcon         : Boolean = True );

var  Rect : TRect;
     MessageInfo : TMessageInfo;

begin

     If   not Assigned( ProcessFrame )   // Puede ocurrir en casos extremos
     then Exit;

     If   ( St='' ) and ( NotificationType<>ntNone )
     then Exit;

     try

       If   NotificationType=ntHeader
       then begin
            HeaderLabel.Caption := St;
            HeaderLabel.Visible := True;
            FLastNotificationType := ntNone;
            FLastIconMessageType := ntNone;
            end
       else begin

            If   not ( Error and ( NotificationType=ntAbort ) )   // Si ya se ha mostrado un error no se notifican los ntAbort
            then begin

                 // Si se produce un error durante el procesamiento de registros dejo el mensaje del último registro

                 If    FLastNotificationType=ntRecord
                 then If   not ( NotificationType in [ ntStop, ntError, ntExceptionError, ntAbort ] )
                      then MessagesData.Delete;

                 MessagesData.Append;

                 var IconVisible := ShowIcon and
                                    ( NotificationType in [ ntInformation..ntRecord, ntLinkInformation ] ) and
                                    not ( ( NotificationType in [ ntStop, ntError, ntExceptionError ] ) and ( FLastNotificationType in [ ntStop, ntError, ntExceptionError ] ) ) and  // Demasiados iconos de error
                                    ( FLastIconMessageType<>NotificationType );
                 If   IconVisible
                 then MessagesDataNotificationType.Value := Ord( NotificationType );

                 If   ( NotificationType=ntHeader ) or BoldText
                 then St := '[B]' + St + '[/B]';

                 MessagesDataMessage.Value := St;

                 MessagesData.Post;

                 If   IconVisible
                 then FLastIconMessageType := NotificationType;

                 end;

            Error := Error or ( NotificationType in [ ntStop, ntError, ntExceptionError, ntAbort ] );
            Warning := Warning or ( NotificationType in [ ntWarning, ntQuestionWarning ] );

            FLastNotificationType := NotificationType;

            If   LogError and ( NotificationType in [ ntError, ntExceptionError, ntAbort ] )
            then FLogMsg := FLogMsg + St + #13;

            If   not ( NotificationType in [ ntRecord, ntRecordInformation ] )
            then HideProgressBar;

            end;

       Application.ProcessMessages;

     except
       end;
end;

procedure TProcessFrame.AddSeparator;
begin
     AddMsg( ntNone, '' );
end;

procedure TProcessFrame.AddRecordMsg( St : String );
begin
     If   FLastNotificationType<>ntRecord
     then AddMsg( ntRecord, FRecordMessage + St  )
     else begin
          MessagesData.Edit;
          MessagesDataMessage.value := FRecordMessage + St;
          MessagesData.Post;
          Application.ProcessMessages;
          end;
end;

procedure TProcessFrame.ShowProgressBar( MarqueeMode : Boolean = False;
                                         AMaxValue   : LongInt = 100 );
begin
     FMarqueeMode := MarqueeMode;
     With ProgressBar do
       begin
       Properties.Marquee := MarqueeMode;
       Properties.Max := AMaxValue;
       Position := 0;
       Visible := True;
       end;
     PercentLabel.Visible := False;
end;

procedure TProcessFrame.TableViewKeyPress(Sender: TObject; var Key: Char);

var   Value : String;

begin
     If   Key=' '
     then If   Assigned( TableView.Controller.FocusedRow )
          then If   TableView.Controller.FocusedRow.Values[ TableViewIcon.Index ]=Ord( ntLinkInformation )
               then try
                      Value := TableView.Controller.FocusedItem.EditValue;
                      var URLPos := Pos( '[URL=', Value );
                      If   URLPos>0
                      then begin
                           Value := Copy( Value, URLPos + 5, 255 );
                           var URLEnd := Pos( ']', Value );
                           If   URLEnd>0
                           then OpenLink( Copy( Value, 1, URLEnd - 1 ) );
                           end;
                    except
                      end;
end;

procedure TProcessFrame.TableViewMessagePropertiesHyperlinkClick( Sender : TObject;
                                                                  AArgs  : TdxHyperlinkClickEventArgs );
begin
     AArgs.Handled := OpenLink( AArgs.URI );
end;

function TProcessFrame.OpenLink( const Link : String ) : Boolean;
begin

     Result := False;  // Handled

     // Solo proceso los ficheros. Le dejo el resto de enlaces al FormattedLabel

     If   Copy( Link, 2, 2 )=':\'
     then begin
          Result := True;
          If   WebApp and not ShiftKey
          then CopyFile( Link, '\\tsclient\\WebFile\' + ExtractFileName( Link ) )
          else If   not OpenFolderAndSelectFile( Link )
               then ShowNotification( ntWarning, RsMsg3, Format( RsMsg4, [ Link ] ), '', { ForceBoxMsg } True );
          end;

end;

procedure TProcessFrame.IncProgressBar;
begin
     With ProgressBar do
       If   Position>Properties.Max
       then Position := 1
       else Position := Position + 1;
     Application.ProcessMessages;
end;

procedure TProcessFrame.SetProgressBarPercent( Value : SmallInt );
begin
     If   Value>=0
     then begin
          ProgressBar.Position := Value;
          If   ProgressBar.Properties.Marquee
          then PercentLabel.Visible := False
          else begin
               PercentLabel.Visible := True;
               PercentLabel.Caption := IntToStr( Value ) + ' %'
               end;
          end;
     Application.ProcessMessages;
end;

procedure TProcessFrame.HideProgressBar;
begin
     ProgressBar.Visible := False;
     PercentLabel.Visible := False;
end;

procedure TProcessFrame.CheckCanceled;
begin
     If   Canceled
     then Abort;
end;

end.
