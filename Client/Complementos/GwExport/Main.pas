
unit Main;

interface

uses
  WinAPI.Windows,

  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.IniFiles,
  Data.DB,

  ZipForge,

  nxdb, DataManager, SxBase, SxMain, ScroogeXHTML,
  nxsdServerEngine, nxsrServerEngine, nxllComponent, Vcl.Dialogs, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.Menus, cxButtons, dxGDIPlusClasses, cxImage, cxLabel, cxGroupBox,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCheckBox, cxProgressBar,
  dxSkinsCore, dxUIAClasses,

  Gim00Fields, dxCore, dxCoreClasses, dxRichEdit.NativeApi,
  dxRichEdit.Types, dxRichEdit.PlainText, dxRichEdit.DocumentServer;

type
  TMainForm = class(TForm)
    Label5: TcxLabel;
    MessageLabel: TcxLabel;
    ApplicationPanel: TcxGroupBox;
    DesktopPanel: TcxGroupBox;
    AplicacionCtrl: TcxCheckBox;
    EmpresasCtrl: TcxCheckBox;
    EmpresasPanel: TcxGroupBox;
    Label11: TcxLabel;
    DirectorioEmpresaCtrl: TcxComboBox;
    TablasLabel: TcxLabel;
    TablasCtrl: TcxComboBox;
    ExportTable: TnxeTable;
    BTScroogeXHTML: TBTScroogeXHTML;
    LocalSession: TnxSession;
    LocalServerEngine: TnxServerEngine;
    AppDatabase: TnxeDatabase;
    EnterpriseDatabase: TnxeDatabase;
    IncluirCabecerasCtrl: TcxCheckBox;
    IdentificadorCtrl: TcxCheckBox;
    CaptionPanel: TcxGroupBox;
    Shape4: TShape;
    cxLabel1: TcxLabel;
    Image1: TcxImage;
    DestinoBtn: TcxButton;
    ExportarButton: TcxButton;
    CancelarButton: TcxButton;
    OpenDialog: TFileOpenDialog;
    DirectorioDestinoCtrl: TcxTextEdit;
    ProgressBarPanel: TcxGroupBox;
    PercentLabel: TcxLabel;
    ProgressBar: TcxProgressBar;
    RichEditDocumentServer: TdxRichEditDocumentServer;
    procedure CancelarButtonClick(Sender: TObject);
    procedure ExportarButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EmpresasCtrlChange(Sender: TObject);
    procedure DirectorioEmpresaCtrlChange(Sender: TObject);
    procedure CaptionPanelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DestinoBtnClick(Sender: TObject);
    procedure DestinoEditPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
  private
    procedure GetTableList( Directorio : String; TableList : TStrings );

  public

    Working,
    ProcessCanceled : Boolean;
    RecordNumber : LongInt;

    EmpresaFields : TEmpresaFields;

    constructor Create( aOwner : TComponent ); override;
    destructor  Destroy;                       override;

    procedure ExecuteProcess;
  end;

var MainForm: TMainForm = nil;

implementation

{$R *.DFM}

uses  WinAPI.Messages,
      DateUtils,
      Files,
      LibUtils,

      dxRichEdit.Rtf,

      nxsdTypes,
      nxsdDataDictionary,
      nxseAllEngines,

      AppManager,

      b_msg;

resourceString
      RsMsg1  = 'Debe seleccionar un directorio de destino para los datos.';
      RsMsg7  = 'Proceso cancelado por el usuario.';
      RsMsg8  = 'El proceso no ha finalizado satisfactoriamente.'#13'Si desea utilizar los datos, debe realizarlo de nuevo.';
      RsMsg9  = 'Copia realizada satisfactoriamente.';
      RsMsg10 = '¿Esta seguro de que desea cancelar el proceso?';

constructor TMainForm.Create( aOwner : TComponent );
begin
     inherited Create( aOwner );
end;

procedure TMainForm.DestinoBtnClick(Sender: TObject);
begin
     try
       OpenDialog.DefaultFolder := DirectorioDestinoCtrl.Text;
       If   OpenDialog.Execute
       then DirectorioDestinoCtrl.Text := AddPathDelim( OpenDialog.FileName );
       DirectorioDestinoCtrl.SetFocus;
     finally
       DirectorioDestinoCtrl.ModifiedAfterEnter := True;
       end;
end;

procedure TMainForm.DestinoEditPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ActiveControl<>DestinoBtn
     then begin
          If   not DirectoryExists( DisplayValue )
          then begin
               Error := True;
               ErrorText := 'El directorio no existe';
               end;
          ExportarButton.Enabled := not Error;
          end;
end;

destructor TMainForm.Destroy;
begin
     inherited Destroy;
end;

procedure TMainForm.DirectorioEmpresaCtrlChange(Sender: TObject);

var  DirectorioEmpresa : String;

begin
     If   DirectorioEmpresaCtrl.ItemIndex>=1
     then begin
          DirectorioEmpresa := DirectorioEmpresaCtrl.Properties.Items[ DirectorioEmpresaCtrl.ItemIndex ];
          GetTableList( ApplicationPath + DirectorioEmpresa, TablasCtrl.Properties.Items );
          end
     else TablasCtrl.Properties.Items.Clear;
     TablasLabel.Enabled := DirectorioEmpresaCtrl.ItemIndex>=1;
     TablasCtrl.Enabled := DirectorioEmpresaCtrl.ItemIndex>=1;
     TablasCtrl.ItemIndex := 0;
end;

procedure TMainForm.GetTableList( Directorio : String; TableList : TStrings );

var   Index : SmallInt;

begin
     GetFileList( AddPathDelim( Directorio ), '*.nx1', TableList );
     Index := 0;
     While  Index < TableList.Count do
       If   not ( Upcase( TableList[ Index ][ 1 ] ) in [ 'A'..'Z' ] )
       then TableList.Delete( Index )
       else begin
            TableList[ Index ] := ExtractFileNameWithoutExtension( TableList[ Index ] );
            Inc( Index );
            end;
     TableList.Insert( 0, '<Todas>' );
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin

     AppDatabase.AliasPath := ApplicationPath + 'data';
     AppDatabase.Open;

     DirectorioDestinoCtrl.Text := ApplicationPath + 'exports';
     GetFileList( ApplicationPath, 'data_???', DirectorioEmpresaCtrl.Properties.Items, { Recursive } False, { RemoveExtension } False, { AddFileInfo } False,  faDirectory );
     DirectorioEmpresaCtrl.Properties.Items.Insert( 0, '<Todos>' );
     DirectorioEmpresaCtrl.ItemIndex := 0;

end;

procedure TMainForm.CancelarButtonClick(Sender: TObject);
begin
     If   Working
     then begin
          If   ShowNotification( ntQuestion, RsMsg10, '' )=mrYes
          then ProcessCanceled := True;
          end
     else Application.Terminate;
end;

procedure TMainForm.CaptionPanelMouseDown(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const sc_DragMove = $F012;

begin
     ReleaseCapture;
     Perform( wm_SysCommand, sc_DragMove, 0 );
end;

procedure TMainForm.ExportarButtonClick(Sender: TObject);

var  Index : SmallInt;

begin

     If   DirectorioDestinoCtrl.Text=''
     then begin
          ShowNotification( ntStop, RsMsg1 );
          Exit;
          end;

     try

       CancelarButton.SetFocus;
       ExportarButton.Enabled := False;
       EmpresasCtrl.Enabled := False;

       ProcessCanceled := False;

       ExecuteProcess;

       If   ProcessCanceled
       then ShowNotification( ntStop, RsMsg7, RsMsg8 )
       else ShowNotification( ntInformation, RsMsg9, '' );

     finally
       EmpresasCtrl.Enabled := True;
       ExportarButton.Enabled := True;
       end;
end;

procedure TMainForm.EmpresasCtrlChange(Sender: TObject);
begin
     EmpresasPanel.Enabled := EmpresasCtrl.Checked;
end;

procedure TMainForm.ExecuteProcess;

var  DatabaseDirectory,
     TableName,
     FileName,
     FileExt,
     FieldName,
     FieldNames : String;
     ExportFile : TextFile;
     BaseTableList : TStringList;
     EnterpriseIndex,
     TableIndex : Integer;

procedure ExportRecordToText(      Sourcetable : TnxeTable;
                               var TargetFile  : TextFile );

var  Index : SmallInt;
     RecordString,
     FieldString : String;
     Field : TField;
     Stream : TStringStream;

begin
     RecordString := '';
     If   Assigned( SourceTable )
     then With SourceTable do
            try

              If   IdentificadorCtrl.Checked
              then RecordString := IntToStr( RecordNumber );

              For Index:= 0 to FieldCount - 1 do
                begin

                Field := Fields[ Index ];
                FieldString := Field.AsString;

                If   Field.DataType in [ ftWideString, ftWideMemo ]
                then begin

                     If   ( Field.DataType=ftWideMemo ) and
                          ( FieldString<>'' )
                     then begin
                          try
                            Stream := TStringStream.Create;
                            try
                              {
                              Stream.WriteString( FieldString );
                              RichEditDocumentServer.LoadDocument( Stream, TdxRichEditDocumentFormat.Rtf );
                              FieldString := RichEditDocumentServer.HtmlText;
                              }
                              FieldString := BTScroogeXHTML.Convert( FieldString );
                              FieldString := StringReplace( FieldString, ''#$D#$A'', '<br/>', [ rfReplaceAll, rfIgnoreCase ] );
                            finally
                              Stream.Free;
                              end;
                          except on E : Exception do
                            var Error := E.Message;
                            end;
                          end;

                     FieldString := StrRemoveChars( FieldString, [ #0, #10, #13 ] );
                     FieldString := StrChangeChar( FieldString, '"', '`' );
                     FieldString := StrChangeChar( FieldString, '''', '`' );
                     FieldString := '"' + FieldString + '"';
                     end
                else If   Field.DataType in [ ftFloat, ftBCD ]
                     then FieldString := StrChangeChar( FieldString, ',', '.' )
                     else If   Field.DataType=ftBoolean
                          then begin
                               If   Trim( FieldString )=''
                               then FieldString := 'False';
                               end
                          else If   Field.DataType=ftGraphic // No exporto las imágenes en formato texto
                               then FieldString := ''
                               else If   Field.DataType=ftDate
                                    then If   Field.IsNull
                                         then FieldString := ''
                                         else FieldString := StrFormatDate( Field.Value );

                If   RecordString<>''
                then RecordString := RecordString + ',';
                RecordString := RecordString + FieldString;

                end;

              Writeln( TargetFile, RecordString );

            except on E : Exception do
              raise;
              end;
end;

procedure  ExportTables( Database       : TnxeDatabase;
                         Folder         : String;
                         TableList      : TStrings;
                         TableListIndex : SmallInt = 0 );   // Si es solo una tabla

var  TableIndex, I : Integer;
     NumOfRecords : LongInt;

begin

     If   TableListIndex=0
     then TableIndex := 1
     else TableIndex := TableListIndex;

     ProgressBar.Visible := True;

     repeat

       CreateDirPath( AddPathDelim( DirectorioDestinoCtrl.Text ) + Folder  );

       TableName := TableList[ TableIndex ];

       FileName  := AddPathDelim( DirectorioDestinoCtrl.Text ) + Folder + '\' + TableName + '.csv';

       AssignFile( ExportFile, FileName, CP_UTF8 );
       Rewrite( ExportFile );

       try

         ExportTable.Database := Database;
         ExportTable.TableName := TableName;
         ExportTable.Open;

         With ExportTable do
           begin

           RecordNumber := 1;
           ProgressBar.Position := 0;
           ProgressBar.Properties.Max := RecordCount;
           PercentLabel.Caption := '';

           MessageLabel.Caption := 'Tabla : ' + TableName;

           If   IncluirCabecerasCtrl.Checked
           then begin

                If   IdentificadorCtrl.Checked
                then FieldNames := 'Id'
                else FieldNames := '';

                For I := 0 to FieldCount - 1 do
                  begin
                  If   Fields[ I ].DataType<>ftGraphic  // No exporto las imágenes
                  then begin
                       If   FieldNames<>''
                       then FieldNames := FieldNames + ',';
                       FieldNames := FieldNames + Fields[ I ].FieldName;
                       end;
                  end;

                WriteLn( ExportFile, FieldNames );
                end;

           NumOfRecords := RecordCount;
           First;
           While not Eof and not ProcessCanceled do
             begin

             ExportRecordToText( ExportTable, ExportFile );
             Next;

             Inc( RecordNumber );
             ProgressBar.Position := RecordNumber;
             PercentLabel.Caption := Format( '%d%%', [ ( RecordNumber * 100 ) div NumOfRecords ] );
             Application.ProcessMessages;
             end;

           end;

       finally
         CloseFile( ExportFile );
         ExportTable.Close;
         end;

       Inc( TableIndex );

     until ( TableListIndex<>0 ) {Solo una tabla} or ( TableIndex>=TableList.Count );

     ProgressBar.Position := 0;
     MessageLabel.Caption := '';
     ProgressBar.Visible := False;
     Application.ProcessMessages;

end;

begin

     Working := True;

     try

       If   AplicacionCtrl.Checked
       then begin
            BaseTableList := TStringList.Create;
            try
              GetTableList( ApplicationPath + 'data', BaseTableList );
              ExportTables( AppDatabase, 'data', BaseTableList );
            finally
              BaseTableList.Free;
              end;
            end;

       If   EmpresasCtrl.Checked and not ProcessCanceled
       then try

              If   DirectorioEmpresaCtrl.ItemIndex=0  // Todas las Empresas
              then begin
                   For EnterpriseIndex := 1 to DirectorioEmpresaCtrl.Properties.Items.Count - 1 do
                     begin

                     BaseTableList := TStringList.Create;

                     try

                       DatabaseDirectory := DirectorioEmpresaCtrl.Properties.Items[ EnterpriseIndex ];

                       GetTableList( ApplicationPath + DatabaseDirectory, BaseTableList );

                       EnterpriseDatabase.Close;
                       EnterpriseDatabase.AliasPath := ApplicationPath + DatabaseDirectory;
                       EnterpriseDatabase.Open;

                       ExportTables( EnterpriseDatabase, DatabaseDirectory, BaseTableList );

                       If   ProcessCanceled
                       then Exit;

                     finally
                       BaseTableList.Free;
                       end;

                     end;

                   end
              else begin

                   DatabaseDirectory := DirectorioEmpresaCtrl.Properties.Items[ DirectorioEmpresaCtrl.ItemIndex ];

                   EnterpriseDatabase.Close;
                   EnterpriseDatabase.AliasPath := ApplicationPath + DatabaseDirectory;
                   EnterpriseDatabase.Open;

                   ExportTables( EnterpriseDatabase,
                                 DatabaseDirectory,
                                 TablasCtrl.Properties.Items,
                                 TablasCtrl.ItemIndex );
                   end;


            finally
              EnterpriseDatabase.Close;
              end;

       finally
         Working := False;
         end;

end;

end.
