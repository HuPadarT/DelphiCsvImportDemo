unit uViewModel;

interface

uses
  System.Classes, System.SysUtils, Datasnap.DBClient, Data.DB, System.Generics.Collections,
  uPerson, Data.FMTBcd, Data.SqlExpr;

type
  TPersonViewModel = class

  private
    FPersonList: TObjectList<TPerson>;
    FClientDataSet: TClientDataSet;
    FProgressStatus: string;
    FDBConnection: TSQLConnection;
    FSQLQuery1: TSQLQuery;
    procedure SyncToClientDataSet;
    function StringToMd5Hash(const ADataString: string): string;
  public
    constructor Create;
    destructor Destroy; override;

    property ClientDataSet: TClientDataSet read FClientDataSet;
    property StatusMessage: string read FProgressStatus;
    procedure ParseEnum<T>(sl: TStrings);
    procedure LoadFromCSV(const AFileName: string; const AFieldSeparator: char);
    procedure AddPerson(AVezeteknev, AKeresztnev, ASzemelyiAzon, ALakcimAzon, ACimTipus,
      AIranyitoSzam, ATelepules, AUtca, AHazszam, AElerhetosegTipus, AElerhetoseg: string);
    procedure DeletePerson(const AItemId: string);
    procedure SaveToDb;
  end;
implementation

uses uEnums, System.Rtti, System.TypInfo, System.Hash, uFireBirdProvider;

{ TPersonViewModel }

procedure TPersonViewModel.AddPerson(AVezeteknev, AKeresztnev, ASzemelyiAzon,
  ALakcimAzon, ACimTipus, AIranyitoSzam, ATelepules, AUtca, AHazszam,
  AElerhetosegTipus, AElerhetoseg: string);
var Person: TPerson;
begin
  Person := TPerson.Create();
  try
    Person.Inicialize(AVezeteknev, AKeresztnev, ASzemelyiAzon, ALakcimAzon, ACimTipus,
      AIranyitoSzam, ATelepules, AUtca, AHazszam, AElerhetosegTipus, AElerhetoseg);
    FPersonList.Add(Person.Clone);
    SyncToClientDataSet;
    FProgressStatus := AVezeteknev + ' ' + AKeresztnev + '(' + ASzemelyiAzon + ') sikeresen hozzáadva';
  finally
    Person.Free;
  end;
end;

constructor TPersonViewModel.Create;
begin
  FPersonList := TObjectList<TPerson>.Create(True);

  FClientDataSet := TClientDataSet.Create(nil);
  with FClientDataSet.FieldDefs do
  begin
    Add('Vezeteknev', ftString, 50);
    Add('Keresztnev', ftString, 50);
    Add('SzemelyiAzon', ftString, 15);
    Add('LakcimAzon', ftString, 15);
    Add('CimTipus', ftString, 15);
    Add('IranyitoSzam', ftString, 10);
    Add('Telepules', ftString, 50);
    Add('Utca', ftString, 250);
    Add('Hazszam', ftString, 20);
    Add('ElerhetosegTipus', ftString, 15);
    Add('Elerhetoseg', ftString, 50);
  end;
  FClientDataSet.CreateDataSet;

  end;

function TPersonViewModel.StringToMd5Hash(const ADataString: string): string;
begin
  Result := THashMD5.GetHashString(ADataString);
end;

procedure TPersonViewModel.DeletePerson(const AItemId: string);
var hsh, s, prsHsh: string;
begin
  hsh := StringToMd5Hash(AItemId);
  for var I := 0 to FPersonList.Count - 1 do
  begin;
    s := FPersonList[I].LastName + ';' +
      FPersonList[I].FirstName + ';' +
      FPersonList[I].PersonIdentifier + ';' +
      FPersonList[I].AddressId + ';' +
      FPersonList[I].AddressType + ';' +
      FPersonList[I].Postcode + ';' +
      FPersonList[I].City + ';' +
      FPersonList[I].Street + ';' +
      FPersonList[I].HouseNumber + ';' +
      FPersonList[I].ContactType + ';' +
      FPersonList[I].Contact;
    prsHsh := StringToMd5Hash(s);
    if prsHsh = hsh then
    begin;
      FProgressStatus := FPersonList[I].LastName + ' ' + FPersonList[I].FirstName + ' (' + FPersonList[I].PersonIdentifier + ') törlése megtörtént.';
      if FPersonList.Count = 1 then
      begin
        FPersonList.Clear;
      end
      else
        FPersonList.Remove(FPersonList[I]);
      Break;
    end;
  end;
  SyncToClientDataSet;
end;

procedure TPersonViewModel.LoadFromCSV(const AFileName: string; const AFieldSeparator: char);
var Person: TPerson;
    FileContent: TStringList;
    Lines: TArray<string>;
    Line: string;
    Parts: TStringList;
    Headers: TDictionary<string, Integer>;
begin
  FileContent := TStringList.Create;
  try
    Headers := TDictionary<string, Integer>.Create;
    try
      Parts := TStringList.Create();
      try
        FileContent.LoadFromFile(AFileName, TEncoding.UTF8);
        Lines := FileContent.Text.Split([sLineBreak], TStringSplitOptions.ExcludeEmpty);

        if Length(Lines) < 2 then // van legalább 2 sora (fejléc és 1 rekord)
        begin
          FProgressStatus := 'A fájl túl kevés sort tartalmaz.';
          Exit;
        end;

        Line := Lines[0]; // fejléc
        Parts.Delimiter := AFieldSeparator;
        Parts.StrictDelimiter := true;
        Parts.DelimitedText := Line;
        if Parts.Count < 11 then // meg van minden mezõ?
        begin
          FProgressStatus := 'Nincs elég mezõ.';
          Exit;
        end;
        for var i := 0 to Parts.Count-1 do
          Headers.Add(Trim(Parts[i]), i); // Mezõnév -> Index párok

        for var i := 1 to High(Lines) do
        begin
          Line := Lines[i];
          if Line = '' then Continue;
          Parts.DelimitedText := Line;

          if Parts.Count >= Headers.Count then  // Ellenõrizzük, hogy van-e elég oszlop
          begin
            try
              Person := TPerson.Create();
              Person.Inicialize(
                Parts[Headers['Vezeteknev']],
                Parts[Headers['Keresztnev']],
                Parts[Headers['SzemelyiAzon']],
                Parts[Headers['LakcimAzon']],
                Parts[Headers['CimTipus']],
                Parts[Headers['IranyitoSzam']],
                Parts[Headers['Telepules']],
                Parts[Headers['Utca']],
                Parts[Headers['Hazszam']],
                Parts[Headers['ElerhetosegTipus']],
                Parts[Headers['Elerhetoseg']]);
              FPersonList.Add(Person.Clone);
            except
              on E: Exception do
                FProgressStatus := 'Hiba a sor feldolgozása közben: ' + E.Message;
            end;
          end;
        end;
        SyncToClientDataSet;
        FProgressStatus := 'Betöltés kész.';
      finally
        Parts.Free;
      end;
    finally
      Headers.Free;
    end;
  finally
    FileContent.Free;
  end;
end;

procedure TPersonViewModel.ParseEnum<T>(sl: TStrings);
var
  rt: TRttiType;
  rot: TRttiOrdinalType;
  i: Integer;
begin
  rt := TRttiContext.Create.GetType(TypeInfo(T));
  rot := rt.AsOrdinal;
  for i := rot.MinValue to rot.MaxValue do
    sl.Add(GetEnumName(TypeInfo(T), i));
end;

procedure TPersonViewModel.SaveToDb;
begin
  // majd késõbb
end;

procedure TPersonViewModel.SyncToClientDataSet;
var Person: TPerson;
begin
  if FPersonList.Count < 1 then
    Exit;
  FClientDataSet.DisableControls;
  try
    FClientDataSet.EmptyDataSet;
    for Person in FPersonList do
    begin
      FClientDataSet.Append;
      FClientDataSet.FieldByName('Vezeteknev').AsString := Person.LastName;
      FClientDataSet.FieldByName('Keresztnev').AsString := Person.FirstName;
      FClientDataSet.FieldByName('SzemelyiAzon').AsString := Person.PersonIdentifier;
      FClientDataSet.FieldByName('LakcimAzon').AsString := Person.AddressId;
      FClientDataSet.FieldByName('CimTipus').AsString := Person.AddressType;
      FClientDataSet.FieldByName('IranyitoSzam').AsString := Person.Postcode;
      FClientDataSet.FieldByName('Telepules').AsString := Person.City;
      FClientDataSet.FieldByName('Utca').AsString := Person.Street;
      FClientDataSet.FieldByName('Hazszam').AsString := Person.HouseNumber;
      FClientDataSet.FieldByName('ElerhetosegTipus').AsString := Person.ContactType;
      FClientDataSet.FieldByName('Elerhetoseg').AsString := Person.Contact;
      FClientDataSet.Post;
    end;
  finally
    FClientDataSet.EnableControls;
  end;
end;

destructor TPersonViewModel.Destroy;
begin
  FClientDataSet.Free;
  FPersonList.Free;
  inherited;
end;

end.
