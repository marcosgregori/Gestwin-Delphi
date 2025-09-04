unit l_cpe;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,
     ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb,
     dxmdaset, ReportManager, cxMaskEdit, cxDropDownEdit,
     cxCalendar, cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit,

     cxCheckBox, cxStyles, cxCustomData, cxGraphics, cxFilter,
     cxData, cxDataStorage, cxDBData, cxGridCustomTableView, cxGridTableView,
     cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid,

     dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
     cxLookAndFeels, f_smv, cxLabel, cxGroupBox,

     LibUtils,
     AppContainer,
     DataManager,
     Spring,

     Gim30Fields,

     dmi_mov, dxUIAClasses;


type
    TTipoInsercionRegistro = ( irCabecera, irLinea, irPie );
    TProcesaRegistroCargaEvent = function( TipoInsercion : TTipoInsercionRegistro; CodTransportista : String = ''; LineaMovimientoOrigenFields : TLineaMovimientoFields = nil ) : Decimal of object;

    TRptCpeForm = class(TgxForm)
    FormManager: TgxFormManager;
    LineaMovimientoTable: TnxeTable;
    MovimientoTable: TnxeTable;
    DataPanel: TgxEditPanel;
    ArticuloInicialCtrl: TcxDBTextEdit;
    ArticuloFinalCtrl: TcxDBTextEdit;
    AlmacenInicialCtrl: TcxDBTextEdit;
    AlmacenFinalCtrl: TcxDBTextEdit;
    Report: TgxReportManager;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataClienteInicial: TWideStringField;
    DataClienteFinal: TWideStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataArticuloInicial: TWideStringField;
    DataArticuloFinal: TWideStringField;
    DataAlmacenInicial: TWideStringField;
    DataAlmacenFinal: TWideStringField;
    gxRangeBox3: TgxRangeBox;
    gxRangeBox4: TgxRangeBox;
    DataFechaEntrega: TBooleanField;
    DataDesglosar: TBooleanField;
    TransportistaCtrl: TcxDBTextEdit;
    ActualizarCtrl: TcxDBCheckBox;
    DataTransportista: TWideStringField;
    DataActualizar: TBooleanField;
    SmvFrame: TSmvFrame;
    Label1: TcxLabel;
    Label5: TcxLabel;
    Label4: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    Label9: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label6: TcxLabel;
    DataCrearHojaCarga: TBooleanField;
    CrearHojaCargaCtrl: TcxDBCheckBox;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxGroupBox1: TcxGroupBox;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure AlmacenCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure AlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TransportistaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TransportistaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CrearHojaCargaCtrlPropertiesChange(Sender: TObject);

    private
      FOnProcesaRegistroCarga : Event<TProcesaRegistroCargaEvent>;

    protected

    public
      MovimientoFields : TMovimientoFields;
      LineaMovimientoFields : TLineaMovimientoFields;
      CarteraArticulosTable : TnxeTable;
      CarteraArticulosFields : TCarteraArticulosFields;
      ArticuloFields : TArticuloFields;
      Pendiente : Decimal;
      TextoDocumentosIncluidos : String;

      class var TipoMovimiento : TTipoMovimiento;

      property OnProcesaRegistroCarga : Event<TProcesaRegistroCargaEvent> read FOnProcesaRegistroCarga write FOnProcesaRegistroCarga;
    end;

var  RptCpeForm: TRptCpeForm = nil;

procedure ListadoCargaEnvios( TipoMovimiento : TTipoMovimiento );


implementation

uses   Variants,
       SysUtils,
       DataAccess,
       EnterpriseDataAccess,
       AppManager,

       Gdm00Dm,
       Gdm30Dm,
       Gim00Fields,
       Gim10Fields,

       dm_mov,
       dm_sto,
       dm_cls,
       dm_cli,
       dm_art,
       dm_fdv,
       dm_alm,
       dm_tra,

       b_msg,

       cx_art,
       cx_cli,
       cx_alm,
       cx_mve,
       cx_sdf,
       cx_tra;

{$R *.DFM}

resourceString

       RsMsg3 = 'No ha indicado ningún documento.';
       RsMsg4 = '<El del documento>';
       RsMsg5 = 'El transportista del albarán nº %s %d no ha podido ser modificado.';
       RsMsg6 = 'Es probable que el documento esté siendo editado por otro usuario.'#13'Si desea reasignar el transportista de este albarán debe repetir el proceso o modificarlo manualmente.';

procedure ListadoCargaEnvios( TipoMovimiento : TTipoMovimiento );
begin
     TRptCpeForm.TipoMovimiento := TipoMovimiento;
     CreateReportForm( TRptCpeForm, RptCpeForm );
end;

procedure TRptCpeForm.InitializeForm;
begin

     ID := idRptCpeForm;

     Caption := Format( Caption, [ Movimiento.TextoTipoMovimiento( TipoMovimiento ) ] );

     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );
     ArticuloFields := TArticuloFields.Create( Self );

     With DataModule00.DmEmpresaFields do
       begin
       SmvFrame.GridViewSerie.Visible := Movimiento.SeriesEnDocumentosVenta( TipoMovimiento );
       AlmacenInicialCtrl.Enabled := Stock_MultiAlmacen.Value;
       AlmacenFinalCtrl.Enabled := Stock_MultiAlmacen.Value;
       end;

     TransportistaCtrl.Enabled := TipoMovimiento=tmVenta;
     ActualizarCtrl.Enabled := TipoMovimiento=tmVenta;

     DataArticuloFinal.Value := HighStrCode;
     DataAlmacenFinal.Value := HighStrCode;

     With SmvFrame do
       begin
       TipoMovimiento := Self.TipoMovimiento;
       GeneraRelacion;
       end;
end;

procedure TRptCpeForm.ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TRptCpeForm.ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptCpeForm.CrearHojaCargaCtrlPropertiesChange(Sender: TObject);
begin
     TransportistaCtrl.Properties.Required := CrearHojaCargaCtrl.Checked;
end;

procedure TRptCpeForm.TransportistaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTransportistas( Sender );
end;

procedure TRptCpeForm.TransportistaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue)
     then TransportistaCtrl.Description := RsMsg4
     else Transportista.Valida( Sender, DisplayValue, ErrorText, Error );
     ActualizarCtrl.Enabled := not Error and not ValueIsEmpty( DisplayValue);
     If   TransportistaCtrl.Editing
     then ResetTab;
end;

procedure TRptCpeForm.FormManagerOkButton;


procedure SeleccionaCarga;

var   Insertar : Boolean;
      CantidadCargadaLinea,
      CantidadACargarLinea : Decimal;

begin

     try

       EnterpriseDataModule.StartTransaction( [ MovimientoTable ] );   // Por la actualización de transportistas

       With SmvFrame, RelacionDocumentosTable do
         try

           DisableControls;

           OnProcesaRegistroCarga.Invoke( irCabecera, DataTransportista.Value );    // Creación de la cabecera de la hoja de carga

           First;
           While not Eof do
             begin

             If   MovimientoTable.FindKey( [ TipoMovimiento, RelacionDocumentosTableEjercicio.Value, RelacionDocumentosTableSerie.Value, RelacionDocumentosTableNroDocumento.Value ] )
             then With LineaMovimientoTable do
                    begin

                    If   TextoDocumentosIncluidos<>''
                    then TextoDocumentosIncluidos := TextoDocumentosIncluidos + ', ';
                    If   ( RelacionDocumentosTableSerie.Value<>'' ) and Movimiento.SeriesEnDocumentosVenta( TipoMovimiento )
                    then StrAdd( TextoDocumentosIncluidos, RelacionDocumentosTableSerie.Value + '-' );
                    StrAdd( TextoDocumentosIncluidos, IntToStr( RelacionDocumentosTableNroDocumento.Value ) );
                    If   EjercicioActual( MovimientoFields.Ejercicio.Value )
                    then StrAdd( TextoDocumentosIncluidos, ' (' + IntToStr( RelacionDocumentosTableEjercicio.Value ) + ')' );

                    With MovimientoFields do
                      SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );

                    First;
                    While not Eof do
                      begin

                      With LineaMovimientoFields do
                        If   ( CodigoArticulo.Value<>ArticuloManual ) and
                             ( CodigoArticulo.Value>=DataArticuloInicial.Value ) and
                             ( CodigoArticulo.Value<=DataArticuloFinal.Value ) and
                             ( CodigoAlmacen.Value>=DataAlmacenInicial.Value ) and
                             ( CodigoAlmacen.Value<=DataAlmacenFinal.Value ) and
                             ( Cantidad.Value<>0.0 )
                        then begin

                             If   OnProcesaRegistroCarga.CanInvoke
                             then CantidadCargadaLinea := OnProcesaRegistroCarga.Invoke( irLinea, '', LineaMovimientoFields )
                             else CantidadCargadaLinea := 0.0;

                             If   TipoMovimiento=tmVenta
                             then CantidadACargarLinea := -Cantidad.Value - CantidadCargadaLinea
                             else CantidadACargarLinea := Cantidad.Value - CantidadProcesada.Value - CantidadCargadaLinea;

                             If   CantidadACargarLinea>0.0
                             then begin

                                  Articulo.Obten( CodigoArticulo.Value, ArticuloFields, True );

                                  // (CarteraArticulosTable) CodigoAlmacen;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;Tipo';

                                  Insertar := not ( ( Descripcion.Value=ArticuloFields.Descripcion.Value ) and
                                                    CarteraArticulosTable.FindKey( [ CodigoAlmacen.Value, CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, 0 ] ) );

                                  If   Insertar
                                  then CarteraArticulosTable.Append
                                  else CarteraArticulosTable.Edit;

                                  If   Descripcion.Value=ArticuloFields.Descripcion.Value
                                  then CarteraArticulosFields.Tipo.Value := 0   // registro normal
                                  else begin
                                       CarteraArticulosFields.Tipo.Value := 1;  // registro especial
                                       CarteraArticulosFields.Ejercicio.Value := MovimientoFields.Ejercicio.Value;
                                       CarteraArticulosFields.Serie.Value := MovimientoFields.Serie.Value;
                                       CarteraArticulosFields.NroDocumento.Value := MovimientoFields.NroDocumento.Value;
                                       // CarteraArticulosFields.NroRegistro.Value := NroRegistro.Value;
                                       end;

                                  If   Insertar
                                  then begin
                                       CarteraArticulosFields.CodigoAlmacen.Value := CodigoAlmacen.Value;
                                       CarteraArticulosFields.NombreAlmacen.Value := Almacen.Descripcion( CodigoAlmacen.Value, False );
                                       CarteraArticulosFields.CodigoArticulo.Value := CodigoArticulo.Value;
                                       CarteraArticulosFields.CodigoClaseA.Value := CodigoClaseA.Value;
                                       CarteraArticulosFields.CodigoClaseB.Value := CodigoClaseB.Value;
                                       CarteraArticulosFields.CodigoClaseC.Value := CodigoClaseC.Value;
                                       CarteraArticulosFields.CodigoFamilia.Value := ArticuloFields.Familia.Value;
                                       CarteraArticulosFields.NroCajas.Value := NroCajas.Value;
                                       If   TipoMovimiento=tmVenta
                                       then CarteraArticulosFields.Cantidad.Value := -Cantidad.Value
                                       else CarteraArticulosFields.Cantidad.Value := Cantidad.Value - CantidadProcesada.Value;
                                       CarteraArticulosFields.Descripcion.Value := Descripcion.Value;
                                       end
                                  else begin
                                       CarteraArticulosFields.NroCajas.Value := CarteraArticulosFields.NroCajas.Value + NroCajas.Value;
                                       If   TipoMovimiento=tmVenta
                                       then CarteraArticulosFields.Cantidad.Value := CarteraArticulosFields.Cantidad.Value - Cantidad.Value
                                       else CarteraArticulosFields.Cantidad.Value := CarteraArticulosFields.Cantidad.Value + Cantidad.Value - CantidadProcesada.Value;
                                       end;

                                  CarteraArticulosTable.Post;

                                  end;

                        end;

                      Next;
                      end;

                    If   DataActualizar.Value
                    then With MovimientoTable do
                           try
                             FailOnError := False;
                               try
                               Edit;
                               MovimientoFields.CodigoTransportista.Value := DataTransportista.Value;
                               Post;
                             except
                               With MovimientoFields do
                                 ShowNotification( ntWarning, Format( RsMsg5, [ Serie.Value, NroDocumento.Value ] ), RsMsg6 );
                               end;
                           finally
                             FailOnError := True;
                             Cancel;
                             end;

               end;

             ApplicationContainer.ShowProgression;

             Next;
             end;

           OnProcesaRegistroCarga.Invoke( irPie );

           TextoDocumentosIncluidos := TextoDocumentosIncluidos + '.';

           EnterpriseDataModule.Commit;

         finally
           EnableControls;
           end;

     except
       EnterpriseDataModule.RollBack;
       raise;
       end;

end;

procedure SeleccionaRegistros;
begin

       try

         ApplicationContainer.StartProgression( SmvFrame.RelacionDocumentosTable.RecordCount * 2 );

         With SmvFrame.RelacionDocumentosTable do
           begin
           DisableControls;
           IndexFieldNames := 'Ejercicio;Serie;NroDocumento';
           end;

         TextoDocumentosIncluidos := '';

         SeleccionaCarga;

         With CarteraArticulosTable do
           begin

           First;
           While not Eof do
             begin

             With CarteraArticulosFields do
               begin

               If   Articulo.Obten( CodigoArticulo.Value, ArticuloFields )
               then begin
                    Edit;
                    Bultos.Value := ArticuloFields.Bultos.Value * Cantidad.Value;
                    Kilos.Value := ArticuloFields.Kilos.Value * Cantidad.Value;
                    Volumen.Value := ArticuloFields.Volumen.Value * Cantidad.Value;
                    Post;
                    end;

               ApplicationContainer.ShowProgression;

               end;

             Next;
             end;

           end;

       finally
         ApplicationContainer.EndProgression;
         With SmvFrame.RelacionDocumentosTable do
           begin
           IndexFieldNames := 'NroRegistro';
           EnableControls;
           end;
         end;
end;

begin

     If   SmvFrame.RelacionDocumentosTable.RecordCount=0
     then begin
          ShowNotification( ntStop, RsMsg3 );
          Abort;
          end;

     Enabled := False;

     With Report do
       begin
       try

         Load;

         CarteraArticulosTable := Report.CreateEmptyTable( 'CarteraArticulos', DataModule30.GetSQL( 'CarteraArticulos' ) );
         CarteraArticulosFields := TCarteraArticulosFields.Create( CarteraArticulosTable );

         CarteraArticulosTable.IndexFieldNames := 'CodigoAlmacen;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;Tipo';

         SeleccionaRegistros;

         Clase.SetReportTitles( Report, 4 );
         FacturaVentas.FijaDecimalesInforme( Report );

         SetValueFields( Data );
         SetValue( 'TextoDocumentosIncluidos', TextoDocumentosIncluidos );

         Start;

       except on E : Exception do Cancel( E );
         end;

       end;

end;

procedure TRptCpeForm.AlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TRptCpeForm.AlmacenCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scVentas, Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptCpeForm.ArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scVentas, False, Sender );
end;

procedure TRptCpeForm.ArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

end.
