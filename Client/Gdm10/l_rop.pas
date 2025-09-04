unit l_rop;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,

  Menus, cxLookAndFeelPainters, cxButtons, cxGraphics,
  cxCheckBox, cxDBEdit, cxDropDownEdit, cxCurrencyEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxCalendar, DB, nxdb,
  DataManager, ReportManager, dxmdaset,

  Gim00Fields,
  Gim10Fields, cxIndexedComboBox, dxSkinsCore, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox, dxUIAClasses;

type
    TRptRopForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    FormManager: TgxFormManager;
    ImporteMinimoCtrl: TcxDBCurrencyEdit;
    AsientoTable: TnxeTable;
    ApunteTable: TnxeTable;
    TipoCtrl: TcxDBIndexedComboBox;
    gxRangeBox2: TgxRangeBox;
    Data: TgxMemData;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataImporteMinimo: TBCDField;
    DataTipoDocumento: TSmallintField;
    CartaReport: TgxReportManager;
    DataOrdenarPorNIF: TBooleanField;
    OrdenarPorNIFCtrl: TcxDBCheckBox;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label5: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    AgruparPorNIFCtrl: TcxDBCheckBox;
    DataAgruparPorNIF: TBooleanField;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure AgruparPorNIFCtrlPropertiesChange(Sender: TObject);
    private

    public

      AsientoFields : TAsientoFields;
      ApunteFields : TApunteFields;
      TiposIVAFields : TTiposIVAFields;
      ProveedorFields : TProveedorFields;

      RptDocumentoTable : TnxeTable;
      RptDocumentoFields : TDocumentoFields;

      procedure SeleccionaRegistros;
    end;

var  RptRopForm: TRptRopForm = nil;

procedure RelacionOperacionesProveedores;

implementation

uses   Files,
       FileCtrl,
       LibUtils,
       DateUtils,

       EnterpriseDataAccess,

       Gdm10Dm,

       dmi_iva,
       dmi_ast,

       dm_ast,
       dm_pro,
       dm_iex,
       dm_sub,
       dm_prv,
       dm_ban,
       dm_pai,
       dm_iva,
       dm_fac,

       b_pro,
       b_msg,
       b_dir;

{$R *.DFM}

resourceString
       RsMsg1 = '*** Sin ficha de proveedor asociada ***';

procedure RelacionOperacionesProveedores;
begin
     CreateReportForm( TRptRopForm, RptRopForm );
end;

procedure TRptRopForm.initializeForm;
begin
     AsientoFields := TAsientoFields.Create( AsientoTable );
     ApunteFields := TApunteFields.Create( ApunteTable );

     TiposIVAFields := TTiposIVAFields.Create( Self );
     ProveedorFields := TProveedorFields.Create( Self );

     SetEditControlDecimals( ImporteMinimoCtrl );

     DataFechaInicial.Value := ApplicationContainer.FirstDayOfYearDate;
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;
     DataImporteMinimo.Value := 3005.06;
     DataTipoDocumento.Value := 0;

end;

procedure TRptRopForm.SeleccionaRegistros;

var  CodigoAgrupacion : String;
     PropietarioConFicha : Boolean;
     ImporteFactura : Decimal;
     IndiceTrimestre,
     NroTrimestre : SmallInt;
     ImporteTrimestre : array[ 1..4 ] of Decimal;

begin

     RptDocumentoTable.IndexFieldNames := 'CodigoAgrupacion';

     With AsientoTable do
       begin

       SetRange( [ taFraRecibida, DataFechaInicial.Value ], [ taFraRecibida, DataFechaFinal.Value ] );

       ApplicationContainer.StartProgression( RecordCount );
       try

         First;
         While not Eof  do
           begin

           ImporteFactura := 0.0;
           NroTrimestre := ( ( MonthOf( AsientoFields.Fecha.Value ) - 1 ) div 3 ) + 1;

           ApplicationContainer.ShowProgression;
           With ApunteTable do
             begin

             SetRange( [ AsientoFields.Ejercicio.Value, AsientoFields.NroAsiento.Value, 1 ],
                       [ AsientoFields.Ejercicio.Value, AsientoFields.NroAsiento.Value, MaxSmallint ] );

             First;
             While not Eof do
               begin

               If   ApunteFields.NroApunte.Value=1  // El apunte del propietario
               then begin

                    If   Factura.ObtenCodigoAgrupacionAcreedor( AsientoFields.Origen.Value, ApunteFields.Subcuenta.Value, DataAgruparPorNIF.Value, PropietarioConFicha, CodigoAgrupacion, ProveedorFields )
                    then If   RptDocumentoTable.FindKey( [ CodigoAgrupacion ] )
                         then RptDocumentoTable.Edit
                         else begin

                              //* 17.03.2000 Excluidos del informe los proveedores con retención

                              If   not PropietarioConFicha or ( PropietarioConFicha and ( ProveedorFields.CodigoPais.Value=CodigoEspaña ) and ( ProveedorFields.Factura_TipoRet.Value=0 ) )
                              then begin

                                   RptDocumentoTable.Append;

                                   RptDocumentoFields.CodigoAgrupacion.Value := CodigoAgrupacion;
                                   RptDocumentoFields.CodigoSubcuenta.Value := ApunteFields.Subcuenta.Value;
                                   // Los pongo a cero para evitar que contengan nulos
                                   RptDocumentoFields.Importe.Value := 0.0;
                                   For IndiceTrimestre := 1 to 4 do
                                     RptDocumentoFields.ImporteTrimestre[ IndiceTrimestre ].Value := 0.0;
                                   RptDocumentoFields.ImporteEfectivo.Value := Asiento.ImporteCobrosEfectivo( RptDocumentoFields.CodigoSubcuenta.Value, DataFechaInicial.Value, DataFechaFinal.Value, True );

                                   If   PropietarioConFicha
                                   then begin
                                        RptDocumentoFields.Codigo.Value := ProveedorFields.Codigo.Value;
                                        RptDocumentoFields.Nombre.Value := ProveedorFields.Nombre.Value;
                                        RptDocumentoFields.Domicilio.Value := ProveedorFields.Domicilio.Value;
                                        RptDocumentoFields.Localidad.Value := ProveedorFields.Localidad.Value;
                                        RptDocumentoFields.CodigoPostal.Value := ProveedorFields.CodigoProvincia.Value + ProveedorFields.CodigoPostal.Value;
                                        RptDocumentoFields.Provincia.Value := dm_prv.provincia.descripcion( ProveedorFields.CodigoPais.Value, ProveedorFields.CodigoProvincia.Value, True );
                                        RptDocumentoFields.NIF.Value := ProveedorFields.NIF.Value;
                                        end
                                   else begin
                                        RptDocumentoFields.Nombre.Value := Cuenta.Descripcion( RptDocumentoFields.CodigoSubcuenta.Value, True, False );
                                        RptDocumentoFields.Domicilio.Value := RsMsg1;
                                        end;

                                    If   AsientoFields.Origen.Value=2  // Inversión del sujeto pasivo
                                    then RptDocumentoFields.Nombre.Value := RptDocumentoFields.Nombre.Value + ' (ISP)';

                                    end;
                             end;

                    end
               else If   ApunteFields.TipoApunte.Value=tapManual
                    then begin

                         //* 25.02.2009   Excluyendo los suplidos

                         Tasa.TipoIVA( ApunteFields.Fecha.Value, ApunteFields.Tipo.Value, TiposIVAFields );
                         If   not ( TiposIVAFields.SobreTotal.Value )  // Suplido
                         then DecAdd( ImporteFactura, ApunteFields.ImporteTotal.Value );

                         end;

               Next;
               end;

             end;

           If   RptDocumentoTable.Editing
           then begin
                RptDocumentoFields.Importe.Value := RptDocumentoFields.Importe.Value + ImporteFactura;
                RptDocumentoFields.ImporteTrimestre[ NroTrimestre ].Value := RptDocumentoFields.ImporteTrimestre[ NroTrimestre ].Value + ImporteFactura;
                RptDocumentoTable.Post;
                end;

           Next;
           end;

         // Suprimiendo los registros que no superan el importe minimo

         With RptDocumentoTable do
           begin
           First;
           While not Eof do
             begin
             ApplicationContainer.ShowProgression;
             If   Abs( RptDocumentoFields.Importe.Value )<DataImporteMinimo.Value
             then Delete
             else Next;
             end;
           end;

       finally
          ApplicationContainer.EndProgression;
          end;

       end;

end;

procedure TRptRopForm.AgruparPorNIFCtrlPropertiesChange(Sender: TObject);
begin
     OrdenarPorNIFCtrl.Enabled := not AgruparPorNIFCtrl.Checked;
end;

procedure TRptRopForm.FormManagerOkButton;

var  ActiveReport : TgxReportManager;

begin

     If   DataTipoDocumento.Value=0
     then ActiveReport := Report
     else ActiveReport := CartaReport;

     With ActiveReport do
       try
         Load;
         RptDocumentoTable := CreateEmptyTable( 'Documento', DataModule10.SQLSet );
         RptDocumentoFields := TDocumentoFields.Create( RptDocumentoTable );
         SeleccionaRegistros;

         If   DataOrdenarPorNIF.Value
         then RptDocumentoTable.IndexFieldNames := 'NIF';

         Start;
       except on E : Exception do Cancel( E );
         end;

end;

end.

