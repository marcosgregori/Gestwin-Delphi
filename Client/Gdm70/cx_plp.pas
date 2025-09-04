
unit cx_plp;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppContainer,
  EnterpriseDataAccess,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager,

  dxSkinsCore, dxSkinscxPCPainter, QueryForm, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, dxSkinsDefaultPainters, cxGroupBox,
  cxNavigator,

  Gim70Fields, dxDateRanges, dxScrollbarAnnotations;

type
  TCxPlpForm = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TableViewCodigoArticulo: TcxGridDBColumn;
    TableViewCodigoClaseA: TcxGridDBColumn;
    TableViewCodigoClaseB: TcxGridDBColumn;
    TableViewCodigoClaseC: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    QueryCodigoArticulo: TWideStringField;
    QueryCodigoClaseA: TWideStringField;
    QueryCodigoClaseB: TWideStringField;
    QueryCodigoClaseC: TWideStringField;
    QueryArticulo_Descripcion: TWideStringField;
    QueryProceso: TSmallintField;
    QueryCodigoOperacion: TWideStringField;
    QueryOperacion_Descripcion: TWideStringField;
    TableViewProceso: TcxGridDBColumn;
    TableViewCodigoOperacion: TcxGridDBColumn;
    TableViewOperacion_Descripcion: TcxGridDBColumn;
    RelacionMaterialesTable: TnxeTable;
    RelacionOperacionesTable: TnxeTable;
    procedure FormCreate(Sender: TObject);
    procedure QueryPanelDataSelected(Target: TcxCustomEdit);
  private
    RelacionMaterialesDestinoTable,
    RelacionOperacionesDestinoTable : TnxeTable;
    RelacionMaterialesFields : TRelacionMaterialesFields;
    RelacionOperacionesFields : TRelacionOperacionesFields;
  protected
    class var
    _RelacionMaterialesDestinoTable,
    _RelacionOperacionesDestinoTable : TnxeTable
  end;

var  CxPlpForm : TCxPlpForm = nil;

procedure PlantillaRelacionMaterialesyOperaciones( RelacionMaterialesDestinoTable,
                                                   RelacionOperacionesDestinoTable : TnxeTable );

implementation

{$R *.dfm}

uses  SysUtils,
      AppManager,
      
      dm_cls,
      dm_clp,

      a_lmp,

      b_msg;

resourceString
      RsMsg1 = 'La relación de materiales destino y origen son la misma.';

procedure PlantillaRelacionMaterialesyOperaciones( RelacionMaterialesDestinoTable,
                                                   RelacionOperacionesDestinoTable : TnxeTable );
begin
     TCxPlpForm._RelacionMaterialesDestinoTable := RelacionMaterialesDestinoTable;
     TCxPlpForm._RelacionOperacionesDestinoTable := RelacionOperacionesDestinoTable;
     CreateQueryForm( TCxPlpForm, CxPlpForm, nil );
end;

procedure TCxPlpForm.FormCreate(Sender: TObject);
begin
     RelacionMaterialesDestinoTable := _RelacionMaterialesDestinoTable;
     RelacionOperacionesDestinoTable := _RelacionOperacionesDestinoTable;
     RelacionMaterialesFields := TRelacionMaterialesFields.Create( RelacionMaterialesTable );
     RelacionOperacionesFields := TRelacionOperacionesFields.Create( RelacionOperacionesTable );
     ClaseProduccion.SetupGridColumns( TableViewCodigoClaseA, TableViewCodigoClaseB, TableViewCodigoClaseC, 4 );
end;

procedure TCxPlpForm.QueryPanelDataSelected(Target: TcxCustomEdit);

var   RelacionMaterialesDestinoFields : TRelacionMaterialesFields;
      RelacionOperacionesDestinoFields : TRelacionOperacionesFields;

      CodigoArticuloOrigen : String;
      CodigoClaseAOrigen,
      CodigoClaseBOrigen,
      CodigoClaseCOrigen : String;

      CodigoArticuloDestino : String;
      CodigoClaseADestino,
      CodigoClaseBDestino,
      CodigoClaseCDestino : String;

begin
     try

       EnterpriseDataModule.StartTransaction( [ RelacionMaterialesDestinoTable,
                                                RelacionOperacionesDestinoTable ] );

       If   Assigned( RelacionMaterialesDestinoTable ) and 
            Assigned( RelacionOperacionesDestinoTable )
       then begin

            RelacionMaterialesDestinoTable.DisableControls;
            RelacionOperacionesDestinoTable.DisableControls;

            try

              RelacionMaterialesDestinoFields := TRelacionMaterialesFields.Create( RelacionMaterialesDestinoTable );
              RelacionOperacionesDestinoFields := TRelacionOperacionesFields.Create( RelacionOperacionesDestinoTable );

              With RelacionOperacionesDestinoFields do
                begin
                CodigoArticuloDestino := CodigoArticulo.Value;
                CodigoClaseADestino := CodigoClaseA.Value;
                CodigoClaseBDestino := CodigoClaseB.Value;
                CodigoClaseCDestino := CodigoClaseC.Value;
                end;

              CodigoArticuloOrigen := QueryCodigoArticulo.Value;
              CodigoClaseAOrigen := QueryCodigoClaseA.Value;
              CodigoClaseBOrigen := QueryCodigoClaseB.Value;
              CodigoClaseCOrigen := QueryCodigoClaseC.Value;

              If   ( CodigoArticuloOrigen=CodigoArticuloDestino ) and
                   ( CodigoClaseAOrigen=CodigoClaseADestino ) and
                   ( CodigoClaseBOrigen=CodigoClaseBDestino ) and
                   ( CodigoClaseCOrigen=CodigoClaseCDestino ) 
              then begin
                   ShowNotification( ntStop, RsMsg1 );
                   Abort;
                   end;
                   
              RelacionOperacionesDestinoTable.Cancel;
              
              EnterpriseDataModule.ExecQuery( Format( 'DELETE FROM RelacionOperaciones WHERE CodigoArticulo=''%s'' AND CodigoClaseA=''%s'' AND CodigoClaseB=''%s'' AND CodigoClaseC=''%s''',
                                                      [ CodigoArticuloDestino, CodigoClaseADestino, CodigoClaseBDestino, CodigoClaseCDestino ] ) );

              With RelacionOperacionesTable do
                begin
                
                SetRange( [ CodigoArticuloOrigen, CodigoClaseAOrigen, CodigoClaseBOrigen, CodigoClaseCOrigen, 0 ],
                          [ CodigoArticuloOrigen, CodigoClaseAOrigen, CodigoClaseBOrigen, CodigoClaseCOrigen, MaxSmallint ] );
              
                First;
                While not Eof do
                  begin

                  RelacionOperacionesDestinoTable.Append;
                  RelacionOperacionesDestinoTable.CopyFields( RelacionOperacionesTable );

                  With RelacionOperacionesDestinoFields do
                    begin
                    CodigoArticulo.Value := CodigoArticuloDestino;
                    CodigoClaseA.Value := CodigoClaseADestino;
                    CodigoClaseB.Value := CodigoClaseBDestino;
                    CodigoClaseC.Value := CodigoClaseCDestino;
                    end;

                  RelacionOperacionesDestinoTable.Post;

                  Next;
                  end;

                end;

              RelacionMaterialesDestinoTable.Cancel;
              
              EnterpriseDataModule.ExecQuery( Format( 'DELETE FROM RelacionMateriales WHERE CodigoArticulo=''%s'' AND CodigoClaseA=''%s'' AND CodigoClaseB=''%s'' AND CodigoClaseC=''%s''',
                                                      [ CodigoArticuloDestino, CodigoClaseADestino, CodigoClaseBDestino, CodigoClaseCDestino ] ) );

              With RelacionMaterialesTable do
                begin
                
                SetRange( [ CodigoArticuloOrigen, CodigoClaseAOrigen, CodigoClaseBOrigen, CodigoClaseCOrigen, 1, 1 ],
                          [ CodigoArticuloOrigen, CodigoClaseAOrigen, CodigoClaseBOrigen, CodigoClaseCOrigen, MaxSmallint, MaxSmallint ] );
                First;
                While not Eof do
                  begin

                  RelacionMaterialesDestinoTable.Append;
                  RelacionMaterialesDestinoTable.CopyFields( RelacionMaterialesTable );

                  With RelacionMaterialesDestinoFields do
                    begin
                    CodigoArticulo.Value := CodigoArticuloDestino;
                    CodigoClaseA.Value := CodigoClaseADestino;
                    CodigoClaseB.Value := CodigoClaseBDestino;
                    CodigoClaseC.Value := CodigoClaseCDestino;
                    end;

                  RelacionMaterialesDestinoTable.Post;

                  Next;
                  end;

                end;

            finally

              RelacionMaterialesDestinoFields.Free;
              RelacionOperacionesDestinoFields.Free;
              
              RelacionMaterialesDestinoTable.EnableControls;
              RelacionOperacionesDestinoTable.EnableControls;

              RelacionOperacionesDestinoTable.Cancel;
                            
              MntLmpForm.FormManager.ReloadRecord( True );
              MntLmpForm.FormManager.SelectFirstKeyControl;
               
              end;

            end;

       EnterpriseDataModule.Commit;

     except on E : Exception do 
       begin
       EnterpriseDataModule.RollBack;
       ShowException( E, Self );
       Abort;
       end;
     end;
     
end;

end.
