unit b_roi;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,

  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxDBEdit, DB, nxdb, DataManager, cxCurrencyEdit, dxmdaset,

  ReportManager,

  Gim00Fields,
  Gim10Fields, dxSkinsCore, dxSkinsDefaultPainters, cxGroupBox, cxRadioGroup,
  cxGraphics, cxIndexedComboBox, cxSpinEdit, cxLookAndFeels, cxLabel, cxImage, dxGDIPlusClasses,
  dxUIAClasses;


type
    TBoxRolForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Label4: TcxLabel;
    PathCtrl: TcxDBTextEdit;
    examinarButton: TgBitBtn;
    ficheroLabel: TcxLabel;
    NombreFicheroLabel: TcxLabel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Label1: TcxLabel;
    gxRangeBox1: TgxRangeBox;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    Data: TgxMemData;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataSource: TDataSource;
    DataPath: TWideStringField;
    DataPeriodo: TSmallintField;
    Label2: TcxLabel;
    NroPresentacionCtrl: TcxDBSpinEdit;
    DataNroPresentacion: TSmallintField;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    cxGroupBox2: TcxGroupBox;
    TituloLabel: TcxLabel;
    Image1: TcxImage;
    PeriodoCtrl: TcxDBIndexedComboBox;
    PeriodicidadCtrl: TcxDBRadioGroup;
    PeriodoLabel: TcxLabel;
    cxLabel2: TcxLabel;
    DataPeriodicidad: TSmallintField;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure examinarButtonClick(Sender: TObject);
    procedure PathCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FechaInicialCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure FechaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure PeriodicidadCtrlPropertiesChange(Sender: TObject);
    procedure PeriodoCtrlPropertiesChange(Sender: TObject);
    procedure NroPresentacionCtrlPropertiesChange(Sender: TObject);
    private

      FFijandoPeriodo,
      FEjercicioAnterior : Boolean;

      DsClienteFields : TClienteFields;
      DsTiposIVAFields : TTiposIVAFields;
      DsProveedorFields : TProveedorFields;
      DsPaisFields : TPaisFields;

      OperacionesTable : TnxeTable;
      OperacionesFields : TOperacionesIntracomunitariasFields;

      NombreFichero : String;
      Fichero : Text;
      NIFDeclarado,
      NombreDeclarado,
      PaisDeclarado : String;

      function TrimestreLiquidacion : SmallInt;

      procedure ExecuteProcess;
    public


    end;

var  BoxRolForm: TBoxRolForm = nil;

procedure DeclaracionModelo349;


implementation

uses   DateUtils,
       Files,
       FileCtrl,
       LibUtils,

       AppManager,

       EnterpriseDataAccess,
       SessionDataAccess,

       Gdm00Dm,
       Gdm10Dm,

       dmi_ast,
       dmi_fac,

       dm_ast,
       dm_fac,
       dm_cli,
       dm_pro,
       dm_iex,
       dm_sub,
       dm_prv,
       dm_ban,
       dm_pai,
       dm_iva,
       dm_reg,

       b_pro,
       b_msg,
       b_dir,

       f_prg;

{$R *.dfm}

resourceString
       RsMsg2  = 'Se ha creado el fichero [URL=%0:s]%0:s[/URL].';
       RsMsg3  = 'Se ha interrumpido el proceso.'#13'Los datos contenidos en el fichero no deben ser considerados válidos.'#13'Solucione el problema y reintente el proceso.';

       RsMsg6  = 'Es obligatorio indicar el número de teléfono de la empresa.';
       RsMsg7  = 'Vaya a la ficha de la Empresa activa y complete los datos necesarios.';
       RsMsg8  = 'El N.I.F. de la Empresa activa no es válido.';
       RsMsg9  = 'Es obligatorio indicar el nombre de la persona con quien relacionarse.';

       RsMsg10 = 'No se ha podido reuperar la ficha del %s %s.';
       RsMsg11 = 'Corrija el problema y reintente la operación.';

       RsTrimestre = '"<Definido por el usuario>","Primer trimestre","Segundo trimestre","Tercer trimestre","Cuarto trimestre"';
       RsMes = 'Mes';
       RsPeriodo = 'Periodo';

       ncrNroPresentacion349 = 'NroPresentacion349';

procedure DeclaracionModelo349;
begin
     CreateEditForm( TBoxRolForm, BoxRolForm, [] );
end;

procedure TBoxRolForm.InitializeForm;

var  DirectoryName : string;
     MesDeclaracion : SmallInt;

begin

     DsPaisFields := TPaisFields.Create( Self );
     DsClienteFields := TClienteFields.Create( Self );
     DsTiposIVAFields := TTiposIVAFields.Create( Self );
     DsProveedorFields := TProveedorFields.Create( Self );

     DataPeriodicidad.Value := 1; // Trimestral, por defecto
     DataPeriodo.Value := TrimestreLiquidacion;
     DataNroPresentacion.Value := StrToIntDef( Registro.ObtenValorString( ncrNroPresentacion349 ), 1 );

     DirectoryName := Copy( ApplicationPath, 1, 3 ) + '349';
     If   SysUtils.DirectoryExists( DirectoryName )
     then DataPath.Value := DirectoryName
     else DataPath.Value := ApplicationExportsPath;

end;

procedure TBoxRolForm.NroPresentacionCtrlPropertiesChange(Sender: TObject);
begin
     NombreFichero := 'MOD349-' + CodigoEmpresaActual + '-' + StrIntPadded( NroPresentacionCtrl.EditingValue, 4 ) + '.TXT';
     NombreFicheroLabel.Caption := NombreFichero;
end;

function TBoxRolForm.TrimestreLiquidacion : SmallInt;
begin
     Result := ( MonthOf( ApplicationContainer.TodayDate ) - 1 ) div 3;
     If   Result=0
     then begin
          Result := 4;
          FEjercicioAnterior := True;
          end;
end;

procedure TBoxRolForm.FechaInicialCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   not FFijandoPeriodo
     then DataPeriodo.Value := 0;
end;

procedure TBoxRolForm.PathCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     With PathCtrl do
       If   not ValueIsEmpty( DisplayValue )
       then If   not SysUtils.DirectoryExists( DisplayValue )
            then begin
                 Error := True;
                 ErrorText := JoinMessage( RsgMsg394, RsgMsg395 );
                 end;
end;

procedure TBoxRolForm.PeriodicidadCtrlPropertiesChange(Sender: TObject);
begin
     With PeriodoCtrl.Properties.Items do
       begin
       PeriodoCtrl.Enabled := PeriodicidadCtrl.ItemIndex<>2;
       case PeriodicidadCtrl.ItemIndex of
         0 : begin
             PeriodoLabel.Caption := RsMes;
             CommaText := '"<Definido por el usuario>",' + RsMeses;
             DataPeriodo.Value := MonthOf( ApplicationContainer.TodayDate );
             end;
         1 : begin
             PeriodoLabel.Caption := RsPeriodo;
             CommaText := RsTrimestre;
             DataPeriodo.Value := TrimestreLiquidacion;
             end;
         2 : ;
         end;
       end;
end;

procedure TBoxRolForm.PeriodoCtrlPropertiesChange(Sender: TObject);

var   EjercicioLiquidacion : SmallInt;

begin
     try
       FFijandoPeriodo := True;
       case PeriodicidadCtrl.ItemIndex of
         0 : If   PeriodoCtrl.ItemIndex<>0
             then begin
                  DataFechaInicial.Value := EncodeDate( ApplicationContainer.Ejercicio, DataPeriodo.Value, 1 );
                  DataFechaFinal.Value := EncodeDate( ApplicationContainer.Ejercicio, DataPeriodo.Value, DaysInAMonth( ApplicationContainer.Ejercicio, DataPeriodo.Value ) );
                  end;
         1 : case PeriodoCtrl.ItemIndex of
               0 : ;
               1 : begin
                   DataFechaInicial.Value := EncodeDate(  ApplicationContainer.Ejercicio, 1, 1 );
                   DataFechaFinal.Value := EncodeDate( ApplicationContainer.Ejercicio, 3, 31 );
                   end;
               2 : begin
                   DataFechaInicial.Value := EncodeDate( ApplicationContainer.Ejercicio, 4, 1 );
                   DataFechaFinal.Value := EncodeDate( ApplicationContainer.Ejercicio, 6, 30 );
                   end;
               3 : begin
                   DataFechaInicial.Value := EncodeDate( ApplicationContainer.Ejercicio, 7, 1 );
                   DataFechaFinal.Value := EncodeDate( ApplicationContainer.Ejercicio, 9, 30 );
                   end;
               4 : begin
                   EjercicioLiquidacion := ApplicationContainer.Ejercicio;
                   If   FEjercicioAnterior
                   then Dec( EjercicioLiquidacion );
                   DataFechaInicial.Value := EncodeDate( EjercicioLiquidacion, 10, 1 );
                   DataFechaFinal.Value := EncodeDate( EjercicioLiquidacion, 12, 31 );
                   FEjercicioAnterior := False;
                   end;
               end;

         2 : begin
             DataFechaInicial.Value := EncodeDate( ApplicationContainer.Ejercicio, 1, 1 );
             DataFechaFinal.Value := EncodeDate( ApplicationContainer.Ejercicio, 12, 31 );
             end;

         end;
       finally
         FFijandoPeriodo := False;
         end;
end;

procedure TBoxRolForm.FechaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     //.. ValidateYear( DisplayValue, ErrorText, Error );
end;

procedure TBoxRolForm.FormManagerOkButton;
begin
     Enabled := False;
     CreateProcessForm( ExecuteProcess, Caption );
end;

procedure TBoxRolForm.ExaminarButtonClick(Sender: TObject);
begin
     SelectDirectory( DataPath );
end;

procedure TBoxRolForm.ExecuteProcess;

var  TextoLinea,
     TextoPeriodo,
     NumeroIdentificativo : String;
     EjercicioDeclaracion : SmallInt;
     AcumuladoOperacionesIntracomunitarias : IAcumuladoOperacionesIntracomunitarias;
     Lineas : TStringList;

begin

     With ProcessFrame, ExportImport do
       begin

       CompruebaDisco( DataPath.Value, 0, True );

       try

          Lineas := TStringList.Create;

          If   ValueIsEmpty( DataModule00.DmEmpresaFields.Telefono.Value )
          then begin
               AddMsg( ntError, RsMsg6 );
               AddMsg( ntError, RsMsg7 );
               Abort;
               end;

          If   ValueIsEmpty( DataModule00.DmEmpresaFields.PersonaConQuienRelacionarse.Value )
          then begin
               AddMsg( ntError, RsMsg9 );
               AddMsg( ntError, RsMsg7 );
               Abort;
               end;

          If   ValueIsEmpty( DataModule00.DmEmpresaFields.NIF.Value )
          then begin
               AddMsg( ntError, RsMsg8 );
               AddMsg( ntError, RsMsg7 );
               Abort;
               end;

          OperacionesTable := SessionDataModule.CreateSQLTable( Self, 'OperacionesIntracomunitarias', DataModule10.GetSQL( 'OperacionesIntracomunitarias' ), tsServerSide );
          OperacionesFields := TOperacionesIntracomunitariasFields.Create( OperacionesTable );

          AcumuladoOperacionesIntracomunitarias := Factura.ObtenRelacionOperacionesIntracomunitarias( OperacionesTable.TableName, DataPeriodicidad.Value, DataFechaInicial.Value, DataFechaFinal.Value );

          try

            With OperacionesTable do
              begin

              EjercicioDeclaracion := YearOf( DataFechaInicial.Value );  // En ejercicios partidos utilizar ApplicationContainer.Ejercicio da un resultado erróneo

              var MesInicial := MonthOf( DataFechaInicial.Value );
              case DataPeriodicidad.Value of
                0 : TextoPeriodo := StrIntPadded( MesInicial, 2 );
                1 : TextoPeriodo := IntToStr( Trunc( MesInicial / 3 ) + 1 ) + 'T';
                2 : TextoPeriodo := '0A';
                end;

              NumeroIdentificativo := '349' + StrIntPadded( DataNroPresentacion.Value, 10 );

              First;
              While not Eof and not Canceled do
                begin

                AddRecordMsg( OperacionesFields.NIF.Value );

                TextoLinea := '2349' +
                              IntToStr( EjercicioDeclaracion ) +
                              LeftPad( DataModule00.DmEmpresaFields.NIF.Value, 9 ) +
                              StrConst( 58 ) +
                              RightPad( OperacionesFields.NIF.Value, 17 ) +
                              TextoAjustado( StrToUNIFI( OperacionesFields.NombreOperador.Value ), 40 ) +  // Apellidos y Nombre, Razón social o denominacion del operador intracomunitario
                              Copy( OperacionesFields.ClaveOperacion.Value, 1, 1 );                        // Clave operación

                // Tipos de registro : 0 = Adquisiciones y rectificaciones en el periodo y 1 = Rectificaciones de facturas de periodos anteriorres

                If   OperacionesFields.TipoRegistro.Value=triNormal
                then StrAdd( TextoLinea,
                             FormateaValorNumerico( OperacionesFields.BaseImponible.Value, 13, DecimalesMoneda, tfAEAT ) +
                             StrConst( 354 ) )
                else StrAdd( TextoLinea,
                             StrConst( 13 ) +
                             IntToStr( OperacionesFields.EjercicioRectificacion.Value ) +
                             LeftPad( IntToStr( MonthOf( OperacionesFields.FechaRectificacion.Value ) ), 2, '0' ) +
                             FormateaValorNumerico( OperacionesFields.BaseImponibleRectificada.Value, 13, DecimalesMoneda, tfAEAT ) +
                             FormateaValorNumerico( OperacionesFields.BaseImponibleAnterior.Value, 13, DecimalesMoneda, tfAEAT ) +
                             StrConst( 322 ) );

                Lineas.Add( TextoLinea );

                Next;
                end;

              end;

            // Inserto la cabecera en la primera posición

            If   not Canceled
            then begin

                 Lineas.Insert( 0,
                                '1349' +
                                IntToStr( EjercicioDeclaracion )  +
                                LeftPad( DataModule00.DmEmpresaFields.NIF.Value, 9 ) +
                                TextoAjustado( DataModule00.DmEmpresaFields.Nombre.Value, 40 ) +
                                'T' +                             // Por defecto, telematica
                                RightPad( Copy( DataModule00.DmEmpresaFields.Telefono.Value, 1, 9 ), 9, '0' ) +   // Telefono de contacto
                                RightPad( DataModule00.DmEmpresaFields.PersonaConQuienRelacionarse.Value, 40 ) +  // Persona con quien relacionarse
                                NumeroIdentificativo +            // Numero identificativo de la declaración
                                '  ' +                            // Declaración comlementaria o sustitutiva
                                StrConst( 13, '0' ) +             // Número identificativo de la declaración anterior
                                TextoPeriodo +                    // Periodo
                                StrIntPadded( AcumuladoOperacionesIntracomunitarias.NroRegistrosFacturacion, 9 ) +
                                FormateaValorNumerico( AcumuladoOperacionesIntracomunitarias.TotalBaseImponible, 15, DecimalesMoneda, tfAEAT ) +                 // Importe de las operaciones intracomunitarias
                                StrIntPadded( AcumuladoOperacionesIntracomunitarias.NroRegistrosRectificaciones, 9 ) +                                           // Número total de operadores intracomunitarios con rectificaciones
                                FormateaValorNumerico( AcumuladoOperacionesIntracomunitarias.TotalBaseImponibleRectificaciones, 15, DecimalesMoneda, tfAEAT ) +  // Importe de las rectificaciones
                                ' ' +                                                                                                                            // Indicador de cambio de periodicidad en la obligación de declarar
                                StrConst( 204 ) +
                                StrConst( 9 ) +                   // NIF del representante legal
                                StrConst( 88 ) +
                                StrConst( 13 ) );                 // Sello electrónico (reservado para Hacienda)

                 // Creando el fichero de exportación de datos

                 EraseFile( AddPathDelim( DataPath.Value ) + NombreFichero, False );

                 AssignFile( Fichero, AddPathDelim( DataPath.Value ) + NombreFichero );
                 Rewrite( Fichero );
                 IoCheck( IoResult );

                 With Lineas do
                   For var I := 0 to Count - 1 do
                     WriteLn( Fichero, Strings[ I ] );

                 AddMsg( ntLinkInformation, Format( RsMsg2, [ AddPathDelim( DataPath.Value ) + NombreFichero ] ) );

                 end;

          finally
            CloseFile( Fichero );
            OperacionesTable.Free;
            Lineas.Free;
            end;

          Registro.GuardaValor( ncrNroPresentacion349, IntToStr( DataNroPresentacion.Value + 1 ) );

       except
         AddMsg( ntError, RsMsg3 );
         end;

       end;

end;

end.
