
unit b_ctc;

interface

uses AppForms, StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics,

     AppManager,
     AppContainer,
     Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox,
     cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit, DB, dxmdaset,
     DataManager, cxGraphics, cxLookAndFeels, dxSkinsCore,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox, dxUIAClasses;

type

  TBoxCtcForm = class(TgxForm)
    FormManager: TgxFormManager;
    dataPanel: TgxEditPanel;
    CodigoClienteCtrl: TcxDBTextEdit;
    CopiarReferenciasCtrl: TcxDBCheckBox;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataCodigoCliente: TWideStringField;
    DataCopiarReferencias: TBooleanField;
    Label2: TcxLabel;
    Label1: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure FormManagerOkButton;
    procedure CodigoClienteCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
  private
  public

    FOnSelected : TSimpleEvent;
  end;

var  BoxCtcForm: TBoxCtcForm = nil;

procedure CopiaTarifaCliente( CodigoCliente : String;
                              OnSelected    : TSimpleEvent );

implementation

{$R *.DFM}

uses   Gim00Fields,
       Gim30Fields,

       dm_cli,

       a_cli,

       cx_cli;

// Solo debe usarse desde a_tpc

resourceString
       rsMsg1  = 'No puede utilizar el mismo código de cliente como destino.';

var  CodigoClienteOrigen : String;

procedure CopiaTarifaCliente( CodigoCliente : String;
                              OnSelected    : TSimpleEvent );
begin
     CodigoClienteOrigen := CodigoCliente;
     CreateEditForm( TboxCtcForm, BoxCtcForm, [] );
     If   Assigned( BoxCtcForm )
     then BoxCtcForm.FOnSelected := OnSelected;
end;

procedure TBoxCtcForm.FormManagerOkButton;
begin
     If   Assigned( FOnSelected )
     then FOnSelected;
end;

procedure TBoxCtcForm.CodigoClienteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] );
end;

procedure TBoxCtcForm.CodigoClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TBoxCtcForm.CodigoClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
     If   DisplayValue=CodigoClienteOrigen
     then begin
          Error := True;
          ErrorText := RsMsg1;
          end;
end;

end.
