
unit cx_mve;

interface

uses Forms, AppForms, Classes, Controls,

  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, cxCurrencyEdit,

  cxRichEdit, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxLookAndFeels, cxLookAndFeelPainters,
  cxImageComboBox, ImgList, QueryForm, cxContainer, cxGroupBox, cxNavigator,

  LibUtils,
  AppManager,
  dmi_mov,
  System.ImageList, cxImageList, dxDateRanges, dxScrollbarAnnotations,
  dxUIAClasses;

type
  TCxMveForm = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    dataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TableViewPropietario: TcxGridDBColumn;
    TableViewSerie: TcxGridDBColumn;
    TableViewNro_Documento: TcxGridDBColumn;
    TableViewFecha: TcxGridDBColumn;
    TableViewRegistroAuxiliar: TcxGridDBColumn;
    TableViewNroFactura: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    TableViewAuxiliarDescripcion: TcxGridDBColumn;
    QueryEjercicio: TSmallintField;
    QueryTipoMovimiento: TSmallintField;
    QueryNroOperacion: TIntegerField;
    QuerySerie: TWideStringField;
    QueryNroDocumento: TIntegerField;
    QueryFecha: TDateField;
    QueryPropietario: TWideStringField;
    QueryRegistroAuxiliar: TWideStringField;
    QueryNroFactura: TIntegerField;
    QueryNombre: TWideStringField;
    TableViewTextoSituacion: TcxGridDBColumn;
    QuerySituacion: TSmallintField;
    QueryTextoSituacion: TWideStringField;
    TableViewSituacion: TcxGridDBColumn;
    QueryAnotacion: TWideMemoField;
    TableViewAnotacion: TcxGridDBColumn;
    QueryAuxiliarDescripcion: TWideStringField;
    QueryNroDocumentoPropietario: TWideStringField;
    TableViewNroDocumentoPropietario: TcxGridDBColumn;
    QueryTraspasado: TBooleanField;
    QueryFacturado: TBooleanField;
    QueryNoFacturar: TBooleanField;
    QueryIndiceImagenSituacion: TSmallintField;
    TableViewImagenSituacion: TcxGridDBColumn;
    QueryImporteNeto: TBCDField;
    TableViewImporteNeto: TcxGridDBColumn;
    QueryCampoLibre1: TWideStringField;
    QueryCampoLibre2: TWideStringField;
    TableViewCampoLibre1: TcxGridDBColumn;
    TableViewCampoLibre2: TcxGridDBColumn;
    DocumentStatesImageList: TcxImageList;
    QueryGrupoFacturacion: TWideStringField;
    TableViewGrupoFacturacion: TcxGridDBColumn;
    QueryCodigoVendedor: TWideStringField;
    TableViewCodigoVendedor: TcxGridDBColumn;
    QueryEnvios_Nombre: TWideStringField;
    TableViewEnvios_Nombre: TcxGridDBColumn;
    QueryCampoLibre3: TWideStringField;
    TableViewCampoLibre3: TcxGridDBColumn;
    QueryCampoLibre4: TWideStringField;
    QueryCampoLibre5: TWideStringField;
    TableViewCampoLibre4: TcxGridDBColumn;
    TableViewCampoLibre5: TcxGridDBColumn;
    QueryCodigoTransportista: TWideStringField;
    TableViewCodigoTransportista: TcxGridDBColumn;
    QueryNombreTransportista: TWideStringField;
    TableViewNombreTransportista: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure QueryFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure QueryPanelUserSelection;
    procedure QueryPanelColumVisibilityChanged(Column: TcxGridDBColumn);
    procedure QueryPanelAfterReadQueryState;
  private
    ImporteBruto,
    DescuentosArticulos,
    ImporteNeto : Decimal;
  protected
    class var
    TipoMovimiento : TTipoMovimientoVenta;
    Serie : String;
    CodigoCliente : String;
    FechaInicial : TDateTime;
    FechaFinal : TDateTime;
    Seleccion : TSeleccionDocumento;
    TodasLasSeries : Boolean;
    OnUserSelection : TDataEditEvent;
  end;

var  CxMveForm : array[ tmPresupuesto..tmVenta ] of TCxMveForm = ( nil, nil, nil );

procedure ConsultaMovimientosVenta( TipoMovimiento  : TTipoMovimientoVenta;
                                    Seleccion       : TSeleccionDocumento;
                                    LockRangeField  : TField;
                                    Edit            : TcxCustomEdit = nil;
                                    InitialState    : TQueryGridInitialState = qgsNormal;
                                    CodigoCliente   : String = '';
                                    UserSelection   : TDataEditEvent = nil );

implementation

{$R *.dfm}

uses SysUtils,
     DateUtils,

     EnterpriseDataAccess,

     Gdm00Dm,
     Gim00Fields,

     dm_cli,
     dm_mov,
     dm_rac,
     dm_sdf,
     dm_tra,

     a_mve;

resourceString
     RsMsg1   = 'Consulta de %s';
     RsMsg2   = ' del cliente %s.';

procedure ConsultaMovimientosVenta( TipoMovimiento  : TTipoMovimientoVenta;
                                    Seleccion       : TSeleccionDocumento;
                                    LockRangeField  : TField;
                                    Edit            : TcxCustomEdit = nil;
                                    InitialState    : TQueryGridInitialState = qgsNormal;
                                    CodigoCliente   : String = '';
                                    UserSelection   : TDataEditEvent = nil );
begin

     TCxMveForm.TodasLasSeries := False;

     // La restricción de series viene determinada por el estado del control asociado al LockRangeField
     // por lo que es importante que se apliquen las restricciones en los mantenimientos para que funcione

     If   ShiftKey
     then CodigoCliente := '';

     TCxMveForm.TipoMovimiento := TipoMovimiento;
     TCxMveForm.CodigoCliente := CodigoCliente;
     TCxMveForm.Seleccion := Seleccion;
     TCxMveForm.OnUserSelection := UserSelection;

     CreateQueryForm( TCxMveForm, CxMveForm[ TipoMovimiento ], LockRangeField, Edit, InitialState, dsFrom30DaysAgo );

end;

procedure TCxMveForm.FormCreate(Sender: TObject);
begin

     Caption := Format( RsMsg1, [ Movimiento.TextoTipoMovimiento( TipoMovimiento ) ] );

     If   DataModule00.DmEmpresaFields.Cliente_RegAuxiliar.Value
     then begin

          With TableViewRegistroAuxiliar do
            begin
            Caption := NombreAuxiliarCliente( True );
            HeaderHint := Caption;
            Visible := True;
            end;

          With TableViewAuxiliarDescripcion do
            begin
            DataBinding.FieldName := 'AuxiliarDescripcion';
            Caption := DataModule00.DmEmpresaFields.Cliente_CampoAux[ 1 ].Value;
            HeaderHint := Caption;
            Visible := True;
            end;

          end;

     Query.SQL.Add( SQLFormat( ' WHERE TipoMovimiento=%d ', [ TipoMovimiento ] ) );

     If   CodigoCliente<>''
     then begin
          Caption := Caption + Format( RsMsg2, [ CodigoCliente ] );
          Query.SQL.Add( SQLFormat( ' AND Propietario=%s', [ QuotedStr( CodigoCliente ) ] ) );
          TableViewPropietario.Visible := False;
          TableViewNombre.Visible := False;
          end;

     Query.SQL.Add( ' AND NOT Anulado ' );
     {
     If   not TodasLasSeries and Movimiento.SeriesEnDocumentosVenta( TipoMovimiento )
     then begin
          If   Serie=''
          then Caption := Caption + RsMsg4
          else Caption := Caption + Format( RsMsg3, [ Serie ] );
          Query.SQL.Add( SQLFormat( ' AND Serie=%s', [ QuotedStr( Serie ) ] ) );
          end;
     }

     Query.SQL.Add( ' ORDER BY Fecha, NroDocumento' );

     TableViewTextoSituacion.Visible := TipoMovimiento=tmPedidoVenta;
     TableViewNroFactura.Visible := TipoMovimiento=tmVenta;
     TableViewNroDocumentoPropietario.VisibleForCustomization := TipoMovimiento=tmPedidoVenta;

     SetColumnDecimals( TableViewImporteNeto );

     var ListaCampos := [ TableViewCampoLibre1, TableViewCampoLibre2, TableViewCampoLibre3, TableViewCampoLibre4, TableViewCampoLibre5 ];

     With DataModule00.DmEmpresaFields do
       For var Inx := 1 to 5 do
         If   not Ventas_CamposLibres.Value or ( Ventas_CampoLibre[ Inx ].Value='' )
         then ListaCampos[ Inx - 1 ].VisibleForCustomization := False
         else ListaCampos[ Inx - 1 ].Caption := Ventas_CampoLibre[ Inx ].Value;

     If   DataModule00.DmEmpresaFields.Ventas_Transportista.Value
     then begin
          TableViewCodigoTransportista.VisibleForCustomization := True;
          TableViewNombreTransportista.VisibleForCustomization := True;
          end;

     QueryPanel.OnDataSelected := OnUserSelection;

end;

procedure TCxMveForm.QueryCalcFields(DataSet: TDataSet);
begin
     // Imagenes : 0 = Rojo, 1 = Amarillo y 2 = Verde

     case Self.TipoMovimiento of

       tmPresupuesto :

         case QuerySituacion.Value of

           eprPendiente :
             begin
             QueryIndiceImagenSituacion.Value := 1;
             QueryTextoSituacion.Value := 'Pendiente';
             end;

           eprAceptado :
             begin
             QueryIndiceImagenSituacion.Value := 2;
             QueryTextoSituacion.Value := 'Aceptado';
             end;

           eprCancelado :
             begin
             QueryIndiceImagenSituacion.Value := 0;
             QueryTextoSituacion.Value := 'Cancelado';
             end;

           end;

       tmPedidoVenta :
         begin
         QueryTextoSituacion.Value := Movimiento.TextoSituacionPedido( tmPedidoVenta, QuerySituacion.Value );
         case QuerySituacion.Value of
           epPendiente             : QueryIndiceImagenSituacion.Value := 0;
           epParcialmenteProcesado : QueryIndiceImagenSituacion.Value := 1;
           epProcesado             : QueryIndiceImagenSituacion.Value := 2;
           end;
         end;

       tmVenta :
         If   QueryTraspasado.Value
         then begin
              QueryIndiceImagenSituacion.Value := 2;
              QueryTextoSituacion.Value := 'Contabilizado';
              end
         else If   QueryFacturado.Value
              then begin
                   QueryIndiceImagenSituacion.Value := 1;
                   QueryTextoSituacion.Value := 'Facturado';
                   end
              else begin
                   If   QueryNofacturar.Value
                   then QueryTextoSituacion.Value := 'No facturable'
                   else QueryTextoSituacion.Value := 'Pendiente de facturar';
                   QueryIndiceImagenSituacion.Value := 0;
                   end;
       end;

     If   TableViewImporteNeto.Visible
     then begin
          Movimiento.ObtenImporteMovimiento( QueryEjercicio.Value,
                                             QueryNroOperacion.Value,
                                             ImporteBruto,
                                             DescuentosArticulos,
                                             ImporteNeto );
          QueryImporteNeto.Value := ImporteNeto;
          end;

     If   DataModule00.DmEmpresaFields.Cliente_RegAuxiliar.Value and not ValueIsEmpty( QueryRegistroAuxiliar.Value )
     then QueryAuxiliarDescripcion.Value := AuxiliarCliente.Descripcion( QueryPropietario.Value, QueryRegistroAuxiliar.Value, True );

     If   TableViewNombreTransportista.Visible
     then QueryNombreTransportista.Value := Transportista.Descripcion( QueryCodigoTransportista.Value );

end;

procedure TCxMveForm.QueryFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
     If   TipoMovimiento=tmPedidoVenta
     then case Seleccion of
            sdTodos      : Accept := True;
            sdPendientes : Accept := QuerySituacion.Value in [ 0, 1 ];
            sdProcesados : Accept := QuerySituacion.Value=2;
            end
     else Accept := True;
end;

procedure TCxMveForm.QueryPanelAfterReadQueryState;
begin
     With QueryPanel do
       begin
       If   TableViewEnvios_Nombre.Visible
       then SearchField := QueryEnvios_Nombre
       else SearchField := QueryNombre;
       UpdateSearchColumn( False );  // No se invalida
       end;
end;

procedure TCxMveForm.QueryPanelColumVisibilityChanged(Column: TcxGridDBColumn);
begin
     If   Column=TableViewImporteNeto
     then Query.RefreshQuery;
end;

procedure TCxMveForm.QueryPanelUserSelection;
begin
     MntMovimientosVenta(  [ TipoMovimiento, QueryEjercicio.Value, QuerySerie.Value, QueryNroDocumento.Value ] );
end;

end.
