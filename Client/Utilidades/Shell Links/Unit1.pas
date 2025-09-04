unit Unit1;

{

Shortcut target finder
http://delphi.about.com/library/weekly/aa072704a.htm

A sample Delphi application, with full source code,
that can be used to locate all the shortcut files (.LNK)
on a drive (directory) and find the target that is executed by a shortcut.

..............................................
Zarko Gajic, BSCS
About Guide to Delphi Programming
http://delphi.about.com
how to advertise: http://delphi.about.com/library/bladvertise.htm
free newsletter: http://delphi.about.com/library/blnewsletter.htm
forum: http://forums.about.com/ab-delphi/start/
..............................................

}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ShlObj, ActiveX, FileCtrl,ComObj, FileIterator ;

type
  TForm1 = class(TForm)
    Button1: TButton;
    FileListBox1: TFileListBox;
    DirectoryListBox1: TDirectoryListBox;
    FilterComboBox1: TFilterComboBox;
    ButtonAnalyses: TButton;
    Memo1: TMemo;
    DriveComboBox1: TDriveComboBox;
    procedure Button1Click(Sender: TObject);
    procedure ButtonAnalysesClick(Sender: TObject);
  private
    { Private declarations }
    MyFileFinder : TFileFinder;
  public
    { Public declarations }
    procedure AddFile(PAth:String;TheFile:TSearchRec);
    function GetTarget(const LinkFileName:String):String;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
  tmp : String;
begin
  if FileListBox1.ItemIndex = -1 then
  begin
    ShowMessage('Nothing selected!');
    Exit;
  end;
  tmp := GetTarget(FileListBox1.FileName);
  ShowMessage(tmp);
end;

function TForm1.GetTarget(const LinkFileName:String):String;
var
   //Link : String;
   psl  : IShellLink;
   ppf  : IPersistFile;
   WidePath  : Array[0..260] of WideChar;
   Info      : Array[0..MAX_PATH] of Char;
   wfs       : TWin32FindData;
begin
  if UpperCase(ExtractFileExt(LinkFileName)) <> '.LNK' Then
  begin
    Result:='NOT a shortuct by extension!';
    Exit;
  end;

  CoCreateInstance(CLSID_ShellLink, nil, CLSCTX_INPROC_SERVER, IShellLink, psl);
  if psl.QueryInterface(IPersistFile, ppf) = 0 Then
  Begin
    MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, PChar(LinkFileName), -1, @WidePath, MAX_PATH);
    ppf.Load(WidePath, STGM_READ);
    psl.GetPath(@info, MAX_PATH, wfs, SLGP_UNCPRIORITY);
    Result := info;
  end
  else
    Result := '';
end;

procedure TForm1.AddFile(Path : String; TheFile : TSearchRec);
var
  tmp : String;
  target : string;
begin
  if ExtractFileExt(TheFile.Name) = '.lnk' Then
  begin
     tmp := Path+'\'+TheFile.Name;
     target := GetTarget(tmp);
     Memo1.Lines.Add(IntToStr(1 + Memo1.Lines.Count) + '. ' + tmp +' --> '+ target);
  end;
end;

procedure TForm1.ButtonAnalysesClick(Sender: TObject);
begin
  Memo1.Clear;

  MyFileFinder := TFileFinder.Create;
  MyFileFinder.Path :=  DirectoryListBox1.Directory;
  MyFileFinder.WildCard := '*.*';
  MyFileFinder.OnFind := AddFile;
  MyFileFinder.Find;
end;

end.
