unit b_frc;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask, Menus, cxLookAndFeelPainters, cxButtons, cxGraphics, cxCheckBox,
  cxDBEdit, cxDropDownEdit, cxCalendar, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxIndexedComboBox, DB, dxmdaset, DataManager,
  dxSkinsCore, cxLookAndFeels, dxSkinsDefaultPainters, cxLabel, cxGroupBox,

  AppManager;


type
    TBoxFrcForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    TipoDocumentoCtrl: TcxDBIndexedComboBox;
    RevisionCtrl: TcxDBIndexedComboBox;
    FormaCobroCtrl: TcxDBTextEdit;
    IncluirAbonosCtrl: TcxDBCheckBox;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataTipoDocumento: TSmallintField;
    DataRevision: TSmallintField;
    DataFormaCobro: TWideStringField;
    DataIncluirAbonos: TBooleanField;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label8: TcxLabel;
    Label9: TcxLabel;
    procedure FormManagerOkButton;
    procedure TipoDocumentoCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure FormaCobroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormaCobroCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerInitializeForm;
    private

      FOnAccepted : TSimpleEvent;

    public

    end;

var  BoxFrcForm: TBoxFrcForm = nil;

procedure FitroRemesaCobro( OnAccepted : TSimpleEvent );


implementation

{$R *.dfm}

uses  dm_fco,

      a_rem,

      cx_fco;

procedure FitroRemesaCobro( OnAccepted : TSimpleEvent );
begin
     CreateEditForm( TBoxFrcForm, BoxFrcForm, [] );
     If   Assigned( BoxFrcForm )
     then BoxFrcForm.FOnAccepted := OnAccepted;
end;

procedure TBoxFrcForm.FormaCobroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasCobro( Sender );
end;

procedure TBoxFrcForm.FormaCobroCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then FormaCobroCtrl.Description := rsgMsgTodas
     else FormaCobro.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxFrcForm.FormManagerInitializeForm;
begin

     // Esto significa que solo puede llamarse desde MntRemForm, por supuesto ...

     With MntRemForm do
       begin
       DataTipoDocumento.Value := FiltroTipoDocumento;
       DataRevision.Value := FiltroRevision;
       DataFormaCobro.Value := FiltroCodigoFormaCobro;
       DataIncluirAbonos.Value := FiltroIncluirAbonos;
       end;

end;

procedure TBoxFrcForm.FormManagerOkButton;
begin
     If   assigned( FOnAccepted )
     then FOnAccepted;
end;

procedure TBoxFrcForm.TipoDocumentoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With FormaCobroCtrl do
       begin
       Enabled := TipoDocumentoCtrl.ItemIndex=0;
       If   not Enabled
       then Clear;
       end;
end;

end.

