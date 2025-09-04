
unit i_rem;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons, DB, nxdb,

  AppContainer,
  Gim10Fields,
  Mask,
  ComCtrls,

  dm_sal,
  DataManager,
  EnterpriseDataAccess,
  ReportManager, Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxSpinEdit, cxDBEdit,
  dxmdaset, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics,
  cxLookAndFeels, cxLabel, cxGroupBox, dxUIAClasses;


type
    TRptFRemForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    NroRemesaCtrl: TcxDBTextEdit;
    NroOrdenCtrl: TcxDBSpinEdit;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    EfectoCobrarTable: TnxeTable;
    RemesaTable: TnxeTable;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataNroRemesa: TIntegerField;
    DataNroOrden: TSmallintField;
    DataFormato: TSmallintField;
    FormatoCtrl: TcxDBSpinEdit;
    Label6: TcxLabel;
    Label7: TcxLabel;
    Label4: TcxLabel;
    FormatoLabel: TcxLabel;
    Label1: TcxLabel;
    procedure ReportSetReportName;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ReportSelectPrinter;
    procedure NroRemesaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure NroRemesaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ReportBeforeStart;
    private

      ClienteFields : TClienteFields;
      BancoFields : TBancoFields;

      RptCartaRemesaTable,
      RptLineaCartaRemesaTable : TnxeTable;

      RemesaFields : TRemesaFields;
      EfectoCobrarFields : TEfectoCobrarFields;

      RptCartaRemesaFields : TCartaRemesaFields;
      RptLineaCartaRemesaFields : TLineaCartaRemesaFields;

      UltVencimientoEfecto : TDate;
    procedure SeleccionaRegistros;

    protected
    class var
      NroRemesa : LongInt;

    public


    end;

var
  RptFRemForm : TRptFRemForm = nil;

procedure impresionCartaRemesa( NroRemesa : LongInt );


implementation

uses   AppManager,

       Gim00Fields,

       Gdm10Dm,

       b_msg,

       dm_emp,
       dm_ban,
       dm_sub,
       dm_prv,
       dm_cli,
       dm_ine,
       dm_rem,

       a_imp,

       cx_rem,
       cx_imp;

{$R *.DFM}

procedure ImpresionCartaRemesa( NroRemesa : LongInt );
begin
     RptFRemForm.NroRemesa := NroRemesa;
     CreateReportForm( TRptFRemForm, RptFRemForm );
end;

procedure TRptFRemForm.InitializeForm;
begin
     RemesaFields := TRemesaFields.Create( RemesaTable );
     EfectoCobrarFields := TEfectoCobrarFields.Create( EfectoCobrarTable );

     BancoFields := TBancoFields.Create( Self );
     ClienteFields := TClienteFields.Create( Self );

     DataNroRemesa.Value := NroRemesa;
     DataNroOrden.Value := 1;
end;

procedure TRptFRemForm.NroRemesaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaRemesas( Sender, srTodas );
end;

procedure TRptFRemForm.NroRemesaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Remesa.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptFRemForm.FormatoCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntImpresos( [ Ord( impCartaRemesa ), Sender.EditingValue ] );
end;

procedure TRptFRemForm.FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaImpresos( impCartaRemesa, Sender );
end;

procedure TRptFRemForm.FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     InformeExterno.Valida( impCartaRemesa, Sender, DisplayValue, Errortext, Error );
end;

procedure TRptFRemForm.SeleccionaRegistros;
begin

     If   RemesaTable.FindKey( [ ApplicationContainer.Ejercicio, DataNroRemesa.Value ] )
     then begin

          RptCartaRemesaTable.Append;

          Banco.Obten( RemesaFields.SubcuentaEntidad.Value, BancoFields, True );

          UltVencimientoEfecto := 0;

          With EfectoCobrarTable do
            begin

            With RemesaFields do
              SetRange( [ Ejercicio.Value, NroRemesa.Value ], [ Ejercicio.Value, NroRemesa.Value ] );

            ApplicationContainer.StartProgression( RecordCount );

            First;
            While not Eof do
              begin

              RptLineaCartaRemesaTable.Append;

              With RptLineaCartaRemesaFields do
                begin

                NroRemesa.Value := RemesaFields.NroRemesa.Value;
                FechaVencimiento.Value := EfectoCobrarFields.FechaVencimiento.Value;
                Serie.Value := EfectoCobrarFields.Serie.Value;
                NroFactura.Value := EfectoCobrarFields.NroFactura.Value;
                NroEfecto.Value := EfectoCobrarFields.NroEfecto.Value;
                CodigoCliente.Value := EfectoCobrarFields.SubcuentaCliente.Value;

                If   Cliente.Obten( EfectoCobrarFields.CodigoCliente.Value, EfectoCobrarFields.SubcuentaCliente.Value, ClienteFields )
                then begin
                     NombreCliente.Value := ClienteFields.Cobro_Nombre.Value;
                     Plaza.Value := ClienteFields.Cobro_Localidad.Value;
                     end
                else NombreCliente.Value := Cuenta.Descripcion( EfectoCobrarFields.SubcuentaCliente.Value, True, True );

                Importe.Value := EfectoCobrarFields.Importe.Value;

                With RptCartaRemesaFields do
                  begin
                  ImporteRemesa.Value := ImporteRemesa.Value + EfectoCobrarFields.Importe.Value;
                  NroEfectos.Value := NroEfectos.Value + 1;
                  end;

                If   UltVencimientoEfecto<EfectoCobrarFields.FechaVencimiento.Value
                then UltVencimientoEfecto := EfectoCobrarFields.FechaVencimiento.Value;

                end;

              RptLineaCartaRemesaTable.Post;

              ApplicationContainer.ShowProgression;

              Next;
              end;

            end;

          With RptCartaRemesaFields do
            begin

            NroRemesa.Value := RemesaFields.NroRemesa.Value;
            Fecha.Value := RemesaFields.Fecha.Value;
            SubcuentaEntidad.Value := BancoFields.Subcuenta.Value;
            CodigoEntidad.Value := BancoFields.Subcuenta.Value;
            Entidad.Value := BancoFields.Nombre.Value;
            Presentador.Value := BancoFields.Adeudos_Presentador.Value;
            NIFPresentador.Value := BancoFields.Adeudos_NIF.Value;
            EntidadReceptora.Value := BancoFields.Adeudos_EntidadRec.Value;
            OficinaReceptora.Value := BancoFields.Adeudos_OficinaRec.Value;
            EntidadDeposito.Value := BancoFields.Adeudos_EntidadDep.Value;
            OficinaDeposito.Value := BancoFields.Adeudos_OficinaDep.Value;
            DCDeposito.Value := BancoFields.Adeudos_DCDeposito.Value;
            CuentaDeposito.Value := BancoFields.Adeudos_CuentaDep.Value;
            FechaVtoInicial.Value := RemesaFields.fechaVtoInicial.Value;
            FechaVtoFinal.Value := RemesaFields.fechaVtoFinal.Value;
            CodigoIdentificacion.Value := BancoFields.Adeudos_CIC.Value;
            NroOrden.Value := DataNroOrden.Value;
            UltimoVencimiento.Value := UltVencimientoEfecto;
            end;

          RptCartaRemesaTable.Post;

          ApplicationContainer.EndProgression;
          end;
end;

procedure TRptFRemForm.FormManagerOkButton;
begin
     Report.Launch;
end;

procedure TRptFRemForm.ReportBeforeStart;
begin
     RptCartaRemesaTable := Report.CreateEmptyTable( 'CartaRemesa', DataModule10.SQLSet );
     RptCartaRemesaFields := TCartaRemesaFields.Create( RptCartaRemesaTable );

     RptLineaCartaRemesaTable := Report.CreateEmptyTable( 'LineaCartaRemesa', DataModule10.SQLSet );
     RptLineaCartaRemesaFields := TLineaCartaRemesaFields.Create( RptLineaCartaRemesaTable );

     SeleccionaRegistros;
end;

procedure TRptFRemForm.ReportSelectPrinter;
begin
     Report.ReportPrinter := InformeExterno.Impresora;
end;

procedure TRptFRemForm.ReportSetReportName;
begin
     Report.FileName := InformeExterno.Fichero;
end;

end.
