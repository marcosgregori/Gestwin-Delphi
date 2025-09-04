
unit b_sav;

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

    Gim30Fields, cxCurrencyEdit, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxGroupBox, cxLookAndFeels, cxLabel,
  cxPCdxBarPopupMenu, cxNavigator, dxBarBuiltInMenu, dxDateRanges, AppForms,
  GridTableViewController, dxScrollbarAnnotations, dxUIAClasses;

type

  TBoxSavForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    CodigoClienteCtrl: TcxDBTextEdit;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    TabSheet2: TcxTabSheet;
    NroAlbaranInicialCtrl: TcxDBTextEdit;
    NroAlbaranFinalCtrl: TcxDBTextEdit;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    MovimientoTable: TnxeTable;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    gxRangeBox2: TgxRangeBox;
    gxRangeBox1: TgxRangeBox;
    RelacionAlbaranesTable: TnxeTable;
    LineaDataSource: TDataSource;
    Data: TgxMemData;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataCodigoCliente: TWideStringField;
    DataSource: TDataSource;
    DataNroAlbaranInicial: TIntegerField;
    DataNroAlbaranFinal: TIntegerField;
    DataSeleccion: TSmallintField;
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
    MovimientoQuery: TnxeQuery;
    DataFechaFactura: TDateField;
    Label2: TcxLabel;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label6: TcxLabel;
    Label4: TcxLabel;
    BottomPanel: TcxGroupBox;
    FechaFacturaCtrl: TcxDBDateEdit;
    Label5: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    TopPanel: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    procedure GridViewNroDocumentoPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewEjercicioPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewNroDocumentoPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridEnter(Sender: TObject);
    procedure RelacionAlbaranesTableNewRecord(DataSet: TDataSet);
    procedure CodigoClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoClienteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    function GridViewFocusFirstAvailableItem(
      Sender: TcxCustomGridTableController): Boolean;
    procedure CtrlPropertiesValuePosted(Sender: TObject);
  private

    MovimientoFields : TMovimientoFields;
    RelacionAlbaranesFields : TRelacionAlbaranesFields;

    procedure ActualizaImporteNeto;

  public
    class var
      SerieFacturacion : String;
      OnSelected : TSimpleEvent;

    procedure RegeneraLista;
    procedure DoAlbaranSelected( Target : TcxCustomEdit = nil );
    procedure CompruebaDocumento( Ejercicio : SmallInt; NroDocumento : LongInt; var ErrorText : TCaption; var Error : Boolean );
  end;

var
  BoxSavForm : TBoxSavForm = nil;

procedure SeleccionaAlbaranesVenta( Serie : String; OnSelected : TSimpleEvent );

implementation

{$R *.DFM}

uses   SysUtils,
       LibUtils,
       nxDbBase,
       nxllBde,

       DataAccess,
       EnterpriseDataAccess,

       dmi_mov,

       dm_cli,
       dm_tma,
       dm_mov,
       dm_fdv,

       a_mve,
       a_fdv,
       a_cli,

       b_msg,

       cx_cli,
       cx_apv;

resourceString
      RsMsg1   = 'Este número de albarán no existe.';
      RsMsg2   = 'Utilice la consulta en línea (F4) para visualizar los albaranes pendientes de este cliente.';
      RsMsg3   = 'Este albarán no pertenece al cliente seleccionado.';
      RsMsg4   = 'No ha seleccionado ningún albarán.';
      //..
      RsMsg6   = 'Este albarán ya ha sido facturado.';
      RsMsg7   = 'Este albarán ha sido marcado como no facturable.';
      RsMsg8   = 'Este albarán ya ha sido incluído en la relación.';
      RsMsg9   = 'Al menos uno de los albaranes que intenta facturar está siendo modificado por otro usuario.';
      RsMsg10  = 'Si desea seleccionar el/los albaranes bloqueados debe esperar a que sean liberados.';
      RsMsg11  = 'Se ha producido un error al crear la relación de albaranes a facturar.';
      RsMsg12  = 'Puede que alguno de los ficheros de movimientos está deteriorado o que exista un problema con el acceso a los datos.'#13'Identifique y corrija el origen del error y reintente la operación.';
      RsMsg13  = 'Existen dos albaranes con el mismo número de documento .';
      
procedure SeleccionaAlbaranesVenta( Serie      : String;
                                    OnSelected : TSimpleEvent );
begin
     TBoxSavForm.SerieFacturacion := Serie;
     TBoxSavForm.OnSelected := OnSelected;

     //* 01.08.99 Evito que el usuario está editando el albarán. Aunque se realiza la lectura con bloqueo cuando el cliente es el mismo
     //           DBAccess no notifica que el registro está bloqueado.

     If   Assigned( MntMveForm[ tmVenta ] )
     then begin
          MntMveForm[ tmVenta ].FormManager.SelectFirstKeyControl;
          Application.ProcessMessages;  // Que se complete antes de seguir
          end;

     CreateEditForm( TBoxSavForm, BoxSavForm );
end;

procedure TBoxSavForm.FormManagerOkButton;
begin
     If   RelacionAlbaranesTable.RecordCount=0
     then begin
          ShowNotification( ntStop, RsMsg4, '' );
          Enabled := True;
          FormManager.SelectFirstDataControl;
          Abort;
          end;
     If   Assigned( OnSelected )
     then OnSelected;
end;

procedure TBoxSavForm.CtrlPropertiesValuePosted(Sender: TObject);
begin
     RegeneraLista;
end;

procedure TBoxSavForm.FormManagerInitializeForm;
begin
     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     RelacionAlbaranesFields := TRelacionAlbaranesFields.Create( RelacionAlbaranesTable );

     DataFechaInicial.Value := ApplicationContainer.FirstDayOfYearDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
     DataNroAlbaranInicial.Value := 1;
     DataNroAlbaranFinal.Value := 99999999;
     DataFechaFactura.Value := ApplicationContainer.TodayDate;

     SetColumnDecimals( GridViewImporte );

     RegeneraLista;
end;

procedure TBoxSavForm.RegeneraLista;

var MovimientoQueryFields : TMovimientoFields;
    NroRegistroActual : Integer;
    
begin

     RelacionAlbaranesTable.DeleteRecords;

     If   not ValueIsEmpty( DataCodigoCliente.Value ) and
          not ValueIsEmpty( DataFechaInicial.Value ) and
          not ValueIsEmpty( DataFechaFinal.Value )
     then With MovimientoQuery do
            begin
            Close;
            case PageControl.ActivePageIndex of
              0 : SQL.Text := SQLFormat( 'SELECT * FROM Movimiento WHERE TipoMovimiento=%d AND Propietario=%s AND Fecha BETWEEN %s AND %s ORDER BY Fecha, NroDocumento',
                                         [ tmVenta,
                                           DataCodigoCliente,
                                           DataFechaInicial,
                                           DataFechaFinal ] );
              1 : SQL.Text := SQLFormat( 'SELECT * FROM Movimiento WHERE TipoMovimiento=%d AND Ejercicio=%d AND Propietario=%s AND Serie=%s AND NroDocumento BETWEEN %s AND %s ORDER BY NroDocumento',
                                         [ tmVenta,
                                           ApplicationContainer.Ejercicio,
                                           DataCodigoCliente,
                                           QuotedStr( SerieFacturacion ),
                                           DataNroAlbaranInicial,
                                           DataNroAlbaranFinal ] );
              end;

            NroRegistroActual := 1;
            
            Open;
            MovimientoQueryFields := TMovimientoFields.Create( MovimientoQuery );

            try

              ShowErrorDialog := False;
              RelacionAlbaranesTable.DisableControls;
              try

                First;
                While not Eof do
                  begin
                  If   not MovimientoQueryFields.NoFacturar.Value and
                       not MovimientoQueryFields.Facturado.Value and
                           ( MovimientoQueryFields.Serie.Value=SerieFacturacion )
                  then begin

                       RelacionAlbaranesTable.Append;

                       RelacionAlbaranesFields.NroRegistro.Value := NroRegistroActual;
                       RelacionAlbaranesFields.Ejercicio.Value := MovimientoQueryFields.Ejercicio.Value;
                       RelacionAlbaranesFields.Codigo.Value := '';
                       RelacionAlbaranesFields.Propietario.Value  := MovimientoQueryFields.Propietario.Value;
                       RelacionAlbaranesFields.Fecha.Value := MovimientoQueryFields.Fecha.Value;
                       RelacionAlbaranesFields.Serie.Value := MovimientoQueryFields.Serie.Value;
                       RelacionAlbaranesFields.NroDocumento.Value := MovimientoQueryFields.NroDocumento.Value;
                       RelacionAlbaranesFields.NroOperacion.Value := MovimientoQueryFields.NroOperacion.Value;

                       ActualizaImporteNeto;

                       RelacionAlbaranesTable.Post;

                       Inc( NroRegistroActual );
                       end;

                  Next;
                  end;

              except on E : Exception do begin

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
              Close;
              RelacionAlbaranesTable.EnableControls;
              ShowErrorDialog := True;
              end;

            end;

     GridView.ViewData.DataController.RefreshExternalData;

 end;

procedure TBoxSavForm.RelacionAlbaranesTableNewRecord(DataSet: TDataSet);
begin
     RelacionAlbaranesFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
     RelacionAlbaranesFields.Importe.Value := 0.0;
end;

procedure TBoxSavForm.GridEnter(Sender: TObject);
begin
     FormManager.ValidateDataArea( faData );
end;

procedure TBoxSavForm.GridViewEjercicioPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   not ( TabKey or ShiftKey ) and GridViewEjercicio.Editing
     then If   not ValueIsEmpty( RelacionAlbaranesFields.NroDocumento.Value ) and
               not ValueIsEmpty( DisplayValue )
          then CompruebaDocumento( DisplayValue, RelacionAlbaranesFields.NroDocumento.Value, ErrorText, Error );
end;

function TBoxSavForm.GridViewFocusFirstAvailableItem( Sender: TcxCustomGridTableController): Boolean;
begin
     Sender.FocusedItem := GridViewNroDocumento;
     Result := True;
end;

procedure TBoxSavForm.GridViewNroDocumentoPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaAlbaranesVentaPendientes( SerieFacturacion, DataCodigoCliente.Value, Sender, DoAlbaranSelected );
end;

procedure TBoxSavForm.ActualizaImporteNeto;

var  ImporteBruto,
     DescuentosArticulo,
     ImporteNeto : Decimal;

begin

     ImporteNeto := 0.0;

     If   ( RelacionAlbaranesFields.Ejercicio.Value<>0 ) and
          ( RelacionAlbaranesFields.NroOperacion.Value<>0 )
     then Movimiento.ObtenImporteMovimiento( RelacionAlbaranesFields.Ejercicio.Value,
                                             RelacionAlbaranesFields.NroOperacion.Value,
                                             ImporteBruto,
                                             DescuentosArticulo,
                                             ImporteNeto );

     RelacionAlbaranesFields.Importe.Value := Redondea( ImporteNeto );
end;

procedure TBoxSavForm.GridViewNroDocumentoPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   not ShiftKey and GridViewNroDocumento.Editing
     then If   not ValueIsEmpty( RelacionAlbaranesFields.Ejercicio.Value ) and
               not ValueIsEmpty( DisplayValue )
          then CompruebaDocumento( RelacionAlbaranesFields.Ejercicio.Value, DisplayValue, ErrorText, Error );
end;

procedure TBoxSavForm.DoAlbaranSelected;
begin
     With cxApvForm do
       begin
       RelacionAlbaranesTable.Edit;
       RelacionAlbaranesFields.Ejercicio.Value := QueryEjercicio.Value;
       RelacionAlbaranesFields.NroDocumento.Value := QueryNroDocumento.Value;
       end;
end;

procedure TBoxSavForm.CodigoClienteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] );
end;

procedure TBoxSavForm.CodigoClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TBoxSavForm.CodigoClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxSavForm.CompruebaDocumento(     Ejercicio    : SmallInt;
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
              then If   ( GetValue( Index, 1 )=Ejercicio ) and ( GetValue( Index, 2 )=NroDocumento )
                   then begin
                        ErrorText := RsMsg8;
                        Error := True;
                        Exit;
                        end;

          With MovimientoTable do
            begin
            IndexFieldNames := 'TipoMovimiento;Ejercicio;Serie;NroDocumento';
            If   not FindKey( [ tmVenta, Ejercicio, SerieFacturacion, NroDocumento ] )
            then begin
                 Error := True;
                 ErrorText := JoinMessage( RsMsg1, RsMsg2 );
                 end
            else If   MovimientoFields.Propietario.Value<>DataCodigoCliente.Value
                 then begin
                      Error := True;
                      ErrorText := JoinMessage( RsMsg3, RsMsg2 );
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
