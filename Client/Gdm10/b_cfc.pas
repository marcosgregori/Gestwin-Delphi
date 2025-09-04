
unit b_cfc;

interface

uses AppForms, StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics,

     AppContainer,
     Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, DB, dxmdaset, DataManager,

  cxCheckBox, dxSkinsCore, cxGraphics, cxLookAndFeels, cxLabel, cxGroupBox,
  dxSkinsDefaultPainters,

  AppManager;

type

  TBoxCfcForm = class(TgxForm)
    ButtonsPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    CodigoPropietarioCtrl: TcxDBTextEdit;
    Label2: TcxLabel;
    Label1: TcxLabel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataCodigoPropietario: TWideStringField;
    DataSerieNroFactura: TWideStringField;
    Label3: TcxLabel;
    SerieCtrl: TcxDBTextEdit;
    DataSuprimir: TBooleanField;
    SuprimirCtrl: TcxDBCheckBox;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    procedure FormManagerOkButton;
    procedure CodigoPropietarioCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPropietarioCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoPropietarioCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure FormManagerInitializeForm;
  private
  protected
    class var
    FCodigoPropietario,
    FSerieNroFactura : String;
    FOnSelected : TSimpleEvent;
  public

  end;

var
  BoxCfcForm: TBoxCfcForm = nil;

procedure CopiaFacturaRecibida( CodigoPropietario : String;
                                SerieNroFactura   : String;
                                OnSelected        : TSimpleEvent );

implementation

{$R *.DFM}

uses   LibUtils,

       dmi_ast,

       dm_sub,
       dm_ast,
       dm_fac,

       a_sub,

       cx_sub;

resourceString
       RsMsg1  = '<La próxima disponible>';
       RsMsg2  = 'Ya existe una factura con esta clave.';
       RsMsg3  = 'Indique un propietario, serie o número de factura distintos.';

procedure CopiaFacturaRecibida( CodigoPropietario : String;
                                SerieNroFactura   : String;
                                OnSelected        : TSimpleEvent );
begin
     TBoxCfcForm.FCodigoPropietario := CodigoPropietario;
     TBoxCfcForm.FSerieNroFactura := SerieNroFactura;
     TBoxCfcForm.FOnSelected := OnSelected;

     CreateEditForm( TBoxCfcForm, BoxCfcForm, [] );
     {
     If   Assigned( BoxCfcForm )
     then With BoxCfcForm do
            begin
            FOnSelected := OnSelected;
            With CodigoPropietarioCtrl do
              begin
              PostEditValue( FCodigoPropietario );
              SelectAll;
              end;
            SerieCtrl.PostEditValue( FSerieNroFactura );
            end;
     }
end;

procedure TBoxCfcForm.CodigoPropietarioCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, True );
end;

procedure TBoxCfcForm.CodigoPropietarioCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxCfcForm.FormManagerInitializeForm;
begin
     DataCodigoPropietario.Value := FCodigoPropietario;
     DataSerieNroFactura.Value := FSerieNroFactura;
     DataSuprimir.Value := False;
end;

procedure TBoxCfcForm.FormManagerOkButton;
begin
     If   Assigned( fOnSelected )
     then fOnSelected;
end;

procedure TBoxCfcForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   Sender.Editing and
          Asiento.ObtenDocumento( taFraRecibida, ApplicationContainer.Ejercicio, DataCodigoPropietario.Value, DisplayValue, 0 )
     then begin
          Error := True;
          ErrorText := JoinMessage( RsMsg2, RsMsg3 );
          end;
end;

procedure TBoxCfcForm.CodigoPropietarioCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentas( [ Sender.EditingValue ] );
end;

end.
