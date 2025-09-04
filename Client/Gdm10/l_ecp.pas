
unit l_ecp;

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

  Gim10Fields, cxPC, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxCheckBox, cxLookAndFeels, cxLabel, cxGroupBox, cxRadioGroup;


type
    TRptEcpForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    EfectoPagarTable: TnxeTable;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    TipoDocumentoCtrl: TcxDBIndexedComboBox;
    SituacionCtrl: TcxDBIndexedComboBox;
    RevisionCtrl: TcxDBIndexedComboBox;
    FormaPagoCtrl: TcxDBTextEdit;
    Data: TgxMemData;
    DataSource: TDataSource;
    report: TgxReportManager;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataTipoDocumento: TSmallintField;
    DataSituacion: TSmallintField;
    DataRevision: TSmallintField;
    DataFormaPago: TWideStringField;
    DataProveedorInicial: TWideStringField;
    DataProveedorFinal: TWideStringField;
    gxRangeBox2: TgxRangeBox;
    DataEntidadInicial: TWideStringField;
    DataEntidadFinal: TWideStringField;
    DataAgruparEntidad: TBooleanField;
    FechaLabel: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label8: TcxLabel;
    Label9: TcxLabel;
    DataTipoFecha: TSmallintField;
    Label14: TcxLabel;
    TipoFechaCtrl: TcxDBRadioGroup;
    gxRangeBox1: TgxRangeBox;
    CodigoProveedorInicialCtrl: TcxDBTextEdit;
    CodigoProveedorFinalCtrl: TcxDBTextEdit;
    Label6: TcxLabel;
    Label11: TcxLabel;
    Label7: TcxLabel;
    gxRangeBox3: TgxRangeBox;
    CodigoEntidadInicialCtrl: TcxDBTextEdit;
    CodigoEntidadFinalCtrl: TcxDBTextEdit;
    Label10: TcxLabel;
    Label12: TcxLabel;
    Label13: TcxLabel;
    AgruparEntidadCtrl: TcxDBCheckBox;
    AgruparProveedorCtrl: TcxDBCheckBox;
    DataAgruparProveedor: TBooleanField;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure FormaPagoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormaPagoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ProveedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SubcuentaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure SubcuentaCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure TipoFechaCtrlPropertiesChange(Sender: TObject);
    procedure AgruparProveedorCtrlPropertiesChange(Sender: TObject);
    procedure AgruparCtrlPropertiesChange(Sender: TObject);
    procedure reportBeforeStart;
    private
    procedure SeleccionaRegistros;

    public
      EfectoPagarFields : TEfectoPagarFields;
      RelacionEfectosTable : TnxeTable;
      RelacionEfectosFields : TRelacionEfectosFields;
      RemesaPagoFields : TRemesaPagoFields;
      FormaPagoFields : TFormaPagoFields;
    end;

var RptEcpForm : TRptEcpForm = nil;

procedure ListadoEfectosPagar;


implementation

uses   EnterpriseDataAccess,

       Gdm10Dm,

       dm_pga,
       dm_ast,
       dm_tas,
       dm_sub,
       dm_iva,
       dm_fpa,
       dm_rdp,
       dm_ecp,

       b_msg,

       cx_sub,
       cx_ecp,
       cx_fpa;

{$R *.DFM}

resourceString
       RsMsg1  = 'Vencimiento';
       RsMsg2  = 'Fecha de pago';

const  TextoAgrupacion : array[ 0..1 ] of String = ( 'proveedor o acreedor', 'entidad financiera' );

procedure ListadoEfectosPagar;
begin
     CreateReportForm( TRptEcpForm, RptEcpForm );
end;

procedure TRptEcpForm.initializeForm;
begin
     EfectoPagarFields := TEfectoPagarFields.Create( EfectoPagarTable );
     RemesaPagoFields := TRemesaPagoFields.Create( Self );
     FormaPagoFields := TFormaPagoFields.Create( Self );

     DataTipoFecha.Value := 0;
     DataFechaInicial.Value := ApplicationContainer.TodayDate;
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;
     DataProveedorInicial.Value := '400000000';
     DataProveedorFinal.Value := '41' + HighStrCode;
     DataEntidadInicial.Value := '570000000';
     DataEntidadFinal.Value := '57' + HighStrCode;
     DataTipoDocumento.Value := 0;
     DataSituacion.Value := 0;
     DataRevision.Value := 0;
end;

procedure TRptEcpForm.ProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, True, False );
end;

procedure TRptEcpForm.ProveedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptEcpForm.reportBeforeStart;
begin
     With Report do
       begin
       RelacionEfectosTable := CreateEmptyTable( 'RelacionEfectos', DataModule10.GetSQL( 'RelacionEfectos' ) );
       RelacionEfectosFields := TRelacionEfectosFields.Create( RelacionEfectosTable );

       SeleccionaRegistros;

       SetValue( 'TextoTipoDocumento', TipoDocumentoCtrl.Text );
       SetValue( 'TextoSituacion', SituacionCtrl.Text );
       SetValue( 'TextoRevision', RevisionCtrl.Text );

       With RelacionEfectosTable do
         If   DataAgruparProveedor.Value or DataAgruparEntidad.Value
         then IndexFieldNames := 'CodigoGrupo;Serie;FechaVencimiento;NroFactura;NroEfecto'
         else IndexFieldNames := 'FechaVencimiento;Entidad;Serie;NroFactura;NroEfecto';

       end;
end;

procedure TRptEcpForm.SubcuentaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender );
end;

procedure TRptEcpForm.SubcuentaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorTExt, Error, nil, True );
end;

procedure TRptEcpForm.TipoFechaCtrlPropertiesChange(Sender: TObject);
begin
      case TipoFechaCtrl.ItemIndex of
       0 : FechaLabel.Caption := RsMsg1;
       1 : FechaLabel.Caption := RsMsg2;
       end;
end;

procedure TRptEcpForm.AgruparCtrlPropertiesChange(Sender: TObject);
begin
     If   AgruparEntidadCtrl.Checked
     then DataAgruparProveedor.Value := False;
end;

procedure TRptEcpForm.AgruparProveedorCtrlPropertiesChange(Sender: TObject);
begin
     If   AgruparProveedorCtrl.Checked
     then DataAgruparEntidad.Value := False;
end;

procedure TRptEcpForm.FormaPagoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasPago( Sender );
end;

procedure TRptEcpForm.FormaPagoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then FormaPagoCtrl.Description := rsgMsgTodas
     else FormaPago.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptEcpForm.SeleccionaRegistros;

var   InsertarRegistro : Boolean;

begin

     With EfectoPagarTable do
       begin

       If   DataTipoFecha.Value=0
       then IndexFieldNames := 'FechaVencimiento'
       else IndexFieldNames := 'FechaPago';

       SetRange( [ DataFechaInicial.Value ], [ DataFechaFinal.Value ] );

       ApplicationContainer.StartProgression( RecordCount );

       First;
       While not Eof  do
         begin

         If   ( EfectoPagarFields.SubcuentaProveedor.Value>=DataProveedorInicial.Value ) and
              ( EfectoPagarFields.SubcuentaProveedor.Value<=DataProveedorFinal.Value ) and
              ( EfectoPagarFields.SubcuentaEntidad.Value>=DataEntidadInicial.Value ) and
              ( EfectoPagarFields.SubcuentaEntidad.Value<=DataEntidadFinal.Value )
         then begin

              ApplicationContainer.ShowProgression;

              InsertarRegistro := True;

              FormaPago.Obten( EfectoPagarFields.FormaDePago.Value, FormaPagoFields );

              InsertarRegistro := ( DataTipoDocumento.Value=0 ) or ( DataTipoDocumento.Value=FormaPagoFields.TipoDeDocumento.Value );

              If   InsertarRegistro
              then begin

                   case DataSituacion.Value of
                     0 : ;
                     1 : InsertarRegistro := EfectoPagar.EfectoPendiente( EfectoPagarFields );
                     2 : InsertarRegistro := not EfectoPagar.EfectoPendiente( EfectoPagarFields );
                     end;

                   If   InsertarRegistro
                   then begin

                        case DataRevision.Value of
                          0 : ;
                          1 : InsertarRegistro := EfectoPagarFields.Revisado.Value;
                          2 : InsertarRegistro := not EfectoPagarFields.Revisado.Value;
                          end;

                        InsertarRegistro := InsertarRegistro and ( ValueIsEmpty( DataFormaPago.Value ) or ( DataFormaPago.Value=EfectoPagarFields.FormaDePago.Value) );

                        If   InsertarRegistro
                        then With RelacionEfectosFields do
                               begin                                        

                               RelacionEfectosTable.Append;

                               Ejercicio.Value := EfectoPagarFields.Ejercicio.Value;
                               Serie.Value := EfectoPagarFields.Serie.Value;
                               NroFactura.Value := EfectoPagarFields.NroFactura.Value;
                               NroEfecto.Value := EfectoPagarFields.NroEfecto.Value;
                               FechaVencimiento.Value := EfectoPagarFields.FechaVencimiento.Value;
                               FechaLibramiento.Value := EfectoPagarFields.FechaLibramiento.Value;

                               If   not ValueIsEmpty( EfectoPagarFields.FechaPago.Value )
                               then FechaCobro.Value := EfectoPagarFields.FechaPago.Value
                               else If   not ValueIsEmpty( EfectoPagarFields.NroRemesa.Value )
                                    then If   RemesaPago.Obten( EfectoPagarFields.EjercicioRemesa.Value, EfectoPagarFields.NroRemesa.Value, RemesaPagoFields )
                                         then If   not ValueIsEmpty( RemesaPagoFields.FechaPago.Value )
                                              then FechaCobro.Value := RemesaPagoFields.FechaPago.Value;

                               Propietario.Value := EfectoPagarFields.SubcuentaProveedor.Value;
                               Nombre.Value := Cuenta.Descripcion( EfectoPagarFields.SubcuentaProveedor.Value, True, True );
                               Entidad.Value := EfectoPagarFields.SubcuentaEntidad.Value;
                               Descripcion.Value := Cuenta.Descripcion( EfectoPagarFields.SubcuentaEntidad.Value, True, True );
                               Concepto.Value := EfectoPagarFields.Concepto.Value;
                               Importe.Value := EfectoPagarFields.Importe.Value;
                               ImporteCobrado.Value := EfectoPagarFields.ImportePagado.Value;
                               CodigoFormaCobro.Value := EfectoPagarFields.FormaDePago.Value;
                               DescripcionFormaCobro.Value := FormaPagoFields.Descripcion.Value;

                               If   DataAgruparEntidad.Value
                               then CodigoGrupo.Value := Entidad.Value
                               else If   DataAgruparProveedor.Value
                                    then CodigoGrupo.Value := Propietario.Value;

                               DescripcionGrupo.Value := Cuenta.Descripcion( CodigoGrupo.Value, False, False );

                               RelacionEfectosTable.Post;

                               end;

                        end;
                   end;
              end;
         Next;
         end;

       end;

     ApplicationContainer.EndProgression;

end;

procedure TRptEcpForm.FormManagerOkButton;
begin
     Report.Launch;
end;

end.
