
unit b_sac;

interface

uses StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics,

     AppManager,
     AppContainer,
     ComCtrls,

     Menus, cxLookAndFeelPainters, cxButtons, cxControls,
    cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxMaskEdit, cxDropDownEdit,
    cxCalendar, cxPC, DB, nxdb, DataManager, cxStyles, cxCustomData,
    cxGraphics, cxFilter, cxData, cxDataStorage, cxDBData,
    cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
    cxClasses, cxGridCustomView, cxGrid, dxmdaset,

    Gim30Fields, cxCurrencyEdit, cxCheckBox, dxSkinsCore, dxSkinscxPCPainter,
  cxGroupBox, cxLookAndFeels, dxSkinsDefaultPainters, cxLabel, cxNavigator,
  dxDateRanges, AppForms, GridTableViewController,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  dxScrollbarAnnotations, dxUIAClasses;

type

  TBoxSacForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    CodigoProveedorCtrl: TcxDBTextEdit;
    MovimientoTable: TnxeTable;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    RelacionAlbaranesTable: TnxeTable;
    LineaDataSource: TDataSource;
    Data: TgxMemData;
    DataCodigoProveedor: TWideStringField;
    DataSource: TDataSource;
    GridPanel: TcxGroupBox;
    GridTableViewController1: TGridTableViewController;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridViewEjercicio: TcxGridDBColumn;
    GridViewNroDocumento: TcxGridDBColumn;
    GridViewFecha: TcxGridDBColumn;
    GridViewImporte: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    GridViewNroRegistro: TcxGridDBColumn;
    gxRangeBox2: TgxRangeBox;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    GridViewSerie: TcxGridDBColumn;
    DataTodasLasSeries: TBooleanField;
    TodasLasSeriesCtrl: TcxDBCheckBox;
    DataFechaFactura: TDateField;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label6: TcxLabel;
    BottomPanel: TcxGroupBox;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    FechaFacturaCtrl: TcxDBDateEdit;
    Label5: TcxLabel;
    SerieCtrl: TcxDBTextEdit;
    SerieAlbaranCaptionLabel: TcxLabel;
    DataSerie: TStringField;
    TopPanel: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    procedure GridViewNroDocumentoPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewEjercicioPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewDocumentoPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridEnter(Sender: TObject);
    procedure AllCtrlsPropertiesEditValueChanged(Sender: TObject);
    procedure RelacionAlbaranesTableNewRecord(DataSet: TDataSet);
    procedure CodigoProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoProveedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProveedorCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure GridViewSeriePropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    function GridViewFocusFirstAvailableItem(
      Sender: TcxCustomGridTableController): Boolean;
    procedure TodasLasSeriesCtrlPropertiesEditValueChanged(Sender: TObject);
  private

    MovimientoFields : TMovimientoFields;
    RelacionAlbaranesFields : TRelacionAlbaranesFields;

    procedure ActualizaImporteNeto;

  public

    FOnSelected : TSimpleEvent;

    procedure RegeneraLista;
    procedure DoAlbaranSelected( Target : TcxCustomEdit = nil );
    procedure CompruebaDocumento( Ejercicio : SmallInt; Serie : String; NroDocumento : LongInt; var ErrorText : TCaption; var Error : Boolean );
  end;

var BoxSacForm : TBoxSacForm = nil;

procedure SeleccionaAlbaranesCompra( CodigoProveedor : String;
                                     Serie           : String;
                                     OnSelected      : TSimpleEvent );

implementation

{$R *.DFM}

uses   SysUtils,
       LibUtils,

       nxDbBase,
       nxllBde,

       DataAccess,
       EnterpriseDataAccess,

       dmi_mov,

       dm_pro,
       dm_tma,
       dm_mov,
       dm_fdc,

       a_mco,
       a_fdc,
       a_pro,

       b_msg,

       cx_pro,
       cx_apc;

resourceString
      RsMsg1   = 'Este número de albarán no existe.';
      RsMsg2   = 'Utilice la consulta en línea (F4) para visualizar los albaranes pendientes de este proveedor.';
      // RsMsg3   = 'Este albarán no pertenece al proveedor seleccionado.';
      RsMsg4   = 'No ha seleccionado ningún albarán.';
      RsMsg5   = 'Especifique el código del proveedor antes de introducir la relación de albaranes.';
      RsMsg6   = 'Este albarán ya ha sido facturado.';
      RsMsg7   = 'Este albarán ha sido marcado como no facturable.';
      RsMsg8   = 'Este albarán ya ha sido incluído en la relación.';
      RsMsg9   = 'Al menos uno de los albaranes que intenta facturar está siendo modificado por otro usuario.';
      RsMsg10  = 'Si desea seleccionar el/los albaranes bloqueados debe esperar a que sean liberados.';
      RsMsg11  = 'Se ha producido un error al crear la relación de albaranes a facturar.';
      RsMsg12  = 'Puede que alguno de los ficheros de movimientos está deteriorado o que exista un problema con el acceso a los datos.'#13'Identifique y corrija el origen del error y reintente la operación.';
      RsMsg13  = 'Existen dos albaranes con el mismo número de documento .';

procedure SeleccionaAlbaranesCompra( CodigoProveedor : String;
                                     Serie           : String;
                                     OnSelected      : TSimpleEvent );
begin
     If   Assigned( MntMcoForm[ tmCompra ] )
     then begin
          MntMcoForm[ tmCompra ].FormManager.SelectFirstKeyControl;
          Application.ProcessMessages;  // Que se complete antes de seguir
          end;

     CreateEditForm( TBoxSacForm, BoxSacForm, [ CodigoProveedor, Serie ] );
     If   Assigned( BoxSacForm )
     then BoxSacForm.FOnSelected := OnSelected;
end;

procedure TBoxSacForm.FormManagerOkButton;
begin
     If   RelacionAlbaranesTable.RecordCount=0
     then begin
          ShowNotification( ntStop, RsMsg4, '' );
          Enabled := True;
          FormManager.SelectFirstDataControl;
          Abort;
          end;
     If   Assigned( FOnSelected )
     then FOnSelected;
end;

procedure TBoxSacForm.AllCtrlsPropertiesEditValueChanged(Sender: TObject);
begin
     If   ( Sender as TcxCustomEdit ).Editing
     then  RegeneraLista;
end;

procedure TBoxSacForm.FormManagerInitializeForm;
begin
     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     RelacionAlbaranesFields := TRelacionAlbaranesFields.Create( RelacionAlbaranesTable );

     DataCodigoProveedor.Value := FormValues[ 0 ];
     DataFechaInicial.Value := ApplicationContainer.FirstDayOfYearDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
     DataFechaFactura.Value := ApplicationContainer.TodayDate;
     DataTodasLasSeries.Value := True;

     SetColumnDecimals( GridViewImporte );

     RegeneraLista;
end;

procedure TBoxSacForm.RegeneraLista;

var  NroRegistroActual : Integer;

begin

     RelacionAlbaranesTable.DeleteRecords;

     If   not ValueIsEmpty( DataCodigoProveedor.Value )
     then With MovimientoTable do
            begin

            IndexFieldNames := 'TipoMovimiento;Propietario;Fecha';
            SetRange( [ tmCompra, DataCodigoProveedor.Value, DataFechaInicial.Value ], [ tmCompra, DataCodigoProveedor.Value, DataFechaFinal.Value ] );

            try

              ShowErrorDialog := False;
              RelacionAlbaranesTable.DisableControls;
              try

                NroRegistroActual := 1;
                First;
                While not Eof do
                  begin
                  If   not MovimientoFields.NoFacturar.Value and
                       not MovimientoFields.Facturado.Value and
                           ( DataTodasLasSeries.Value or ( MovimientoFields.Serie.Value=DataSerie.Value ) )
                  then With RelacionAlbaranesTable, RelacionAlbaranesFields do
                         begin
                         Append;

                         NroRegistro.Value := NroRegistroActual;
                         Ejercicio.Value := MovimientoFields.Ejercicio.Value;
                         Codigo.Value := '';
                         Propietario.Value  := MovimientoFields.Propietario.Value;
                         Fecha.Value := MovimientoFields.Fecha.Value;
                         Serie.Value := MovimientoFields.Serie.Value;
                         NroDocumento.Value := MovimientoFields.NroDocumento.Value;
                         NroOperacion.Value := MovimientoFields.NroOperacion.Value;

                         ActualizaImporteNeto;

                         Post;

                         Inc( NroRegistroActual );
                         end;

                  Next;
                  end;

              except on E : Exception do
                begin

                With RelacionAlbaranesTable do
                  begin
                  Cancel;
                  DeleteRecords;
                  end;

                  If   E is EnxDatabaseError
                  then With E as EnxDatabaseError do
                         begin
                         case ErrorCode of
                           DBIERR_LOCKED,
                           DBIERR_RECLOCKFAILED : ShowNotification( ntWarning, RsMsg9, RsMsg10 );
                           DBIERR_KEYVIOL       : ShowNotification( ntError, RsMsg13, RsMsg12 );
                           else                   begin
                                                  ShowErrorDialog := True;
                                                  ShowException( E, nil ) ;
                                                  end;
                           end;
                         end
                  else ShowNotification( ntError, RsMsg11, RsMsg12 );

                  Release;
                  end;
                end;

            finally
              RelacionAlbaranesTable.EnableControls;
              ShowErrorDialog := True;
              end;

            end;

     GridView.DataController.RefreshExternalData;

end;

procedure TBoxSacForm.ActualizaImporteNeto;

var ImporteBruto,
    ImporteDescuentos,
    ImporteNeto : Decimal;

begin
     ImporteNeto := 0.0;

     If   ( RelacionAlbaranesFields.Ejercicio.Value<>0 ) and
          ( RelacionAlbaranesFields.NroOperacion.Value<>0 )
     then Movimiento.ObtenImporteMovimiento( RelacionAlbaranesFields.Ejercicio.Value,
                                             RelacionAlbaranesFields.NroOperacion.Value,
                                             ImporteBruto,
                                             ImporteDescuentos,
                                             ImporteNeto );

     RelacionAlbaranesFields.Importe.Value := ImporteNeto;

end;

procedure TBoxSacForm.RelacionAlbaranesTableNewRecord(DataSet: TDataSet);
begin
     RelacionAlbaranesFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
     RelacionAlbaranesFields.Importe.Value := 0.0;
end;

procedure TBoxSacForm.TodasLasSeriesCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     SerieCtrl.Enabled := not TodasLasSeriesCtrl.Checked;
     If   TodasLasSeriesCtrl.Editing
     then begin
          If   TodasLasSeriesCtrl.Checked
          then DataSerie.Clear;
          RegeneraLista;
          end;
end;

procedure TBoxSacForm.GridEnter(Sender: TObject);
begin
     With CodigoProveedorCtrl do
       If   ValueIsEmpty( EditValue )
       then begin
            ShowNotification( ntStop, RsMsg5, '' );
            SetFocus;
            end;
end;

procedure TBoxSacForm.GridViewEjercicioPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   not TabKey or ShiftKey
     then If   not ValueIsEmpty( RelacionAlbaranesFields.NroDocumento.Value ) and
               not ValueIsEmpty( DisplayValue )
          then CompruebaDocumento( DisplayValue,
                                   RelacionAlbaranesFields.Serie.Value,
                                   RelacionAlbaranesFields.NroDocumento.Value,
                                   ErrorText,
                                   Error );
end;

function TBoxSacForm.GridViewFocusFirstAvailableItem( Sender: TcxCustomGridTableController): Boolean;
begin
     Sender.FocusedItem := GridViewNroDocumento;
     Result := True;
end;

procedure TBoxSacForm.GridViewDocumentoPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaAlbaranesCompraPendientes( DataCodigoProveedor.Value, Sender, DoAlbaranSelected );
end;

procedure TBoxSacForm.GridViewNroDocumentoPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   not ShiftKey
     then If   not ValueIsEmpty( RelacionAlbaranesFields.Ejercicio.Value ) and
               not ValueIsEmpty( DisplayValue )
          then CompruebaDocumento( RelacionAlbaranesFields.Ejercicio.Value,
                                   RelacionAlbaranesFields.Serie.Value,
                                   DisplayValue,
                                   ErrorText,
                                   Error );
end;

procedure TBoxSacForm.GridViewSeriePropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
          If   not ShiftKey
     then If   not ValueIsEmpty( RelacionAlbaranesFields.Ejercicio.Value ) and
               not ValueIsEmpty( RelacionAlbaranesFields.NroDocumento.Value ) and
               not ValueIsEmpty( DisplayValue )
          then CompruebaDocumento( RelacionAlbaranesFields.Ejercicio.Value,
                                   DisplayValue,
                                   RelacionAlbaranesFields.NroDocumento.Value,
                                   ErrorText,
                                   Error );
end;

procedure TBoxSacForm.DoAlbaranSelected;
begin
     With cxApcForm do
       begin
       RelacionAlbaranesTable.Edit;
       RelacionAlbaranesFields.Ejercicio.Value := QueryEjercicio.Value;
       RelacionAlbaranesFields.Serie.Value := QuerySerie.Value;
       RelacionAlbaranesFields.NroDocumento.Value := QueryNroDocumento.Value;
       end;
end;

procedure TBoxSacForm.CodigoProveedorCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntProveedores( [ Sender.EditingValue ] );
end;

procedure TBoxSacForm.CodigoProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TBoxSacForm.CodigoProveedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxSacForm.CompruebaDocumento(     Ejercicio    : SmallInt;
                                              Serie        : String;
                                              NroDocumento : LongInt;
                                          var ErrorText    : TCaption;
                                          var Error        : Boolean );

var  Index : SmallInt;

begin

     If   not RelacionAlbaranesTable.ControlsDisabled and ( RelacionAlbaranesTable.State in [ dsInsert, dsEdit ] )
     then begin

          With GridView.DataController do
            For Index := 0 to RecordCount - 1 do
              If   Index<>FocusedRecordIndex
              then If    ( GetValue( Index, 0 )=Ejercicio ) and
                         ( GetValue( Index, 1 )=Serie) and
                         ( GetValue( Index, 2 )=NroDocumento )
                   then begin
                        ErrorText := RsMsg8;
                        Error := True;
                        Exit;
                        end;

          With MovimientoTable do
            begin
            IndexFieldNames := 'TipoMovimiento;Ejercicio;Propietario;Serie;NroDocumento';
            If   not FindKey( [ tmCompra, Ejercicio, DataCodigoProveedor.Value, Serie, NroDocumento ] )
            then begin
                 Error := True;
                 ErrorText := JoinMessage( RsMsg1, RsMsg2 );
                 end
            else If   MovimientoFields.Facturado.Value
                 then begin
                      Error := True;
                      ErrorText := JoinMessage( RsMsg6, RsMsg2 );
                      end
                 else If   MovimientoFields.NoFacturar.Value
                      then begin
                           Error := True;
                           ErrorText := JoinMessage( RsMsg7, RsMsg2 );
                           end
                      else With RelacionAlbaranesFields do
                             begin
                             Codigo.Value := '';
                             Ejercicio.Value := MovimientoFields.Ejercicio.Value;
                             Propietario.Value := MovimientoFields.Propietario.Value;
                             Fecha.Value := MovimientoFields.Fecha.Value;
                             Serie.Value := MovimientoFields.Serie.Value;
                             NroDocumento.Value := MovimientoFields.NroDocumento.Value;
                             NroOperacion.Value := MovimientoFields.NroOperacion.Value;
                             ActualizaImporteNeto;
                             end;
            end;

          end;
end;

end.
