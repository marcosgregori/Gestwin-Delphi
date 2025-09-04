unit b_rop;

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
  cxGraphics, cxLookAndFeels, cxLabel, cxImage, cxCheckBox, dxGDIPlusClasses,
  cxSpinEdit, dxUIAClasses;


type
    TBoxRopForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    ImporteMinimoCtrl: TcxDBCurrencyEdit;
    AsientoTable: TnxeTable;
    ApunteTable: TnxeTable;
    PathCtrl: TcxDBTextEdit;
    examinarButton: TgBitBtn;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    gxRangeBox1: TgxRangeBox;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    Data: TgxMemData;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataSource: TDataSource;
    DataPath: TWideStringField;
    DataImporteMinimo: TBCDField;
    ApunteAuxTable: TnxeTable;
    Label3: TcxLabel;
    Label4: TcxLabel;
    ficheroLabel: TcxLabel;
    NombreFicheroLabel: TcxLabel;
    Label1: TcxLabel;
    TituloLabel: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    Image1: TcxImage;
    AgruparPorNIFCtrl: TcxDBCheckBox;
    DataAgruparPorNIF: TBooleanField;
    cxLabel2: TcxLabel;
    ApunteCCTable: TnxeTable;
    cxGroupBox2: TcxGroupBox;
    Label2: TcxLabel;
    NroPresentacionCtrl: TcxDBSpinEdit;
    DataNroPresentacion: TSmallintField;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure examinarButtonClick(Sender: TObject);
    procedure PathCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure NroPresentacionCtrlPropertiesChange(Sender: TObject);
    private

      EjercicioDeclaracion : SmallInt;

    public

      AsientoFields : TAsientoFields;
      ApunteFields,
      ApunteAuxFields,
      ApunteCCFields : TApunteFields;

      DsClienteFields : TClienteFields;
      DsTiposIVAFields : TTiposIVAFields;
      DsProveedorFields : TProveedorFields;
      DsPaisFields : TPaisFields;

      DeclaracionOperacionesTable : TnxeTable;
      DeclaracionOperacionesFields : TDeclaracionOperacionesFields;

      NombreFichero : String;
      Fichero : Text;
      // CodigoOrigen : String;

      procedure SeleccionaRegistros;
      procedure ExecuteProcess;
    end;

var  BoxRopForm: TBoxRopForm = nil;

procedure DeclaracionModelo347;


implementation

uses   Files,
       FileCtrl,
       LibUtils,

       AppManager,
       DateUtils,

       EnterpriseDataAccess,
       SessionDataAccess,

       Gdm00Dm,
       Gdm10Dm,

       dmi_iva,
       dmi_ast,

       dm_reg,
       dm_ast,
       dm_cli,
       dm_pro,
       dm_iex,
       dm_sub,
       dm_prv,
       dm_ban,
       dm_pai,
       dm_iva,
       dm_fac,

       b_pro,
       b_msg,
       b_dir,
       f_prg;

{$R *.dfm}

resourceString
       RsMsg1  = 'Generando los registros de la presentación.';
       RsMsg2  = 'Se ha creado el fichero [URL=%0:s]%0:s[/URL].';
       RsMsg3  = 'Se ha interrumpido el proceso.' + #13 + 'Los datos contenidos en el fichero no deben ser considerados válidos.' + #13 + 'Solucione el problema y reintente el proceso.';
       RsMsg4  = 'Ha solicitado una declaración agrupada por N.I.F. y la subcuenta %s no tiene asignada una ficha o falta el N.I.F. en la misma.';
       // RsMsg5  = 'El proceso se ha realizado satisfactoriamente.';
       RsMsg6  = 'Es obligatorio indicar el número de teléfono de la empresa.';
       RsMsg7  = 'Vaya a la ficha de la Empresa activa y complete el contenido del campo indicado.';
       RsMsg8  = 'No ha indicado el N.I.F. de la empresa activa.';
       RsMsg9  = 'Es obligatorio indicar el nombre de la persona con quien relacionarse.';

       ncrNroPresentacion347 = 'NroPresentacion347';

const regAcreedor = 0;
      regDeudor = 1;

procedure DeclaracionModelo347;
begin
     CreateEditForm( TBoxRopForm, BoxRopForm, [] );
end;

procedure TBoxRopForm.InitializeForm;

var  DirectoryName : string;

begin
     AsientoFields := TAsientoFields.Create( AsientoTable );
     ApunteFields := TApunteFields.Create( ApunteTable );
     ApunteAuxFields := TApunteFields.Create( ApunteAuxTable );
     ApunteCCFields := TApunteFields.Create( ApunteCCTable );

     DsPaisFields := TPaisFields.Create( Self );
     DsClienteFields := TClienteFields.Create( Self );
     DsTiposIVAFields := TTiposIVAFields.Create( Self );
     DsProveedorFields := TProveedorFields.Create( Self );

     SetEditControlDecimals( ImporteMinimoCtrl );

     DataFechaInicial.Value := ApplicationContainer.FirstDayOfYearDate;
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;
     DataImporteMinimo.Value := 3005.06;
     DataNroPresentacion.Value := StrToIntDef( Registro.ObtenValorString( ncrNroPresentacion347 ), 1 );

     DirectoryName := Copy( ApplicationPath, 1, 3 ) + '347';
     If   DirectoryExists( DirectoryName )
     then DataPath.Value := DirectoryName
     else DataPath.Value := ApplicationExportsPath;

end;

procedure TBoxRopForm.NroPresentacionCtrlPropertiesChange(Sender: TObject);
begin
     NombreFichero := 'MOD347-' + CodigoEmpresaActual + '-' + StrIntPadded( NroPresentacionCtrl.EditingValue, 4 ) + '.TXT';
     NombreFicheroLabel.Caption := NombreFichero;
end;

procedure TBoxRopForm.PathCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     With PathCtrl do
       If   not ValueIsEmpty( DisplayValue )
       then If   not DirectoryExists( DisplayValue )
            then begin
                 Error := True;
                 ErrorText := JoinMessage( RsgMsg394, RsgMsg395 );
                 end;
end;

procedure TBoxRopForm.SeleccionaRegistros;

var   PropietarioConFicha : Boolean;
      NroTrimestre,
      TipoRegistro : SmallInt;
      Importe : Decimal;
      CodigoAgrupacion,
      CodigoOrigen : String;
      RegistroEncontrado : Boolean;

procedure DescuentaSuplidos;
begin
     // Descontando los suplidos y similares

     With ApunteAuxTable do
       begin
       With AsientoFields do
         SetRange( [ Ejercicio.Value, NroAsiento.Value, 2 ], [ Ejercicio.Value, NroAsiento.Value, MaxSmallint ] );
       First;
       While not Eof do
         begin
         Tasa.TipoIVA( ApunteAuxFields.Fecha.Value, ApunteAuxFields.Tipo.Value, DsTiposIVAFields );
         If   ( ApunteAuxFields.TipoApunte.Value=tapManual ) and
              ( DsTiposIVAFields.SobreTotal.Value ) // Suplido
         then DecAdd( Importe, -ApunteAuxFields.ImporteTotal.Value );
         Next;
         end;
       end;
end;

function ObtenCodigoOrigen( CodigoPais      : String;
                            CodigoProvincia : String ) : String;
begin
     If   Pais.Obten( CodigoPais, DsPaisFields )  // Hay que leer siempre el pais porque se utiliza el registro en la selección de registros
     then begin
          If   CodigoPais=CodigoEspaña
          then Result := LeftPad( CodigoProvincia, 2 ) + '  '
          else Result := '99' + DsPaisFields.CodigoISO2.Value;
          end
     else Result := '99  ';
end;

procedure ObtenImporteEfectivoCC( ApunteFields : TApunteFields );

var  Importe : Decimal;

begin
     If   ApunteCCTable.FindKey( [ ApunteFields.Ejercicio.Value, ApunteFields.NroAsiento.Value, 1 ] )
     then If   Copy( ApunteCCFields.Subcuenta.Value, 1, 3 )='570'
          then begin
               If   ApunteCCFields.Debe.Value<>0.0
               then Importe := ApunteCCFields.Debe.Value
               else Importe := -ApunteCCFields.Haber.Value;
               DeclaracionOperacionesFields.ImporteEfectivoCriterioCaja.Value := DeclaracionOperacionesFields.ImporteEfectivoCriterioCaja.Value + Importe;
               end;
end;

begin

     DeclaracionOperacionesTable.IndexFieldNames := 'TipoRegistro;CodigoAgrupacion';

     With AsientoTable do
       begin

       // Primero los deudores (clientes)

       TipoRegistro := regDeudor;

       SetRange( [ taFraEmitida, DataFechaInicial.Value ], [ taFraEmitida, DataFechaFinal.Value ] );

       ApplicationContainer.StartProgression( RecordCount );

       First;
       While not Eof and not ProcessFrame.Canceled do
         begin

         ApplicationContainer.ShowProgression;

         NroTrimestre := ( ( MonthOf( AsientoFields.Fecha.Value ) - 1 ) div 3 ) + 1;

         If   ApunteTable.FindKey( [ AsientoFields.Ejercicio.Value, AsientoFields.NroAsiento.Value, 1 ] )
         then begin

              If   Factura.ObtenCodigoAgrupacionDeudor( ApunteFields.Subcuenta.Value, DataAgruparPorNIF.Value, PropietarioConFicha, CodigoAgrupacion, DsClienteFields )
              then begin

                   If   DeclaracionOperacionesTable.FindKey( [ TipoRegistro, CodigoAgrupacion ] )
                   then begin
                        DeclaracionOperacionesTable.Edit;
                        Importe := GetSignedValue( ApunteFields.Debe, ApunteFields.Haber );
                        DescuentaSuplidos;
                        DeclaracionOperacionesFields.ImporteTotalAnual.Value := DeclaracionOperacionesFields.ImporteTotalAnual.Value + Importe;
                        DeclaracionOperacionesFields.ImporteTrimestre[ NroTrimestre ].Value := DeclaracionOperacionesFields.ImporteTrimestre[ NroTrimestre ].Value + Importe;
                        DeclaracionOperacionesTable.Post;
                        end
                   else begin

                        //* 17.03.2000 Excluidos del informe los clientes con retención

                        If   PropietarioConFicha
                        then CodigoOrigen := ObtenCodigoOrigen( DsClienteFields.CodigoPais.Value, DsClienteFields.CodigoProvincia.Value )  // Aqui se obtiene el registro del pais
                        else CodigoOrigen := '';

                        If   not PropietarioConFicha  or   // No tiene ficha asociada
                             ( ( DsClienteFields.CodigoPais.Value=CodigoEspaña ) and ( DsClienteFields.Factura_TipoRet.Value=0 ) )
                        then begin

                             ProcessFrame.AddRecordMsg( ApunteFields.Subcuenta.Value );

                             Importe := GetSignedValue( ApunteFields.Debe, ApunteFields.Haber );
                             DescuentaSuplidos;

                             If   Importe<>0.0
                             then begin

                                  DeclaracionOperacionesTable.Append;

                                  DeclaracionOperacionesFields.CodigoAgrupacion.Value := CodigoAgrupacion;
                                  DeclaracionOperacionesFields.Propietario.Value := ApunteFields.Subcuenta.Value;
                                  DeclaracionOperacionesFields.Nombre.Value := Cuenta.Descripcion( ApunteFields.Subcuenta.Value, False, False );
                                  DeclaracionOperacionesFields.OrigenOperacion.Value := 0; // Forma parte del índice y no puede ser nulo

                                  If   PropietarioConFicha
                                  then begin
                                       DeclaracionOperacionesFields.CriterioCaja.Value := DataModule00.DmEmpresaFields.RegimenEspecialCriterioCaja.Value and ( DsClienteFields.Factura_ModeloIVA.Value=micSinRE );
                                       DeclaracionOperacionesFields.CodigoOrigen.Value := CodigoOrigen;
                                       If   DsClienteFields.CodigoPais.Value=CodigoEspaña
                                       then DeclaracionOperacionesFields.NIF.Value := DsClienteFields.NIF.Value
                                       else begin
                                            DeclaracionOperacionesFields.OrigenOperacion.Value := 1;
                                            DeclaracionOperacionesFields.NIF.Value := DsPaisFields.CodigoISO2.Value + DsClienteFields.NIF.Value;
                                            end;
                                       end
                                  else DeclaracionOperacionesFields.CriterioCaja.Value := DataModule00.DmEmpresaFields.RegimenEspecialCriterioCaja.Value;

                                  DeclaracionOperacionesFields.TipoRegistro.Value := TipoRegistro;  // Es un cliente
                                  DeclaracionOperacionesFields.ImporteTotalAnual.Value := Importe;
                                  DeclaracionOperacionesFields.ImporteTrimestre[ NroTrimestre ].Value := Importe;
                                  DeclaracionOperacionesTable.Post;
                                  end;

                             end;

                        end;
                   end;
              end;

         Next;
         end;

       // Y luego, los acreedores (proveedores)

       If   ProcessFrame.Canceled
       then Abort;

       TipoRegistro := regAcreedor;
 
       SetRange( [ taFraRecibida, DataFechaInicial.Value ], [ taFraRecibida, DataFechaFinal.Value ] );

       First;
       While not Eof and not ProcessFrame.Canceled do
         begin

         ApplicationContainer.ShowProgression;

         NroTrimestre := ( ( MonthOf( AsientoFields.Fecha.Value ) - 1 ) div 3 ) + 1;

         If   ApunteTable.FindKey( [ AsientoFields.Ejercicio.Value, AsientoFields.NroAsiento.Value, 1 ] )
         then begin

              If   Factura.ObtenCodigoAgrupacionAcreedor( AsientoFields.Origen.Value,
                                                          ApunteFields.Subcuenta.Value,
                                                          DataAgruparPorNIF.Value,
                                                          PropietarioConFicha,
                                                          CodigoAgrupacion,
                                                          DsProveedorFields )
              then begin

                   If   DeclaracionOperacionesTable.FindKey( [ TipoRegistro, CodigoAgrupacion ] )
                   then begin
                        DeclaracionOperacionesTable.Edit;
                        Importe := GetSignedValue( ApunteFields.Debe, ApunteFields.Haber, True );
                        DescuentaSuplidos;
                        DeclaracionOperacionesFields.ImporteTotalAnual.Value := DeclaracionOperacionesFields.ImporteTotalAnual.Value + Importe;
                        DeclaracionOperacionesFields.ImporteTrimestre[ NroTrimestre ].Value := DeclaracionOperacionesFields.ImporteTrimestre[ NroTrimestre ].Value + Importe;
                        DeclaracionOperacionesTable.Post;
                        end
                   else begin

                        //* 17.03.2000 Excluidos del informe los proveedores con retención

                        If   PropietarioConFicha
                        then CodigoOrigen := ObtenCodigoOrigen( DsProveedorFields.CodigoPais.Value, DsProveedorFields.CodigoProvincia.Value )
                        else CodigoOrigen := '';

                        If   not PropietarioConFicha or   // No tiene ficha asociada
                             ( ( DsProveedorFields.CodigoPais.Value=CodigoEspaña ) and ( DsProveedorFields.Factura_TipoRet.Value=0 ) )
                        then begin

                             ProcessFrame.AddRecordMsg( ApunteFields.Subcuenta.Value );

                             Importe := GetSignedValue( ApunteFields.Debe, ApunteFields.Haber, True );
                             DescuentaSuplidos;

                             If   Importe<>0.0
                             then begin
                                DeclaracionOperacionesTable.Append;

                                DeclaracionOperacionesFields.CodigoAgrupacion.Value := CodigoAgrupacion;
                                DeclaracionOperacionesFields.Propietario.Value := ApunteFields.Subcuenta.Value;
                                DeclaracionOperacionesFields.Nombre.Value := Cuenta.Descripcion( ApunteFields.Subcuenta.Value, False, False );

                                If   PropietarioConFicha
                                then begin
                                     DeclaracionOperacionesFields.CriterioCaja.Value := DataModule00.DmEmpresaFields.RegimenEspecialCriterioCaja.Value and ( DsProveedorFields.Factura_ModeloIVA.Value=mipNormal );
                                     DeclaracionOperacionesFields.OrigenOperacion.Value := AsientoFields.Origen.Value;
                                     DeclaracionOperacionesFields.CriterioCaja.Value := DeclaracionOperacionesFields.CriterioCaja.Value or DsProveedorFields.Factura_RegimenEspecialCC.Value;
                                     DeclaracionOperacionesFields.CodigoOrigen.Value := CodigoOrigen;
                                     If   DsProveedorFields.CodigoPais.Value=CodigoEspaña
                                     then DeclaracionOperacionesFields.NIF.Value := DsProveedorFields.NIF.Value
                                     else DeclaracionOperacionesFields.NIF.Value := DsPaisFields.CodigoISO2.Value + DsProveedorFields.NIF.Value;
                                     end
                                else begin
                                     DeclaracionOperacionesFields.CriterioCaja.Value := DataModule00.DmEmpresaFields.RegimenEspecialCriterioCaja.Value;
                                     DeclaracionOperacionesFields.OrigenOperacion.Value := AsientoFields.Origen.Value;
                                     end;

                                DeclaracionOperacionesFields.TipoRegistro.Value := TipoRegistro;  // Es un proveedor
                                DeclaracionOperacionesFields.ImporteTotalAnual.Value := Importe;
                                DeclaracionOperacionesFields.ImporteTrimestre[ NroTrimestre ].Value := Importe;
                                DeclaracionOperacionesTable.Post;
                                end;

                             end;

                        end;
                   end;
              end;

         Next;
         end;

       end;

     // Ahora obtengo los importes devengados.
     // Como los apuntes de tipo tapTraspasoIVA solo se crean si el usuario está acogido al criterio de caja o se realiza el pago de un proveedor
     // en la misma situación, basta con comprobar los registros existentes

     EjercicioDeclaracion := YearOf( DataFechaInicial.Value );

     With ApunteTable do
       begin
       IndexFieldNames := 'TipoApunte;Fecha';
       SetRange( [ tapTraspasoIVA, DataFechaInicial.Value ], [ tapTraspasoIVA, DataFechaFinal.Value ] );
       First;
       While not Eof do
         begin

         If   Copy( ApunteFields.Contrapartida.Value, 1, 4 )=CtaIVARepercutidoDevengado  // Es un cliente / deudor
         then begin
              TipoRegistro := regDeudor;
			           RegistroEncontrado := Factura.ObtenCodigoAgrupacionDeudor( ApunteFields.Propietario.Value, DataAgruparPorNIF.Value, PropietarioConFicha, CodigoAgrupacion, DsClienteFields )
			           end
         else begin
		 	          TipoRegistro := regAcreedor;
		            RegistroEncontrado := Factura.ObtenCodigoAgrupacionAcreedor( AsientoFields.Origen.Value, ApunteFields.Propietario.Value, DataAgruparPorNIF.Value, PropietarioConFicha, CodigoAgrupacion, DsProveedorFields );
              end;

         If   RegistroEncontrado
         then If   DeclaracionOperacionesTable.FindKey( [ TipoRegistro, CodigoAgrupacion ] )
              then begin
                   DeclaracionOperacionesTable.Edit;
                   If   TipoRegistro=regDeudor
                   then ObtenImporteEfectivoCC( ApunteFields );
                   DeclaracionOperacionesFields.ImporteTotalCriterioCaja.Value := DeclaracionOperacionesFields.ImporteTotalCriterioCaja.Value + ApunteFields.ImporteTotal.Value;
                   DeclaracionOperacionesTable.Post;
                   end
              else begin

                   DeclaracionOperacionesTable.Append;

                   DeclaracionOperacionesFields.CodigoAgrupacion.Value := CodigoAgrupacion;
                   DeclaracionOperacionesFields.Propietario.Value := ApunteFields.Propietario.Value;
                   DeclaracionOperacionesFields.Nombre.Value := Cuenta.Descripcion( ApunteFields.Propietario.Value, False, False );
                   DeclaracionOperacionesFields.CriterioCaja.Value := True;

                   If   TipoRegistro=regDeudor
                   then begin

                        If   Cliente.ObtenPorSubcuenta( ApunteFields.Propietario.Value, DsClienteFields )
                        then begin
                             DeclaracionOperacionesFields.CodigoOrigen.Value := ObtenCodigoOrigen( DsClienteFields.CodigoPais.Value, DsClienteFields.CodigoProvincia.Value );
                             DeclaracionOperacionesFields.NIF.Value := DsClienteFields.NIF.Value;
                             end;

                        ObtenImporteEfectivoCC( ApunteFields );                        
                        end
                   else If   Proveedor.ObtenPorSubcuenta( ApunteFields.Propietario.Value, DsProveedorFields )
                        then begin
                             DeclaracionOperacionesFields.CodigoOrigen.Value := ObtenCodigoOrigen( DsProveedorFields.CodigoPais.Value, DsProveedorFields.CodigoProvincia.Value );
                             DeclaracionOperacionesFields.NIF.Value := DsProveedorFields.NIF.Value;
                             end;                       

                   DeclaracionOperacionesFields.TipoRegistro.Value := TipoRegistro;
                   DeclaracionOperacionesFields.ImporteTotalCriterioCaja.Value := ApunteFields.ImporteTotal.Value;

                   DeclaracionOperacionesTable.Post;

                   end;

         Next;
         end;

       end;

     ApplicationContainer.EndProgression;

end;

procedure TBoxRopForm.FormManagerOkButton;
begin
     Enabled := False;
     CreateProcessForm( ExecuteProcess, Caption );
end;

procedure TBoxRopForm.ExaminarButtonClick(Sender: TObject);
begin
     SelectDirectory( DataPath );
end;

procedure TBoxRopForm.ExecuteProcess;

var  NroRegistros : Integer;
     ImporteTotal,
     ImporteEfectivoDeclarado,
     ImporteOperacionesCC,
     ImporteTotalAnual : Decimal;
     TextoEjercicioEfectivo,
     NIFDeclarado,
     NIFOperadorIntracomunitario,
     NumeroIdentificativo : String;
     OperacionInversionSujetoPasivo,
     OperacionRegimenCriterioCaja : Char;
     ImporteOperacionesTrimestre : Array[ 1..4 ] of Decimal;
     EjercicioEfectivo,
     Index : SmallInt;
     TextoEjercicioDeclaracion : String;

procedure GrabaRegistro;
begin
     If   DeclaracionOperacionesFields.TipoRegistro.Value=regDeudor  // Es un cliente
     then begin

          //* 13.03.2009  Obteniendo los cobros en efectivo superiores a 6000€

          If   OperacionRegimenCriterioCaja='X'
          then ImporteEfectivoDeclarado := DeclaracionOperacionesFields.ImporteEfectivoCriterioCaja.Value
          else ImporteEfectivoDeclarado := Asiento.ImporteCobrosEfectivo( DeclaracionOperacionesFields.Propietario.Value,
                                                                          DataFechaInicial.Value,
                                                                          DataFechaFinal.Value,
                                                                          False ) - DeclaracionOperacionesFields.ImporteEfectivoCriterioCaja.Value;

          // Ejercicio en el que se han declarado las operaciones que dan origen al cobro en metálico por importe superior a 6000€
          // De momento, y hasta que se aclare su uso, supongo que el ejercicio es el mismo que el de las operaciones

          EjercicioEfectivo := YearOf( DataFechaFinal.Value );

          If   ( OperacionRegimenCriterioCaja='X' ) and
               not DeclaracionOperacionesFields.CriterioCaja.Value
               and ( DeclaracionOperacionesFields.ImporteTotalCriterioCaja.Value<>0.0 )
          then Dec( EjercicioEfectivo );

          If   ImporteEfectivoDeclarado=0.0
          then TextoEjercicioEfectivo := '0000'
          else TextoEjercicioEfectivo := StrIntPadded( EjercicioEfectivo, 4 );

          WriteLn( Fichero, '2347' +
                   TextoEjercicioDeclaracion +
                   LeftPad( DataModule00.DmEmpresaFields.NIF.Value, 9 ) +
                   LeftPad( NIFDeclarado, 9 ) +  // NIF declarado
                   StrConst( 9 ) +  // NIF del representante legal
                   TextoAjustado( DeclaracionOperacionesFields.Nombre.Value, 40 ) +

                   'D' +
                   RightPad( DeclaracionOperacionesFields.CodigoOrigen.Value, 4 ) +
                   ' ' +
                   'B' +

                   FormateaValorNumerico( ImporteTotalAnual, 16, DecimalesMoneda, tfAEATConSigno ) + // Importe anual total de las operaciones

                   ' ' +  // Operación de seguro
                   ' ' +  // Arrendamiento local negocio

                   FormateaValorNumerico( ImporteEfectivoDeclarado, 15, DecimalesMoneda, tfAEAT ) +  // Importe percibido en metálico

                   ' ' + StrConst( 15, '0' ) +  // Importe percibido por transmisiones de inmuebles sujetas a IVA (con signo al principio)

                   TextoEjercicioEfectivo +

                   FormateaValorNumerico( ImporteOperacionesTrimestre[ 1 ], 16, DecimalesMoneda, tfAEATConSigno ) +  // Importe de las operaciones primer trimestre
                   ' ' + StrConst( 15, '0' ) +  // Importe percibido por transmisiones de inmuebles sujetas a IVA primer trimestre

                   FormateaValorNumerico( ImporteOperacionesTrimestre[ 2 ], 16, DecimalesMoneda, tfAEATConSigno ) +  // Importe de las operaciones segundo trimestre
                   ' ' + StrConst( 15, '0' ) +  // Importe percibido por transmisiones de inmuebles sujetas a IVA segundo trimestre

                   FormateaValorNumerico( ImporteOperacionesTrimestre[ 3 ], 16, DecimalesMoneda, tfAEATConSigno ) +  // Importe de las operaciones tercer trimestre
                   ' ' + StrConst( 15, '0' ) +  // Importe percibido por transmisiones de inmuebles sujetas a IVA tercer trimestre

                   FormateaValorNumerico( ImporteOperacionesTrimestre[ 4 ], 16, DecimalesMoneda, tfAEATConSigno ) +  // Importe de las operaciones cuarto trimestre
                   ' ' + StrConst( 15, '0' ) +  // Importe percibido por transmisiones de inmuebles sujetas a IVA cuarto trimestre

                   RightPad( NIFOperadorIntracomunitario, 17 ) +   // NIF Operador intracomunitario
                   OperacionRegimenCriterioCaja +                  // Operaciones régimen especial criterio de caja IVA
                   ' ' +                                           // Operación con inversión del sujeto pasivo
                   ' ' +                                           // Operación con bienes vinculados o destinados a vincularse al régimen de depósito distinto del aduanero
                   FormateaValorNumerico( ImporteOperacionesCC, 16, DecimalesMoneda, tfAEATConSigno ) +
                                                                   // Importe anual de las operaciones devengadas conforme al criterio de caja del IVA
                   StrConst( 201 ) );

          end
     else begin

          // Inversión del sujeto pasivo

          If   DeclaracionOperacionesFields.OrigenOperacion.Value=2
          then OperacionInversionSujetoPasivo := 'X'
          else OperacionInversionSujetoPasivo := ' ';

          WriteLn( Fichero, '2347' +
                   TextoEjercicioDeclaracion +
                   LeftPad( DataModule00.DmEmpresaFields.NIF.Value, 9 ) +
                   LeftPad( DeclaracionOperacionesFields.NIF.Value, 9 ) +  // NIF declarado
                   StrConst( 9 ) +  // NIF del representante legal
                   TextoAjustado( DeclaracionOperacionesFields.Nombre.Value, 40 ) +
                   'D' +
                   RightPad( DeclaracionOperacionesFields.CodigoOrigen.Value, 4 ) +
                   ' ' +
                   'A' +

                   FormateaValorNumerico( ImporteTotalAnual, 16, DecimalesMoneda, tfAEATConSigno ) +
                   ' ' +
                   ' ' +
                   StrConst( 15, '0' ) +
                   ' ' + StrConst( 15, '0' ) +
                   StrConst( 4, '0' ) +

                   FormateaValorNumerico( ImporteOperacionesTrimestre[ 1 ], 16, DecimalesMoneda, tfAEATConSigno ) +  // Importe de las operaciones primer trimestre
                   ' ' + StrConst( 15, '0' ) +

                   FormateaValorNumerico( ImporteOperacionesTrimestre[ 2 ], 16, DecimalesMoneda, tfAEATConSigno ) +  // Importe de las operaciones segundo trimestre
                   ' ' + StrConst( 15, '0' ) +

                   FormateaValorNumerico( ImporteOperacionesTrimestre[ 3 ], 16, DecimalesMoneda, tfAEATConSigno ) +  // Importe de las operaciones tercer trimestre
                   ' ' + StrConst( 15, '0' ) +

                   FormateaValorNumerico( ImporteOperacionesTrimestre[ 4 ], 16, DecimalesMoneda, tfAEATConSigno ) +  // Importe de las operaciones cuarto trimestre
                   ' ' + StrConst( 15, '0' ) +

                   RightPad( NIFOperadorIntracomunitario, 17 ) +   // NIF Operador intracomunitario
                   OperacionRegimenCriterioCaja +                  // Operaciones régimen especial criterio de caja IVA
                   OperacionInversionSujetoPasivo +                // Operación con inversión del sujeto pasivo
                   ' ' +                                           // Operación con bienes vinculados o destinados a vincularse al régimen de depósito distinto del aduanero
                   FormateaValorNumerico( ImporteOperacionesCC, 16, DecimalesMoneda, tfAEATConSigno ) +
                                                                   // Importe anual de las operaciones devengadas conforme al criterio de caja del IVA
                   StrConst( 201 ) );

          end;
end;

procedure ConfiguraRegistroCC;

var  Index : SmallInt;

begin
     OperacionRegimenCriterioCaja := 'X';
     ImporteTotalAnual := 0.0;
     ImporteOperacionesCC := DeclaracionOperacionesFields.ImporteTotalCriterioCaja.Value;
     For Index := 1 to 4 do
       ImporteOperacionesTrimestre[ Index ] := 0.0;
end;

begin

     With ProcessFrame, ExportImport do
       begin

       CompruebaDisco( DataPath.Value, 0, True );

       try

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

          AddMsg( ntInformation, RsMsg1 );

          DeclaracionOperacionesTable := SessionDataModule.CreateSQLTable( Self, 'DeclaracionOperaciones', DataModule10.GetSQL( 'DeclaracionOperaciones' ) );
          DeclaracionOperacionesFields := TDeclaracionOperacionesFields.Create( DeclaracionOperacionesTable );

          EraseFile( AddPathDelim( DataPath.Value ) +  NombreFichero, False );

          AssignFile( Fichero, AddPathDelim( DataPath.Value ) + NombreFichero );
          Rewrite( Fichero );

          IoCheck( IoResult );
              
          TextoEjercicioDeclaracion := IntToStr( YearOf( DataFechaInicial.Value ) );

          try

            With DeclaracionOperacionesTable do
              begin

              SeleccionaRegistros;

              //* 03.03.2009  Ordeno la salida por NIF para que el usuario pueda detectar fácilmente los duplicados con el programa de Hacienda somos todos

              DeclaracionOperacionesTable.IndexFieldNames := 'TipoRegistro;NIF';

              // Necesito el número total de registros

              NroRegistros := 0;
              ImporteTotal := 0.0;

              //* 20.02.2013 Modificado para que se consideren también los abonos que superan el límite de declaración
              //*
              First;
              While not Eof and not Canceled do
                begin
                If   ( Abs( DeclaracionOperacionesFields.ImporteTotalAnual.Value )>=DataImporteMinimo.Value ) or
                     ( Abs( DeclaracionOperacionesFields.ImporteTotalCriterioCaja.Value )<>0.0 )
                then begin
                     If   not DeclaracionOperacionesFields.CriterioCaja.Value and
                          ( DeclaracionOperacionesFields.ImporteTotalCriterioCaja.Value<>0.0 )
                     then Inc( NroRegistros );
                     Inc( NroRegistros );
                     DecAdd( ImporteTotal, DeclaracionOperacionesFields.ImporteTotalAnual.Value );
                     end;
                Next;
                end;

              If   Canceled
              then Abort;

              NumeroIdentificativo := '347' + StrIntPadded( DataNroPresentacion.Value, 10 );

              WriteLn( Fichero, '1347' +
                                TextoEjercicioDeclaracion +
                                LeftPad( DataModule00.DmEmpresaFields.NIF.Value, 9 ) +
                                TextoAjustado( DataModule00.DmEmpresaFields.Nombre.Value, 40 ) +
                                'T' +                         // Por defecto, telemática
                                RightPad( Copy( DataModule00.DmEmpresaFields.Telefono.Value, 1, 9 ), 9, '0' ) +    // Telefono de contacto
                                RightPad( DataModule00.DmEmpresaFields.PersonaConQuienRelacionarse.Value, 40 ) +   // Persona con quien relacionarse
                                NumeroIdentificativo +        // Numero de justificante de la declaración
                                '  ' +                        // Declaración complementaria o sustitutiva
                                StrConst( 13, '0' ) +         // Número de justificante de la declaración anterior
                                StrIntPadded( NroRegistros, 9 ) +
                                FormateaValorNumerico( ImporteTotal, 16, DecimalesMoneda, tfAEATConSigno ) +
                                StrConst(  9, '0' ) +         // Numero total de inmuebles
                                ' ' + StrConst( 15, '0' ) +   // Importe total inmuebles
                                StrConst( 205 ) +
                                StrConst( 9 ) +               // NIF del representante legal
                                StrConst( 88 ) +
                                StrConst( 13 ) );             // Sello electrónico

              First;
              While not Eof and not Canceled do
                begin

                If   ( Abs( DeclaracionOperacionesFields.ImporteTotalAnual.Value )>=DataImporteMinimo.Value ) or
                     ( Abs( DeclaracionOperacionesFields.ImporteTotalCriterioCaja.Value )<>0.0 )
                then begin

                     AddRecordMsg( DeclaracionOperacionesFields.Propietario.Value );

                     // Intracomunitario. Los Campos del NIF son excluyentes

                     If   DeclaracionOperacionesFields.OrigenOperacion.Value=1
                     then begin
                          NIFDeclarado := '';
                          NIFOperadorIntracomunitario := DeclaracionOperacionesFields.NIF.Value;
                          end
                     else begin
                          NIFDeclarado := DeclaracionOperacionesFields.NIF.Value;
                          NIFOperadorIntracomunitario := '';
                          end;

                     // Operaciones CriterioCaja

                     If   DeclaracionOperacionesFields.CriterioCaja.Value
                     then ConfiguraRegistroCC
                     else begin

                          // El usuario ya no está acogido al criterio de caja pero aún hay cobros o pagos de facturas del ejercicio anterior, cuando
                          // todavía lo estaba. Hay que grabar un registro adicional.

                          If   DeclaracionOperacionesFields.ImporteTotalCriterioCaja.Value<>0.0
                          then begin
                               ConfiguraRegistroCC;
                               GrabaRegistro;
                               end;

                          OperacionRegimenCriterioCaja := ' ';
                          ImporteOperacionesCC := 0.0;
                          For Index := 1 to 4 do
                            ImporteOperacionesTrimestre[ Index ] := DeclaracionOperacionesFields.ImporteTrimestre[ Index ].Value;

                          end;

                     ImporteTotalAnual := DeclaracionOperacionesFields.ImporteTotalAnual.Value;

                     GrabaRegistro;

                     end;

                Next;
                end;

              AddMsg( ntLinkInformation, Format( RsMsg2, [ AddPathDelim( DataPath.Value ) + NombreFichero ] ) );

              end;

          finally
            DeclaracionOperacionesTable.Close;
            CloseFile( Fichero );
            end;

          Registro.GuardaValor( ncrNroPresentacion347, IntToStr( DataNroPresentacion.Value + 1 ) );

       except
         AddMsg( ntError, RsMsg3 );
         end;

       end;
end;

end.
