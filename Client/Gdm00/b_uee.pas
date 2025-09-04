
unit b_uee;

interface

uses Forms, AppForms, StdCtrls, Controls, Buttons, Classes,
     Mask,Winapi.Messages,ExtCtrls, ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, cxControls,
     cxContainer, cxEdit, cxTextEdit, cxDBEdit, nxdb, DB,
     cxMaskEdit, cxDropDownEdit, cxCalendar, cxCheckBox,
     dxSkinsCore, dxSkinsDefaultPainters, cxLabel, cxGraphics,
     cxLookAndFeels, cxGroupBox, dxmdaset,

     AppContainer,
     DataManager,
     LibUtils,

     Gim00Fields;

type
  TBoxUeeForm = class( TgxForm )
    ButtonsPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    Label2: TcxLabel;
    LabelCtrl3: TcxLabel;
    LabelCtrl4: TcxLabel;
    LabelCtrl6: TcxLabel;
    LabelCtrl1: TcxLabel;
    LabelCtrl5: TcxLabel;
    UsuarioCtrl: TcxDBTextEdit;
    FechaCtrl: TcxDBDateEdit;
    EmpresaCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    Panel3: TgxEditPanel;
    OkButton: TgBitBtn;
    cerrarButton: TgBitBtn;
    Data: TgxMemData;
    DataCodigoUsuario: TWideStringField;
    DataCodigoEmpresa: TWideStringField;
    DataFecha: TDateField;
    DataSource: TDataSource;
    EjercicioLabel: TcxLabel;
    procedure UsuarioCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure UsuarioCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure empresaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure empresaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure empresaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure InitializeForm;
    procedure FormManagerOkButton;
    function FormManagerCanClose: Boolean;
    procedure UsuarioCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure UsuarioCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure FormManagerShowForm;
    procedure FechaCtrlPropertiesValuePosted(Sender: TObject);
    procedure FormManagerAfterDestroyForm;

  private

    DsEmpresaFields : TEmpresaFields;
    DsUsuarioFields : TUsuarioFields;

    AccesoInicial : Boolean;
    CodigoUsuarioAnterior : String;
    Ejercicio : SmallInt;

    procedure ActualizaEjercicio;

  protected

  public

  end;

var
  BoxUeeForm : TBoxUeeForm = nil;

procedure CambioEmpresa( MuestraMensajeAdvertencia : Boolean = True );

implementation

{$R *.dfm}

uses   Windows,
       SysUtils,
       DateUtils,
       Variants,
       Files,
       DataAccess,
       EnterpriseDataAccess,

       AppManager,
       Scheduler,
       Dashboard,
       NexusRpcData,

       AppForm,

       Gdm00Dm,
       Gdm00Frm,

       dm_pga,
       dm_usr,
       dm_emp,
       dm_cnd,

       b_msg,
       b_cda,

       cx_emp,
       cx_usr,

       a_emp,
       a_usr;

resourceString
       RsMsg1  = 'Solo el usuario maestro (código 00) puede acceder al mantenimiento de Empresas.';
       RsMsg2  = 'Si quiere acceder al mantenimiento de Empresas desde este punto modifique el código del usuario.';
       RsMsg3  = 'Está intentando acceder al ejercicio [B]%d[/B].';
       RsMsg4  = 'Antes de proseguir, confirme que eso es lo que desea hacer.';

var  AccessGranted : Boolean = False;
     AccessDate : TDate;

procedure CambioEmpresa( MuestraMensajeAdvertencia : Boolean = True );
begin
     If   ApplicationContainer.TryToCloseAll( True, MuestraMensajeAdvertencia )=mrOk
     then CreateEditForm( TBoxUeeForm, BoxUeeForm, Gds00Frm.StartAppSection, True );
end;

procedure TBoxUeeForm.InitializeForm;
begin

     DsEmpresaFields := TEmpresaFields.Create( Self );
     DsUsuarioFields := TUsuarioFields.Create( Self );

     With ApplicationContainer, DataModule00 do
       If   CodigoEmpresaActual=''
       then begin
            DmEmpresaTable.First;
            With DmUsuarioTable do
              begin
              First;
              If   not Eof
              then Next;    // No el usuario maestro, sino el siguiente
              end;
            AccesoInicial := True;
            end;

     // Primero hay que asignar la Empresa porque al asignar el usuario se fija la Empresa por defecto del mismo (si existe)

     DataCodigoEmpresa.Value := DataModule00.DmEmpresaFields.Codigo.Value;
     DataCodigoUsuario.Value := DataModule00.DmUsuarioFields.Codigo.Value;

     DataFecha.Value := ApplicationContainer.TodayDate;

     ReleaseScheduler;
     ReleaseDashboard;

     // Limpio el código de usuario activo por seguridad

     CodigoUsuarioActual := '';

     Configuracion;  // Carga el módulo y lo inicializa

     ApplicationContainer.SelectAppSection( Gds00Frm.StartAppSection );

     AccessGranted := False;
end;

procedure TBoxUeeForm.UsuarioCtrlPropertiesEditRequest( Sender: TcxCustomEdit );
begin
     MntUsuarios( [ Sender.EditingValue ] );
end;

procedure TBoxUeeForm.UsuarioCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With UsuarioCtrl do
       begin
       EmpresaCtrl.Properties.ReadOnly := False;
       Usuario.Obten( EditValue, DsUsuarioFields );
       If   EditValue<>'00'   // No se puede limitar el acceso al usuario maestro
       then If   DsUsuarioFields.CodigoEmpresa.Value<>''
            then begin
                 DataCodigoEmpresa.Value := DsUsuarioFields.CodigoEmpresa.Value;
                 EmpresaCtrl.Properties.ReadOnly := True;
                 end;
       end;
end;

procedure TBoxUeeForm.UsuarioCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaUsuarios( Sender );
end;

procedure TBoxUeeForm.UsuarioCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean );
begin
     Usuario.Valida( Sender, DisplayValue, ErrorText, Error, DsUsuarioFields );
end;

procedure TBoxUeeForm.FormManagerOkButton;

var  PalabraPaso : String;

begin

     try

       try

         If   Ejercicio>YearOf( Now ) + 1
         then If   ShowNotification( ntQuestionWarning, Format( RsMsg3, [ Ejercicio ] ), RsMsg4 )<>mrYes
              then Abort;

         If   not ApplicationContainer.TDI
         then Visible := False;

         ApplicationContainer.CambioDeEmpresa := True;

         DataModule00.DmEmpresaTable.GotoCurrent( Empresa.DmEmpresaTable );

         If   DataModule00.DmUsuarioTable.FindKey( [ DataCodigoUsuario.Value ] )
         then begin

              // Evito que se vuelva a pedir la contraseña si el usuario
              // está simplemente cambiando de empresa o ejercicio activo.

              If   AccesoInicial or ( DataCodigoUsuario.Value<>CodigoUsuarioAnterior )
              then If   DataModule00.DmUsuarioFields.Password.Value<>0
                   then If   not CheckPassword( DataModule00.DmUsuarioFields, PalabraPaso )
                        then Abort;

              CodigoUsuarioActual := DataCodigoUsuario.Value;
              UsuarioMaestro := CodigoUsuarioActual='00';

              If   NexusRpc.AccesoUsuario( DataCodigoUsuario.Value, AccesoInicial, PalabraPaso, DataCodigoEmpresa.Value, DataFecha.Value )
              then begin
                   CloseAllDataModules;
                   AccessGranted := True;
                   AccessDate := DataFecha.Value;
                   end
              else Abort;

              end;

       finally
         If   not ReleasingApplication
         then ApplicationContainer.CambioDeEmpresa := False;
         end;

       except
         If   not ReleasingApplication
         then Visible := True;
         raise;
         end;

end;

procedure TBoxUeeForm.FormManagerShowForm;
begin
     CodigoUsuarioAnterior := DataCodigoUsuario.Value;
end;

procedure TBoxUeeForm.FechaCtrlPropertiesValuePosted(Sender: TObject);
begin
     ActualizaEjercicio;
end;

procedure TBoxUeeForm.FormManagerAfterDestroyForm;
begin
     If   AccessGranted and not ( ReleasingApplication or DatabaseUpdateRequested )
     then try
            Configuracion.AccesoUsuario( AccessDate );
          except on E : Exception do
            begin
            ShowException( E );
            PrgExit( { RequestForExit } False,  { Force } True );
            end;
          end;
end;

function TBoxUeeForm.FormManagerCanClose: Boolean;
begin
     //* 06.10.2005  Si se está procediendo a una reestructuración de la base de datos
     //              entonces tiene permiso para cerrar la ventana.

     Result := False;
     If   ReleasingApplication or DatabaseUpdateRequested or ( FormManager.FormResult=mrOk )
     then Result := True
     else If   ( ( FormManager.FormResult=mrCancel ) or ApplicationContainer.ApplicationFormCloseQuery ) and not Application.Terminated
          then Result := PrgExit( True );
end;

procedure TBoxUeeForm.EmpresaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     If   DataCodigoUsuario.Value='00'
     then begin

          //* 20.07.2004  De esta forma se vuelve a cargar la ficha en validación aunque
          //              el usuario no cambie el código

          EmpresaCtrl.EditModified := True;
          MntEmpresas( [ Sender.EditingValue ] );
          end
     else ShowNotification( ntStop, RsMsg1, RsMsg2 );
end;

procedure TBoxUeeForm.EmpresaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaEmpresas( Sender );
end;

procedure TBoxUeeForm.EmpresaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Empresa.Valida( Sender, DisplayValue, ErrorText, Error, DsEmpresaFields );
     If   not Error
     then ActualizaEjercicio;
end;

procedure TBoxUeeForm.ActualizaEjercicio;
begin
     try
       Ejercicio := AccountingYear( DataFecha.Value, DsEmpresaFields.Contable_MesInicial.Value );
       If   Ejercicio>=1900
       then EjercicioLabel.Caption := IntToStr( Ejercicio ) + ' ';
     except
       end;
end;

end.
