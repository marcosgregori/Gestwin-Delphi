
unit l_dec;

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

     dm_rcl, cxGroupBox, cxRadioGroup, cxGraphics, cxDropDownEdit,
  cxIndexedComboBox, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxLookAndFeels, cxLabel, cxPCdxBarPopupMenu, dxBarBuiltInMenu;


type
    TRptDecForm = class(TgxForm)
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    DataPanel: TgxEditPanel;
    MesInicialCtrl: TcxDBSpinEdit;
    MesFinalCtrl: TcxDBSpinEdit;
    seleccionPageControl: TcxPageControl;
    clienteTabSheet: TcxTabSheet;
    ClienteInicialCtrl: TcxDBTextEdit;
    ClienteFinalCtrl: TcxDBTextEdit;
    GrupoClienteTabSheet: TcxTabSheet;
    GrupoClienteInicialCtrl: TcxDBTextEdit;
    GrupoClienteFinalCtrl: TcxDBTextEdit;
    vendedorTabSheet: TcxTabSheet;
    VendedorInicialCtrl: TcxDBTextEdit;
    VendedorFinalCtrl: TcxDBTextEdit;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataClienteInicial: TWideStringField;
    DataClienteFinal: TWideStringField;
    DataGrupoClienteInicial: TWideStringField;
    DataGrupoClienteFinal: TWideStringField;
    DataVendedorInicial: TWideStringField;
    DataVendedorFinal: TWideStringField;
    DataMesInicial: TSmallintField;
    DataMesFinal: TSmallintField;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    gxRangeBox3: TgxRangeBox;
    gxRangeBox4: TgxRangeBox;
    cxDBIndexedComboBox1: TcxDBIndexedComboBox;
    DataCalculoMargen: TSmallintField;
    Label6: TcxLabel;
    Label2: TcxLabel;
    Label5: TcxLabel;
    Label13: TcxLabel;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    Label9: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    Label11: TcxLabel;
    Label10: TcxLabel;
    Label12: TcxLabel;
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
    procedure GrupoClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GrupoClienteCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure VendedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure VendedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure MesCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private
      ConsumosTable : TnxeTable;
      ClienteDatEconFields : TClienteDatEconFields;
      AcumuladoClienteFields : TAcumuladoClienteFields;
    public

      MargenMedio,
      porcentaje           : Decimal;
    end;

var
  RptDecForm: TRptDecForm = nil;

procedure ListadoDatosEconomicosClientes;

implementation

uses   DateUtils,
       SysUtils,

       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm10Dm,
       Gim00Fields,

       b_msg,

       dm_cli,
       dm_gdc,
       dm_ven,

       cx_cli,
       cx_gdc,
       cx_ven;

{$R *.DFM}

procedure ListadoDatosEconomicosClientes;
begin
     CreateReportForm( TRptDecForm, RptDecForm );
end;

procedure TRptDecForm.InitializeForm;
begin
     DataClienteFinal.Value := HighStrCode;
     DataGrupoClienteFinal.Value := HighStrCode;
     DataVendedorFinal.Value := HighStrCode;
     DataMesInicial.Value := 1;
     DataMesFinal.Value := MonthOf( ApplicationContainer.TodayDate );
     DataCalculoMargen.Value := 0;
     GrupoClienteTabSheet.TabVisible := DataModule00.DmEmpresaFields.Cliente_GruposFac.Value;
     VendedorTabSheet.TabVisible := DataModule00.DmEmpresaFields.Vendedor_ComPorCli.Value;
end;

procedure TRptDecForm.ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TRptDecForm.ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptDecForm.FormManagerOkButton;

procedure SeleccionaRegistros;

var  SQLString : String;

begin

     With Report, ReportManagerDataModule do
       begin

       SQLString := SQLSet.GetSQLText;

       case SeleccionPageControl.ActivePageIndex of
         0 : StrAdd( SQLString, SQLFormat( 'ClienteDatEcon.Codigo BETWEEN %s AND %s', [ DataClienteInicial, DataClienteFinal ] ) + 'ORDER BY ClienteDatEcon.Codigo' );
         1 : StrAdd( SQLString, SQLFormat( 'Cliente.Factura_Agrupacion BETWEEN %s AND %s', [ DataGrupoClienteInicial, DataGrupoClienteFinal ] ) + 'ORDER BY Cliente.Factura_Agrupacion' );
         2 : StrAdd( SQLString, SQLFormat( 'Cliente.Vendedor BETWEEN %s AND %s', [ DataVendedorInicial, DataVendedorFinal ] ) + 'ORDER BY Cliente.Vendedor' );
         end;

       SetSQLVar( SQLString, 'EjercicioActual', IntToStr( ApplicationContainer.Ejercicio ) );

       try

         ConsumosTable := CreateQueryTable( 'Consumos', SQLString );
         ClienteDatEconFields := TClienteDatEconFields.Create( ConsumosTable );
         AcumuladoClienteFields := TAcumuladoClienteFields.Create( ConsumosTable );

         ApplicationContainer.StartProgression( ConsumosTable.RecordCount );

         With ConsumosTable do
           try

             First;
             while not eof do
               begin

               Edit;

               RelacionesCliente.CalculaAcumulados( ClienteDatEconFields, AcumuladoClienteFields, DataMesInicial.Value, DataMesFinal.Value );

               With AcumuladoClienteFields do
                 begin

                 If   TotalImporteVentas.Value<>0.0
                 then begin

                      If   TotalImporteVentas.Value=0.0
                      then DescuentosSobreVentas.Value := 0.0
                      else DescuentosSobreVentas.Value := ( totalImporteDescuentos.Value * 100 ) / TotalImporteVentas.Value;


                      case DataCalculoMargen.Value of
                        0 : If   TotalImporteVentas.Value=0.0
                            then MargenMedio.Value := 0.0
                            else MargenMedio.Value := ( 100 * ( TotalImporteVentas.Value - TotalImporteCoste.Value ) ) / TotalImporteVentas.Value;
                        1 : If   TotalImporteCoste.Value=0.0
                            then MargenMedio.Value := 0.0
                            else MargenMedio.Value := ( 100 * ( TotalImporteVentas.Value - TotalImporteCoste.Value ) ) / TotalImporteCoste.Value;
                            end;

                      end;

                 end;

               Post;

               ApplicationContainer.ShowProgression;
               Next;
               end;

           finally
             end;

       finally
         ApplicationContainer.EndProgression;
         end;
     end;
end;

begin
     With report do
       begin
       try
         Load;
         SeleccionaRegistros;
         SetValue( RsSeleccion, SeleccionPageControl.ActivePageIndex );
         Start;
       except on E : Exception do Cancel( E );
         end;

       end;

end;

procedure TRptDecForm.MesCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateMonth( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptDecForm.VendedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender );
end;

procedure TRptDecForm.VendedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Vendedor.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptDecForm.GrupoClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaGruposCliente( Sender );
end;

procedure TRptDecForm.GrupoClienteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     GrupoCliente.Valida( Sender, DisplayValue, ErrorText, Error, True ); 
end;

end.
