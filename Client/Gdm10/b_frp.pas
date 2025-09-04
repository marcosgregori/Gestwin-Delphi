unit b_frp;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  Mask, Menus, cxLookAndFeelPainters, cxButtons, cxGraphics, cxCheckBox,
  cxDBEdit, cxDropDownEdit, cxCalendar, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxIndexedComboBox, DB, dxmdaset, DataManager,
  dxSkinsCore, cxLookAndFeels, dxSkinsDefaultPainters, cxLabel, cxGroupBox,

  AppManager, AppContainer;


type
    TBoxFrpForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    TipoDocumentoCtrl: TcxDBIndexedComboBox;
    FormaPagoCtrl: TcxDBTextEdit;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataTipoDocumento: TSmallintField;
    DataFormaPago: TWideStringField;
    Label1: TcxLabel;
    Label8: TcxLabel;
    Label9: TcxLabel;
    DataRevision: TSmallintField;
    RevisionCtrl: TcxDBIndexedComboBox;
    Label3: TcxLabel;
    procedure FormManagerOkButton;
    procedure TipoDocumentoCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure FormaPagoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormaPagoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerInitializeForm;
    private

      FOnAccepted : TSimpleEvent;

    public


    end;

var  BoxFrpForm: TBoxFrpForm = nil;

procedure FitroRemesaPago( OnAccepted : TSimpleEvent );


implementation

{$R *.dfm}

uses  dm_fpa,

      a_rdp,

      cx_fpa;

procedure FitroRemesaPago( OnAccepted : TSimpleEvent );
begin
     CreateEditForm( TBoxFrpForm, BoxFrpForm, [] );
     If   Assigned( BoxFrpForm )
     then BoxFrpForm.FOnAccepted := OnAccepted;
end;

procedure TBoxFrpForm.FormaPagoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasPago( Sender );
end;

procedure TBoxFrpForm.FormaPagoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then FormaPagoCtrl.Description := rsgMsgTodas
     else FormaPago.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxFrpForm.FormManagerInitializeForm;
begin

     // Esto significa que solo puede llamarse desde MntRdpForm, por supuesto ...

     With MntRdpForm do
       begin
       DataTipoDocumento.Value := FiltroTipoDocumento;
       DataRevision.Value := FiltroRevision;
       DataFormaPago.Value := FiltroCodigoFormaPago;
       end;
end;

procedure TBoxFrpForm.FormManagerOkButton;
begin
     If   Assigned( FOnAccepted )
     then FOnAccepted;
end;

procedure TBoxFrpForm.TipoDocumentoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With FormaPagoCtrl do
       begin
       Enabled := TipoDocumentoCtrl.ItemIndex=0;
       If   not Enabled
       then Clear;
       end;
end;

end.

