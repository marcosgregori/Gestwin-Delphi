
unit b_ehc;

interface

uses AppForms, StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics,

     Dialogs,

     Menus, cxLookAndFeelPainters, cxButtons, cxGraphics, DB, nxdb,
     DataManager, cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit,
     cxMaskEdit, cxDropDownEdit, cxIndexedComboBox, dxmdaset, cxGroupBox,
     cxRadioGroup,

     cxCheckBox, dxSkinsCore, dxSkinsDefaultPainters, cxLookAndFeels, cxLabel,

     AppContainer,

     Gim30Fields,
     Gim40Fields,

     dm_mov;

type

  TBoxEhcForm = class(TgxForm)
    FormManager: TgxFormManager;
    dataPanel: TgxEditPanel;
    TransportistaCtrl: TcxDBTextEdit;
    HojaCargaTable: TnxeTable;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataTransportista: TWideStringField;
    LineaHojaCargaTable: TnxeTable;
    CaptionPropietarioLabel: TcxLabel;
    DescTransportistaLabel: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure TransportistaCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure TransportistaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure TransportistaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);

  private

    HojaCargaFields : THojaCargaFields;
    LineaHojaCargaFields : TLineaHojaCargaFields;
    ArticuloFields : TArticuloFields;

    procedure ExportaDocumento;

  protected
  class var
    MovimientoOrigenFields : TMovimientoFields;
    LineaMovimientoOrigenFields : TLineaMovimientoFields;

  end;

var
  BoxEhcForm: TBoxEhcForm = nil;

// Esta ventana solo debe utilizarse desde a_mve

procedure ExportaAHojaCarga( MovimientoOrigenFields      : TMovimientoFields;
                             LineaMovimientoOrigenFields : TLineaMovimientoFields );

implementation

{$R *.DFM}

uses   SysUtils,

       nxllException,

       AppManager,
       DataAccess,
       LibUtils,
       EnterpriseDataAccess,

       Gdm00Dm,

       dmi_mov,

       dm_hdc,
       dm_tra,
       dm_art,

       a_hdc,
       a_tra,
       a_pde4,

       cx_tra,

       b_msg;

resourceString

   RsMsg6  = 'Este pedido ya ha sido completamente servido.';
   RsMsg15 = 'No hay ninguna cantidad pendiente de servir o pendiente de carga.';
   RsMsg16 = 'No se ha creado ningún documento.';
   RsMsg17 = 'Ha ocurrido un error durante el proceso de generación del documento. No ha podido ser creado.';

procedure ExportaAHojaCarga( MovimientoOrigenFields      : TMovimientoFields;
                             LineaMovimientoOrigenFields : TLineaMovimientoFields );
begin
     TBoxEhcForm.MovimientoOrigenFields := MovimientoOrigenFields;
     TBoxEhcForm.LineaMovimientoOrigenFields := LineaMovimientoOrigenFields;
     CreateEditForm( TBoxEhcForm, BoxEhcForm );
end;

procedure TBoxEhcForm.FormManagerOkButton;
begin
     ExportaDocumento;
end;

procedure TBoxEhcForm.FormManagerInitializeForm;
begin
     HojaCargaFields := THojaCargaFields.Create( HojaCargaTable );
     LineaHojaCargaFields := TLineaHojaCargaFields.Create( LineaHojaCargaTable );

     ArticuloFields := TArticuloFields.Create( Self );

end;

procedure TBoxEhcForm.ExportaDocumento;

var  NroLineaActual : SmallInt;
     CantidadCargada,
     CantidadACargar : Decimal;

begin

     try

       EnterpriseDataModule.StartTransaction( [ HojaCargaTable,
                                                LineaHojaCargaTable ] );

       If   MovimientoOrigenFields.Situacion.Value=epProcesado
       then begin
            ShowNotification( ntStop, RsMsg6, RsMsg16 );
            Exit;
            end;

       HojaCargaTable.Append;

       HojaCargaFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
       HojaCargaFields.NroHoja.Value := HojaCarga.ProximoNroHoja;
       HojaCargaFields.Fecha.Value := ApplicationContainer.TodayDate;
       HojaCargaFields.CodigoTransportista.Value := DataTransportista.Value;

       NroLineaActual := 1;

       With LineaMovimientoOrigenFields.Dataset do
         try

           DisableControls;
           Cancel;

           First;
           While not Eof do
             begin

             CantidadCargada := HojaCarga.ObtenCantidadCargada( LineaMovimientoOrigenFields.NroRegistro.Value );

             CantidadACargar := 0.0;

             If   not PedidoEnOrigen
             then CantidadACargar := ( -LineaMovimientoOrigenFields.Cantidad.Value ) - CantidadCargada
             else If   not LineaMovimientoOrigenFields.Procesada.Value
                  then CantidadACargar := LineaMovimientoOrigenFields.Cantidad.Value - { LineaMovimientoOrigenFields.CantidadProcesada.Value - } CantidadCargada;

             If   CantidadACargar>0.0
             then With LineaHojaCargaTable do
                    begin

                    Articulo.Obten( LineaMovimientoOrigenFields.CodigoArticulo.Value, ArticuloFields );

                    Append;

                    LineaHojaCargaFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
                    LineaHojaCargaFields.NroHoja.Value := HojaCargaFields.NroHoja.Value;
                    LineaHojaCargaFields.NroLinea.Value := NroLineaActual;
                    LineaHojaCargaFields.EjercicioOrigen.Value := MovimientoOrigenFields.Ejercicio.Value;
                    LineaHojaCargaFields.NroOperacionOrigen.Value := MovimientoOrigenFields.NroOperacion.Value;
                    LineaHojaCargaFields.NroRegistroOrigen.Value := LineaMovimientoOrigenFields.NroRegistro.Value;
                    LineaHojaCargaFields.CodigoAlmacen.Value := LineaMovimientoOrigenFields.CodigoAlmacen.Value;
                    LineaHojaCargaFields.Ubicacion.Value := LineaMovimientoOrigenFields.Ubicacion.Value;

                    If   DataModule00.DmEmpresaFields.Articulo_Cajas.Value and ( ArticuloFields.UnidadesPorCaja.Value<>0.0 )
                    then LineaHojaCargaFields.NroCajas.Value := Redondea( CantidadACargar / ArticuloFields.UnidadesPorCaja.Value, DataModule00.DmEmpresaFields.Ventas_DecCajas.Value );

                    LineaHojaCargaFields.Cargado.Value := CantidadACargar;

                    Inc( NroLineaActual );

                    Post;

                    end;

             Next;
             end;

         finally
           EnableControls;
           end;

       With HojaCargaTable do
         If   NroLineaActual>1
         then Post
         else begin
              Cancel;
              ShowNotification( ntStop, RsMsg15, RsMsg16 );
              EnterpriseDataModule.RollBack;
              Exit;
              end;

       EnterpriseDataModule.Commit;

     except on E : Exception do begin
                                EnterpriseDataModule.RollBack;
                                If   E is EnxBaseException
                                then ShowDatabaseError( nil, EnxBaseException( E ) );
                                ShowNotification( ntStop, RsMsg17, '' );
                                end;
       end;

     With HojaCargaFields do
       begin
       MovimientoOrigenFields.DatasetCancel;
       MntHojasCarga( [ Ejercicio.Value, NroHoja.Value ] );
       end;

end;

procedure TBoxEhcForm.TransportistaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTransportistas( [ Sender.EditingValue ] );
end;

procedure TBoxEhcForm.TransportistaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTransportistas( Sender );
end;

procedure TBoxEhcForm.TransportistaCtrlPropertiesValidate(     Sender       : TcxCustomEdit;
                                                           var DisplayValue : Variant;
                                                           var ErrorText    : TCaption;
                                                           var Error        : Boolean );
begin
     Transportista.Valida( Sender, DisplayValue, ErrorText, Error );
end;

end.

