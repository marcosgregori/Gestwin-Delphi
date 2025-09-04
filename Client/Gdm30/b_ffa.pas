unit b_ffa;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask, Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset, DataManager,
  cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxSpinEdit, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics,
  cxLookAndFeels, cxLabel, cxGroupBox, dxUIAClasses;


type
    TboxFfaForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    TipoMovimientoCtrl: TcxDBSpinEdit;
    CodigoClaseACtrl: TcxDBTextEdit;
    CodigoClaseBCtrl: TcxDBTextEdit;
    CodigoClaseCCtrl: TcxDBTextEdit;
    LoteFabricacionCtrl: TcxDBTextEdit;
    CodigoPropietarioCtrl: TcxDBTextEdit;
    Data: TgxMemData;
    DataTipoMovimiento: TSmallintField;
    DataCodigoPropietario: TWideStringField;
    DataSource: TDataSource;
    DataCodigoClaseA: TWideStringField;
    DataCodigoClaseB: TWideStringField;
    DataCodigoClaseC: TWideStringField;
    DataLoteFabricacion: TWideStringField;
    Label7: TcxLabel;
    DescTipoMovimientoLabel: TcxLabel;
    capClaseALabel: TcxLabel;
    capClaseBLabel: TcxLabel;
    DescClaseALabel: TcxLabel;
    DescClaseBLabel: TcxLabel;
    capClaseCLabel: TcxLabel;
    DescClaseCLabel: TcxLabel;
    Label1: TcxLabel;
    Label4: TcxLabel;
    DescPropietarioLabel: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure TipoMovimientoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure TipoMovimientoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TipoMovimientoCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure CodigoClaseCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoClaseCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClaseCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoPropietarioCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPropietarioCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure LoteFabricacionCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    private

    public


    end;

var
  boxFfaForm: TboxFfaForm;

procedure FiltroFichaArticulo;


implementation

{$R *.DFM}

uses  LibUtils,

      dm_cls,
      dm_tma,
      dm_pro,
      dm_cli,

      Gdm00Dm,
      Gim00Fields,
      Gim30Fields,

      dmi_mov,

      a_cls,
      
      b_fda,

      dm_mov,
      
      cx_tma,
      cx_cls1,
      cx_pro,
      cx_cli,
      cx_ldp1,
      cx_ldp2;

// Solo puede llamarse desde BrwFdaForm.

procedure FiltroFichaArticulo;
begin
     CreateEditForm( TBoxFfaForm, BoxFfaForm );
end;

procedure TboxFfaForm.FormManagerInitializeForm;
begin
     Clase.SetupEditControls( CodigoClaseACtrl, CodigoClaseBCtrl, CodigoClaseCCtrl, 0 );

     With DataModule00.DmEmpresaFields do
       LoteFabricacionCtrl.Enabled := Stock_LotesProductos.Value;

     With BrwFdaForm do
       begin
       DataTipoMovimiento.Value := FTipoMovimiento;
       DataCodigoClaseA.Value := FCodigoClaseA;
       DataCodigoClaseB.Value := FCodigoClaseB;
       DataCodigoClaseC.Value := FCodigoClaseC;
       DataLoteFabricacion.Value := FLoteFabricacion;
       DataCodigoPropietario.Value := FCodigoPropietario;
       end;

end;

procedure TboxFfaForm.FormManagerOkButton;
begin
     With BrwFdaForm do
       begin

       FTipoMovimiento := DataTipoMovimiento.Value;
       FCodigoClaseA := DataCodigoClaseA.Value;
       FCodigoClaseB := DataCodigoClaseB.Value;
       FCodigoClaseC := DataCodigoClaseC.Value;
       FLoteFabricacion  := DataLoteFabricacion.Value;
       FCodigoPropietario := DataCodigoPropietario.Value;

       FDescripcionTipoMovimiento := DescTipoMovimientoLabel.Caption;
       FNombrePropietario := DescPropietarioLabel.Caption;

       DataFiltroActivo.Value := True;

       Grid.SetFocus;
       end;
end;

procedure TboxFfaForm.LoteFabricacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   DataModule00.DmEmpresaFields.Stock_TrazabilidadPorLotes.Value 
     then ConsultaLotesProductos2( Sender, BrwFdaForm.DataCodigoArticulo.Value, ApplicationContainer.TodayDate, nil, scAmbas )
     else ConsultaLotesProductos1( Sender, BrwFdaForm.DataCodigoArticulo.Value );
end;

procedure TboxFfaForm.TipoMovimientoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     CodigoPropietarioCtrl.Enabled := VarToInteger( TipoMovimientoCtrl.EditValue ) in [ tmOferta..tmVenta ];
     If   TipoMovimientoCtrl.Editing
     then ResetTab;
     With CodigoPropietarioCtrl do
       If   not Enabled
       then Clear;
end;

procedure TboxFfaForm.TipoMovimientoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTiposMovimientoAlmacen( Sender );
end;

procedure TboxFfaForm.TipoMovimientoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue, varSmallInt )
     then TipoMovimientoCtrl.Description := RsgCualquiera
     else TipoMovAlmacen.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TboxFfaForm.CodigoClaseCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClases1( TNroClase( Sender.Tag ), Sender );
end;

procedure TboxFfaForm.CodigoClaseCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( TNroClase( Sender.Tag ), False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TboxFfaForm.CodigoPropietarioCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   DataTipoMovimiento.Value in [ tmOferta..tmCompra ]
     then ConsultaProveedores( Sender )
     else ConsultaClientes( Sender );
end;

procedure TboxFfaForm.CodigoPropietarioCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then CodigoPropietarioCtrl.Description := RsgMsgTodos
     else If   DataTipoMovimiento.Value in [ tmOferta..tmCompra ]
          then Proveedor.Valida( Sender, DisplayValue, ErrorText, Error )
          else Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TboxFfaForm.CodigoClaseCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClases( [ TNroClase( Sender.Tag ), Sender.EditingValue ] );
end;

end.
