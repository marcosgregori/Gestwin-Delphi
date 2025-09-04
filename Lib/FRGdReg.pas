
unit FRGdReg;

interface

procedure Register;

implementation


uses    Windows,
        Classes,
        AppContainer,
        DesignIntf,
        DesignEditors,

        SQLSet,
        SQLsEdit,

        f_not;

const   GestwinTab = 'Gestwin';


procedure Register;
begin

     { SQLSet }

     RegisterComponents( GestwinTab, [ TgxSQLSet ] );

     RegisterPropertyEditor( TypeInfo( TgxSQLItems ), TgxSQLSet, '', TSQLItemsProperty );

     RegisterNoIcon( [ TAnnotationFrame ] );
end;

initialization

finalization

end.

