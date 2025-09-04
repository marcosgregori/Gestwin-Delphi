
unit l_fdc;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,

     LibUtils,
     AppContainer,

     ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB,
     dxmdaset, DataManager, ReportManager, nxdb, cxGraphics, cxControls,
     cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxDBEdit,
     cxIndexedComboBox, cxCheckBox, cxCalendar,

     Gim10Fields,
     Gim30Fields, dxSkinsCore, dxSkinsDefaultPainters, cxLookAndFeels, cxLabel,
  cxGroupBox;


type
    
    TRptFdcForm = class(TgxForm)
    FormManager: TgxFormManager;
    FacturaComprasTable: TnxeTable;
    MovimientoTable: TnxeTable;
    DataPanel: TgxEditPanel;
    SituacionCtrl: TcxDBIndexedComboBox;
    ProveedorInicialCtrl: TcxDBTextEdit;
    ProveedorFinalCtrl: TcxDBTextEdit;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    AgruparPorProveedorCtrl: TcxDBCheckBox;
    IncluirAlbaranesCtrl: TcxDBCheckBox;
    LineaMovimientoTable: TnxeTable;
    Report: TgxReportManager;
    Data: TgxMemData;
    DataProveedorInicial: TWideStringField;
    DataProveedorFinal: TWideStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataAgruparPorProveedor: TBooleanField;
    DataSituacion: TSmallintField;
    DataIncluirAlbaranes: TBooleanField;
    DataSource: TDataSource;
    gxRangeBox3: TgxRangeBox;
    gxRangeBox1: TgxRangeBox;
    DataIniciarPaginaProveedor: TBooleanField;
    IniciarPaginaProveedorCtrl: TcxDBCheckBox;
    Label8: TcxLabel;
    Label3: TcxLabel;
    Label6: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure AgruparPorProveedorCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure ProveedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

    public

      FacturaComprasFields : TFacturaComprasFields;
      MovimientoFields : TMovimientoFields;
      LineaMovimientoFields : TLineaMovimientoFields;

      CabeceraTable,
      LineasTable : TnxeTable;

      CabeceraFields : TReportCabeceraFacturaFields;
      LineasFields : TReportLineasFacturaFields;

      TotalBruto,
      TotalDescuentos,
      TotalNeto,
      TotalCuotaIVA : Decimal;
      Insertar : Boolean;

      NroOperacionActual : LongInt;

    end;


var RptFdcForm: TRptFdcForm = nil;

procedure ListadoFacturasCompra;

implementation

uses   SysUtils,

       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm30Dm,
       Gim00Fields,

       dmi_mov,

       dm_mov,
       dm_fdc,
       dm_iva,
       dm_pro,
       dm_art,

       b_msg,

       cx_art,
       cx_pro;

{$R *.DFM}

procedure ListadoFacturasCompra;
begin
     CreateReportForm( TRptFdcForm, RptFdcForm );
end;

procedure TRptFdcForm.InitializeForm;
begin
     FacturaComprasFields := TFacturaComprasFields.Create( FacturaComprasTable );
     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );

     DataAgruparPorProveedor.Value := False;
     DataProveedorFinal.Value := HighStrCode;
     DataFechaInicial.Value := ApplicationContainer.TodayDate;
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;
     DataSituacion.Value := 0;
     DataIncluirAlbaranes.Value := False;
end;

procedure TRptFdcForm.ProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TRptFdcForm.ProveedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptFdcForm.FormManagerOkButton;

procedure GeneraRegistroFactura;

procedure CalculaImporteAlbaran;
begin
     With LineaMovimientoTable do
       begin

       TotalBruto := 0.0;
       TotalDescuentos := 0.0;
       TotalNeto := 0.0;
       TotalCuotaIVA := 0.0;

       With MovimientoFields do
         SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ],  [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );

       First;
       While not Eof do
         begin

         With LineaMovimientoFields do
           begin
           DecAdd( TotalBruto, ImporteBruto.Value );
           DecAdd( TotalDescuentos, ImporteDescuento.Value );
           DecAdd( TotalNeto, ImporteNeto.Value  );
           DecAdd( TotalCuotaIVA, CuotaIVA.Value );
           end;

         Next;
         end;

       end;
end;

begin
     With CabeceraFields do
       begin

       CabeceraTable.Append;

       NroOperacion.Value := NroOperacionActual;
       CodigoPropietario.Value := FacturaComprasFields.Proveedor.Value;
       Nombre.Value := Proveedor.Descripcion( CodigoPropietario.Value, True );
       Fecha.Value := FacturaComprasFields.Fecha.Value;
       Serie.Value := FacturaComprasFields.SerieNroFactura.Value;
       Ejercicio.Value := FacturaComprasFields.Ejercicio.Value;
       Traspasada.Value := FacturaComprasFields.Traspasada.Value;

       BrutoArticulos.Value := FacturaComprasFields.BrutoArticulos.Value;
       DescuentoArticulos.Value := FacturaComprasFields.DescuentoArticulos.Value;
       DescuentoPropietario.Value := FacturaComprasFields.DescuentoProveedores.Value;
       NetoFactura.Value := FacturaComprasFields.NetoFactura.Value + FacturaComprasFields.Portes.Value - DescuentoPropietario.Value;
       CuotaIVA.Value := FacturaComprasFields.CuotaIVA.Value;
       TotalFactura.Value := FacturaComprasFields.TotalFactura.Value;
       end;

     CabeceraTable.Post;

     ApplicationContainer.ShowProgression;

     If   DataIncluirAlbaranes.Value
     then With MovimientoTable do
            begin

            With FacturaComprasFields do
              SetRange( [ tmCompra, Ejercicio.Value, Proveedor.Value, SerieNroFactura.Value, 0 ],
                        [ tmCompra, Ejercicio.Value, Proveedor.Value, SerieNroFactura.Value, 0 ] );

            First;
            While not Eof do
              begin

              CalculaImporteAlbaran;

              LineasTable.Append;

              LineasFields.NroOperacion.Value := NroOperacionActual;
              LineasFields.Serie.Value := MovimientoFields.Serie.Value;
              LineasFields.NroDocumento.Value := MovimientoFields.NroDocumento.Value;
              LineasFields.Fecha.Value := MovimientoFields.Fecha.Value;

              LineasFields.BrutoArticulos.Value := TotalBruto;
              LineasFields.DescuentoArticulos.Value := TotalDescuentos;
              LineasFields.NetoAlbaran.Value := TotalNeto;
              LineasFields.CuotaIVA.Value := TotalCuotaIVA;
              LineasFields.TotalAlbaran.Value := TotalNeto + TotalCuotaIVA;

              LineasTable.Post;

              Next;
              end;

            end;
end;

procedure SeleccionaRegistros;
begin
     With FacturaComprasTable do
       begin

       If   DataAgruparPorProveedor.Value
       then begin
            IndexFieldNames := 'Proveedor;Fecha';
            SetRange( [ DataProveedorInicial.Value, DataFechaInicial.Value ], [ DataProveedorFinal.Value, DataFechaFinal.Value ] );
            end
       else begin
            IndexFieldNames := 'Fecha';
            SetRange( [ DataFechaInicial.Value ], [ DataFechaFinal.Value ] );
            end;

       try

         ApplicationContainer.StartProgression( RecordCount );

         NroOperacionActual := 1;

         First;
         while not Eof do
           begin

           case DataSituacion.Value of
             0 : Insertar := True;
             1 : Insertar := not FacturaComprasFields.Traspasada.Value;
             2 : Insertar := FacturaComprasFields.Traspasada.Value;
             end;

           If   Insertar
           then begin
                GeneraRegistroFactura;
                Inc( NroOperacionActual );
                end;

           Next;
           end;

         finally
           ApplicationContainer.EndProgression;
           end;

       end;
end;

begin
     Enabled := False;

     With Report do
       begin
       try

         Load;

         CabeceraTable := CreateEmptyTable( 'CabeceraFactura', DataModule30.SQLSet );
         LineasTable := CreateEmptyTable( 'LineasFactura', DataModule30.SQLSet );

         CabeceraFields := TReportCabeceraFacturaFields.Create( CabeceraTable );
         LineasFields := TReportLineasFacturaFields.Create( LineasTable );

         SeleccionaRegistros;

         SetValueFields( Data );
         SetValue( 'TextoSituacion', SituacionCtrl.Text ); 

         Start;

       except on E : Exception do Cancel( E );
         end;

       end;

end;

procedure TRptFdcForm.AgruparPorProveedorCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With AgruparPorProveedorCtrl do
       begin
       ProveedorInicialCtrl.Enabled := EditValue;
       ProveedorFinalCtrl.Enabled := EditValue;
       IniciarPaginaProveedorCtrl.Enabled := EditValue;
       end;
end;

end.
 
