unit fi_100;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, nxdb, DataManager, sqlset, dxmdaset, AppContainer, InpFrames,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, AppForms,
  StdCtrls, cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBExtLookupComboBox, ExtCtrls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinscxPCPainter,
  cxGroupBox, dxSkinsDefaultPainters;

type
  TGadgetI100Frame = class(TFrame)
    Consulta: TnxeQuery;
    SQLSet: TgxSQLSet;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataFechaVencimiento: TDateField;
    DataImporteCobros: TBCDField;
    DataImportePagos: TBCDField;
    DataSaldo: TBCDField;
    FrameManager: TgFrameManager;
    ConsultaFechaVencimiento: TDateField;
    ConsultaImporte: TBCDField;
    TableView: TcxGridDBTableView;
    Level: TcxGridLevel;
    Grid: TcxGrid;
    TableViewFechaVencimento: TcxGridDBColumn;
    TableViewImporteCobros: TcxGridDBColumn;
    TableViewImportePagos: TcxGridDBColumn;
    TableViewSaldo: TcxGridDBColumn;
    BancoTable: TnxeTable;
    BancoTableDataSource: TDataSource;
    BancoTableSubcuenta: TWideStringField;
    BancoTableNombre: TWideStringField;
    Panel1: TcxGroupBox;
    Label1: TLabel;
    CuentaFinancieraCtrl: TcxDBExtLookupComboBox;
    GridViewRepository: TcxGridViewRepository;
    GridViewRepositoryTableView: TcxGridDBTableView;
    GridViewRepositoryTableViewSubcuenta: TcxGridDBColumn;
    GridViewRepositoryTableViewNombre: TcxGridDBColumn;
    LookupData: TgxMemData;
    LookupDataSubcuenta: TWideStringField;
    LookupDataSource: TDataSource;
    LookupDataTodas: TBooleanField;
    LookupDataFechaVencimientoInicial: TDateField;
    procedure FrameManagerInitialize;
    procedure FrameManagerUpdate;
    procedure TableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure CuentaFinancieraCtrlPropertiesChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses   DateUtils,
       LibUtils,

       dm_sal;

procedure TGadgetI100Frame.CuentaFinancieraCtrlPropertiesChange( Sender: TObject);
begin
     FrameManagerUpdate;
end;

procedure TGadgetI100Frame.FrameManagerInitialize;
begin
     SetColumnsDecimals( [ TableViewImporteCobros, TableViewImportePagos, TableViewSaldo ] );

     With LookUpData do
       begin
       Open;
       Append;
       LookupDataSubcuenta.Value := BancoTableSubcuenta.Value;
       end;

end;

procedure TGadgetI100Frame.FrameManagerUpdate;

var  SQLText : String;
     FechaSaldoInicial,
     FechaInicio : TDateTime;
     SaldoInicial,
     SaldoAcumulado : Decimal;

begin

     With Data do
       begin
       Close;
       Open;
       end;

     FechaInicio := ApplicationContainer.TodayDate;

     // El saldo inicial en la cuenta

     FechaSaldoInicial := IncDay( FechaInicio, -1 );  // El día anterior
     SaldoInicial := Saldos.SaldoFecha( LookupDataSubcuenta.Value, '', True, FechaSaldoInicial );
     Data.Append;
     DataFechaVencimiento.Value := FechaSaldoInicial;
     DataSaldo.Value := SaldoInicial;

     // Recogiendo los importes diarios de cobros

     SQLText := SQLSet.GetSQLText( 'Cobros' );
     SetSQLVar( SQLText, 'Entidad', QuotedStr( LookupDataSubcuenta.Value ) );
     SetSQLVar( SQLText, 'Fecha', SQLDateString( FechaInicio ) );
     With Consulta do
       begin
       Close;
       SQL.Text := SQLText;
       Open;
       First;
       While not Eof do
         begin
         Data.Append;
         DataFechaVencimiento.Value := ConsultaFechaVencimiento.Value;
         DataImporteCobros.Value := ConsultaImporte.Value;
         Data.Post;
         Next;
         end;
       Close;
       end;

     // Y, ahora, los pagos

     SQLText := SQLSet.GetSQLText( 'Pagos' );
     SetSQLVar( SQLText, 'Entidad', QuotedStr( LookupDataSubcuenta.Value ) );
     SetSQLVar( SQLText, 'Fecha', SQLDateString( FechaInicio ) );
     With Consulta do
       begin
       Close;
       SQL.Text := SQLText;
       Open;
       First;
       While not Eof do
         begin
         If   Data.Locate( 'FechaVencimiento', ConsultaFechaVencimiento.Value, [] )
         then Data.Edit
         else begin
              Data.Append;
              DataFechaVencimiento.Value := ConsultaFechaVencimiento.Value;
              end;
         DataImportePagos.Value := ConsultaImporte.Value;
         Data.Post;
         Next;
         end;
       Close;
       end;

     // Y, finalmente, los saldos

     SaldoAcumulado := SaldoInicial;
     With Data do
       begin
       First;
       While not Eof do
         begin
         Edit;
         DecAdd( SaldoAcumulado, DataImporteCobros.Value - DataImportePagos.Value );
         DataSaldo.Value := SaldoAcumulado;
         Post;
         Next;
         end;
       end;

end;

procedure TGadgetI100Frame.TableViewCustomDrawCell(      Sender    : TcxCustomGridTableView;
                                                         ACanvas   : TcxCanvas;
                                                         AViewInfo : TcxGridTableDataCellViewInfo;
                                                     var ADone     : Boolean );
begin
     If   VarToDecimal( AViewInfo.GridRecord.Values[ TableViewSaldo.Index ] )<0.0
     then With ACanvas do
            begin
            Brush.Color := rgb_lightRed;
            Font.Color := clBlack;
            end;
end;

end.
