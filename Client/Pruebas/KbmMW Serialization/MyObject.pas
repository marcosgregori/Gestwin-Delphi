unit MyObject;

interface

uses
    System.SysUtils,
    System.Variants,
    System.Classes,
    Generics.Collections,
    kbmMWXMLMarshal,
    kbmMWObjectMarshal;

type

    [kbmMW_Root('address')]
    TAddress = class
    private
        FStreet: String;
        FZipCode: Integer;
        FCity: String;
        FCountry: String;
    public
        constructor Create(AStreet: String; AZipCode: Integer; ACity, ACountry: String);
        [kbmMW_Element]
        property Street: String read FStreet write FStreet;
        [kbmMW_Element]
        property ZipCode: Integer read FZipCode write FZipCode;
        [kbmMW_Element]
        property City: String read FCity write FCity;
        [kbmMW_Element]
        property Country: String read FCountry write FCountry;
    end;

    TPerson = class;

    [kbmMW_Root('children', [mwrfIncludeOnlyTagged])]
    [kbmMW_Child('child')]
    TChildren = class(TObjectList<TPerson>)
        function Add(APerson: TPerson): Integer;
    end;

    [kbmMW_Root('person')]
    TPerson = class
    private
        FName: String;
        FAge: Integer;
        FAddress: TAddress;
        FChildren: TChildren;
    public
        constructor Create(AName: String; AAge: Integer; AAddress: TAddress);
        destructor Destroy; override;
        [kbmMW_Attribute]
        property Name: String read FName write FName;
        [kbmMW_Attribute]
        property Age: Integer read FAge write FAge;
        [kbmMW_Element]
        property Address: TAddress read FAddress write FAddress;
        [kbmMW_Element]
        property Children: TChildren read FChildren write FChildren;
    end;

implementation

constructor TAddress.Create(AStreet: string; AZipCode: Integer; ACity: string; ACountry: string);
begin
    inherited Create;
    FStreet := AStreet;
    FZipCode := AZipCode;
    FCity := ACity;
    FCountry := ACountry;
end;

function TChildren.Add(APerson: TPerson): Integer;
begin
    Result := inherited Add(APerson);
end;

constructor TPerson.Create(AName: string; AAge: Integer; AAddress: TAddress);
begin
    inherited Create;
    FName := AName;
    FAge := AAge;
    FAddress := AAddress;
    FChildren := TChildren.Create;
end;

destructor TPerson.Destroy;
begin
    FChildren.Free;
    FAddress.Free;
    inherited Destroy;
end;

initialization

kbmMWRegisterKnownTypes([typeinfo(TAddress), typeinfo(TChildren), typeinfo(TPerson)]);

end.
