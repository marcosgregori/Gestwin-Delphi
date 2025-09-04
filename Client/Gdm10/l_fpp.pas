
unit l_fpp;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  LibUtils,

  Mask,
  ComCtrls,

  Menus, cxLookAndFeelPainters, cxButtons, nxdb, DataManager, DB,
  dxmdaset, ReportManager, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxDBEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,

  Gim10Fields, cxCheckBox, cxGraphics, cxLookAndFeels, dxSkinsCore,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox, AppContainer;


type
    TrptFppForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    ProveedorInicialCtrl: TcxDBTextEdit;
    ProveedorFinalCtrl: TcxDBTextEdit;
    Report: TgxReportManager;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataProveedorInicial: TWideStringField;
    DataProveedorFinal: TWideStringField;
    ApunteTable: TnxeTable;
    AsientoTable: TnxeTable;
    EfectoPagarTable: TnxeTable;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    cxDBCheckBox1: TcxDBCheckBox;
    DataMostrarEfectos: TBooleanField;
    Label8: TcxLabel;
    Label1: TcxLabel;
    Label11: TcxLabel;
    Label3: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DataIncluirAbonos: TBooleanField;
    cxDBCheckBox2: TcxDBCheckBox;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure SubcuentaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

    public

      EfectoPagarFields : TEfectoPagarFields;
      AsientoFields : TAsientoFields;
      ApunteFields : TApunteFields;

      RelacionFacturasTable : TnxeTable;
      RelacionFacturasFields : TRelacionFacturasFields;

    end;

var
  rptFppForm : TrptFppForm = nil;

procedure FacturasPendientesPago;


implementation

uses   EnterpriseDataAccess,

       Gdm10Dm,

       dmi_ast,

       b_msg,

       dm_sub,
       dm_ast,
       dm_ecp,
       dm_fpa,

       cx_sub;

{$R *.DFM}

procedure FacturasPendientesPago;
begin
     CreateReportForm( TrptFppForm, rptFppForm );
end;

procedure TrptFppForm.initializeForm;
begin
     EfectoPagarFields := TEfectoPagarFields.Create( EfectoPagarTable );
     AsientoFields := TAsientoFields.Create( AsientoTable );
     ApunteFields := TApunteFields.Create( ApunteTable );

     DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
     DataProveedorInicial.Value := '400000000';
     DataProveedorFinal.Value := '4' + HighStrCode;
     DataMostrarEfectos.Value := True;
end;

procedure TrptFppForm.SubcuentaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TrptFppForm.FormManagerOkButton;

procedure SeleccionaRegistros;

var  ImporteFactura,
     Pendiente : Decimal;
      
begin

     With AsientoTable do
       begin

       SetRange( [ taFraRecibida, DataFechaInicial.Value ], [ taFraRecibida, DataFechaFinal.Value ] );

       ApplicationContainer.StartProgression( RecordCount );

       First;
       While not Eof  do
         begin

         ApplicationContainer.ShowProgression;

         If   ( AsientoFields.Propietario.Value>=DataProveedorInicial.Value ) and
              ( AsientoFields.Propietario.Value<=DataProveedorFinal.Value   )
         then If   ApunteTable.FindKey( [ AsientoFields.Ejercicio.Value, AsientoFields.NroAsiento.Value, 1 ] )
              then begin

                   ImporteFactura := GetSignedValue( ApunteFields.Debe, ApunteFields.Haber, True );
                   Pendiente := ImporteFactura;
                   
                   With EfectoPagarTable do
                     begin

                     With AsientoFields do
                       SetRange( [ Ejercicio.Value, Propietario.Value, Serie.Value, NroFactura.Value, 0 ],
                                 [ Ejercicio.Value, Propietario.Value, Serie.Value, NroFactura.Value, MaxSmallint ] );
                     First;
                     While not Eof do
                       begin

                       //* 20.07.99 He cambiado la comprobación de la fecha de pago por la llamada a la función pendiente.

                       If   not EfectoPagar.EfectoPendiente( EfectoPagarFields )
                       then If   ValueIsEmpty( EfectoPagarFields.FechaPago.Value )
                            then Pendiente := Pendiente - EfectoPagarFields.Importe.Value  // Está remesado
                            else Pendiente := Pendiente - EfectoPagarFields.ImportePagado.Value;

                       Next;
                       end;

                     If   ( DataIncluirAbonos.Value and ( ImporteFactura<0.01 ) and ( Pendiente<0.01 ) ) or 
                          ( Pendiente>0.01 )
                     then begin

                          First;  // Este First es de EfectoPagarFields. De esta forma dispongo del primer efecto (si existe) en la cabecera

                          With RelacionFacturasFields do
                            begin

                            RelacionFacturasTable.Append;

                            Ejercicio.Value := AsientoFields.Ejercicio.Value;
                            Serie.Value := AsientoFields.Serie.Value;
                            NroFactura.Value:= AsientoFields.NroFactura.Value;
                            NroEfecto.Value := -1;
                            Fecha.Value := AsientoFields.Fecha.Value;
                            Propietario.Value := AsientoFields.Propietario.Value;
                            NombrePropietario.Value := Cuenta.Descripcion( Propietario.Value, True, True );

                            Entidad.Value := EfectoPagarFields.SubcuentaEntidad.Value;
                            NombreEntidad.Value := Cuenta.Descripcion( Entidad.Value, True, True );
                            Concepto.Value := ApunteFields.Concepto.Value;
                            FormaCobro.Value := EfectoPagarFields.FormaDePago.Value;
                            DescripcionFormaCobro.Value := FormaPago.Descripcion( FormaCobro.Value, True );

                            Importe.Value := GetSignedValue( ApunteFields.Debe, ApunteFields.Haber, True );
                            ImportePendiente.Value := Pendiente;

                            RelacionFacturasTable.Post;

                            end;

                          If   DataMostrarEfectos.Value
                          then While not Eof do  // Del First anterior
                                 begin
                                 If   EfectoPagar.EfectoPendiente( EfectoPagarFields )
                                 then With RelacionFacturasFields do
                                        begin

                                        RelacionFacturasTable.Append;

                                        Ejercicio.Value := EfectoPagarFields.Ejercicio.Value;
                                        Serie.Value := EfectoPagarFields.Serie.Value;
                                        NroFactura.Value := EfectoPagarFields.NroFactura.Value;
                                        NroEfecto.Value := EfectoPagarFields.NroEfecto.Value;
                                        Fecha.Value := AsientoFields.Fecha.Value;
                                        FechaVencimiento.Value := EfectoPagarFields.FechaVencimiento.Value;
                                        Propietario.Value := AsientoFields.Propietario.Value;
                                        Entidad.Value := EfectoPagarFields.SubcuentaEntidad.Value;
                                        NombreEntidad.Value := Cuenta.Descripcion( Entidad.Value, True, True );
                                        FormaCobro.Value := EfectoPagarFields.FormaDePago.Value;
                                        DescripcionFormaCobro.Value := FormaPago.Descripcion( FormaCobro.Value, True );

                                        Concepto.Value := EfectoPagarFields.Concepto.Value;
                                        Importe.Value := EfectoPagarFields.Importe.Value;

                                        RelacionFacturasTable.Post;
                                        end;

                                 Next;
                                 end;

                          end;

                     end;

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

         RelacionFacturasTable  := CreateEmptyTable( 'Consulta', DataModule10.GetSQL( 'RelacionFacturas' ) );
         RelacionFacturasFields := TRelacionFacturasFields.Create( RelacionFacturasTable );

         SeleccionaRegistros;
         SetValueFields( Data );
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

procedure TrptFppForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, True, True );
end;

end.
