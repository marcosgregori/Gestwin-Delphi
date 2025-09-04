
unit l_dep;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,

     LibUtils,
     AppContainer,
     DataManager,

     Gim30Fields,

     ComCtrls,

     DB,
     nxDB,

     ReportManager, Menus, cxLookAndFeelPainters, cxButtons, cxPC,
     cxControls, dxmdaset, cxDBEdit, cxContainer, cxEdit, cxTextEdit,
     cxMaskEdit, cxSpinEdit,

     dm_rpr, cxGraphics, cxDropDownEdit, cxIndexedComboBox, dxSkinsCore,
  dxSkinscxPCPainter, cxLookAndFeels, dxSkinsDefaultPainters, cxLabel,
  cxGroupBox, cxPCdxBarPopupMenu, dxBarBuiltInMenu;


type
    TRptDepForm = class(TgxForm)
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    DataPanel: TgxEditPanel;
    MesInicialCtrl: TcxDBSpinEdit;
    MesFinalCtrl: TcxDBSpinEdit;
    SeleccionPageControl: TcxPageControl;
    ProveedorTabSheet: TcxTabSheet;
    ProveedorInicialCtrl: TcxDBTextEdit;
    ProveedorFinalCtrl: TcxDBTextEdit;
    grupoProveedorTabSheet: TcxTabSheet;
    GrupoProveedorInicialCtrl: TcxDBTextEdit;
    GrupoProveedorFinalCtrl: TcxDBTextEdit;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataProveedorInicial: TWideStringField;
    DataProveedorFinal: TWideStringField;
    DataGrupoProveedorInicial: TWideStringField;
    DataGrupoProveedorFinal: TWideStringField;
    DataMesInicial: TSmallintField;
    DataMesFinal: TSmallintField;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    gxRangeBox3: TgxRangeBox;
    Label6: TcxLabel;
    Label2: TcxLabel;
    Label5: TcxLabel;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    Label9: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
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
    procedure GrupoProveedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GrupoProveedorCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure MesCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private
      ConsumosTable : TnxeTable;
      ProveedorDatEconFields : TProveedorDatEconFields;
      AcumuladoProveedorFields : TAcumuladoProveedorFields;
    public

      Porcentaje           : Decimal;
    end;

var
  RptDepForm: TRptDepForm = nil;

procedure ListadoDatosEconomicosProveedores;

implementation

uses   DateUtils,
       SysUtils,

       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,

       b_msg,

       dm_pro,
       dm_gdp,

       cx_pro,
       cx_gdp;

{$R *.DFM}

procedure ListadoDatosEconomicosProveedores;
begin
     CreateReportForm( TRptDepForm, RptDepForm );
end;

procedure TRptDepForm.InitializeForm;
begin
     DataProveedorFinal.Value := HighStrCode;
     DataGrupoProveedorFinal.Value := HighStrCode;

     DataMesInicial.Value := 1;
     DataMesFinal.Value := MonthOf( ApplicationContainer.TodayDate );

     GrupoProveedorTabSheet.TabVisible := DataModule00.DmEmpresaFields.Proveedor_Grupos.Value;
end;

procedure TRptDepForm.ProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TRptDepForm.ProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptDepForm.FormManagerOkButton;

procedure SeleccionaRegistros;

var  SQLString : String;

begin

     With Report, ReportManagerDataModule do
       begin

       SQLString := SQLSet.GetSQLText;

       case SeleccionPageControl.ActivePageIndex of
         0 : StrAdd( SQLString, SQLFormat( 'ProveedorDatEcon.Codigo BETWEEN %s AND %s', [ DataProveedorInicial, DataProveedorFinal ] ) + 'ORDER BY ProveedorDatEcon.Codigo' );
         1 : StrAdd( SQLString, SQLFormat( 'Proveedor.Factura_CodigoGrupo BETWEEN %s AND %s', [ DataGrupoProveedorInicial, DataGrupoProveedorFinal ] ) + 'ORDER BY Proveedor.Factura_CodigoGrupo, Proveedor.Codigo' );
         end;

       SetSQLVar( SQLString, 'EjercicioActual', IntToStr( ApplicationContainer.Ejercicio ) );

       try

         ConsumosTable := CreateQueryTable( 'Consumos', SQLString );
         ProveedorDatEconFields := TProveedorDatEconFields.Create( ConsumosTable );
         AcumuladoProveedorFields := TAcumuladoProveedorFields.Create( ConsumosTable );

         ApplicationContainer.StartProgression( ConsumosTable.RecordCount );

         With ConsumosTable do
           begin

           First;
           while not Eof do
             begin

             Edit;

             RelacionesProveedor.CalculaAcumulados( ProveedorDatEconFields, AcumuladoProveedorFields, DataMesInicial.Value, DataMesFinal.Value );

             With AcumuladoProveedorFields do
               begin

               If   TotalImporteCompras.Value<>0.0
               then If   TotalImporteCompras.Value=0.0
                    then DescuentosSobreCompras.Value := 0.0
                    else DescuentosSobreCompras.Value := ( TotalImporteDescuentos.Value * 100 ) / TotalImporteCompras.Value;

               end;

             Post;

             ApplicationContainer.ShowProgression;

             Next;
             end;

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
         SeleccionaRegistros;
         SetValue( RsSeleccion, SeleccionPageControl.ActivePageIndex );
         SetValueFields( Data );
         Start;
       except on E : Exception do Cancel( E );
         end;

       end;

end;

procedure TRptDepForm.MesCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateMonth( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptDepForm.GrupoProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaGruposProveedores( Sender );
end;

procedure TRptDepForm.GrupoProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     GrupoProveedor.Valida( Sender, DisplayValue, ErrorText, Error, True ); 
end;

end.
