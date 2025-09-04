unit l_tva;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask, Menus, cxLookAndFeelPainters, cxButtons, ReportManager, DB,
  dxmdaset, DataManager, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxDBEdit, cxCheckBox, nxdb,

  dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel, cxGroupBox,

  Gim10Fields,
  Gim30Fields;


type
    TRptTvaForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    CodigoTarifaInicialCtrl: TcxDBTextEdit;
    CodigoTarifaFinalCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    CodigoArticuloInicialCtrl: TcxDBTextEdit;
    CodigoArticuloFinalCtrl: TcxDBTextEdit;
    Data: TgxMemData;
    DataArticuloInicial: TWideStringField;
    DataArticuloFinal: TWideStringField;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataTarifaInicial: TWideStringField;
    DataTarifaFinal: TWideStringField;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    DataMostrarIVA: TBooleanField;
    DataIVAIncluido: TBooleanField;
    DataMostrarDescuento: TBooleanField;
    MostrarIVACtrl: TcxDBCheckBox;
    IVAIncluidoCtrl: TcxDBCheckBox;
    MostrarDescuentoCtrl: TcxDBCheckBox;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    Label2: TcxLabel;
    Label5: TcxLabel;
    Label6: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure CodigoTarifaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoTarifaCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure CodigoArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    private

     ReportTarifaTable : TnxeTable;
     ReportTarifaFields : TReportTarifaFields;
     TiposIVAFields : TTiposIVAFields;

    public

    end;

var
  RptTvaForm: TRptTvaForm;

procedure ListadoTarifasVentaArticulo;


implementation

uses   Gdm00Dm,

       dm_fdv,
       dm_cdt,
       dm_art,
       dm_iva,

       cx_cdt,
       cx_art;

{$R *.DFM}

procedure ListadoTarifasVentaArticulo;
begin
     CreateReportForm( TRptTvaForm, RptTvaForm );
end;

procedure TRptTvaForm.initializeForm;
begin
     TiposIVAFields := TTiposIVAFields.Create( Self );

     DataTarifaFinal.Value := HighStrCode;
     DataArticuloFinal.Value := HighStrCode;
end;

procedure TRptTvaForm.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scVentas, False, Sender );
end;

procedure TRptTvaForm.CodigoArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptTvaForm.CodigoTarifaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosTarifa( Sender );
end;

procedure TRptTvaForm.CodigoTarifaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoTarifa.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptTvaForm.FormManagerOkButton;

procedure SeleccionaRegistros;

var  SQLString : String;

begin
     {
     SELECT  TarifaVentas.*,
             CodigoTarifa.Descripcion AS Descripcion,
             Articulo.Descripcion AS DescripcionArticulo,
             Articulo.TipoIVA,
             CAST( 0.0 AS BCD(16,4) ) AS PrecioIVA,
             CAST( 0.0 AS BCD(16,4) ) AS PorcentajeIVA

     FROM 	 TarifaVentas
             LEFT JOIN CodigoTarifa ON ( TarifaVentas.CodigoTarifa=CodigoTarifa.Codigo )
             LEFT JOIN Articulo ON ( TarifaVentas.CodigoArticulo=Articulo.Codigo )

     WHERE 	<Seleccion>

     ORDER BY CodigoTarifa, CodigoArticulo
      }

     SQLString := Report.GetSQLText;
     SetSQLVar( SQLString, 'Seleccion',
                SQLFormat( 'Tipo=0 AND not Articulo.Obsoleto AND ( CodigoTarifa BETWEEN %s AND %s ) AND ( CodigoArticulo BETWEEN %s AND %s )',
                [ DataTarifaInicial, DataTarifaFinal, DataArticuloInicial, DataArticuloFinal ] ) );

     ReportTarifaTable := Report.CreateQueryTable( 'Tarifa', SQLString );
     ReportTarifaFields := TReportTarifaFields.Create( ReportTarifaTable );

     With ReportTarifaTable do
       try
         ApplicationContainer.StartProgression( RecordCount );
         First;
         while not Eof do
           begin
           Edit;
           With ReportTarifaFields do
             begin
             Tasa.TipoIVA( ApplicationContainer.TodayDate, TipoIVA.Value, TiposIVAFields );
             PorcentajeIVA.Value := TiposIVAFields.IVARepercutido.Value;
             PrecioIVA.Value := Precio.Value + ( ( Precio.Value * PorcentajeIVA.Value ) / 100.0 );
             end;
           Post;
           ApplicationContainer.ShowProgression;
           Next;
           end;

       finally
         ApplicationContainer.EndProgression;
         end;
end;


begin
     With Report do
       try
         Load;
         SeleccionaRegistros;

         FacturaVentas.FijaDecimalesInforme( Report );

         SetValue( RsRecargos, BoolToStr( DataModule00.DmEmpresaFields.Ventas_Recargos.Value ) );
         SetValue( RsNombreRecargos, DataModule00.DmEmpresaFields.Ventas_NombreRecargos.Value );

         Start;
       except on E : Exception do Cancel( E );
         end;
end;

end.


