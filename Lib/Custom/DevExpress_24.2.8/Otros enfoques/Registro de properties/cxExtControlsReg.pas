unit cxExtControlsReg;

interface

uses  Classes,
      
      cxExtControls;

procedure Register;

implementation

resourceString
      ExtControlsTab = 'Gestwin Extended Controls';

procedure Register;
begin
     RegisterComponents( ExtControlsTab, [ TgxDBTextEdit ] );
end;

end.
