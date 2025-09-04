
unit b_sdd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, AppForms, StdCtrls, Buttons, Mask, 

  AppContainer,
  Menus,
  cxLookAndFeelPainters,
  cxButtons,
  DataManager,
  cxCheckBox,
  cxDBEdit,
  cxControls,
  cxContainer,
  cxEdit,
  cxTextEdit,
  dxmdaset,
  DB,
  nxDB, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel, cxGroupBox;

type
  TboxSddForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    buttonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    EjercicioCtrl: TcxDBTextEdit;
    CompactarCtrl: TcxDBCheckBox;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataEjercicio: TSmallintField;
    DataCompactar: TBooleanField;
    cxGroupBox1: TcxGroupBox;
    Label3: TcxLabel;
    cxLabel1: TcxLabel;
    Label2: TcxLabel;
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;

  private
    ActiveDatabase : TnxDatabase;

  public
    procedure ExecuteProcess;
    
  end;

var boxSddForm: TboxSddForm;

procedure SupresionDatos;

implementation

{$R *.DFM}

uses   LibUtils,
       AppManager,
       DataAccess,
       EnterpriseDataAccess,
       NexusRpcData,

       Gdm00Dm,
       Gdm00Frm,

       b_msg,
       b_pro,

       f_prg;

resourceString
  RsMsg2   = 'Realizando el proceso solicitado ...';
  RsMsg3   = 'Suprimiendo';
  RsMsg4   = 'Compactando';
  RsMsg5   = 'Proceso realizado satisfactoriamente';
  RsMsg6   = 'ATENCION: Está a punto de suprimir todos los movimientos del Ejercicio %d de la empresa activa.';
  RsMsg7   = '¿Esta seguro de que desea realizar el proceso?.';
  RsMsg8   = 'Se ha producido error durante la compactación de la tabla %s.';

procedure SupresionDatos;
begin
     CloseAllDataModules;
     NexusRpc.FreeAllSessionDataModules;
     CreateEditForm( TBoxSddForm, boxSddForm, nil, True );
end;

procedure TboxSddForm.FormManagerInitializeForm;
begin

     CloseWindowWhenFocusLost := True;

     DataEjercicio.Value := ApplicationContainer.Ejercicio - 6;
     DataCompactar.Value := True;

end;

procedure TboxSddForm.FormManagerOkButton;
begin
     If   ShowNotification( ntQuestionWarning, Format( RsMsg6, [ DataEjercicio.Value ] ), RsMsg7 )=mrYes
     then begin
          Enabled := False;
          CreateProcessForm( ExecuteProcess, Caption );
          end;
end;

procedure TboxSddForm.ExecuteProcess;

var   Ejercicio,
      Index : SmallInt;

const DiarioProcesosTable : String = 'DiarioProcesos';
      NroFicheros = 19;
      ListaFicheros : array[ 1..NroFicheros ] of String = ( 'Saldos',
                                                            'Asiento',
                                                            'Apunte',
                                                            'Existencia',
                                                            'EfectoCobrar',
                                                            'EfectoPagar',
                                                            'Remesa',
                                                            'RemesaPago',
                                                            'ProveedorDatEcon',
                                                            'Movimiento',
                                                            'LineaMovimiento',
                                                            'FacturaCompras',
                                                            'FacturaVentas',
                                                            'ClienteDatEcon',
                                                            'VendedorDatEcon',
                                                            'Stock',
                                                            'ArticuloDatEcon',
                                                            'ConsumoCompras',
                                                            'ConsumoVentas' );

procedure EraseDataInTable( ATableName    : String;
                             ASQLWhereText : String = '';
                             AppTable      : Boolean = False );

var  SQLText : String;

begin
     ProcessFrame.AddMsg( ntInformation, '  ' + ATableName );
     SQLText := 'DELETE FROM ' + ATableName + ' ';
     If   ASQLWhereText=''
     then StrAdd( SQLText, ' WHERE Ejercicio=' + IntToStr( Ejercicio ) )
     else StrAdd( SQLText, ASQLWhereText );
     ExecQuery( ActiveDatabase, SQLText );
     ProcessFrame.CheckCanceled;
end;

procedure PackDataTable( TableName : String );
begin
     With ProcessFrame do
       begin
       If   DataAccessModule.PackTable( ActiveDatabase, TableName )<>idOK
       then begin
            AddMsg( ntError, Format( RsMsg8, [ TableName ] ) );
            Abort;
            end;
       CheckCanceled;
       end;
end;

begin

     With ProcessFrame do
       try

         DataModule00.CloseGlobalFiles;

         try

           Ejercicio := DataEjercicio.Value;

           AddMsg( ntInformation, RsMsg2 );
           AddMsg( ntInformation, RsMsg3, True, True );

           ActiveDatabase := DataAccessModule.AppDatabase;

           EraseDataInTable( DiarioProcesosTable,
                             'WHERE CodigoEmpresa=' + QuotedStr( CodigoEmpresaActual ) +
                             ' AND Fecha BETWEEN ' + SQLDateString( FechaPrimerDiaEjercicio( Ejercicio ) ) + ' AND ' + SQLDateString( FechaUltimoDiaEjercicio( Ejercicio ) ) );

           ActiveDatabase := EnterpriseDataModule.UserDatabase;

           For Index := 1 to NroFicheros do
             EraseDataInTable( ListaFicheros[ Index ] );

           If   DataCompactar.Value
           then begin

                AddMsg( ntInformation, RsMsg4, True, True );

                ActiveDatabase := DataAccessModule.AppDatabase;

                PackDataTable( DiarioProcesosTable );

                ActiveDatabase := EnterpriseDataModule.UserDatabase;

                For Index := 2 to NroFicheros do
                  PackDataTable( ListaFicheros[ Index ] );

                end;

           ShowNotification( ntInformation, RsMsg5, '' )

         except on E : Exception do ShowException( E, Self );
           end;

       finally

         try

           DataModule00.OpenGlobalFiles;

         except
           {
             Si no se pueden reabrir los ficheros globales más vale salir de la
             aplicación
           }
           PrgExit( True );
           end;

         end;
end;

procedure Initialize;
begin
     If   assigned( Gds00Frm )
     then Gds00Frm.OnSupresionDatos := SupresionDatos;
end;

initialization
     AddProcedure( imInitialize, 0, Initialize );
end.
