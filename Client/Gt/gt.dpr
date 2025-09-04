program gt;

uses
  nxReplacementMemoryManager,
  nxReplacementMove,
  Windows,
  Forms,
  Gim00Fields in '..\..\Interface\Gim00\Gim00Fields.pas',
  dmi_cnd in '..\..\Interface\Gim00\dmi_cnd.pas',
  b_uee in '..\Gtm00\b_uee.pas' {BoxUeeForm: TgxForm},
  b_cda in '..\Gtm00\b_cda.pas' {controlAccesosForm: TgxForm},
  ct_emp in '..\Gtm00\ct_emp.pas' {CtEmpForm: TgxForm},
  ct_usr in '..\Gtm00\ct_usr.pas' {ctUsrForm: TgxForm},
  at_tck in '..\Gtm30\at_tck.pas' {MntTckTouchForm: TgxForm},
  Gim10Fields in '..\..\Interface\Gim10\Gim10Fields.pas',
  Gim30Fields in '..\..\Interface\Gim30\Gim30Fields.pas',
  dmi_mov in '..\..\Interface\Gim30\dmi_mov.pas',
  dmi_sto in '..\..\Interface\Gim30\dmi_sto.pas',
  MovimientoIntf in '..\..\Interface\Gim30\MovimientoIntf.pas',
  LineaMovimientoIntf in '..\..\Interface\Gim30\LineaMovimientoIntf.pas',
  dmi_iva in '..\..\Interface\Gim10\dmi_iva.pas',
  ct_mve in '..\Gtm30\ct_mve.pas' {CxMveForm: TgxForm},
  teclado in '..\Gtm00\teclado.pas' {TecladoForm: TgxForm},
  ct_art in '..\Gtm30\ct_art.pas' {CBoxArtForm: TgxForm},
  AppForm in 'AppForm.pas' {ApplicationForm: TgxForm},
  EnterpriseDataAccess in '..\..\Lib\EnterpriseDataAccess.pas' {EnterpriseDataModule: TDataModule},
  DataManager in '..\..\Lib\DataManager.pas',
  DataAccess in '..\..\Lib\DataAccess.pas' {DataAccessModule: TDataModule},
  AppManager in '..\..\Lib\AppManager.pas',
  TouchTableViewController in '..\..\Lib\TouchTableViewController.pas',
  TouchQueryForm in '..\..\Lib\TouchQueryForm.pas' {FilterFrame: TFrame};

{$R *.res}

// Estas opciones hacen que se cargue toda la aplicación en memoria y evita que se lean páginas desde el servidor cuando se necesitan (entre otras cosas)

const  IMAGE_DLLCHARACTERISTICS_TERMINAL_SERVER_AWARE = $8000;

{$SetPEOptFlags IMAGE_DLLCHARACTERISTICS_TERMINAL_SERVER_AWARE}
{$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP or IMAGE_FILE_NET_RUN_FROM_SWAP}


begin

     TouchApplication := True;
     TabletApp := True;

     Application.Initialize;
     Application.MainFormOnTaskbar := True;
     Application.CreateForm(TApplicationForm, ApplicationForm);
  Application.Run;
end.
