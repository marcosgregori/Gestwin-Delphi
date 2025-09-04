
unit l_cac;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,

     AppContainer,

     ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb,
  DataManager, dxmdaset, ReportManager, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit,

  Gim30Fields, cxGraphics, cxIndexedComboBox, dxSkinsCore, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox;


type
    TRptCacForm = class(TgxForm)
    FormManager: TgxFormManager;
    MovimientoTable: TnxeTable;
    LineaMovimientoTable: TnxeTable;
    DataPanel: TgxEditPanel;
    ProveedorInicialCtrl: TcxDBTextEdit;
    ProveedorFinalCtrl: TcxDBTextEdit;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    ArticuloInicialCtrl: TcxDBTextEdit;
    ArticuloFinalCtrl: TcxDBTextEdit;
    AlmacenInicialCtrl: TcxDBTextEdit;
    AlmacenFinalCtrl: TcxDBTextEdit;
    Bevel1: TShape;
    Report: TgxReportManager;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataProveedorInicial: TWideStringField;
    DataProveedorFinal: TWideStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataArticuloInicial: TWideStringField;
    DataArticuloFinal: TWideStringField;
    DataAlmacenInicial: TWideStringField;
    DataAlmacenFinal: TWideStringField;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    gxRangeBox3: TgxRangeBox;
    gxRangeBox4: TgxRangeBox;
    SituacionCtrl: TcxDBIndexedComboBox;
    DataSituacion: TSmallintField;
    Label3: TcxLabel;
    Label6: TcxLabel;
    Label1: TcxLabel;
    Label5: TcxLabel;
    Label16: TcxLabel;
    Label2: TcxLabel;
    Label4: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ProveedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure AlmacenCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure AlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

    public
      MovimientoFields : TMovimientoFields;
      LineaMovimientoFields : TLineaMovimientoFields;
      CarteraArticulosTable : TnxeTable;
      CarteraArticulosFields : TCarteraArticulosFields;
    end;

var  RptCacForm: TRptCacForm = nil;

procedure ListadoCarteraAlbaranesCompra;


implementation

uses   SysUtils,
       LibUtils,

       Gdm00Dm,
       Gdm30Dm,
       Gim00Fields,
       Gim10Fields,

       dmi_mov,
       dmi_sto,

       dm_sto,
       dm_cls,
       dm_pro,
       dm_art,
       dm_mov,
       dm_fdc,
       dm_alm,

       b_msg,

       cx_art,
       cx_pro,
       cx_alm;

{$R *.DFM}

procedure ListadoCarteraAlbaranesCompra;
begin
     CreateReportForm( TRptCacForm, RptCacForm );
end;

procedure TRptCacForm.initializeForm;
begin
     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );

     With DataModule00.DmEmpresaFields do
       begin
       AlmacenInicialCtrl.Enabled := Stock_MultiAlmacen.Value;
       AlmacenFinalCtrl.Enabled := Stock_MultiAlmacen.Value;
       end;

     DataProveedorFinal.Value := HighStrCode;
     DataFechaInicial.Value := ApplicationContainer.TodayDate;
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;
     DataSituacion.Value := 0;
     DataArticuloFinal.Value := HighStrCode;
     DataAlmacenFinal.Value := HighStrCode;

end;

procedure TRptCacForm.ProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TRptCacForm.ProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptCacForm.FormManagerOkButton;


procedure SeleccionaCartera;

var  Procesar : Boolean;

begin

     With MovimientoTable, MovimientoFields do
       begin
       SetRange( [ tmCompra, DataProveedorInicial.Value, DataFechaInicial.Value ],
                 [ tmCompra, DataProveedorFinal.Value, DataFechaFinal.Value ] );

       ApplicationContainer.StartProgression( RecordCount );

       First;
       While not Eof do
         begin

         With MovimientoFields do
           case DataSituacion.value of
             0 : Procesar := True;
             1 : Procesar := NoFacturar.Value;
             2 : Procesar := not Facturado.Value;
             3 : Procesar := Facturado.Value;
             4 : Procesar := not Traspasado.Value;
             5 : Procesar := Traspasado.Value;
             end;

         If   Procesar
         then With LineaMovimientoTable do
                begin

                With MovimientoFields do
                  SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );

                First;
                While not eof do
                  begin
                  If   ( LineaMovimientoFields.CodigoArticulo.Value<>ArticuloManual ) and
                       ( LineaMovimientoFields.CodigoArticulo.Value>=DataArticuloInicial.Value ) and
                       ( LineaMovimientoFields.CodigoArticulo.Value<=DataArticuloFinal.Value ) and
                       ( LineaMovimientoFields.CodigoAlmacen.Value>=DataAlmacenInicial.Value ) and
                       ( LineaMovimientoFields.CodigoAlmacen.Value<=DataAlmacenFinal.Value ) and
                       ( LineaMovimientoFields.Cantidad.Value<>0.0 )
                  then With CarteraArticulosTable do
                         begin

                         If   FindKey( [ LineaMovimientoFields.CodigoAlmacen.Value,
                                         LineaMovimientoFields.CodigoArticulo.Value,
                                         LineaMovimientoFields.CodigoClaseA.Value,
                                         LineaMovimientoFields.CodigoClaseB.Value,
                                         LineaMovimientoFields.CodigoClaseC.Value,
                                         0 ] )
                         then begin
                              Edit;
                              CarteraArticulosFields.Cantidad.Value := CarteraArticulosFields.Cantidad.Value + LineaMovimientoFields.Cantidad.Value;
                              CarteraArticulosFields.ImporteNeto.Value := CarteraArticulosFields.ImporteNeto.Value + LineaMovimientoFields.ImporteNeto.Value
                              end
                         else begin
                              Append;
                              CarteraArticulosFields.CodigoAlmacen.Value := LineaMovimientoFields.CodigoAlmacen.Value;
                              CarteraArticulosFields.CodigoArticulo.Value := LineaMovimientoFields.CodigoArticulo.Value;
                              CarteraArticulosFields.CodigoClaseA.Value := LineaMovimientoFields.CodigoClaseA.Value;
                              CarteraArticulosFields.CodigoClaseB.Value := LineaMovimientoFields.CodigoClaseB.Value;
                              CarteraArticulosFields.CodigoClaseC.Value := LineaMovimientoFields.CodigoClaseC.Value;
                              CarteraArticulosFields.Descripcion.Value := Articulo.Descripcion( CarteraArticulosFields.CodigoArticulo.Value, True );
                              CarteraArticulosFields.NombreAlmacen.Value := Almacen.Descripcion( CarteraArticulosFields.CodigoAlmacen.Value, True );
                              CarteraArticulosFields.Tipo.Value := 0;
                              CarteraArticulosFields.Cantidad.Value := LineaMovimientoFields.Cantidad.Value;
                              CarteraArticulosFields.ImporteNeto.Value := LineaMovimientoFields.ImporteNeto.Value;
                              end;

                         Post;
                         end;

                  ApplicationContainer.ShowProgression;

                  Next;
                  end;

                end;

         Next;
         end;
       end;

end;

procedure SeleccionaRegistros;

var  ExistenciasArticulo : IExistenciasArticulo;


begin
     try

       SeleccionaCartera;

       With CarteraArticulosTable do
         begin

         ApplicationContainer.StartProgression( RecordCount );

         First;
         While not Eof do
           begin

           Edit;

           ExistenciasArticulo := StockAlmacen.ObtenStock( CarteraArticulosFields.CodigoArticulo.Value,
                                                           False,
                                                           CarteraArticulosFields.CodigoClaseA.Value,
                                                           CarteraArticulosFields.CodigoClaseB.Value,
                                                           CarteraArticulosFields.CodigoClaseC.Value,
                                                           True,
                                                           '',
                                                           False,
                                                           CarteraArticulosFields.CodigoAlmacen.Value,
                                                           True,
                                                           '',
                                                           False,
                                                           ApplicationContainer.Ejercicio,
                                                           0,
                                                           ApplicationContainer.NroMesFinal );

           CarteraArticulosFields.Existencias.Value := ExistenciasArticulo.SumaExistencias.Saldo;
           CarteraArticulosFields.ExistenciasVirtuales.Value := CarteraArticulosFields.Cantidad.Value + ExistenciasArticulo.SumaExistencias.Saldo;

           Post;

           ApplicationContainer.ShowProgression;

           Next;
           end;

         end;

     finally
       ApplicationContainer.endProgression;
       end;
end;

begin
     Enabled := false;

     With Report do
       begin
       try

         Load;

         CarteraArticulosTable := Report.CreateEmptyTable( 'CarteraArticulos', DataModule30.GetSQL( 'CarteraArticulos' ) );
         CarteraArticulosFields := TCarteraArticulosFields.Create( CarteraArticulosTable );

         CarteraArticulosTable.IndexFieldNames := 'CodigoAlmacen;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;Tipo';

         SeleccionaRegistros;

         Clase.SetReportTitles( Report, 4 );
         FacturaCompras.FijaDecimalesInforme( Report );

         Start;
       except on E : Exception do Cancel( E );
         end;

       end;

end;

procedure TRptCacForm.AlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TRptCacForm.AlmacenCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scCompras, Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptCacForm.ArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scCompras, False, Sender );
end;

procedure TRptCacForm.ArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

end.
