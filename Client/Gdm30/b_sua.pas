
unit b_sua;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons, Mask,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, nxdb,
  dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel, cxGroupBox, dxUIAClasses,

  AppContainer,
  DataManager,

  Gim30Fields;


type
    TBoxSuaForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataSerie: TWideStringField;
    DataNroAlbaranInicial: TIntegerField;
    DataNroAlbaranFinal: TIntegerField;
    gxRangeBox1: TgxRangeBox;
    SerieCtrl: TcxDBTextEdit;
    NroAlbaranInicialCtrl: TcxDBTextEdit;
    NroAlbaranFinalCtrl: TcxDBTextEdit;
    MovimientoTable: TnxeTable;
    Label6: TcxLabel;
    DescSerieFacturacionLabel: TcxLabel;
    Label7: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure NroAlbaranFinalCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure NroAlbaranCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    private

    public

      MovimientoFields : TMovimientoFields;

      procedure DoProcess;
    end;

var BoxSuaForm : TBoxSuaForm = nil;

procedure supresionAlbaranesVenta;


implementation

uses   LibUtils,
       AppManager,
       EnterpriseDataAccess,

       Gdm30Frm,

       dmi_mov,

       dm_sdf,
       dm_mov,

       b_msg,
       b_pro,

       cx_sdf,
       cx_mve, f_prg;

{$R *.DFM}

resourceString
       RsMsg2 = 'Albarán nº %d.';
       RsMsg3 = 'El albarán nº %d no será suprimido porque consta como facturado.';

procedure supresionAlbaranesVenta;
begin
     CreateEditForm( TBoxSuaForm, BoxSuaForm, TGds30Frm.VentasSection, True );
end;

procedure TBoxSuaForm.FormManagerOkButton;
begin
     CreateProcessForm( DoProcess, Caption );
end;

procedure TBoxSuaForm.NroAlbaranFinalCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With NroAlbaranFinalCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := DataNroAlbaranInicial.Value;
end;

procedure TBoxSuaForm.NroAlbaranCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaMovimientosVenta( tmVenta, sdTodos, DataSerie, Sender );
end;

procedure TBoxSuaForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TBoxSuaForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxSuaForm.DoProcess;
begin

     try

       try

        With MovimientoTable do
         begin

         SetRange( [ tmVenta, ApplicationContainer.Ejercicio, DataSerie.Value, DataNroAlbaranInicial.Value ],
                   [ tmVenta, ApplicationContainer.Ejercicio, DataSerie.Value, DataNroAlbaranFinal.Value ] );
         First;
         While not Eof  do
           begin
           If   MovimientoFields.Facturado.Value
           then ProcessFrame.AddMsg( ntWarning, Format( RsMsg3, [ MovimientoFields.NroDocumento.Value ] ) )
           else begin
                Movimiento.SuprimeMovimiento( MovimientoFields.Ejercicio.Value, MovimientoFields.NroOperacion.Value );
                ProcessFrame.AddMsg( ntInformation, Format( RsMsg2, [ MovimientoFields.NroDocumento.Value ] ) );
                end;
           Next;
           end;

         end;

        except on E : Exception do begin
                                   If   not ( E is EDatabaseError )
                                   then ShowException( E, Self );
                                   ShowNotification( ntStop, RsgMsg436, RsgMsg437 );
                                   end;
              end;

      finally
        end;

end;

procedure TBoxSuaForm.FormManagerInitializeForm;
begin
     MovimientoFields := TMovimientoFields.Create( MovimientoTable );

     SerieFacturacion.AplicaRestriccionSerie( SerieCtrl );
end;

end.
