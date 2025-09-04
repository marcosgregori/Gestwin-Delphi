
unit b_cdv;

interface

uses AppForms, StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics,

     AppContainer,
     Menus, cxLookAndFeelPainters, cxButtons, cxControls,
     cxContainer, cxEdit, cxTextEdit, cxDBEdit, DB, dxmdaset, DataManager,
     cxCheckBox, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics,
     cxLookAndFeels, cxLabel, cxGroupBox,

     AppManager,

     dmi_mov,

     dm_mov, dxUIAClasses;

type

  TBoxCdvForm = class(TgxForm)
    FormManager: TgxFormManager;
    dataPanel: TgxEditPanel;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataSerie: TWideStringField;
    DataSuprimir: TBooleanField;
    InformacionCtrl: TcxGroupBox;
    cxLabel1: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxGroupBox1: TcxGroupBox;
    SerieCtrl: TcxDBTextEdit;
    SuprimirCtrl: TcxDBCheckBox;
    Label2: TcxLabel;
    Label1: TcxLabel;
    DataActualizarPrecios: TBooleanField;
    ActualizarPreciosCtrl: TcxDBCheckBox;
    procedure FormManagerOkButton;
    procedure SerieCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SerieCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormManagerInitializeForm;
  private
  protected
    class var
      FTipoMovimiento : TTipoMovimiento;
      FSerie  : String;
      FOnSelected : TSimpleEvent;

  public

  end;

var
  BoxCdvForm: TBoxCdvForm = nil;

procedure CopiaDocumentoVentas( TipoMovimiento : TTipoMovimiento;
                                Serie          : String;
                                OnSelected     : TSimpleEvent );

implementation

{$R *.DFM}

uses   Gdm00Dm,

       dm_sdf,

       a_sdf,

       cx_sdf;

procedure CopiaDocumentoVentas( TipoMovimiento : TTipoMovimiento;
                                Serie          : String;
                                OnSelected     : TSimpleEvent );
begin
     TBoxCdvForm.FTipoMovimiento := TipoMovimiento;
     TBoxCdvForm.FSerie := Serie;
     TBoxCdvForm.FOnSelected := OnSelected;
     CreateEditForm( TBoxCdvForm, BoxCdvForm );
end;

procedure TBoxCdvForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TBoxCdvForm.SerieCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxCdvForm.FormManagerInitializeForm;
begin
     If   Movimiento.SeriesEnDocumentosVenta( FTipoMovimiento )
     then DataSerie.Value := FSerie
     else begin
          SerieCtrl.Enabled := False;
          InformacionCtrl.Visible := False;
          Height := 185;
          end;
end;

procedure TBoxCdvForm.FormManagerOkButton;
begin
     If   Assigned( fOnSelected )
     then fOnSelected;
end;

procedure TBoxCdvForm.SerieCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntSeriesFacturacion( [ Sender.EditingValue ] );
end;

end.
