
unit l_ecc;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,
  Mask, ComCtrls,

  Menus, cxLookAndFeelPainters, cxButtons, cxGraphics, DB, nxdb,
  DataManager, cxDropDownEdit, cxDBEdit, cxIndexedComboBox, cxMaskEdit,
  cxCalendar, cxControls, cxContainer, cxEdit, cxTextEdit, ReportManager,
  dxmdaset,

  AppContainer,

  Gim10Fields, dxSkinsCore, dxSkinsDefaultPainters, cxCheckBox, cxGroupBox,
  cxRadioGroup, cxLookAndFeels, cxLabel, cxCurrencyEdit;


type
    TRptEccForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    EfectoCobrarQuery: TnxeQuery;
    SerieInicialCtrl: TcxDBTextEdit;
    SerieFinalCtrl: TcxDBTextEdit;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    TipoDocumentoCtrl: TcxDBIndexedComboBox;
    SituacionCtrl: TcxDBIndexedComboBox;
    RevisionCtrl: TcxDBIndexedComboBox;
    FormaCobroCtrl: TcxDBTextEdit;
    ClienteInicialCtrl: TcxDBTextEdit;
    ClienteFinalCtrl: TcxDBTextEdit;
    Data: TgxMemData;
    DataSource: TDataSource;
    report: TgxReportManager;
    DataSerieInicial: TStringField;
    DataSerieFinal: TStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataTipoDocumento: TSmallintField;
    DataSituacion: TSmallintField;
    DataRevision: TSmallintField;
    DataFormaCobro: TStringField;
    DataClienteInicial: TStringField;
    DataClienteFinal: TStringField;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    gxRangeBox3: TgxRangeBox;
    DataAgruparEntidad: TBooleanField;
    AgruparEntidadCtrl: TcxDBCheckBox;
    gxRangeBox4: TgxRangeBox;
    EntidadInicialCtrl: TcxDBTextEdit;
    EntidadFinalCtrl: TcxDBTextEdit;
    DataEntidadInicial: TStringField;
    DataEntidadFinal: TStringField;
    DataTipoFecha: TSmallintField;
    TipoFechaCtrl: TcxDBRadioGroup;
    Label6: TcxLabel;
    FechaLabel: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label8: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label5: TcxLabel;
    Label7: TcxLabel;
    Label11: TcxLabel;
    Label12: TcxLabel;
    Label13: TcxLabel;
    Label14: TcxLabel;
    AgruparClienteCtrl: TcxDBCheckBox;
    DataAgruparCliente: TBooleanField;
    cxLabel1: TcxLabel;
    gxRangeBox5: TgxRangeBox;
    DataImporteMinimo: TBCDField;
    DataImporteMaximo: TBCDField;
    ImporteMinimoCtrl: TcxDBCurrencyEdit;
    ImporteMaximoCtrl: TcxDBCurrencyEdit;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure FormaCobroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormaCobroCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TipoFechaCtrlPropertiesChange(Sender: TObject);
    procedure AgruparClienteCtrlPropertiesChange(Sender: TObject);
    procedure AgruparEntidadCtrlPropertiesChange(Sender: TObject);
    procedure reportBeforeStart;
    procedure SerieCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private
      EfectoCobrarFields : TEfectoCobrarFields;
      RemesaFields : TRemesaFields;
      RelacionEfectosTable : TnxeTable;
      RelacionEfectosFields : TRelacionEfectosFields;
      FormaCobroFields : TFormaCobroFields;
    procedure SeleccionaRegistros;

    public

    end;

var
  RptEccForm : TRptEccForm = nil;

procedure ListadoEfectosCobrar;


implementation

uses   LibUtils,
       EnterpriseDataAccess,

       Gdm10Dm,

       dm_pga,
       dm_ast,
       dm_tas,
       dm_sub,
       dm_iva,
       dm_fco,
       dm_rem,
       dm_ecc,
       dm_sdf,

       b_msg,

       cx_sub,
       cx_ecc,
       cx_fco,
       cx_sdf;

{$R *.DFM}

resourceString
       RsMsg1  = 'Vencimiento';
       RsMsg2  = 'Cobro o descuento';

procedure ListadoEfectosCobrar;
begin
     CreateReportForm( TRptEccForm, RptEccForm );
end;

procedure TRptEccForm.InitializeForm;
begin

     RemesaFields := TRemesaFields.Create( Self );
     FormaCobroFields := TFormaCobroFields.Create( Self );

     SetEditControlsDecimals( [ ImporteMinimoCtrl, ImporteMaximoCtrl ] );

     DataSerieFinal.Value := HighStrCode;
     DataFechaInicial.Value := ApplicationContainer.TodayDate;
     DataTipoFecha.Value := 0;
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;
     DataClienteInicial.Value := '430000000';
     DataClienteFinal.Value := '43' + HighStrCode;
     DataEntidadInicial.Value := '570000000';
     DataEntidadFinal.Value := '57' + HighStrCode;
     DataImporteMaximo.Value := 99999999.99;
     DataTipoDocumento.Value := 0;
     DataSituacion.Value := 0;
     DataRevision.Value := 0;
end;

procedure TRptEccForm.reportBeforeStart;
begin
     With Report do
       begin
       RelacionEfectosTable := CreateEmptyTable( 'RelacionEfectos', DataModule10.GetSQL( 'RelacionEfectos' ) );
       RelacionEfectosFields := TRelacionEfectosFields.Create( RelacionEfectosTable );

       SeleccionaRegistros;

       With RelacionEfectosTable do
         If   DataAgruparCliente.Value or DataAgruparEntidad.Value
         then IndexFieldNames := 'CodigoGrupo;Serie;FechaVencimiento;NroFactura;NroEfecto'
         else IndexFieldNames := 'FechaVencimiento;Entidad;Serie;NroFactura;NroEfecto';

       SetValue( 'TextoTipoDocumento', TipoDocumentoCtrl.Text );
       SetValue( 'TextoSituacion', SituacionCtrl.Text );
       SetValue( 'TextoRevision', RevisionCtrl.Text );
       end;

end;

procedure TRptEccForm.TipoFechaCtrlPropertiesChange(Sender: TObject);
begin
     case TipoFechaCtrl.ItemIndex of
       0 : FechaLabel.Caption := RsMsg1;
       1 : FechaLabel.Caption := RsMsg2;
       end; 
end;

procedure TRptEccForm.AgruparClienteCtrlPropertiesChange(Sender: TObject);
begin
     If   AgruparClienteCtrl.Checked
     then DataAgruparEntidad.Value := False;
end;

procedure TRptEccForm.AgruparEntidadCtrlPropertiesChange(Sender: TObject);
begin
     If   AgruparEntidadCtrl.Checked
     then DataAgruparCliente.Value := False;
end;

procedure TRptEccForm.ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, True, False );
end;

procedure TRptEccForm.ClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptEccForm.FormaCobroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasCobro( Sender );
end;

procedure TRptEccForm.FormaCobroCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then FormaCobroCtrl.Description := rsgMsgTodas
     else FormaCobro.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptEccForm.SeleccionaRegistros;

var   InsertarRegistro : Boolean;
      SQLText : String;
      SerieFacturacionFields : TSerieFacturacionFields;

begin

     With EfectoCobrarQuery do
       try

         Close;

         SQLText := 'SELECT EfectoCobrar.* ';

         If   DataTipoFecha.Value=0
         then StrAdd( SQLText, SQLFormat( ' FROM EfectoCobrar WHERE ( EfectoCobrar.FechaVencimiento BETWEEN %s AND %s ) ORDER BY FechaVencimiento', [ DataFechaInicial, DataFechaFinal ] ) )
         else begin
              StrAdd( SQLText, ', Remesa.FechaCobro AS FechaCobroRemesa, Remesa.FechaDescuento AS FechaDescuentoRemesa FROM EfectoCobrar LEFT JOIN Remesa ON ( EfectoCobrar.EjercicioRemesa=Remesa.Ejercicio AND EfectoCobrar.NroRemesa=Remesa.NroRemesa )' );
              StrAdd( SQLText, SQLFormat( ' WHERE ( EfectoCobrar.FechaCobro BETWEEN %0:s AND %1:s ) OR ( Remesa.FechaCobro BETWEEN %0:s AND %1:s ) OR ( Remesa.FechaDescuento BETWEEN %0:s AND %1:s ) ORDER BY FechaCobro, Remesa.FechaCobro, Remesa.FechaDescuento',
                                          [ DataFechaInicial, DataFechaFinal ] ) );
              end;

         SQL.Text := SQLText;

         Open;

         EfectoCobrarFields := TEfectoCobrarFields.Create( EfectoCobrarQuery );

         ApplicationContainer.StartProgression( RecordCount );

         First;
         While not Eof  do
           begin

           If   ( EfectoCobrarFields.Serie.Value>=DataSerieInicial.Value ) and
                ( EfectoCobrarFields.Serie.Value<=DataSerieFinal.Value ) and

                ( EfectoCobrarFields.SubcuentaCliente.Value>=DataClienteInicial.Value ) and
                ( EfectoCobrarFields.SubcuentaCliente.Value<=DataClienteFinal.Value ) and

                ( EfectoCobrarFields.SubcuentaEntidad.Value>=DataEntidadInicial.Value ) and
                ( EfectoCobrarFields.SubcuentaEntidad.Value<=DataEntidadFinal.Value ) and

                ( EfectoCobrarFields.Importe.Value>=DataImporteMinimo.Value ) and
                ( EfectoCobrarFields.Importe.Value<=DataImporteMaximo.Value )

           then begin

                ApplicationContainer.ShowProgression;

                InsertarRegistro := True;

                If   DataTipoDocumento.Value<>0
                then FormaCobro.Obten( EfectoCobrarFields.FormaDePago.Value, FormaCobroFields, False );

                InsertarRegistro := ( DataTipoDocumento.Value=0 ) or ( DataTipoDocumento.Value=FormaCobroFields.TipoDeDocumento.Value );

                If   InsertarRegistro
                then begin

                     case DataSituacion.Value of
                       0 : ;
                       1 : InsertarRegistro := EfectoCobrar.EfectoPendiente( EfectoCobrarFields );
                       2,
                       3 : begin
                           InsertarRegistro := False;
                           If   not ValueIsEmpty( EfectoCobrarFields.NroRemesa.Value )
                           then begin
                                If   Remesa.Obten( EfectoCobrarFields.EjercicioRemesa.Value, EfectoCobrarFields.NroRemesa.Value, RemesaFields )
                                then InsertarRegistro := ( ( DataSituacion.Value=2 ) and ( RemesaFields.Estado.Value=erDescontada ) and not EfectoCobrarFields.Cancelado.Value ) or
                                                         ( ( DataSituacion.Value=3 ) and ( RemesaFields.Estado.Value=erAceptada ) );
                                end;
                           end;
                       4 : InsertarRegistro := not EfectoCobrar.EfectoPendiente( EfectoCobrarFields );
                       5 : InsertarRegistro := EfectoCobrarFields.Impagado.Value;
                       end;

                     If   InsertarRegistro
                     then begin

                          case DataRevision.Value of
                            0 : ;
                            1 : InsertarRegistro := EfectoCobrarFields.Revisado.Value;
                            2 : InsertarRegistro := not EfectoCobrarFields.Revisado.Value;
                            end;

                          InsertarRegistro := InsertarRegistro and ( ValueIsEmpty( DataFormaCobro.Value ) or ( DataFormaCobro.Value=EfectoCobrarFields.FormaDePago.Value) );

                          If   InsertarRegistro
                          then With RelacionEfectosFields do
                                 begin

                                 RelacionEfectosTable.Append;

                                 Ejercicio.Value := EfectoCobrarFields.Ejercicio.Value;
                                 Serie.Value := EfectoCobrarFields.Serie.Value;
                                 NroFactura.Value := EfectoCobrarFields.NroFactura.Value;
                                 NroEfecto.Value := EfectoCobrarFields.NroEfecto.Value;
                                 FechaVencimiento.Value := EfectoCobrarFields.FechaVencimiento.Value;
                                 FechaLibramiento.Value := EfectoCobrarFields.FechaLibramiento.Value;

                                 If   not ValueIsEmpty( EfectoCobrarFields.FechaCobro.Value )
                                 then FechaCobro.Value := EfectoCobrarFields.FechaCobro.Value
                                 else If   not ValueIsEmpty( EfectoCobrarFields.FechaCobroRemesa.Value )
                                      then FechaCobro.Value := EfectoCobrarFields.FechaCobroRemesa.Value
                                      else If   not ValueIsEmpty( EfectoCobrarFields.FechaDescuentoRemesa.Value )
                                           then FechaCobro.Value := EfectoCobrarFields.FechaDescuentoRemesa.Value;

                                 Propietario.Value := EfectoCobrarFields.SubcuentaCliente.Value;
                                 Nombre.Value := Cuenta.Descripcion( EfectoCobrarFields.SubcuentaCliente.Value, True, True );
                                 Entidad.Value := EfectoCobrarFields.SubcuentaEntidad.Value;
                                 Descripcion.Value := Cuenta.Descripcion( EfectoCobrarFields.SubcuentaEntidad.Value, True, True );
                                 Concepto.Value := EfectoCobrarFields.Concepto.Value;
                                 Importe.Value := EfectoCobrarFields.Importe.Value;
                                 ImporteCobrado.Value := EfectoCobrarFields.ImporteCobrado.Value;
                                 GastosGestion.Value := EfectoCobrarFields.GastosGestion.Value;
                                 GastosDevolucion.Value := EfectoCobrarFields.GastosDevolucion.Value;
                                 CodigoFormaCobro.Value := EfectoCobrarFields.FormaDePago.Value;
                                 DescripcionFormaCobro.Value := FormaCobro.Descripcion( CodigoFormaCobro.Value, False );

                                 If   DataAgruparEntidad.Value
                                 then CodigoGrupo.Value := Entidad.Value
                                 else If   DataAgruparCliente.Value
                                      then CodigoGrupo.Value := Propietario.Value;

                                 DescripcionGrupo.Value := Cuenta.Descripcion( CodigoGrupo.Value, False, False );

                                 RelacionEfectosTable.Post;

                                 end;

                          end;
                     end;
                end;

           Next;
           end;

     finally
       Close;
       end;

     ApplicationContainer.EndProgression;

end;

procedure TRptEccForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TRptEccForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptEccForm.FormManagerOkButton;
begin
     Report.Launch;
end;

end.
