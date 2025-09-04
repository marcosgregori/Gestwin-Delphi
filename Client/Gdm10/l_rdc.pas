
unit l_rdc;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  LibUtils,
  Mask,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, nxdb, DataManager, DB,
  dxmdaset, ReportManager, cxCheckBox, cxDBEdit, cxControls, cxContainer,
  cxEdit, cxTextEdit,

  cxCurrencyEdit, dxSkinsCore, dxSkinsDefaultPainters,

  Gim10Fields, cxGraphics, cxLookAndFeels, cxLabel, cxGroupBox, AppContainer;


type
    TConsultaFields = class( TnxeDatasetFields)
      Codigo : TWideStringField;
      Nombre : TWideStringField;
      Cargos : TBCDField;
      EnCartera : TBCDField;
      Descontado : TBCDField;
      Impagados : TBCDField;
      Riesgo : TBCDField;
      RiesgoLimite : TBCDField;
      Porcentaje : TBCDField;
      end;

    TRptRdcForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    ComprobarLimiteCtrl: TcxDBCheckBox;
    MargenCtrl: TcxDBCurrencyEdit;
    Report: TgxReportManager;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
    ClienteTable: TnxeTable;
    gxRangeBox1: TgxRangeBox;
    DataComprobarLimite: TBooleanField;
    DataMargen: TBCDField;
    Label6: TcxLabel;
    Label1: TcxLabel;
    Label11: TcxLabel;
    Label2: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ComprobarLimiteCtrlPropertiesEditValueChanged(
      Sender: TObject);
    private

    public

      ConsultaTable : TnxeTable;
      ConsultaFields : TConsultaFields;
      ClienteFields : TClienteFields;

      Cargos,
      DeudaActual,
      RiesgoActual,
      RiesgoTotal,
      Margen : Decimal;
      SubcuentaRiesgo : String;

    end;

var  RptRdcForm : TRptRdcForm = nil;

procedure ListadoRiesgoConClientes;


implementation

uses   EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,

       dm_sal,
       dm_cli,
       dm_ecc,
       
       cx_cli;

{$R *.DFM}

procedure ListadoRiesgoConClientes;
begin
     CreateReportForm( TRptRdcForm, RptRdcForm );
end;

procedure TRptRdcForm.initializeForm;
begin
     ClienteFields := TClienteFields.Create( ClienteTable );

     SetEditControlDecimals( MargenCtrl );

     DataCodigoInicial.Value := '00000';
     DataCodigoFinal.Value := HighStrCode;
end;

procedure TRptRdcForm.FormManagerOkButton;

var  Cargos,
     EnCartera,
     Descontado,
     Impagados,
     Riesgo,
     Porcentaje : Decimal;

procedure SeleccionaRegistros;
begin

     With ClienteTable do
       begin

       SetRange( [ DataCodigoInicial.Value ], [ DataCodigoFinal.Value ] );

       ApplicationContainer.StartProgression( RecordCount );

       First;
       While not Eof  do
         begin

         ApplicationContainer.ShowProgression;

         Riesgo := EfectoCobrar.ObtenRiesgoCliente( ClienteFields.Subcuenta.Value, Cargos, EnCartera, Descontado, Impagados );
         Margen := ClienteFields.Cobro_RiesgoLimite.Value - Riesgo;

         If   Riesgo<>0.0
         then If   not DataComprobarLimite.Value or ( Margen<DataMargen.Value )
              then begin

                   ConsultaTable.Append;

                   If   ClienteFields.Cobro_RiesgoLimite.Value=0.0
                   then Porcentaje := 0.0
                   else Porcentaje := ( Riesgo * 100.0 ) / ClienteFields.Cobro_RiesgoLimite.Value;

                   ConsultaFields.Codigo.Value := ClienteFields.Codigo.Value;
                   ConsultaFields.Nombre.Value := ClienteFields.Nombre.Value;
                   ConsultaFields.Cargos.Value := Cargos;
                   ConsultaFields.EnCartera.Value := EnCartera;
                   ConsultaFields.Descontado.Value := Descontado;
                   ConsultaFields.Impagados.Value := Impagados;
                   ConsultaFields.Riesgo.Value := Riesgo;
                   ConsultaFields.RiesgoLimite.Value := ClienteFields.Cobro_RiesgoLimite.Value;
                   ConsultaFields.Porcentaje.Value := Porcentaje;

                   ConsultaTable.Post;

                   end;

         Next;
         end;

       end;

     ApplicationContainer.EndProgression;

end;
                                                    
begin
     Enabled := False;
     With Report do
       try
         Load;
         ConsultaTable := CreateEmptyTable( 'Consulta', SQLSet.GetSQLText( 'Consulta' ) );
         ConsultaFields := TConsultaFields.Create( ConsultaTable );
         SeleccionaRegistros;
         SetValue( 'DesgloseCtasCobros', DataModule00.DmEmpresaFields.Contable_DesglosarCtasCobros.Value );
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptRdcForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TRptRdcForm.CodigoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptRdcForm.ComprobarLimiteCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     MargenCtrl.Enabled := DataComprobarLimite.Value;
end;

end.
 
