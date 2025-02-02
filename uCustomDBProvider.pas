unit uCustomDBProvider;

{ Abstract db provider osztály }

interface

uses
  SysUtils, SyncObjs, uPerson;

type
  TCustomDBProvider = class(TObject)
  private
    FRecordCount: integer;
    FDBPath: string;
    function GetdBPath: string;
    function GetRecordCount: integer;
    procedure SetDBPath(const AValue: string);
  protected
    procedure SetRecordCount(const AValue: integer);
  public
    property DBPath: string read GetdBPath write SetDBPath;
    property RecordCount: integer read GetRecordCount;

    constructor Create(Parent: TObject); virtual;
    destructor Destroy; override;
    function Initialize(): boolean; virtual; abstract;

    procedure BeginTransaction; virtual; abstract;
    procedure CommitTransaction; virtual; abstract;
    procedure RollbackTransaction; virtual; abstract;

    function GetOption(Name: string): string; virtual; abstract;
    procedure PutOption(Name, Value: string); virtual; abstract;

    function FetchRecords(): boolean; virtual; abstract;
    function GetOneRecord(const AId: Int64): TPerson; virtual; abstract;
  end;

implementation

{ TCustomDBProvider }

constructor TCustomDBProvider.Create(Parent: TObject);
begin
  FRecordCount := 0;
end;

destructor TCustomDBProvider.Destroy;
begin

  inherited;
end;

procedure TCustomDBProvider.SetDBPath(const AValue: string);
begin
  FDBPath := AValue;
end;

procedure TCustomDBProvider.SetRecordCount(const AValue: integer);
begin
  FRecordCount := AValue;
end;

function TCustomDBProvider.GetdBPath: string;
begin
  Result := FDBPath;
end;

function TCustomDBProvider.GetRecordCount: integer;
begin
  Result := FRecordCount;
end;

end.
