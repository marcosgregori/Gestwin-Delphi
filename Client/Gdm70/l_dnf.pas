
unit l_dnf;

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
     AppContainer,

     Gim30Fields,
     Gim70Fields;


type
    TConsultaFields = class( TnxeDatasetFields )
      Nivel : TSmallIntField;
      CodigoArticulo,
      CodigoClaseA,
      CodigoClaseB,
      CodigoClaseC,
      Descripcion,
      CodigoComponente,
      CodigoClaseAComponente,
      CodigoClaseBComponente,
      CodigoClaseCComponente : TWideStringField;
      Existencias,
      Pedido,
      Disponible,
      Fabricacion : TBCDField;
      end;
      
    TRptDnfForm = class(TgxForm)
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    MovimientoTable: TnxeTable;
    LineaMovimientoTable: TnxeTable;
    Panel1: TgxEditPanel;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataClienteInicial: TWideStringField;
    DataClienteFinal: TWideStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    gxRangeBox3: TgxRangeBox;
    gxRangeBox1: TgxRangeBox;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    ClienteInicialCtrl: TcxDBTextEdit;
    ClienteFinalCtrl: TcxDBTextEdit;
    RelacionMaterialesTable: TnxeTable;
    Label6: TcxLabel;
    Label3: TcxLabel;
    Label2: TcxLabel;
    Label7: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    ExistenciasVirtualesCtrl: TcxDBCheckBox;
    DataExistenciasVirtuales: TBooleanField;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    private

    public
      MovimientoFields : TMovimientoFields;
      LineaMovimientoFields : TLineaMovimientoFields;
      RelacionMaterialesFields : TRelacionMaterialesFields;
      ConsultaTable : TnxeTable;
      ConsultaFields : TConsultaFields;
    end;

var
  RptDnfForm: TRptDnfForm = nil;

procedure ListadoDiponibilidadNecesidades;


implementation

uses   DateUtils,
       SysUtils,
       EnterpriseDataAccess,

       dmi_mov,
       dmi_sto,

       dm_sto,
       dm_mov,
       dm_fdv,
       dm_art,
       dm_cli,

       b_msg,

       cx_cli;

{$R *.DFM}

procedure ListadoDiponibilidadNecesidades;
begin
     CreateReportForm( TRptDnfForm, RptDnfForm, [] );
end;

procedure TRptDnfForm.InitializeForm;
begin
     MovimientoFields := TMovimientoFields.create( MovimientoTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );
     RelacionMaterialesFields := TRelacionMaterialesFields.Create( RelacionMaterialesTable );
     
     DataClienteFinal.Value := HighStrCode;
     DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
end;

procedure TRptDnfForm.ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TRptDnfForm.ClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptDnfForm.FormManagerOkButton;

procedure SeleccionaRegistros;

var  StockActual,
     CantidadPendiente : Decimal;
     FieldValuesArray : TFieldValuesArray;
     ExistenciasArticulo : IExistenciasArticulo;
     NivelActual : SmallInt;


procedure ProcesaComponentes( CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC : String; Cantidad : Decimal );


var  Bm : TBookMark;
     SavedRangeStart,
     SavedRangeEnd : Pointer;

begin
     With RelacionMaterialesTable do
       begin
       Inc( NivelActual );
       Bm := GetBookMark;
       SaveRange( SavedRangeStart, SavedRangeEnd );
       try

         SetRange( [ CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, 1, 1 ],
                   [ CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, MaxSmallint, MaxSmallint ] );
         First;
         While not Eof do
           begin
           ConsultaTable.Append;

           ConsultaTable.SetFieldValues( FieldValuesArray );

           ConsultaFields.Nivel.Value := NivelActual;
           ConsultaFields.CodigoComponente.Value := RelacionMaterialesFields.CodigoComponente.Value;
           ConsultaFields.CodigoClaseAComponente.Value := RelacionMaterialesFields.ClaseAComponente.Value;
           ConsultaFields.CodigoClaseBComponente.Value := RelacionMaterialesFields.ClaseBComponente.Value;
           ConsultaFields.CodigoClaseCComponente.Value := RelacionMaterialesFields.ClaseCComponente.Value;

           ConsultaFields.Descripcion.Value := Articulo.Descripcion( ConsultaFields.CodigoComponente.Value, False );
           ConsultaFields.Pedido.Value := Cantidad * RelacionMaterialesFields.Cantidad.Value;

           ExistenciasArticulo := StockAlmacen.ObtenStock( ConsultaFields.CodigoComponente.Value,
                                                           False,
                                                           ConsultaFields.CodigoClaseAComponente.Value,
                                                           ConsultaFields.CodigoClaseBComponente.Value,
                                                           ConsultaFields.CodigoClaseCComponente.Value,
                                                           True,
                                                           '',                     // LoteFabricacion,
                                                           True,                   // TodosLosAlmacenes
                                                           '',                     // CodigoAlmacen
                                                           True,                   // TodasLasUbicaciones
                                                           '',                     // CodigoUbicacion
                                                           False,                  // ObtenCoste
                                                           ApplicationContainer.Ejercicio,
                                                           0,
                                                           ApplicationContainer.NroMesFinal );
           StockActual :=  ExistenciasArticulo.SumaExistencias.Saldo;
           ConsultaFields.Existencias.Value := StockActual;
           If   StockActual>=ConsultaFields.Pedido.Value
           then ConsultaFields.Disponible.Value := ConsultaFields.Pedido.Value
           else begin
                ConsultaFields.Disponible.Value := StockActual;
                ConsultaFields.Fabricacion.Value := ConsultaFields.Pedido.Value - ConsultaFields.Disponible.Value;
                end;

           ConsultaTable.Post;

           ProcesaComponentes( ConsultaFields.CodigoComponente.Value,
                               ConsultaFields.CodigoClaseAComponente.Value,
                               ConsultaFields.CodigoClaseBComponente.Value,
                               ConsultaFields.CodigoClaseCComponente.Value,
                               ConsultaFields.Pedido.Value );

           Next;
           end;

       finally
         RestoreRange( SavedRangeStart, SavedRangeEnd );
         GotoBookMark( Bm );
         Dec( NivelActual )
         end;

       end;
end;


begin

     NivelActual := 0;

     ConsultaTable.IndexFieldNames := 'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC';

     With MovimientoTable do
       begin

       SetRange( [ tmPedidoVenta, DataClienteInicial.Value, DataFechaInicial.Value ], [ tmPedidoVenta, DataClienteFinal.Value, DataFechaFinal.Value ] );
       First;
       While not Eof do
         begin

         With LineaMovimientoTable do
           begin

           With MovimientoFields do
             SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );

           First;
           While not Eof do
             begin

             With LineaMovimientoFields do
               If   ( CodigoArticulo.Value<>ArticuloManual ) and
                    ( RelacionMaterialesTable.FindKey( [ CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value ] ) ) // Si no tiene lista de materiales no es un articulo a fabricar
               then With ConsultaTable do
                      begin

                      CantidadPendiente := Cantidad.Value - CantidadProcesada.Value;

                      If   FindKey( [ CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value ] )
                      then begin
                           Edit;
                           ConsultaFields.Pedido.Value := ConsultaFields.Pedido.Value + CantidadPendiente;
                           end
                      else begin
                           Append;
                           ConsultaFields.CodigoArticulo.Value := CodigoArticulo.Value;
                           ConsultaFields.CodigoClaseA.Value := CodigoClaseA.Value;
                           ConsultaFields.CodigoClaseB.Value := CodigoClaseB.Value;
                           ConsultaFields.CodigoClaseC.Value := CodigoClaseC.Value;
                           ConsultaFields.Descripcion.Value := Descripcion.Value;
                           ConsultaFields.Pedido.Value := CantidadPendiente;
                           end;

                      Post;
                      end;

             Next;
             end;

           end;

         Next;
         end;


       With ConsultaTable do
         begin
         First;
         While not Eof do
           begin
           FieldValuesArray := GetFieldValues;
           ExistenciasArticulo := StockAlmacen.ObtenStock( ConsultaFields.CodigoArticulo.Value,
                                                           False,
                                                           ConsultaFields.CodigoClaseA.Value,
                                                           ConsultaFields.CodigoClaseB.Value,
                                                           ConsultaFields.CodigoClaseC.Value,
                                                           True,
                                                           '',                     // LoteFabricacion,
                                                           True,                   // TodosLosAlmacenes
                                                           '',                     // CodigoAlmacen
                                                           True,                   // TodasLasUbicaciones
                                                           '',                     // CodigoUbicacion
                                                           False,                  // ObtenCoste
                                                           ApplicationContainer.Ejercicio,
                                                           0,
                                                           12 );

           StockActual := ExistenciasArticulo.SumaExistencias.Saldo;

           If   DataExistenciasVirtuales.Value
           then StockActual := StockActual + ExistenciasArticulo.SumaExistencias.PendienteRecibir - ExistenciasArticulo.SumaExistencias.PendienteServir;

           Edit;

           ConsultaFields.Existencias.Value := StockActual;
           If   StockActual>=ConsultaFields.Pedido.Value
           then ConsultaFields.Disponible.Value := ConsultaFields.Pedido.Value
           else begin
                ConsultaFields.Disponible.Value := StockActual;
                ConsultaFields.Fabricacion.Value := ConsultaFields.Pedido.Value - ConsultaFields.Disponible.Value;
                end;

           Post;

           ProcesaComponentes( ConsultaFields.CodigoArticulo.Value,
                               ConsultaFields.CodigoClaseA.Value,
                               ConsultaFields.CodigoClaseB.Value,
                               ConsultaFields.CodigoClaseC.Value,
                               ConsultaFields.Pedido.Value );

           Next;
           end;

         end;

       end;
end;

begin
     With Report do
       try
         Load;
         ConsultaTable := CreateEmptyTable( 'Consulta' );
         ConsultaFields := TConsultaFields.Create( ConsultaTable );
         MainDataSet := ConsultaTable;
         SeleccionaRegistros;
         FacturaVentas.FijaDecimalesInforme( Report );
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

end.

