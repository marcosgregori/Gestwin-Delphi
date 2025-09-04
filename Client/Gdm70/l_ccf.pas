
unit l_ccf;

interface

uses AppForms, StdCtrls, Mask, Controls, Buttons, Classes, ExtCtrls, Forms,
  Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxCheckBox, cxDBEdit, cxGroupBox, cxRadioGroup, cxControls, cxContainer,
  cxEdit, cxTextEdit, dxmdaset, ReportManager, cxCurrencyEdit,

  dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel,

  LibUtils,
  AppContainer,

  Gim30Fields,
  Gim70Fields,

  dm_lmp,
  dm_sto;

type
    TRptCcfForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    ArticuloInicialCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    ArticuloTable: TnxeTable;
    ArticuloFinalCtrl: TcxDBTextEdit;
    RelacionOperacionesTable: TnxeTable;
    RelacionMaterialesTable: TnxeTable;
    OperacionTable: TnxeTable;
    MaquinaTipoTable: TnxeTable;
    LineaOperacionTable: TnxeTable;
    OperarioTipoTable: TnxeTable;
    CantidadCtrl: TcxDBCurrencyEdit;
    RelacionOperaciones1Table: TnxeTable;
    PrecioValoracionCtrl: TcxDBRadioGroup;
    PrecioValidoCtrl: TcxDBCheckBox;
    gxRangeBox2: TgxRangeBox;
    Report: TgxReportManager;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataArticuloInicial: TWideStringField;
    DataArticuloFinal: TWideStringField;
    DataCantidad: TBCDField;
    DataPrecioValoracion: TSmallIntField;
    DataBuscarPrecioValido: TBooleanField;
    Label1: TcxLabel;
    Label4: TcxLabel;
    Label3: TcxLabel;
    Label2: TcxLabel;
    Label7: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    CosteOperacExternasTable: TnxeTable;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

    public
    type

    TCosteTeoricoFields = class( TnxeDatasetFields)
     public
       NroRegistro : TIntegerField;
       NroProcesoRaiz : TIntegerField;
       Tipo : TSmallIntField;
       Nivel : TSmallIntField;
       Proceso : TIntegerField;
       NroElemento : TSmallIntField;
       CodigoArticuloDesglose : TWideStringField;
       DescripcionArticuloDesglose : TWideStringField;
       CodigoClaseA : TWideStringField;
       CodigoClaseB : TWideStringField;
       CodigoClaseC : TWideStringField;
       CodigoArticulo : TWideStringField;
       DescripcionArticulo : TWideStringField;
       CodigoOperacion : TWideStringField;
       DescripcionOperacion : TWideStringField;
       CodigoComponente : TWideStringField;
       DescripcionComponente : TWideStringField;
       ComponentesPorUnidad : TBCDField;
       Existencias : TBCDField;
       CosteFabricacion : TBCDField;
       Cantidad : TBCDField;
       Importe : TBCDField;
       SinCoste : TBooleanField;
     end;

    var

    CosteTeoricoTable : TnxeTable;
    CosteTeoricoFields : TCosteTeoricoFields;

    RelacionMaterialesFields : TRelacionMaterialesFields;
    RelacionOperaciones1Fields,
    RelacionOperacionesFields : TRelacionOperacionesFields;
    ArticuloFields : TArticuloFields;
    OperacionFields : TOperacionFields;
    MaquinaTipoFields : TMaquinaTipoFields;
    LineaOperacionFields : TLineaOperacionFields;
    OperarioTipoFields : TOperarioTipoFields;
    CosteOperacExternasFields : TCosteOperacExternasFields;

    PrecioCoste,
    HorasProceso,
    CosteProceso,
    CosteFabricacion : Decimal;

    TieneComponentes : Boolean;
    NroProcesoRaiz : SmallInt;
    NroRegistroActual,
    NroElementoActual : LongInt;
    end;

var RptCcfForm: TRptCcfForm = nil;

procedure ListadoCostesFabricacion;


implementation

uses   SysUtils,

       Gdm00Dm,

       dmi_sto,

       dm_cls,
       dm_art,
       dm_fdc,

       cx_art,
       cx_alm;

{$R *.DFM}

procedure ListadoCostesFabricacion;
begin
     CreateReportForm( TRptCcfForm, RptCcfForm );
end;

procedure TRptCcfForm.InitializeForm;
begin
     RelacionOperacionesFields := TRelacionOperacionesFields.Create( RelacionOperacionesTable );
     RelacionOperaciones1Fields := TRelacionOperacionesFields.Create( RelacionOperaciones1Table );
     RelacionMaterialesFields := TRelacionMaterialesFields.Create( RelacionMaterialesTable );
     ArticuloFields := TArticuloFields.Create( ArticuloTable );
     OperacionFields := TOperacionFields.Create( OperacionTable );
     MaquinaTipoFields := TMaquinaTipoFields.Create( MaquinaTipoTable );
     LineaOperacionFields := TLineaOperacionFields.Create( LineaOperacionTable );
     OperarioTipoFields := TOperarioTipoFields.Create( OperarioTipoTable );
     CosteOperacExternasFields := TCosteOperacExternasFields.Create( CosteOperacExternasTable );

     DataArticuloFinal.Value := HighStrCode;
     DataCantidad.Value := 100.0;
     DataPrecioValoracion.Value := 0;
     DataBuscarPrecioValido.Value := True;

     SetEditControlDecimals( CantidadCtrl, DataModule00.DmEmpresaFields.Compras_DecCantidad.Value );
end;

procedure TRptCcfForm.ArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, False, Sender );
end;

procedure TRptCcfForm.ArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptCcfForm.FormManagerOkButton;


var  CodigoArticuloDesglose : String;
     CodigoClaseADesglose,
     CodigoClaseBDesglose,
     CodigoClaseCDesglose : String;
     DescArticuloDesglose : String;

     NivelActual : SmallInt;

procedure DesglosaArticulo( _CodigoArticulo      : String;
                            _CodigoClaseA        : String;
                            _CodigoClaseB        : String;
                            _CodigoClaseC        : String;
                            _ArticuloRaiz,
                            _PrecioCompraValido  : Boolean;
                            _Cantidad,
                            _CantidadPadre       : Decimal );

var  PrecioCompraValido  : Boolean;
     Bm : TBookMark;
     SavedRangeStart,
     SavedRangeEnd : Pointer;
     ExistenciasArticulo : IExistenciasArticulo;

begin

     // Operaciones

     With RelacionOperacionesTable, RelacionOperacionesFields do
       begin

       SetRange( [ _CodigoArticulo, _CodigoClaseA, _CodigoClaseB, _CodigoClaseC, 1 ], [ _CodigoArticulo, _CodigoClaseA, _CodigoClaseB, _CodigoClaseC, MaxSmallint ] );
       First;
       While not Eof do
         begin

         If   _ArticuloRaiz
         then NroProcesoRaiz := Proceso.Value;

         With RelacionOperacionesFields do
           begin

           CosteFabricacion := 0.0;

           If   OperacionTable.FindKey( [ CodigoOperacion.Value ] )
           then begin

                // Añado el coste de la maquina tipo o del subcontratista

                If   OperacionFields.OperacionExterna.Value
                then begin
                     If   CosteOperacExternasTable.FindKey( [ CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, OperacionFields.CodigoOperador.Value, CodigoOperacion.Value ] )
                     then CosteFabricacion :=  CosteOperacExternasFields.CosteUnitario.Value * _Cantidad;
                     end
                else begin

                     HorasProceso := ( TiempoPreparacion.Value + ( ( _Cantidad / UnidadesTiempo.Value ) * TiempoFabricacion.Value ) ) / 3600;

                     If   MaquinaTipoTable.FindKey( [ OperacionFields.CodigoOperador.Value ] )
                     then begin
                          CosteProceso := HorasProceso * MaquinaTipoFields.CosteHora.Value;
                          DecAdd( CosteFabricacion, CosteProceso );
                          end;

                     // y el de los operarios tipo que intervendrán

                     With LineaOperacionTable do
                       begin
                       SetRange( [ OperacionFields.Codigo.Value, 1 ], [ OperacionFields.Codigo.Value, MaxSmallint ] );
                       First;
                       While not Eof do
                         begin
                         If   OperarioTipoTable.FindKey( [ LineaOperacionFields.CodigoOperarioTipo.Value ] )
                         then begin
                              CosteProceso := HorasProceso * OperarioTipoFields.CosteHora.Value * LineaOperacionFields.Cantidad.Value;
                              DecAdd( CosteFabricacion, CosteProceso );
                              end;
                         Next;
                         end;

                       end;

                     end;

                end;

           CosteTeoricoTable.Append;

           CosteTeoricoFields.NroRegistro.Value := NroRegistroActual;
           CosteTeoricoFields.NroProcesoRaiz.Value := NroProcesoRaiz;
           CosteTeoricoFields.Tipo.Value := 0;
           CosteTeoricoFields.Nivel.Value  := NivelActual;
           CosteTeoricoFields.Proceso.Value := Proceso.Value;
           CosteTeoricoFields.NroElemento.Value := NroElementoActual;
           CosteTeoricoFields.CodigoArticuloDesglose.Value := CodigoArticuloDesglose;
           CosteTeoricoFields.DescripcionArticuloDesglose.Value := DescArticuloDesglose;
           CosteTeoricoFields.CodigoArticulo.Value := _CodigoArticulo;
           CosteTeoricoFields.CodigoClaseA.Value := CodigoClaseADesglose;
           CosteTeoricoFields.CodigoClaseB.Value := CodigoClaseBDesglose;
           CosteTeoricoFields.CodigoClaseC.Value := CodigoClaseCDesglose;
           CosteTeoricoFields.CodigoOperacion.Value := CodigoOperacion.Value;
           CosteTeoricoFields.DescripcionOperacion.Value := OperacionFields.Descripcion.Value;

           CosteTeoricoFields.CosteFabricacion.Value := CosteFabricacion;
           CosteTeoricoFields.Cantidad.Value := _Cantidad;
           CosteTeoricoFields.Importe.Value := CosteFabricacion;

           Inc( NroElementoActual );

           CosteTeoricoTable.Post;

           end;

         // Paso a procesar los componentes de este Proceso

         With RelacionMaterialesTable, RelacionMaterialesFields do
           begin

           SetRange( [ _CodigoArticulo, _CodigoClaseA, _CodigoClaseB, _CodigoClaseC, RelacionOperacionesFields.Proceso.Value, 1 ],
                     [ _CodigoArticulo, _CodigoClaseA, _CodigoClaseB, _CodigoClaseC, RelacionOperacionesFields.Proceso.Value, MaxSmallint ] );
           First;
           While not Eof do
             begin

             If   _ArticuloRaiz
             then NroProcesoRaiz := Proceso.Value;

             If   ArticuloTable.FindKey( [ CodigoComponente.Value ] )
             then begin

                  ExistenciasArticulo := StockAlmacen.ObtenStock( CodigoComponente.Value, False, ClaseAComponente.Value, ClaseBComponente.Value, ClaseCComponente.Value, True, '', True, '', True, '', True, ApplicationContainer.Ejercicio, 0, 12 );

                  TieneComponentes := ListaMaterialesProcesos.TieneRelacion( CodigoComponente.Value, ClaseAComponente.Value, ClaseBComponente.Value, ClaseCComponente.Value );

                  CosteTeoricoTable.Append;

                  CosteTeoricoFields.NroRegistro.Value := NroRegistroActual;
                  CosteTeoricoFields.NroProcesoRaiz.Value := NroProcesoRaiz;
                  CosteTeoricoFields.Tipo.Value := 1;
                  CosteTeoricoFields.Nivel.Value  := NivelActual;
                  CosteTeoricoFields.Proceso.Value := Proceso.Value;
                  CosteTeoricoFields.NroElemento.Value := NroElementoActual;
                  CosteTeoricoFields.CodigoArticuloDesglose.Value := CodigoArticuloDesglose;
                  CosteTeoricoFields.DescripcionArticuloDesglose.Value := DescArticuloDesglose;
                  CosteTeoricoFields.CodigoComponente.Value := CodigoComponente.Value;
                  CosteTeoricoFields.CodigoClaseA.Value := ClaseAComponente.Value;
                  CosteTeoricoFields.CodigoClaseB.Value := ClaseBComponente.Value;
                  CosteTeoricoFields.CodigoClaseC.Value := ClaseCComponente.Value;
                  CosteTeoricoFields.CodigoArticulo.Value := _CodigoArticulo;
                  CosteTeoricoFields.DescripcionComponente.Value := Articulo.Descripcion( CodigoComponente.Value, True );

                  CosteTeoricoFields.ComponentesPorUnidad.Value := Cantidad.Value * _CantidadPadre;           // el número de componentes necesarios por unidad
                  CosteTeoricoFields.Existencias.Value := ExistenciasArticulo.SumaExistencias.Saldo;
                  CosteTeoricoFields.Cantidad.Value := CosteTeoricoFields.ComponentesPorUnidad.Value * _Cantidad;

                  If   not _PrecioCompraValido
                  then begin

                       case DataPrecioValoracion.Value of
                         0 : PrecioCoste := ArticuloFields.Precio_Compra.Value;
                         1 : PrecioCoste := ExistenciasArticulo.CosteUltEntrada;
                         2 : PrecioCoste := ExistenciasArticulo.CosteMedio;
                         3 : PrecioCoste := ExistenciasArticulo.Coste;
                         end;

                       If   DataBuscarPrecioValido.Value and ( PrecioCoste=0.0 )
                       then case DataPrecioValoracion.Value of
                              1 : begin
                                  PrecioCoste := ExistenciasArticulo.CosteUltEntrada;
                                  If   PrecioCoste=0.0
                                  then PrecioCoste := ArticuloFields.Precio_Compra.Value;
                                  end;
                              2 : PrecioCoste := ArticuloFields.Precio_Compra.Value;
                              end;

                       CosteTeoricoFields.CosteFabricacion.Value := PrecioCoste;
                       CosteTeoricoFields.Importe.Value := PrecioCoste * CosteTeoricoFields.Cantidad.Value;
                       CosteTeoricoFields.SinCoste.Value := ( PrecioCoste=0.0 ) and not TieneComponentes;  // el precio de compra de su padre no es válido y él no tiene precio de coste
                       end;

                  CosteTeoricoTable.Post;

                  Inc( NroElementoActual );

                  If   TieneComponentes
                  then begin
                       PrecioCompraValido := _PrecioCompraValido or ( PrecioCoste<>0.0 );
                       Bm := GetBookMark;
                       SaveRange( SavedRangeStart, SavedRangeEnd );
                       try
                         Inc( NivelActual );
                         DesglosaArticulo( CodigoComponente.Value, ClaseAComponente.Value, ClaseBComponente.Value, ClaseCComponente.Value, False, PrecioCompraValido, Cantidad.Value * _Cantidad, Cantidad.Value * _CantidadPadre );
                         Dec( NivelActual );
                       finally
                         RestoreRange( SavedRangeStart, SavedRangeEnd );
                         GotoBookMark( Bm );
                         end;
                       end;

                  end;

             Next;
             end;

           end;

         Next;
         end;

       end;


     If   _ArticuloRaiz
     then begin
          CosteTeoricoTable.Append;

          CosteTeoricoFields.NroRegistro.Value := NroRegistroActual;
          CosteTeoricoFields.NroProcesoRaiz.Value := NroProcesoRaiz;
          CosteTeoricoFields.Tipo.Value := 0;
          CosteTeoricoFields.Nivel.Value := 0;
          CosteTeoricoFields.CodigoArticuloDesglose.Value := CodigoArticuloDesglose;
          CosteTeoricoFields.DescripcionArticuloDesglose.Value := DescArticuloDesglose;

          CosteTeoricoTable.Post;
          end;

end;

procedure SeleccionaRegistros;
begin

     NroRegistroActual := 1;

     With RelacionOperaciones1Table do
       try
         SetRange( [ DataArticuloInicial.Value, '', '', '', 1 ], [ DataArticuloFinal.Value, HighStrCode, HighStrCode, HighStrCode, 1 ] );
         ApplicationContainer.StartProgression( RecordCount );
         First;
         While not Eof do
           With RelacionOperaciones1Fields do
             begin
             NroElementoActual := 0;
             NivelActual := 1;
             CodigoArticuloDesglose := CodigoArticulo.Value;
             CodigoClaseADesglose := CodigoClaseA.Value;
             CodigoClaseBDesglose := CodigoClaseB.Value;
             CodigoClaseCDesglose := CodigoClaseC.Value;
             If   ArticuloTable.FindKey( [ CodigoArticulo.Value ] )
             then begin
                  DescArticuloDesglose := ArticuloFields.Descripcion.Value;
                  DesglosaArticulo( CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, True, False, DataCantidad.Value, 1 );
                  end;
             Next;
             Inc( NroRegistroActual );
             NroElementoActual := 0;
             end;
       finally
         ApplicationContainer.EndProgression;
         end;

end;

begin
     With Report do
       try
         Load;
         CosteTeoricoTable := Report.CreateEmptyTable( 'CosteTeorico' );
         CosteTeoricoFields := TCosteTeoricoFields.Create( CosteTeoricoTable );
         SeleccionaRegistros;
         FacturaCompras.FijaDecimalesInforme( Report );
         SetValue( 'TextoPrecioValoracion', PrecioValoracionCtrl.SelectedButton.Caption );
         Clase.SetReportTitles( Report, 4 );
         Start;
       except on E : Exception do Cancel( E );
         end;

end;

end.

