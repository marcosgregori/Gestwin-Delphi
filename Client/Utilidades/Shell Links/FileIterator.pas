unit FileIterator;

interface

Uses SysUtils;

Type TFoundEvent = procedure(Path:String; FileFound:TSearchRec) of object;

Type TFileAttributes = Set of (faSystem, faHidden, faReadOnly, faArchive);

Type TFileFinder = Class(TObject)
     private
//       FFileAttributes : TFileAttributes;
       FFromPath : String;
       FWildCard : String;
       FOnFound   : TFoundEvent;
       Procedure  RecursiveFind(StartPath : String);
     public
       Constructor Create;
       Destructor Destroy; Override;
       Procedure Find;
       property Path : String read FFromPath write FFromPath;
       property OnFind: TFoundEvent read FOnFound write FOnFound;
       Property WildCard : String read FWildCard Write FWildCard;
end;


implementation

Constructor TFileFinder.Create;
Begin
  Inherited Create;
  FWildCard := '*.*';
  FFromPath := 'C:\';
end;

Destructor TFileFinder.Destroy;
begin

  Inherited Destroy;
end;

Procedure TFileFinder.Find;
begin
  If Not Assigned(FOnFound) Then Exit;
  RecursiveFind(FFromPath);
end;

Procedure TFileFinder.RecursiveFind(StartPath:String);
var
  FSearchRec : TSearchRec;
begin
  FindFirst(StartPath+'\'+FWildCard, faAnyFile, FSearchRec);
  while FindNext(FSearchRec) = 0 do
  begin
    if ((FSearchRec.Name <> '.') AND (FSearchRec.Name <> '..') AND (FSearchRec.Attr <> faDirectory)) Then
       FOnFound(StartPath,FSearchRec);
    if FSearchRec.Attr = faDirectory Then
    Begin
       if (FSearchRec.Name <> '.') AND (FSearchRec.Name <> '..') Then
          RecursiveFind(StartPath+'\'+FSearchRec.Name);
    end;
  end;
  FindClose(FSearchRec);
end;

end.
