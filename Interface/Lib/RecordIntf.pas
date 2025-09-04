
{$ALIGN OFF} {$OPTIMIZATION OFF}

unit RecordIntf;

interface

uses  SysUtils,
      Classes,

      LibUtils,
      DataManager,
      nxllComponent,
      nxllTypes,
      nxivTypes,
      nxrdClass,
      nxrbTypes,
      nxsdTypes,

      DB,
      SessionIntf,

      Gim30Fields;

const
  CLSID_Record : TnxGuid = '{}';

type

  IRecordIntf = interface( IInvokableRecord )

    procedure ToDataset( RecordFields : TnxeDatasetFields );
    function GetState : TDataSetState;
    procedure SetState( const Value : TDataSetState );

    function GetRecordSize : SmallInt;
    procedure SetRecordSize( const Value  : SmallInt );
    function GetData : Variant;
    procedure SetData( const Value  : Variant );

    property State : TDatasetState read GetState write SetState;

    property RecordSize : SmallInt read GetRecordSize write SetRecordSize;
    property Data : Variant read GetData write SetData;
    end;

   TRecordIntf = class( TnxClass, InxRemoteableClass, IRecordIntf)
     private

     FState : TDataSetState;
     FRecordSize : Variant;
     FData : Variant;

     function GetRecordSize : SmallInt;
     procedure SetRecordSize( const Value  : SmallInt );
     function GetData : Variant;
     procedure SetData( const Value  : Variant );

     function LoadFromReader( AReader : InxReader ) : HRESULT;
     function SaveToWriter( AWriter : InxWriter ) : HRESULT;

     function GetState : TDataSetState;
     procedure SetState( const Value : TDataSetState );
     function GetClassID : TnxGuid;

     public

     constructor Create( AClassID : PnxGuid );

     class function FromDataset( RecordFields : TnxeDatasetFields ) : IRecordIntf;
     procedure ToDataset( RecordFields : TnxeDatasetFields );
     end;

implementation

uses  Variants,

      nxrbVariantFiler,
      nxreRemoteServerEngine;

{ TRecordIntf }

constructor TRecordIntf.Create( AClassID : PnxGuid );
begin
     inherited Create( AClassID, nil, nil, False);
     FState := dsInsert;
end;

class function TRecordIntf.FromDataset( RecordFields : TnxeDatasetFields ) : IRecordIntf;

var  I : SmallInt;

begin
      Result := TRecordIntf.Create;

      With Result do
        begin
        State := RecordFields.Dataset.State;


        end;


end;

procedure TRecordIntf.ToDataset( RecordFields : TnxeDatasetFields );

var  I : SmallInt;

begin

     try

       If   RecordFields.SetStateFromInterface( FState )
       then begin

            end;

     except
       RecordFields.Dataset.Cancel;
       raise;
       end;
end;

function TRecordIntf.LoadFromReader( AReader : InxReader ) : HRESULT;

var  I : SmallInt;
     AFlags : TnxVarFlags;

begin
     With AReader do
       try
         FState := TDatasetState( ReadInteger );
         FRecordSize := ReadInteger;
         nxReadVariant( AFlags, FData, AReader );
       except
         end;
     Result := S_OK;
end;

function TRecordIntf.SaveToWriter( AWriter : InxWriter) : HRESULT;

var  I : SmallInt;

begin
     With AWriter do
       try
         WriteInteger( Ord( FState ) );
         WriteInteger( FRecordSize );
         nxWriteVariant( FData, AWriter );
       except
         end;
     Result := S_OK;
end;

function TRecordIntf.GetClassID: TnxGuid;
begin
     Result := CLSID_Record;
end;

{ Getters}

function TRecordIntf.GetState: TDataSetState;
begin
     Result := FState;
end;

function TRecordIntf.GetRecordSize: SmallInt;
begin
     Result := FRecordSize;
end;

function TRecordIntf.GetData : Variant;
begin
     Result := FData;
end;

{ Setters}

procedure TRecordIntf.SetState(const Value: TDataSetState);
begin
     FState := Value;
end;

procedure TRecordIntf.SetRecordSize(const Value: SmallInt);
begin
     FRecordSize := Value;
end;

procedure TRecordIntf.SetData( const Value: Variant );
begin
     FData := Value;
end;

end.


