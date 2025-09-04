unit Unit1;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
    kbmMWJSONMarshal,
    kbmMWObjectMarshal,
    MyObject, kbmMemTable, kbmMWStreamFormat, kbmMWJSONStreamFormat, kbmMWCustomHTTPService,
    kbmMWCustomTransport, kbmMWServer, kbmMWTCPIPIndyServerTransport, kbmMWAJAXTransStream,
    HTTPServiceModule, kbmMWJSON;

type
    TForm1 = class(TForm)
        ButtonSerialize: TButton;
        ButtonDeserialize: TButton;
        Label1: TLabel;
        Label2: TLabel;
        MSerialized: TMemo;
        MLog: TMemo;
        ButtonListen: TButton;
        Button1: TButton;
        kbmMWServer1: TkbmMWServer;
        kbmMWTCPIPIndyServerTransport1: TkbmMWTCPIPIndyServerTransport;
        kbmMWJSONStreamFormat1: TkbmMWJSONStreamFormat;
        procedure ButtonSerializeClick(Sender: TObject);
        procedure ButtonDeserializeClick(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure ButtonListenClick(Sender: TObject);
        procedure Button1Click(Sender: TObject);
    private
        O: TPerson;
        FHTTPServerSD: TkbmMWHTTPServiceDefinition;
    public
        { Public declarations }
    end;

var
    Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
    kbmMWServer1.Active := False;
end;

procedure TForm1.ButtonDeserializeClick(Sender: TObject);
var
    S: String;
    P, C: TPerson;
    M: TkbmMWJSONMarshal;
begin
    If Assigned(O) then
        FreeAndNil(O);

    M := TkbmMWJSONMarshal.Create;
    try
        S := MSerialized.Text;
        P := M.ValueFromString<TPerson>(S);
        MLog.Clear;
        If P = nil then
            MLog.Lines.Add('Unable to deserialize')
        else
        begin
            MLog.Lines.Add('Name=' + P.Name);
            MLog.Lines.Add('Age=' + IntToStr(P.Age));
            MLog.Lines.Add('Street=' + P.Address.Street);
            MLog.Lines.Add('ZipCode=' + IntToStr(P.Address.ZipCode));
            MLog.Lines.Add('City=' + P.Address.City);
            MLog.Lines.Add('Country=' + P.Address.Country);
            For C in P.Children do
                MLog.Lines.Add(' Child:' + C.Name);
        end;
        O := P;
    finally

    end;
end;

procedure TForm1.ButtonListenClick(Sender: TObject);

var
    WebRoot: String;
begin
    WebRoot := ExtractFilePath(ParamStr(0));
    FHTTPServerSD.RootPath[mwhfcHTML] := WebRoot;
    FHTTPServerSD.RootPath[mwhfcImage] := WebRoot;
    FHTTPServerSD.RootPath[mwhfcJavaScript] := WebRoot;
    FHTTPServerSD.RootPath[mwhfcStyleSheet] := WebRoot;
    FHTTPServerSD.RootPath[mwhfcOther] := WebRoot;
    kbmMWServer1.Active := True;
end;

procedure TForm1.ButtonSerializeClick(Sender: TObject);

var
    S: String;
    M: TkbmMWJSONMarshal;
    P: TPerson;
begin
    If Assigned(O) then
        FreeAndNil(O);

    P := TPerson.Create('Michael Jhonson', 53, TAddress.Create('Street 1', 12345, 'New York', 'USA'));
    O := P;
    P.Children.Add(TPerson.Create('Ana', 10, TAddress.Create('Street 1', 12345, 'New York', 'USA')));
    P.Children.Add(TPerson.Create('Jhon', 25, TAddress.Create('Street 1', 12345, 'New York', 'USA')));

    M := TkbmMWJSONMarshal.Create;
    try
        M.Typed := False;
        M.AutoIndent := True;
        M.AutoLineFeed := True;
        S := M.ValueToString(O);
        MSerialized.Text := S;
    finally
        M.Free;

    end;

end;

procedure TForm1.FormCreate(Sender: TObject);

var
    Sd: TkbmMWCustomServiceDefinition;
begin
    Sd := kbmMWServer1.RegisterServiceByName('HTTPSERVICE', TkbmMWEventHTTPService2, False);
    FHTTPServerSD := TkbmMWHTTPServiceDefinition(Sd);
end;

end.
