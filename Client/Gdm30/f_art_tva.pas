unit f_art_tva;

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

  Gim30Fields, cxSplitter;

type
  TMntArtTvaFrame = class(TFrame)
    FramePanel: TcxGroupBox;
    TarifaVentasDataSource: TDataSource;
    TarifaVentasCachedDataset: TnxeCachedDataSet;
    TarifaVentasCachedDatasetCodigo: TWideStringField;
    TarifaVentasCachedDatasetDescripcion: TWideStringField;
    TarifaVentasCachedDatasetTipo: TSmallintField;
    TarifaVentasCachedDatasetCodigoTarifa: TWideStringField;
    TarifaVentasCachedDatasetCodigoArticulo: TWideStringField;
    TarifaVentasCachedDatasetReferencia: TWideStringField;
    TarifaVentasCachedDatasetCantidadMinima: TBCDField;
    TarifaVentasCachedDatasetPrecio: TFloatField;
    TarifaVentasCachedDatasetRecargo: TBCDField;
    TarifaVentasCachedDatasetDescuento: TBCDField;
    TarifaVentasCachedDatasetDisponible: TBooleanField;
    TarifaVentasQuery: TnxeQuery;
    TarifaVentasTable: TnxeTable;
    TarifaVentasGrid: TcxGrid;
    TarifaVentasTableView: TcxGridDBTableView;
    TarifaVentasTableViewCodigo: TcxGridDBColumn;
    TarifaVentasTableViewDescripcion: TcxGridDBColumn;
    TarifaVentasTableViewDisponible: TcxGridDBColumn;
    TarifaVentasTableViewCantidadMinima: TcxGridDBColumn;
    TarifaVentasTableViewPrecio: TcxGridDBColumn;
    TarifaVentasTableViewRecargo: TcxGridDBColumn;
    TarifaVentasTableViewDescuento: TcxGridDBColumn;
    TarifaVentasGridLevel: TcxGridLevel;
    GridTableViewController1: TGridTableViewController;
    procedure TarifaVentasCachedDatasetBeforePost(DataSet: TDataSet);
    procedure TarifaVentasQueryAfterOpen(DataSet: TDataSet);
  private

      TarifaVentasFields : TTarifaVentasFields;

      FPageInitialized : Boolean;

      procedure DoActualizaEstadoComponentes;

  protected

     class var Wrapper : TProcedureWrapper;

     class procedure DoOnMntArtPageChanged( Value : TControl );

  public

     destructor Destroy; override;

  end;

var MntArtTvaFrame : TMntArtTvaFrame = nil;

procedure SetupFrame;  // Se llama desde otra pestaña configurable

implementation

uses AppManager,
     EnterpriseDataAccess,

     Gdm00Dm,

     dm_art,

     dmi_pga,

     a_art,

     cx_art,

     b_msg;

{$R *.dfm}

resourceString
       RsMsg1 = '';

procedure SetupLink;
begin
     If   DataModule00.DmEmpresaFields.Cliente_TarCodigo.Value and Assigned( MntArtForm )
     then begin
          TMntArtTvaFrame.Wrapper := TProcedureWrapper.Create( TMntArtTvaFrame.DoOnMntArtPageChanged );
          MntArtForm.OnPageChanged.Add( TMntArtTvaFrame.Wrapper.Execute );
          end;
end;

procedure RemoveLink;
begin
     FreeAndNil( TMntArtTvaFrame.Wrapper );
     FreeAndNil( MntArtTvaFrame );
end;

procedure SetupFrame;
begin

     If   Assigned( MntArtForm )
     then begin

          MntArtTvaFrame := TMntArtTvaFrame.Create( MntArtForm );

          With MntArtTvaFrame do
            begin

            TarifaVentasFields := TTarifaVentasFields.Create( TarifaVentasTable );

            // Colocando los paneles en su posición dentro de la ventana de edición

            FramePanel.Parent := MntArtForm.TarifaVentasTabSheet;
            FramePanel.Align := alClient;

            With DataModule00.DmEmpresaFields do
              begin
              SetColumnDecimals( TarifaVentasTableViewCantidadMinima, Ventas_DecCantidad.Value );
              SetColumnDecimals( TarifaVentasTableViewPrecio, Ventas_DecPrecio.Value );
              SetColumnDecimals( TarifaVentasTableViewRecargo, Ventas_DecPrecio.Value );
              SetColumnDecimals( TarifaVentasTableViewDescuento, Ventas_DecDto.Value );

              TarifaVentasTableViewRecargo.Visible := Ventas_Recargos.Value;
              end;

            MntArtForm.OnActualizaEstadoComponentes.Add( DoActualizaEstadoComponentes );

            // La pestaña de la tienda virtual modifica ésta cuando se crea. La inicializo por si acaso.

            If   DataModule00.TiendaVirtual
            then MntArtForm.OnPageChanged.Invoke( MntArtForm.TiendaVirtualTabSheet );

            FPageInitialized := True;
            end;

          end;
end;

// Si es la primera vez que se activa la página se crea el Frame, si ya existe se actualizan los componentes

class procedure TMntArtTvaFrame.DoOnMntArtPageChanged( Value : TControl );
begin
     With MntArtForm do
       begin
       If   Value=TarifaVentasTabSheet
       then If   not Assigned( MntArtTvaFrame )
            then SetupFrame;
       If   Assigned( MntArtTvaFrame )
       then MntArtTvaFrame.DoActualizaEstadoComponentes;
       end;
end;

procedure TMntArtTvaFrame.TarifaVentasCachedDatasetBeforePost(DataSet: TDataSet);

var  ExisteTarifaArticulo : Boolean;

begin
     With TarifaVentasTable, TarifaVentasFields do
       begin

       ExisteTarifaArticulo := FindKey( [ MntArtForm.ArticuloFields.Codigo.Value, rtvTarifaArticulo, TarifaVentasCachedDatasetCodigo.Value ] );

       If   not TarifaVentasTableViewDisponible.Visible and
            ( TarifaVentasCachedDatasetCantidadMinima.Value=0.0 ) and
            ( TarifaVentasCachedDatasetPrecio.Value=0.0 ) and
            ( TarifaVentasCachedDatasetRecargo.Value=0.0 ) and
            ( TarifaVentasCachedDatasetDescuento.Value=0.0 )
       then begin
            If   ExisteTarifaArticulo
            then TarifaVentasTable.Delete;
            end
       else begin

            If   not ExisteTarifaArticulo
            then begin
                 Append;
                 Tipo.Value := rtvTarifaArticulo;
                 CodigoTarifa.Value := TarifaVentasCachedDatasetCodigo.Value;
                 CodigoArticulo.Value := MntArtForm.ArticuloFields.Codigo.Value;
                 end
            else Edit;

            If   TarifaVentasTableViewDisponible.Visible
            then Disponible.Value := TarifaVentasCachedDatasetDisponible.Value
            else begin
                 CantidadMinima.Value := TarifaVentasCachedDatasetCantidadMinima.Value;
                 Precio.Value := TarifaVentasCachedDatasetPrecio.Value;
                 Recargo.Value := TarifaVentasCachedDatasetRecargo.Value;
                 Descuento .Value := TarifaVentasCachedDatasetDescuento.Value;
                 end;

            MntArtForm.OnTarifaVentasBeforePost.Invoke( Dataset );

            ApplicationContainer.ProcessRecordChangesLog( TarifaVentasCachedDataset, frdTarifaVentas, TarifaVentasTable );

            Post;
            end;

         end;
end;

procedure TMntArtTvaFrame.TarifaVentasQueryAfterOpen(DataSet: TDataSet);
begin
     With TarifaVentasCachedDataset do
       begin
       Close;
       Open;
       end;
end;

destructor TMntArtTvaFrame.Destroy;
begin
     If   Assigned( MntArtForm )
     then MntArtForm.OnPageChanged.Remove( TMntArtTvaFrame.Wrapper.Execute );
     inherited;
end;

procedure TMntArtTvaFrame.DoActualizaEstadoComponentes;
begin
     If   FPageInitialized
     then begin
          TarifaVentasQuery.Active := MntArtForm.PageControl.ActivePage=MntArtForm.TarifaVentasTabSheet;
          TarifaVentasDataSource.Enabled := TarifaVentasQuery.Active;

          TarifaVentasQuery.RefreshQuery( { OnlyIfActive } True );
          end;
end;

initialization

  AddProcedure( imOnCreateComponent, idMntArtForm, SetupLink );
  AddProcedure( imOnDestroyComponent, idMntArtForm, RemoveLink );

end.

