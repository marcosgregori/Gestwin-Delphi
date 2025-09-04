
unit a_pg101;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask,
  Controls, Classes, ExtCtrls, printers,

  AppContainer,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, cxGroupBox,
  cxRadioGroup, cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit, DB,
  DataManager, nxdb,

  dxSkinsCore, cxGraphics, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxHeader,

  Gim00Fields,
  Gim101Fields,

  dxmdaset;

type
  TmntPg101Form = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    FicheroImportacionCtrl: TcxDBTextEdit;
    examinarButton: TgBitBtn;
    CampoObraCtrl: TcxDBRadioGroup;
    CPNroAlbaranCtrl: TcxDBTextEdit;
    CLNroAlbaranCtrl: TcxDBTextEdit;
    CPArticulo1Ctrl: TcxDBTextEdit;
    CLArticulo1Ctrl: TcxDBTextEdit;
    CPClienteCtrl: TcxDBTextEdit;
    CLClienteCtrl: TcxDBTextEdit;
    CPCantidad1Ctrl: TcxDBTextEdit;
    CLCantidad1Ctrl: TcxDBTextEdit;
    CPObraCtrl: TcxDBTextEdit;
    CIObraCtrl: TcxDBTextEdit;
    CPArticulo2Ctrl: TcxDBTextEdit;
    CLArticulo2Ctrl: TcxDBTextEdit;
    CPTarifaCtrl: TcxDBTextEdit;
    CLTarifaCtrl: TcxDBTextEdit;
    CPCantidad2Ctrl: TcxDBTextEdit;
    CLCantidad2Ctrl: TcxDBTextEdit;
    CPFechaCtrl: TcxDBTextEdit;
    CIFechaCtrl: TcxDBTextEdit;
    CPCantidad3Ctrl: TcxDBTextEdit;
    CLCantidad3Ctrl: TcxDBTextEdit;
    CLArticulo3Ctrl: TcxDBTextEdit;
    CPArticulo3Ctrl: TcxDBTextEdit;
    ConfiguracionTable: TnxeTable;
    ConfiguracionTableAplicacion: TSmallintField;
    ConfiguracionTableTipo: TSmallintField;
    ConfiguracionTableCodigo: TWideStringField;
    ConfiguracionTableData: TBlobField;
    DataSource: TDataSource;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label5: TcxLabel;
    Label6: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label12: TcxLabel;
    Label13: TcxLabel;
    Label22: TcxLabel;
    Label20: TcxLabel;
    Label21: TcxLabel;
    Label25: TcxLabel;
    Label26: TcxLabel;
    CPArticulo4Ctrl: TcxDBTextEdit;
    CLArticulo4Ctrl: TcxDBTextEdit;
    CPCantidad4Ctrl: TcxDBTextEdit;
    CLCantidad4Ctrl: TcxDBTextEdit;
    CPArticulo5Ctrl: TcxDBTextEdit;
    CLArticulo5Ctrl: TcxDBTextEdit;
    CPCantidad5Ctrl: TcxDBTextEdit;
    CLCantidad5Ctrl: TcxDBTextEdit;
    CPCantidad6Ctrl: TcxDBTextEdit;
    CLCantidad6Ctrl: TcxDBTextEdit;
    CLArticulo6Ctrl: TcxDBTextEdit;
    CPArticulo6Ctrl: TcxDBTextEdit;
    Label4: TcxLabel;
    Label11: TcxLabel;
    Label23: TcxLabel;
    Label24: TcxLabel;
    Label27: TcxLabel;
    Label1: TcxLabel;
    Data: TgxMemData;
    DataFicheroImportacion: TWideStringField;
    dataCampoObra: TSmallintField;
    dataCPNroAlbaran: TSmallintField;
    dataCLNroAlbaran: TSmallintField;
    dataCPCliente: TSmallintField;
    dataCLCliente: TSmallintField;
    dataCPObra: TSmallintField;
    dataCLObra: TSmallintField;
    dataCPTarifa: TSmallintField;
    dataCLTarifa: TSmallintField;
    dataCPFecha: TSmallintField;
    dataCLFecha: TSmallintField;
    dataCPArticulo1: TSmallintField;
    dataCLArticulo1: TSmallintField;
    dataCPCantidad1: TSmallintField;
    dataCLCantidad1: TSmallintField;
    dataCPArticulo2: TSmallintField;
    dataCLArticulo2: TSmallintField;
    dataCPCantidad2: TSmallintField;
    dataCLCantidad2: TSmallintField;
    dataCPArticulo3: TSmallintField;
    dataCLArticulo3: TSmallintField;
    dataCPCantidad3: TSmallintField;
    dataCLCantidad3: TSmallintField;
    DataCPArticulo4: TSmallintField;
    DataCLArticulo4: TSmallintField;
    DataCPCantidad4: TSmallintField;
    DataCLCantidad4: TSmallintField;
    DataCPArticulo5: TSmallintField;
    DataCLArticulo5: TSmallintField;
    DataCPCantidad5: TSmallintField;
    DataCLCantidad5: TSmallintField;
    DataCPArticulo6: TSmallintField;
    DataCLArticulo6: TSmallintField;
    DataCPCantidad6: TSmallintField;
    DataCLCantidad6: TSmallintField;
    cxHeader1: TcxHeader;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Shape1: TShape;
    Shape2: TShape;
    cxHeader2: TcxHeader;
    cxHeader3: TcxHeader;
    procedure FormManagerOkButton;
    procedure FormManagerDestroyForm;
    procedure FormManagerInitializeForm;
    procedure examinarButtonClick(Sender: TObject);
  private

    ConfiguracionAppFields : TConfiguracionFields;
    ParametrosRec : TParametrosHormigonesRec;
    RecordExists : Boolean;

  public

  end;

var   mntPg101Form : TmntPg101Form =nil;
      ParametrosHormigonesRec : TParametrosHormigonesRec;

const ctParametrosModulo = 1101;

procedure mntParametros;

implementation

{$R *.DFM}

uses   SysUtils,
       LibUtils,
       
       AppManager,

       Gdm101Frm,

       dm_pga;

procedure mntParametros;
begin
     CreateEditForm( TMntPg101Form, MntPg101Form, Gds101Frm.HormigonerasSection, True );
end;

procedure TmntPg101Form.FormManagerOkButton;
begin

     With ParametrosHormigonesRec do
       begin
       
       FicheroImportacion  := DataFicheroImportacion.Value;
       CampoObra  := DataCampoObra.Value;

       PosicionCampo[  1 ] := DataCPNroAlbaran.Value;
       LongitudCampo[  1 ] := DataCLNroAlbaran.Value;

       PosicionCampo[  2 ] := DataCPCliente.Value;
       LongitudCampo[  2 ] := DataCLCliente.Value;

       PosicionCampo[  3 ] := DataCPObra.Value;
       LongitudCampo[  3 ] := DataCLObra.Value;

       PosicionCampo[  4 ] := DataCPTarifa.Value;
       LongitudCampo[  4 ] := DataCLTarifa.Value;

       PosicionCampo[  5 ] := DataCPFecha.Value;
       LongitudCampo[  5 ] := DataCLFecha.Value;

       PosicionCampo[  6 ] := DataCPArticulo1.Value;
       LongitudCampo[  6 ] := DataCLArticulo1.Value;

       PosicionCampo[  7 ] := DataCPCantidad1.Value;
       LongitudCampo[  7 ] := DataCLCantidad1.Value;

       PosicionCampo[  8 ] := DataCPArticulo2.Value;
       LongitudCampo[  8 ] := DataCLArticulo2.Value;

       PosicionCampo[  9 ] := DataCPCantidad2.Value;
       LongitudCampo[  9 ] := DataCLCantidad2.Value;

       PosicionCampo[ 10 ] := DataCPArticulo3.Value;
       LongitudCampo[ 10 ] := DataCLArticulo3.Value;

       PosicionCampo[ 11 ] := DataCPCantidad3.Value;
       LongitudCampo[ 11 ] := DataCLCantidad3.Value;

       PosicionCampo[ 12 ] := DataCPArticulo4.Value;
       LongitudCampo[ 12 ] := DataCLArticulo4.Value;

       PosicionCampo[ 13 ] := DataCPCantidad4.Value;
       LongitudCampo[ 13 ] := DataCLCantidad4.Value;

       PosicionCampo[ 14 ] := DataCPArticulo5.Value;
       LongitudCampo[ 14 ] := DataCLArticulo5.Value;

       PosicionCampo[ 15 ] := DataCPCantidad5.Value;
       LongitudCampo[ 15 ] := DataCLCantidad5.Value;

       PosicionCampo[ 16 ] := DataCPArticulo6.Value;
       LongitudCampo[ 16 ] := DataCLArticulo6.Value;

       PosicionCampo[ 17 ] := DataCPCantidad6.Value;
       LongitudCampo[ 17 ] := DataCLCantidad6.Value;
       end;

     With ConfiguracionTable do
       begin
       WriteMemoBuffer( ConfiguracionTableData, ParametrosHormigonesRec, SizeOf( ParametrosHormigonesRec ) );
       Post;
       end;

end;

procedure TmntPg101Form.FormManagerDestroyForm;
begin
     If   not ReleasingApplication
     then Configuracion.Update;
end;

procedure TmntPg101Form.FormManagerInitializeForm;

const  PosDef : TArrayCampo = (  1, 11, 0,  0, 16, 24, 37, 43, 56, 62, 75, 81, 94, 100, 113, 119, 132 );
       LenDef : TArrayCampo = (  6, 5,  0,  0,  8, 13,  6, 13,  6, 13,  6, 13,  6, 13,   6,  13,   6 );
       
var    I : SmallInt;

begin

     With ConfiguracionTable do
       begin

       RecordExists := FindKey( [ ProgramNumber, ctParametrosModulo, CodigoEmpresaActual ] );
       If   RecordExists
       then begin
            Edit;
            ReadMemoBuffer( ConfiguracionTableData, ParametrosHormigonesRec, SizeOf( ParametrosHormigonesRec ) );
            end
       else begin
            Append;
            ConfiguracionTableAplicacion.Value := ProgramNumber;
            ConfiguracionTableTipo.Value := ctParametrosModulo;
            ConfiguracionTableCodigo.Value := CodigoEmpresaActual;

            FillChar( ParametrosRec, SizeOf( ParametrosRec ), #0 );
            ParametrosRec.FicheroImportacion := 'ALBBETON.PRN';
            end;

       With ParametrosHormigonesRec do
         begin

         // Algunos campos no son obligatorios, por lo que solo pongo valores por defecto si el primer campo está vacío (la primera vez)

         If   PosicionCampo[ 1 ]=0
         then For I := 1 to High( PosicionCampo ) do
                begin
                If   PosicionCampo[ I ]=0
                then PosicionCampo[ I ] := PosDef[ I ];
                If   LongitudCampo[ I ]=0
                then LongitudCampo[ I ] := LenDef[ I ];
                end;

         With Data do
           begin
           Active := True;
           Append;
           end;
           
         DataFicheroImportacion.Value := FicheroImportacion;
         DataCampoObra.Value          := CampoObra;

         DataCPNroAlbaran.Value       := PosicionCampo[  1 ];
         DataCLNroAlbaran.Value       := LongitudCampo[  1 ];

         DataCPCliente.Value          := PosicionCampo[  2 ];
         DataCLCliente.Value          := LongitudCampo[  2 ];

         DataCPObra.Value             := PosicionCampo[  3 ];
         DataCLObra.Value             := LongitudCampo[  3 ];

         DataCPTarifa.Value           := PosicionCampo[  4 ];
         DataCLTarifa.Value           := LongitudCampo[  4 ];

         DataCPFecha.Value            := PosicionCampo[  5 ];
         DataCLFecha.Value            := LongitudCampo[  5 ];

         DataCPArticulo1.Value        := PosicionCampo[  6 ];
         DataCLArticulo1.Value        := LongitudCampo[  6 ];

         DataCPCantidad1.Value        := PosicionCampo[  7 ];
         DataCLCantidad1.Value        := LongitudCampo[  7 ];

         DataCPArticulo2.Value        := PosicionCampo[  8 ];
         DataCLArticulo2.Value        := LongitudCampo[  8 ];

         DataCPCantidad2.Value        := PosicionCampo[  9 ];
         DataCLCantidad2.Value        := LongitudCampo[  9 ];

         DataCPArticulo3.Value        := PosicionCampo[ 10 ];
         DataCLArticulo3.Value        := LongitudCampo[ 10 ];

         DataCPCantidad3.Value        := PosicionCampo[ 11 ];
         DataCLCantidad3.Value        := LongitudCampo[ 11 ];

         DataCPArticulo4.Value        := PosicionCampo[ 12 ];
         DataCLArticulo4.Value        := LongitudCampo[ 12 ];

         DataCPCantidad4.Value        := PosicionCampo[ 13 ];
         DataCLCantidad4.Value        := LongitudCampo[ 13 ];

         DataCPArticulo5.Value        := PosicionCampo[ 14 ];
         DataCLArticulo5.Value        := LongitudCampo[ 14 ];

         DataCPCantidad5.Value        := PosicionCampo[ 15 ];
         DataCLCantidad5.Value        := LongitudCampo[ 15 ];

         DataCPArticulo6.Value        := PosicionCampo[ 16 ];
         DataCLArticulo6.Value        := LongitudCampo[ 16 ];

         DataCPCantidad6.Value        := PosicionCampo[ 17 ];
         DataCLCantidad6.Value        := LongitudCampo[ 17 ];

         end;

       end;

end;

procedure TmntPg101Form.ExaminarButtonClick(Sender: TObject);
begin
     With ApplicationForms.OpenFileDialog do
       begin
       InitialDir := ExtractFilePath( DataFicheroImportacion.Value );
       Filter     := 'Ficheros de datos (*prn)|*.PRN';
       If   Execute
       then With FicheroImportacionCtrl do
              begin
              PostEditValue( FileName );
              SetFocus;
              end;
       end;
end;

procedure ObtenParametros;
begin
     Configuracion.ObtenParametros( ctParametrosModulo, CodigoEmpresaActual, TParametrosRec( ParametrosHormigonesRec ) );
end;

initialization
     AddProcedure( imGetParamConf, 0, ObtenParametros );

end.

