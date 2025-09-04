
unit i_fdc;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,

     AppContainer,
     Gim30Fields,
     ComCtrls,
     DB,
     DataManager,
     ReportManager, Menus, cxLookAndFeelPainters, cxButtons, cxGraphics,
     cxMaskEdit, cxDropDownEdit, cxDBEdit, cxCheckBox, cxControls,
     cxContainer, cxEdit, cxTextEdit, cxPC, dxmdaset, cxCalendar,
     cxIndexedComboBox, cxSpinEdit,

     cxLookAndFeels, dxSkinsCore, dxSkinscxPCPainter,
     dxSkinsDefaultPainters, cxLabel, cxGroupBox, cxPCdxBarPopupMenu,
     dxBarBuiltInMenu,

     dm_fdc,
     ParametrosFacturacionIntf;


type
    TFrpFdcForm = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    TabSheet2: TcxTabSheet;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataProveedorInicial: TWideStringField;
    DataProveedorFinal: TWideStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataProveedor: TWideStringField;
    DataSerieNroFacturaInicial: TWideStringField;
    DataSerieNroFacturaFinal: TWideStringField;
    ProveedorCtrl: TcxDBTextEdit;
    SerieNroFacturaInicialCtrl: TcxDBTextEdit;
    SerieNroFacturaFinalCtrl: TcxDBTextEdit;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox3: TgxRangeBox;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    ProveedorInicialCtrl: TcxDBTextEdit;
    ProveedorFinalCtrl: TcxDBTextEdit;
    FormatoCtrl: TcxDBSpinEdit;
    DataFormato: TSmallintField;
    gxRangeBox2: TgxRangeBox;
    Label5: TcxLabel;
    Label8: TcxLabel;
    FormatoLabel: TcxLabel;
    Label1: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label6: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    Label7: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure ProveedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure CodigoProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure DocumentoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerPreparedForm;
    private

    protected
    class var
      TipoSeleccion : TTipoSeleccionAlbaranes;
      Ejercicio : SmallInt;
      SerieNroFactura : String;
      CodigoProveedorInicial,
      CodigoProveedorFinal : String;
      FechaInicial,
      FechaFinal : TDateTime;
    public

    end;

var
  FrpFdcForm: TFrpFdcForm = nil;

procedure ImpresionFacturasCompra( Ejercicio        : SmallInt;
                                   CodigoProveedor  : String;
                                   SerieNroFactura  : String );

procedure ImpresionFacturasCompraPorFecha( CodigoProveedorInicial,
                                           CodigoProveedorFinal    : String;
                                           FechaInicial,
                                           FechaFinal              : TDateTime );

implementation

uses   SysUtils,
       DateUtils,
       nxsdDataDictionaryStrings,

       Gim00Fields,

       dm_pro,
       dm_ine,

       a_imp,

       b_msg,

       cx_fdc,
       cx_pro,
       cx_imp;

{$R *.DFM}

procedure ImpresionFacturasCompra( Ejercicio        : SmallInt;
                                   CodigoProveedor  : String;
                                   SerieNroFactura  : String );
begin
     TFrpFdcForm.TipoSeleccion :=tsDocumento;
     TFrpFdcForm.Ejercicio := Ejercicio;
     TFrpFdcForm.SerieNroFactura := SerieNroFactura;
     TFrpFdcForm.CodigoProveedorInicial := CodigoProveedor;
     CreateReportForm( TFrpFdcForm, FrpFdcForm );
end;

procedure ImpresionFacturasCompraPorFecha( CodigoProveedorInicial,
                                           CodigoProveedorFinal    : String;
                                           FechaInicial,
                                           FechaFinal              : TDateTime );
begin
     TFrpFdcForm.TipoSeleccion := tsFecha;
     TFrpFdcForm.CodigoProveedorInicial := CodigoProveedorInicial;
     TFrpFdcForm.CodigoProveedorFinal := CodigoProveedorFinal;
     TFrpFdcForm.FechaInicial := FechaInicial;
     TFrpFdcForm.FechaFinal := FechaFinal;  
     CreateReportForm( TFrpFdcForm, FrpFdcForm );
end;

procedure TFrpFdcForm.InitializeForm;
begin
     case TipoSeleccion of
       tsDocumento :
         begin
         DataProveedor.Value := CodigoProveedorInicial;
         DataSerieNroFacturaInicial.Value := SerieNroFactura;
         DataSerieNroFacturaFinal.Value := SerieNroFactura;
         DataProveedorFinal.Value := HighStrCode;
         DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
         DataFechaFinal.Value := ApplicationContainer.TodayDate;
         end;

       tsFecha :
         begin;
         DataProveedorInicial.Value := CodigoProveedorInicial;
         DataProveedorFinal.Value := CodigoProveedorFinal;
         DataFechaInicial.Value := FechaInicial;
         DataFechaFinal.Value := FechaFinal;
         end;

       end;

end;

procedure TFrpFdcForm.FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntImpresos( [ Ord( impFacturasCompra ), Sender.EditingValue ] );
end;

procedure TFrpFdcForm.FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaImpresos( impFacturasCompra, Sender );
end;

procedure TFrpFdcForm.FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     InformeExterno.Valida( impFacturasCompra, Sender, DisplayValue, ErrorText, Error );
end;

procedure TFrpFdcForm.FormManagerOkButton;

var  ParametrosFacturacion : IParametrosFacturacion;

begin
     Enabled := False;
     ParametrosFacturacion := TParametrosFacturacion.Create;

     With ParametrosFacturacion do
       begin

       TipoSeleccion := TTipoSeleccionAlbaranes( PageControl.ActivePageIndex );

       Formato := DataFormato.Value;

       case TipoSeleccion of
         tsDocumento :
           begin
           EjercicioFactura := Ejercicio;
           CodigoPropietario := DataProveedor.Value;
           SerieInicial := DataSerieNroFacturaInicial.Value;
           SerieFinal := DataSerieNroFacturaFinal.Value;
           end;
         tsFecha :
          begin
          PropietarioInicial := DataProveedorInicial.Value;
          PropietarioFinal := DataProveedorFinal.Value;
          FechaInicial := DataFechaInicial.Value;
          FechaFinal := DataFechaFinal.Value;
          end;

         end;

       FacturaCompras.ImprimeFacturas( ParametrosFacturacion );

       end;
end;

procedure TFrpFdcForm.FormManagerPreparedForm;
begin
     If   TipoSeleccion=tsFecha
     then PageControl.ActivePageIndex := 1;
end;

procedure TFrpFdcForm.CodigoProveedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TFrpFdcForm.ProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TFrpFdcForm.DocumentoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFacturasCompra( DataProveedor, Sender, qgsNormal, nil, { LockRange } True );
end;

procedure TFrpFdcForm.ProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

end.

