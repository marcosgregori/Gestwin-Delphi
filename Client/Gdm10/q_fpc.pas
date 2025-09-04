unit q_fpc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, nxdb, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGrid, Menus, Buttons, ExtCtrls, AppForms, cxGridDBTableView,
  cxCurrencyEdit, cxLookAndFeelPainters, StdCtrls, cxButtons, AppContainer,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter, cxContainer,
  cxGroupBox, DataManager, ReportManager, QueryGrid;

type
  TGridFpcForm = class(TgxForm)
    FormManager: TgxFormManager;
    QueryGridFrame: TQueryGridFrame;
    procedure FormManagerInitializeForm;
  private

      NroAsientoColumn,
      CodigoClienteColumn,
      FechaColumn,
      FechaLibramientoColumn,
      FechaVencimientoColumn,
      NombreColumn,
      ConceptoColumn,
      EjercicioColumn,
      SerieColumn,
      NroFacturaColumn,
      NroEfectoColumn,
      ImporteColumn,
      ImportePendienteColumn,
      ImporteEfectoColumn,
      ImporteCobradoEfectoColumn,
      EntidadColumn,
      FormaDePagoColumn : TcxGridDBColumn;


      procedure DoUserSelection(Sender: TObject; var AHandled : Boolean);
      procedure DoDrawGroupCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
      procedure DoCompareRowValuesForCellMerging( Sender: TcxGridColumn; ARow1: TcxGridDataRow; AProperties1: TcxCustomEditProperties; const AValue1: Variant; ARow2: TcxGridDataRow; AProperties2: TcxCustomEditProperties; const AValue2: Variant; var AAreEqual: Boolean);

  protected
  class var
     SQLString : String;
     AgruparPor : SmallInt;

  public

  end;

procedure RejillaFacturasPendientesCobro( SQLString  : String;
                                          AgruparPor : SmallInt );

implementation

{$R *.dfm}

uses  cxGridCommon,
      EnterpriseDataAccess,

      Gim00Fields,
      Gim10Fields,

      dmi_ast,

      a_fvi,
      a_ecc;

resourceString
     RsMsg1  = 'Haga doble <click> con el ratón -o pulse la barra espaciadora- sobre una línea para acceder a la factura o al efecto.';

procedure RejillaFacturasPendientesCobro( SQLString  : String;
                                          AgruparPor : SmallInt );
begin
     TGridFpcForm.SQLString := SQLString;
     TGridFpcForm.AgruparPor := AgruparPor;
     CreateGridForm( TGridFpcForm );
end;

procedure TGridFpcForm.FormManagerInitializeForm;

procedure SetupCellsMerging( Columns : array of TcxGridDBColumn );

var Column : TcxGridDBColumn;

begin
     For Column in Columns do
       With Column do
         begin
         Options.CellMerging := True;
         Column.OnCompareRowValuesForCellMerging := DoCompareRowValuesForCellMerging;
         end;
end;

begin

     With QueryGridFrame do
       begin

       Grid.Hint := RsMsg1;

       Setup( SQLString );

       EjercicioColumn := CreateColumn( 'Ejercicio', 'Ejerc.', 60, False );
       NroAsientoColumn := CreateColumn( 'NroAsiento', 'Nº Asiento', 60, False );
       SerieColumn := CreateColumn( 'Serie' );

       NroFacturaColumn := CreateColumn( 'NroFactura', 'Nº Factura' );
       FechaColumn := CreateColumn( 'Fecha' );
       CodigoClienteColumn := CreateColumn( 'Cliente', 'Cliente' );
       NombreColumn := CreateColumn( 'NombreCliente', 'Nombre', 300 );
       ImporteColumn := CreateColumn( 'Importe' );
       ImportePendienteColumn := CreateColumn( 'ImportePendiente', 'Pendiente' );

       NroEfectoColumn := CreateColumn( 'NroEfecto', 'Nº Ef.', 35 );
       EntidadColumn := CreateColumn( 'Entidad' );
       FormaDePagoColumn := CreateColumn( 'FormaDePago', 'Forma de cobro', 30 );
       FechaLibramientoColumn := CreateColumn( 'FechaLibramiento', 'Libramiento' );
       FechaVencimientoColumn := CreateColumn( 'FechaVencimiento', 'Vencimiento' );
       ImporteEfectoColumn := CreateColumn( 'ImporteEfecto', 'Imp. efecto' );

       AddGroupsIndex( [ SerieColumn ] );

       case AgruparPor of
         0 : ;
         1 : AddGroupsIndex( [ CodigoClienteColumn ] );
         2 : AddGroupsIndex( [ EntidadColumn ] );
         3 : AddGroupsIndex( [ FormaDePagoColumn ] );
         end;

       SetupCellsMerging( [ NroFacturaColumn, FechaLibramientoColumn, CodigoClienteColumn, NombreColumn, ImporteColumn, ImportePendienteColumn ] );
       SetColumnsDecimals( [ ImporteColumn, ImportePendienteColumn, ImporteEfectoColumn ] );

       GridTableViewController.OnUserSelection := DoUserSelection;
       GridView.OnCustomDrawGroupCell := DoDrawGroupCell;

       FullExpand;

       end;

end;

procedure TGridFpcForm.DoCompareRowValuesForCellMerging(       Sender       : TcxGridColumn;
                                                               ARow1        : TcxGridDataRow;
                                                               AProperties1 : TcxCustomEditProperties;
                                                         const AValue1      : Variant;
                                                               ARow2        : TcxGridDataRow;
                                                               AProperties2 : TcxCustomEditProperties;
                                                         const AValue2      : Variant;
                                                         var   AAreEqual    : Boolean );
begin
     AAreEqual := ARow1.Values[ NroAsientoColumn.Index ]=ARow2.Values[ NroAsientoColumn.Index ];
end;

procedure TGridFpcForm.DoUserSelection(Sender: TObject; var AHandled : Boolean);
begin
     With QueryGridFrame.GridView.Controller do
       If   Assigned( FocusedRecord )
       then With FocusedRecord do
              If   FocusedColumn.Index<=ImportePendienteColumn.Index
              then MntFacturasEmitidas( [ taFraEmitida, Values[ EjercicioColumn.Index ], Values[ SerieColumn.Index ], Values[ NroFacturaColumn.Index ], NroEfectoRegistroFactura ] )
              else MntEfectosCobrar( [ Values[ EjercicioColumn.Index ], Values[ SerieColumn.Index ], Values[ NroFacturaColumn.Index ], Values[ NroEfectoColumn.Index ] ] );
end;

procedure TGridFpcForm.DoDrawGroupCell(     Sender    : TcxCustomGridTableView;
                                            ACanvas   : TcxCanvas;
                                            AViewInfo : TcxGridTableCellViewInfo;
                                        var ADone     : Boolean );
var  ARec: TRect;
     ARowIndex: Integer;
     ARowInfo : TcxRowInfo;
     AItemIndex : Integer;
     ARecordIndex : Integer;
     ATextToDraw : String;

begin
     With AViewInfo do
       If   ( GridView.GroupedItemCount=1 ) and
            ( GridView.GroupedItems[ 0 ]=CodigoClienteColumn )
       then begin
            ARec := Bounds;
            ACanvas.FillRect( ARec );
            ATextToDraw := GridView.DataController.Values[ AViewInfo.GridRecord.RecordIndex, NombreColumn.Index ];
            ATextToDraw := 'Cliente : ' +  GridRecord.Values[ CodigoClienteColumn.Index ] + ' , ' + ATextToDraw;
            ARec.Left := ARec.Left + ( RecordViewInfo.ExpandButtonBounds.Right - RecordViewInfo.ExpandButtonBounds.Left ) + 10;
            ARec.Top := ARec.Top + cxGridCellTextOffset;
            ACanvas.DrawText( ATextToDraw, ARec, 0 );
            ADone := True;
            end;
end;

end.

