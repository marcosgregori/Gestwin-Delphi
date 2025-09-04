
unit cx_rap;

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
  TCxRapForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryCodigoProveedor: TWideStringField;
    QueryCodigo: TWideStringField;
    QueryCampo1: TWideStringField;
    QueryCampo2: TWideStringField;
    QueryCampo3: TWideStringField;
    QueryCampo4: TWideStringField;
    QueryCampo5: TWideStringField;
    QueryCampo6: TWideStringField;
    QueryCampo7: TWideStringField;
    QueryCampo8: TWideStringField;
    TableViewCodigoProveedor: TcxGridDBColumn;
    TableViewCodigo: TcxGridDBColumn;
    TableViewCampo1: TcxGridDBColumn;
    TableViewCampo2: TcxGridDBColumn;
    TableViewCampo3: TcxGridDBColumn;
    TableViewCampo4: TcxGridDBColumn;
    TableViewCampo5: TcxGridDBColumn;
    TableViewCampo6: TcxGridDBColumn;
    TableViewCampo7: TcxGridDBColumn;
    TableViewCampo8: TcxGridDBColumn;
    QueryCampoFecha1: TDateField;
    QueryCampoFecha2: TDateField;
    TableViewCampoFecha1: TcxGridDBColumn;
    TableViewCampoFecha2: TcxGridDBColumn;
    QueryNombreProveedor: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure TableViewCodigoProveedorGetDataText(
      Sender: TcxCustomGridTableItem; ARecordIndex: Integer;
      var AText: string);
  private
    
  protected
    class var
    Todos : Boolean;
    CodigoProveedor : String;
    InitialState  : TQueryGridInitialState;
  end;

var  CxRapForm : TCxRapForm = nil;

procedure ConsultaAuxiliarProveedores( Edit            : TcxCustomEdit;
                                       CodigoProveedor : String= '';
                                       InitialState    : TQueryGridInitialState = qgsNormal );

implementation

uses  SysUtils,
      LibUtils,

      dm_rap,

      Gdm00Dm,
      Gim00Fields;

{$R *.dfm}

procedure ConsultaAuxiliarProveedores( Edit            : TcxCustomEdit;
                                       CodigoProveedor : String= '';
                                       InitialState    : TQueryGridInitialState = qgsNormal );
begin
     TcxRapForm.Todos := ShiftKey;
     TCxRapForm.CodigoProveedor := CodigoProveedor;
     TCxRapForm.InitialState := InitialState;
     CreateQueryForm( TCxRapForm, CxRapForm, Edit, InitialState );
end;

procedure TCxRapForm.FormCreate(Sender: TObject);

var  SQLSelect : String;

procedure SetupCamposLibres( Columns : Array of TcxGridDBColumn );

var  Column : TcxGridDBColumn;
     NroCampo : SmallInt;

begin
     NroCampo := 1;
     For Column in Columns do
       begin
       Column.Caption := DataModule00.DmEmpresaFields.Proveedor_CampoAux[ NroCampo ].Value;
       Column.VisibleForCustomization := Column.Caption<>'';
       Inc( NroCampo );
       end;
end;

begin

     Caption := 'Consulta de ' + NombreAuxiliarProveedor( False, True );
     If   not Todos and ( CodigoProveedor<>'' )
     then Caption := Caption + ' del proveedor ' + CodigoProveedor;

     SetupCamposLibres( [ TableViewCampo1, TableViewCampo2, TableViewCampo3, TableViewCampo4, TableViewCampo5,
                          TableViewCampo6, TableViewCampo7, TableViewCampo8, TableViewCampoFecha1, TableViewCampoFecha2 ] );

     TableViewCodigoProveedor.Visible := Todos or ( ( CodigoProveedor<>'' ) and ( InitialState<>qgsLinked ) );

     If   not Todos
     then begin

          If   InitialState=qgsLinked
          then SQLSelect := ''
          else SQLSelect := ' CodigoProveedor='''' ';

          If   ( CodigoProveedor<>'' ) or ( InitialState=qgsLinked )
          then begin
               If   SQLSelect<>''
               then StrAdd( SQLSelect, ' OR ' );
               StrAdd( SQLSelect, 'CodigoProveedor=' + QuotedStr( CodigoProveedor ) );
               end;

          SQLSelect := ' WHERE ( ' + SQLSelect + ' )';
          end;

     Query.SQL.Add( SQLSelect + ' ORDER BY CodigoProveedor, AuxiliarProveedor.Codigo' );
end;

procedure TCxRapForm.TableViewCodigoProveedorGetDataText(     Sender       : TcxCustomGridTableItem;
                                                             ARecordIndex : Integer;
                                                         var AText        : string );
begin
     If   AText=''
     then AText := 'Todos';
end;

end.
