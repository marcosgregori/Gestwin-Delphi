
unit l_uba;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask, Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, DB, dxmdaset, DataManager,
  ReportManager,

  Gim30Fields, dxSkinsCore, cxGraphics, cxLookAndFeels, dxSkinsDefaultPainters,
  cxLabel, cxGroupBox, dxSkinscxPCPainter, cxPCdxBarPopupMenu, cxPC, cxMaskEdit,
  cxDropDownEdit, cxIndexedComboBox, dxBarBuiltInMenu;


type
    TRptUbaForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    gxRangeBox1: TgxRangeBox;
    Report: TgxReportManager;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataArticuloInicial: TWideStringField;
    DataArticuloFinal: TWideStringField;
    DataAlmacenInicial: TWideStringField;
    DataAlmacenFinal: TWideStringField;
    Label1: TcxLabel;
    Label4: TcxLabel;
    Label7: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxLabel1: TcxLabel;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    TabSheet2: TcxTabSheet;
    gxRangeBox4: TgxRangeBox;
    UbicacionInicialCtrl: TcxDBTextEdit;
    UbicacionFinalCtrl: TcxDBTextEdit;
    cxLabel4: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    gxRangeBox2: TgxRangeBox;
    AlmacenInicialCtrl: TcxDBTextEdit;
    AlmacenFinalCtrl: TcxDBTextEdit;
    Label3: TcxLabel;
    Label2: TcxLabel;
    Label5: TcxLabel;
    cxLabel2: TcxLabel;
    AlmacenCtrl: TcxDBTextEdit;
    cxLabel3: TcxLabel;
    cxLabel5: TcxLabel;
    ExistenciasCtrl: TcxDBIndexedComboBox;
    DataAlmacen: TWideStringField;
    DataUbicacionInicial: TWideStringField;
    DataUbicacionFinal: TWideStringField;
    DataExistencias: TSmallintField;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure AlmacenCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure AlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure UbicacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure UbicacionCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    private

    public

    end;

var
  RptUbaForm: TRptUbaForm;

procedure ListadoUbicacion;


implementation

uses   LibUtils,

       Gim00Fields,

       dm_art,
       dm_alm,
       dm_ubi,

       cx_art,
       cx_alm,
       cx_ubi;

{$R *.DFM}

procedure ListadoUbicacion;
begin
     CreateReportForm( TRptUbaForm, RptUbaForm );
end;

procedure TRptUbaForm.InitializeForm;
begin
     DataArticuloFinal.Value := HighStrCode;
     DataAlmacenFinal.Value := HighStrCode;
     DataUbicacionFinal.Value := HighStrCode;
end;

procedure TRptUbaForm.UbicacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaUbicaciones( DataAlmacen.Value, ubTodas, Sender );
end;

procedure TRptUbaForm.UbicacionCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Ubicacion.Valida( DataAlmacen.Value, True, Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptUbaForm.CodigoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptUbaForm.FormManagerOkButton;
function ConstruyeConsulta : String;

var  SQLSelect,
     SQLSelectStock,
     SQLText : String;

begin

     {
     SELECT *
     FROM ( SELECT
           CodigoArticulo,
           CodigoClaseA,
           CodigoClaseB,
           CodigoClaseC,
           CodigoAlmacen,
           Ubicacion,
           LoteFabricacion,
           FechaUltEntrada,
           FechaUltSalida,
           ( Apertura_Entradas + Enero_Entradas + Febrero_Entradas + Marzo_Entradas + Abril_Entradas + Mayo_Entradas + Junio_Entradas + Julio_Entradas + Agosto_Entradas + Septiembre_Entradas + Octubre_Entradas + Noviembre_Entradas +Diciembre_Entradas ) AS SumaEntradas,
           ( Apertura_Salidas + Enero_Salidas + Febrero_Salidas + Marzo_Salidas + Abril_Salidas + Mayo_Salidas + Junio_Salidas + Julio_Salidas + Agosto_Salidas + Septiembre_Salidas + Octubre_Salidas + Noviembre_Salidas + Diciembre_Salidas ) AS SumaSalidas

           FROM   Stock
           WHERE  <Seleccion> ) AS Stock

     <SeleccionExistencias>

     ORDER BY CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, CodigoAlmacen, Ubicacion

     }

     With Report, ReportManagerDataModule do
       begin

       SQLSelect := SQLVarsFormat( ' Ejercicio=? AND ( CodigoArticulo BETWEEN ? AND ? ) AND ',
                                   [ ApplicationContainer.Ejercicio,
                                     DataArticuloInicial.Value,
                                     DataArticuloFinal.Value ] );

       case PageControl.ActivePageIndex of
         0 : StrAdd( SQLSelect, SQLFieldsFormat( '( CodigoAlmacen BETWEEN ? AND ? )', [ DataAlmacenInicial, DataAlmacenFinal ] ) );
         1 : StrAdd( SQLSelect, SQLFieldsFormat( ' CodigoAlmacen=? AND Ubicacion BETWEEN ? AND ?', [ DataAlmacen, DataUbicacionInicial, DataUbicacionFinal ] ) );
         end;

       case DataExistencias.Value of
        0 : SQLSelectStock := ' WHERE ( SumaEntradas - SumaSalidas )>0.0 ';
        1 : SQLSelectStock := ' WHERE ( SumaEntradas - SumaSalidas )<0.0 ';
        2 : SQLSelectStock := '';
        end;

       SQLText := SQLSet.GetSQLText;

      SetSQLVar( SQLText, 'Seleccion', SQLSelect );
      SetSQLVar( SQLText, 'SeleccionExistencias', SQLSelectStock );

      end;

     Result := SQLText;

end;

begin
     With Report do
       try
         Load;

         SetSQLExpression( ConstruyeConsulta );

         SetValue( rsSeleccion, PageControl.ActivePageIndex );
         SetValue( 'TextoExistencias', ExistenciasCtrl.Text );

         Start;
       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptUbaForm.AlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TRptUbaForm.AlmacenCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scAmbas, Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptUbaForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, False, Sender );
end;

end.
