
unit l_reb;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  Libutils,
  Mask,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, nxdb, DataManager,
  ReportManager, DB, dxmdaset,

  Gim10Fields, cxGraphics, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters,
  cxLabel, cxGroupBox, AppContainer;


type
    TConsultaFields = class( TnxeDatasetFields)
      Codigo : TWideStringField;
      Nombre : TWideStringField;
      Riesgo : TBCDField;
      RiesgoActual : TBCDField;
      Porcentaje1 : TBCDField;
      Descuentos : TBCDField;
      Intereses : TBCDField;
      Porcentaje2 : TBCDField;
      end;

    TRptRebForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    gxRangeBox1: TgxRangeBox;
    Data: TgxMemData;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
    DataSource: TDataSource;
    Report: TgxReportManager;
    BancoTable: TnxeTable;
    Label6: TcxLabel;
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
    procedure CodigoFinalCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoInicialCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

    public

      ConsultaTable : TnxeTable;
      ConsultaFields : TConsultaFields;
      BancoFields : TBancoFields;

      Descuentos,
      Intereses,
      RiesgoActual,
      Porcentaje1,
      Porcentaje2 : Decimal;

    end;

var RptRebForm : TRptRebForm = nil;

procedure ListadoRiesgoEnBancos;


implementation

uses   EnterpriseDataAccess,

       dmi_sal,

       dm_sal,
       dm_ban,

       cx_ban;

{$R *.DFM}

procedure ListadoRiesgoEnBancos;
begin
     CreateReportForm( TRptRebForm, RptRebForm );
end;

procedure TRptRebForm.initializeForm;
begin
     BancoFields := TBancoFields.Create( BancoTable );

     DataCodigoInicial.Value := '572000000';
     DataCodigoFinal.Value := '572999999';
end;

procedure TRptRebForm.FormManagerOkButton;

procedure SeleccionaRegistros;

var  SumasySaldos : ISumasySaldos;

begin

     With BancoTable do
       begin

       SetRange( [ DataCodigoInicial.Value ], [ DataCodigoFinal.Value ] );

       ApplicationContainer.StartProgression( RecordCount );

       First;
       While not Eof  do
         begin

         ApplicationContainer.ShowProgression;

         ConsultaTable.Append;

         SumasySaldos := Saldos.SaldoPeriodo( BancoFields.Subcuenta_Riesgo.Value, '', True, ApplicationContainer.Ejercicio, 0, ApplicationContainer.NroMesFinal );
         RiesgoActual := SumasySaldos.Saldo;
         If   RiesgoActual<>0.0
         then RiesgoActual := -RiesgoActual;

         If   BancoFields.Riesgo.Value=0.0
         then Porcentaje1 := 0.0
         else Porcentaje1 := ( RiesgoActual * 100.0 ) / BancoFields.Riesgo.Value;

         Descuentos := SumasySaldos.SumaHaber;

         Saldos.saldoPeriodo( BancoFields.Subcuenta_Intereses.Value, '', True, ApplicationContainer.Ejercicio, 0, ApplicationContainer.NroMesFinal );

         Intereses := SumasySaldos.Saldo;
         If   Descuentos=0.0
         then Porcentaje2 := 0.0
         else Porcentaje2 := ( Intereses * 100.0 ) / Descuentos;

         ConsultaFields.Codigo.Value := BancoFields.Subcuenta.Value;
         ConsultaFields.Nombre.Value := BancoFields.Nombre.Value;
         ConsultaFields.Riesgo.Value := BancoFields.Riesgo.Value;
         ConsultaFields.RiesgoActual.Value := RiesgoActual;
         ConsultaFields.Porcentaje1.Value := Porcentaje1;
         ConsultaFields.Descuentos.Value := Descuentos;
         ConsultaFields.Intereses.Value := Intereses;
         ConsultaFields.Porcentaje2.Value := Porcentaje2;

         ConsultaTable.Post;

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
         SetValueFields( Data );
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptRebForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaBancos( Sender );
end;

procedure TRptRebForm.CodigoFinalCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Banco.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptRebForm.CodigoInicialCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Banco.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

end.
