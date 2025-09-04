
unit b_ea3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, AppForms, StdCtrls, Buttons, Mask, 

  AppContainer,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, DB, dxmdaset, DataManager,
  nxdb, dxSkinsCore, cxGraphics, cxLookAndFeels, dxSkinsDefaultPainters,
  cxLabel, cxGroupBox;

type
  TboxEA3Form = class(TgxForm)
    DataPanel: TgxEditPanel;
    ButtonsPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    PathCtrl: TcxDBTextEdit;
    examinarButton: TgBitBtn;
    FicheroCtrl: TcxDBTextEdit;
    Panel2: TcxGroupBox;
    gBitBtn1: TgBitBtn;
    gBitBtn2: TgBitBtn;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataPath: TWideStringField;
    DataFichero: TWideStringField;
    SaldosTable: TnxeTable;
    SaldosTableEjercicio: TSmallintField;
    SaldosTableCodigo: TWideStringField;
    SaldosTableCentroCoste: TWideStringField;
    Label3: TcxLabel;
    Label8: TcxLabel;
    Label1: TcxLabel;
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
    procedure examinarButtonClick(Sender: TObject);
    procedure PathCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);

  private

    Fichero           : Text;
    FileName          : String;

    CodigoCuenta      : String;
    StSaldoInicial,
    StSaldoFinal,
    StAcumuladoDebe,
    StAcumuladoHaber  : String;

  public
    procedure ExecuteProcess;
  end;

var
  boxEA3Form: TboxEA3Form;

procedure enlaceA3;

implementation

{$R *.DFM}

{$I-}

uses   Files,
       FileCtrl,
       LibUtils,
       AppManager,
       EnterpriseDataAccess,

       Gim00Fields,
       Gdm00Dm,
       Gdm10Frm,

       dmi_sal,

       dm_sal,
       dm_ast,
       dm_iex,

       b_msg,
       b_pro,
       b_dir,
       f_prg;

resourceString
  rsMsg1   = 'Realizando el proceso de enlace con el impuesto de sociedades de A3';
  rsMsg2   = 'El Fichero %s.DAT ya existe en el subdirectorio indicado.';
  rsMsg3   = '¿Desea sustituir el Fichero existente?';
  rsMsg4   = 'No he conseguido crear el Fichero [%s].';
  rsMsg5   = 'Cuenta';
  rsMsg6   = 'Ha ocurrido un error durante el proceso de enlace,' + #13 + 'Debe repetirlo para asegurarse de que los datos se han exportado correctamente.';

procedure EnlaceA3;
begin
     CreateEditForm( TBoxEA3Form, boxEA3Form, TGds10Frm.ContableSection, True );
end;

procedure TboxEA3Form.FormManagerInitializeForm;

function ObtenPathA3 : String;

Var   St  : String;

begin
     getDir( 0, St );
     If   IoResult=0
     then result := copy( St, 1, 3 ) + 'A3SOC\'
     else result := '';
end;

begin
     DataPath.Value := ObtenPathA3;
     DataFichero.value  := 'S' + CodigoEmpresaActual + 'BALA';
end;

procedure TboxEA3Form.FormManagerOkButton;
begin
     CreateProcessForm( ExecuteProcess, caption );
end;

procedure TboxEA3Form.PathCtrlPropertiesValidate(Sender: TcxCustomEdit;var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If  not FormManager.ValidatingFormData
     then If   DisplayValue<>''
          then If   not SysUtils.DirectoryExists( DisplayValue )
               then begin
                    Error := True;
                    ErrorText := JoinMessage( rsgMsg394, rsgMsg395 );
                    end;
end;

procedure TboxEA3Form.examinarButtonClick(Sender: TObject);
begin
     SelectDirectory( DataPath );
end;

procedure TboxEA3Form.ExecuteProcess;

var  SumasySaldos : ISumasySaldos;

function StDoubleCompact( Value : Decimal; Decimals : byte ) : String;

var  St : String;
     Ps : SmallInt;

begin
     try
       If   Value=0.0
       then St := '0'
       else begin
            St := format( '%.*f', [ Decimals, Value ] );
            Ps := Pos( FormatSettings.DecimalSeparator, St );
            If   Ps<>0
            then Delete( St, Ps, 1 );
            end;
       Result := St;
     finally
       end;
end;

begin

     With ProcessFrame do
       begin

       AddMsg( ntInformation, rsMsg1 );

       try

         fileName := addPathDelim( DataPath.value ) + DataFichero.value + '.DAT';

         assignFile( Fichero, fileName );
         reset( Fichero );
         If   IoResult=0
         then begin
              closeFile( Fichero );
              If   ShowNotification( ntQuestionWarning,  format( rsMsg2, [ DataFichero.value ] ), rsMsg3 )<>mrYes
              then exit;
              end;

         rewrite( Fichero );
         If   IoResult<>0
         then begin
              addMsg( ntError, format( rsMSg4, [ fileName ] ) + #13 + rsgMsg361 );
              exit;
              end;

         addMsg( ntInformation, rsMsg5 );

         CodigoCuenta := '';

         With SaldosTable do
           begin
           SetRange( [ ApplicationContainer.Ejercicio, '', '' ], [ ApplicationContainer.Ejercicio, HighStrCode, HighStrCode ] );
           First;
           While not eof do
             begin

             If   TrimRight( SaldosTableCodigo.Value )<>CodigoCuenta
             then begin

                  CodigoCuenta := TrimRight( SaldosTableCodigo.Value  );

                  If   Length( CodigoCuenta )=4
                  then With Saldos do
                         begin

                         //* 19.11.2001 Sustituido el 12 por ApplicationContainer.NroMesFinal

                         SumasySaldos := SaldoPeriodo( CodigoCuenta, '', True, ApplicationContainer.Ejercicio, 0, ApplicationContainer.NroMesFinal );

                         If   ( SumasySaldos.SumaDebe<>0.0 ) or ( SumasySaldos.SumaHaber<>0.0 )
                         then begin

                              StSaldoInicial   := StDoubleCompact( SumasySaldos.Debe[ 0 ] - SumasySaldos.Haber[ 0 ], DecimalesMoneda );
                              StSaldoFinal     := StDoubleCompact( SumasySaldos.Saldo, DecimalesMoneda );

                              StAcumuladoDebe  := StDoubleCompact( SumasySaldos.DebeAcumulado, DecimalesMoneda );
                              StAcumuladoHaber := StDoubleCompact( SumasySaldos.HaberAcumulado, DecimalesMoneda );

                              Writeln( Fichero, LeftPad( DataModule00.DmEmpresaFields.NIF.Value, 10, ' ' ) +
                                                LeftPad( CodigoCuenta, 4, ' ' ) +
                                                LeftPad( StSaldoInicial, 12, ' ' ) +
                                                LeftPad( StSaldoFinal, 12, ' ' ) +
                                                LeftPad( StAcumuladoDebe, 12, ' ' ) +
                                                LeftPad( StAcumuladoHaber,12, ' ' ) +
                                                IntToStr( ApplicationContainer.Ejercicio ) );

                              AddRecordMsg( CodigoCuenta );
                              end;

                         end;

                  end;

             Next;
             end;

           end;

         closeFile( Fichero );
         IoCheck( IoResult );

       except
         addmsg( ntError, rsMsg6 );
         end;


     end;
     
end;


end.
