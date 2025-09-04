
unit b_sdv;

interface

uses AppForms, StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics,

     AppManager,
     AppContainer,
     Dialogs,

     Menus, cxLookAndFeelPainters, cxButtons, cxGraphics, DB, nxdb,
     DataManager, cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit,
     cxMaskEdit, cxDropDownEdit, cxIndexedComboBox, dxmdaset, cxGroupBox,
     cxRadioGroup, dxSkinsCore, dxSkinsDefaultPainters, cxLookAndFeels,
     cxLabel,dxBevel,

     dmi_mov,
     dm_mov,
     Gim30Fields, dxUIAClasses;

type

  TBoxSdvForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    MovimientoTable: TnxeTable;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Data: TgxMemData;
    DataSerie: TWideStringField;
    DataSource: TDataSource;
    DataTipoMovimiento: TSmallintField;
    DataEjercicio: TSmallintField;
    DataPropietario: TWideStringField;
    DataNroDocumento: TIntegerField;
    DataNroOperacion: TIntegerField;
    DocumentosMultiplesPanel: TcxGroupBox;
    Label4: TcxLabel;
    TipoMovimientoCtrl: TcxDBRadioGroup;
    DocumentoUnicoPanel: TcxGroupBox;
    cxLabel1: TcxLabel;
    TipoDocumentoLabel: TcxLabel;
    ParametrosPanel: TcxGroupBox;
    SerieCtrl: TcxDBTextEdit;
    NroDocumentoCtrl: TcxDBTextEdit;
    PropietarioCtrl: TcxDBTextEdit;
    EjercicioCtrl: TcxDBTextEdit;
    TipoMovimientoLabel: TcxLabel;
    CapSerieLabel: TcxLabel;
    CaptionPropietarioLabel: TcxLabel;
    DescPropietarioLabel: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    FicheroPanel: TcxGroupBox;
    ExaminarButton: TgBitBtn;
    captionFicheroDatosLabel: TcxLabel;
    FicheroDatosBox: TcxLabel;
    procedure FormManagerOkButton;
    procedure ExaminarButtonClick(Sender: TObject);
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
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure PropietarioCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
  private
    TipoMovimiento : SmallInt;
    TipoSeleccionDocumento : TSeleccionDocumento;
    MovimientoFields : TMovimientoFields;

    procedure FijaTipoMovimiento( TipoMovimiento : SmallInt );
    procedure DoOnSelectMovimientoCompra( Target : TcxCustomEdit = nil );
    procedure DoOnSelectMovimientoVenta( Target : TcxCustomEdit = nil );

  protected
    class var
    CodigoCliente : String;
    TiposMovimiento : TTiposMovimiento;
    TipoMovimientoDestino : TTipoMovimiento;
    UltimoTipoMovimiento : TTipoMovimiento;
    OnSelected : TSimpleEvent;

  public

    TipoMovimientoAnterior : SmallInt;

  end;

var
  BoxSdvForm: TBoxSdvForm = nil;

// Esta ventana solo debe utilizarse desde a_mve

procedure ImportaDocumentoVenta( CodigoCliente         : String;
                                 OnSelected            : TSimpleEvent;
                                 TipoMovimientoDestino : TTipoMovimiento;
                                 TiposMovimiento       : TTiposMovimiento;
                                 UltimoTipoMovimiento  : TTipoMovimiento = tmNoDefinido );

implementation

{$R *.DFM}

uses   SysUtils,
       LibUtils,

       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,

       dm_pga,
       dm_cli,
       dm_pro,
       dm_sdf,

       a_mve,
       a_pro,
       a_cli,

       b_msg,

       cx_cli,
       cx_pro,
       cx_sdf,
       cx_mco,
       cx_mve;

resourceString
   RsMsg1  = 'Nº de presupuesto';
   RsMsg2  = 'Nº de pedido';
   RsMsg3  = 'Nº de albarán';

   RsMsg7  = 'Proveedor';
   RsMsg8  = 'Cliente';

   RsMsg9  = 'No ha indicado el fichero en el que se encuentran los datos.';
   RsMsg10 = 'Indique el origen pulsando [Examinar...].';

procedure ImportaDocumentoVenta( CodigoCliente         : String;
                                 OnSelected            : TSimpleEvent;
                                 TipoMovimientoDestino : TTipoMovimiento;
                                 TiposMovimiento       : TTiposMovimiento;
                                 UltimoTipoMovimiento  : TTipoMovimiento = tmNoDefinido );
begin
     TBoxSdvForm.CodigoCliente := CodigoCliente;
     TBoxSdvForm.TiposMovimiento := TiposMovimiento;
     TBoxSdvForm.UltimoTipoMovimiento := UltimoTipoMovimiento;
     TBoxSdvForm.TipoMovimientoDestino := TipoMovimientoDestino;
     TBoxSdvForm.OnSelected := OnSelected;

     CreateEditForm( TBoxSdvForm, BoxSdvForm );
end;

procedure TBoxSdvForm.TipoMovimientoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     FijaTipoMovimiento( VarToInteger( TipoMovimientoCtrl.EditValue ) );
end;

procedure TBoxSdvForm.FijaTipoMovimiento( TipoMovimiento : SmallInt );
begin
     case TipoMovimiento of
       tmPresupuesto   : TipoMovimientoLabel.Caption := RsMsg1;
       tmPedidoCompra,
       tmPedidoVenta   : TipoMovimientoLabel.Caption := RsMsg2;
       tmVenta,
       tmCompra        : TipoMovimientoLabel.Caption := RsMsg3;
       end;

     // Si estamos importando desde la báscula o el capturador, no es necesario asignar propietario

     PropietarioCtrl.Enabled := not ( TipoMovimiento in [ { tmBascula, } tmCapturador ] );

     If   TipoMovimiento in [ tmPedidoCompra, tmCompra ]
     then CaptionPropietarioLabel.Caption := RsMsg7
     else CaptionPropietarioLabel.Caption := RsMsg8;

     If   ( not ( TipoMovimientoAnterior in [ tmPedidoCompra, tmCompra ] ) and ( TipoMovimiento in [ tmPedidoCompra, tmCompra ] ) ) or
          ( ( TipoMovimientoAnterior in [ tmPedidoCompra, tmCompra ] ) and not ( TipoMovimiento in [ tmPedidoCompra, tmCompra ] ) )
     then PropietarioCtrl.PostEditValue( '' );

     EjercicioCtrl.Enabled := TipoMovimiento in [ tmPresupuesto, tmPedidoCompra, tmPedidoVenta, tmCompra, tmVenta ];
     NroDocumentoCtrl.Enabled := EjercicioCtrl.Enabled;
     SerieCtrl.Enabled := EjercicioCtrl.Enabled and ( ( TipoMovimiento=tmCompra ) or Movimiento.SeriesEnDocumentosVenta( TipoMovimiento  ) );

     FicheroDatosBox.Enabled := TipoMovimiento in [ tmCapturador {, tmBascula } ];
     CaptionFicheroDatosLabel.Enabled := FicheroDatosBox.Enabled;
     ExaminarButton.Enabled := FicheroDatosBox.Enabled;

     TipoMovimientoAnterior := TipoMovimiento;

end;

procedure TBoxSdvForm.PropietarioCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     With PropietarioCtrl do
       If   DataTipoMovimiento.Value in [ tmPedidoCompra, tmCompra ]
       then MntProveedores( [ EditingValue ] )
       else MntClientes(  [ EditingValue ] );
end;

procedure TBoxSdvForm.PropietarioCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   DataTipoMovimiento.Value in [ tmPedidoCompra, tmCompra ]
     then ConsultaProveedores( Sender )
     else ConsultaClientes( Sender );
end;

procedure TBoxSdvForm.PropietarioCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then PropietarioCtrl.Description := RsgCualquiera
     else If   DataTipoMovimiento.Value in [ tmPedidoCompra, tmCompra ]
          then Proveedor.Valida( Sender, DisplayValue, ErrorText, Error )
          else Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxSdvForm.DoOnSelectMovimientoCompra;
begin
     With CxMcoForm[ DataTipoMovimiento.Value ] do
       begin
       EjercicioCtrl.PostEditValue( QueryEjercicio.Value );
       SerieCtrl.PostEditValue( QuerySerie.Value );
       NroDocumentoCtrl.PostEditValue( QueryNroDocumento.Value );
       end;
end;

procedure TBoxSdvForm.DoOnSelectMovimientoVenta;
begin
     With CxMveForm[ DataTipoMovimiento.Value ] do
       begin
       EjercicioCtrl.PostEditValue( QueryEjercicio.Value );
       SerieCtrl.PostEditValue( QuerySerie.Value );
       NroDocumentoCtrl.PostEditValue( QueryNroDocumento.Value );
       end;
end;

procedure TBoxSdvForm.FormManagerOkButton;
begin

     If   ( DataTipoMovimiento.Value=tmCapturador ) and
          ( Configuracion.ParametrosUsrRec.PathFicheroDatosCapturador='' )
     then begin
          ShowNotification( ntStop, RsMsg9, '' );
          Abort;
          end;

     // Primero compruebo si el documento está libre

     // Movimiento.CompruebaMovimientoLibre( MovimientoTable );

     If   Assigned( OnSelected )
     then OnSelected;

end;

procedure TBoxSdvForm.ExaminarButtonClick(Sender: TObject);
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

procedure TBoxSdvForm.FormManagerInitializeForm;

var  I, NumOfItems, ItemEnabled : SmallInt;

procedure FijaTipoMovimiento( TipoMovimiento : SmallInt );

var  I : SmallInt;

begin
     With TipoMovimientoCtrl.Properties.Items do
       For I := 0 to Count - 1 do
         If   ( Items[ I ].Value=TipoMovimiento ) and ( Items[ I ].Enabled )
         then begin
              DataTipoMovimiento.Value := Items[ I ].Value;
              Exit;
              end;

     // Si el tipo de movimiento que se pretende fijar no está activado, se opta por seleccionar el primero que esté activo

     DataTipoMovimiento.Value := GetFirstEnabledButtonValue( TipoMovimientoCtrl );
end;

begin

     MovimientoFields := TMovimientoFields.Create( MovimientoTable );

     With TipoMovimientoCtrl.Properties do
       begin

       Items[ 0 ].Enabled := tmPresupuesto in TiposMovimiento;
       Items[ 1 ].Enabled := tmPedidoCompra in TiposMovimiento;
       Items[ 2 ].Enabled := tmPedidoVenta in TiposMovimiento;
       Items[ 3 ].Enabled := tmCompra in TiposMovimiento;
       Items[ 4 ].Enabled := tmVenta in TiposMovimiento;
       Items[ 5 ].Enabled := tmCapturador in TiposMovimiento;
       // Items[ 6 ].Enabled := tmBascula in TiposMovimiento;

       // Contando el número de documentos permitidos para ver si hay solo uno

       NumOfItems := 0;
       For I := 0 to Items.Count - 1  do
         If   Items[ I ].Enabled
         then begin
              ItemEnabled := I;
              Inc( NumOfItems );
              end;

       If   NumOfItems=1
       then begin
            DocumentoUnicoPanel.Visible := True;
            DocumentoUnicoPanel.Top := 0;
            TipoDocumentoLabel.Caption := Items[ ItemEnabled ].Caption;
            Height := Height - DocumentosMultiplesPanel.Height;
            TipoMovimiento := Items[ ItemEnabled ].Value;
            DataTipoMovimiento.Value := TipoMovimiento;
            If   TipoMovimiento in [ tmCapturador{ , tmBascula } ]
            then begin
                 ParametrosPanel.Visible := False;
                 Height := Height - ParametrosPanel.Height;
                 end
            else begin
                 FicheroPanel.Visible := False;
                 Height := Height - FicheroPanel.Height;
                 end;
            FormManager.FirstDataControl := EjercicioCtrl;
            end
       else begin
            DocumentosMultiplesPanel.Visible := True;
            Height := Height - DocumentoUnicoPanel.Height;

            If   UltimoTipoMovimiento=tmNoDefinido
            then FijaTipoMovimiento( tmPedidoVenta )
            else FijaTipoMovimiento( UltimoTipoMovimiento );

            end;

       end;

     DataPropietario.Value := CodigoCliente;
     DescPropietarioLabel.Caption := Cliente.Descripcion( CodigoCliente, True );

     DataEjercicio.Value := ApplicationContainer.Ejercicio;

     With Configuracion.ParametrosUsrRec do
       If   PathFicheroDatosCapturador=''
       then FicheroDatosBox.Caption := RsMsg10
       else FicheroDatosBox.Caption := PathFicheroDatosCapturador;

end;

procedure TBoxSdvForm.NroDocumentoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   DataTipoMovimiento.Value in [ tmPedidoCompra, tmCompra ]
     then ConsultaMovimientosCompra( DataTipoMovimiento.Value,
                                     sdTodos,
                                     DataPropietario,
                                     Sender,
                                     qgsNormal,
                                     DoOnSelectMovimientoCompra )
     else ConsultaMovimientosVenta( DataTipoMovimiento.Value,
                                    sdPendientes,
                                    DataSerie,
                                    Sender,
                                    qgsNormal,
                                    DataPropietario.Value,
                                    DoOnSelectMovimientoVenta )
end;

procedure TBoxSdvForm.NroDocumentoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

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

     DataNroOperacion.Value := MovimientoFields.NroOperacion.Value;

end;

procedure TBoxSdvForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   TipoMovimiento=tmPedidoVenta
     then ConsultaSeriesFacturacion( Sender );
end;

procedure TBoxSdvForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   TipoMovimiento=tmPedidoVenta
     then SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

end.

