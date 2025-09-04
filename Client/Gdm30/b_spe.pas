
unit b_spe;

interface

uses AppForms, StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics,


     Menus, cxLookAndFeelPainters, cxButtons, cxGraphics, DB, nxdb,
  DataManager, cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxIndexedComboBox, dxmdaset, cxGroupBox,
  cxRadioGroup, dxSkinsCore, dxSkinsDefaultPainters, cxLookAndFeels, cxLabel,

  AppManager,
  AppContainer,
  Dialogs,

  Gim30Fields,

  dmi_mov, dxUIAClasses;

type

  TBoxSpvForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    PedidoTable: TnxeTable;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Data: TgxMemData;
    DataSerie: TWideStringField;
    DataSource: TDataSource;
    DataEjercicio: TSmallintField;
    DataNroDocumento: TIntegerField;
    DataNroOperacionPedido: TIntegerField;
    LineaPedidoTable: TnxeTable;
    cxGroupBox3: TcxGroupBox;
    CapSerieLabel: TcxLabel;
    SerieCtrl: TcxDBTextEdit;
    Label3: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    EjercicioCtrl: TcxDBTextEdit;
    Label1: TcxLabel;
    TipoMovimientoLabel: TcxLabel;
    NroDocumentoCtrl: TcxDBTextEdit;
    Label2: TcxLabel;
    LineaAlbaranTable: TnxeTable;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure NroDocumentoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure NroDocumentoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
  private

    PedidoFields : TMovimientoFields;
    LineaPedidoFields,
    LineaAlbaranFields : TLineaMovimientoFields;

    TipoDocumentoDestino : TTipoMovimiento;

    procedure DoOnSelectPedido( Target : TcxCustomEdit = nil );

  protected
    class var
    AlbaranEdicionFields : TMovimientoFields;
    LineaAlbaranEdicionFields : TLineaMovimientoFields;
    OnSelected : TSimpleEvent;

  public

  end;

var
  BoxSpvForm: TBoxSpvForm = nil;

resourceString

   RsMsg3  = 'Se ha producido error durante el proceso de vinculación.';
   RsMsg4  = 'Se ha cancelado el proceso. El estado del documento no se ha visto modificado.';

// Esta ventana solo debe utilizarse desde a_mve

procedure VincularAPedido( AlbaranEdicionFields      : TMovimientoFields;
                           LineaAlbaranEdicionFields : TLineaMovimientoFields;
                           OnSelected                : TSimpleEvent = nil );

implementation

{$R *.DFM}

uses   SysUtils,
       LibUtils,

       nxllException,

       DataAccess,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,

       dm_pga,
       dm_art,
       dm_cli,
       dm_sdf,
       dm_sto,
       dm_mov,

       a_mve,

       b_msg,

       cx_sdf,
       cx_mco,
       cx_mve;

procedure VincularAPedido( AlbaranEdicionFields      : TMovimientoFields;
                           LineaAlbaranEdicionFields : TLineaMovimientoFields;
                           OnSelected                : TSimpleEvent = nil );
begin
     TBoxSpvForm.AlbaranEdicionFields := AlbaranEdicionFields;
     TBoxSpvForm.LineaAlbaranEdicionFields := LineaAlbaranEdicionFields;
     TBoxSpvForm.OnSelected := OnSelected;
     CreateEditForm( TBoxSpvForm, BoxSpvForm );
end;

procedure TBoxSpvForm.FormManagerInitializeForm;
begin
     PedidoFields := TMovimientoFields.Create( PedidoTable );
     LineaPedidoFields := TLineaMovimientoFields.Create( LineaPedidoTable );
     LineaAlbaranFields := TLineaMovimientoFields.Create( LineaAlbaranTable );

     DataEjercicio.Value := ApplicationContainer.Ejercicio;
     DataSerie.Value := AlbaranEdicionFields.Serie.Value;

     SetupPanelableCtrl( SerieCtrl, Movimiento.SeriesEnDocumentosVenta( tmPedidoVenta ), True );

     If   AlbaranEdicionFields.TipoMovimiento.Value=tmVenta
     then TipoDocumentoDestino := tmPedidoVenta
     else TipoDocumentoDestino := tmPedidOCompra;
end;

procedure TBoxSpvForm.NroDocumentoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   TipoDocumentoDestino=tmPedidoVenta
     then ConsultaMovimientosVenta( TipoDocumentoDestino,
                                    sdPendientes,
                                    DataSerie,
                                    Sender,
                                    qgsNormal,
                                    AlbaranEdicionFields.Propietario.Value,
                                    DoOnSelectPedido )
     else ConsultaMovimientosCompra( TipoDocumentoDestino, sdPendientes, AlbaranEdicionFields.Propietario, Sender, qgsNormal, DoOnSelectPedido );
end;

procedure TBoxSpvForm.DoOnSelectPedido;
begin
     If   TipoDocumentoDestino=tmPedidoVenta
     then With CxMveForm[ tmPedidoVenta ] do
            begin
            EjercicioCtrl.PostEditValue( QueryEjercicio.Value );
            SerieCtrl.PostEditValue( QuerySerie.Value );
            NroDocumentoCtrl.PostEditValue( QueryNroDocumento.Value );
            end
     else With CxMcoForm[ tmPedidoCompra ] do
            begin
            EjercicioCtrl.PostEditValue( QueryEjercicio.Value );
            NroDocumentoCtrl.PostEditValue( QueryNroDocumento.Value );
            end;
end;

procedure TBoxSpvForm.NroDocumentoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var   NroDocumento : Integer;

begin
     NroDocumento := VarToInteger( DisplayValue );
     ValidateRelation( NroDocumentoCtrl, PedidoTable, [ TipoDocumentoDestino, DataEjercicio.Value, AlbaranEdicionFields.Propietario.Value, DataSerie.Value, NroDocumento ], DisplayValue, ErrorText, Error );
     DataNroOperacionPedido.Value := PedidoFields.NroOperacion.Value;
end;

procedure TBoxSpvForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TBoxSpvForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxSpvForm.FormManagerOkButton;
begin
     If   Movimiento.VincularAlbaranAPedido( AlbaranEdicionFields.NroOperacion.Value, LineaAlbaranEdicionFields.NroPagina.Value, DataEjercicio.Value, DataNroOperacionPedido.Value )
     then With AlbaranEdicionFields.Table do
            begin
            Cancel;
            ReloadRecord;
            end;
end;

end.

