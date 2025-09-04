
unit b_atf;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, dxmdaset,

  dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel, cxGroupBox, cxRadioGroup, cxCheckBox, cxIndexedComboBox,

  Gim70Fields;


type
    TBoxAtfForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxGroupBox1: TcxGroupBox;
    cxLabel2: TcxLabel;
    RelacionOperacionesTable: TnxeTable;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    private

      RelacionOperacionesFields : TRelacionOperacionesFields;
    protected
    class var
      OperacionFields : TOperacionFields;

    public
      procedure DoProcess;
    end;

var  BoxAtfForm : TBoxAtfForm = nil;

procedure ActualizarTiemposOperacion( OperacionFields : TOperacionFields );


implementation

uses   DateUtils,
       LibUtils,
       AppManager,
       EnterpriseDataAccess,

       dm_art,

       b_pro,
       f_prg;

{$R *.DFM}

resourceString
       RsMsg1 = 'No se ha actualizado ninguna relación de operaciones.';

procedure ActualizarTiemposOperacion( OperacionFields : TOperacionFields );
begin
     TBoxAtfForm.OperacionFields := OperacionFields;
     CreateEditForm( TBoxAtfForm, BoxAtfForm );
end;

procedure TBoxAtfForm.FormManagerInitializeForm;
begin
     RelacionOperacionesFields := TRelacionOperacionesFields.Create( RelacionOperacionesTable );
end;

procedure TBoxAtfForm.FormManagerOkButton;
begin
     CreateProcessForm( DoProcess, Caption );
end;

procedure TBoxAtfForm.DoProcess;

var  Actualizado : Boolean;

function StrClase( Codigo : String ) : String;
begin
     If   Codigo=''
     then Result := ''
     else Result := RightPad( Codigo, 3 ) + ', ';
end;

begin

     // CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;Proceso

     Actualizado := False;
     With RelacionOperacionesTable do
       begin
       First;
       While not Eof and not ProcessFrame.Canceled do
         begin
         If   RelacionOperacionesFields.CodigoOperacion.Value=OperacionFields.Codigo.Value
         then begin
              Edit;
              RelacionOperacionesFields.TiempoPreparacion.Value := OperacionFields.Preparacion.Value;
              RelacionOperacionesFields.TiempoFabricacion.Value := OperacionFields.Fabricacion.Value;
              RelacionOperacionesFields.UnidadesTiempo.Value := OperacionFields.UnidadesTiempo.Value;
              ShowNotification( ntInformation, RelacionOperacionesFields.CodigoArticulo.Value + ', ' +
                                               StrClase( RelacionOperacionesFields.CodigoClaseA.Value ) +
                                               StrClase( RelacionOperacionesFields.CodigoClaseB.Value ) +
                                               StrClase( RelacionOperacionesFields.CodigoClaseC.Value ) +
                                               Articulo.Descripcion( RelacionOperacionesFields.CodigoArticulo.Value ) );
              Post;
              Actualizado := True;
              end;
         Next;
         end;
       If   not Actualizado
       then ShowNotification( ntWarning, RsMsg1 );
       end;
end;

end.

