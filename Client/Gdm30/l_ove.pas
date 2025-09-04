
unit l_ove;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,

     LibUtils,
     AppContainer,
     ComCtrls,

     Menus, cxLookAndFeelPainters, cxButtons,

     ReportManager, DB, nxdb,DataManager, cxCurrencyEdit,
     cxDBEdit, cxMaskEdit, cxSpinEdit, cxControls, cxContainer, cxEdit,
     cxTextEdit, dxmdaset,

     cxPC,

     dm_rcl,

     Gim10Fields,
     Gim30Fields, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxGraphics, cxLookAndFeels, cxLabel, cxGroupBox, cxPCdxBarPopupMenu,
  dxBarBuiltInMenu;


type
    TRptOveForm = class(TgxForm)
    FormManager: TgxFormManager;
    ClienteDatEcon1Table: TnxeTable;
    Report: TgxReportManager;
   DataPanel: TgxEditPanel;
    MesInicialCtrl: TcxDBSpinEdit;
    MesFinalCtrl: TcxDBSpinEdit;
    ImporteMinimoCtrl: TcxDBCurrencyEdit;
    ImporteMaximoCtrl: TcxDBCurrencyEdit;
    MostrarCtrl: TcxDBSpinEdit;
    gxRangeBox2: TgxRangeBox;
   Data: TgxMemData;
   DataSource: TDataSource;
   DataClienteInicial: TWideStringField;
   DataClienteFinal: TWideStringField;
   DataGrupoClienteInicial: TWideStringField;
   DataGrupoClienteFinal: TWideStringField;
   DataMesInicial: TSmallintField;
   DataMesFinal: TSmallintField;
   DataImporteMinimo: TBCDField;
   DataImporteMaximo: TBCDField;
   DataMostrar: TIntegerField;
    PageControl: TcxPageControl;
    TabSheet3: TcxTabSheet;
    gxRangeBox1: TgxRangeBox;
    ClienteInicialCtrl: TcxDBTextEdit;
    ClienteFinalCtrl: TcxDBTextEdit;
    GrupoClienteTabSheet: TcxTabSheet;
    gxRangeBox3: TgxRangeBox;
    GrupoClienteInicialCtrl: TcxDBTextEdit;
    GrupoClienteFinalCtrl: TcxDBTextEdit;
    ClienteTable: TnxeTable;
    Label6: TcxLabel;
    Label2: TcxLabel;
    Label5: TcxLabel;
    Label1: TcxLabel;
    Label8: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label14: TcxLabel;
    Label3: TcxLabel;
    Label16: TcxLabel;
    Label17: TcxLabel;
    Label12: TcxLabel;
    Label19: TcxLabel;
    Label20: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    ClienteDatEcon2Table: TnxeTable;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure MesCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GrupoClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GrupoClienteCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    private

    public

      ClienteFields : TClienteFields;

      ClienteDatEcon1Fields,
      ClienteDatEcon2Fields  : TClienteDatEconFields;

      ReportConsumosTable : TnxeTable;
      ReportConsumosFields : TReportConsumosFields;

      AcumCliente1,
      AcumCliente2 : TAcumuladoCliente;

      ImporteTotal : Decimal;

    end;

var
  RptOveForm: TRptOveForm = nil;

procedure ListadoABCClientes;

implementation

uses   SysUtils,
       DateUtils,

       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm30Dm,

       dm_cli,
       dm_gdc,

       b_msg,

       cx_cli,
       cx_gdc;

{$R *.DFM}

procedure ListadoABCClientes;
begin
     CreateReportForm( TRptOveForm, RptOveForm );
end;

procedure TRptOveForm.initializeForm;
begin

     ClienteFields := TClienteFields.Create( ClienteTable );
     ClienteDatEcon1Fields := TClienteDatEconFields.Create( ClienteDatEcon1Table );
     ClienteDatEcon2Fields := TClienteDatEconFields.Create( ClienteDatEcon2Table );

     GrupoClienteTabSheet.Visible := DataModule00.DmEmpresaFields.Cliente_GruposFac.Value;
     SetEditControlsDecimals( [ ImporteMinimoCtrl, ImporteMaximoCtrl ] );

     DataClienteFinal.Value := HighStrCode;
     DataGrupoClienteFinal.Value := HighStrCode;
     DataMesInicial.Value := 1;
     DataMesFinal.Value := MonthOf( ApplicationContainer.TodayDate );
     DataImporteMaximo.Value := 9999999.99;
     DataMostrar.Value := 99999;
end;

procedure TRptOveForm.MesCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateMonth( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptOveForm.ClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptOveForm.FormManagerOkButton;

procedure SeleccionaDatosEconomicos( CodigoCliente : String );

var   TotalNetoVentas  : Decimal;

begin

     FillChar( AcumCliente1, SizeOf( AcumCliente1 ),#0 );
     FillChar( AcumCliente2, SizeOf( AcumCliente2 ),#0 );

     With ClienteDatEcon1Table do
       begin

       SetRange( [ ApplicationContainer.Ejercicio, CodigoCliente ], [ ApplicationContainer.Ejercicio, CodigoCliente ] );

       First;
       while not Eof do
         begin

         With ClienteDatEcon1Fields do
           begin

           RelacionesCliente.CalculaAcumulados( ClienteDatEcon1Fields, AcumCliente1, DataMesInicial.Value, DataMesFinal.Value );

           TotalNetoVentas := AcumCliente1.TotalImporteVentas - AcumCliente1.TotalImporteDescuentos;

           If   ( TotalNetoVentas>=DataImporteMinimo.Value ) and
                ( TotalNetoVentas<=DataImporteMaximo.Value )
           then begin

                ReportConsumosTable.Append;

                DecAdd( ImporteTotal, TotalNetoVentas );

                ReportConsumosFields.ID.Value := Codigo.Value;
                ReportConsumosFields.CodigoPropietario.Value := Codigo.Value;
                ReportConsumosFields.Nombre.Value := Cliente.Descripcion( Codigo.Value, True );
                ReportConsumosFields.Importe1.Value := TotalNetoVentas;

                If   PageControl.ActivePageIndex=1
                then begin
                     ReportConsumosFields.CodigoGrupo.Value := ClienteFields.Factura_Agrupacion.Value;
                     If   ClienteFields.Factura_Agrupacion.Value<>''
                     then ReportConsumosFields.DescripcionGrupo.Value := GrupoCliente.Descripcion( ClienteFields.Factura_Agrupacion.Value, True );
                     end;

                // Datos del ejercicio anterior

                If   ClienteDatEcon2Table.FindKey( [ ApplicationContainer.Ejercicio - 1, CodigoCliente ] )
                then begin

                     RelacionesCliente.CalculaAcumulados( ClienteDatEcon2Fields, AcumCliente2, DataMesInicial.Value, DataMesFinal.Value );
                     TotalNetoVentas := AcumCliente2.TotalImporteVentas - AcumCliente2.TotalImporteDescuentos;
                     ReportConsumosFields.Importe2.Value := TotalNetoVentas;
                     end;

                ReportConsumosTable.Post;
                end;

           end;

         ApplicationContainer.ShowProgression;

         Next;
         end;

       end;
end;

procedure SeleccionaRegistros;
begin
       try

         ImporteTotal := 0.0;

         With ClienteTable do
           begin

           case PageControl.ActivePageIndex of
             0 : begin
                 IndexFieldNames := 'Codigo';
                 SetRange( [ dataClienteInicial.value ], [ dataClienteFinal.value ] );
                 end;
             1 : begin
                 IndexFieldNames := 'Factura_Agrupacion;Codigo';
                 SetRange( [ DataGrupoClienteInicial.value, '' ], [ DataGrupoClienteFinal.value,   HighStrCode ] );
                 end;
             end;

           ApplicationContainer.StartProgression( RecordCount );

           First;
           While not Eof do
             begin
             SeleccionaDatosEconomicos( ClienteFields.Codigo.Value );
             Next;
             end;

           end;

       finally
         ApplicationContainer.EndProgression;
         end;

end;

begin
     Enabled := False;

     With Report do
       begin
       try
         Load;

         ReportConsumosTable := CreateEmptyTable( 'Consulta',DataModule30.GetSQL( 'Consumos' ) );
         ReportConsumosFields := TReportConsumosFields.Create( ReportConsumosTable );
         ReportConsumosTable.IndexName := 'Index1'; // Importe1

         SeleccionaRegistros;

         SetValue( RsSeleccion, PageControl.ActivePageIndex );
         SetValue( RsImporteTotal, ImporteTotal );
         Start;
       except on E : Exception do Cancel( E );
         end;

       end;

end;

procedure TRptOveForm.GrupoClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaGruposCliente( Sender );
end;

procedure TRptOveForm.GrupoClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     GrupoCliente.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptOveForm.ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

end.

