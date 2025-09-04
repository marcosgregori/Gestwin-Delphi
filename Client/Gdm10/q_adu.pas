unit q_adu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, nxdb, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGrid, Menus, Buttons, ExtCtrls, AppForms, cxGridDBTableView,
  cxCurrencyEdit, cxLookAndFeelPainters, StdCtrls, cxButtons, AppContainer,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter, cxContainer,
  cxGroupBox, DataManager, ReportManager, QueryGrid, dxBar;

type
  TGridAduForm = class(TgxForm)
    FormManager: TgxFormManager;
    QueryGridFrame: TQueryGridFrame;
    procedure FormManagerInitializeForm;

  private

      CodigoClienteColumn,
      FechaLibramientoColumn,
      FechaVencimientoColumn,
      NombreColumn,
      ConceptoColumn,
      ImporteColumn,
      DiasColumn,
      EjercicioColumn,
      SerieColumn,
      NroFacturaColumn,
      NroEfectoColumn : TcxGridDBColumn;

      DefaultGroupSummaryItem : TcxGridDBTableSummaryItem;

      procedure DoUserSelection(Sender: TObject; var AHandled : Boolean);
      procedure DoDrawGroupCell( Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
  protected
  class var
     SQLString : String;
     AgruparPorCliente : Boolean;
  public

  end;

procedure RejillaAntiguedadDeuda( SQLString : String; AgruparPorCliente : Boolean );

implementation

{$R *.dfm}

uses  cxGridCommon,
      EnterpriseDataAccess,

      Gim00Fields,

      a_ecc;

resourceString
     RsMsg1  = 'Haga doble <click> con el ratón -o pulse la barra espaciadora- sobre una línea para acceder al efecto.';

procedure RejillaAntiguedadDeuda( SQLString         : String;
                                  AgruparPorCliente : Boolean );
begin
     TGridAduForm.SQLString := SQLString;
     TGridAduForm.AgruparPorCliente := AgruparPorCliente;
     CreateGridForm( TGridAduForm );
end;

procedure TGridAduForm.FormManagerInitializeForm;
begin

     With QueryGridFrame do
       begin

       Grid.Hint := RsMsg1;

       Setup( SQLString );

       CodigoClienteColumn := CreateColumn( 'SubcuentaCliente', 'Cliente' );
       FechaLibramientoColumn := CreateColumn( 'FechaLibramiento', 'Libramiento' );
       FechaVencimientoColumn := CreateColumn( 'FechaVencimiento', 'Vencimiento' );
       NombreColumn := CreateColumn( 'Nombre', 'Nombre', 300, not AgruparPorCliente );
       ConceptoColumn := CreateColumn( 'Concepto', 'Concepto', 200 );
       ImporteColumn := CreateColumn( 'Importe' );
       DiasColumn := CreateColumn( 'Dias' );
       EjercicioColumn := CreateColumn( 'Ejercicio', 'Ejerc.', 60, False );
       SerieColumn := CreateColumn( 'Serie' );
       NroFacturaColumn := CreateColumn( 'NroFactura', 'Nº Factura' );
       NroEfectoColumn := CreateColumn( 'NroEfecto', 'Nº Ef.', 35 );

       If   AgruparPorCliente
       then begin
            AddGroupsIndex( [ CodigoClienteColumn ] );
            AddDefaultGroupSummaryItems( [ ImporteColumn ] );
            end;

       SetColumnsDecimals( [ ImporteColumn ] );

       GridTableViewController.OnUserSelection := DoUserSelection;
       GridView.OnCustomDrawGroupCell := DoDrawGroupCell;

       FullExpand;

       end;

end;

procedure TGridAduForm.DoUserSelection(Sender: TObject; var AHandled : Boolean);
begin
     With QueryGridFrame.GridView.Controller do
       If   Assigned( FocusedRecord )
       then With FocusedRecord do
              MntEfectosCobrar( [ Values[ EjercicioColumn.Index ], Values[ SerieColumn.Index ], Values[ NroFacturaColumn.Index ], Values[ NroEfectoColumn.Index ] ] );
end;

procedure TGridAduForm.DoDrawGroupCell(     Sender    : TcxCustomGridTableView;
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

