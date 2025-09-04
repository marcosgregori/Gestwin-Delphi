
unit a_pde7;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask,
  Controls, Classes, ExtCtrls,

  AppContainer,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb,
  DataManager, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  dxmdaset, cxMaskEdit, cxSpinEdit,

  Gdm40Dm, dxSkinsCore, cxGraphics, cxLookAndFeels, cxLabel, cxGroupBox,
  cxDropDownEdit, cxIndexedComboBox, dxSkinsDefaultPainters,

  dxBarBuiltInMenu, cxPC, cxCheckBox,

  Gim40Fields,
  Gim70Fields, cxCurrencyEdit, dxToggleSwitch, dxDBToggleSwitch;

type
  TMntPde7Form = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    LineaHojaCargaTable: TnxeTable;
    DataPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataDecimalesComponentes: TSmallintField;
    DataAlmacenComponentes: TWideStringField;
    DataAlmacenProductoAcabado: TWideStringField;
    DataSerieAlbaranesSalida: TWideStringField;
    DataDocumentoHojaCarga: TSmallintField;
    cxPageControl1: TcxPageControl;
    AlmacenesTabSheet: TcxTabSheet;
    CierreTabSheet: TcxTabSheet;
    cxGroupBox2: TcxGroupBox;
    SerieAlbaranesSalidaCtrl: TcxDBTextEdit;
    Label4: TcxLabel;
    descSerieSalidaLabel: TcxLabel;
    cxLabel2: TcxLabel;
    DocumentoHojaCargaCtrl: TcxDBIndexedComboBox;
    cxGroupBox1: TcxGroupBox;
    AlmacenComponentesCtrl: TcxDBTextEdit;
    AlmacenProdAcabadoCtrl: TcxDBTextEdit;
    Label2: TcxLabel;
    descComponentesLabel: TcxLabel;
    Label5: TcxLabel;
    descAcabadoLabel: TcxLabel;
    cxGroupBox3: TcxGroupBox;
    DecimalesComponentesCtrl: TcxDBSpinEdit;
    Label10: TcxLabel;
    AlmacenExtraccionesCtrl: TcxDBTextEdit;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    AlmacenarProdDefectuososCtrl: TcxDBCheckBox;
    DataAlmacenExtracciones: TWideStringField;
    DataAlmacenarProdDefectuosos: TBooleanField;
    DataAlmacenProdDefectuoso: TWideStringField;
    AlmacenProdDefectuosoCtrl: TcxDBTextEdit;
    CapProductoDefectuosoLabel: TcxLabel;
    cxLabel6: TcxLabel;
    cxGroupBox4: TcxGroupBox;
    cxLabel7: TcxLabel;
    TipoJornadaSabadoCtrl: TcxDBIndexedComboBox;
    DataTipoJornadaSabado: TSmallintField;
    cxTabSheet1: TcxTabSheet;
    DataRetrasoMaximoLanzamiento: TSmallintField;
    DataRetrasoMaximoTareas: TSmallintField;
    DataMetodoNumeracionLote: TSmallintField;
    DataMantenerTurnoEnAsignacion: TBooleanField;
    DataNoDescontarComponentes: TBooleanField;
    cxGroupBox5: TcxGroupBox;
    cxGroupBox6: TcxGroupBox;
    cxLabel5: TcxLabel;
    RetrasoMaximoLanzamientoCtrl: TcxDBSpinEdit;
    cxLabel8: TcxLabel;
    RetrasoMaximoTareasCtrl: TcxDBSpinEdit;
    cxLabel9: TcxLabel;
    cxLabel10: TcxLabel;
    cxLabel11: TcxLabel;
    MetodoNumeracionLotesCtrl: TcxDBIndexedComboBox;
    MantenerTurnoEnAsignacionCtrl: TcxDBCheckBox;
    NoDescontarComponentesCtrl: TcxDBCheckBox;
    MermaExcesoArticulosCtrl: TcxDBCheckBox;
    IncorporarExtraerArticulosCtrl: TcxDBCheckBox;
    RealizarProduccionPrevistaCtrl: TcxDBCheckBox;
    DataIncorporarExtraerArticulos: TBooleanField;
    DataMermaExcesoArticulos: TBooleanField;
    DataRealizarProduccionPrevista: TBooleanField;
    cxGroupBox7: TcxGroupBox;
    cxLabel12: TcxLabel;
    MetodoCalculoCosteCtrl: TcxDBIndexedComboBox;
    cxLabel13: TcxLabel;
    IncrementoPorcentualCosteCtrl: TcxDBCurrencyEdit;
    PorcentajeLabel: TcxLabel;
    cxGroupBox8: TcxGroupBox;
    cxLabel15: TcxLabel;
    MetodoCalculoMargenCtrl: TcxDBIndexedComboBox;
    cxLabel16: TcxLabel;
    MargenPorcentualVentaCtrl: TcxDBCurrencyEdit;
    MargenPorcentualLabel: TcxLabel;
    cxGroupBox9: TcxGroupBox;
    AjusteAutomaticoConsumosCtrl: TcxDBCheckBox;
    DataMetodoCalculoCoste: TSmallintField;
    DataMetodoCalculoMargen: TSmallintField;
    DataIncrementoPorcentualCoste: TCurrencyField;
    DataMargenPorcentualVenta: TCurrencyField;
    DataAjusteAutomaticoConsumos: TBooleanField;
    ArticulosGroupBox: TcxGroupBox;
    ExisteClaseACtrl: TcxDBCheckBox;
    NombreClaseACtrl: TcxDBTextEdit;
    NombreClaseBCtrl: TcxDBTextEdit;
    ExisteClaseBCtrl: TcxDBCheckBox;
    NombreClaseCCtrl: TcxDBTextEdit;
    ExisteClaseCCtrl: TcxDBCheckBox;
    DataNombreClaseA: TStringField;
    DataNombreClaseB: TStringField;
    DataNombreClaseC: TStringField;
    DataExisteClaseA: TBooleanField;
    DataExisteClaseB: TBooleanField;
    DataExisteClaseC: TBooleanField;
    cxGroupBox10: TcxGroupBox;
    cxLabel1: TcxLabel;
    CosteComponentesCtrl: TcxDBIndexedComboBox;
    DataCosteComponentes: TSmallintField;
    NoLanzarOrdenesRecursivasCtrl: TcxDBCheckBox;
    DataNoLanzarOrdenesRecursivas: TBooleanField;
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
    procedure FormManagerDestroyForm;
    procedure AlmacenCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure AlmacenCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure AlmacenCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure SerieAlbaranesSalidaCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure SerieAlbaranesSalidaCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure SerieAlbaranesSalidaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure DocumentoHojaCargaCtrlPropertiesChange(
      Sender: TObject);
    procedure AlmacenarProdDefectuososCtrlPropertiesChange(Sender: TObject);
    procedure cxDBIndexedComboBox1PropertiesChange(Sender: TObject);
    procedure cxDBIndexedComboBox2PropertiesChange(Sender: TObject);
    procedure ExisteClaseACtrlPropertiesChange(Sender: TObject);
    procedure ExisteClaseBCtrlPropertiesChange(Sender: TObject);
    procedure ExisteClaseCCtrlPropertiesChange(Sender: TObject);
  private

  public

  end;

var   MntPde7Form : TMntPde7Form =nil;

      ParametrosAprovisionamientoRec : TParametrosAprovisionamientoRec;
      ParametrosProduccionRec : TParametrosProduccionRec;

procedure MntConfiguracionProduccion;

implementation

{$R *.DFM}

uses   SysUtils,
       LibUtils,
       AppManager,

       Gim00Fields,
       Gim30Fields,
       Gdm00Dm,
       Gdm00Frm,

       dm_pga,
       dm_alm,
       dm_cls,
       dm_sdf,

       b_msg,

       a_alm,
       a_sdf,

       cx_alm,
       cx_sdf;

resourceString
       RsMsg1  = 'El fichero de hojas de carga tiene movimientos.';
       RsMsg2  = 'No puede modificar el tipo de documento de las hojas de carga si existen movimientos.'#13'Suprima todos los registros de hoja de carga existentes y reintente la operaci�n.';

procedure MntConfiguracionProduccion;
begin
     CreateEditForm( TMntPde7Form, MntPde7Form, Gds00Frm.ConfigurationSection, True );
end;

procedure ObtenParametros;
begin
     Configuracion.ObtenParametros( ctParametrosModuloAprovisionamiento, CodigoEmpresaActual, TParametrosRec( ParametrosAprovisionamientoRec ) );
     Configuracion.ObtenParametros( ctParametrosModuloProduccion, CodigoEmpresaActual, TParametrosRec( ParametrosProduccionRec ) );
end;

procedure TMntPde7Form.FormManagerInitializeForm;

procedure AjustaControlesClase( NroClase         : SmallInt;
                                ExisteClaseCtrl,
                                NombreClaseCtrl  : TcxCustomEdit );

begin
     If   DataModule00.DmEmpresaFields.Articulo_ExisteClase[ NroClase ].Value
     then begin
          ExisteClaseCtrl.Enabled := False;
          NombreClaseCtrl.Enabled := False;

          ExisteClaseCtrl.PostEditValue( True );
          NombreClaseCtrl.PostEditValue( DataModule00.DmEmpresaFields.Articulo_NombreClase[ NroClase ].Value );
          end;
end;

begin

     CloseWindowWhenFocusLost := True;

     SetEditControlsDecimals( [ IncrementoPorcentualCosteCtrl, MargenPorcentualVentaCtrl ] );

     ObtenParametros;

     With ParametrosAprovisionamientoRec do
       begin
       DataSerieAlbaranesSalida.Value := SerieAlbaranesSalida;
       DataDocumentoHojaCarga.Value := DocumentoHojaCarga;
       DataMetodoCalculoMargen.Value := MetodoCalculoMargen;
       DataMargenPorcentualVenta.Value := MargenPorcentualVenta;
       end;

     With ParametrosProduccionRec do
       begin

       DataExisteClaseA.Value := ExisteClase[ 1 ];
       DataExisteClaseB.Value := ExisteClase[ 2 ];
       DataExisteClaseC.Value := ExisteClase[ 3 ];

       DataNombreClaseA.Value := NombreClase[ 1 ];
       DataNombreClaseB.Value := NombreClase[ 2 ];
       DataNombreClaseC.Value := NombreClase[ 3 ];

       DataAlmacenComponentes.Value := AlmacenComponentes;
       DataAlmacenProductoAcabado.Value := AlmacenProdAcabado;
       DataAlmacenExtracciones.Value := AlmacenExtracciones;
       DataAlmacenarProdDefectuosos.Value := AlmacenarProdDefectuosos;
       DataAlmacenProdDefectuoso.Value := AlmacenProdDefectuoso;

       DataDecimalesComponentes.Value := DecimalesComponentes;

       DataTipoJornadaSabado.Value := TipoJornadaSabado;

       DataRetrasoMaximoLanzamiento.Value := RetrasoMaximoLanzamiento;
       DataRetrasoMaximoTareas.Value := RetrasoMaximoTareas;
       DataMetodoNumeracionLote.Value := MetodoNumeracionLote;
       DataMantenerTurnoEnAsignacion.Value := MantenerTurnoEnAsignacion;
       DataNoDescontarComponentes.Value := NoDescontarComponentes;
       DataNoLanzarOrdenesRecursivas.Value := NoLanzarOrdenesRecursivas;

       DataIncorporarExtraerArticulos.Value := IncorporarExtraerArticulos;
       DataMermaExcesoArticulos.Value :=  MermaExcesoArticulos;
       DataRealizarProduccionPrevista.Value :=  RealizarProduccionPrevista;

       DataCosteComponentes.Value  := CosteComponentes;
       DataMetodoCalculoCoste.Value := MetodoCalculoCoste;
       DataIncrementoPorcentualCoste.Value := IncrementoPorcentualCoste;

       DataAjusteAutomaticoConsumos.Value := AjusteAutomaticoConsumos;
       end;

     DocumentoHojaCargaCtrl.Enabled := LineaHojaCargaTable.RecordCount=0;

     AjustaControlesClase( 1, ExisteClaseACtrl, NombreClaseACtrl );
     AjustaControlesClase( 2, ExisteClaseBCtrl, NombreClaseBCtrl );
     AjustaControlesClase( 3, ExisteClaseCCtrl, NombreClaseCCtrl );

end;

procedure TMntPde7Form.FormManagerOkButton;
begin

     With ParametrosAprovisionamientoRec do
       begin
       SerieAlbaranesSalida := DataSerieAlbaranesSalida.Value;
       DocumentoHojaCarga := DataDocumentoHojaCarga.Value;
       MetodoCalculoMargen := DataMetodoCalculoMargen.Value;
       MargenPorcentualVenta := DataMargenPorcentualVenta.Value;
       end;

     With ParametrosProduccionRec do
       begin

       ExisteClase[ 1 ] := DataExisteClaseA.Value;
       ExisteClase[ 2 ] := DataExisteClaseB.Value;
       ExisteClase[ 3 ] := DataExisteClaseC.Value;

       NombreClase[ 1 ] := DataNombreClaseA.Value;
       NombreClase[ 2 ] := DataNombreClaseB.Value;
       NombreClase[ 3 ] := DataNombreClaseC.Value;

       AlmacenComponentes := DataAlmacenComponentes.Value;
       AlmacenProdAcabado := DataAlmacenProductoAcabado.Value;
       AlmacenExtracciones := DataAlmacenExtracciones.Value;
       AlmacenarProdDefectuosos := DataAlmacenarProdDefectuosos.Value;
       AlmacenProdDefectuoso := DataAlmacenProdDefectuoso.Value;

       DecimalesComponentes := DataDecimalesComponentes.Value;

       TipoJornadaSabado := DataTipoJornadaSabado.Value;

       RetrasoMaximoLanzamiento := DataRetrasoMaximoLanzamiento.Value;
       RetrasoMaximoTareas := DataRetrasoMaximoTareas.Value;
       MetodoNumeracionLote := DataMetodoNumeracionLote.Value;
       MantenerTurnoEnAsignacion := DataMantenerTurnoEnAsignacion.Value;
       NoDescontarComponentes := DataNoDescontarComponentes.Value;
       NoLanzarOrdenesRecursivas := DataNoLanzarOrdenesRecursivas.Value;

       IncorporarExtraerArticulos := DataIncorporarExtraerArticulos.Value;
       MermaExcesoArticulos := DataMermaExcesoArticulos.Value;
       RealizarProduccionPrevista := DataRealizarProduccionPrevista.Value;

       CosteComponentes := DataCosteComponentes.Value;
       MetodoCalculoCoste := DataMetodoCalculoCoste.Value;
       IncrementoPorcentualCoste := DataIncrementoPorcentualCoste.Value;

       AjusteAutomaticoConsumos := DataAjusteAutomaticoConsumos.Value;
       end;

    Configuracion.GuardaParametros( ctParametrosModuloAprovisionamiento, CodigoEmpresaActual,  TParametrosRec( ParametrosAprovisionamientoRec ) );
    Configuracion.GuardaParametros( ctParametrosModuloProduccion, CodigoEmpresaActual,  TParametrosRec( ParametrosProduccionRec ) );

    FormManager.CloseWindow := True;
end;

procedure TMntPde7Form.SerieAlbaranesSalidaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntSeriesFacturacion( [ Sender.EditingValue ] );
end;

procedure TMntPde7Form.SerieAlbaranesSalidaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TMntPde7Form.SerieAlbaranesSalidaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntPde7Form.DocumentoHojaCargaCtrlPropertiesChange(Sender: TObject);
begin
     SerieAlbaranesSalidaCtrl.Enabled := DocumentoHojaCargaCtrl.ItemIndex=0;
end;

procedure TMntPde7Form.ExisteClaseACtrlPropertiesChange(Sender: TObject);
begin
     If   not DataModule00.DmEmpresaFields.Articulo_ExisteClase[ 1 ].Value
     then begin
          NombreClaseACtrl.Enabled := ExisteClaseACtrl.Checked;
          ExisteClaseBCtrl.Enabled := ExisteClaseACtrl.Checked;
          end;
end;

procedure TMntPde7Form.ExisteClaseBCtrlPropertiesChange(Sender: TObject);
begin
     If   not DataModule00.DmEmpresaFields.Articulo_ExisteClase[ 2 ].Value
     then begin
          NombreClaseBCtrl.Enabled := ExisteClaseBCtrl.Checked;
          ExisteClaseCCtrl.Enabled := ExisteClaseBCtrl.Checked;
          end;
end;

procedure TMntPde7Form.ExisteClaseCCtrlPropertiesChange(Sender: TObject);
begin
     If   not DataModule00.DmEmpresaFields.Articulo_ExisteClase[ 3 ].Value
     then NombreClaseCCtrl.Enabled := ExisteClaseCCtrl.Checked;
end;

procedure TMntPde7Form.FormManagerDestroyForm;
begin
     Configuracion.Update;
end;

procedure TMntPde7Form.AlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scVentas, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntPde7Form.cxDBIndexedComboBox1PropertiesChange(Sender: TObject);
begin
     IncrementoPorcentualCosteCtrl.Enabled := MetodoCalculoCosteCtrl.ItemIndex=1;
     PorcentajeLabel.Enabled := IncrementoPorcentualCosteCtrl.Enabled;
end;

procedure TMntPde7Form.cxDBIndexedComboBox2PropertiesChange(Sender: TObject);
begin
     MargenPorcentualVentaCtrl.Enabled := MetodoCalculoMargenCtrl.ItemIndex=1;
     MargenPorcentualLabel.Enabled := MargenPorcentualVentaCtrl.Enabled;
end;

procedure TMntPde7Form.AlmacenarProdDefectuososCtrlPropertiesChange(Sender: TObject);
begin
     AlmacenProdDefectuosoCtrl.Enabled := AlmacenarProdDefectuososCtrl.Checked;
end;

procedure TMntPde7Form.AlmacenCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntAlmacenes( [ Sender.Editingvalue ] );
end;

procedure TMntPde7Form.AlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

initialization
     AddProcedure( imGetParamConf, 0, ObtenParametros );
end.

 
