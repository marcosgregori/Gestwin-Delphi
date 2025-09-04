
unit b_sch;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, AppForms, ExtCtrls,

  AppContainer,
  DB, nxDB,
  Mask, cxGraphics, cxMemo, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxControls, cxContainer, cxEdit, cxGroupBox, cxRadioGroup, Menus,
  cxLookAndFeelPainters, cxButtons, cxGridTableView, cxGridDBTableView, cxDBEdit,
  dxSkinsCore, dxSkinsDefaultPainters, cxLookAndFeels, dxGDIPlusClasses,
  cxImage;

type
  TSearchForm = class(TgxForm)
    Panel3: TPanel;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxGroupBox1: TcxGroupBox;
    LabelCtrl2: TLabel;
    Label2: TLabel;
    CampoComboBox: TcxComboBox;
    ValorCtrl: TcxTextEdit;
    Image1: TcxImage;
    procedure FormShow(Sender: TObject);
  private

    TableView : TcxGridTableView;
    FieldIndex : Integer;
    SearchValue : String;

  public

    constructor Create( ATableView  : TcxGridTableView; AFieldIndex : Integer; AValue : String ); reintroduce;
    destructor Destroy; override;
  end;

var
  SearchForm: TSearchForm = nil;

function SearchBox(     ATableView  : TcxGridTableView;
                    var AFieldIndex : Integer;
                    var AValue      : String ) : Integer;

implementation

{$R *.dfm}

uses   b_msg;

function SearchBox(     ATableView  : TcxGridTableView;
                    var AFieldIndex : Integer;
                    var AValue      : String ) : Integer;
begin
     Result := mrCancel;
     SearchForm := TSearchForm.Create( ATableView, AFieldIndex, AValue );
     If   Assigned( SearchForm )
     then With SearchForm do
            try
              Result := ShowModal;
              If   Result=mrOk
              then begin
                   AFieldIndex := CampoComboBox.ItemIndex;
                   AValue := ValorCtrl.Text;
                   end;
            finally
              Free;
              end;
end;

{ TSearchForm --------------------------------------------------------------- }

constructor TSearchForm.Create( ATableView  : TcxGridTableView;
                                AFieldIndex : Integer;
                                AValue      : String );
begin
     TableView := ATableView;
     FieldIndex := AFieldIndex;
     SearchValue := AValue;

     inherited Create( Application.MainForm );
end;

destructor  TSearchForm.destroy;
begin
     inherited Destroy;
end;

procedure TSearchForm.FormShow(Sender: TObject);

var  P : TPoint;
     Index : SmallInt;

begin

     P.x := Application.MainForm.Left + ( Application.MainForm.ClientWidth - Width ) div 2;
     P.y := Application.MainForm.Top + GetSystemMetrics( SM_CYCAPTION ) + GetSystemMetrics( SM_CYMENU ) + ApplicationContainer.MainTopBar.Control.Height + 20;

     Application.MainForm.ClientToScreen( P );

     Left := P.x;
     Top := P.y;

     If   SearchValue<>''
     then With ValorCtrl do
            begin
            Text := SearchValue;
            SelectAll;
            end;

     With CampoComboBox, Properties do
       begin

       For Index := 0 to TableView.ColumnCount - 1 do
         Items.Add( TcxGridDBColumn( TableView.Columns[ Index ] ).DataBinding.FieldName );

       {
       If   FieldName=''
       then ItemIndex := 0
       else ItemIndex := Properties.Items.IndexOf( FieldName );
       }
       ItemIndex := FieldIndex;
       end;

end;

end.

