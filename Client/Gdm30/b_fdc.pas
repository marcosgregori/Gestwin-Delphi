
unit b_fdc;

interface

uses AppForms, StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics,

     AppContainer,
     Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, DB, dxmdaset, DataManager,

  cxCheckBox, dxSkinsCore, cxGraphics, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox,

  AppManager,

  dmi_mov,

  dm_mov, dxUIAClasses;

type

  TBoxFdcForm = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataSerieNroFactura: TWideStringField;
    SerieNroFacturaCtrl: TcxDBTextEdit;
    Label4: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure FormManagerOkButton;
    procedure NroDocumentoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerInitializeForm;
    procedure NroDocumentoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
  private
     class var
     FTipoMovimiento : TTipoMovimientoCompra;
     FCodigoProveedorCtrl : TcxDBTextEdit;
     FOnSelected : TSimpleEvent;
  public

  end;

var
  BoxFdcForm: TBoxFdcForm = nil;

procedure CreaFacturaCompra( CodigoProveedorCtrl : TcxDBTextEdit;
                             OnSelected          : TSimpleEvent );

implementation

{$R *.DFM}

uses   Variants,
       LibUtils,

       dm_fdc,

       cx_fdc;

resourceString
       RsMsg2  = 'Ya existe un documento con esta clave.';
       RsMsg3  = 'Indique una serie y número de factura distintos.';

procedure CreaFacturaCompra( CodigoProveedorCtrl : TcxDBTextEdit;
                             OnSelected          : TSimpleEvent );
begin
     TBoxFdcForm.FCodigoProveedorCtrl := CodigoProveedorCtrl;
     TBoxFdcForm.FOnSelected := OnSelected;
     CreateEditForm( TBoxFdcForm, BoxFdcForm );
end;

procedure TBoxFdcForm.FormManagerInitializeForm;
begin
     //..
end;

procedure TBoxFdcForm.FormManagerOkButton;
begin
     If   Assigned( fOnSelected )
     then fOnSelected;
end;

procedure TBoxFdcForm.NroDocumentoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFacturasCompra( FCodigoProveedorCtrl.DataBinding.Field, nil, qgsNormal );
end;

procedure TBoxFdcForm.NroDocumentoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   FacturaCompras.Obten( ApplicationContainer.Ejercicio, FCodigoProveedorCtrl.EditValue, VarToStr( DisplayValue ) )
     then begin
          Error := True;
          ErrorText := JoinMessage( RsMsg2, RsMsg3 );
          end;
end;

end.
