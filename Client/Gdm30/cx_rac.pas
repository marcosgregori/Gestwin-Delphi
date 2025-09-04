
unit cx_rac;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppContainer,
  EnterpriseDataAccess,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, DataManager, QueryForm, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxGroupBox, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations;

type
  TCxRacForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryCodigoCliente: TWideStringField;
    QueryCodigo: TWideStringField;
    QueryCampo1: TWideStringField;
    QueryCampo2: TWideStringField;
    QueryCampo3: TWideStringField;
    QueryCampo4: TWideStringField;
    QueryCampo5: TWideStringField;
    QueryCampo6: TWideStringField;
    QueryCampo7: TWideStringField;
    QueryCampo8: TWideStringField;
    TableViewCodigoCliente: TcxGridDBColumn;
    TableViewCodigo: TcxGridDBColumn;
    TableViewCampo1: TcxGridDBColumn;
    TableViewCampo2: TcxGridDBColumn;
    TableViewCampo3: TcxGridDBColumn;
    TableViewCampo4: TcxGridDBColumn;
    TableViewCampo5: TcxGridDBColumn;
    TableViewCampo6: TcxGridDBColumn;
    TableViewCampo7: TcxGridDBColumn;
    TableViewCampo8: TcxGridDBColumn;
    QueryCodigoEAN: TWideStringField;
    TableViewCodigoEAN: TcxGridDBColumn;
    QueryAnotacion: TWideMemoField;    
    TableViewNombre: TcxGridDBColumn;
    QueryCampoFecha1: TDateField;
    QueryCampoFecha2: TDateField;
    TableViewCampoFecha1: TcxGridDBColumn;
    TableViewCampoFecha2: TcxGridDBColumn;
    QueryNombreCliente: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure TableViewCodigoClienteGetDataText(
      Sender: TcxCustomGridTableItem; ARecordIndex: Integer;
      var AText: string);
  private
 
  protected
    class var
    Todos : Boolean;
    CodigoCliente : String;
    InitialState  : TQueryGridInitialState;
    OnUserSelection : TDataEditEvent;
  end;

var  CxRacForm : TCxRacForm = nil;

procedure ConsultaAuxiliarClientes( Edit          : TcxCustomEdit;
                                    CodigoCliente : String = '';
                                    UserSelection : TDataEditEvent = nil;
                                    InitialState  : TQueryGridInitialState = qgsNormal );

implementation

uses  SysUtils,
      LibUtils,

      Gdm00Dm,
      Gim00Fields,

      dm_rac;

{$R *.dfm}

procedure ConsultaAuxiliarClientes( Edit          : TcxCustomEdit;
                                    CodigoCliente : String = '';
                                    UserSelection : TDataEditEvent = nil;
                                    InitialState  : TQueryGridInitialState = qgsNormal );
begin
     TcxRacForm.Todos := ShiftKey or ( CodigoCliente='00000' );
     TCxRacForm.CodigoCliente := CodigoCliente;
     TCxRacForm.InitialState := InitialState;
     TCxRacForm.OnUserSelection := UserSelection;
     CreateQueryForm( TCxRacForm, CxRacForm, Edit, InitialState );
end;

procedure TCxRacForm.FormCreate(Sender: TObject);

var  SQLSelect : String;

procedure SetupCamposLibres( Columns : Array of TcxGridDBColumn );

var  Column : TcxGridDBColumn;
     NroCampo : SmallInt;

begin
     NroCampo := 1;
     For Column in Columns do
       begin
       Column.Caption := DataModule00.DmEmpresaFields.Cliente_CampoAux[ NroCampo ].Value;
       Column.VisibleForCustomization := Column.Caption<>'';
       Inc( NroCampo );
       end;
end;

begin

     Caption := 'Consulta de ' + NombreAuxiliarCliente( False, True );
     If   not Todos and ( CodigoCliente<>'' )
     then Caption := Caption + ' del cliente ' + CodigoCliente;

     SetupCamposLibres( [ TableViewCampo1, TableViewCampo2, TableViewCampo3, TableViewCampo4, TableViewCampo5,
                          TableViewCampo6, TableViewCampo7, TableViewCampo8, TableViewCampoFecha1, TableViewCampoFecha2 ] );

     TableViewCodigoCliente.Visible := Todos or ( ( CodigoCliente<>'' ) and ( InitialState<>qgsLinked ) );

     If   not Todos
     then begin

          If   InitialState=qgsLinked
          then SQLSelect := ''
          else SQLSelect := ' CodigoCliente='''' ';

          If   ( CodigoCliente<>'' ) or ( InitialState=qgsLinked )
          then begin
               If   SQLSelect<>''
               then StrAdd( SQLSelect, ' OR ' );
               StrAdd( SQLSelect, 'CodigoCliente=' + QuotedStr( CodigoCliente ) );
               end;

          SQLSelect := ' WHERE ( ' + SQLSelect + ' )';

          end;

     Query.SQL.Add( SQLSelect + ' ORDER BY CodigoCliente, AuxiliarCliente.Codigo' );

     QueryPanel.OnDataSelected := OnUserSelection;
end;

procedure TCxRacForm.TableViewCodigoClienteGetDataText(     Sender       : TcxCustomGridTableItem;
                                                            ARecordIndex : Integer;
                                                        var AText        : string );
begin
     If   AText=''
     then AText := 'Todos';
end;

end.
