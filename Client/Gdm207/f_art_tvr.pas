unit f_art_tvr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, nxDB,

  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  cxCheckBox, cxMaskEdit, cxSpinEdit, cxCurrencyEdit,

  Menus, cxLookAndFeelPainters, cxButtons, dxSkinsCore,
  dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels, cxLabel, cxGroupBox,
  dxUIAClasses, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxDBData, dxTokenEdit,
  dxDBTokenEdit, GridTableViewController, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, cxPC,

  LibUtils,
  AppForms,
  DataManager,
  AppContainer,

  Gim30Fields;

type
  TMntArtTvrFrame = class(TFrame)
    FramePanel: TcxGroupBox;
    ClasesArticuloPanel: TcxGroupBox;
    ClaseAPanel: TcxGroupBox;
    ClaseADisponibleLabel: TcxLabel;
    ClaseAGridPanel: TcxGroupBox;
    ClaseAArticuloTableViewController: TGridTableViewController;
    ClaseBPanel: TcxGroupBox;
    ClaseBGridPanel: TcxGroupBox;
    ClaseBArticuloTableViewController: TGridTableViewController;
    ClaseBDisponibleLabel: TcxLabel;
    cxGroupBox29: TcxGroupBox;
    VisibleTiendaCtrl: TcxDBCheckBox;
    ParametrosTiendaGroupBox: TcxGroupBox;
    cxLabel7: TcxLabel;
    cxLabel8: TcxLabel;
    Tienda_CodigoArticuloAgrupadoCtrl: TcxDBTextEdit;
    Tienda_VisibleIndividualmenteCtrl: TcxDBCheckBox;
    DescAgrupadoLabel: TcxLabel;
    cxLabel13: TcxLabel;
    Tienda_NombreImagenCtrl: TcxDBTextEdit;
    Tienda_ComentariosClientesCtrl: TcxDBCheckBox;
    Tienda_NoPublicarClasesCtrl: TcxDBCheckBox;
    ActualizarEnLaTiendaCtrl: TcxCheckBox;
    CategoriaGridPanel: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    CategoriaArticuloGrid: TcxGrid;
    CategoriasArticuloTableView: TcxGridDBTableView;
    CategoriasArticuloTableViewCodigo: TcxGridDBColumn;
    CategoriasArticuloTableViewDescripcion: TcxGridDBColumn;
    CategoriaArticuloGridLevel: TcxGridLevel;
    CategoriasArticuloGridTableViewController: TGridTableViewController;
    CategoriasArticuloDataSource: TDataSource;
    CategoriasArticuloTable: TnxeTable;
    CategoriasArticuloTableCodigoArticulo: TWideStringField;
    CategoriasArticuloTableCodigoCategoria: TWideStringField;
    CategoriasArticuloTableNroOrden: TSmallintField;
    CategoriasArticuloTableNombre: TWideStringField;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    ClaseADataSource: TDataSource;
    ClaseATable: TnxeTable;
    ClaseATableNroClase: TSmallintField;
    ClaseATableCodigo: TWideStringField;
    ClaseATableNroOrden: TSmallintField;
    ClaseATableDescripcion: TWideStringField;
    ClaseATableDisponibleTienda: TBooleanField;
    ClaseAArticuloTable: TnxeTable;
    ClaseAArticuloTableCodigoArticulo: TWideStringField;
    ClaseAArticuloTableNroClase: TSmallintField;
    ClaseAArticuloTableCodigoClase: TWideStringField;
    ClaseBDataSource: TDataSource;
    ClaseBTable: TnxeTable;
    ClaseBTableNroClase: TSmallintField;
    ClaseBTableCodigo: TWideStringField;
    ClaseBTableNroOrden: TSmallintField;
    ClaseBTableDescripcion: TWideStringField;
    ClaseBTableDisponibleTienda: TBooleanField;
    ClaseBArticuloTable: TnxeTable;
    ClaseBArticuloTableCodigoArticulo: TWideStringField;
    ClaseBArticuloTableNroClase: TSmallintField;
    ClaseBArticuloTableCodigoClase: TWideStringField;
    ClaseAArticuloGrid: TcxGrid;
    ClaseAArticuloTableView: TcxGridDBTableView;
    ClaseAArticuloTableViewCodigo: TcxGridDBColumn;
    ClaseAArticuloTableViewDescripcion: TcxGridDBColumn;
    ClaseAArticuloGridLevel: TcxGridLevel;
    ClaseBArticuloGrid: TcxGrid;
    ClaseBArticuloTableView: TcxGridDBTableView;
    ClaseBArticuloTableViewCodigo: TcxGridDBColumn;
    ClaseBArticuloTableViewDescripcion: TcxGridDBColumn;
    ClaseBArticuloGridLevel: TcxGridLevel;
    CategoriasArticuloAuxTable: TnxeTable;
    WideStringField1: TWideStringField;
    WideStringField2: TWideStringField;
    SmallintField1: TSmallintField;
    WideStringField3: TWideStringField;
    procedure Tienda_CodigoArticuloAgrupadoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure VisibleTiendaCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure Tienda_NoPublicarClasesCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure CategoriasArticuloTableCalcFields(DataSet: TDataSet);
    procedure CategoriasArticuloTableViewCodigoPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
    procedure CategoriasArticuloTableNewRecord(DataSet: TDataSet);
    procedure ClaseAArticuloTableNewRecord(DataSet: TDataSet);
    procedure ClaseBArticuloTableNewRecord(DataSet: TDataSet);
    procedure ClaseAArticuloTableViewCodigoPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure ClaseBArticuloTableViewCodigoPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure CategoriasArticuloTableViewCodigoPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure ClaseAArticuloTableViewCodigoPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure ClaseBArticuloTableViewCodigoPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CategoriasArticuloTableViewCodigoPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ClaseAArticuloTableViewCodigoPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ClaseBArticuloTableViewCodigoPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure Tienda_CodigoArticuloAgrupadoCtrlPropertiesValuePosted(Sender: TObject);
    procedure ClaseAArticuloTableViewSelectionChanged(Sender: TcxCustomGridTableView);
    procedure ClaseAArticuloTableViewControllerUserSelection(Sender: TObject; var AHandled: Boolean);
    procedure ClaseAArticuloTableViewControllerBeforeRowShift(Sender: TObject);
    procedure ClaseBArticuloTableViewSelectionChanged(Sender: TcxCustomGridTableView);
    procedure ClaseBArticuloTableViewControllerUserSelection(Sender: TObject; var AHandled: Boolean);
    procedure ClaseBArticuloTableViewControllerBeforeRowShift(
      Sender: TObject);
  private

      DsArticuloFields : TArticuloFields;

      ExisteClaseA,
      ExisteClaseB : Boolean;

      FPageInitialized : Boolean;

      procedure DoActualizaEstadoComponentes;
      procedure DoArticuloBeforePost(Dataset : TDataset);
      procedure ReordenaClases( Tabla : TnxeTable; CampoNroOrden : TSmallintField );


  protected

     class var Wrapper : TProcedureWrapper;

     class procedure DoOnMntArtPageChanged( Value : TControl );

  public

     destructor Destroy; override;

  end;

implementation

uses AppManager,
     EnterpriseDataAccess,

     Gdm00Dm,

     dm_cat,
     dm_art,
     dm_cls,
     dm_ptv,

     dm_rea,
     dm_rea207,
     dm_tvr,

     a_art,
     a_cat,
     a_cls,

     f_art_tva,

     cx_cat,
     cx_cls1,

     b_msg;

{$R *.dfm}

resourceString
       RsMsg1 = 'No se puede incluir un artículo en sí mismo.';
       RsMsg2 = 'Este artículo ya está agrupado y pertenece al grupo del artículo de código %s.';
       RsMsg3 = 'No se ha podido generar una secuencia de registros válida.';
       RsMsg4 = 'Compruebe el estado del fichero de clases y reintente la operación.';
       RsMsg5 = 'El número de orden no era correcto y se ha reordenado la secuencia.';
       RsMsg6 = 'Reintente el proceso de ordenación.';
       //
       RsMsg8 = 'Ya ha incluído este elemento en la lista.';

var MntArtTvrFrame : TMntArtTvrFrame = nil;

procedure SetupFrame;

var Index : SmallInt;

begin
     If   Assigned( MntArtForm )
     then begin

          MntArtTvrFrame := TMntArtTvrFrame.Create( MntArtForm );

          With MntArtTvrFrame do
            begin

            // Colocando los paneles en su posición dentro de la ventana de edición

            FramePanel.Parent := MntArtForm.TiendaVirtualTabSheet;
            FramePanel.Align := alClient;

            // Tienda virtual

            ExisteClaseA := DataModule00.DmEmpresaFields.Articulo_ExisteClase[ tcClaseA ].Value;
            ExisteClaseB := DataModule00.DmEmpresaFields.Articulo_ExisteClase[ tcClaseB ].Value;

            Tienda_NombreImagenCtrl.Properties.ValidChars := FileNameCharSet;

            DsArticuloFields := TArticuloFields.Create( MntArtForm );

            With MntArtForm do
              begin

              OnActualizaEstadoComponentes.Add( DoActualizaEstadoComponentes );

              OnArticuloBeforePost.Add( DoArticuloBeforePost );

              OnTarifaVentasBeforePost.Add( DoArticuloBeforePost );  // Si se modifica una tarifa también se invalida el artículo

              var CodigoField := ArticuloTable.FindField( 'Codigo' );
              If   Assigned( CodigoField )
              then CodigoField.ValidChars := AlfaNumCharSet + CleanCodeCharSet;

              Tienda_NoPublicarClasesCtrl.Enabled := ParametrosTiendaVirtual.PublicarClasesComoConfiguraciones;

              ClasesArticuloPanel.Visible := ( DataModule00.DmEmpresaFields.Articulo_ExisteClase[ tcClaseA ].Value ) and
                                             ParametrosTiendaVirtualModule.PublicarClasesComoConfiguraciones;
              If   ClasesArticuloPanel.Visible
              then If   ExisteClaseA
                   then begin
                        ClaseADisponibleLabel.Caption := Clase.NombreClase( tcClaseA, { Plural } True, { Capital } True );
                        ClaseAArticuloTableViewCodigo.Caption := Clase.NombreClase( tcClaseA, { Plural } False, { Capital } True );

                        ClaseAArticuloTable.Open;
                        ClaseATable.Open;

                        If   ExisteClaseB
                        then begin
                             ClaseBDisponibleLabel.Caption := Clase.NombreClase( tcClaseB, { Plural } True, { Capital } True );
                             ClaseBArticuloTableViewCodigo.Caption := Clase.NombreClase( tcClaseB, { Plural } False, { Capital } True );

                             ClaseBArticuloTable.Open;
                             ClaseBTable.Open;

                             end;
                        end;

              // Me aseguro de que la pestaña de tarifas de venta exista

              MntArtForm.OnPageChanged.Invoke( MntArtForm.TarifaVentasTabSheet );

              end;

            FPageInitialized := True;
            end;

          end;
end;

procedure SetupLink;
begin
     If   DataModule00.TiendaVirtual and Assigned( MntArtForm )
     then If   not Assigned( MntArtTvrFrame )
          then begin

               SetupFrame;

               TMntArtTvrFrame.Wrapper := TProcedureWrapper.Create( TMntArtTvrFrame.DoOnMntArtPageChanged );
               MntArtForm.OnPageChanged.Add( TMntArtTvrFrame.Wrapper.Execute );
               end;

end;

procedure RemoveLink;
begin
     FreeAndNil( TMntArtTvrFrame.Wrapper );
     FreeAndNil( MntArtTvrFrame );
end;

class procedure TMntArtTvrFrame.DoOnMntArtPageChanged( Value : TControl );
begin
     With MntArtForm do
       If   Value=TiendaVirtualTabSheet
       then begin
            {
            If   not Assigned( MntArtTvrFrame )
            then SetupFrame;
            }
            MntArtTvrFrame.DoActualizaEstadoComponentes;
            end;

end;

procedure TMntArtTvrFrame.ReordenaClases( Tabla         : TnxeTable;
                                          CampoNroOrden : TSmallintField );
begin
     If   CampoNroOrden.Value<=0
     then With Tabla do
            begin
            try
              try
                DisableControls;
                var RecordNumber := RecordCount;
                Last;
                While not Bof do
                  begin
                  Edit;
                  CampoNroOrden.Value := RecordNumber;
                  Dec( RecordNumber );
                  Post;
                  Prior;
                  end;
              finally
                EnableControls;
                end;
            except
              ShowNotification( ntWarning, RsMsg3, RsMsg4 );
              end;
            ShowNotification( ntWarning, RsMsg5, RsMsg6 );
            end;
end;

procedure TMntArtTvrFrame.Tienda_CodigoArticuloAgrupadoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean );
begin
     If   DisplayValue=MntArtForm.ArticuloFields.Codigo.Value
     then begin
          Error := True;
          ErrorText := RsMsg1;
          end
     else begin
          Articulo.Valida( Sender, DisplayValue, ErrorText, Error, DsArticuloFields );
          If   not Error and
               DsArticuloFields.VisibleTienda.Value and
               ( DsArticuloFields.Tienda_CodigoArticuloAgrupado.Value<>'' )
          then begin
               Error := True;
               ErrorText := Format( RsMsg2, [ DsArticuloFields.Tienda_CodigoArticuloAgrupado.Value ] );
               end;
          end;

     If   Tienda_CodigoArticuloAgrupadoCtrl.Editing
     then DoActualizaEstadoComponentes;

end;

procedure TMntArtTvrFrame.Tienda_CodigoArticuloAgrupadoCtrlPropertiesValuePosted(Sender: TObject);
begin
     ResetTab;
end;

procedure TMntArtTvrFrame.VisibleTiendaCtrlPropertiesEditValueChanged( Sender: TObject);
begin
     If   VisibleTiendaCtrl.IsFocused or MntArtForm.FormManager.ValidatingFormData
     then DoActualizaEstadoComponentes;
end;

procedure TMntArtTvrFrame.ClaseBArticuloTableNewRecord(DataSet: TDataSet);
begin
     ClaseBArticuloTableCodigoArticulo.Value := MntArtForm.ArticuloFields.Codigo.Value;
     ClaseBArticuloTableNroClase.Value := tcClaseB;
end;

procedure TMntArtTvrFrame.ClaseBArticuloTableViewCodigoPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClases( [ tcClaseB, Sender.EditingValue ] );
end;

procedure TMntArtTvrFrame.ClaseBArticuloTableViewCodigoPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClases1( tcClaseB, Sender );
end;

procedure TMntArtTvrFrame.ClaseBArticuloTableViewCodigoPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ClaseBArticuloTable.Editing and
          not ClaseBArticuloTableViewController.ControllerPostingRecord and
          ( ClaseBArticuloTableView.DataController.FindRecordIndexByKey( DisplayValue )<>-1 )
     then begin
          Error := True;
          ErrorText := RsMsg8;
          end
     else Clase.Valida( tcClaseB, False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntArtTvrFrame.ClaseBArticuloTableViewControllerBeforeRowShift(Sender: TObject);
begin
     If   ClaseBTableNroOrden.Value<=0
     then ReordenaClases( ClaseBTable, ClaseBTableNroOrden );
end;

procedure TMntArtTvrFrame.ClaseBArticuloTableViewControllerUserSelection( Sender : TObject; var AHandled: Boolean );
begin
     var RecordIndex := ClaseBArticuloTableView.DataController.FocusedRecordIndex;
     If   RecordIndex>=0
     then begin
          var RecData := ClaseBArticuloTableView.ViewData.Records[ RecordIndex ];
          RecData.Selected := not RecData.Selected;
          end;
end;

procedure TMntArtTvrFrame.ClaseBArticuloTableViewSelectionChanged( Sender : TcxCustomGridTableView );

var  ExisteRegistro : Boolean;
     RecordIndex : SmallInt;
     Selected : Boolean;

begin
     If   ClaseBArticuloGrid.IsFocused and not ClaseBTable.ShiftingRecords
     then begin
          RecordIndex := Sender.DataController.FocusedRecordIndex;
          If   RecordIndex>=0
          then begin
               Selected := Sender.ViewData.Records[ RecordIndex ].Selected;
               ExisteRegistro := ClaseBArticuloTable.FindKey( [ MntArtForm.ArticuloFields.Codigo.Value, tcClaseB, ClaseBTableCodigo.Value ] );
               If   Selected
               then begin
                    If   not ExisteRegistro
                    then begin
                         ClaseBArticuloTable.Append;
                         ClaseBArticuloTableCodigoArticulo.Value := MntArtForm.ArticuloFields.Codigo.Value;
                         ClaseBArticuloTableNroClase.Value := tcClaseB;
                         ClaseBArticuloTableCodigoClase.Value := ClaseBTableCodigo.Value;
                         ClaseBArticuloTable.Post;
                         end;
                    end
               else If   ExisteRegistro
                    then ClaseBArticuloTable.Delete;
               end;
          end;
end;

procedure TMntArtTvrFrame.CategoriasArticuloTableCalcFields(DataSet: TDataSet);
begin
     CategoriasArticuloTableNombre.Value := Categoria.Descripcion( CategoriasArticuloTableCodigoCategoria.Value )
end;

procedure TMntArtTvrFrame.CategoriasArticuloTableNewRecord(DataSet: TDataSet);
begin
     CategoriasArticuloTableCodigoArticulo.Value := MntArtForm.ArticuloFields.Codigo.Value;
end;

procedure TMntArtTvrFrame.CategoriasArticuloTableViewCodigoPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCategorias( [ Sender.EditingValue ] );
end;

procedure TMntArtTvrFrame.CategoriasArticuloTableViewCodigoPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCategorias( Sender );
end;

procedure TMntArtTvrFrame.CategoriasArticuloTableViewCodigoPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin

     // Comprobando si la categoría ya está incluida en la lista
     // CodigoCategoria;CodigoArticulo

     var CodigoCategoria := VarToStr( DisplayValue );

     If   CategoriasArticuloTable.Editing and
          not CategoriasArticuloGridTableViewController.ControllerPostingRecord and
          CategoriasArticuloAuxTable.FindKey( [ CodigoCategoria, MntArtForm.ArticuloFields.Codigo.Value ]  )
     then begin
          Error := True;
          ErrorText := RsMsg8;
          end
     else Categoria.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntArtTvrFrame.ClaseAArticuloTableNewRecord(DataSet: TDataSet);
begin
     ClaseAArticuloTableCodigoArticulo.Value := MntArtForm.ArticuloFields.Codigo.Value;
     ClaseAArticuloTableNroClase.Value := tcClaseA;
end;

procedure TMntArtTvrFrame.ClaseAArticuloTableViewCodigoPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClases( [ tcClaseA, Sender.EditingValue ] );
end;

procedure TMntArtTvrFrame.ClaseAArticuloTableViewCodigoPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClases1( tcClaseA, Sender );
end;

procedure TMntArtTvrFrame.ClaseAArticuloTableViewCodigoPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ClaseAArticuloTable.Editing and
          not ClaseAArticuloTableViewController.ControllerPostingRecord and
          ( ClaseAArticuloTableView.DataController.FindRecordIndexByKey( DisplayValue )<>-1 )
     then begin
          Error := True;
          ErrorText := RsMsg8;
          end
     else Clase.Valida( tcClaseA, False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntArtTvrFrame.ClaseAArticuloTableViewControllerBeforeRowShift(Sender: TObject);
begin
     If   ClaseATableNroOrden.Value<=0
     then ReordenaClases( ClaseATable, ClaseATableNroOrden );
end;

procedure TMntArtTvrFrame.ClaseAArticuloTableViewControllerUserSelection(Sender: TObject; var AHandled: Boolean);
begin
     var RecordIndex := ClaseAArticuloTableView.DataController.FocusedRecordIndex;
     If   RecordIndex>=0
     then begin
          var RecData := ClaseAArticuloTableView.ViewData.Records[ RecordIndex ];
          RecData.Selected := not RecData.Selected;
          end;
end;

procedure TMntArtTvrFrame.ClaseAArticuloTableViewSelectionChanged(Sender: TcxCustomGridTableView);

var  ExisteRegistro : Boolean;
     RecordIndex : SmallInt;
     Selected : Boolean;

begin
     If   ClaseAArticuloGrid.IsFocused and not ClaseATable.ShiftingRecords
     then begin
          RecordIndex := Sender.DataController.FocusedRecordIndex;
          If   RecordIndex>=0
          then begin
               Selected := Sender.ViewData.Records[ RecordIndex ].Selected;
               ExisteRegistro := ClaseAArticuloTable.FindKey( [ MntArtForm.ArticuloFields.Codigo.Value, tcClaseA, ClaseATableCodigo.Value ] );
               If   Selected
               then begin
                    If   not ExisteRegistro
                    then begin
                         ClaseAArticuloTable.Append;
                         ClaseAArticuloTableCodigoArticulo.Value := MntArtForm.ArticuloFields.Codigo.Value;
                         ClaseAArticuloTableNroClase.Value := tcClaseA;
                         ClaseAArticuloTableCodigoClase.Value := ClaseATableCodigo.Value;
                         ClaseAArticuloTable.Post;
                         end;
                    end
               else If   ExisteRegistro
                    then ClaseAArticuloTable.Delete;
               end;
          end;
end;


destructor TMntArtTvrFrame.Destroy;
begin
     If   Assigned( MntArtForm )
     then With MntArtForm do
            begin
            OnActualizaEstadoComponentes.Remove( DoActualizaEstadoComponentes );
            OnArticuloBeforePost.Remove( DoArticuloBeforePost );
            OnTarifaVentasBeforePost.Remove( DoArticuloBeforePost );
            OnPageChanged.Remove( TMntArtTvrFrame.Wrapper.Execute );
            end;
     inherited;
end;

procedure TMntArtTvrFrame.DoActualizaEstadoComponentes;

procedure ActualizaClasesSeleccionadas( CodigoArticulo           : String;
                                        NroClase                 : SmallInt;
                                        TableView                : TcxGridDBTableView;
                                        ClaseArticuloColumnIndex : smallInt;
                                        ClaseArticuloTable       : TnxeTable );
begin

     // CodigoArticulo;NroClase;CodigoClase

     With TableView do
       For var RecordIndex := 0 to DataController.RecordCount - 1 do
         begin
         var RecordData := ViewData.Records[ RecordIndex ];
         var Codigo := RecordData.Values[ ClaseArticuloColumnIndex ];
         var ExisteRegistro := ClaseArticuloTable.FindKey( [ CodigoArticulo, NroClase, Codigo ] );
         RecordData.Selected := ExisteRegistro;
         end;

end;

begin

     With MntArtForm do
       If   FPageInitialized and
            DataModule00.TiendaVirtual and
            Assigned( ArticuloFields )
       then begin

            SetGroupBoxControlsEnabled( ParametrosTiendaGroupBox,
                                        ArticuloFields.VisibleTienda.Value,
                                        { Exceptions } [ CategoriasArticuloGridTableViewController ],
                                        { Force } True );

            If   ArticuloFields.VisibleTienda.Value
            then begin
                 var ArticuloIncluidoEnUnGrupo := Tienda_CodigoArticuloAgrupadoCtrl.Text<>'';
                 var EsUnArticuloAgrupado := Articulo.EsUnArticuloAgrupado( ArticuloFields.Codigo.Value );
                 Tienda_CodigoArticuloAgrupadoCtrl.Enabled := not EsUnArticuloAgrupado;
                 Tienda_VisibleIndividualmenteCtrl.Enabled := ArticuloIncluidoEnUnGrupo;
                 Tienda_ComentariosClientesCtrl.Enabled := not EsUnArticuloAgrupado;
                 Tienda_NoPublicarClasesCtrl.Enabled := ExisteClaseA;
                 end;

            // CategoriasArticulo

            // CodigoArticulo;CodigoCategoria;NroOrden

            CategoriasArticuloTable.SetRange( [ MntArtForm.ArticuloFields.Codigo.Value ] );
            CategoriasArticuloDataSource.Enabled := PageControl.ActivePage=TiendaVirtualTabSheet;

            If   ClasesArticuloPanel.Visible
            then begin

                 ClaseAPanel.Visible := ExisteClaseA and ArticuloFields.VisibleTienda.Value and not ArticuloFields.Tienda_NoPublicarClases.Value;
                 ClaseBPanel.Visible := ExisteClaseB and ArticuloFields.VisibleTienda.Value and not ArticuloFields.Tienda_NoPublicarClases.Value;

                 If   ExisteClaseA
                 then begin


                      // NroClase;NroOrden

                      ClaseATable.SetRange( [ tcClaseA, 0 ], [ tcClaseA, MaxSmallint ] );
                      ClaseADatasource.Enabled := True;

                      ActualizaClasesSeleccionadas( MntArtForm.ArticuloFields.Codigo.Value,
                                                    tcClaseA,
                                                    ClaseAArticuloTableView,
                                                    ClaseAArticuloTableViewCodigo.Index,
                                                    ClaseAArticuloTable );

                      If   ExisteClaseB
                      then begin
                           ClaseBTable.SetRange( [ tcClaseB, 0 ], [ tcClaseB, MaxSmallInt ] );
                           ClaseBDatasource.Enabled := True;

                           ActualizaClasesSeleccionadas( MntArtForm.ArticuloFields.Codigo.Value,
                                                         tcClaseB,
                                                         ClaseBArticuloTableView,
                                                         ClaseBArticuloTableViewCodigo.Index,
                                                         ClaseBArticuloTable );

                           end;


                      end;

                 end;

            If   ArticuloFields.VisibleTienda.Value
            then ActualizarEnLaTiendaCtrl.EditValue := RegistroActualizacionTienda.PendienteActualizar( rgaArticulo, ArticuloFields.Codigo.Value )
            else ActualizarEnLaTiendaCtrl.EditValue := False;

            // Tarifas de venta

            If   Assigned( MntArtTvaFrame )
            then With MntArtTvaFrame do
                   begin
                   TarifaVentasTableViewDisponible.Visible := ( ParametrosTiendaVirtualModule.PublicarClasesComoConfiguraciones ) and not Tienda_NoPublicarClasesCtrl.Checked;
                   TarifaVentasTableViewCantidadMinima.Visible := not TarifaVentasTableViewDisponible.Visible;
                   TarifaVentasTableViewPrecio.Visible := not TarifaVentasTableViewDisponible.Visible;
                   TarifaVentasTableViewRecargo.Visible := not TarifaVentasTableViewDisponible.Visible and DataModule00.DmEmpresaFields.Ventas_Recargos.Value;
                   TarifaVentasTableViewDescuento.Visible := not TarifaVentasTableViewDisponible.Visible;
                   end;

            end;

end;

procedure TMntArtTvrFrame.Tienda_NoPublicarClasesCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     ActualizarEnLaTiendaCtrl.Enabled := Tienda_NoPublicarClasesCtrl.Checked;
     If   not ActualizarEnLaTiendaCtrl.Enabled
     then ActualizarEnLaTiendaCtrl.Checked := False;
end;

procedure TMntArtTvrFrame.DoArticuloBeforePost( Dataset : TDataset );

procedure DesmarcaActualizacion;
begin
      With MntArtForm do
       begin
       RegistroActualizacion.Edita( rgaArticulo, ArticuloFields.Codigo.Value );
       try
         RegistroActualizacion.RegistroActualizacionFields.Actualizado.Value := True;
         RegistroActualizacion.RegistroActualizacionFields.DatasetPost;
       finally
         RegistroActualizacion.RegistroActualizacionFields.DatasetCancel;
         end;
       end;
end;

begin
     With MntArtForm do
       begin

       var PendienteActualizar := RegistroActualizacionTienda.PendienteActualizar( rgaArticulo, ArticuloFields.Codigo.Value );

       // Actualmente está pendiente de actualizar (lo estaba antes de entrar en el registro),
       // pero el usuario ha desmarcado ActualizarEnLaTiendaCtrl

       If   PendienteActualizar and not ActualizarEnLaTiendaCtrl.Checked
       then begin
            DesmarcaActualizacion;
            Exit;
            end
       else If   not ActualizarEnLaTiendaCtrl.Checked and
                 not ArticuloFields.Tienda_NoPublicarClases.Value
            then If   Clase.CombinacionesClasesArticulo( ArticuloFields.Codigo.Value )>20   // Si hay más de 20 combinaciones no se marca automáticamente, hay que hacerlo a mano
                 then Exit;

       TiendaVirtualModule.ArticuloModificado( ArticuloFields.Codigo.Value, ArticuloFields.Imagen.Modified );
       end;
end;

initialization

  AddProcedure( imOnCreateComponent, idMntArtForm, SetupLink );
  AddProcedure( imOnDestroyComponent, idMntArtForm, RemoveLink );

end.

