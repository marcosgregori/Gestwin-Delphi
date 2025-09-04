
unit b_edv;

interface

uses AppForms, StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics,

     Dialogs,

     Menus, cxLookAndFeelPainters, cxButtons, cxGraphics, DB, nxdb, Generics.Collections,
     DataManager, cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit,
     cxMaskEdit, cxDropDownEdit, cxIndexedComboBox, dxmdaset, cxGroupBox, cxIntegerEdit,
     cxRadioGroup, cxLookAndFeels, cxLabel, cxCheckBox, dxSkinsCore, dxSkinsDefaultPainters,

     AppManager,
     LibUtils,
     AppContainer,

     Gim10Fields,
     Gim30Fields,

     dmi_mov, dxUIAClasses;

type

  TOnGetLineaMovimientoFieldsEvent = function : TLineaMovimientoFields of object;
  TOnGetGrupoLineaMovimientoFieldsEvent = function : TGrupoLineaMovimientoFields of object;

  TBoxEdvForm = class(TgxForm)
    FormManager: TgxFormManager;
    dataPanel: TgxEditPanel;
    SerieCtrl: TcxDBTextEdit;
    PropietarioCtrl: TcxDBTextEdit;
    Data: TgxMemData;
    DataSerie: TWideStringField;
    DataSource: TDataSource;
    DataTipoMovimiento: TSmallintField;
    DataPropietario: TWideStringField;
    DataNroDocumento: TIntegerField;
    TipoMovimientoCtrl: TcxDBRadioGroup;
    DataDocumentoAutomatico: TBooleanField;
    DocumentoAutomaticoCtrl: TcxDBCheckBox;
    DataSoloCantidadesPendientes: TBooleanField;
    SoloCantidadesPendientesCtrl: TcxDBCheckBox;
    Label4: TcxLabel;
    CapSerieLabel: TcxLabel;
    CaptionPropietarioLabel: TcxLabel;
    DescPropietarioLabel: TcxLabel;
    Label3: TcxLabel;
    TipoMovimientoLabel: TcxLabel;
    NroDocumentoCtrl: TcxDBIntegerEdit;
    Label2: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    MovimientoExpTable: TnxeTable;
    TodasLasLineasCtrl: TcxDBCheckBox;
    DataTodasLasLineas: TBooleanField;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure TipoMovimientoCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure NroDocumentoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure PropietarioCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure PropietarioCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure NroDocumentoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure DocumentoAutomaticoCtrlPropertiesChange(Sender: TObject);
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure PropietarioCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
  private

    TipoMovimientoAnterior : TTipoMovimiento;

    MovimientoExpFields : TMovimientoFields;
    GrupoLineaMovimientoExpFields : TGrupoLineaMovimientoFields;
    LineaMovimientoExpFields : TLineaMovimientoFields;

  protected
  class var
    Serie : String;
    CodigoCliente : String;
    TiposMovimientoDestino : TTiposMovimiento;
    TipoMovimientoOrigen : TTipoMovimiento;
    UltimoTipoMovimiento : TTipoMovimiento;
    OnExportaDocumento : TSimpleEvent;

    MovimientoOrigenFields : TMovimientoFields;

  end;

var
  BoxEdvForm: TBoxEdvForm = nil;

procedure ExportaDocumentoVenta( Serie                  : String;
                                 CodigoCliente          : String;
                                 TiposMovimientoDestino : TTiposMovimiento;
                                 TipoMovimientoOrigen   : TTipoMovimiento;
                                 MovimientoOrigenFields : TMovimientoFields;
                                 OnExportaDocumento     : TSimpleEvent = nil );

implementation

{$R *.DFM}

uses   SysUtils,

       nxllException,

       DataAccess,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,

       MovimientoIntf,

       dm_pga,
       dm_reg,
       dm_cli,
       dm_pro,
       dm_sdf,
       dm_art,
       dm_sto,
       dm_rcl,
       dm_fdc,
       dm_mov,

       a_mco,
       a_mve,
       a_cli,
       a_pro,
       a_sdf,

       b_msg,
       b_mve,

       cx_cli,
       cx_pro,
       cx_mco,
       cx_mve,
       cx_sdf;

resourceString
   RsMsg1  = 'Nº de presupuesto';
   RsMsg2  = 'Nº de pedido';
   RsMsg3  = 'Nº de albarán';

   RsMsg7  = 'Proveedor';
   RsMsg8  = 'Cliente';
   RsMsg9  = 'Ya existe un documento con ese número.';

   // Parámetros del registro

   ncrExportarTodasLasLineasVentas = 'ExportarTodasLasLineasVentas';

procedure ExportaDocumentoVenta( Serie                  : String;
                                 CodigoCliente          : String;
                                 TiposMovimientoDestino : TTiposMovimiento;
                                 TipoMovimientoOrigen   : TTipoMovimiento;
                                 MovimientoOrigenFields : TMovimientoFields;
                                 OnExportaDocumento     : TSimpleEvent = nil );
begin
     TBoxEdvForm.Serie := Serie;
     TBoxEdvForm.CodigoCliente := CodigoCliente;
     TBoxEdvForm.TiposMovimientoDestino := TiposMovimientoDestino;
     TBoxEdvForm.TipoMovimientoOrigen := TipoMovimientoOrigen;
     TBoxEdvForm.OnExportaDocumento := OnExportaDocumento;
     TBoxEdvForm.MovimientoOrigenFields := MovimientoOrigenFields;

     CreateEditForm( TboxEdvForm, BoxEdvForm );
end;

procedure TBoxEdvForm.TipoMovimientoCtrlPropertiesEditValueChanged(Sender: TObject);

var  TipoMovimiento : SmallInt;

begin
     With TipoMovimientoCtrl do
       begin

       TipoMovimiento := VarToInteger( EditValue );

       case TipoMovimiento of
         tmPedidoCompra,
         tmPedidoVenta :
           TipoMovimientoLabel.Caption := RsMsg2;

         tmVenta :
           begin
           TipoMovimientoLabel.Caption := RsMsg3;
           SerieCtrl.Enabled := Movimiento.SeriesEnDocumentosVenta( TipoMovimiento );
           If   not SerieCtrl.Enabled
           then SerieCtrl.Clear;
           end;

         end;

       If   TipoMovimiento=tmPedidoCompra
       then CaptionPropietarioLabel.Caption := RsMsg7
       else CaptionPropietarioLabel.Caption := RsMsg8;

       If   Editing
       then If   ( ( TipoMovimientoAnterior<>tmPedidoCompra ) and ( TipoMovimiento=tmPedidoCompra ) ) or
                 ( ( TipoMovimientoAnterior=tmPedidoCompra ) and ( TipoMovimiento<>tmPedidoCompra ) )
            then begin
                 DataPropietario.Clear;
                 PropietarioCtrl.ClearDescription;
                 end;

       SoloCantidadesPendientesCtrl.Enabled := ( TipoMovimientoOrigen=tmPedidoVenta ) and ( TipoMovimiento=tmPedidoCompra );
       TipoMovimientoAnterior := TipoMovimiento;
       end;
end;

procedure TBoxEdvForm.PropietarioCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     With PropietarioCtrl do
       If   DataTipoMovimiento.Value=tmPedidoCompra
       then MntProveedores( [ EditingValue ] )
       else MntClientes(  [ EditingValue ] );
end;

procedure TBoxEdvForm.PropietarioCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   DataTipoMovimiento.Value=tmPedidoCompra
     then ConsultaProveedores( Sender )
     else ConsultaClientes( Sender );
end;

procedure TBoxEdvForm.PropietarioCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   DataTipoMovimiento.Value=tmPedidoCompra
     then Proveedor.Valida( Sender, DisplayValue, ErrorText, Error )
     else Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxEdvForm.DocumentoAutomaticoCtrlPropertiesChange(Sender: TObject);
begin
     NroDocumentoCtrl.Enabled := not DocumentoAutomaticoCtrl.Checked;
end;

procedure TBoxEdvForm.FormManagerOkButton;
begin
     Registro.GuardaValorUsuario( ncrExportarTodasLasLineasVentas, BoolToStr( DataTodasLasLineas.Value, True ) );
     If   Assigned( OnExportaDocumento )
     then OnExportaDocumento;
end;

procedure TBoxEdvForm.FormManagerInitializeForm;
begin

     MovimientoExpFields := TMovimientoFields.Create( MovimientoExpTable );

     With TipoMovimientoCtrl.Properties do
       begin
       Items[ 0 ].Enabled := tmPedidoCompra in TiposMovimientoDestino;
       Items[ 1 ].Enabled := tmPedidoVenta in TiposMovimientoDestino;
       Items[ 2 ].Enabled := tmVenta in TiposMovimientoDestino;
       end;

     DataSerie.Value := Serie;
     If   UltimoTipoMovimiento<>tmPedidoCompra
     then DataPropietario.Value := CodigoCliente;
     DescPropietarioLabel.Caption := Cliente.Descripcion( CodigoCliente, True );
     DataTipoMovimiento.Value := GetFirstEnabledButtonValue( TipoMovimientoCtrl );
     DataDocumentoAutomatico.Value := True;
     DataTodasLasLineas.Value := Registro.ValorUsuarioActivo( ncrExportarTodasLasLineasVentas );

     If   UltimoTipoMovimiento=0
     then DataTipoMovimiento.Value := tmVenta  // Por defecto, albaranes de venta
     else DataTipoMovimiento.Value := UltimoTipoMovimiento;

     SetFirstEnabledButtonValue( TipoMovimientoCtrl );

end;

procedure TBoxEdvForm.NroDocumentoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   DataTipoMovimiento.Value=tmPedidoCompra
     then ConsultaMovimientosCompra( DataTipoMovimiento.Value, sdTodos, DataPropietario, Sender )
     else ConsultaMovimientosVenta( DataTipoMovimiento.Value, sdTodos, DataSerie, Sender, qgsNormal, DataPropietario.Value )
end;

procedure TBoxEdvForm.NroDocumentoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var   NroDocumento : Integer;

begin

     // TipoMovimiento;Ejercicio;Propietario;Serie;NroDocumento

     NroDocumento := VarToInteger( DisplayValue );

     With DataNroDocumento, MovimientoExpTable do
       If   ValueIsEmpty( DataPropietario.Value )
       then begin
            IndexFieldNames := 'TipoMovimiento;Ejercicio;Serie;NroDocumento';
            ValidateRelation( NroDocumentoCtrl, MovimientoExpTable, [ DataTipoMovimiento.Value, ApplicationContainer.Ejercicio, '', NroDocumento ], DisplayValue, ErrorText, Error );
            end
       else begin
            IndexFieldNames := 'TipoMovimiento;Ejercicio;Propietario;Serie;NroDocumento';
            ValidateRelation( NroDocumentoCtrl, MovimientoExpTable, [ DataTipoMovimiento.Value, ApplicationContainer.Ejercicio, DataPropietario.Value, '', NroDocumento ], DisplayValue, ErrorText, Error );
            end;

     // Si no hay error es que ya existe el documento en cuestión

     If   Error
     then Error := False
     else begin
          Error := True;
          ErrorText := RsMsg9;
          end;

end;

procedure TBoxEdvForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TBoxEdvForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

end.

