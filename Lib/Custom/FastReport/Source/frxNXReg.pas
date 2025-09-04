
{ ******************************************

              FastReport v3.0
          NX enduser components

  Creado por : Marcos Gregori Forestier

  ****************************************** }

unit frxNXReg;

interface

{$I frx.inc}

procedure Register;

implementation

uses
  Windows, Messages, SysUtils, Classes, DesignIntf, DesignEditors,

  FrxNXComponents,
  DataManager,
  ReportManager,
  SQLSet,
  SQLsEdit;

// TSQLItemsProperty

Type TSQLItemsProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

procedure TSQLItemsProperty.Edit;

var  AComponent : TPersistent;
     ASQLSet : TgxSQLSet;

begin
     AComponent := GetComponent( 0 );
     ASQlSet := nil;
     If   AComponent is TgxReportManager
     then ASQLSet := TgxReportManager( AComponent ).SQLSet
     else If   AComponent is TnxeDatabaseDictionary
          then ASQLSet := TnxeDatabaseDictionary( AComponent ).SQLSet;
     If   Assigned( ASQLSet )
     then If   EditSQLItems( ASQLSet )
          then Modified;
end;

function TSQLItemsProperty.GetAttributes: TPropertyAttributes;
begin
     Result := [ paDialog, paReadOnly ];
end;

procedure Register;
begin
  RegisterComponents('FastReport VCL', [ TfrxNXComponents ] );

  RegisterComponents('Gestwin', [ TgxReportManager ]);

  RegisterPropertyEditor( TypeInfo( TgxSQLItems ), TgxReportManager, '', TSQLItemsProperty );
  RegisterPropertyEditor( TypeInfo( TgxSQLItems ), TnxeDatabaseDictionary, '', TSQLItemsProperty );

end;

end.
