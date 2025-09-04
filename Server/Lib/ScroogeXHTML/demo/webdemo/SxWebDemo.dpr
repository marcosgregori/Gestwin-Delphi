program SxWebDemo;

{$APPTYPE CONSOLE}

uses
  ScroogeXHTML, SxTypes,
  IdHTTPServer, IdCustomHTTPServer, IdContext,
  SysUtils, Classes, ShellAPI, Windows;

type
  TScroogeWebDemo = class(TObject)
  private
    Server: TIdHTTPServer;
    SX: TBTScroogeXHTML;
    procedure OnCommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
  public
    constructor Create;
    procedure Run;
  end;

const
  IndexHtml = '<!DOCTYPE html>\n'
    + '<html>\n'
    + '  <head>\n'
    + '    <title>ScroogeXHTML Web Demo</title>\n'
    + '  </head>\n'
    + '  <body>\n'
    + '    <h1>ScroogeXHTML Web Demo</h1>\n'
    + '    <form method="post" action="/scroogedemo" accept-charset="US-ASCII">\n'
    + '      <fieldset>\n'
    + '        <legend>RTF Input</legend>\n'
    + '        <textarea name="rtf" rows="6" cols="60" style="margin: 0pt; width: 100%;">\n'
    + '{\rtf1\n'
    + ' Hello! \par\n'
    + ' {\i This} is formatted {\b text}. \par\n'
    + ' Convert me.\n'
    + '}\n'
    + '        </textarea><br />\n'
    + '      </fieldset>\n'
    + '      <p><input type="submit" /></p>\n'
    + '    </form>\n'
    + '  </body>\n'
    + '</html>';

var
  Demo: TScroogeWebDemo;

  { TScroogeWebDemo }

constructor TScroogeWebDemo.Create;
begin
  SX := TBTScroogeXHTML.Create(nil);
  Server := TIdHTTPServer.Create;
  Server.OnCommandGet := OnCommandGet;

  WriteLn('Server ready - using ScroogeXHTML ' + SX.Version);
end;

procedure TScroogeWebDemo.OnCommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  Rtf: RawByteString;
  Response: TStream;
begin
  if ARequestInfo.Command = 'GET' then
  begin
    if ARequestInfo.Document = '/' then
    begin
      Response := TStringStream.Create(StringReplace(IndexHtml, '\n', #13,
        [rfReplaceAll]));
      AResponseInfo.ContentStream := Response;
    end;
  end
  else if ARequestInfo.Command = 'POST' then
  begin
    if ARequestInfo.Document = '/scroogedemo' then
    begin
      Rtf := RawByteString(ARequestInfo.Params.Values['rtf']);
      Response := TStringStream.Create(
        {$IFDEF FPC}
          AnsiString(ToBytes(SX.Convert(Rtf))));
        {$ELSE}
          ToBytes(SX.Convert(Rtf)));
        {$ENDIF}
      AResponseInfo.ContentStream := Response;
    end;
  end;
end;

procedure TScroogeWebDemo.Run;
begin
  Server.Active := True;
end;

begin
  Demo := TScroogeWebDemo.Create;
  Demo.Run;

  // launch browser
  ShellExecute(0, 'open', 'http://localhost/', '', '', SW_SHOWNORMAL);

  WriteLn('Hit any key to stop the server');
  ReadLn;
end.

