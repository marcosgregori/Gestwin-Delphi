
unit l_pyg;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  LibUtils,
  Mask,
  ComCtrls,

  DataManager,
  ReportManager, Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,
  nxdb, cxTextEdit, cxMaskEdit, cxSpinEdit, cxDBEdit, cxGroupBox,
  cxRadioGroup, cxControls, cxContainer, cxEdit, cxCheckBox,

  Gim00Fields,
  Gim10Fields,

  dm_sal, dxSkinsCore, cxGraphics, cxLookAndFeels, dxSkinsDefaultPainters,
  cxLabel, AppContainer;

const NivelMaximo = 5;

type
    TVariable    = record
      Nombre   : String;
      Valor    : array[ 1..2 ] of Decimal;
      end;

    TTipoRegistro = ( trCabecera, trLinea, trDesglose, trTotal );

    TListaSaldos = array[ 1..2 ] of Decimal;

    TRptPygForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    ModeloAbreviadoCtrl: TcxDBCheckBox;
    CentroCosteCtrl: TcxDBTextEdit;
    SeleccionCentroCosteCtrl: TcxDBRadioGroup;
    PeriodoInicialCtrl: TcxDBSpinEdit;
    PeriodoFinalCtrl: TcxDBSpinEdit;
    SaldosFinalesCtrl: TcxDBCheckBox;
    DesglosarCtrl: TcxDBCheckBox;
    ComparativoCtrl: TcxDBCheckBox;
    gxRangeBox1: TgxRangeBox;
    ExistenciaTable: TnxeTable;
    Data: TgxMemData;
    DataPeriodoInicial: TSmallintField;
    DataPeriodoFinal: TSmallintField;
    DataSaldosFinales: TBooleanField;
    DataModeloAbreviado: TBooleanField;
    DataDesglosar: TBooleanField;
    DataComparativo: TBooleanField;
    DataSource: TDataSource;
    DataSeleccionCentroCoste: TSmallintField;
    DataCentroCoste: TWideStringField;
    Label8: TcxLabel;
    Label4: TcxLabel;
    Label3: TcxLabel;
    Label2: TcxLabel;
    descCentroCosteLabel: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure SeleccionCentroCosteCtrlPropertiesChange(Sender: TObject);
    procedure ComparativoCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure PeriodoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CentroCosteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CentroCosteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure InitializeForm;
    procedure FormManagerOkButton;
    private

    public

      BalanceTable : TnxeTable;
      BalanceFields : TBalanceFields;
      ExistenciaFields : TExistenciaFields;

      // Fichero : Text;
      ConfigTextList : TStringList;

      Saldo,
      SaldoDebe,
      SaldoHaber,
      SaldoTitulo,
      TotalGrupo,
      SaldoVacio : TListaSaldos;

      UltimoNroCuenta,
      NroCuenta : SmallInt;

      CodigoCuenta : String;

      TextoCabecera : String;
      CodigoVariableNivel : array[ 1..NivelMaximo ] of String;
      TextoNivel : array[ 1..NivelMaximo ] of String;
      ImprimirNivel : array[ 1..NivelMaximo ] of Boolean;

      UltimoNivelImpreso,
      Nivel : SmallInt;

      MesInicialExistencias,
      MesFinalExistencias,
      MesFinalExistAnterior : SmallInt;

      SaldoExistInicial,
      SaldoExistFinal : Decimal;

      CodigoExistInicial,
      CodigoExistFinal : String;

      St,
      Cuentas,
      Linea : String;
      NroLineaFichero : Word;

      ListaCuenta : array[ 1..30 ] of String;
      IndDescripcion : SmallInt;

      PilaVariables : array[ 1..100 ] of TVariable;
      PunteroPila : SmallInt;

      NivelActivo : array[ 1..NivelMaximo ] of boolean;
      Variable : array[ 1..NivelMaximo ] of TVariable;
      VariableTmp : TVariable;
      Operacion : String[ 1 ];

      FicheroAbierto,
      Existe,
      Error : boolean;

      MesFinalAnterior,
      I, J, K : SmallInt;

    end;

var
  RptPygForm : TRptPygForm = nil;

procedure CuentaPerdidasyGanancias;


implementation

uses   Variants,
       Files,
       DateUtils,
       AppManager,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm10Dm,

       dm_pga,
       dm_sub,
       dm_cco,

       b_msg,

       cx_sub,
       cx_cco;

{$R *.DFM}

resourceString
       RsMsg1  = 'No consigo abrir el fichero de configuracion.';
       RsMsg2  = 'Por algún motivo el fichero [%s] no es accesible. Revise su instalación';
       RsMsg3  = 'CUENTA DE PERDIDAS Y GANANCIAS';
       RsMsg4  = 'La cabecera del fichero de configuracion es incorrecta.';
       RsMsg5  = 'Si ha modificado el fichero CPG_2008.RCF ó CPGA_2008.RCF, revíselo.';
       //..
       RsMsg8  = 'Total';

procedure CuentaPerdidasyGanancias;
begin
     CreateReportForm( TRptPygForm, RptPygForm );
end;

procedure TRptPygForm.initializeForm;
begin
     ExistenciaFields := TExistenciaFields.Create( ExistenciaTable );

     SeleccionCentroCosteCtrl.Enabled := DataModule00.DmEmpresaFields.Contable_CtrosCoste.Value;

     DataPeriodoInicial.Value := 0; 
     DataPeriodoFinal.Value := MonthOf( ApplicationContainer.TodayDate );
     DataSeleccionCentroCoste.Value := 0;
     DataModeloAbreviado.Value := False;
     DataComparativo.Value := True;

end;

procedure TRptPygForm.PeriodoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateMonth( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptPygForm.SeleccionCentroCosteCtrlPropertiesChange(Sender: TObject);
begin
     CentroCosteCtrl.Enabled := DataSeleccionCentroCoste.Value=1;
end;

procedure TRptPygForm.FormManagerOkButton;
begin

     Enabled := False;

     Saldos.Cuadra;

     With Report do
       try

         Load;

         BalanceTable  := CreateEmptyTable( 'Balance', DataModule10.SQLSet );

         Saldos.SaldosPerdidasyGanancias( BalanceTable,

                                          DataSeleccionCentroCoste.Value,
                                          DataCentroCoste.Value,
                                          ApplicationContainer.Ejercicio,
                                          DataPeriodoInicial.Value,
                                          DataPeriodoFinal.Value,
                                          DataDesglosar.Value,
                                          DataSaldosFinales.Value,
                                          DataModeloAbreviado.Value );

         With DataSeleccionCentroCoste do
           If   Active
           then SetValueField( DataSeleccionCentroCoste )
           else SetValue( RsSeleccionCentroCoste, 2 );    // No existen centros de coste

         SetValue( RsDescCentroCoste, descCentroCosteLabel.Caption );
         SetValue( RsTextoPeriodoInicial, StrMonth( DataPeriodoInicial.Value, False ) );
         SetValue( RsTextoPeriodoFinal, StrMonth( DataPeriodoFinal.Value, False ) );

         Start;

       except on E : Exception do Cancel( E );
         end;

end;

procedure TRptPygForm.CentroCosteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCentrosCoste( Sender );
end;

procedure TRptPygForm.CentroCosteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     CentroCoste.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptPygForm.ComparativoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     SaldosFinalesCtrl.Enabled := DataComparativo.Value;
end;

end.
 
