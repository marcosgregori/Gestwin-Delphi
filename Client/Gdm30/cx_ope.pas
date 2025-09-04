
unit cx_ope;

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
  TCxOpeForm = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
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
    QueryNombre: TWideStringField;
    TableViewNombre: TcxGridDBColumn;
    QueryCodigoPropietario: TWideStringField;
    QueryCodigoOperarioTipo: TWideStringField;
    QueryDomicilio: TWideStringField;
    QueryLocalidad: TWideStringField;
    QueryCodigoPais: TWideStringField;
    QueryCodigoProvincia: TWideStringField;
    QueryCodigoPostal: TWideStringField;
    QueryTelefono: TWideStringField;
    QueryFax: TWideStringField;
    QueryMovil: TWideStringField;
    QueryNIF: TWideStringField;
    QueryEMail: TWideStringField;
    QueryCampoFecha1: TDateField;
    QueryCampoFecha2: TDateField;
    QueryClienteNombre: TWideStringField;
    TableViewDomicilio: TcxGridDBColumn;
    TableViewTelefono: TcxGridDBColumn;
    TableViewMovil: TcxGridDBColumn;
    TableViewLocalidad: TcxGridDBColumn;
    TableViewCodigoPais: TcxGridDBColumn;
    TableViewCodigoProvincia: TcxGridDBColumn;
    TableViewCodigoPostal: TcxGridDBColumn;
    TableViewFax: TcxGridDBColumn;
    TableViewNIF: TcxGridDBColumn;
    TableViewEMail: TcxGridDBColumn;
    TableViewCampoFecha1: TcxGridDBColumn;
    TableViewCampoFecha2: TcxGridDBColumn;
    TableViewClienteNombre: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure TableViewCodigoClienteGetDataText(
      Sender: TcxCustomGridTableItem; ARecordIndex: Integer;
      var AText: string);
  private
  
  protected
    class var
    CodigoCliente : String;
    InitialState  : TQueryGridInitialState;

  end;

var  CxOpeForm : TCxOpeForm = nil;

procedure ConsultaOperarios( Edit          : TcxCustomEdit;
                             CodigoCliente : String = '';
                             InitialState  : TQueryGridInitialState = qgsNormal );

implementation

uses  SysUtils,
      LibUtils,

      Gdm00Dm,
      Gim00Fields,

      dm_ope;

{$R *.dfm}

procedure ConsultaOperarios( Edit          : TcxCustomEdit;
                             CodigoCliente : String = '';
                             InitialState  : TQueryGridInitialState = qgsNormal );
begin
     TCxOpeForm.CodigoCliente := CodigoCliente;
     TCxOpeForm.InitialState := InitialState;
     CreateQueryForm( TCxOpeForm, CxOpeForm, Edit, InitialState );
end;

procedure TCxOpeForm.FormCreate(Sender: TObject);

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

     Caption := 'Consulta de ' + NombreOperarios( False, True );
     If   CodigoCliente<>''
     then Caption := Caption + ' del cliente ' + CodigoCliente;

     SetupCamposLibres( [ TableViewCampo1, TableViewCampo2, TableViewCampo3, TableViewCampo4, TableViewCampo5,
                          TableViewCampo6, TableViewCampo7, TableViewCampo8, TableViewCampoFecha1,  TableViewCampoFecha2 ] );

     TableViewCodigoCliente.Visible := ( CodigoCliente<>'' ) and ( InitialState<>qgsLinked );

     If   InitialState<>qgsLinked
     then SQLSelect := ' CodigoPropietario='''' ';

     If   ( CodigoCliente<>'' ) or ( InitialState=qgsLinked )
     then begin
          If   SQLSelect<>''
          then StrAdd( SQLSelect, ' OR ' );
          StrAdd( SQLSelect, 'CodigoPropietario=' + QuotedStr( CodigoCliente ) );
          end;

     Query.SQL.Add( ' WHERE ( ' + SQLSelect + ' ) ORDER BY CodigoPropietario, Codigo' );

end;

procedure TCxOpeForm.TableViewCodigoClienteGetDataText(     Sender       : TcxCustomGridTableItem;
                                                            ARecordIndex : Integer;
                                                        var AText        : string );
begin
     If   AText=''
     then AText := 'Todos';
end;

end.
