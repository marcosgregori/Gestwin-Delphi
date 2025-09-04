
unit l_lrp;

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
  cxLabel, cxGroupBox, AppContainer, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator, cxDBData, EditSelector,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, dxDateRanges, dxScrollbarAnnotations;


type
    TRptLrpForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    AsientoQuery: TnxeQuery;
    ApunteTable: TnxeTable;
    SerieInicialCtrl: TcxDBTextEdit;
    SerieFinalCtrl: TcxDBTextEdit;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    SoloTablaCtrl: TcxDBCheckBox;
    SerieRangeBox: TgxRangeBox;
    gxRangeBox1: TgxRangeBox;
    Data: TgxMemData;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataSerieInicial: TWideStringField;
    DataSerieFinal: TWideStringField;
    DataSoloTablaResumen: TBooleanField;
    Label6: TcxLabel;
    Label4: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    GridViewRepository: TcxGridViewRepository;
    SeriesFacturacionTableView: TcxGridDBTableView;
    SeriesFacturacionTableViewCodigo: TcxGridDBColumn;
    SeriesFacturacionTableViewDescripcion: TcxGridDBColumn;
    SeriesFacturacionDataSource: TDataSource;
    SeriesFacturacionTable: TnxeTable;
    SeriesFacturacionTableNroRegistro: TSmallintField;
    SeriesFacturacionTableCodigo: TStringField;
    SeriesFacturacionTableDescripcion: TStringField;
    EditSelector: TgxEditSelector;
    Label7: TcxLabel;
    Label9: TcxLabel;
    RelacionTable: TnxMemTable;
    RelacionTableFechaAplicacion: TDateField;
    RelacionTableTipo: TSmallintField;
    RelacionTablePropietario: TWideStringField;
    SumasTable: TnxMemTable;
    SumasTableFechaAplicacion: TDateField;
    SumasTableTipo: TSmallintField;
    SumasTableBaseImponible: TBCDField;
    SumasTableRetencion: TBCDField;
    SumasTableImporte: TBCDField;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure SerieCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SeriesFacturacionTableViewCodigoPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    private

      AsientoFields : TAsientoFields;
      ApunteFields : TApunteFields;
      ClienteFields : TClienteFields;
      TiposRetencionFields : TTiposIVAFields;
      SerieFacturacionFields : TSerieFacturacionFields;

      RelacionRetencionesTable : TnxeTable;
      RelacionRetencionesFields : TRelacionRetencionesFields;

      SumaImporteTotal : Decimal;
      
    end;

var RptLrpForm : TRptLrpForm = nil;

procedure LibroRetencionesPracticadas;


implementation

uses   Variants,
       DateUtils,
       DataAccess,
       SessionDataAccess,
       EnterpriseDataAccess,

       Gdm10Dm,

       dmi_iva,
       dmi_ast,

       dm_pga,
       dm_tas,
       dm_sub,
       dm_iva,
       dm_cli,
       dm_sdf,

       cx_sdf,

       b_msg;

{$R *.DFM}

procedure LibroRetencionesPracticadas;
begin
     CreateReportForm( TrptLrpForm, rptLrpForm );
end;

procedure TRptLrpForm.initializeForm;
begin
     ApunteFields := TApunteFields.Create( ApunteTable );
     ClienteFields := TClienteFields.Create( Self );
     TiposRetencionFields := TTiposIVAFields.Create( Self );
     SerieFacturacionFields := TSerieFacturacionFields.Create( Self );

     DataSerieInicial.Value := '';
     DataSerieFinal.Value := HighStrCode;
     DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
     DataSoloTablaResumen.Value := False;

     EditSelector.EditMode := tesRange;
end;

procedure TRptLrpForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TRptLrpForm.SerieCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
    SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptLrpForm.SeriesFacturacionTableViewCodigoPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error, SerieFacturacionFields );
     If   not Error and SeriesFacturacionTable.Editing
     then SeriesFacturacionTableDescripcion.Value := SerieFacturacionFields.Descripcion.Value;
end;

procedure TRptLrpForm.FormManagerOkButton;

procedure SeleccionaRegistros;

var  FechaAplicacion : TDate;
     TipoImpositivo : SmallInt;
     QueryText : String;

begin
     SumasTable.DeleteRecords;
     RelacionTable.DeleteRecords;

     With AsientoQuery do
       try

         QueryText := 'SELECT * FROM Asiento ' +
                      'WHERE TipoAsiento=' + IntToStr( taFraEmitida ) + ' AND ' +
                      '      Fecha BETWEEN ' + SQLFieldValue( DataFechaInicial ) + ' AND ' + SQLFieldValue( DataFechaFinal ) + ' AND ' +
                      EditSelector.GetSQLSelection( 'Serie' ) +
                      ' ORDER BY Ejercicio, NroAsiento';

         AsientoQuery.SQL.Text := QueryText;
         AsientoQuery.Open;
         AsientoFields := TAsientoFields.Create( AsientoQuery );

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
               then SumaImporteTotal := GetSignedValue( ApunteFields.Debe, ApunteFields.Haber )
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
                       SumasTableRetencion.Value := SumasTableRetencion.Value + GetSignedValue( ApunteFields.Debe, ApunteFields.Haber );
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

                            Cliente.ObtenPorSubcuenta( AsientoFields.Propietario.Value, ClienteFields, True );

                            If   ClienteFields.Nombre.Value=''
                            then RelacionRetencionesFields.Nombre.Value := AsientoFields.Nombre.Value
                            else begin
                                 RelacionRetencionesFields.Nombre.Value := ClienteFields.Nombre.Value;
                                 RelacionRetencionesFields.NIF.Value := ClienteFields.NIF.Value;
                                 end;

                            RelacionRetencionesFields.BaseImponible.Value := ApunteFields.BaseImponible.Value;
                            RelacionRetencionesFields.TipoRetencion.Value := ApunteFields.Tipo.Value;

                            Tasa.TipoRetencion( AsientoFields.Fecha.Value, ApunteFields.Tipo.Value, TiposRetencionFields );

                            RelacionRetencionesFields.Retencion.Value := TiposRetencionFields.Retencion.Value;
                            RelacionRetencionesFields.ImporteRetencion.Value := GetSignedValue( ApunteFields.Debe, ApunteFields.Haber );
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
		 
     finally
       AsientoQuery.Close;
       ApplicationContainer.EndProgression;
       end;

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

          SetValue( RsTextoSeleccionSeries, EditSelector.GetReportSelectionText );

          Start;
        except on E : Exception do Cancel( E );
          end;

end;

end.
