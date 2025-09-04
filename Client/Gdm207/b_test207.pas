
unit b_test207;

interface

uses StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics,
     Menus, cxLookAndFeelPainters, cxButtons, cxControls,
     cxContainer, cxEdit, cxTextEdit, cxDBEdit, DB, dxmdaset, DataManager,
     cxGraphics, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters, cxLabel,
     cxGroupBox, cxMaskEdit, cxDropDownEdit, cxIndexedComboBox, cxRadioGroup,

     AppManager,
     AppForms,
     AppContainer,

     Gim30Fields;


type

  TBoxTest207Form = class(TgxForm)
    ButtonsPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Data: TgxMemData;
    DataSource: TDataSource;
    Label2: TcxLabel;
    TipoRegistroCtrl: TcxDBIndexedComboBox;
    DataTipoRegistro: TSmallintField;
    DataProceso: TSmallintField;
    ProcesoCtrl: TcxDBRadioGroup;
    cxLabel2: TcxLabel;
    cxGroupBox2: TcxGroupBox;
    DataCodigo: TStringField;
    cxLabel1: TcxLabel;
    CodigoCtrl: TcxDBTextEdit;
    cxLabel3: TcxLabel;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
  private
  protected
  class procedure Pruebas( Sender : TObject );
  class var OnSelected : TSimpleEvent;
  procedure ExecuteProcess;
  public
  end;

var  BoxTest207Form: TBoxTest207Form = nil;

procedure PruebasTienda;

implementation

{$R *.DFM}

uses   ClipBrd,

       dxBar,

       Gdm30Frm,

       cx_art,

       dm_art,
       dm_tvr,
       dm_ptv,
       dm_rea207,
       dm_sdt207,

       b_pro,
       f_prg;

resourceString
    RsMsg1 = 'El proceso se ha realizado correctamente';

class procedure TBoxTest207Form.Pruebas( Sender : TObject );
begin
     CreateEditForm( TBoxTest207Form, BoxTest207Form, Gds30Frm.VentasSection, True );
end;

procedure PruebasTienda;
begin
     CreateEditForm( TBoxTest207Form, BoxTest207Form, [] );
end;

procedure TBoxTest207Form.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     case DataTipoRegistro.Value of
       0 : ConsultaArticulos( scAmbas, False, Sender );
       end;
end;

procedure TBoxTest207Form.CodigoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     case DataTipoRegistro.Value of
       0 : Articulo.Valida( Sender, DisplayValue, ErrorText, Error );
       end;
end;

procedure TBoxTest207Form.FormManagerInitializeForm;
begin
     DataProceso.Value := 0;
     DataTipoRegistro.Value := 0;
end;

procedure TBoxTest207Form.FormManagerOkButton;
begin
     CreateProcessForm( ExecuteProcess, Caption );
end;

procedure TBoxTest207Form.ExecuteProcess;

var  JSONText : String;

begin
     JSONText := '';
     {
     If   ParametrosTiendaVirtual.GetAuthorization
     then begin
          case DataProceso.Value of
            0 : begin
                case DataTipoRegistro.Value of
                  0 : begin
                      JSONText := SincronizacionTiendaMagento.ObtenArticulo( DataCodigo.Value );

                      end;
                  1 : ;
                  end;
                end;
            end;

          If   JSONText=''
          then ProcessFrame.AddMsg( ntWarning, 'El registro no existe en la tienda' )
          else begin
               ClipBoard.AsText := JSONText;
               ProcessFrame.AddMsg( ntInformation, 'El resultado está en el portapapeles.' )
               end;

          end;
     }
end;

procedure SetupTestSection;
begin
     With Gds30Frm do  // Se supone que existe, claro
       begin
       PruebasTiendaItem.Visible := ivAlways;
       PruebasTiendaItem.OnClick := TboxTest207Form.Pruebas;
       end;
end;

initialization
     AddProcedure( imStartUp, 0, SetupTestSection );

end.
