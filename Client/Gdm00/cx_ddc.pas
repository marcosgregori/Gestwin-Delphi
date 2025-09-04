
unit cx_ddc;

interface

uses Forms, AppForms, Classes, Controls, 

  AppContainer,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, QueryForm,

  dm_ddc, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinscxPCPainter, cxContainer, dxSkinsDefaultPainters, cxGroupBox,
  DataManager, cxNavigator, dxDateRanges, dxScrollbarAnnotations;

type
  TCxDdcForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    dataSource: TDataSource;
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGridDBTableViewCodigo: TcxGridDBColumn;
    cxGridDBTableViewNombre: TcxGridDBColumn;
    QueryCodigo: TWideStringField;
    QueryEsUnGrupo: TBooleanField;
    QueryNombre: TWideStringField;
    procedure FormCreate(Sender: TObject);
  private
  protected
    class var
    TipoDireccion : TTipoDireccion;
  end;

var  CxDdcForm : TCxDdcForm = nil;

procedure ConsultaDireccionesCorreo( Edit          : TcxCustomEdit;
                                     TipoDireccion : TTipoDireccion = tdAmbos;
                                     InitialState  : TQueryGridInitialState = qgsNormal );

implementation

uses  DataAccess;

{$R *.dfm}

procedure ConsultaDireccionesCorreo( Edit          : TcxCustomEdit;
                                     TipoDireccion : TTipoDireccion = tdAmbos;
                                     InitialState  : TQueryGridInitialState = qgsNormal );
begin
     TCxDdcForm.TipoDireccion := TipoDireccion;
     CreateQueryForm( TCxDdcForm, CxDdcForm, Edit, InitialState );
end;

procedure TCxDdcForm.FormCreate(Sender: TObject);
begin
     With Query do
       begin
       case TipoDireccion of
         tdIndividual : SQL.Add( 'AND not EsUnGrupo' );
         tdGrupo      : SQL.Add( 'AND EsUnGrupo' );
         tdAmbos      : ;
         end;
       end;
end;

end.
