
unit l_cap;

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

     dm_pro, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxGraphics, cxLookAndFeels, cxLabel, cxGroupBox, cxPCdxBarPopupMenu,
  dxBarBuiltInMenu, dxUIAClasses;


type
    TRptCapForm = class(TgxForm)
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    DataPanel: TgxEditPanel;
    Data: TgxMemData;
    DataProveedorInicial: TWideStringField;
    DataProveedorFinal: TWideStringField;
    DataMesInicial: TSmallIntField;
    DataMesFinal: TSmallIntField;
    DataCodigoArticuloInicial: TWideStringField;
    DataCodigoArticuloFinal: TWideStringField;
    DataCodigoFamiliaInicial: TWideStringField;
    DataCodigoFamiliaFinal: TWideStringField;
    DataSource: TDataSource;
    DataGrupoProveedorInicial: TWideStringField;
    DataGrupoProveedorFinal: TWideStringField;
    DataMostrarCoste: TBooleanField;
    ArticulosPanel: TcxGroupBox;
    seleccion2PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    gxRangeBox2: TgxRangeBox;
    CodigoArticuloInicialCtrl: TcxDBTextEdit;
    CodigoArticuloFinalCtrl: TcxDBTextEdit;
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
    ProveedoresPanel: TcxGroupBox;
    seleccion1PageControl: TcxPageControl;
    TabSheet3: TcxTabSheet;
    gxRangeBox1: TgxRangeBox;
    ProveedorInicialCtrl: TcxDBTextEdit;
    ProveedorFinalCtrl: TcxDBTextEdit;
    Label3: TcxLabel;
    Label16: TcxLabel;
    Label17: TcxLabel;
    GrupoProveedorTabSheet: TcxTabSheet;
    gxRangeBox3: TgxRangeBox;
    GrupoProveedorInicialCtrl: TcxDBTextEdit;
    GrupoProveedorFinalCtrl: TcxDBTextEdit;
    Label12: TcxLabel;
    Label19: TcxLabel;
    Label20: TcxLabel;
    Label14: TcxLabel;
    MesesPanel: TcxGroupBox;
    gxRangeBox5: TgxRangeBox;
    MesInicialCtrl: TcxDBSpinEdit;
    MesFinalCtrl: TcxDBSpinEdit;
    Label6: TcxLabel;
    Label2: TcxLabel;
    Label5: TcxLabel;
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
    procedure MesCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure GrupoProveedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GrupoProveedorCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure CodigoFamiliaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoFamiliaCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    private

    protected
    class var
      AgrupadoPorArticulo : Boolean;
    public

      ReportConsumosTable : TnxeTable;
      ReportConsumosFields : TReportConsumosFields;

      SumaImporte,
      SumaUnidades,
      PrecioMedio : Decimal;

    end;

var  RptCapForm: TRptCapForm = nil;

procedure ListadoConsumoProveedores( AgrupadoPorArticulo : Boolean = False );

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
       dm_gdp,
       dm_fdc,

       cx_pro,
       cx_gdp,
       cx_art,
       cx_fam;

{$R *.DFM}

resourceString
     RsMsg1 = 'Listado de consumos a proveedores';

procedure ListadoConsumoProveedores( AgrupadoPorArticulo : Boolean = False );
begin
     TRptCapForm.AgrupadoPorArticulo := AgrupadoPorArticulo;
     CreateReportForm( TRptCapForm, RptCapForm );
end;

procedure TRptCapForm.InitializeForm;
begin

     If   AgrupadoPorArticulo
     then begin
          Caption := RsMsg1;
          Report.FileName := 'dm30\l_cap2';
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

     GrupoProveedorTabSheet.Visible := DataModule00.DmEmpresaFields.Proveedor_Grupos.Value;

     DataProveedorFinal.Value := HighStrCode;
     DataGrupoProveedorFinal.Value := HighStrCode;
     DataMesInicial.Value := 1;
     DataMesFinal.Value := MonthOf( ApplicationContainer.TodayDate );
     DataCodigoArticuloFinal.Value := HighStrCode;
     DataCodigoFamiliaFinal.Value := HighStrCode;
end;

procedure TRptCapForm.MesCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateMonth( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptCapForm.FormManagerOkButton;

function ConstruyeConsulta : String;

var  SQLFields,
     SQLSelect,
     SQLOrder,
     SQLJoin,
     SQLText : String;
     TipoRegistro : SmallInt;

begin

     {
     SELECT ConsumoCompras.Ejercicio,
            ConsumoCompras.Proveedor,
            Proveedor.Nombre,
            ConsumoCompras.FamiliaArticulo,
            ConsumoCompras.CodigoClaseA,
            ConsumoCompras.CodigoClaseB,
            ConsumoCompras.CodigoClaseC,
            <Unidades> AS Unidades,
            <Importes> AS Importe
            <Descuentos> AS Descuentos
            <Campos>

     FROM   ConsumoCompras
            LEFT JOIN Proveedor ON ( ConsumoCompras.Proveedor=Proveedor.Codigo )
            <Tablas>

     WHERE  <Seleccion>

     ORDER BY Proveedor, FamiliaArticulo, Ejercicio
     }

     With Report, ReportManagerDataModule do
       begin

       If   Seleccion2PageControl.ActivePageIndex=0
       then TipoRegistro := 2
       else TipoRegistro := 1;

       SQLFields := '';
       SQLJoin := '';

       If   AgrupadoPorArticulo
       then SQLOrder := 'FamiliaArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, Proveedor, Ejercicio'
       else SQLOrder := 'Proveedor, FamiliaArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, Ejercicio';

       SQLSelect := SQLVarsFormat( ' Tipo=? AND Ejercicio BETWEEN ? AND ? ',
                                   [ TipoRegistro,
                                     ApplicationContainer.Ejercicio - 1,
                                     ApplicationContainer.Ejercicio ] );

       If   Seleccion2PageControl.ActivePageIndex=0
       then StrAdd( SQLSelect, ' AND NOT Articulo.Obsoleto ' );
       
       StrAdd( SQLSelect, ' AND ' + ObtenExpresionRango( DataMesInicial.Value, DataMesFinal.Value, 'Unidades' ) + ' <>0.0 ');

       case Seleccion1PageControl.ActivePageIndex of
         0 : begin
             StrAdd( SQLFields, ', '' '' AS CodigoGrupo, '' '' AS NombreGrupo ' );
             StrAdd( SQLSelect, SQLFieldsFormat( 'AND ConsumoCompras.Proveedor BETWEEN ? AND ?', [ DataProveedorInicial, DataProveedorFinal ] ) );
             end;
         1 : begin
             StrAdd( SQLFields, ', GrupoProveedor.Codigo AS CodigoGrupo, GrupoProveedor.Descripcion AS DescripcionGrupo ' );
             StrAdd( SQLSelect, SQLFieldsFormat( 'AND Proveedor.Factura_CodigoGrupo BETWEEN ? AND ?', [ DataGrupoProveedorInicial, DataGrupoProveedorFinal ] ) );
             SQLJoin := ' LEFT JOIN GrupoProveedor ON ( Proveedor.Factura_CodigoGrupo=GrupoProveedor.Codigo ) ';
             If   AgrupadoPorArticulo
             then SQLOrder := 'FamiliaArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, GrupoProveedor.Codigo, Proveedor, Ejercicio'
             else SQLOrder := 'GrupoProveedor.Codigo, Proveedor, FamiliaArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, Ejercicio';
             end;

         end;

       case Seleccion2PageControl.ActivePageIndex of
         0 : begin
             StrAdd( SQLFields, ', Articulo.Descripcion ' );
             StrAdd( SQLSelect, SQLFieldsFormat( 'AND ConsumoCompras.FamiliaArticulo BETWEEN ? AND ?', [ DataCodigoArticuloInicial, DataCodigoArticuloFinal ] ) );
             StrAdd( SQLJoin, ' LEFT JOIN Articulo ON ( ConsumoCompras.FamiliaArticulo=Articulo.Codigo ) ' );
             end;
         1 : begin
             StrAdd( SQLFields, ', Familia.Descripcion ' );
             StrAdd( SQLSelect, SQLFieldsFormat( 'AND ConsumoCompras.FamiliaArticulo BETWEEN ? AND ?', [ DataCodigoFamiliaInicial, DataCodigoFamiliaFinal ] ) );
             StrAdd( SQLJoin, ' LEFT JOIN Familia ON ( ConsumoCompras.FamiliaArticulo=Familia.Codigo ) ' );
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
     With Report do
       begin
       try

         Load;


         SetSQLExpression( ConstruyeConsulta );

         case Seleccion1PageControl.ActivePageIndex of
           0 : begin
               SetValueField( DataProveedorInicial );
               SetValueField( DataProveedorFinal );
               end;
           1 : begin
               SetValueField( DataGrupoProveedorInicial );
               SetValueField( DataGrupoProveedorFinal );
               end;
           end;

         SetValueField( DataMesInicial );
         SetValueField( DataMesFinal );
         SetValueField( DataMostrarCoste );

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

         SetValue( rsSeleccion + '1', Seleccion1PageControl.ActivePageIndex );
         SetValue( rsSeleccion + '2', Seleccion2PageControl.ActivePageIndex );

         FacturaCompras.FijaDecimalesInforme( Report );

         Start;

       except on E : Exception do Cancel( E );
         end;

       end;

end;

procedure TRptCapForm.GrupoProveedorCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaGruposProveedores( Sender );
end;

procedure TRptCapForm.GrupoProveedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     GrupoProveedor.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptCapForm.ProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TRptCapForm.ProveedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptCapForm.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, True, Sender );
end;

procedure TRptCapForm.CodigoArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptCapForm.CodigoFamiliaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFamilias( Sender );
end;

procedure TRptCapForm.CodigoFamiliaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Familia.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

end.
