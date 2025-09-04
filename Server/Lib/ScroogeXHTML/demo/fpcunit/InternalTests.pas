unit InternalTests;

interface
uses
  fpcunit,
  testregistry,
  ScroogeXHTML,
  SxHtmlTranslator,
  SxXhtmlTranslator;

type
  TInternalTests = class(TTestCase)
  private
    S: TBTScroogeXHTML;

  public
    procedure SetUp; override;
    procedure TearDown; override;

  published
    procedure TestWriter; virtual;
    procedure TestFormatter; virtual;

  end;

implementation
uses SxWriter, SxInterfaces, SxFormatter;

{ TFileTests }

procedure TInternalTests.SetUp;
begin
  inherited;
  S := TBTScroogeXHTML.Create(nil);
end;

procedure TInternalTests.TearDown;
begin
  inherited;
  S.Free;
  S := nil;
end;

procedure TInternalTests.TestFormatter;
var
  F: ISxFormatter;
begin
  F := TSxFormatter.Create;
  CheckEquals('Hello World' + F.NewLine, F.Add('Hello World'));
  CheckEquals('  2.Level' + F.NewLine, F.Indent('2.Level'));
  CheckEquals('    3.Level' + F.NewLine, F.Indent('3.Level'));
  CheckEquals('    3.Level' + F.NewLine, F.Add('3.Level'));
  CheckEquals('      4.Level' + F.NewLine, F.Indent('4.Level'));
  CheckEquals('      4.Level' + F.NewLine, F.Add('4.Level'));
  CheckEquals('    3.Level' + F.NewLine, F.UnIndent('3.Level'));
  CheckEquals('  2.Level' + F.NewLine, F.UnIndent('2.Level'));
  CheckEquals('1.Level' + F.NewLine, F.UnIndent('1.Level'));
end;

procedure TInternalTests.TestWriter;
var
  W: TSxWriter;
begin
  W := TSxWriter.Create(S);
  try

  finally
    W.Free;
  end;
end;

initialization
  RegisterTest(TInternalTests);
end.

