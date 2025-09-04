
unit l_ccl;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,

     LibUtils,
     AppContainer,

     ComCtrls,
     DB,
     nxdb,
     DataManager, ReportManager, Menus, cxLookAndFeelPainters, cxButtons,
     dxmdaset, cxPC, cxControls, cxDBEdit, cxContainer, cxEdit, cxTextEdit,
     cxMaskEdit, cxSpinEdit,

     Gim00Fields,
     Gim30Fields,

     dm_cli, cxCheckBox, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxGraphics, cxLookAndFeels, cxLabel, cxGroupBox,
  cxPCdxBarPopupMenu, dxBarBuiltInMenu, dxUIAClasses;


type
    TRptCclForm = class(TgxForm)
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    DataPanel: TgxEditPanel;
    Data: TgxMemData;
    DataClienteInicial: TWideStringField;
    DataClienteFinal: TWideStringField;
    DataMesInicial: TSmallIntField;
    DataMesFinal: TSmallIntField;
    DataCodigoArticuloInicial: TWideStringField;
    DataCodigoArticuloFinal: TWideStringField;
    DataCodigoFamiliaInicial: TWideStringField;
    DataCodigoFamiliaFinal: TWideStringField;
    DataSource: TDataSource;
    DataGrupoClienteInicial: TWideStringField;
    DataGrupoClienteFinal: TWideStringField;
    DataMostrarMargenMedio: TBooleanField;
    ArticulosPanel: TcxGroupBox;
    Seleccion2PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    gxRangeBox2: TgxRangeBox;
    CodigoArticuloInicialCtrl: TcxDBTextEdit;
    CodigoArticuloFinalCtrl: TcxDBTextEdit;
    MostrarMargenMedioCtrl: TcxDBCheckBox;
    Label1: TcxLabel;
    Label15: TcxLabel;
    Label18: TcxLabel;
    TabSheet2: TcxTabSheet;
    gxRangeBox4: TgxRangeBox;
    CodigoFamiliaInicialCtrl: TcxDBTextEdit;
    CodigoFamiliaFinalCtrl: TcxDBTextEdit;
    Label10: TcxLabel;
    Label21: TcxLabel;
    Label22: TcxLabel;
    Label9: TcxLabel;
    MesesPanel: TcxGroupBox;
    gxRangeBox5: TgxRangeBox;
    MesInicialCtrl: TcxDBSpinEdit;
    MesFinalCtrl: TcxDBSpinEdit;
    Label6: TcxLabel;
    Label2: TcxLabel;
    Label5: TcxLabel;
    ClientesPanel: TcxGroupBox;
    seleccion1PageControl: TcxPageControl;
    TabSheet3: TcxTabSheet;
    gxRangeBox1: TgxRangeBox;
    ClienteInicialCtrl: TcxDBTextEdit;
    ClienteFinalCtrl: TcxDBTextEdit;
    Label3: TcxLabel;
    Label16: TcxLabel;
    Label17: TcxLabel;
    GrupoClienteTabSheet: TcxTabSheet;
    gxRangeBox3: TgxRangeBox;
    GrupoClienteInicialCtrl: TcxDBTextEdit;
    GrupoClienteFinalCtrl: TcxDBTextEdit;
    Label12: TcxLabel;
    Label19: TcxLabel;
    Label20: TcxLabel;
    Label14: TcxLabel;
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
    procedure MesCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure GrupoClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GrupoClienteCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure CodigoFamiliaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoFamiliaCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure TabSheet2Show(Sender: TObject);
    procedure ReportSetReportName;
    private
    protected
    class var
      AgrupadoPorArticulo : Boolean;
    public

      SumaImporte,
      SumaUnidades,
      PrecioCoste,
      PrecioMedioVenta,
      MargenMedio : Decimal;

    end;

var RptCclForm: TRptCclForm = nil;

procedure ListadoConsumoClientes( AgrupadoPorArticulo : Boolean = False );

implementation

uses   SysUtils,
       DateUtils,

       EnterpriseDataAccess,

       Gdm00Dm,

       b_msg,

       dm_art,
       dm_fam,
       dm_sec,
       dm_sto,
       dm_gdc,
       dm_fdv,

       cx_cli,
       cx_gdc,
       cx_art,
       cx_fam;

{$R *.DFM}

resourceString
     RsMsg1 = 'Listado de consumos de clientes';

procedure ListadoConsumoClientes( AgrupadoPorArticulo : Boolean = False );
begin
     TRptCclForm.AgrupadoPorArticulo := AgrupadoPorArticulo;
     CreateReportForm( TRptCclForm, RptCclForm );
end;

procedure TRptCclForm.InitializeForm;
begin

     If   AgrupadoPorArticulo
     then begin
          Caption := RsMsg1;

          With ArticulosPanel do
            begin
            Top := 0;
            TabOrder := 0;
            end;

          With MesesPanel do
            begin
            Top := 10;
            TabOrder := 1;
            end;

          end;

     GrupoClienteTabSheet.Visible := DataModule00.DmEmpresaFields.Cliente_GruposFac.Value;

     DataClienteFinal.Value := HighStrCode;
     DataGrupoClienteFinal.Value := HighStrCode;
     DataMesInicial.Value := 1;
     DataMesFinal.Value := MonthOf( ApplicationContainer.TodayDate );
     DataCodigoArticuloFinal.Value := HighStrCode;
     DataCodigoFamiliaFinal.Value := HighStrCode;
     DataMostrarMargenMedio.Value := False;
end;

procedure TRptCclForm.MesCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateMonth( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptCclForm.ReportSetReportName;
begin
     If   AgrupadoPorArticulo
     then Report.FileName := 'dm30\l_ccl2'
     else Report.FileName := 'dm30\l_ccl1';
end;

procedure TRptCclForm.TabSheet2Show(Sender: TObject);
begin
     DataMostrarMargenMedio.Value := False;
end;

procedure TRptCclForm.FormManagerOkButton;

function ConstruyeConsulta : String;

var  SQLFields,
     SQLSelect,
     SQLOrder,
     SQLJoin,
     SQLText : String;
     TipoRegistro : SmallInt;

begin

     {
     SELECT ConsumoVentas.Ejercicio,
            ConsumoVentas.Cliente,
            Cliente.Nombre,
            ConsumoVentas.FamiliaArticulo,
            ConsumoVentas.CodigoClaseA,
            ConsumoVentas.CodigoClaseB,
            ConsumoVentas.CodigoClaseC,
            <Unidades> AS Unidades,
            <Importes> AS Importe
            <Descuentos> AS Descuento
            <Campos>

     FROM   ConsumoVentas
            LEFT JOIN Cliente ON ( ConsumoVentas.Cliente=Cliente.Codigo )
            <Tablas>

     WHERE  <Seleccion>

     ORDER BY Cliente, FamiliaArticulo, Ejercicio
     }

     With Report, ReportManagerDataModule do
       begin

       If   Seleccion2PageControl.ActivePageIndex=0
       then TipoRegistro := 2
       else TipoRegistro := 1;

       SQLFields := '';
       SQLJoin := '';

       If   AgrupadoPorArticulo
       then SQLOrder := 'FamiliaArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, Cliente, Ejercicio'
       else SQLOrder := 'Cliente, FamiliaArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, Ejercicio';

       SQLSelect := SQLVarsFormat( ' Tipo=? AND Ejercicio BETWEEN ? AND ? ',
                                   [ TipoRegistro,
                                     ApplicationContainer.Ejercicio - 1,
                                     ApplicationContainer.Ejercicio ] );

       StrAdd( SQLSelect, ' AND ' + ObtenExpresionRango( DataMesInicial.Value, DataMesFinal.Value, 'Unidades' ) + ' <>0.0 ');

       case Seleccion1PageControl.ActivePageIndex of
         0 : begin
             StrAdd( SQLFields, ', '' '' AS CodigoGrupo, '' '' AS NombreGrupo ' );
             StrAdd( SQLSelect, SQLFieldsFormat( 'AND ConsumoVentas.Cliente BETWEEN ? AND ?', [ DataClienteInicial, DataClienteFinal ] ) );
             end;
         1 : begin
             StrAdd( SQLFields, ', GrupoCliente.Codigo AS CodigoGrupo, GrupoCliente.Descripcion AS DescripcionGrupo ' );
             StrAdd( SQLSelect, SQLFieldsFormat( 'AND Cliente.Factura_Agrupacion BETWEEN ? AND ?', [ DataGrupoClienteInicial, DataGrupoClienteFinal ] ) );
             SQLJoin := ' LEFT JOIN GrupoCliente ON ( Cliente.Factura_Agrupacion=GrupoCliente.Codigo ) ';
             If   AgrupadoPorArticulo
             then SQLOrder := 'FamiliaArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, GrupoCliente.Codigo, Cliente, Ejercicio'
             else SQLOrder := 'GrupoCliente.Codigo, Cliente, FamiliaArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, Ejercicio';
             end;
         end;

       case Seleccion2PageControl.ActivePageIndex of
         0 : begin
             StrAdd( SQLFields, ', Articulo.Descripcion ' );
             StrAdd( SQLSelect, SQLFieldsFormat( 'AND ConsumoVentas.FamiliaArticulo BETWEEN ? AND ?', [ DataCodigoArticuloInicial, DataCodigoArticuloFinal ] ) );
             StrAdd( SQLJoin, ' LEFT JOIN Articulo ON ( ConsumoVentas.FamiliaArticulo=Articulo.Codigo ) ' );
             end;
         1 : begin
             StrAdd( SQLFields, ', Familia.Descripcion ' );
             StrAdd( SQLSelect, SQLFieldsFormat( 'AND ConsumoVentas.FamiliaArticulo BETWEEN ? AND ?', [ DataCodigoFamiliaInicial, DataCodigoFamiliaFinal ] ) );
             StrAdd( SQLJoin, ' LEFT JOIN Familia ON ( ConsumoVentas.FamiliaArticulo=Familia.Codigo ) ' );
             end;
         end;

       SQLText := SQLSet.GetSQLText;

       SetSQLVar( SQLText, 'Unidades', ObtenExpresionRango( DataMesInicial.Value, DataMesFinal.Value, 'Unidades' ) );
       SetSQLVar( SQLText, 'Importes', ObtenExpresionRango( DataMesInicial.Value, DataMesFinal.Value, 'Importe' ) );
       SetSQLVar( SQLText, 'ImporteDescuentos', ObtenExpresionRango( DataMesInicial.Value, DataMesFinal.Value, 'ImporteDescuentos' ) );
       SetSQLVar( SQLText, 'Campos', SQLFields );
       SetSQLVar( SQLText, 'Tablas', SQLJoin );
       SetSQLVar( SQLText, 'Seleccion', SQLSelect );
       SetSQLVar( SQLText, 'Orden', SQLOrder );

       end;

     Result := SQLText;
end;

begin
     Enabled := false;

     With Report do
       try

         Load;

         // SetSQLExpression( ConstruyeConsulta );

         CreateQueryTable( 'Consulta', ConstruyeConsulta );

         case Seleccion1PageControl.ActivePageIndex of
           0 : begin
               SetValueField( DataClienteInicial );
               SetValueField( DataClienteFinal );
               end;
           1 : begin
               SetValueField( DataGrupoClienteInicial );
               SetValueField( DataGrupoClienteFinal );
               end;
           end;

         SetValueField( DataMesInicial );
         SetValueField( DataMesFinal );
         SetValueField( DataMostrarMargenMedio );

         case Seleccion2PageControl.ActivePageIndex of
           0 : begin
               SetValueField( DataCodigoArticuloInicial );
               SetValueField( DataCodigoArticuloFinal );
               end;
           1 : begin
               SetValueField( DataCodigoFamiliaInicial );
               SetValueField( DataCodigoFamiliaFinal );
               end;
           end;

         SetValue( RsSeleccion + '1', Seleccion1PageControl.ActivePageIndex );
         SetValue( RsSeleccion + '2', Seleccion2PageControl.ActivePageIndex );

         FacturaVentas.FijaDecimalesInforme( Report );

         Start;

       except on E : Exception do Cancel( E );
         end;

end;

procedure TRptCclForm.GrupoClienteCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaGruposCliente( Sender );
end;

procedure TRptCclForm.GrupoClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     GrupoCliente.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptCclForm.ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TRptCclForm.ClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptCclForm.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, True, Sender );
end;

procedure TRptCclForm.CodigoArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptCclForm.CodigoFamiliaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFamilias( Sender );
end;

procedure TRptCclForm.CodigoFamiliaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Familia.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

end.


