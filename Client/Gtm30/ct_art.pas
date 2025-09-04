
unit ct_art;

interface

uses Forms, StdCtrls, Controls, Buttons, Classes, Mask,
     ExtCtrls, ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, cxControls,
     cxContainer, cxEdit, cxTextEdit, cxDBEdit, nxdb, DataManager, DB,
     cxMaskEdit, cxDropDownEdit, cxCalendar, cxCheckBox,
     dxSkinsCore, dxSkinsDefaultPainters, cxLabel, cxGraphics,
     cxLookAndFeels, cxGroupBox, dxmdaset,
     cxButtonEdit, cxLookupEdit, cxDBLookupEdit, cxDisplayButtonEdit,

     AppContainer,
     AppForms,
     LibUtils, dxGallery, dxGalleryControl, System.ImageList, Vcl.ImgList,
  cxClasses, cxSpinEdit, cxCalc, cxDBLabel;

type
  TCBoxArtForm = class( TgxForm )
    dxGalleryControl1: TdxGalleryControl;
    dxGalleryControl1Group1: TdxGalleryControlGroup;
    dxGalleryControl1Group2: TdxGalleryControlGroup;
    ImageList1: TImageList;
    dxGalleryControl1Group1Item1: TdxGalleryControlItem;
    dxGalleryControl1Group1Item2: TdxGalleryControlItem;
    dxGalleryControl1Group1Item3: TdxGalleryControlItem;
    dxGalleryControl1Group1Item4: TdxGalleryControlItem;
    dxGalleryControl1Group1Item5: TdxGalleryControlItem;
    dxGalleryControl1Group2Item1: TdxGalleryControlItem;
    dxGalleryControl1Group2Item2: TdxGalleryControlItem;
    dxGalleryControl1Group2Item3: TdxGalleryControlItem;
    dxGalleryControl1Group2Item4: TdxGalleryControlItem;
    TopPanel: TcxGroupBox;
    DeleteButton: TgBitBtn;
    DataSource: TDataSource;
    Data: TgxMemData;
    cxLabel1: TcxLabel;
    CantidadLabel: TcxDBLabel;
    DataCantidad: TIntegerField;
    MenosButton: TgBitBtn;
    MasButton: TgBitBtn;
    CantidadCalcEdit: TcxDBCalcEdit;
    AceptarButton: TgBitBtn;
    CantidadPanel: TcxGroupBox;
    procedure CloseButtonClick(Sender: TObject);
    procedure MenosButtonClick(Sender: TObject);
    procedure MasButtonClick(Sender: TObject);
    procedure CantidadLabelClick(Sender: TObject);
    procedure CantidadCalcEditPropertiesChange(Sender: TObject);

  private

  protected

  public

  end;

procedure ConsultaArticulos;

implementation

{$R *.dfm}

uses   Windows,
       SysUtils,

       AppManager;

var CBoxArtForm : TCBoxArtForm = nil;

procedure ConsultaArticulos;
begin
     If   not Assigned( CBoxArtForm )
     then begin
          CBoxArtForm := TCBoxArtForm.Create( Application.MainForm );
          With CBoxArtForm do
            begin
            Parent := Application.MainForm; // ApplicationContainer.DesktopPanel;


            end
          ;
          end;

     With CBoxArtForm do
       begin
       Data.Active := True;
       Data.Edit;
       DataCantidad.Value := 1;
       Visible := True;
       BringToFront;
       end;
end;

procedure TCBoxArtForm.CantidadCalcEditPropertiesChange(Sender: TObject);
begin
     If   Data.State=dsEdit
     then DataCantidad.Value := CantidadCalcEdit.EditingValue;
end;

procedure TCBoxArtForm.CantidadLabelClick(Sender: TObject);
begin
     CantidadCalcEdit.DroppedDown := True;
end;

procedure TCBoxArtForm.CloseButtonClick(Sender: TObject);
begin
     CBoxArtForm.Visible := False;
end;

procedure TCBoxArtForm.MasButtonClick(Sender: TObject);
begin
     DataCantidad.Value := DataCantidad.Value + 1;
end;

procedure TCBoxArtForm.MenosButtonClick(Sender: TObject);
begin
     If   DataCantidad.Value>1
     then DataCantidad.Value := DataCantidad.Value - 1;
end;

initialization
   // AddProcedure( imStartUp, 0, ConsultaArticulos );

end.
