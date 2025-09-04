
unit e_cnt;

interface

uses StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,

     AppContainer,


     ComCtrls,

     DataManager,
     DB,
     nxdb,
     ReportManager, Menus, cxLookAndFeelPainters, cxButtons, dxmdaset,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGrid, cxPC, cxDBEdit, cxContainer, cxTextEdit, cxMaskEdit, cxSpinEdit,
  cxCheckBox,

  Gim10Fields,
  Gim30Fields,
  Gim90Fields, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxLabel, cxGroupBox, cxPCdxBarPopupMenu, cxNavigator,
  dxBarBuiltInMenu, dxDateRanges, AppForms, GridTableViewController;


type
    TEtqCntForm = class(TgxForm)
    FormManager: TgxFormManager;
    Panel1: TgxEditPanel;
    PageControl: TcxPageControl;
    TabSheet2: TcxTabSheet;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    FormatoCtrl: TcxDBSpinEdit;
    TabSheet5: TcxTabSheet;
    NroCopiasCtrl: TcxDBSpinEdit;
    Report: TgxReportManager;
    ContactoTable: TnxeTable;
    PrimeraPosicionCtrl: TcxDBSpinEdit;
    Data: TgxMemData;
    DataSource: TDataSource;
    GridData: TnxeTable;
    GridDataSource: TDataSource;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
    DataNroCopias: TSmallintField;
    DataFormato: TSmallintField;
    DataPrimeraPosicion: TSmallintField;
    GridDataCodigo: TWideStringField;
    GridDataNroCopias: TSmallintField;
    GridDataNombre: TWideStringField;
    GridTableViewController1: TGridTableViewController;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    GridViewCodigo: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewNroCopias: TcxGridDBColumn;
    gxRangeBox1: TgxRangeBox;
    GridDataNroLinea: TSmallintField;
    cxTabSheet1: TcxTabSheet;
    DataActividadInicial: TWideStringField;
    DataActividadFinal: TWideStringField;
    gxRangeBox2: TgxRangeBox;
    ActividadInicialCtrl: TcxDBTextEdit;
    ActividadFinalCtrl: TcxDBTextEdit;
    Label5: TcxLabel;
    Label8: TcxLabel;
    FormatoLabel: TcxLabel;
    Label19: TcxLabel;
    Label16: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    Label7: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label11: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure ReportSetReportName;
    procedure PageControlChange(Sender: TObject);
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ReportSelectPrinter;
    procedure CodigoContactoPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigoPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridDataCalcFields(DataSet: TDataSet);
    procedure CodigoContactoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewNroCopiasPropertiesEnter(Sender: TcxCustomEdit);
    procedure FormManagerPreparedForm;
    procedure GridDataNewRecord(DataSet: TDataSet);
    procedure ActividadCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ActividadCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

    public

      RptEtiquetaPostalTable : TnxeTable;
      
      RptEtiquetaPostalFields : TEtiquetaPostalFields;
      ContactoFields : TContactoFields;

    end;

var
  EtqCntForm: TEtqCntForm = nil;

procedure EtiquetasContactos( UnCodigoContacto : String );


implementation

uses   Variants,
       SysUtils,
       EnterpriseDataAccess,

       Gdm00Dm,

       dm_ine,
       dm_cnt,
       dm_fdv,
       dm_pai,
       dm_prv,
       dm_act,

       a_imp,

       b_msg,

       cx_act,
       cx_cnt,
       cx_imp;

{$R *.DFM}

var    CodigoContacto : String;

procedure EtiquetasContactos( UnCodigoContacto : String );
begin
     CodigoContacto := UnCodigoContacto;
     CreateEditForm( TEtqCntForm, EtqCntForm );
end;

procedure TEtqCntForm.InitializeForm;
begin
     ContactoFields  := TContactoFields.Create( ContactoTable );

     DataNroCopias.Value := 1;
     DataCodigoFinal.Value := HighStrCode;
     DataActividadFinal.Value := HighStrCode;
     DataPrimeraPosicion.Value := 1;
     DataFormato.Value := InformeExterno.ObtenFormatoUsuario( impEtiquetasContactos );
end;

procedure TEtqCntForm.GridDataCalcFields(DataSet: TDataSet);
begin
     GridDataNombre.Value := Contacto.Descripcion( GridDataCodigo.Value, False );
end;

procedure TEtqCntForm.GridDataNewRecord(DataSet: TDataSet);
begin
     GridDataNroCopias.Value := 1;
end;

procedure TEtqCntForm.CodigoContactoPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaContactos( Sender );
end;

procedure TEtqCntForm.GridViewCodigoPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Contacto.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TEtqCntForm.GridViewNroCopiasPropertiesEnter(Sender: TcxCustomEdit);
begin
     With GridViewNroCopias do
       If   ValueIsEmpty( EditValue )
       then EditValue := 1;
end;

procedure TEtqCntForm.FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntImpresos( [ Ord( impEtiquetasContactos ), Sender.EditingValue ] );
end;

procedure TEtqCntForm.FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaImpresos( impEtiquetasContactos, Sender );
end;

procedure TEtqCntForm.FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     InformeExterno.Valida( impEtiquetasContactos, Sender, DisplayValue, Errortext, Error );
end;

procedure TEtqCntForm.FormManagerOkButton;

procedure seleccionaRegistros;

var   Index : Integer;

procedure InsertaRegistro;

var   Index,
      NroCopias : Integer;

begin

     If   PageControl.ActivePage.pageIndex=0
     then NroCopias := GridDataNroCopias.Value
     else NroCopias := DataNroCopias.Value;

     With RptEtiquetaPostalFields do
       For Index := 1 to NroCopias do
         begin

         RptEtiquetaPostalTable.Append;

         Codigo.Value := ContactoFields.Codigo.Value;

         Nombre.Value := ContactoFields.Nombre.Value;
         Domicilio.Value := ContactoFields.Domicilio.Value;
         Localidad.Value := ContactoFields.localidad.Value;
         CodigoPais.Value := ContactoFields.CodigoPais.Value;
         NombrePais.Value := Pais.Descripcion( ContactoFields.CodigoPais.Value, true );
         CP.Value := ContactoFields.CodigoProvincia.Value + ContactoFields.CodigoPostal.Value;
         Provincia.Value := dm_prv.Provincia.Descripcion( ContactoFields.CodigoPais.Value, ContactoFields.codigoProvincia.Value, false );

         RptEtiquetaPostalTable.Post;

         ApplicationContainer.ShowProgression;

         end;

end;

begin

     With RptEtiquetaPostalTable do
       For Index := 1 to DataPrimeraPosicion.Value - 1 do
         begin
         Append;
         Post;
         end;

     With ContactoTable do
       try

         IndexFieldNames := 'Codigo';

         case PageControl.ActivePageIndex of

           0 : With GridData do
                 begin
                 ApplicationContainer.StartProgression( RecordCount );
                 First;
                 While not Eof do
                   begin
                   If   ContactoTable.FindKey( [ GridDataCodigo.Value ] )
                   then InsertaRegistro;
                   Next;
                   end;
                 end;

           1..2 : begin
                  If   PageControl.ActivePageIndex=1
                  then SetRange( [ DataCodigoInicial.Value ], [ DataCodigoFinal.Value ] )
                  else begin
                       IndexFieldNames := 'CodigoActividad;Codigo';
                       SetRange( [ DataActividadInicial.Value, '' ], [ DataActividadFinal.Value, HighStrCode ] );
                       end;
                  ApplicationContainer.StartProgression( RecordCount );
                  First;
                  While not eof do
                    begin
                    InsertaRegistro;
                    Next;
                    end;
                  end;
           end;

       finally
         ApplicationContainer.EndProgression;
         end;

end;

begin
     Enabled := False;

     With Report do
       try
         Load;
         RptEtiquetaPostalTable  := GetTable( 'EtiquetaPostal' );
         RptEtiquetaPostalFields := TEtiquetaPostalFields.Create( RptEtiquetaPostalTable );
         SeleccionaRegistros;
         FacturaVentas.FijaDecimalesInforme( Report );
         Start;
       except on E : Exception do Cancel( E );
         end;

end;

procedure TEtqCntForm.FormManagerPreparedForm;
begin
     If   CodigoContacto<>''
     then begin
          GridDataCodigo.Value :=CodigoContacto;
          GridDataNroCopias.Value := 1;
          end;
end;

procedure TEtqCntForm.ActividadCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaActividades( Sender );
end;

procedure TEtqCntForm.ActividadCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Actividad.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TEtqCntForm.CodigoContactoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Contacto.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TEtqCntForm.ReportSelectPrinter;
begin
     Report.ReportPrinter := InformeExterno.Impresora;
end;

procedure TEtqCntForm.PageControlChange(Sender: TObject);
begin
     NroCopiasCtrl.Enabled:= PageControl.ActivePageIndex<>0;
end;

procedure TEtqCntForm.ReportSetReportName;
begin
     Report.FileName := InformeExterno.Fichero;
end;

end.

