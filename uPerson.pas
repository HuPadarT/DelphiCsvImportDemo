unit uPerson;

interface

uses System.TypInfo, uEnums;

type
  TPerson = class
  strict private
    FDBPrimaryKey: Int64;
    FPersonIdentifier: string;
    FLastName: string;
    FFisrtName: string;
    FAddressCardId: string;
    FAddressType: string;
    FPostcode: string;
    FCity: string;
    FStreet: string;
    FHouseNumber: string;
    FContactType: string;
    FContact: string;
    FModified: boolean;
    function GetContactType: String;
    procedure SetContactType(const AInItem: String);
    function GetAddressType: String;
    procedure SetAddressType(const AInItem: String);

  public
    property PersonIdentifier: string read FPersonIdentifier write FPersonIdentifier;
    property LastName: string read FLastName write FLastName;
    property FirstName: string read FFisrtName write FFisrtName;
    property AddressId: string read FAddressCardId write FAddressCardId;
    property AddressType: string read GetAddressType write SetAddressType;
    property Postcode: string read FPostcode write FPostcode;
    property City: string read FCity write FCity;
    property Street: string read FStreet write FStreet;
    property HouseNumber: string read FHouseNumber write FHouseNumber;
    property ContactType: string read GetContactType write SetContactType;
    property Contact: string read FContact write FContact;
    property Modified: boolean read FModified;
    function StrToAddressTypeEnum(const AValue: string): Boolean;
    function StrToContactTypeEnum(const AValue: string): Boolean;
    function Clone: TPerson;
    function ToString: string; // csv-be mentéshez
    procedure Assign(const AItem: TPerson);
    procedure Clear;
    procedure Inicialize(AVezeteknev, AKeresztnev, ASzemelyiAzon, ALakcimAzon, ACimTipus,
      AIranyitoSzam, ATelepules, AUtca, AHazszam, AElerhetosegTipus, AElerhetoseg: string);

    constructor Create; Reintroduce;
  end;

implementation

procedure TPerson.Assign(const AItem: TPerson);
begin
  self.FLastName := AItem.FLastName;
  self.FFisrtName := AItem.FFisrtName;
  self.FPersonIdentifier := AItem.FPersonIdentifier;
  self.FAddressCardId := AItem.FAddressCardId;
  self.FAddressType := AItem.FAddressType;
  self.FPostcode := AItem.FPostcode;
  self.FCity := AItem.FCity;
  self.FStreet := AItem.FStreet;
  self.FHouseNumber := AItem.FHouseNumber;
  self.FContactType := AItem.FContactType;
  self.FContact := AItem.FContact;
  self.FModified := AItem.FModified;
end;

procedure TPerson.Clear;
begin
  FLastName := '';
  FFisrtName := '';
  FPersonIdentifier := '';
  FAddressCardId := '';
  FAddressType := '';
  FPostcode := '';
  FCity := '';
  FStreet := '';
  FHouseNumber := '';
  FContactType := '';
  FContact := '';
  FModified := False;
end;

function TPerson.Clone: TPerson;
begin
  Result := TPerson.Create();
  Result.Assign(Self);
end;

constructor TPerson.Create;
begin
  inherited Create;
end;

procedure TPerson.Inicialize(AVezeteknev, AKeresztnev, ASzemelyiAzon, ALakcimAzon, ACimTipus,
  AIranyitoSzam, ATelepules, AUtca, AHazszam, AElerhetosegTipus, AElerhetoseg: string);
begin
  FLastName := AVezeteknev;
  FFisrtName := AKeresztnev;
  FPersonIdentifier := ASzemelyiAzon;
  FAddressCardId := ALakcimAzon;
  FAddressType := ACimTipus;
  FPostcode := AIranyitoSzam;
  FCity := ATelepules;
  FStreet := AUtca;
  FHouseNumber := AHazszam;
  FContactType := AElerhetosegTipus;
  FContact := AElerhetoseg;
  FModified := False;
end;

function TPerson.GetAddressType: String;
begin
  Result := FAddressType;
end;

function TPerson.GetContactType: String;
begin
  Result := FContactType;
end;

function TPerson.StrToAddressTypeEnum(const AValue: string): Boolean;
var
  EnumValue: Integer;
begin
  EnumValue := GetEnumValue(TypeInfo(TAddressTypeEnum), AValue);
  Result := EnumValue <> -1;
end;

procedure TPerson.SetAddressType(const AInItem: String);
begin
  if StrToAddressTypeEnum(AInItem) then
  begin
    FAddressType := AInItem;
  end
  else
    FAddressType := '';
end;

function TPerson.StrToContactTypeEnum(const AValue: string): Boolean;
var EnumValue: Integer;
begin
  EnumValue := GetEnumValue(TypeInfo(TContactTypeEnum), AValue);
  Result := EnumValue <> -1;
end;

function TPerson.ToString: string;
begin
  Result := Self.FLastName + ';' +
  Self.FirstName + ';' +
  Self.FPersonIdentifier + ';' +
  Self.FAddressCardId + ';' +
  Self.FAddressType + ';' +
  Self.FPostcode + ';' +
  Self.FCity + ';' +
  Self.FStreet + ';' +
  Self.FHouseNumber + ';' +
  Self.FContactType + ';' +
  Self.FContact + ';';
end;

procedure TPerson.SetContactType(const AInItem: String);
begin
  if StrToContactTypeEnum(AInItem) then
  begin
    FContactType := AInItem;
  end
  else
    FContactType := '';
end;

end.
