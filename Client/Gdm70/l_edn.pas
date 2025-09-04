
unit l_edn;

interface

uses AppForms, StdCtrls, Mask, Controls, Buttons, Classes,
  ExtCtrls, Forms, Menus, cxLookAndFeelPainters,
  cxButtons, DB, nxdb, DataManager,
  ReportManager, cxTextEdit, cxDBEdit, cxControls, cxContainer, cxEdit,
  cxGroupBox, cxRadioGroup, dxmdaset,

  dxSkinsCore, cxGraphics, cxLookAndFeels, cxLabel,
  dxSkinsDefaultPainters,

  LibUtils,
  AppContainer,

  Gim30Fields,
  Gim70Fields,

  dm_lmp,
  dm_sto;


type
    TRptEdnForm = class(TgxForm)
    Panel1: TgxEditPanel;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    ArticuloTable: TnxeTable;
    RelacionMateriales2Table: TnxeTable;
    RelacionMateriales1Table: TnxeTable;
    RelacionMaterialesTable: TnxeTable;
    AlmacenTable: TnxeTable;
    Data: TgxMemData;
    DataSeleccionAlmacen: TSmallintField;
    DataArticuloInicial: TWideStringField;
    DataArticuloFinal: TWideStringField;
    DataAlmacen: TWideStringField;
    DataSource: TDataSource;
    gxRangeBox2: TgxRangeBox;
    ArticuloInicialCtrl: TcxDBTextEdit;
    ArticuloFinalCtrl: TcxDBTextEdit;
    SeleccionAlmacenCtrl: TcxDBRadioGroup;
    AlmacenCtrl: TcxDBTextEdit;
    Label3: TcxLabel;
    Label1: TcxLabel;
    DescAlmacenLabel: TcxLabel;
    Label4: TcxLabel;
    Label7: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure SeleccionAlmacenCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure AlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure AlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

    public

    type

    TDisponibilidadFields = class( TnxeDatasetFields)
     public
       NroRegistro : TIntegerField;
       Nivel : TSmallIntField;
       CodigoComponente : TWideStringField;
       DescripcionComponente : TWideStringField;
       CodigoClaseA : TWideStringField;
       CodigoClaseB : TWideStringField;
       CodigoClaseC : TWideStringField;
       CodigoArticulo : TWideStringField;
       DescripcionArticulo : TWideStringField;
       Existencias : TBCDField;
       Cantidad : TBCDField;
       PrecioCompra : TBCDField;
       PrecioVenta : TBCDField;
     end;

    var

    DisponibilidadTable : TnxeTable;
    DisponibilidadFields : TDisponibilidadFields;

    RelacionMaterialesFields,
    RelacionMateriales1Fields,
    RelacionMateriales2Fields : TRelacionMaterialesFields;
    ArticuloFields : TArticuloFields;

    Salen,
    Cm,
    Cma : array[ 1..NivelMaximo ] of Decimal;

    NroRegistroActual : Cardinal;
    
    procedure SetCantidadMaxima( Index : SmallInt; Value : Decimal );
    function  GetCantidadMaxima( Index : SmallInt ) : Decimal;
    procedure SetCantidadMaximaAnterior( Index : SmallInt; Value : Decimal );
    function  GetCantidadMaximaAnterior( Index : SmallInt ) : Decimal;

    procedure ResetArrays;

    property CantidadMaxima[ Index : SmallInt ] : Decimal read GetCantidadMaxima write SetCantidadMaxima;
    property CantidadMaximaAnterior[ Index : SmallInt ] : Decimal read GetCantidadMaximaAnterior write SetCantidadMaximaAnterior;
    end;

var

  RptEdnForm: TRptEdnForm = nil;

procedure ListadoDisponibilidad;


implementation

uses   SysUtils,

       Gim00Fields,

       dmi_sto,

       dm_art,
       dm_cls,
       dm_alm,
       dm_fdc,
       dm_fdv,

       cx_art,
       cx_alm;

{$R *.DFM}

procedure ListadoDisponibilidad;
begin
     CreateReportForm( TRptEdnForm, RptEdnForm );
end;

procedure TRptEdnForm.InitializeForm;
begin
     RelacionMaterialesFields := TRelacionMaterialesFields.Create( RelacionMaterialesTable );
     RelacionMateriales1Fields := TRelacionMaterialesFields.Create( RelacionMateriales1Table );
     RelacionMateriales2Fields := TRelacionMaterialesFields.Create( RelacionMateriales2Table );
     ArticuloFields := TArticuloFields.Create( ArticuloTable );

     DataSeleccionAlmacen.Value := 0;
     DataArticuloFinal.Value := HighStrCode;
end;

procedure TRptEdnForm.AlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TRptEdnForm.AlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scAmbas, Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptEdnForm.ArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, False, Sender );
end;

procedure TRptEdnForm.ArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptEdnForm.FormManagerOkButton;


var  CodigoArticuloDesglose : String;
     CodigoClaseADesglose,
     CodigoClaseBDesglose,
     CodigoClaseCDesglose : String;
     DescArticuloDesglose : String;
     Disponible : Decimal;
     NivelActual : SmallInt;

procedure DesglosaArticulo( _CodigoArticulo      : String;
                            _CodigoClaseA        : String;
                            _CodigoClaseB        : String;
                            _CodigoClaseC        : String;
                            _ArticuloRaiz,
                            _PrecioCompraValido,
                            _PrecioVentaValido   : Boolean );

var  Index : SmallInt;
     PrecioCompraValido,
     PrecioVentaValido : Boolean;
     Bm : TBookMark;
     SavedRangeStart,
     SavedRangeEnd : Pointer;
     ExistenciasArticulo : IExistenciasArticulo;

begin
     With RelacionMateriales1Table, RelacionMateriales1Fields do
       begin

       SetRange( [ _CodigoArticulo, _CodigoClaseA, _CodigoClaseB, _CodigoClaseC, 1, 1 ], [ _CodigoArticulo, _CodigoClaseA, _CodigoClaseB, _CodigoClaseC, MaxSmallint, MaxSmallint ] );
       First;
       While not Eof do
         begin

         If   ArticuloTable.FindKey( [ CodigoComponente.Value ] )
         then begin

              ExistenciasArticulo := StockAlmacen.ObtenStock( CodigoComponente.Value,
                                                              False,
                                                              ClaseAComponente.Value,
                                                              ClaseBComponente.Value,
                                                              ClaseCComponente.Value,
                                                              True,
                                                              '',
                                                              DataSeleccionAlmacen.Value=0,
                                                              DataAlmacen.Value,
                                                              True,
                                                              '',
                                                              True,
                                                              ApplicationContainer.Ejercicio,
                                                              0,
                                                              ApplicationContainer.NroMesFinal );

              DisponibilidadTable.Append;

              DisponibilidadFields.NroRegistro.Value := NroRegistroActual;
              DisponibilidadFields.Nivel.Value := NivelActual;
              DisponibilidadFields.CodigoArticulo.Value := CodigoArticuloDesglose;
              DisponibilidadFields.DescripcionArticulo.Value := DescArticuloDesglose;
              DisponibilidadFields.CodigoComponente.Value := CodigoComponente.Value;
              DisponibilidadFields.CodigoClaseA.Value := ClaseAComponente.Value;
              DisponibilidadFields.CodigoClaseB.Value := ClaseBComponente.Value;
              DisponibilidadFields.CodigoClaseC.Value:= ClaseCComponente.Value;
              DisponibilidadFields.DescripcionComponente.Value := ArticuloFields.Descripcion.Value;
              DisponibilidadFields.Cantidad.Value := Cantidad.Value;  // el número de componentes necesarios por unidad
              DisponibilidadFields.Existencias.Value := ExistenciasArticulo.SumaExistencias.Saldo;

              If   not _PrecioCompraValido
              then If   ExistenciasArticulo.CosteMedio=0.0
                   then begin
                        If   ExistenciasArticulo.CosteUltEntrada=0.0
                        then DisponibilidadFields.PrecioCompra.Value := ArticuloFields.Precio_Compra.Value
                        else DisponibilidadFields.PrecioCompra.Value := ExistenciasArticulo.CosteUltEntrada;
                        end
                   else DisponibilidadFields.PrecioCompra.Value := ExistenciasArticulo.CosteMedio;

              If   not _PrecioVentaValido
              then DisponibilidadFields.PrecioVenta.Value := ArticuloFields.Precio_Venta.Value;

              Disponible := 0.0;
              If   ( ExistenciasArticulo.SumaExistencias.Saldo>0.0 ) and ( Cantidad.Value<>0.0 )
              then Disponible := Trunc( ExistenciasArticulo.SumaExistencias.Saldo / Cantidad.Value );

              If   CantidadMaxima[ NivelActual + 1 ]<>-1
              then begin
                   If   ( CantidadMaximaAnterior[ NivelActual ]=-1 ) or ( Salen[ NivelActual ] + CantidadMaxima[ NivelActual + 1 ]<CantidadMaximaAnterior[ NivelActual ] )
                   then CantidadMaxima[ NivelActual ] := Salen[ NivelActual ] + CantidadMaxima[ NivelActual + 1 ];
                   CantidadMaxima[ NivelActual + 1 ] := -1;
                   end;

              If   CantidadMaxima[ NivelActual ]=-1
              then CantidadMaxima[ NivelActual ] := Disponible
              else If   Disponible<CantidadMaxima[ NivelActual ]
                   then CantidadMaxima[ NivelActual ] := Disponible;

              Salen[ NivelActual ] := Disponible;
              DisponibilidadFields.Cantidad.Value := Disponible;

              DisponibilidadTable.Post;

              If   RelacionMateriales2Table.FindGreaterOrEqual( [ CodigoComponente.Value, ClaseAComponente.Value, ClaseBComponente.Value, ClaseCComponente.Value, 1, 1 ] )
              then begin
                   PrecioCompraValido := DisponibilidadFields.PrecioCompra.Value<>0.0;
                   PrecioVentaValido  := DisponibilidadFields.PrecioVenta.Value<>0.0;
                   Bm := GetBookMark;
                   SaveRange( SavedRangeStart, SavedRangeEnd );
                   try
                     Inc( NivelActual );
                     DesglosaArticulo( CodigoComponente.Value, ClaseAComponente.Value, ClaseBComponente.Value, ClaseCComponente.Value, False, PrecioCompraValido, PrecioVentaValido );
                     Dec( NivelActual );
                   finally
                     RestoreRange( SavedRangeStart, SavedRangeEnd );
                     GotoBookMark( Bm );
                     end;
                   end;

              end;

         Next;
         end;

       If   _ArticuloRaiz
       then begin

            For Index := NivelMaximo downto 2 do
              If   CantidadMaxima[ Index ]<>-1
              then If   ( CantidadMaximaAnterior[ Index - 1 ]=-1 )  or
                        ( Salen[ Index - 1 ] + CantidadMaxima[ Index ]<CantidadMaximaAnterior[ Index - 1 ] )
                   then CantidadMaxima[ Index - 1 ] := Salen[ Index - 1 ] + CantidadMaxima[ Index ];

            With DisponibilidadFields do
              begin

              DisponibilidadTable.Append;

              DisponibilidadFields.NroRegistro.Value := NroRegistroActual;
              DisponibilidadFields.Nivel.Value := 0;
              DisponibilidadFields.CodigoArticulo.Value := CodigoArticuloDesglose;
              DisponibilidadFields.DescripcionArticulo.Value := DescArticuloDesglose;
              DisponibilidadFields.CodigoClaseA.Value := CodigoClaseADesglose;
              DisponibilidadFields.CodigoClaseB.Value := CodigoClaseBDesglose;
              DisponibilidadFields.CodigoClaseC.Value := CodigoClaseCDesglose;

              If   CantidadMaxima[ 1 ]<>-1
              then DisponibilidadFields.Cantidad.Value := CantidadMaxima[ 1 ];

              DisponibilidadTable.Post;
              end;

            end;

       end;

end;

procedure SeleccionaRegistros;
begin

     NroRegistroActual := 1;

     With RelacionMaterialesTable do
       begin
       SetRange( [ DataArticuloInicial.Value, '', '', '', 1, 1 ], [ DataArticuloFinal.Value,  HighStrCode, HighStrCode, HighStrCode, 1, 1 ] );
       ApplicationContainer.StartProgression( RecordCount );
       First;
       While not Eof do
         With RelacionMaterialesFields do
           begin
           NivelActual := 1;
           CodigoArticuloDesglose := CodigoArticulo.Value;
           CodigoClaseADesglose := CodigoClaseA.Value;
           CodigoClaseBDesglose := CodigoClaseB.Value;
           CodigoClaseCDesglose := CodigoClaseC.Value;
           If   ArticuloTable.FindKey( [ CodigoArticulo.Value ] )
           then begin
                DescArticuloDesglose := ArticuloFields.Descripcion.Value;
                ResetArrays;
                DesglosaArticulo( CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, True, False, False );
                Inc( NroRegistroActual );
                end;
           ApplicationContainer.ShowProgression;
           Next;
           end;

       end;

     ApplicationContainer.EndProgression;

end;

begin
     With Report do
       try
         Load;
         DisponibilidadTable := Report.CreateEmptyTable( 'Disponibilidad' );
         DisponibilidadFields := TDisponibilidadFields.Create( DisponibilidadTable );
         SeleccionaRegistros;
         FacturaCompras.FijaDecimalesInforme( Report );
         FacturaVentas.FijaDecimalesInforme( Report );
         Clase.SetReportTitles( Report, 4 );
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptEdnForm.SeleccionAlmacenCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     AlmacenCtrl.Enabled := DataSeleccionAlmacen.Value=1;
end;

procedure TRptEdnForm.SetCantidadMaxima( Index : SmallInt; Value : Decimal );
begin
     If   Value=-1
     then Cma[ Index ] := Value
     else Cma[ Index ] := Cm[ Index ];
     Cm[ Index ] := Value;
end;

procedure TRptEdnForm.SetCantidadMaximaAnterior( Index : SmallInt; Value : Decimal );
begin
     Cma[ Index ] := Value;
end;

function  TRptEdnForm.GetCantidadMaxima( Index : SmallInt ) : Decimal;
begin
     Result := Cm[ Index ];
end;

function  TRptEdnForm.GetCantidadMaximaAnterior( Index : SmallInt ) : Decimal;
begin
     Result := Cma[ Index ];
end;

procedure TRptEdnForm.ResetArrays;

var   Index   : SmallInt;

begin
     For Index := 1 to NivelMaximo do
       begin
       Cm[ Index ] := -1;
       Cma[ Index ] := -1;
       Salen[ Index ] := -1;
       end;
end;


end.

