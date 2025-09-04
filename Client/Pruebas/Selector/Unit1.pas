unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinsDefaultPainters, Vcl.Menus, cxStyles, dxSkinscxPCPainter, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxNavigator, Data.DB, cxDBData, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Vcl.StdCtrls, cxButtons, cxTextEdit, cxLabel,
  dxmdaset, Vcl.ExtCtrls, cxGroupBox, cxTrackBar, dxZoomTrackBar,
  dxDateRanges, dxScrollbarAnnotations;

type
  TForm1 = class(TForm)
    MemData: TdxMemData;
    MemDataCodigo: TStringField;
    MemDataDescripcion: TStringField;
    DataSource1: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TableViewCodigo: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    DescripcionLabel: TcxLabel;
    ModoButton: TcxButton;
    UltimoTextEdit: TcxTextEdit;
    Panel1: TPanel;
    PrimerTextEdit: TcxTextEdit;
    RelacionButton: TcxButton;
    procedure RelacionButtonClick(Sender: TObject);
    procedure ModoButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    ModoSeleccion : Byte;
    procedure SeleccionaModo( Modo : Byte );
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     If   ssCtrl in Shift
     then If   Key in [ VK_ADD, VK_SUBTRACT]
          then begin
               If   Key=VK_ADD
               then begin
                    If   ModoSeleccion=2
                    then ModoSeleccion := 0
                    else Inc( ModoSeleccion );
                    end
               else If   Key=VK_SUBTRACT
                    then begin
                    If   ModoSeleccion=0
                    then ModoSeleccion := 2
                    else Dec( ModoSeleccion );
                    end;
               SeleccionaModo( ModoSeleccion );
               end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
     SeleccionaModo( 0 );
end;

procedure TForm1.ModoButtonClick(Sender: TObject);
begin
     Inc( ModoSeleccion );
     If   ModoSeleccion=3
     then ModoSeleccion := 0;
     SeleccionaModo( ModoSeleccion );
end;

procedure TForm1.SeleccionaModo( Modo : Byte );
begin
     ModoSeleccion := Modo;
     case ModoSeleccion of
       0 : begin
           ModoButton.Caption := '.';
           RelacionButton.Visible := False;
           PrimerTextEdit.Visible := True;
           UltimoTextEdit.Visible := False;
           Grid.Visible := False;
           PrimerTextEdit.SetFocus;
           end;
       1 : begin
           ModoButton.Caption := '...';
           RelacionButton.Visible := False;
           PrimerTextEdit.Visible := True;
           UltimoTextEdit.Visible := True;
           Grid.Visible := False;
           UltimoTextEdit.SetFocus;
           end;
       2 : begin
           ModoButton.Caption := '=';
           RelacionButton.Visible := True;
           PrimerTextEdit.Visible := False;
           UltimoTextEdit.Visible := False;
           Grid.Visible := True;
           Grid.SetFocus;
           RelacionButton.Caption := 'Cerrar';
           end;
       end;
end;

procedure TForm1.RelacionButtonClick(Sender: TObject);
begin
     Grid.Visible := not Grid.Visible;
     If   Grid.Visible
     then RelacionButton.Caption := 'Cerrar'
     else RelacionButton.Caption := 'Relación';
end;

end.
