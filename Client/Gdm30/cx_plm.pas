
unit cx_plm;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppContainer,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, QueryForm,

  Gim30Fields, dxSkinsCore, dxSkinscxPCPainter, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, dxSkinsDefaultPainters, cxGroupBox,
  cxNavigator, dxDateRanges, dxScrollbarAnnotations;

type
  TcxPlmForm = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryCodigoArticulo: TWideStringField;
    QueryCodigoClaseA: TWideStringField;
    QueryCodigoClaseB: TWideStringField;
    QueryCodigoClaseC: TWideStringField;
    QueryDescripcion: TWideStringField;
    TableViewCodigoArticulo: TcxGridDBColumn;
    TableViewCodigoClaseA: TcxGridDBColumn;
    TableViewCodigoClaseB: TcxGridDBColumn;
    TableViewCodigoClaseC: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    QueryNroLinea: TSmallintField;
    ArticuloTable: TnxeTable;
    ListaMaterialesTable: TnxeTable;
    ArticuloTableEsListaMateriales: TBooleanField;
    ArticuloTableCodigo: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure QueryPanelDataSelected(Target: TcxCustomEdit);
  private
    ListaMaterialesFields : TListaMaterialesFields;
  public
  end;

var  cxPlmForm : TcxPlmForm = nil;

procedure PlantillaListaMateriales;

implementation

{$R *.dfm}

uses  SysUtils,
      EnterpriseDataAccess,

      a_lma,

      dm_cls;

procedure PlantillaListaMateriales;
begin
     CreateQueryForm( TcxPlmForm, cxPlmForm, nil, qgsNormal );
end;

procedure TcxPlmForm.FormCreate(Sender: TObject);
begin
     If   Assigned( MntLmaForm )  // Solo puede utilizarse desde el mantenimiento
     then begin

          Clase.SetupGridColumns( TableViewCodigoClaseA, TableViewCodigoClaseB, TableViewCodigoClaseC, 4 );

          ListaMaterialesFields := TListaMaterialesFields.Create( ListaMaterialesTable );          
          end
     else Abort;
     
end;

procedure TcxPlmForm.QueryPanelDataSelected(Target: TcxCustomEdit);

var   CodigoArticuloDestino : String;
      CodigoClaseADestino,
      CodigoClaseBDestino,
      CodigoClaseCDestino : String;

begin
     try

       try

            MntLmaForm.ListaMaterialesTable.DisableControls;

            EnterpriseDataModule.StartTransaction( [ MntLmaForm.ListaMaterialesTable,
                                                     ArticuloTable ] );

            try

               ListaMaterialesTable.SetRange( [ QueryCodigoArticulo.Value,
                                                QueryCodigoClaseA.Value,
                                                QueryCodigoClaseB.Value,
                                                QueryCodigoClaseC.Value,
                                                0 ],

                                              [ QueryCodigoArticulo.Value,
                                                QueryCodigoClaseA.Value,
                                                QueryCodigoClaseB.Value,
                                                QueryCodigoClaseC.Value,
                                                MaxSmallint ] );

               With MntLmaForm.ListaMaterialesFields do
                 begin
                 CodigoArticuloDestino := CodigoArticulo.Value;
                 CodigoClaseADestino := CodigoClaseA.Value;
                 CodigoClaseBDestino := CodigoClaseB.Value;
                 CodigoClaseCDestino := CodigoClaseC.Value;
                 end;
               
               MntLmaForm.ListaMaterialesTable.Cancel;

               EnterpriseDataModule.ExecQuery( Format( 'DELETE FROM ListaMateriales WHERE CodigoArticulo=%s AND CodigoClaseA=%s AND CodigoClaseB=%s AND CodigoClaseC=%s',
                                                       [ QuotedStr( CodigoArticuloDestino ), QuotedStr( CodigoClaseADestino ), QuotedStr( CodigoClaseBDestino ), QuotedStr( CodigoClaseCDestino ) ] ) );


               With ListaMaterialesTable do
                 begin
                 First;
                 While not Eof do
                   begin

                   MntLmaForm.ListaMaterialesTable.Append;
                   MntLmaForm.ListaMaterialesTable.CopyFields( ListaMaterialesTable );

                   With MntLmaForm.ListaMaterialesFields do
                     begin
                     CodigoArticulo.Value := CodigoArticuloDestino;
                     CodigoClaseA.Value := CodigoClaseADestino;
                     CodigoClaseB.Value := CodigoClaseBDestino;
                     CodigoClaseC.Value := CodigoClaseCDestino;
                     end;
                     
                   MntLmaForm.ListaMaterialesTable.Post;

                   Next;
                   end;

                 end;

               If   ArticuloTable.FindKey( [ QueryCodigoArticulo.Value ] )
               then begin
                    ArticuloTable.Edit;
                    ArticuloTableEsListaMateriales.Value := True;
                    ArticuloTable.Post;
                    end
               else Abort;

              EnterpriseDataModule.Commit;

            except
              EnterpriseDataModule.RollBack;
              MntLmaForm.ListaMaterialesTable.Last;
              raise;
              end;

          finally
            With MntLmaForm, ListaMaterialesTable do
              begin
              EnableControls;
              Cancel;
              FindKey( [ CodigoArticuloDestino, CodigoClaseADestino, CodigoClaseBDestino, CodigoClaseCDestino, 0 ] );              
              FormManager.ReloadRecord;
              FormManager.SelectFirstKeyControl;
              end;
            end;

   except on E : EDatabaseError do Abort;
          on E : Exception      do ShowException( E, Self );
     end;

end;

end.
