unit cm_man;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppContainer, StdCtrls, ExtCtrls, DB,

  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,

  Gim10Fields;

type
  TCmdManModule = class(TDataModule)
    procedure DataModuleDestroy(Sender: TObject);
  private
  protected
    procedure GrupoClienteCtrlQueryRequest(Sender: TcxCustomEdit);
    procedure GrupoClienteCtrlValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
  end;

var CmdManModule : TCmdManModule = nil;

implementation

uses AppManager,

     i_man,

     dm_gdc,

     cx_gdc;

{$R *.dfm}

procedure SetupModule;
begin
     If   Assigned( FrpManForm )
     then begin

          CreateDataModule( TCmdManModule, CmdManModule, FrpManForm );

          If   Assigned( CmdManModule  )
          then With CmdManModule do
                 begin

                 FrpManForm.GrupoClienteTabSheet.TabVisible := True;

                 With FrpManForm.GrupoInicialCtrl.Properties do
                   begin
                   OnQueryRequest := GrupoClienteCtrlQueryRequest;
                   OnValidate := GrupoClienteCtrlValidate;
                   end;

                 With FrpManForm.GrupoFinalCtrl.Properties do
                   begin
                   OnQueryRequest := GrupoClienteCtrlQueryRequest;
                   OnValidate := GrupoClienteCtrlValidate;
                   end;

                 end;

          end;
end;

procedure TCmdManModule.DataModuleDestroy(Sender: TObject);
begin
     CmdManModule := nil;
end;

procedure TCmdManModule.GrupoClienteCtrlQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaGruposCliente( Sender );
end;

procedure TCmdManModule.GrupoClienteCtrlValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     GrupoCliente.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

initialization
  AddProcedure( imOnCreateComponent, idFrpManForm, SetupModule );

end.
