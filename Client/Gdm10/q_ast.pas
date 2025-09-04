unit q_ast;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, nxdb, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGrid, Menus, Buttons, ExtCtrls, AppForms, cxGridDBTableView,
  cxCurrencyEdit, cxLookAndFeelPainters, StdCtrls, cxButtons, AppContainer,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter, cxContainer,
  cxGroupBox, DataManager, QueryGrid;

type
  TGridAstForm = class(TgxForm)
    FormManager: TgxFormManager;
    QueryGridFrame: TQueryGridFrame;
    procedure FormManagerInitializeForm;

  private

      EjercicioColumn,
      NroAsientoColumn,
      NroApunteColumn,
      FechaColumn,
      SubcuentaColumn,
      DescripcionColumn,
      CentroCosteColumn,
      ContrapartidaColumn,
      ConceptoColumn,
      DebeColumn,
      HaberColumn : TcxGridDBColumn;
      {
      SummaryGroup : TcxDataSummaryGroup;
      SummaryGroupItemLink : TcxGridTableSummaryGroupItemLink;
      SummaryItem : TcxGridDBTableSummaryItem;
      }
      DefaultGroupSummaryItem : TcxGridDBTableSummaryItem;

      procedure DoUserSelection(Sender: TObject; var AHandled : Boolean);

  protected
  class var
     SQLString : String;
  public

  end;

procedure RejillaAsientos( SQLString : String );

implementation

{$R *.dfm}

uses  EnterpriseDataAccess,

      Gdm00Dm,
      Gim00Fields,

      a_ast;

resourceString
     RsMsg1  = 'Haga doble <click> con el ratón -o pulse la barra espaciadora- sobre una línea para acceder al asiento.';

procedure RejillaAsientos( SQLString : String );
begin
     TGridAstForm.SQLString := SQLString;
     CreateGridForm( TGridAstForm );
end;

procedure TGridAstForm.FormManagerInitializeForm;
begin

     With QueryGridFrame do
       begin

       Grid.Hint := RsMsg1;

       Setup( SQLString );

       EjercicioColumn := CreateColumn( 'Ejercicio', 'Ejercicio', 0, False );  // No es visible por defecto
       NroAsientoColumn := CreateColumn( 'NroAsiento', 'Nº asiento' );
       NroApunteColumn := CreateColumn( 'NroApunte', 'Nº apunte', 0, False );
       FechaColumn := CreateColumn( 'Fecha' );
       SubcuentaColumn := CreateColumn( 'Subcuenta' );
       DescripcionColumn := CreateColumn( 'Subcuenta_Descripcion', 'Descripción', 300 );
       CentroCosteColumn := CreateColumn( 'CentroCoste', 'C.C.', 40, DataModule00.DmEmpresaFields.Contable_CtrosCoste.Value );
       ContrapartidaColumn := CreateColumn( 'Contrapartida' );
       ConceptoColumn := CreateColumn( 'Concepto', 'Concepto', 200 );
       DebeColumn := CreateColumn( 'Debe' );
       HaberColumn := CreateColumn( 'Haber' );

       AddGroupsIndex( [ FechaColumn, NroAsientoColumn ] );
       AddDefaultGroupSummaryItems( [ DebeColumn, HaberColumn ] );
       SetColumnsDecimals( [ DebeColumn, HaberColumn ] );

       GridTableViewController.OnUserSelection := DoUserSelection;

       FullExpand;

       end;

end;

procedure TGridAstForm.DoUserSelection(Sender: TObject; var AHandled : Boolean);
begin
     With QueryGridFrame.GridView.Controller do
       If   Assigned( FocusedRecord )
       then With FocusedRecord do
              MuestraApunte( [ Values[ EjercicioColumn.Index ], Values[ NroAsientoColumn.Index ] ], Values[ NroApunteColumn.Index ] );
end;

end.



