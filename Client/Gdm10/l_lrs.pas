
unit l_lrs;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  LibUtils,
  Mask,
  ComCtrls,

  dm_sal, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxCheckBox, cxDBEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxControls,
  cxContainer, cxEdit, cxTextEdit, ReportManager, dxmdaset,

  Gim00Fields,
  Gim10Fields, cxGraphics, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters,
  cxLabel, cxGroupBox, AppContainer;


type
    TRptLrsForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    AsientoTable: TnxeTable;
    ApunteTable: TnxeTable;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    SoloTablaCtrl: TcxDBCheckBox;
    gxRangeBox1: TgxRangeBox;
    Data: TgxMemData;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataSoloTablaResumen: TBooleanField;
    RelacionTable: TnxMemTable;
    RelacionTableTipo: TSmallintField;
    RelacionTablePropietario: TWideStringField;
    AgruparCtrl: TcxDBCheckBox;
    DataAgrupar: TBooleanField;
    Label4: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    SumasTable: TnxMemTable;
    SumasTableBaseImponible: TBCDField;
    SumasTableRetencion: TBCDField;
    SumasTableImporte: TBCDField;
    SumasTableFechaAplicacion: TDateField;
    SumasTableTipo: TSmallintField;
    RelacionTableFechaAplicacion: TDateField;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure FechaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

    public

      AsientoFields : TAsientoFields;
      ApunteFields : TApunteFields;
      TiposRetencionFields : TTiposIVAFields;
      ProveedorFields : TProveedorFields;

      RelacionRetencionesTable : TnxeTable;
      RelacionRetencionesFields : TRelacionRetencionesFields;

      SumaImporteTotal : Decimal;
      
    end;

var RptLrsForm : TRptLrsForm = nil;

procedure LibroRetencionesACuenta;


implementation

uses   DateUtils,

       EnterpriseDataAccess,

       Gdm10Dm,

       dmi_iva,
       dmi_ast,

       dm_pga,
       dm_ast,
       dm_tas,
       dm_sub,
       dm_iva,
       dm_pro,

       b_msg;

{$R *.DFM}

procedure LibroRetencionesACuenta;
begin
     CreateReportForm( TrptLrsForm, RptLrsForm );
end;

procedure TRptLrsForm.initializeForm;
begin
     AsientoFields := TAsientoFields.Create( AsientoTable );
     ApunteFields := TApunteFields.Create( ApunteTable );

     TiposRetencionFields := TTiposIVAFields.Create( Self );
     ProveedorFields := TProveedorFields.Create( Self );

     DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
     DataSoloTablaResumen.Value := False;
     DataAgrupar.Value := False;

end;

procedure TRptLrsForm.FechaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error );
end;

procedure TRptLrsForm.FormManagerOkButton;

procedure SeleccionaRegistros;

var   FechaAplicacion : TDate;
      TipoImpositivo : SmallInt;

begin

     SumasTable.DeleteRecords;
     RelacionTable.DeleteRecords;

     With AsientoTable do
       begin

       SetRange( [ taFraRecibida, DataFechaInicial.Value ], [ taFraRecibida, DataFechaFinal.Value ] );

       ApplicationContainer.StartProgression( RecordCount );

       First;
       While not Eof  do
         begin

         ApplicationContainer.ShowProgression;

         With ApunteTable do
           begin

           With AsientoFields do
             SetRange( [ Ejercicio.Value, NroAsiento.Value, 1 ], [ Ejercicio.Value, NroAsiento.Value, MaxSmallint ] );

           First;
           While not Eof do
             begin

             If   ApunteFields.NroApunte.Value=1
             then SumaImporteTotal := GetSignedValue( ApunteFields.Debe, ApunteFields.Haber, True )
             else If   ApunteFields.TipoApunte.Value=tapRetencion
                  then begin

                       FechaAplicacion := Tasa.UltimaFechaAplicacion( AsientoFields.Fecha.Value, { Retencion } True );
                       TipoImpositivo := ApunteFields.Tipo.Value;

                       If   SumasTable.FindKey( [ FechaAplicacion, TipoImpositivo ] )
                       then SumasTable.Edit
                       else begin
                            SumasTable.Append;
                            SumasTableFechaAplicacion.Value := FechaAplicacion;
                            SumasTableTipo.Value := TipoImpositivo;
                            end;

                       SumasTableBaseImponible.Value := SumasTableBaseImponible.Value + ApunteFields.BaseImponible.Value;
                       SumasTableRetencion.Value := SumasTableRetencion.Value + GetSignedValue( ApunteFields.Debe, ApunteFields.Haber, True );
                       SumasTableImporte.Value := SumasTableImporte.Value + SumaImporteTotal;

                       SumasTable.Post;

                       If   not DataSoloTablaResumen.Value
                       then begin

                            RelacionRetencionesTable.Append;

                            RelacionRetencionesFields.TipoRegistro.Value := 0;  // Detalle
                            RelacionRetencionesFields.Fecha.Value := AsientoFields.Fecha.Value;
                            RelacionRetencionesFields.Serie.Value := AsientoFields.Serie.Value;
                            RelacionRetencionesFields.NroDocumento.Value := AsientoFields.NroFactura.Value;
                            RelacionRetencionesFields.Propietario.Value := AsientoFields.Propietario.Value;

                            Proveedor.ObtenPorSubcuenta( AsientoFields.Propietario.Value, ProveedorFields, True );

                            If   ProveedorFields.Nombre.Value=''
                            then RelacionRetencionesFields.Nombre.Value := AsientoFields.Nombre.Value
                            else begin
                                 RelacionRetencionesFields.Nombre.Value := ProveedorFields.Nombre.Value;
                                 RelacionRetencionesFields.NIF.Value := ProveedorFields.NIF.Value;
                                 end;

                            RelacionRetencionesFields.BaseImponible.Value := ApunteFields.BaseImponible.Value;
                            RelacionRetencionesFields.TipoRetencion.Value := ApunteFields.Tipo.Value;

                            Tasa.TipoRetencion( AsientoFields.FechaDocumento.Value, ApunteFields.Tipo.Value, TiposRetencionFields );

                            RelacionRetencionesFields.Retencion.Value := TiposRetencionFields.Retencion.Value;
                            RelacionRetencionesFields.ImporteRetencion.Value := GetSignedValue( ApunteFields.Debe, ApunteFields.Haber, True );
                            RelacionRetencionesFields.ImporteFactura.Value := SumaImporteTotal;

                            RelacionRetencionesTable.Post;

                            end;

                       If   not RelacionTable.FindKey( [ FechaAplicacion, ApunteFields.Tipo.Value, AsientoFields.Propietario.Value ] )
                       then begin

                            RelacionTable.Append;

                            RelacionTableFechaAplicacion.Value := FechaAplicacion;
                            RelacionTableTipo.Value := ApunteFields.Tipo.Value;
                            RelacionTablePropietario.Value := AsientoFields.Propietario.Value;

                            RelacionTable.Post;
                            end;

                         end;

             Next;
             end;

           end;

         Next;
         end;

       SumasTable.First;
       While not SumasTable.Eof do
         begin

         If   SumasTableBaseImponible.Value<>0.0
         then With RelacionRetencionesFields do
                  begin

                  RelacionRetencionesTable.Append;

                  Tasa.TipoRetencion( SumasTableFechaAplicacion.Value, SumasTableTipo.Value, TiposRetencionFields );

                  TipoRegistro.Value := 1;    // Resumen
                  Nombre.Value := TiposRetencionFields.Descripcion.Value;
                  BaseImponible.Value := SumasTableBaseImponible.Value;
                  TipoRetencion.Value := SumasTableTipo.Value;
                  Retencion.Value := TiposRetencionFields.Retencion.Value;
                  ImporteRetencion.Value := SumasTableRetencion.Value;
                  ImporteFactura.Value := SumasTableImporte.Value;

                  With RelacionTable do
                    begin
                    SetRange( [ SumasTableFechaAplicacion.Value, SumasTableTipo.Value, '' ],
                              [ SumasTableFechaAplicacion.Value, SumasTableTipo.Value, HighStrCode ] );
                    Retenedores.Value := RecordCount;
                    end;

                  RelacionRetencionesTable.Post;

                  end;

         SumasTable.Next;
         end;

       end;

     ApplicationContainer.EndProgression;

end;

begin
     Enabled := False;

     With Report do
       try

          Load;

          RelacionRetencionesTable := CreateEmptyTable( 'RelacionRetenciones', DataModule10.GetSQL( 'RelacionRetenciones' ) );
          RelacionRetencionesFields := TRelacionRetencionesFields.Create( RelacionRetencionesTable );

          // Le asigno la misma tabla a la página que muestra el resumen

          AssignTable( 'ResumenRelacionRetenciones', RelacionRetencionesTable );

          SeleccionaRegistros;

          SetValueFields( Data );
          Start;
        except on E : Exception do Cancel( E );
          end;

end;

end.
