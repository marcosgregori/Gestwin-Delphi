unit TextConvert;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,

  dxCore,
  dxCoreClasses,
  dxRichEdit.NativeApi,
  dxRichEdit.Types,
  dxRichEdit.PlainText,
  dxRichEdit.DocumentServer,

  LibUtils;


type
  TTextConvertModule = class(TDataModule)
    RichEditDocumentServer: TdxRichEditDocumentServer;
    procedure DataModuleDestroy(Sender: TObject);

  private


  public

     function ToPlainText( Value : String; JSONText : Boolean = False; DocumentFormat : TdxRichEditDocumentFormat = TdxRichEditDocumentFormat.Rtf ) : String;

  end;

var  TextConvertModule: TTextConvertModule = nil;


function  TextConverter : TTextConvertModule;

implementation


{$R *.dfm}

uses  AppManager;

function TextConverter : TTextConvertModule;
begin
     CreateDataModule( TTextConvertModule, TextConvertModule );
     Result := TextConvertModule;
end;

procedure TTextConvertModule.DataModuleDestroy(Sender: TObject);
begin
     TextConvertModule := nil;
end;


function TTextConvertModule.ToPlainText( Value           : String;
                                         JSONText        : Boolean = False;
                                         DocumentFormat : TdxRichEditDocumentFormat = TdxRichEditDocumentFormat.Rtf ) : String;

var  Stream : TStringStream;

begin
     Result := '';
      try
        Stream := TStringStream.Create;
        try
          Stream.WriteString( Trim( Value ) );
          RichEditDocumentServer.LoadDocument( Stream, DocumentFormat );
          Result := RichEditDocumentServer.Text;
          If   JSONText
          then Result := StrToJSONText( Result );
        finally
          Stream.Free;
          end;
      except
        Result := '';
        end;

end;


end.
