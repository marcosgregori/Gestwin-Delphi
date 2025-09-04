unit l_tvf;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask, Menus, cxLookAndFeelPainters, cxButtons, ReportManager, DB,
  dxmdaset, DataManager, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxDBEdit, cxCheckBox, nxdb,

  Gim30Fields, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel, cxGroupBox;


type
    TRptTvfForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    CodigoTarifaInicialCtrl: TcxDBTextEdit;
    CodigoTarifaFinalCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    CodigoFamiliaInicialCtrl: TcxDBTextEdit;
    CodigoFamiliaFinalCtrl: TcxDBTextEdit;
    Data: TgxMemData;
    DataFamiliaInicial: TWideStringField;
    DataFamiliaFinal: TWideStringField;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataTarifaInicial: TWideStringField;
    DataTarifaFinal: TWideStringField;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    DataMostrarIVA: TBooleanField;
    DataIVAIncluido: TBooleanField;
    DataMostrarDescuento: TBooleanField;
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
    procedure CodigoFamiliaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoFamiliaCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    private

     ReportTarifaTable : TnxeTable;
     ReportTarifaFields : TReportTarifaFields;

    public

    end;

var
  RptTvfForm: TRptTvfForm;

procedure ListadoTarifasVentaFamilia;


implementation

uses   dm_fdv,
       dm_cdt,
       dm_fam,
       dm_iva,

       cx_cdt,
       cx_fam;

{$R *.DFM}

procedure ListadoTarifasVentaFamilia;
begin
     CreateReportForm( TRptTvfForm, RptTvfForm );
end;

procedure TRptTvfForm.InitializeForm;
begin
     DataTarifaFinal.Value := HighStrCode;
     DataFamiliaFinal.Value := HighStrCode;
end;

procedure TRptTvfForm.CodigoFamiliaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFamilias( Sender );
end;

procedure TRptTvfForm.CodigoFamiliaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Familia.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptTvfForm.CodigoTarifaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosTarifa( Sender );
end;

procedure TRptTvfForm.CodigoTarifaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoTarifa.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptTvfForm.FormManagerOkButton;

procedure SeleccionaRegistros;

var  SQLString : String;

begin
     {
     SELECT  TarifaVentas.*, 
             CodigoTarifa.Descripcion AS Descripcion,
             Familia.Descripcion AS DescripcionFamilia

     FROM    Familia
             LEFT JOIN TarifaVentas ON ( TarifaVentas.CodigoArticulo=Familia.Codigo )
             LEFT JOIN CodigoTarifa ON ( TarifaVentas.CodigoTarifa=CodigoTarifa.Codigo )
             LEFT JOIN Familia ON ( TarifaVentas.CodigoArticulo=Familia.Codigo )

     WHERE 	<Seleccion>

     ORDER BY CodigoTarifa, CodigoArticulo
      }

     SQLString := Report.GetSQLText;
     SetSQLVar( SQLString, 'Seleccion',
                SQLFormat( 'Tipo=2 AND ( CodigoTarifa BETWEEN %s AND %s ) AND ( CodigoArticulo BETWEEN %s AND %s )',
                [ DataTarifaInicial, DataTarifaFinal, DataFamiliaInicial, DataFamiliaFinal ] ) );

     ReportTarifaTable := Report.CreateQueryTable( 'Tarifa', SQLString );
     ReportTarifaFields := TReportTarifaFields.Create( ReportTarifaTable );

end;

begin
     With Report do
       try
         Load;
         SeleccionaRegistros;
         FacturaVentas.FijaDecimalesInforme( Report );
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

end.


