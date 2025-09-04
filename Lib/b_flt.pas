
unit b_flt;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, AppForms, ExtCtrls,

  AppContainer,
  DB, nxDB,
  Mask, cxGraphics, cxMemo, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxControls, cxContainer, cxEdit, cxGroupBox, cxRadioGroup, Menus,
  cxLookAndFeelPainters, cxButtons, dxSkinsCore, dxSkinsDefaultPainters,
  cxLookAndFeels, cxRichEdit;

type
  TFilterForm = class(TgxForm)
    Panel3: TPanel;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxGroupBox1: TcxGroupBox;
    ExpresionCtrl: TcxRadioButton;
    CampoCtrl: TcxRadioButton;
    CampoComboBox: TcxComboBox;
    LabelCtrl2: TLabel;
    FiltroMemo: TcxMemo;
    procedure FormShow(Sender: TObject);
    procedure ExpresionCtrlClick(Sender: TObject);
    procedure CampoCtrlClick(Sender: TObject);
  private

    Dataset : TnxDataset;
    FieldName : String;
    SearchValue : String;
    IsAExpression : Boolean;

    procedure UpdateControls;
  public

    constructor Create( ADataset : TnxDataset; AFieldName : String; AValue : String; AIsAExpression : Boolean ); reintroduce;
    destructor Destroy; override;
  end;

var
  FilterForm: TFilterForm = nil;

function FilterBox(     ADataset       : TnxDataset;
                    var AFieldName     : String;
                    var AValue         : String;
                    var AIsAExpression : Boolean ) : integer;


implementation

{$R *.dfm}

uses   b_msg;

resourceString

       RsHintMsg1 = 'Permite utilizar expresiones en las que interviene más de un campo. Es muy versátil, pero de uso algo avanzado.';
       RsHintMsg2 = 'Permite seleccionar el campo por el que se desea filtrar el fichero.';
       RsHintMsg3 = 'Se pueden introducir expresiones del tipo  : (NroAsiento>1200) and Intracomunitaria';
       RsHintMsg4=  'Se pueden introducir valores constantes o rangos del tipo : 12..1400 , 01/01/2010..12/01/2010 , 1200.0..';

function FilterBox(     ADataset       : TnxDataset;
                    var AFieldName     : String;
                    var AValue         : String ;
                    var AIsAExpression : Boolean ) : integer;
begin
     Result := mrCancel;
     FilterForm := TFilterForm.Create( ADataset, AFieldName, AValue, AIsAExpression );
     If   Assigned( FilterForm )
     then With FilterForm do
            try
              Result := ShowModal;
              If   Result=mrOk
              then begin
                   AFieldName := CampoComboBox.Text;
                   AValue := FiltroMemo.Text;
                   AIsAExpression := ExpresionCtrl.Checked;
                   end;
            finally
              Free;
              end;
end;

{ TFilterForm --------------------------------------------------------------- }

procedure TFilterForm.CampoCtrlClick(Sender: TObject);
begin
     ExpresionCtrl.Checked := not CampoCtrl.Checked;
     UpdateControls;
end;

procedure TFilterForm.UpdateControls;
begin
     If   CampoCtrl.Checked
     then FiltroMemo.Hint := RsHintMsg4
     else FiltroMemo.Hint := RsHintMsg3;
     CampoComboBox.Enabled := CampoCtrl.Checked;
end;

constructor TFilterForm.Create( ADataset       : TnxDataset;
                                AFieldName     : String;
                                AValue         : String;
                                AIsAExpression : Boolean );
begin
     Dataset := ADataset;
     FieldName := AFieldName;
     SearchValue := AValue;
     IsAExpression := AIsAExpression;

     inherited Create( Application.MainForm );

     ExpresionCtrl.Hint := RsHintMsg1;
     CampoCtrl.Hint := RsHintMsg2;

end;

destructor  TFilterForm.destroy;
begin
     inherited Destroy;
end;

procedure TFilterForm.ExpresionCtrlClick(Sender: TObject);
begin
     CampoCtrl.Checked := not ExpresionCtrl.Checked;
     UpdateControls;
end;

procedure TFilterForm.FormShow(Sender: TObject);

var  P : TPoint;

begin

     P.x := Application.MainForm.Left + ( Application.MainForm.ClientWidth - Width ) div 2;
     P.y := Application.MainForm.Top + GetSystemMetrics( SM_CYCAPTION ) + GetSystemMetrics( SM_CYMENU ) + ApplicationContainer.MainTopBar.Control.Height + 20;

     Application.MainForm.ClientToScreen( P );

     Left := P.x;
     Top := P.y;

     If   SearchValue<>''
     then With FiltroMemo do
            begin
            Text := SearchValue;
            SelectAll;
            end;

     ExpresionCtrl.Checked := IsAExpression;
     ExpresionCtrlClick( nil );

     With CampoComboBox, Properties do
       begin
       Dataset.getFieldNames( Items );
       If   FieldName=''
       then ItemIndex := 0
       else ItemIndex := Properties.Items.IndexOf( FieldName );
       end;

end;

end.

