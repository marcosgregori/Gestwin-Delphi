
unit b_efc;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  ComCtrls,

  Menus, cxLookAndFeelPainters, cxButtons, nxdb, DataManager, DB,
  dxmdaset, cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxCheckBox,

  dm_fdc, cxGraphics, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters,
  cxLabel, cxGroupBox, dxUIAClasses;


type
    TBoxEfcForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    ImprimirCtrl: TcxDBCheckBox;
    FechaAlbaranInicialCtrl: TcxDBDateEdit;
    FechaAlbaranFinalCtrl: TcxDBDateEdit;
    FechaFacturacionCtrl: TcxDBDateEdit;
    ProveedorInicialCtrl: TcxDBTextEdit;
    ProveedorFinalCtrl: TcxDBTextEdit;
    SerieCtrl: TcxDBTextEdit;
    Data: TgxMemData;
    DataSerieFacturacion: TWideStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataProveedorInicial: TWideStringField;
    DataProveedorFinal: TWideStringField;
    DataFechaFacturacion: TDateField;
    DataImprimir: TBooleanField;
    DataSource: TDataSource;
    RelacionAlbaranesTable: TnxeTable;
    gxRangeBox2: TgxRangeBox;
    gxRangeBox1: TgxRangeBox;
    Label4: TcxLabel;
    Label12: TcxLabel;
    Label1: TcxLabel;
    Label6: TcxLabel;
    desTipoAstoLabel: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ProveedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

    public
      
      procedure doProcess;
    end;

var
  BoxEfcForm : TBoxEfcForm = nil;

procedure EmisionFacturasCompra;


implementation

uses   ParametrosFacturacionIntf,

       Gdm30Frm,

       dm_ast,
       dm_pro,

       b_msg,
       b_pro,
       i_fdc,

       cx_pro;

{$R *.DFM}

procedure EmisionFacturasCompra;
begin
     CreateEditForm( TBoxEfcForm, BoxEfcForm, TGds30Frm.ComprasSection, True );
end;

procedure TBoxEfcForm.InitializeForm;
begin
     DataProveedorFinal.Value := HighStrCode;
     DataFechaInicial.Value := ApplicationContainer.FirstDayOfYearDate;
     DataFechaFinal.Value   := ApplicationContainer.TodayDate;
     DataFechaFacturacion.Value := ApplicationContainer.TodayDate;

     Asiento.CompruebaEjercicioCerrado;
end;

procedure TBoxEfcForm.ProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TBoxEfcForm.ProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TBoxEfcForm.FormManagerOkButton;
begin
     CreateProcessForm( DoProcess, Caption );
end;

procedure TBoxEfcForm.DoProcess;

var  ParametrosFacturacion : IParametrosFacturacion;

begin
     ParametrosFacturacion := TParametrosFacturacion.Create;

     With ParametrosFacturacion do
       begin

       { Cuando se indica la serie genérica se seleccionan todos los albaranes pendientes de facturar, sea cual sea su serie y,
         cuando se especifica una serie, solo se seleccionan los albaranes de esa serie.
         Este comportamiento es intencionado y es el que desean los clientes que lo utilizan }

       Serie := DataSerieFacturacion.Value;
       TipoSeleccion := tsFecha;
       FechaInicial := DataFechaInicial.Value;
       FechaFinal := DataFechaFinal.Value;
       FechaFacturacion := DataFechaFacturacion.Value;
       PropietarioInicial := DataProveedorInicial.Value;
       PropietarioFinal := DataProveedorFinal.Value;

       ParametrosFacturacion := FacturaCompras.GeneraFacturas( ParametrosFacturacion, RelacionAlbaranesTable );

       If   DataImprimir.Value
       then ImpresionFacturasCompraPorFecha( PropietarioInicial, PropietarioFinal, FechaInicial, FechaFinal );

      end;

end;


end.
