program  Instalar;

uses
  Forms,
  b_inw in 'b_inw.pas' {ChargeForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TChargeForm, ChargeForm);
  Application.Run;
end.
