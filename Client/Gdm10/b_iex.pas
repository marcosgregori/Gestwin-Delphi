
unit b_iex;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, AppForms, StdCtrls, Buttons, Mask,

  AppContainer,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,
  DataManager, cxPC, cxControls, cxGraphics, nxdb, cxGroupBox,
  cxRadioGroup, cxDBEdit, cxMaskEdit, cxDropDownEdit, cxIndexedComboBox,
  cxContainer, cxEdit, cxTextEdit, cxCalendar,

  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxLookAndFeels, cxLabel, cxPCdxBarPopupMenu, dxBarBuiltInMenu,

  Gim00Fields,
  Gim10Fields,

  dmi_iex;

type
  TBoxIexForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    ButtonsPanel: TgxEditPanel;
    CuentaTable: TnxeTable;
    FormManager: TgxFormManager;
    AsientoTable: TnxeTable;
    ApunteTable: TnxeTable;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    NroAsientoInicialCtrl: TcxDBTextEdit;
    NroAsientoFinalCtrl: TcxDBTextEdit;
    TabSheet2: TcxTabSheet;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    PathCtrl: TcxDBTextEdit;
    ExaminarButton: TgBitBtn;
    FormatoCtrl: TcxDBIndexedComboBox;
    ExternCuentaTable: TnxeTable;
    ExternAsientoTable: TnxeTable;
    ExternApunteTable: TnxeTable;
    Asiento1Table: TnxeTable;
    ExternEfectoCobrarTable: TnxeTable;
    EfectoCobrarTable: TnxeTable;
    EfectoPagarTable: TnxeTable;
    ExternEfectoPagarTable: TnxeTable;
    RemesaTable: TnxeTable;
    ExternRemesaTable: TnxeTable;
    RemesaPagoTable: TnxeTable;
    ExternRemesaPagoTable: TnxeTable;
    DestinoOrigenCtrl: TcxDBRadioGroup;
    DireccionCorreoCtrl: TcxDBTextEdit;
    Panel2: TcxGroupBox;
    gBitBtn1: TgBitBtn;
    gBitBtn2: TgBitBtn;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataProceso: TSmallintField;
    DataPath: TWideStringField;
    DataFormato: TSmallintField;
    DataNroAsientoInicial: TIntegerField;
    DataNroAsientoFinal: TIntegerField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataDestinoOrigen: TSmallintField;
    DataDireccionCorreo: TWideStringField;
    ProcesoCtrl: TcxDBIndexedComboBox;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    Label2: TcxLabel;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label8: TcxLabel;
    destinoOrigenLabel: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label4: TcxLabel;
    Label6: TcxLabel;
    Query: TnxeQuery;
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
    procedure ExaminarButtonClick(Sender: TObject);
    procedure PathCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ProcesoCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure DestinoOrigenCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure DireccionCorreoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure DireccionCorreoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure DireccionCorreoCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure NroAsientoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);

  private

    CuentaFields : TCuentaFields;
    AsientoFields : TAsientoFields;
    ApunteFields : TApunteFields;
    EfectoCobrarFields : TEfectoCobrarFields;
    EfectoPagarFields : TEfectoPagarFields;
    RemesaFields : TRemesaFields;
    RemesaPagoFields : TRemesaPagoFields;

    ExternCuentaFields : TCuentaFields;
    ExternAsientoFields : TAsientoFields;
    ExternApunteFields : TApunteFields;
    ExternEfectoCobrarFields : TEfectoCobrarFields;
    ExternEfectoPagarFields : TEfectoPagarFields;
    ExternRemesaFields : TRemesaFields;
    ExternRemesaPagoFields : TRemesaPagoFields;

    DsDireccionCorreoFields : TDireccionCorreoFields;

    ft_cuenta,
    ft_asiento,
    ft_apunte  : Text;

    StrDataPath  : String;

  public
    procedure ExecuteProcess;
    procedure AbreFicherosExternos( Exportar : Boolean );
    procedure CierraFicherosExternos( Exportar : Boolean );
    procedure ImportaDatos;
    procedure DoOnAcceptMessage;
  end;

var  BoxIexForm: TBoxIexForm = nil;

procedure exportacionImportacionAsientos;

implementation

{$R *.DFM}

uses   Files,
       FileCtrl,
       DateUtils,
       LibUtils,

       AppManager,

       EnterpriseDataAccess,
       SessionDataAccess,

       Gdm10Frm,

       dmi_ast,

       dm_sub,
       dm_sal,
       dm_ast,
       dm_iex,
       dm_tas,
       dm_ddc,
       dm_fac,

       a_ddc,

       b_msg,
       b_pro,
       b_dir,

       cx_ddc,
       cx_ast,

       f_prg;

resourceString
  RsMsg1   = 'Error creando los ficheros de exportación.';
  RsMsg2   = 'Exportación de asientos contables';
  RsMsg5   = 'Importación de asientos contables';
  RsMsg7   = 'Importando datos desde los ficheros ...';
  RsMsg8   = '¿Desea conservar los ficheros que acaba de importar?';
  RsMsg9   = 'La estructura de los registros del fichero %s no es correcta.';
  RsMsg10  = 'No se ha encontrado ningún apunte del asiento nº %d.';
  RsMsg11  = 'Se ha interrumpido el proceso de exportacion/importación.';
  RsMsg12  = 'Es conveniente que revise el contenido de sus ficheros.';
  RsMsg13  = 'Suprimiendo ficheros ...';
  RsMsg14  = 'Ha ocurrido un error durante el proceso de exportacion/importación.';
  // ..
  RsMsg17  = 'El documento de tipo %s, %s nº %s %d ya existe. No será importado.';
  RsMsg18  = 'Indique si desea cancelar ahora el proceso de importación.' + #13 + 'Si finaliza el proceso no se registrará ningún cambio en sus ficheros.';
  RsMsg19  = 'El documento de tipo %s, %s nº %s %d no ha sido importado.';
  RsMsg22  = 'Destino';
  RsMsg23  = 'Origen';

  RsAsientos = 'Asientos contables';

const
  ListaFicheros  : TStringArray = [ 'Cuenta.nx1',
                                    'Asiento.nx1',
                                    'Apunte.nx1',
                                    'EfectoCobrar.nx1',
                                    'Remesa.nx1',
                                    'EfectoPagar.nx1',
                                    'RemesaPago.nx1' ];

  ListaFicherosTexto : TStringArray = [ 'Cuenta.txt',
                                        'Asiento.txt',
                                        'Apunte.txt' ];

procedure exportacionImportacionAsientos;
begin
     CreateEditForm( TBoxIexForm, BoxIexForm, TGds10Frm.ContableSection, True );
end;

procedure TBoxIexForm.FormatoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With FormatoCtrl do
       begin
       If   EditValue=1
       then DataDestinoOrigen.Value := 0;  // Solo fichero
       DestinoOrigenCtrl.Enabled := EditValue=0;
       end;
end;

procedure TBoxIexForm.FormManagerInitializeForm;
begin
     CloseWindowWhenFocusLost := True;

     CuentaFields := TCuentaFields.Create( CuentaTable );
     AsientoFields := TAsientoFields.Create( AsientoTable );
     ApunteFields := TApunteFields.Create( ApunteTable );
     EfectoCobrarFields := TEfectoCobrarFields.Create( EfectoCobrarTable );
     EfectoPagarFields := TEfectoPagarFields.Create( EfectoPagarTable );
     RemesaFields := TRemesaFields.Create( RemesaTable );
     RemesaPagoFields := TRemesaPagoFields.Create( RemesaPagoTable );

     DsDireccionCorreoFields := TDireccionCorreoFields.Create( Self );

     DataFormato.Value := 0;
     DataProceso.Value := 0;
     DataDestinoOrigen.Value := 0; 
     DataPath.Value := ApplicationExportsPath;
     DataNroAsientoInicial.Value := 1;
     DataNroAsientoFinal.Value := 99999999;
     DataFechaInicial.Value := ApplicationContainer.FirstDayOfYearDate;
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;

end;

procedure TBoxIexForm.FormManagerOkButton;

var  MsgHeader : String;

begin
     case DataProceso.Value of
       0 : MsgHeader := RsMsg2;
       1 : MsgHeader := RsMsg5;
       end;
     CreateProcessForm( ExecuteProcess, MsgHeader );
end;

procedure TBoxIexForm.ExaminarButtonClick(Sender: TObject);
begin
     SelectDirectory( DataPath );
end;

procedure TBoxIexForm.AbreFicherosExternos( Exportar : Boolean );

Var   outcome   : Integer;

begin

     With ExportImport do
       case DataFormato.Value of
         0 : begin
             AbreFicherosExternos( [ ExternCuentaTable,
                                     ExternAsientoTable,
                                     ExternApunteTable,
                                     ExternEfectoCobrarTable,
                                     ExternEfectoPagarTable,
                                     ExternRemesaTable,
                                     ExternRemesaPagoTable ],

                                     Exportar );

             ExternCuentaFields := TCuentaFields.Create( ExternCuentaTable );
             ExternAsientoFields := TAsientoFields.Create( ExternAsientoTable );
             ExternApunteFields := TApunteFields.Create( ExternApunteTable );
             ExternEfectoCobrarFields := TEfectoCobrarFields.Create( ExternEfectoCobrarTable );
             ExternEfectoPagarFields := TEfectoPagarFields.Create( ExternEfectoPagarTable );
             ExternRemesaFields := TRemesaFields.Create( ExternRemesaTable );
             ExternRemesaPagoFields := TRemesaPagoFields.Create( ExternRemesaPagoTable );

             end;
         1 : begin
             If   Exportar
             then begin
                  AbreFicheroExterno( ExternCuentaTable, True );
                  CuentaFields := TCuentaFields.Create( ExternCuentaTable );
                  end;
             AbreFicheroTextoExterno( ft_cuenta, AddPathDelim( DataPath.Value ) + 'Cuenta.txt', Exportar );
             AbreFicheroTextoExterno( ft_asiento, AddPathDelim( DataPath.Value ) + 'Asiento.txt', Exportar );
             AbreFicheroTextoExterno( ft_apunte, AddPathDelim( DataPath.Value ) + 'Apunte.txt', Exportar );
             end;
         end;
end;

procedure TBoxIexForm.CierraFicherosExternos( Exportar : Boolean );
begin
     With ExportImport do
       case DataFormato.Value of
         0 : begin
             ExternCuentaTable.Close;
             ExternAsientoTable.Close;
             ExternApunteTable.Close;
             ExternEfectoCobrarTable.Close;
             ExternEfectoPagarTable.Close;
             ExternRemesaTable.Close;
             ExternRemesaPagoTable.Close;
             end;

         1 : begin
             If   Exportar
             then ExternCuentaTable.Close;
             CloseFile( ft_cuenta  );
             CloseFile( ft_asiento );
             CloseFile( ft_apunte  );
             end;
         end;
end;

procedure TBoxIexForm.ExecuteProcess;

Var   St  : string;

procedure ExportarAsientos;

procedure ProcesaAsiento;
begin

     With ExportImport do
       begin

       case DataFormato.Value of
         0 : begin

             ExternAsientoTable.CopyAndAppendRecord( AsientoTable );

             With AsientoFields do
               case TipoAsiento.Value of
                 taCobro,
                 taCancelacionEfecto,
                 taImpagado           : If   not ExternEfectoCobrarTable.FindKey( [ EjercicioFecha( FechaDocumento.Value ), Serie.Value, NroFactura.Value, NroEfecto.Value ] )
                                        then If   EfectoCobrarTable.FindKey( [ EjercicioFecha( FechaDocumento.Value ), Serie.Value, NroFactura.Value, NroEfecto.Value ] )
                                             then ExternEfectoCobrarTable.CopyAndAppendRecord( EfectoCobrarTable );

                 taPago               : If   not ExternEfectoPagarTable.FindKey( [ EjercicioFecha( FechaDocumento.Value ), propietario, Serie.Value, NroFactura.Value, NroEfecto.Value ] )
                                        then If   EfectoPagarTable.FindKey( [ EjercicioFecha( FechaDocumento.Value ), propietario, Serie.Value, NroFactura.Value, NroEfecto.Value ] )
                                             then ExternEfectoPagarTable.CopyAndAppendRecord( EfectoPagarTable );

                 taDescuento,
                 taCancelacion,
                 taCobroRemesa        : If   not ExternRemesaTable.FindKey( [ EjercicioFecha( FechaDocumento.Value ), NroFactura.Value ] )
                                        then If   RemesaTable.FindKey( [ EjercicioFecha( FechaDocumento.Value ), NroFactura.Value ] )
                                             then ExternRemesaTable.CopyAndAppendRecord( RemesaTable );

                 taPagoRemesa         : If   not ExternRemesaPagoTable.FindKey( [ EjercicioFecha( FechaDocumento.Value ), NroFactura.Value ] )
                                        then If   RemesaPagoTable.FindKey( [ EjercicioFecha( FechaDocumento.Value ), NroFactura.Value ] )
                                             then ExternRemesaPagoTable.CopyAndAppendRecord( RemesaPagoTable );
                 end;

             end;

         1 : With AsientoFields do
               WriteLn( ft_asiento, ASCFormat( ASCInt( NroAsiento.Value ) +
                                               ASCDate( Fecha.Value ) +
                                               ASCInt( TipoAsiento.Value ) +
                                               ASCText( Serie.Value ) +
                                               ASCInt( NroFactura.Value ) +
                                               ASCInt( NroEfecto.Value ) +
                                               ASCDate( FechaDocumento.Value ) +
                                               ASCText( Propietario.Value ) +
                                               ASCInt( NroRegistro.Value ) +
                                               ASCText( Nombre.Value ) +
                                               ASCInt( Origen.Value ) ) );
         end;

       With ApunteTable do
         begin
         With AsientoFields do
           SetRange( [ Ejercicio.Value, NroAsiento.Value, 1 ], [ Ejercicio.Value, NroAsiento.Value, MaxSmallint ] );
         First;
         While not Eof  do
           begin

           ProcessFrame.AddRecordMsg( StrFormatDate( AsientoFields.Fecha.Value, dfDefault ) + ' , ' +
                                      StrInt( AsientoFields.NroAsiento.Value ) + ' , ' +
                                      StrInt( ApunteFields.NroApunte.Value ) );

           case DataFormato.Value of
             0 : ExternApunteTable.CopyAndAppendRecord( ApunteTable );

             //* 19.06.2002 Añadido DecimalesMoneda en los campos numéricos

             1 : With ApunteFields do
                   WriteLn( ft_apunte, ASCFormat( ASCInt( NroAsiento.Value ) +
                                                  ASCInt( NroApunte.Value ) +
                                                  ASCDate( Fecha.Value ) +
                                                  ASCText( Subcuenta.Value ) +
                                                  ASCText( CentroCoste.Value ) +
                                                  ASCText( Contrapartida.Value ) +
                                                  ASCText( Concepto.Value ) +
                                                  ASCDouble( Debe.Value, DecimalesMoneda ) +
                                                  ASCDouble( Haber.Value, DecimalesMoneda ) +
                                                  ASCInt( Ord( TipoApunte.Value ) ) +
                                                  ASCDouble( BaseImponible.Value, DecimalesMoneda ) +
                                                  ASCInt( Tipo.Value ) +
                                                  ASCDouble( CuotaIVA.Value, DecimalesMoneda ) +
                                                  ASCDouble( CuotaRE.Value, DecimalesMoneda ) +
                                                  ASCDouble( ImporteTotal.Value, DecimalesMoneda ) ) );
             end;

           With CuentaTable do
             If   FindKey( [ ApunteFields.Subcuenta.Value ] )
             then ExternCuentaTable.CopyAndAppendRecord( CuentaTable, False );

           Next;
           end;

         end;

       RecordProcessed := True;
       end;

end;

procedure InsertaParametros;
begin
     With ExportImport do
       begin
       HeaderList.Values[ RsCodigoEmpresa ] := CodigoEmpresaActual;
       HeaderList.Values[ RsNombreEmpresa ] := ApplicationContainer.Empresa_Nombre;
       HeaderList.Values[ RsTipoDeDatos ] := RsAsientos;
       HeaderList.Values[ RsFormato ] := FormatoCtrl.Text;
       If   PageControl.ActivePageIndex=0
       then begin
            HeaderList.Values[ RsNroAsientoInicial ] := IntToStr( NroAsientoInicialCtrl.EditValue );
            HeaderList.Values[ RsNroAsientoFinal ] := IntToStr( NroAsientoFinalCtrl.EditValue );
            end
       else begin
            HeaderList.Values[ RsFechaInicial ] := StrFormatDate( FechaInicialCtrl.EditValue );
            HeaderList.Values[ RsFechaFinal ] := StrFormatDate( FechaFinalCtrl.EditValue );
            end;
       end;
end;

begin

     With ProcessFrame do
       begin

       try

         ExportImport.CleanExportDir;

         AbreFicherosExternos( True );

         try
           case PageControl.ActivePageIndex of
             0 : With AsientoTable do
                   begin
                   IndexFieldNames := 'Ejercicio;NroAsiento';
                   SetRange( [ ApplicationContainer.Ejercicio, DataNroAsientoInicial.Value ],
                             [ ApplicationContainer.Ejercicio, DataNroAsientoFinal.Value ] );
                   First;
                   While not Eof and not Canceled do
                     begin
                     ProcesaAsiento;
                     Next;
                     end;
                   end;

             1 : With AsientoTable do
                   begin
                   IndexFieldNames := 'Fecha';
                   SetRange( [ DataFechaInicial.Value ], [ DataFechaFinal.Value ] );
                   First;
                   While not Eof and not Canceled do
                     begin
                     ProcesaAsiento;
                     Next;
                     end;
                   end;
             end;

           If   not Canceled and ( DataFormato.Value=1 )
           then With ExportImport, ExternCuentaTable, CuentaFields do
                  begin
                  First;
                  While not Eof do
                    begin
                    St := ASCText( Codigo.Value ) +
                          ASCInt( Nivel.Value ) +
                          ASCText( Descripcion.Value );
                    WriteLn( ft_cuenta, ASCFormat( St ) );
                    Next;
                    end;
                  end;

         finally
           CierraFicherosExternos( True );
           end;

         If   not Canceled
         then With ExportImport do
                If   DataFormato.Value=0
                then begin

                     //* 04.11.2000 (9.2) Añadida la opción de export/import por e-mail

                     case DataDestinoOrigen.Value of
                       0 : begin
                           CompressAndCopyFiles( ListaFicheros, SessionDataModule.ExportsDatabase.Path, StrDataPath, True );
                           SetBackupInfo( StrDataPath, tdAsiento, True );
                           end;

                       1 : begin
                           InsertaParametros;
                           var  CompressedFile := SMTPCompressFiles( ListaFicheros, [], SessionDataModule.ExportsDatabase.Path );
                           SMTPInitDataPacket( tdAsiento, DsDireccionCorreoFields, [ CompressedFile ], True );
                           SMTPSend;
                           end;

                       end;

                     end;

       except on E : Exception do
         begin
         ShowException( e, self );
         AddMsg( ntError, RsMsg14 );
         end;
       end;

       end;

end;

procedure ImportarAsientos;
begin

     With ProcessFrame, ExportImport do
       begin

       try

         ExportImport.CleanImportDir;

         case DataDestinoOrigen.Value of
           0 : begin

               CompruebaDisco( StrDataPath, 0, True );

               // Cuando no se especifica directorio de destino se asume el de importacion

               If   DataFormato.Value=0
               then If   SetBackupInfo( StrDataPath, tdAsiento, False )
                    then DeCompressAndCopyFiles( StrDataPath, ListaFicheros );

               ImportaDatos;
               end;

           1 : POP3Init( tdAsiento, 0, DoOnAcceptMessage );
           end;

       except on E : Exception do
         AddMsg( ntError, RsMsg11 + #13 + RsMsg12 );
         end;

       end;
end;

begin
     StrDataPath := AddPathDelim( DataPath.Value );
     case DataProceso.Value of
       0 : ExportarAsientos;
       1 : ImportarAsientos;
       end;
end;

procedure TBoxIexForm.DoOnAcceptMessage;
begin
     With ExportImport do
       DeCompressFiles( SessionDataModule.GetImportDirectory, ListaFicheros );
     ImportaDatos;
end;

procedure TBoxIexForm.ImportaDatos;

var NroMes : Integer;
    NroAsientoActual : LongInt;
    ListaParametros : TStringList;
    LineaCuenta,
    LineaAsiento,
    LineaApunte : string;
    CodeLen : SmallInt;
    AvisoCancelacion : Boolean;

procedure ProcesaAsiento;

var  NroAstoTmp : LongInt;
     SumaDebe,
     SumaHaber : Decimal;

begin

     If   ExternAsientoFields.Ejercicio.Value=ApplicationContainer.Ejercicio
     then begin

          AsientoTable.Append;

          NroAstoTmp := ExternAsientoFields.NroAsiento.Value;

          AsientoFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
          AsientoFields.NroAsiento.Value := NroAsientoActual;

          With AsientoFields do
            try

              If   ( TipoAsiento.Value in [ taFraEmitida..taPagoRemesa ] ) and
                   ( Asiento1Table.FindKey( [ TipoAsiento.Value, Ejercicio.Value, Propietario.Value, Serie.Value, NroFactura.Value, NroEfecto.Value ] ) )
              then begin
                   If   not AvisoCancelacion
                   then begin
                        If   ShowNotification( ntAcceptCancel, Format( RsMsg17, [ dm_tas.TipoAsiento.Descripcion( TipoAsiento.Value ),
                                                                       Propietario.Value,
                                                                       Serie.Value,
                                                                       NroFactura.Value ] ), RsMsg18 )=mrCancel
                        then begin
                             ProcessFrame.Canceled := True;
                             Abort;
                             end;
                        AvisoCancelacion := True;
                        end;
                   ProcessFrame.AddMsg( ntWarning, Format( RsMsg19, [ dm_tas.TipoAsiento.Descripcion( TipoAsiento.Value ),
                                                                     Propietario.Value,
                                                                     Serie.Value,
                                                                     NroFactura.Value ] ) );
                   AsientoTable.Cancel;
                   end
              else With ExportImport, AsientoTable do
                     begin

                     //* 13.09.2000 Añadida la importación de los documentos asociados

                     With AsientoFields do
                       case TipoAsiento.Value of
                         taCobro           : If   not EfectoCobrarTable.FindKey( [ EjercicioFecha( FechaDocumento.Value ), Serie.Value, NroFactura.Value, NroEfecto.Value ] )
                                             then If   ExternEfectoCobrarTable.FindKey( [ EjercicioFecha( FechaDocumento.Value ), Serie.Value, NroFactura.Value, NroEfecto.Value ] )
                                                  then EfectoCobrarTable.CopyAndAppendRecord( ExternEfectoCobrarTable );

                         taPago            : If   not EfectoPagarTable.FindKey( [ EjercicioFecha( FechaDocumento.Value ), propietario, Serie.Value, NroFactura.Value, NroEfecto.Value ] )
                                             then If   ExternEfectoPagarTable.FindKey( [ EjercicioFecha( FechaDocumento.Value ), propietario, Serie.Value, NroFactura.Value, NroEfecto.Value ] )
                                                  then EfectoPagarTable.CopyAndAppendRecord( ExternEfectoPagarTable );
                         taDescuento,
                         taCancelacion,
                         taCobroRemesa     : If   not RemesaTable.FindKey( [ EjercicioFecha( FechaDocumento.Value ), NroFactura.Value ] )
                                             then If   ExternRemesaTable.FindKey( [ EjercicioFecha( FechaDocumento.Value ), NroFactura.Value ] )
                                                  then RemesaTable.CopyAndAppendRecord( ExternRemesaTable );

                         taPagoRemesa      : If   not RemesaPagoTable.FindKey( [ EjercicioFecha( FechaDocumento.Value ), NroFactura.Value ] )
                                             then If   ExternRemesaPagoTable.FindKey( [ EjercicioFecha( FechaDocumento.Value ), NroFactura.Value ] )
                                                  then RemesaPagoTable.CopyAndAppendRecord( ExternRemesaPagoTable );
                         end;

                     CopyAndAppendRecord( ExternAsientoTable, True, True );

                     If   AsientoFields.TipoAsiento.Value in [ taFraRecibida, taFraEmitida ]
                     then Factura.CompruebaRegistroFacturaAsiento( AsientoFields.NroAsiento.Value );

                     NroMes := MonthOf( AsientoFields.Fecha.Value );
                     SumaDebe  := 0.0;
                     SumaHaber := 0.0;

                     With ExternApunteTable do
                       begin
                       SetRange( [ AsientoFields.Ejercicio, NroAstoTmp, 1 ], [ AsientoFields.Ejercicio, NroAstoTmp, MaxSmallint ] );
                       First;
                       While not Eof do
                         begin

                         ApunteTable.Append;

                         With AsientoFields do
                           begin
                           ApunteFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
                           ApunteFields.NroAsiento.Value := NroAsiento.Value;
                           ApunteFields.NroApunte.Value := ExternApunteFields.NroApunte.Value;

                           ApunteTable.CopyAndAppendRecord( ExternApunteTable, True, True );

                           ProcessFrame.AddRecordMsg( StrFormatDate( Fecha.Value, dfDefault ) + ' , ' +
                                                     StrInt( NroAsiento.Value ) + ' , ' +
                                                     StrInt( ExternApunteFields.NroApunte.Value ) );
                           end;

                         Saldos.ActualizaSaldos( AsientoFields.TipoAsiento.Value, ApunteFields, False );

                         Next;
                         end;

                       {
                       //* 08.07.99 Elevado el límite de redondeo de 0.1 a 0.5

                       If   not DblEqual( SumaDebe, SumaHaber ) and ( Abs( SumaDebe - SumaHaber )<0.5 )
                       then With ApunteTable do
                              begin
                              FindGreaterOrEqual( [ AsientoFields.Ejercicio.Value, AsientoFields.NroAsiento.Value, 2 ] ); // Siempre a partir del segundo apunte
                              If   not Eof and
                                   ( ApunteFields.Ejercicio.Value=AsientoFields.Ejercicio.Value ) and
                                   ( ApunteFields.NroAsiento.Value=AsientoFields.NroAsiento.Value )
                              then With ApunteFields do
                                     begin
                                     Saldos.Actualiza( AsientoFields, ApunteFields, True );
                                     Edit;
                                     If   Cargo.Value
                                     then Importe.Value := Importe.Value - SumaDebe  + SumaHaber
                                     else Importe.Value := Importe.Value - SumaHaber + SumaDebe;
                                     If   AsientoFields.TipoAsiento.Value in [ taFraEmitida, taFraRecibida ]
                                     then BaseImponible.Value := Importe.Value;
                                     Saldos.Actualiza( AsientoFields, ApunteFields, False );
                                     Post;
                                     end;
                              end;
                         }

                       end;

                     end;

            except
              AsientoTable.Cancel;
              raise;
              end;

          end;
end;

procedure ProcesaAsientoASCII;

Var    NroAstoTmp : LongInt;
       InsertaAsiento,
       FinAsiento,
       ApunteInsertado : Boolean;
       FechaAsiento : TDate;

begin

     With ExportImport do
       begin

       // CompruebaEjercicio( AsientoFields.Fecha.Value );

       //* 09.10.2010 Si el fichero contiene asientos de varios ejercicios importo solo los del actual

       NroAstoTmp := LongIntASC( ListaParametros.Strings[ 0 ] );
       FechaAsiento := DateASC( ListaParametros.Strings[ 1 ] );

       InsertaAsiento := EjercicioFecha( FechaAsiento )=ApplicationContainer.Ejercicio;

       If   InsertaAsiento
       then begin

            If   ListaParametros.Count=11
            then begin

                 AsientoTable.Append;

                 With AsientoFields, ListaParametros do
                   begin
                   Ejercicio.Value := ApplicationContainer.Ejercicio;
                   NroAsiento.Value := NroAstoTmp;
                   Fecha.Value := FechaAsiento;
                   TipoAsiento.Value := ByteASC( Strings[ 2 ] );
                   Serie.Value := Strings[ 3 ];
                   NroFactura.Value := LongIntASC( Strings[ 4 ] );
                   NroEfecto.Value := ByteASC( Strings[ 5 ] );
                   FechaDocumento.Value := DateASC( Strings[ 6 ] );
                   Propietario.Value := Strings[ 7 ];
                   NroRegistro.Value := LongIntASC( Strings[ 8 ] );
                   Nombre.Value := Strings[ 9 ];
                   Origen.Value := IntegerASC( Strings[ 10 ] );
                   end;

                 end
            else begin
                 ProcessFrame.AddMsg( ntError, Format( RsMsg9, [ 'Asiento.txt' ] ) );
                 Abort;
                 end;

            AsientoFields.NroAsiento.Value := NroAsientoActual;

            AsientoTable.Post;

            If   AsientoFields.TipoAsiento.Value in [ taFraRecibida, taFraEmitida ]
            then Factura.CompruebaRegistroFacturaAsiento( NroAsientoActual );

            end;

       NroMes := MonthOf( AsientoFields.Fecha.Value );
       ExtraeParametros( LineaApunte, ListaParametros );

       FinAsiento := False;
       ApunteInsertado := False;

       repeat

         If   ListaParametros.Count<>15
         then begin
              ProcessFrame.AddMsg( ntError, Format( RsMsg9, [ 'Apunte.txt' ] ) );
              Abort;
              end
         else begin
              If   LongIntASC( ListaParametros.Strings[ 0 ] )<>NroAstoTmp
              then FinAsiento := True
              else begin

                   If   InsertaAsiento
                   then begin

                        ApunteTable.Append;

                        ApunteFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
                        ApunteFields.NroAsiento.Value := AsientoFields.NroAsiento.Value;

                        With ApunteFields, ListaParametros do
                          begin

                          NroApunte.Value := IntegerASC( Strings[ 1 ] );
                          Fecha.Value := DateASC( Strings[ 2 ] );
                          Subcuenta.Value := Strings[ 3 ];
                          CentroCoste.Value := Strings[ 4 ];
                          Contrapartida.Value := Strings[ 5 ];
                          Concepto.Value := Strings[ 6 ];
                          Debe.Value := Abs( DecimalASC( Strings[ 7 ] ) );
                          Haber.Value := Abs( DecimalASC( Strings[ 8 ] ) );
                          TipoApunte.Value := IntegerASC( Strings[ 9 ] );
                          BaseImponible.Value := DecimalASC( Strings[ 10 ] );
                          Tipo.Value := ByteASC( Strings[ 11 ] );
                          CuotaIVA.Value := DecimalASC( Strings[ 12 ] );
                          CuotaRE.Value := DecimalASC( Strings[ 13 ] );
                          ImporteTotal.Value := DecimalASC( Strings[ 14 ] );

                          ProcessFrame.AddRecordMsg( StrFormatDate( AsientoFields.Fecha.Value, dfDefault ) + ' , ' +
                                                     StrInt( AsientoFields.NroAsiento.Value ) + ' , ' +
                                                     StrInt( ApunteFields.NroApunte.Value ) );

                          Saldos.ActualizaSaldos( AsientoFields.TipoAsiento.Value, ApunteFields, False );  // No está incluido en la transacción porque se ejecuta en el servidor. Puede provocar inconsistencias en los saldos si se produce un error.
                          ApunteTable.Post;

                          ApunteInsertado  := True;
                          end;

                        end;

                   If   not Eof( ft_apunte )
                   then begin
                        Readln( ft_apunte, LineaApunte );
                        ExtraeParametros( LineaApunte, ListaParametros );
                        end
                   else FinAsiento := True;

                  end;

              end;

       until FinAsiento or ProcessFrame.Canceled;

       If   InsertaAsiento and
            not ProcessFrame.Canceled and
            not ApunteInsertado
       then begin
            ProcessFrame.AddMsg( ntError, Format( RsMsg10, [ NroAstoTmp ] ) );
            Abort;
            end;

       end;

end;

begin

      try

        ListaParametros := TStringList.Create;

        AbreFicherosExternos( False );

        With ProcessFrame, ExportImport do
          begin

          try

            try

              EnterpriseDataModule.StartTransaction( [ CuentaTable,
                                                       AsientoTable,
                                                       ApunteTable ] );

              NroAsientoActual := Asiento.ProximoNroAsiento;

              AddMsg( ntInformation, RsMsg7 );

              case DataFormato.Value of
                0 : begin

                    With ExternCuentaTable do
                      begin
                      First;
                      While not Eof and not Canceled do
                        begin
                        AddRecordMsg( CuentaFields.Codigo.Value );
                        CuentaTable.CopyAndAppendRecord( ExternCuentaTable, False );
                        Next;
                        end;

                      end;

                    If   not Canceled
                    then With ExternAsientoTable do
                           begin
                           First;
                           If   not Eof
                           then begin
                                // CompruebaEjercicio( ExternAsientoFields.Fecha.Value );
                                While not Eof and not Canceled do
                                  begin
                                  ProcesaAsiento;
                                  Inc( NroAsientoActual );
                                  Next;
                                  end;
                                end;
                           end;

                    end;

                1 : begin

                    While not Eof( ft_cuenta ) and not Canceled do
                      begin
                      Readln( ft_cuenta, LineaCuenta );
                      ExtraeParametros( LineaCuenta, ListaParametros );

                      With CuentaFields, ListaParametros do
                        If   not CuentaTable.FindKey( [ Strings[ 0 ] ] )
                        then begin
                             CuentaTable.Append;
                             Codigo.Value := Strings[ 0 ];
                             CodeLen := Length( Codigo.Value );
                             If   CodeLen=9
                             then CodeLen := Cuenta.NivelSubcuenta;
                             Nivel.Value := CodeLen;
                             Descripcion.Value := Strings[ 2 ];
                             CuentaTable.Post;
                             end;

                      AddRecordMsg( CuentaFields.Codigo.Value );
                      end;

                    If   not Canceled
                    then begin
                         Readln( ft_apunte, LineaApunte );   // simplemente para posicionarse
                         While not Eof( ft_asiento ) and
                               not Eof( ft_apunte ) and
                               not Canceled do
                           begin
                           Readln( ft_asiento, LineaAsiento );
                           ExtraeParametros( LineaAsiento, ListaParametros );
                           ProcesaAsientoASCII;
                           Inc( NroAsientoActual );
                           end;
                         end;

                    end;

                end;

              If   Canceled
              then Abort
              else EnterpriseDataModule.Commit;

            except on E : Exception do
              begin
              EnterpriseDataModule.RollBack;
              ShowException( E, Self );
              ProcessFrame.AddMsg( ntError, RsgMsg120 );
              Canceled := True;
              end;
            end;

          finally
            CierraFicherosExternos( False );
          end;

          If   not Canceled
          then If   DataDestinoOrigen.Value=0
               then If   ShowNotification( ntQuestion, RsMsg8, '' )=mrNo
                    then begin
                         AddMsg( ntInformation, RsMsg13 );
                         case DataFormato.Value of
                           0 : EraseListOfFiles( StrDataPath, [ BackupFileName, BackupInfoFileName, ListaFicheros[ 0 ], ListaFicheros[ 1 ], ListaFicheros[ 2 ], ListaFicheros[ 3 ], ListaFicheros[ 4 ], ListaFicheros[ 5 ], ListaFicheros[ 6 ] ] );
                           1 : EraseListOfFiles( StrDataPath, ListaFicherosTexto );
                           end;
                         end;


          end;

      finally
        ListaParametros.free;
      end;

end;

procedure TBoxIexForm.NroAsientoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAsientos( Sender );
end;

procedure TBoxIexForm.PathCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   PathCtrl.UserValidateAction or FormManager.ValidatingFormData
     then If   not ValueIsEmpty( DisplayValue )
          then If   not DirectoryExists( DisplayValue )
               then begin
                    Error := True;
                    ErrorText := JoinMessage( RsgMsg394, RsgMsg395 );
                    end;
end;

procedure TBoxIexForm.ProcesoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With ProcesoCtrl do
      begin
       NroAsientoInicialCtrl.Enabled := EditValue=0;
       NroAsientoFinalCtrl.Enabled := EditValue=0;
       With PageControl do
         begin
         ActivePage := TabSheet1;
         Enabled := EditValue=0;
         end;
       With DestinoOrigenLabel do
         case ItemIndex of
           0 : Caption := RsMsg22;
           1 : Caption := RsMsg23;
           end;
       DireccionCorreoCtrl.Enabled := ( EditValue=0 ) and ( DataDestinoOrigen.Value=1 );
       end;
end;

procedure TBoxIexForm.DestinoOrigenCtrlPropertiesEditValueChanged( Sender: TObject);
begin
     With DestinoOrigenCtrl do
       begin
       PathCtrl.Enabled := EditValue=0;
       ExaminarButton.Enabled := EditValue=0;
       DireccionCorreoCtrl.Enabled := ( DataProceso.Value=0 ) and ( EditValue=1 );
       end;
end;

procedure TBoxIexForm.DireccionCorreoCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntDireccionesCorreo( [ Sender.EditingValue ] );
end;

procedure TBoxIexForm.DireccionCorreoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaDireccionesCorreo( Sender );
end;

procedure TBoxIexForm.DireccionCorreoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     DireccionCorreo.Valida( Sender, tdAmbos, DisplayValue, ErrorText, Error, DsDireccionCorreoFields );
end;

end.
