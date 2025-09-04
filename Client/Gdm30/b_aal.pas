
unit b_aal;

interface

uses AppForms, StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics,

     AppManager,
     AppContainer,
     Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox,
     cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit, DB, dxmdaset,
     DataManager, cxMaskEdit, cxSpinEdit, cxGraphics, cxLookAndFeels,
     dxSkinsCore, dxSkinsDefaultPainters, cxLabel, cxGroupBox,

     dmi_mov,

     dm_mov, dxUIAClasses;

type

  TAsignacionAlmacenEvent = procedure( CodigoAlmacen : String ) of object;

  TBoxAalForm = class(TgxForm)
    FormManager: TgxFormManager;
    dataPanel: TgxEditPanel;
    AlmacenCtrl: TcxDBTextEdit;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataAlmacen: TWideStringField;
    Label4: TcxLabel;
    Label5: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxGroupBox2: TcxGroupBox;
    procedure AlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure AlmacenCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure AlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
  private
  protected
    class var
    FOnSelected : TAsignacionAlmacenEvent;

  public

  end;

var  BoxAalForm: TBoxAalForm = nil;

procedure AsignacionAlmacen( OnSelected : TAsignacionAlmacenEvent );

implementation

{$R *.DFM}

uses   LibUtils,

       Gdm00Dm,

       Gim30Fields,

       dm_alm,

       a_alm,

       cx_alm;


procedure AsignacionAlmacen( OnSelected : TAsignacionAlmacenEvent );
begin
     TBoxAalForm.FOnSelected := OnSelected;
     CreateEditForm( TBoxAalForm, BoxAalForm );
end;

procedure TBoxAalForm.FormManagerOkButton;
begin
     If   Assigned( FOnSelected )
     then FOnSelected( DataAlmacen.Value );
end;

procedure TBoxAalForm.FormManagerInitializeForm;
begin
     //..
end;

procedure TBoxAalForm.AlmacenCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntAlmacenes( [ Sender.Editingvalue ] );
end;

procedure TBoxAalForm.AlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TBoxAalForm.AlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit;var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scAmbas, Sender, DisplayValue, ErrorText, Error );
end;

end.
