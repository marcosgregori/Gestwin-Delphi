
unit b_ipv115;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask,

  AppContainer,
  ComCtrls,
  Menus,
  cxLookAndFeelPainters,
  cxButtons,
  DB, nxdb, DataManager, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxDBEdit, dxmdaset,

  dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel, cxGroupBox,

  Gdm00Dm,
  Gim00Fields,
  Gim10Fields,
  Gim30Fields,

  AppForms;

type
    TParametrosImportacionRec = packed record
      case byte of
        0 : ( Parametros           : TParametrosRec );
        1 : ( FicheroMovimientos   : String[ 80 ];
              Serie                : String[ 2 ] );
        end;

  TBoxIpv115Form = class(TgxForm)
    DataPanel: TgxEditPanel;
    PathCtrl: TcxDBTextEdit;
    examinarButton: TgBitBtn;
    LineaMovimientoTable: TnxeTable;
    MovimientoTable: TnxeTable;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataPath: TWideStringField;
    FormManager: TgxFormManager;
    Label3: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxGroupBox5: TcxGroupBox;
    cxLabel5: TcxLabel;
    ClienteTable: TnxeTable;
    SerieCtrl: TcxDBTextEdit;
    Label19: TcxLabel;
    Label20: TcxLabel;
    DataSerie: TWideStringField;
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
    procedure examinarButtonClick(Sender: TObject);
    function FormManagerGetAccessLevel: Smallint;
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);

  protected
    class procedure ImportacionPedidosEuropastry( Sender : TObject );

  private

    MovimientoFields : TMovimientoFields;
    LineaMovimientoFields : TLineaMovimientoFields;
    ClienteFields : TClienteFields;
    SerieFacturacionFields : TSerieFacturacionFields;
    ArticuloFields : TArticuloFields;
    TiposIVAFields : TTiposIVAFields;

    ParametrosImportacionRec : TParametrosImportacionRec;

  public
    procedure ExecuteProcess;
  end;

var BoxIpv115Form: TBoxIpv115Form = nil;

implementation

{$R *.DFM}

uses   dxBar,

       Files,
       FileCtrl,
       DateUtils,
       LibUtils,

       AppManager,
       EnterpriseDataAccess,

       Gdm30Frm,

       dmi_mov,

       dm_cli,
       dm_mov,
       dm_tma,
       dm_iex,
       dm_sdf,
       dm_pga,
       dm_art,
       dm_sto,
       dm_fdv,

       cx_sdf,

       b_msg,
       b_pro,
       f_prg;

resourceString

  RsMsg4  = 'La fecha de los movimientos a importar no coincide con el ejercicio activo.';
  RsMsg5  = 'El fichero especificado no existe';
  RsMsg6  = 'Utilice el botón [Examinar...] para localizar un fichero válido';
  RsMsg7  = 'Creado el pedido nº %s %d.';
  RsMsg8  = 'El pedido nº %s %d que pretende importar ya existe.';
  RsMsg9  = 'Se cancela el proceso de importación.';
  RsMsg10 = 'La estructura del fichero a importa no es la esperada.';
  RsMsg11 = 'El error se ha producido leyendo la línea nº %d.';
  RsMsg12 = 'No existe el cliente de código %s.';
  RsMsg13 = 'No existe el artículo de código %s.';

  RsMsg14 = 'Es necesario adaptar la tabla de clientes.';
  RsMsg15 = 'Se va ha proceder a modificar la estructura de la tabla de clientes. Asegúrese de que no haya ningún otro usuario utilizando GESTWIN.'#13'¿Confirma que desea realizar el proceso?';

const
  ctImpPedidosVenta = 115;     // Configuración del módulo 115

class procedure TBoxIpv115Form.ImportacionPedidosEuropastry( Sender : TObject );
begin
     CreateEditForm( TBoxIpv115Form, BoxIpv115Form, TGds30Frm.VentasSection, True );
end;

procedure TBoxIpv115Form.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TBoxIpv115Form.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error, SerieFacturacionFields );
end;

procedure TBoxIpv115Form.FormManagerInitializeForm;

const  IndexName = '$Index_115';

begin
     CloseWindowWhenFocusLost := True;

     // Creo sobre la marcha un índice

     If   ClienteTable._Dictionary.GetIndexFromName( IndexName )=-1
     then If   ShowNotification( ntQuestionWarning, RsMsg14, RsMsg15 )=mrYes
          then ClienteTable.AddIndex( IndexName, 'CampoLibre3', [] )
          else Abort;

     ClienteTable.IndexName := IndexName;

     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );
     ClienteFields := TClienteFields.Create( ClienteTable );
     SerieFacturacionFields := TSerieFacturacionFields.Create( Self );
     ArticuloFields := TArticuloFields.Create( Self );
     TiposIVAFields := TTiposIVAFields.Create( Self );

     Configuracion.ObtenParametros( ctImpPedidosVenta, CodigoEmpresaActual, TParametrosRec( ParametrosImportacionRec ) );

     DataPath.Value := ParametrosImportacionRec.FicheroMovimientos;
     DataSerie.Value := ParametrosImportacionRec.Serie;
end;

procedure TBoxIpv115Form.FormManagerOkButton;
begin

     If   not FileExists( DataPath.AsString )
     then begin
          ShowHintMsg( RsMsg6, RsMsg7 );
          Abort;
          end;

     CreateProcessForm( ExecuteProcess, caption );

     ParametrosImportacionRec.FicheroMovimientos := DataPath.Value;
     ParametrosImportacionRec.Serie := DataSerie.Value;

     Configuracion.GuardaParametros( ctImpPedidosVenta, CodigoEmpresaActual, TParametrosRec( ParametrosImportacionRec ) );
end;

procedure TBoxIpv115Form.examinarButtonClick(Sender: TObject);
begin
     With ApplicationForms.OpenFileDialog do
       begin
       Filter := '';
       If   Execute
       then begin
            DataPath.AsString := FileName;
            PathCtrl.SetFocus;
            end;
       end;
end;

procedure TBoxIpv115Form.ExecuteProcess;

var   Fichero : TextFile;
      DataLine : String;

      NroPedidoActual : Longint;
      NroLineaActual : SmallInt;

      CodigoDistribuidor : String;
      NroPedido : LongInt;
      Tipo : String;
      CodigoCliente,
      Nombre,
      Direccion,
      CodigoPostal,
      Provincia : String;
      NroPedidoCliente : String;
      FechaPedido,
      FechaServicio : TDateTime;
      Observaciones,
      CodigoArticulo,
      CodigoEANArticulo  : String;
      Cantidad : Decimal;
      UnidadMedida : String;

procedure DesglosaLineaEntrada;

// 2358;562563;E;377913;AUTOGRILL BENICARLO HOSTELERIA;A-7 P.K. 358 ;12580;CASTELLON;440680;24/06/2014;31/12/1899;;24650;8424465246506;5;CA;N;;

var  ListaParametros : TStringList;
     TextoFechaServicio : String;

begin

     ListaParametros := TStringList.Create;
     try

       try

         ExportImport.ExtraeParametros( DataLine, ListaParametros, ';' );

         If   ListaParametros.Count=19
         then begin

              CodigoDistribuidor := ListaParametros.Strings[ 0 ];
              NroPedido := StrToInt( ListaParametros.Strings[ 1 ] );
              Tipo := ListaParametros.Strings[ 2 ];
              CodigoCliente := ListaParametros.Strings[ 3 ];
              Nombre := ListaParametros.Strings[ 4 ];
              Direccion := ListaParametros.Strings[ 5 ];
              CodigoPostal := ListaParametros.Strings[ 6 ];
              Provincia := ListaParametros.Strings[ 7 ];
              NroPedidoCliente := ListaParametros.Strings[ 8 ];
              AppContainer.StrToDate( ListaParametros.Strings[ 9 ], FechaPedido, dfDefault );
              TextoFechaServicio := ListaParametros.Strings[ 10 ];
              If   TextoFechaServicio='31/12/1899'
              then FechaServicio := FechaPedido
              else AppContainer.StrToDate( TextoFechaServicio, FechaServicio, dfDefault );
              Observaciones := ListaParametros.Strings[ 11 ];
              CodigoArticulo := ListaParametros.Strings[ 12 ];
              CodigoEANArticulo := ListaParametros.Strings[ 13 ];
              Cantidad := StrToCurr( ListaParametros.Strings[ 14 ] );
              UnidadMedida := ListaParametros.Strings[ 15 ];

              end
         else Abort;

       except
         ShowNotification( ntStop, RsMsg10, Format( RsMsg11, [ NroLineaActual ] ) );
         Abort;
         end;

     finally
       ListaParametros.Free;
       end;

end;

begin

     ProcessFrame.AddMsg( ntHeader, Caption );

     EnterpriseDataModule.StartTransaction;

     try

       AssignFile( Fichero, DataPath.AsString );
       Reset( Fichero );
       IoCheck( IoResult );

       NroPedidoActual := 0;
       NroLineaActual := 1;

       try

         While not eof( Fichero ) do
           begin

           ReadLn( Fichero, DataLine );
           IoCheck( IoResult );

           DataLine := Trim( DataLine );
           If   DataLine<>''
           then begin

                DesglosaLineaEntrada;

                If   YearOf( FechaPedido )<>ApplicationContainer.Ejercicio
                then begin
                     ShowNotification( ntStop, RsMsg4 );
                     abort;
                     end;

                If   NroPedidoActual<>NroPedido
                then begin

                     NroPedidoActual := NroPedido;
                     NroLineaActual := 1;

                     If   MovimientoTable.FindKey( [ tmVenta, ApplicationContainer.Ejercicio, DataSerie.Value, NroPedido ] )
                     then begin
                          ShowNotification( ntStop, Format( RsMsg8, [ DataSerie.Value, NroPedido ] ) );
                          Abort;
                          end;

                     If   not ClienteTable.FindKey( [ CodigoCliente ] )
                     then begin
                          ShowNotification( ntStop, Format( RsMsg12, [ CodigoCliente ] ) );
                          Abort;
                          end;

                     MovimientoTable.Append;

                     MovimientoFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
                     MovimientoFields.NroOperacion.Value := Movimiento.ProximaOperacion;
                     MovimientoFields.TipoMovimiento.Value := tmPedidoVenta;
                     MovimientoFields.Serie.Value := DataSerie.Value;
                     MovimientoFields.NroDocumento.Value := Movimiento.ProximoDocumento( MovimientoFields );
                     MovimientoFields.Fecha.Value := FechaPedido;
                     MovimientoFields.FechaAplicacion.Value := FechaServicio;
                     MovimientoFields.Propietario.Value := ClienteFields.Codigo.Value;
                     MovimientoFields.NroDocumentoPropietario.Value := IntToStr( NroPedido );
                     MovimientoFields.CampoLibre[ 1 ].Value := NroPedidoCliente;

                     ProcessFrame.AddMsg( ntInformation, Format( 'Pedido nº : %s %8d', [ DataSerie.Value, MovimientoFields.NroDocumento.Value ] ) );

                     MovimientoTable.Post;

                     end;

                Movimiento.CompruebaPrimerNroPagina( MovimientoFields );

                If   not Articulo.Obten( CodigoArticulo, ArticuloFields )
                then begin
                     ShowNotification( ntStop, Format( RsMsg13, [ CodigoArticulo ] ) );
                     Abort;
                     end;

                LineaMovimientoTable.Append;

                LineaMovimientoFields.NroOperacion.Value := MovimientoFields.NroOperacion.Value;
                LineaMovimientoFields.Ejercicio.Value := MovimientoFields.Ejercicio.Value;
                LineaMovimientoFields.NroLinea.Value := NroLineaActual;
                LineaMovimientoFields.Fecha.Value := MovimientoFields.Fecha.Value;
                LineaMovimientoFields.FechaAplicacion.Value := FechaServicio;
                LineaMovimientoFields.CodigoArticulo.Value := CodigoArticulo;
                LineaMovimientoFields.Descripcion.Value := ArticuloFields.Descripcion.Value;
                LineaMovimientoFields.CodigoAlmacen.Value := DataModule00.DmEmpresaFields.Ventas_AlmacenDefec.Value;
                LineaMovimientoFields.Cantidad.Value := Cantidad;
                LineaMovimientoFields.CantidadAjustada.Value := Cantidad;

                Articulo.ObtenPrecioyDtoVenta( tmVenta, LineaMovimientoFields, ClienteFields.Codigo.Value );

                FacturaVentas.CalculaImportesIVA( MovimientoFields, LineaMovimientoFields, ClienteFields, ArticuloFields, SerieFacturacionFields, TiposIVAFields );

                StockAlmacen.ActualizaStock( MovimientoFields, LineaMovimientoFields, False );

                LineaMovimientoTable.Post;

                Inc( NroLineaActual );

                end;

           end;

         EnterpriseDataModule.Commit;

       finally
         CloseFile( Fichero );
         end;

     except
       EnterpriseDataModule.RollBack;
       ShowNotification( ntStop, RsgMsg123 );
       end;

end;

function TBoxIpv115Form.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.acCaProcesos.Value;
end;

procedure Setup;

var  MenuItem : TMenuItem;

begin
     With Gds30Frm do
       begin
       ImportacionEuropastryItem.Visible := ivAlways;
       ImportacionEuropastryItem.OnClick := TBoxIpv115Form.ImportacionPedidosEuropastry;
       end;

end;

initialization
    AddProcedure( imOnEnterpriseAccess, 0, Setup );

end.

