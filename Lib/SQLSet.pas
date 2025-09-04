
{$D+,L+,Y+}

unit sqlset;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus;

const
  VarStruct = 0;
    
type
  PStrValue = ^String;

  TgxSQLItem = class(TCollectionItem)
  private
    FTitle,
    FSQLText: String;
    procedure SetTitle(const Value: String);
    procedure SetSQLText(const Value: String);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Title: String read FTitle write SetTitle;
    property SQLText: String read FSQLText write SetSQLText;
  end;

  TgxSQLSet = class;

  TgxSQLItems = class(TCollection)
  private
    FSQLSet: TgxSQLSet;
    function GetItem(Index: Integer): TgxSQLItem;
    procedure SetItem(Index: Integer; Value: TgxSQLItem);
  public
    constructor Create(SQLSet: TgxSQLSet);
    function Add: TgxSQLItem;
    property SQLSet: TgxSQLSet read FSQLSet;
    property Items[Index: Integer]: TgxSQLItem read GetItem write SetItem;
  end;

  TgxSQLSet = class(TComponent)
  private
    { Private declarations }
    FSQLItems: TgxSQLItems;
    procedure SetSQLItems(const Value: TgxSQLItems);
    function GetSQLItems: TgxSQLItems;
    procedure DisposeValue(Sender: TObject; Structure: Integer; Properties: pointer);

  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddSQL(const Title, SQLText: String);
    procedure RemoveSQL(const Title: String);
    procedure ClearItems;
    function GetSQLTextIndex( const Title : String ) : Integer;
    function GetSQLText( const Title : String ) : String; overload;
    function GetSQLText( const TitleIndex : Integer = 0 ): String; overload;
  published
    { Published declarations }
    property SQLItems: TgxSQLItems read GetSQLItems write SetSQLItems;
  end;

implementation

{TgxSQLItem}
constructor TgxSQLItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TgxSQLItem.Destroy;
begin
  inherited Destroy;
end;

procedure TgxSQLItem.SetTitle(const Value: String);
begin
  FTitle := Value;
  Changed( False );
end;

procedure TgxSQLItem.SetSQLText(const Value: String);
begin
  FSQLText := Value;
  Changed(false);
end;

procedure TgxSQLItem.Assign( Source : TPersistent );
begin
     If   Source is TgxSQLItem
     then begin
          Title := TgxSQLItem( Source ).Title;
          SQLText := TgxSQLItem( Source ).SQLText;
          end
     else inherited Assign( Source );
end;

{TgxSQLItems}
constructor TgxSQLItems.Create( SQLSet : TgxSQLSet );
begin
     inherited Create(TgxSQLItem);
     FSQLSet := SQLSet;
end;

function TgxSQLItems.GetItem( Index: Integer ) : TgxSQLItem;
begin
  Result := TgxSQLItem( inherited GetItem( Index ) );
end;

procedure TgxSQLItems.SetItem( Index : Integer;
                               Value : TgxSQLItem );
begin
     inherited SetItem( Index, Value );
end;

function TgxSQLItems.Add: TgxSQLItem;
begin
     Result := TgxSQLItem( inherited Add );
end;

{TgxSQLSet}
constructor TgxSQLSet.Create( AOwner : TComponent );
begin
     inherited Create( AOwner );
     FSQLItems := TgxSQLItems.Create( Self );
end;

destructor TgxSQLSet.Destroy;
begin
     FSQLItems.Free;
     inherited Destroy;
end;

procedure TgxSQLSet.SetSQLItems(const Value: TgxSQLItems);
begin
      FSQLItems.Assign( Value );
end;

function TgxSQLSet.GetSQLItems: TgxSQLItems;
begin
      Result := FSQLItems;
end;

procedure TgxSQLSet.DisposeValue( Sender: TObject; Structure: Integer; Properties: pointer );
begin
     If   Structure=VarStruct
     then If   PStrValue( Properties )^<>''
          then Dispose( PStrValue( Properties ) );
end;

procedure TgxSQLSet.AddSQL(const Title, SQLText: String);
var
  I: Integer;
  VC: TgxSQLItem;
begin
  for I := 0 to FSQLItems.Count - 1 do
    if AnsiLowerCase(FSQLItems.Items[I].Title)=
      AnsiLowerCase(Title) then begin
      FSQLItems.Items[I].Title:=Title;
      FSQLItems.Items[I].SQLText:=SQLText;
      Exit;
    end;
  VC := FSQLItems.Add;
  VC.Title := Title;
  VC.SQLText := SQLText;
end;

procedure TgxSQLSet.RemoveSQL(const Title: String);
var
  OldSQLItems: TgxSQLItems;
  I, i1: Integer;
begin
  OldSQLItems := TgxSQLItems.Create(Self);
  try
    OldSQLItems.Assign(FSQLItems);
    FSQLItems.Clear;
    i1:=0;
    for I := 0 to OldSQLItems.Count - 1 do
      if AnsiLowerCase(OldSQLItems.Items[I].Title)=
        AnsiLowerCase(Title) then inc(i1)
      else begin
        FSQLItems.Add;
        FSQLItems.Items[I-i1].Assign(OldSQLItems.Items[I]);
      end;
  finally
    OldSQLItems.Free;
  end;
end;

procedure TgxSQLSet.ClearItems;
begin
     FSQLItems.Clear;
end;

function TgxSQLSet.GetSQLTextIndex( const Title : String ) : Integer;

var I : Integer;

begin
     Result := -1;
     For I := 0 to FSQLItems.Count - 1 do
       If   AnsiLowerCase( FSQLItems.Items[ I ].Title )=AnsiLowerCase( Title )
       then begin
            Result := I;
            Exit;
            end;
end;

function TgxSQLSet.GetSQLText( const Title : String ) : String;

var I : Integer;

begin
     Result:='';
     For I := 0 to FSQLItems.Count - 1 do
       If   AnsiLowerCase( FSQLItems.Items[ I ].Title )=AnsiLowerCase( Title )
       then begin
            Result := FSQLItems.Items[ I ].SQLText;
            Exit;
            end;
end;

function TgxSQLSet.GetSQLText( const TitleIndex : Integer = 0 ) : String;
begin
     Result := FSQLItems.Items[ TitleIndex ].SQLText;
end;

end.

