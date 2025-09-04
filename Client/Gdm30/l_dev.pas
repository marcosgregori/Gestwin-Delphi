
unit l_dev;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,

     AppContainer,
     ComCtrls,

     Menus, cxLookAndFeelPainters, cxButtons, ReportManager,
     cxMaskEdit, cxSpinEdit, cxDBEdit, cxControls, cxContainer, cxEdit,
     cxTextEdit, DB, dxmdaset, DataManager,

     Gim30Fields,

     dm_ven, dxSkinsCore, cxGraphics, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox;


type
    TRptDevForm = class(TgxForm)
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    dataPanel: TgxEditPanel;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    gxRangeBox3: TgxRangeBox;
    MesInicialCtrl: TcxDBSpinEdit;
    MesFinalCtrl: TcxDBSpinEdit;
    gxRangeBox1: TgxRangeBox;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataVendedorInicial: TWideStringField;
    DataVendedorFinal: TWideStringField;
    DataMesInicial: TSmallintField;
    DataMesFinal: TSmallintField;
    Label3: TcxLabel;
    Label6: TcxLabel;
    Label2: TcxLabel;
    Label5: TcxLabel;
    Label1: TcxLabel;
    Label4: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure MesCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoInicialCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    private

    public
      ConsumosTable : TnxeTable;
      VendedorDatEconFields : TVendedorDatEconFields;
      AcumuladoVendedorFields : TAcumuladoVendedorFields;
    end;

var
  RptDevForm: TRptDevForm = nil;

procedure ListadoDatosEconomicosVendedores;

implementation

uses   SysUtils,
       DateUtils,
       LibUtils,

       b_msg,

       cx_ven;

{$R *.DFM}

procedure ListadoDatosEconomicosVendedores;
begin
     CreateReportForm( TRptDevForm, RptDevForm );
end;

procedure TRptDevForm.initializeForm;
begin
     DataVendedorFinal.Value := HighStrCode;
     DataMesInicial.Value := 1;
     DataMesFinal.Value := MonthOf( ApplicationContainer.TodayDate );
end;

procedure TRptDevForm.MesCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateMonth( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptDevForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender );
end;

procedure TRptDevForm.CodigoInicialCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Vendedor.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptDevForm.FormManagerOkButton;

procedure SeleccionaRegistros;

var  SQLString : String;

begin

     With Report, ReportManagerDataModule do
       begin

       SQLString := SQLSet.GetSQLText;
       StrAdd( SQLString, SQLFormat( 'VendedorDatEcon.Codigo BETWEEN %s AND %s', [ DataVendedorInicial, DataVendedorFinal ] ) + 'ORDER BY VendedorDatEcon.Codigo' );

       SetSQLVar( SQLString, 'EjercicioActual', IntToStr( ApplicationContainer.Ejercicio ) );

       try

         ConsumosTable := CreateQueryTable( 'Consumos', SQLString );
         VendedorDatEconFields := TVendedorDatEconFields.Create( ConsumosTable );
         AcumuladoVendedorFields := TAcumuladoVendedorFields.Create( ConsumosTable );

         ApplicationContainer.StartProgression( ConsumosTable.RecordCount );

         With ConsumosTable do
           begin
           First;
           while not eof do
             begin
             Edit;
             Vendedor.CalculaAcumulados( VendedorDatEconFields, AcumuladoVendedorFields, DataMesInicial.Value, DataMesFinal.Value );
             With AcumuladoVendedorFields do
               begin
               If   TotalImporteVentas.Value<>0.0
               then begin
                    If   TotalImporteVentas.Value=0.0
                    then Porcentaje.Value := 0.0
                    else Porcentaje.Value := ( TotalImporteComisiones.Value * 100 ) / TotalImporteVentas.Value;
                    end;
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
         SetValueFields( Data );
         Start;
       except on E : Exception do Cancel( E );
         end;
       end;
end;

end.
