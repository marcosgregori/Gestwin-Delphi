
unit b_sdc;

interface

uses AppForms, StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics,

     AppContainer, Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset, DataManager,
     cxGroupBox, cxRadioGroup, cxDBEdit, cxControls, cxContainer, cxEdit,
     cxTextEdit, nxdb,

     dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
     cxLabel,

     AppManager,

     Gim30Fields,

     dmi_mov, dxUIAClasses;

type

  TBoxSdcForm = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    NroDocumentoCtrl: TcxDBTextEdit;
    EjercicioCtrl: TcxDBTextEdit;
    MovimientoTable: TnxeTable;
    TipoMovimientoCtrl: TcxDBRadioGroup;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataTipoMovimiento: TSmallintField;
    DataEjercicio: TSmallintField;
    DataNroDocumento: TIntegerField;
    PropietarioCtrl: TcxDBTextEdit;
    DataPropietario: TWideStringField;
    DataNroOperacion: TIntegerField;
    SerieCtrl: TcxDBTextEdit;
    DataSerie: TWideStringField;
    TipoMovimientoLabel: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    CaptionProveedorLabel: TcxLabel;
    DescProveedorLabel: TcxLabel;
    CapSerieLabel: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DescSerieLabel: TcxLabel;
    TopPanel: TcxGroupBox;
    FicheroPanel: TcxGroupBox;
    ExaminarButton: TgBitBtn;
    captionFicheroDatosLabel: TcxLabel;
    FicheroDatosBox: TcxLabel;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure NroDocumentoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure NroDocumentoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TipoMovimientoCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure CodigoPropietarioCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPropietarioCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ExaminarButtonClick(Sender: TObject);
  private

    MovimientoFields : TMovimientoFields;

    procedure DoOnSelectMovimientoCompra( Target : TcxCustomEdit = nil );
    procedure DoOnSelectMovimientoVenta( Target : TcxCustomEdit = nil );
    procedure FijaTipoMovimiento( TipoMovimiento : SmallInt );

  protected
  class var
    CodigoProveedor : String;
    TipoMovimientoDestino : TTipoMovimiento;
    TiposMovimiento : TTiposMovimiento;
    OnSelected : TSimpleEvent;
  public
    TipoMovimientoAnterior : SmallInt;
  end;

var
  BoxSdcForm: TBoxSdcForm = nil;

procedure SeleccionaDocumento( CodigoProveedor       : String;
                               OnSelected            : TSimpleEvent;
                               TipoMovimientoDestino : TTipoMovimiento;
                               TiposMovimiento       : TTiposMovimiento );

implementation

{$R *.DFM}

uses   SysUtils,
       LibUtils,

       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,

       b_msg,

       dm_pga,
       dm_cli,
       dm_pro,
       dm_sdf,
       dm_mov,

       cx_cli,
       cx_pro,
       cx_sdf,
       cx_mco,
       cx_mve;

resourceString
       RsMsg1  = 'Nº de oferta';
       RsMsg2  = 'Nº de pedido';
       
       RsMsg6  = 'Proveedor';
       RsMsg7  = 'Cliente';

       RsMsg10 = 'Indique el origen pulsando [Examinar...].';

procedure SeleccionaDocumento( CodigoProveedor       : String;
                               OnSelected            : TSimpleEvent;
                               TipoMovimientoDestino : TTipoMovimiento;
                               TiposMovimiento       : TTiposMovimiento );
begin
     TBoxSdcForm.CodigoProveedor := CodigoProveedor;
     TBoxSdcForm.TiposMovimiento := TiposMovimiento;
     TBoxSdcForm.TipoMovimientoDestino := TipoMovimientoDestino;
     TBoxSdcForm.OnSelected := OnSelected;

     CreateEditForm( TBoxSdcForm, BoxSdcForm );
end;

procedure TBoxSdcForm.FormManagerOkButton;
begin

     // Primero compruebo si el documento está libre

     Movimiento.CompruebaMovimientoLibre( MovimientoTable );

     If   Assigned( OnSelected )
     then OnSelected;
end;

procedure TBoxSdcForm.NroDocumentoCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     If   DataTipoMovimiento.Value=tmPedidoVenta
     then ConsultaMovimientosVenta( DataTipoMovimiento.Value, sdTodos, DataSerie, Sender, qgsNormal, DataPropietario.Value, DoOnSelectMovimientoVenta )
     else ConsultaMovimientosCompra( DataTipoMovimiento.Value, sdPendientes, DataPropietario, Sender, qgsNormal, DoOnSelectMovimientoCompra );
end;

procedure TBoxSdcForm.CodigoPropietarioCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   DataTipoMovimiento.Value=tmPedidoVenta
     then ConsultaClientes( Sender )
     else ConsultaProveedores( Sender );
end;

procedure TBoxSdcForm.CodigoPropietarioCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then PropietarioCtrl.Description := RsgCualquiera
     else If   DataTipoMovimiento.Value=tmPedidoVenta
          then Cliente.Valida( Sender, DisplayValue, ErrorText, Error )
          else Proveedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxSdcForm.DoOnSelectMovimientoCompra;
begin
     With CxMcoForm[ DataTipoMovimiento.Value ] do
       begin
       EjercicioCtrl.PostEditValue( QueryEjercicio.Value );
       SerieCtrl.PostEditValue( QuerySerie.Value );
       NroDocumentoCtrl.PostEditValue( QueryNroDocumento.Value );
       end;
end;

procedure TBoxSdcForm.DoOnSelectMovimientoVenta;
begin
     With CxMveForm[ DataTipoMovimiento.Value ] do
       begin
       EjercicioCtrl.PostEditValue( QueryEjercicio.Value );
       SerieCtrl.PostEditValue( QuerySerie.Value );
       NroDocumentoCtrl.PostEditValue( QueryNroDocumento.Value );
       end;
end;

procedure TBoxSdcForm.ExaminarButtonClick(Sender: TObject);
begin
     With ApplicationForms.OpenFileDialog do
       begin
       Filter := 'Ficheros de texto (*.*)|*.*';
       If   Execute
       then With Configuracion do
              begin
              ParametrosUsrRec.PathFicheroDatosCapturador := FileName;
              GuardaParametros( ctUsuario, CodigoUsuarioActual, TParametrosRec( ParametrosUsrRec ) );
              FicheroDatosBox.Caption := ParametrosUsrRec.PathFicheroDatosCapturador;
              end;
       end;
end;

procedure TBoxSdcForm.NroDocumentoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var   NroDocumento : Integer;

begin

     // TipoMovimiento;Ejercicio;Propietario;Serie;NroDocumento

     NroDocumento := VarToInteger( DisplayValue );

     With DataNroDocumento, MovimientoTable do
       If   ValueIsEmpty( DataPropietario.Value )
       then begin
            IndexFieldNames := 'TipoMovimiento;Ejercicio;Serie;NroDocumento';
            ValidateRelation( NroDocumentoCtrl, MovimientoTable, [ DataTipoMovimiento.Value, DataEjercicio.Value, DataSerie.Value, NroDocumento ], DisplayValue, ErrorText, Error );
            end
       else begin
            IndexFieldNames := 'TipoMovimiento;Ejercicio;Propietario;Serie;NroDocumento';
            ValidateRelation( NroDocumentoCtrl, MovimientoTable, [ DataTipoMovimiento.Value, DataEjercicio.Value, DataPropietario.Value, DataSerie.Value, NroDocumento ], DisplayValue, ErrorText, Error );
            end;

     {
     If   not Error
     then If   DataTipoMovimiento.Value in [ tmPedidoCompra, tmPedidoVenta ]
          then If   MovimientoFields.Situacion.Value=epProcesado
               then begin
                    ErrorText := RsMsg5;
                    Error := True;
                    end;
     }

     DataNroOperacion.Value := MovimientoFields.NroOperacion.Value;
end;

procedure TBoxSdcForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TBoxSdcForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxSdcForm.TipoMovimientoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     FijaTipoMovimiento( VarToInteger( TipoMovimientoCtrl.EditValue ) );
end;

procedure TBoxSdcForm.FijaTipoMovimiento( TipoMovimiento : SmallInt );
begin
     With TipoMovimientoCtrl do
       begin

       If   TipoMovimiento=tmOferta
       then TipoMovimientoLabel.Caption := RsMsg1
       else TipoMovimientoLabel.Caption := RsMsg2;

       If   TipoMovimiento=tmPedidoVenta
       then CaptionProveedorLabel.Caption := RsMsg7
       else CaptionProveedorLabel.Caption := RsMsg6;

       PropietarioCtrl.Enabled := TipoMovimiento<>tmCapturador;

       If   ( ( TipoMovimientoAnterior in [ tmOferta, tmPedidoCompra ] ) and ( TipoMovimiento=tmPedidoVenta ) ) or
            ( ( TipoMovimientoAnterior=tmPedidoVenta ) and ( TipoMovimiento in [ tmOferta, tmPedidoCompra ] ) )
       then PropietarioCtrl.PostEditValue( '' );

       EjercicioCtrl.Enabled := TipoMovimiento in [ tmOferta, tmPedidoCompra, tmPedidoVenta ];
       NroDocumentoCtrl.Enabled := EjercicioCtrl.Enabled;
       SerieCtrl.Enabled := EjercicioCtrl.Enabled and Movimiento.SeriesEnDocumentosVenta( TipoMovimiento );

       FicheroDatosBox.Enabled := TipoMovimiento=tmCapturador;
       CaptionFicheroDatosLabel.Enabled := FicheroDatosBox.Enabled;
       ExaminarButton.Enabled := FicheroDatosBox.Enabled;

       TipoMovimientoAnterior := TipoMovimiento;
       end;
end;

procedure TBoxSdcForm.FormManagerInitializeForm;
begin
     MovimientoFields := TMovimientoFields.Create( MovimientoTable );

     With TipoMovimientoCtrl.Properties do
       begin
       Items[ 0 ].Enabled := tmOferta in TiposMovimiento;
       Items[ 1 ].Enabled := tmPedidoCompra in TiposMovimiento;
       Items[ 2 ].Enabled := tmPedidoVenta in TiposMovimiento;
       end;

     DataPropietario.Value := CodigoProveedor;
     DescProveedorLabel.Caption := Proveedor.Descripcion( CodigoProveedor, True );
     DataTipoMovimiento.Value := GetFirstEnabledButtonValue( TipoMovimientoCtrl );
     DataEjercicio.Value := ApplicationContainer.Ejercicio;

     SetFirstEnabledButtonValue( TipoMovimientoCtrl );

     With Configuracion.ParametrosUsrRec do
       If   PathFicheroDatosCapturador=''
       then FicheroDatosBox.Caption := RsMsg10
       else FicheroDatosBox.Caption := PathFicheroDatosCapturador;

end;

end.
