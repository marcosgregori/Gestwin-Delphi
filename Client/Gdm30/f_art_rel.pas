unit f_art_rel;

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
  TMntArtRelFrame = class(TFrame)
    FramePanel: TcxGroupBox;
    ArticulosRelacionadosDataSource: TDataSource;
    ArticulosRelacionadosTable: TnxeTable;
    ArticulosRelacionadosTableCodigo: TWideStringField;
    ArticulosRelacionadosTableTipo: TSmallintField;
    ArticulosRelacionadosTableNroOrden: TSmallintField;
    ArticulosRelacionadosTableCodigoArticuloRelacionado: TWideStringField;
    ArticulosRelacionadosTableDescripcion: TStringField;
    ArticulosAlternativosDataSource: TDataSource;
    ArticulosAlternativosTable: TnxeTable;
    ArticulosAlternativosTableCodigo: TWideStringField;
    ArticulosAlternativosTableTipo: TSmallintField;
    ArticulosAlternativosTableNroOrden: TSmallintField;
    ArticulosAlternativosTableCodigoArticuloRelacionado: TWideStringField;
    ArticulosAlternativosTableDescripcion: TStringField;
    cxGroupBox24: TcxGroupBox;
    cxGroupBox23: TcxGroupBox;
    ArticulosRelacionadosGrid: TcxGrid;
    ArticulosRelacionadosTableView: TcxGridDBTableView;
    ArticulosRelacionadosTableViewCodigoArticuloRelacionado: TcxGridDBColumn;
    ArticulosRelacionadosTableViewDescripcion: TcxGridDBColumn;
    ArticulosRelacionadosGridLevel: TcxGridLevel;
    GridTableViewController4: TGridTableViewController;
    cxGroupBox25: TcxGroupBox;
    cxGroupBox26: TcxGroupBox;
    ArticulosAlternativosGrid: TcxGrid;
    ArticulosAlternativosTableView: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    ArticulosAlternativosGridLevel: TcxGridLevel;
    GridTableViewController5: TGridTableViewController;
    cxSplitter1: TcxSplitter;
    procedure ArticulosRelacionadosTableApplyMasterRange(
      DataSet: TDataSet);
    procedure ArticulosAlternativosTableCalcFields(DataSet: TDataSet);
    procedure ArticulosAlternativosTableNewRecord(DataSet: TDataSet);
    procedure ArticulosAlternativosTableApplyMasterRange(
      DataSet: TDataSet);
    procedure ArticulosRelacionadosTableCalcFields(DataSet: TDataSet);
    procedure ArticulosRelacionadosTableNewRecord(DataSet: TDataSet);
    procedure ArticulosValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure ArticulosQueryRequest(
      Sender: TcxCustomEdit);
  private

    FPageInitialized : Boolean;

    procedure DoActualizaEstadoComponentes;


  protected

    class var Wrapper : TProcedureWrapper;

    class procedure DoOnMntArtPageChanged( Value : TControl );

  public

    destructor Destroy; override;

  end;

var MntArtRelFrame : TMntArtRelFrame = nil;

implementation

uses AppManager,
     EnterpriseDataAccess,

     Gdm00Dm,

     dm_art,

     a_art,

     cx_art,

     b_msg;

{$R *.dfm}

resourceString
       RsMsg1 = '';

procedure SetupLink;
begin
     If   DataModule00.DmEmpresaFields.Articulo_ArticulosRelacionados.Value and Assigned( MntArtForm )
     then begin
          TMntArtRelFrame.Wrapper := TProcedureWrapper.Create( TMntArtRelFrame.DoOnMntArtPageChanged );
          MntArtForm.OnPageChanged.Add( TMntArtRelFrame.Wrapper.Execute );
          end;
end;

procedure RemoveLink;
begin
     FreeAndNil( TMntArtRelFrame.Wrapper );
     FreeAndNil( MntArtRelFrame );
end;

procedure SetupFrame;
begin

     If   Assigned( MntArtForm )
     then begin

          MntArtRelFrame := TMntArtRelFrame.Create( MntArtForm );

          With MntArtRelFrame do
            begin

            // Colocando los paneles en su posición dentro de la ventana de edición

            FramePanel.Parent := MntArtForm.RelacionesTabSheet;
            FramePanel.Align := alClient;

            With MntArtForm do
              begin

              OnActualizaEstadoComponentes.Add( DoActualizaEstadoComponentes );

              ArticulosRelacionadosDataSource.Enabled := True;
              ArticulosRelacionadosTable.Open;
              ArticulosRelacionadosTable.OnApplyMasterRange( ArticulosRelacionadosTable );

              ArticulosAlternativosDataSource.Enabled := True;
              ArticulosAlternativosTable.Open;
              ArticulosAlternativosTable.OnApplyMasterRange( ArticulosAlternativosTable );

              end;

            FPageInitialized := True;
            end;

          end;
end;

// Si es la primera vez que se activa la página se crea el Frame, si ya existe se actualizan los componentes

class procedure TMntArtRelFrame.DoOnMntArtPageChanged( Value : TControl );
begin
     With MntArtForm do
       If   Value=RelacionesTabSheet
       then begin
            If   not Assigned( MntArtRelFrame )
            then SetupFrame;
            MntArtRelFrame.DoActualizaEstadoComponentes;
            end;

end;

procedure TMntArtRelFrame.ArticulosAlternativosTableApplyMasterRange(DataSet: TDataSet);
begin
     If   ArticulosAlternativosTable.Active
     then ArticulosAlternativosTable.SetRange( [ MntArtForm.ArticuloFields.Codigo.Value, 1 ] );
end;

procedure TMntArtRelFrame.ArticulosAlternativosTableCalcFields(DataSet: TDataSet);
begin
     ArticulosAlternativosTableDescripcion.Value := Articulo.Descripcion( ArticulosAlternativosTableCodigoArticuloRelacionado.Value, False );
end;

procedure TMntArtRelFrame.ArticulosAlternativosTableNewRecord(DataSet: TDataSet);
begin
          ArticulosAlternativosTableTipo.Value := 1;
end;

procedure TMntArtRelFrame.ArticulosRelacionadosTableApplyMasterRange(DataSet: TDataSet);
begin
     If   ArticulosRelacionadosTable.Active
     then ArticulosRelacionadosTable.SetRange( [ MntArtForm.ArticuloFields.Codigo.Value, 0 ] );
end;

procedure TMntArtRelFrame.ArticulosRelacionadosTableCalcFields(DataSet: TDataSet);
begin
     ArticulosRelacionadosTableDescripcion.Value := Articulo.Descripcion( ArticulosRelacionadosTableCodigoArticuloRelacionado.Value, False );
end;

procedure TMntArtRelFrame.ArticulosRelacionadosTableNewRecord(DataSet: TDataSet);
begin
     ArticulosRelacionadosTableTipo.Value := 0;
end;

procedure TMntArtRelFrame.ArticulosQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, False, Sender );
end;

procedure TMntArtRelFrame.ArticulosValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error );
end;

destructor TMntArtRelFrame.Destroy;
begin
     If   Assigned( MntArtForm )
     then With MntArtForm do
            begin
            OnActualizaEstadoComponentes.Remove( DoActualizaEstadoComponentes );
            OnPageChanged.Remove( TMntArtRelFrame.Wrapper.Execute );
            end;
     inherited;
end;

procedure TMntArtRelFrame.DoActualizaEstadoComponentes;
begin
     //.. If   FPageInitialized ...
end;

initialization

  AddProcedure( imOnCreateComponent, idMntArtForm, SetupLink );
  AddProcedure( imOnDestroyComponent, idMntArtForm, RemoveLink );

end.

