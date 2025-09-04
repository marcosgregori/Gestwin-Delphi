
unit l_tcm;

interface

uses StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,

     ComCtrls,
     ReportManager,
     DB,
     nxdb,
     DataManager,
     Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox,
     cxDBEdit, cxDropDownEdit, cxCalendar, cxPC, cxControls, cxContainer,
     cxEdit, cxTextEdit, cxMaskEdit, cxSpinEdit, dxmdaset, AppForms,
     dxSkinsCore, cxGraphics, cxLookAndFeels, cxLabel, cxGroupBox, dxSkinsDefaultPainters,

     Libutils,
     Spring,
     AppContainer,

     Gim30Fields,

     dm_mov;


type
    TConsultaFields = class( TnxeDatasetFields )
      TipoOperacion,
      TipoMovimiento : TSmallIntField;
      Serie : TWideStringField;
      NroOperacion,
      NroDocumento : TIntegerField;
      Fecha : TDateField;
      CodigoPropietario,
      Nombre,
      CodigoArticulo,
      CodigoClaseA,
      CodigoClaseB,
      CodigoClaseC,
      LoteFabricacion,
      CodigoArticuloRaiz,
      CodigoClaseARaiz,
      CodigoClaseBRaiz,
      CodigoClaseCRaiz,
      LoteFabricacionRaiz,
      Descripcion : TWideStringField;
      Cantidad,
      Existencias : TBCDField;
      end;

    TRptTcmForm = class(TgxForm)
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    MovimientoTable: TnxeTable;
    LineaMovimientoTable: TnxeTable;
    Panel1: TgxEditPanel;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataComponente: TWideStringField;
    DataLote: TWideStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    gxRangeBox1: TgxRangeBox;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    ComponenteCtrl: TcxDBTextEdit;
    LoteCtrl: TcxDBTextEdit;
    Label6: TcxLabel;
    Label3: TcxLabel;
    Label2: TcxLabel;
    Label7: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxLabel1: TcxLabel;
    LineaOrdenFabricacionTable: TnxeTable;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ComponenteCtrlQueryRequest(Sender: TcxCustomEdit);
    procedure ComponenteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure LoteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    private

    protected

    class procedure ListadoTrazabilidad( Sender : TObject );

    public

      MovimientoFields : TMovimientoFields;
      LineaMovimientoFields,
      LineaOrdenFabricacionFields,

      DsLineaOrdenFabricacionFields : TLineaMovimientoFields;

      ConsultaTable,
      ConsultaAuxTable: TnxeTable;
      ConsultaFields,
      ConsultaAuxFields : TConsultaFields;

    end;

var
  RptTcmForm: TRptTcmForm = nil;

procedure ListadoTrazabilidadComponente;

implementation

uses   DateUtils,
       SysUtils,
       AppManager,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm30Frm,

       dmi_mov,
       dmi_sto,

       dm_sto,
       dm_art,
       dm_pro,
       dm_cli,
       dm_fdv,

       b_msg,

       cx_art,
       cx_ldp1,
       cx_ldp2;

{$R *.dfm}

procedure ListadoTrazabilidadComponente;
begin
     CreateReportForm( TRptTcmForm, RptTcmForm, [] );
end;

procedure TRptTcmForm.InitializeForm;
begin

     ID := idRptTcmForm;

     MovimientoFields := TMovimientoFields.create( MovimientoTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );
     LineaOrdenFabricacionFields := TLineaMovimientoFields.Create( LineaOrdenFabricacionTable );

     DsLineaOrdenFabricacionFields := TLineaMovimientoFields.Create( Self );

     DataFechaInicial.Value := IncYear( ApplicationContainer.TodayDate, -1 );
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
end;

class procedure TRptTcmForm.ListadoTrazabilidad(Sender: TObject);
begin
     ListadoTrazabilidadComponente;
end;

procedure TRptTcmForm.LoteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   DataModule00.DmEmpresaFields.Stock_TrazabilidadPorLotes.Value 
     then ConsultaLotesProductos2( Sender, DataComponente.Value, ApplicationContainer.TodayDate, nil )
     else ConsultaLotesProductos1( Sender, DataComponente.Value );
end;

procedure TRptTcmForm.ComponenteCtrlQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, False, Sender );
end;

procedure TRptTcmForm.ComponenteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil );
end;

procedure TRptTcmForm.FormManagerOkButton;


procedure SeleccionaRegistros;

var  ArticuloFinalEncontrado : Boolean;
     CodigoArticulo,
     LoteFabricacion : String;
     NroOperacionExistencias : SmallInt;

procedure AñadeRegistroExistencias( CodigoArticulo,
                                    LoteFabricacion : String );

var  ExistenciasArticulo : IExistenciasArticulo;

begin
     ExistenciasArticulo := StockAlmacen.ObtenStock( CodigoArticulo,
                                                     True,
                                                     '',
                                                     '',
                                                     '',
                                                     False,
                                                     LoteFabricacion,        // LoteFabricacion,
                                                     True,                   // TodosLosAlmacenes
                                                     '',                     // CodigoAlmacen
                                                     True,                   // TodasLasUbicaciones
                                                     '',                     // CodigoUbicacion
                                                     False,                  // ObtenCoste
                                                     ApplicationContainer.Ejercicio,
                                                     0,
                                                     12 );


     ConsultaTable.Append;

     ConsultaFields.TipoOperacion.Value := 3;
     ConsultaFields.NroOperacion.Value := NroOperacionExistencias;
     ConsultaFields.CodigoArticulo.Value := CodigoArticulo;
     ConsultaFields.LoteFabricacion.Value := LoteFabricacion;
     ConsultaFields.Descripcion.Value := Articulo.Descripcion( CodigoArticulo );
     ConsultaFields.Cantidad.Value := ExistenciasArticulo.SumaExistencias.Saldo;

     ConsultaTable.Post;

     Inc( NroOperacionExistencias );
end;

begin

     // Primero leo todas las líneas del componente y lote que aparecen en movimientos de compra y fabricación

     With LineaMovimientoTable do
       begin

       SetRange( [ DataComponente.Value, DataLote.Value, DataFechaInicial.Value ], [ DataComponente.Value, DataLote.Value, DataFechaFinal.Value ] );

       First;
       While not Eof do
         begin

         If   MovimientoTable.FindKey( [ LineaMovimientoFields.Ejercicio.Value, LineaMovimientoFields.NroOperacion.Value ] )
         then If   MovimientoFields.TipoMovimiento.Value in [ tmFabricacion, tmDispFabricacion, tmCompra ]
              then begin
                   ConsultaTable.Append;

                   If   MovimientoFields.TipoMovimiento.Value=tmCompra // Lo utilizo para ordenar los registros por tipo de movimiento
                   then begin
                        ConsultaFields.TipoOperacion.Value := 0;
                        ConsultaFields.CodigoPropietario.Value := MovimientoFields.Propietario.Value;
                        ConsultaFields.Nombre.Value := Proveedor.Descripcion( ConsultaFields.CodigoPropietario.Value );
                        end
                   else begin
                        ConsultaFields.TipoOperacion.Value := 1;
                        ConsultaFields.Nombre.Value := MovimientoFields.DescripcionMovimiento.Value;
                        end;

                   ConsultaFields.TipoMovimiento.Value := MovimientoFields.TipoMovimiento.Value;
                   ConsultaFields.Serie.Value := MovimientoFields.Serie.Value;
                   ConsultaFields.NroOperacion.Value := MovimientoFields.NroOperacion.Value;
                   ConsultaFields.NroDocumento.Value := MovimientoFields.NroDocumento.Value;
                   ConsultaFields.Fecha.Value := LineaMovimientoFields.Fecha.Value;
                   ConsultaFields.CodigoArticulo.Value := LineaMovimientoFields.CodigoArticulo.Value;
                   ConsultaFields.CodigoClaseA.Value := LineaMovimientoFields.CodigoClaseA.Value;
                   ConsultaFields.CodigoClaseB.Value := LineaMovimientoFields.CodigoClaseB.Value;
                   ConsultaFields.CodigoClaseC.Value := LineaMovimientoFields.CodigoClaseC.Value;
                   ConsultaFields.LoteFabricacion.Value := LineaMovimientoFields.LoteFabricacion.Value;
                   ConsultaFields.Descripcion.Value := LineaMovimientoFields.Descripcion.Value;
                   ConsultaFields.Cantidad.Value := LineaMovimientoFields.Cantidad.Value;

                   // Ahora busco el artículo destino dentro de la orden de fabricación

                   If   ( MovimientoFields.TipoMovimiento.Value=tmDispFabricacion ) and
                        Movimiento.OnObtenArticuloFinal.Enabled
                   then begin

                        DsLineaOrdenFabricacionFields.Update( LineaMovimientoTable );

                        If   Movimiento.OnObtenArticuloFinal.Invoke( MovimientoFields, DsLineaOrdenFabricacionFields )
                        then begin
                             ConsultaFields.CodigoArticuloRaiz.Value := DsLineaOrdenFabricacionFields.CodigoArticulo.Value;
                             ConsultaFields.CodigoClaseARaiz.Value := DsLineaOrdenFabricacionFields.CodigoClaseA.Value;
                             ConsultaFields.CodigoClaseBRaiz.Value := DsLineaOrdenFabricacionFields.CodigoClaseB.Value;
                             ConsultaFields.CodigoClaseCRaiz.Value := DsLineaOrdenFabricacionFields.CodigoClaseC.Value;
                             ConsultaFields.LoteFabricacionRaiz.Value := DsLineaOrdenFabricacionFields.LoteFabricacion.Value;
                             end;

                        end
                   else If   MovimientoFields.TipoMovimiento.Value=tmFabricacion
                        then begin

                             ArticuloFinalEncontrado := False;

                             With LineaOrdenFabricacionTable do
                               begin

                               With LineaMovimientoFields do
                                 SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ] ,
                                           [ Ejercicio.Value, NroOperacion.Value, 0, NroLinea.Value - 1 ] );
                               Last;
                               While not Bof and not ArticuloFinalEncontrado do
                                 begin

                                 If   LineaOrdenFabricacionFields.Cantidad.Value>0.0
                                 then begin

                                      ConsultaFields.CodigoArticuloRaiz.Value := LineaOrdenFabricacionFields.CodigoArticulo.Value;
                                      ConsultaFields.CodigoClaseARaiz.Value := LineaOrdenFabricacionFields.CodigoClaseA.Value;
                                      ConsultaFields.CodigoClaseBRaiz.Value := LineaOrdenFabricacionFields.CodigoClaseB.Value;
                                      ConsultaFields.CodigoClaseCRaiz.Value := LineaOrdenFabricacionFields.CodigoClaseC.Value;
                                      ConsultaFields.LoteFabricacionRaiz.Value := LineaOrdenFabricacionFields.LoteFabricacion.Value;

                                      ArticuloFinalEncontrado := True;
                                      end
                                 else Prior;

                                 end;

                               end;

                             end;

                   ConsultaTable.Post;
                   end;

         Next;
         end;

       end;

     NroOperacionExistencias := 0;

     AñadeRegistroExistencias( DataComponente.Value, DataLote.Value );

     CodigoArticulo := '';
     LoteFabricacion := '';

     ConsultaTable.IndexFieldNames := 'TipoOperacion;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;LoteFabricacion';

     With ConsultaAuxTable do
       begin
       IndexFieldNames := 'TipoOperacion;Fecha;NroOperacion';
       SetRange( [ 1 ] );
       First;
       While not Eof do
         begin

         If   ( ConsultaAuxFields.CodigoArticuloRaiz.Value<>CodigoArticulo ) or {
              ( ConsultaAuxFields.CodigoClaseARaiz.Value<>CodigoClaseA ) or
              ( ConsultaAuxFields.CodigoClaseBRaiz.Value<>CodigoClaseB ) or
              ( ConsultaAuxFields.CodigoClaseCRaiz.Value<>CodigoClaseC ) or }
              ( ConsultaAuxFields.LoteFabricacionRaiz.Value<>LoteFabricacion )
         then If   not ConsultaTable.FindKey( [ 2, ConsultaAuxFields.CodigoArticuloRaiz.Value, '', '', '', ConsultaAuxFields.LoteFabricacionRaiz.Value ] )
              then begin

                   CodigoArticulo := ConsultaAuxFields.CodigoArticuloRaiz.Value;
                   LoteFabricacion := ConsultaAuxFields.LoteFabricacionRaiz.Value;

                   AñadeRegistroExistencias( CodigoArticulo, LoteFabricacion );

                   With LineaMovimientoTable do
                     begin

                     SetRange( [ CodigoArticulo, LoteFabricacion, DataFechaInicial.Value ], [ CodigoArticulo, LoteFabricacion, DataFechaFinal.Value ] );
                     First;
                     While not Eof do
                       begin

                       If   MovimientoTable.FindKey( [ LineaMovimientoFields.Ejercicio.Value, LineaMovimientoFields.NroOperacion.Value ] )
                       then If   MovimientoFields.TipoMovimiento.Value=tmVenta
                            then begin

                                 ConsultaTable.Append;

                                 ConsultaFields.TipoOperacion.Value := 2;
                                 ConsultaFields.TipoMovimiento.Value := MovimientoFields.TipoMovimiento.Value;
                                 ConsultaFields.Serie.Value := MovimientoFields.Serie.Value;
                                 ConsultaFields.NroOperacion.Value := MovimientoFields.NroOperacion.Value;
                                 ConsultaFields.NroDocumento.Value := MovimientoFields.NroDocumento.Value;
                                 ConsultaFields.Fecha.Value := LineaMovimientoFields.Fecha.Value;
                                 ConsultaFields.CodigoPropietario.Value := MovimientoFields.Propietario.Value;
                                 ConsultaFields.Nombre.Value := Cliente.Descripcion( ConsultaFields.CodigoPropietario.Value );
                                 ConsultaFields.CodigoArticulo.Value := LineaMovimientoFields.CodigoArticulo.Value;
                                 ConsultaFields.CodigoClaseA.Value := LineaMovimientoFields.CodigoClaseA.Value;
                                 ConsultaFields.CodigoClaseB.Value := LineaMovimientoFields.CodigoClaseB.Value;
                                 ConsultaFields.CodigoClaseC.Value := LineaMovimientoFields.CodigoClaseC.Value;
                                 ConsultaFields.LoteFabricacion.Value := LineaMovimientoFields.LoteFabricacion.Value;
                                 ConsultaFields.Descripcion.Value := LineaMovimientoFields.Descripcion.Value;
                                 ConsultaFields.Cantidad.Value := -LineaMovimientoFields.Cantidad.Value;

                                 ConsultaTable.Post;
                                 end;

                       Next;
                       end;

                     end;

                   end;

         Next;
         end;

       end;

       ConsultaTable.IndexFieldNames := 'TipoOperacion;Fecha;NroOperacion;CodigoClaseA;CodigoClaseB;CodigoClaseC;CodigoArticulo;LoteFabricacion';
end;

begin
     With Report do
       try

         try
           Load;
           ConsultaTable := CreateEmptyTable( 'Consulta' );
           ConsultaFields := TConsultaFields.Create( ConsultaTable );

           ConsultaAuxTable := TnxeTable.Create( Self );
           ConsultaAuxTable.Database := ConsultaTable.Database;
           ConsultaAuxTable.TableName := ConsultaTable.TableName;
           ConsultaAuxTable.Open;

           ConsultaAuxFields := TConsultaFields.Create( ConsultaAuxTable );

           MainDataSet := ConsultaTable;
           SeleccionaRegistros;
           FacturaVentas.FijaDecimalesInforme( Report );
           Start;

         finally
           FreeAndNil( ConsultaAuxTable );
           end;

       except on E : Exception do Cancel( E );
         end;
end;

procedure SetupUnit;

var  MenuItem : TMenuItem;

begin

     // Solo se muestra el listado si están activos los lotes de fabricación

     If   not DatabaseUpdateRequested
     then If   DataModule00.DmEmpresaFields.Stock_LotesProductos.Value
          then If   Assigned( Gds30Frm )
               then With Gds30Frm do
                      begin
                      SetBarItemVisible( TrazabilidadComponenteItem, True );
                      TrazabilidadComponenteItem.OnClick := TRptTcmForm.ListadoTrazabilidad;
                      end;
end;

initialization
   AddProcedure( imStartUp, 0, SetupUnit );

end.

