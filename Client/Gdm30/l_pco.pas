
unit l_pco;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,

     LibUtils,
     AppContainer,

     ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb,
  DataManager, dxmdaset, ReportManager, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit,

  Gim30Fields, cxCheckBox, cxGraphics, cxIndexedComboBox, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxPC, cxLookAndFeels, cxLabel,
  cxGroupBox, cxPCdxBarPopupMenu, dxBarBuiltInMenu;


type
    TRelacionAlbaranesFields = class( TnxeDatasetFields)
      NroDocumento : TIntegerField;
      Propietario : TWideStringField;
      Nombre : TWideStringField;
      CodigoVendedor : TWideStringField;
      NombreVendedor : TWideStringField;
      Fecha : TDateField;
      Serie : TWideStringField;
      Ejercicio : TSmallIntField;
      ImporteAlbaran : TBCDField;
      EntregaACuenta : TBCDField;
      ImporteTotal : TBCDField;
      end;

    TRptPcoForm = class(TgxForm)
    FormManager: TgxFormManager;
    MovimientoTable: TnxeTable;
    LineaMovimientoTable: TnxeTable;
    DataPanel: TgxEditPanel;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    Report: TgxReportManager;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataClienteInicial: TWideStringField;
    DataClienteFinal: TWideStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    gxRangeBox2: TgxRangeBox;
    IncluirIVACtrl: TcxDBCheckBox;
    SerieFacturacionCtrl: TcxDBTextEdit;
    DataIncluirIVA: TBooleanField;
    DataGrupoCliente: TWideStringField;
    GrupoClienteCtrl: TcxDBTextEdit;
    SituacionCtrl: TcxDBIndexedComboBox;
    DataSituacion: TSmallintField;
    DataSerie: TWideStringField;
    DataVendedorInicial: TWideStringField;
    DataVendedorFinal: TWideStringField;
    PageControl: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    gxRangeBox1: TgxRangeBox;
    ClienteInicialCtrl: TcxDBTextEdit;
    ClienteFinalCtrl: TcxDBTextEdit;
    gxRangeBox4: TgxRangeBox;
    VendedorInicialCtrl: TcxDBTextEdit;
    VendedorFinalCtrl: TcxDBTextEdit;
    DataIniciarPagina: TBooleanField;
    IniciarPaginaCtrl: TcxDBCheckBox;
    Label6: TcxLabel;
    Label10: TcxLabel;
    Label11: TcxLabel;
    Label14: TcxLabel;
    Label15: TcxLabel;
    Label1: TcxLabel;
    Label4: TcxLabel;
    Label3: TcxLabel;
    Label16: TcxLabel;
    Label2: TcxLabel;
    Label5: TcxLabel;
    Label21: TcxLabel;
    Label22: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
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
    procedure SerieFacturacionCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure SerieFacturacionCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GrupoClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GrupoClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure VendedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure VendedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    private

    public
      MovimientoFields : TMovimientoFields;
      LineaMovimientoFields : TLineaMovimientoFields;
      RelacionAlbaranesTable : TnxeTable;
      RelacionAlbaranesFields : TRelacionAlbaranesFields;
      Pendiente : Decimal;
    end;

var  RptPcoForm: TRptPcoForm = nil;

procedure ListadoPendienteCobro;


implementation

uses   SysUtils,

       Gim00Fields,
       Gim10Fields,

       dmi_mov,

       dm_sto,
       dm_cls,
       dm_cli,
       dm_ven,
       dm_art,
       dm_mov,
       dm_fdv,
       dm_alm,
       dm_sdf,
       dm_gdc,
       dm_iva,

       b_msg,

       cx_art,
       cx_cli,
       cx_alm,
       cx_sdf,
       cx_gdc,
       cx_ven;

{$R *.DFM}

procedure ListadoPendienteCobro;
begin
     CreateReportForm( TRptPcoForm, RptPcoForm );
end;

procedure TRptPcoForm.InitializeForm;
begin
     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );

     DataClienteFinal.Value := HighStrCode;
     DataVendedorFinal.Value := HighStrCode;
     DataFechaInicial.Value := ApplicationContainer.TodayDate;
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;
     DataSituacion.Value := 0;
     DataIncluirIVA.Value := False;
end;

procedure TRptPcoForm.SerieFacturacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TRptPcoForm.SerieFacturacionCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptPcoForm.VendedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Vendedor.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptPcoForm.VendedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender );
end;

procedure TRptPcoForm.ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TRptPcoForm.ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptPcoForm.FormManagerOkButton;

var ImporteAlbaran : Decimal;

procedure GeneraRegistro;

var Insertar : Boolean;

begin

     try

       ImporteAlbaran := 0.0;

       With LineaMovimientoTable do
         begin

         With MovimientoFields do
           SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );

         First;
         While not Eof do
           begin

           With LineaMovimientoFields do
             If   DataIncluirIVA.Value
             then DecAdd( ImporteAlbaran, ImporteTotal.Value )
             else DecAdd( ImporteAlbaran, ImporteNeto.Value );

           Next;
           end;
         end;

       RelacionAlbaranesTable.Append;

       RelacionAlbaranesFields.NroDocumento.Value := MovimientoFields.NroDocumento.Value;
       RelacionAlbaranesFields.Propietario.Value := MovimientoFields.Propietario.Value;
       RelacionAlbaranesFields.Nombre.Value := Cliente.Descripcion( MovimientoFields.Propietario.Value, True );
       If   not ValueIsEmpty( MovimientoFields.CodigoVendedor.Value )
       then begin
            RelacionAlbaranesFields.CodigoVendedor.Value := MovimientoFields.CodigoVendedor.Value;
            RelacionAlbaranesFields.NombreVendedor.Value := Vendedor.Descripcion( MovimientoFields.CodigoVendedor.Value, True );
            end;
       RelacionAlbaranesFields.Fecha.Value := MovimientoFields.Fecha.Value;
       RelacionAlbaranesFields.Serie.Value := MovimientoFields.Serie.Value;
       RelacionAlbaranesFields.Ejercicio.Value := MovimientoFields.Ejercicio.Value;

       RelacionAlbaranesFields.ImporteAlbaran.Value := ImporteAlbaran;
       RelacionAlbaranesFields.EntregaACuenta.Value := MovimientoFields.EntregaACuenta.Value;
       RelacionAlbaranesFields.ImporteTotal.Value := ImporteAlbaran - MovimientoFields.EntregaACuenta.Value;

       RelacionAlbaranesTable.Post;

       ApplicationContainer.ShowProgression;

     finally
       end;

end;

procedure SeleccionaRegistros;

var  Insertar : Boolean;

begin
     With MovimientoTable do
       begin

       SetRange( [ tmVenta, DataFechaInicial.Value ], [ tmVenta, DataFechaFinal.Value ] );

       try

         ApplicationContainer.StartProgression( RecordCount );

         First;
         while not Eof do
           begin

           If   ( DataSerie.Value=MovimientoFields.Serie.Value ) and
                ( ( DataGrupoCliente.Value='' ) or ( DataGrupoCliente.Value=MovimientoFields.GrupoFacturacion.Value ) ) and
                ( ( ( PageControl.ActivePageIndex=0 ) and
                    ( ( AnsiCompareStr( MovimientoFields.Propietario.Value, DataClienteInicial.Value )>=0 ) and ( AnsiCompareStr( MovimientoFields.Propietario.Value, DataClienteFinal.Value )<=0 ) ) ) or
                  ( ( PageControl.ActivePageIndex=1 ) and
                    ( ( AnsiCompareStr( MovimientoFields.CodigoVendedor.Value, DataVendedorInicial.Value )>=0 ) and ( AnsiCompareStr( MovimientoFields.CodigoVendedor.Value, DataVendedorFinal.Value )<=0 ) ) ) ) and
                not MovimientoFields.Facturado.Value

           then begin

                Insertar := True;

                With MovimientoFields do
                  case DataSituacion.Value of
                    0 : ;
                    1 : Insertar := NoFacturar.Value;
                    2 : Insertar := not NoFacturar.Value;                    
                    end;

                If   Insertar
                then GeneraRegistro;

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
       try

         Load;

         RelacionAlbaranesTable := Report.CreateEmptyTable( 'RelacionAlbaranes' );
         RelacionAlbaranesFields := TRelacionAlbaranesFields.Create( RelacionAlbaranesTable );

         With RelacionAlbaranesTable do
           If   PageControl.ActivePageIndex=0
           then IndexFieldNames := 'Propietario;NroDocumento'
           else IndexFieldNames := 'CodigoVendedor;Propietario;NroDocumento';

         SeleccionaRegistros;

         Clase.SetReportTitles( Report, 4 );
         FacturaVentas.FijaDecimalesInforme( Report );

         SetValue( RsSeleccion, PageControl.ActivePageIndex );
         SetValue( 'NombreSerie', SerieFacturacion.Descripcion( DataSerie.Value, True ) );

         Start;

       except on E : Exception do Cancel( E );
         end;

end;

procedure TRptPcoForm.GrupoClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaGruposCliente( Sender );
end;

procedure TRptPcoForm.GrupoClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then GrupoClienteCtrl.Description := RsgMsgTodos
     else GrupoCliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptPcoForm.AlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TRptPcoForm.AlmacenCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scVentas, Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptPcoForm.ArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scVentas, False, Sender );
end;

procedure TRptPcoForm.ArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

end.
