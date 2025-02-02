unit uFireBirdProvider;

interface

uses
  SysUtils, StrUtils, uCustomDBProvider, Generics.Collections, uPerson;

const
// mezõk: Id, LastName, FirstName, PersonCardId, AddressCardId, AddressType, Postcode, City, Street, HouseNumber, ContactType, Contact
  FB_SQL_SELECTRECORD     = 'SELECT * FROM Person';
  FB_SQL_GETRECORDBYID    = FB_SQL_SELECTRECORD + ' WHERE Id=:pId';
  FB_SQL_INSERT_RECORD    = 'INSERT INTO Person (LastName,FirstName,PersonCardId,AddressCardId,' +
          'AddressType,Postcode,City,Street,HouseNumber,ContactType,Contact) VALUES (:pLName,:pFName,' +
          ':pCId,:apAId,:pAddressType,:pPostcode,:pCity,:pStreet,:pHouseNumber,:pContactType,:pContact);';
  FB_SQL_UPDATE_RECORD    = 'UPDATE Person SET LastName=:pLName,FirstName=:pFName,PersonCardId=:pPcId,' +
    'AddressCardId=:pAdrCId,AddressType=:pAdrType,Postcode=:pPsCode,City=:pCity,Street=:pStr,' +
    'HouseNumber=:pHouseNo,ContactType=:pCntType,Contact=:pContract WHERE Id=:pId;';
  FB_SQL_DEL_RECORD       = 'DELETE FROM Person WHERE Id = :pid';
  FB_SQL_TABLE_ISEXISTS   = 'SELECT Count(9) FROM RDB$RELATIONS WHERE RDB$RELATIONS=:pTableName;';
  FB_SQL_CREATEAUTOINCGEN = 'CREATE GENERATOR GEN_PERSON_ID';
  FB_SQL_PERSON_SCHEME    = 'CREATE TABLE PERSON (ID INTEGER NOT NULL, ' +
      'LastName VARCHAR(50) NOT NULL, FirstName VARCHAR(50) NOT NULL, PersonCardId VARCHAR(15) NOT NULL,' +
      'AddressCardId VARCHAR(15) NOT NULL, AddressType VARCHAR(15) NOT NULL, Postcode VARCHAR(10), ' +
      'City VARCHAR(50), Street VARCHAR(250), HouseNumber VARCHAR(20), ContactType VARCHAR(250) NOT NULL, ' +
      'Contact VARCHAR(250), CONSTRAINT PK_PERSON PRIMARY KEY (ID))';
  FB_SQL_SETUPAUTOINC     = 'CREATE OR ALTER TRIGGER PERSON_BI FOR PERSON ' +
      'ACTIVE BEFORE INSERT POSITION 0 AS ' +
      'BEGIN ' +
      '  IF (NEW.ID IS NULL) THEN ' +
      '  NEW.ID = NEXT VALUE FOR GEN_PERSON_ID; ' +
      'END';

  FB_SQL_DBPROTOCOL       = 'FB';
  FB_DB_FILENAME          = 'DataDb.fdb';

type
  TFireBirdProvider = class(TCustomDBProvider)
  private
    function OpenDB(): boolean;
    function CloseDB(): boolean;
    function CreateDB(): boolean;
    procedure GetRecordCountFromDB;
    function ExistTable(ATableName: string): boolean;

  public
    constructor Create(Parent: TObject); override;
    destructor Destroy; override;

    function Initialize: boolean; override;

    procedure BeginTransaction; override;
    procedure CommitTransaction; override;
    procedure RollbackTransaction; override;
    function FetchRecords(): boolean; override;
    function GetOneRecord(const AId: Int64): TPerson; override;

  end;

implementation

{ TFireBirdProvider }

procedure TFireBirdProvider.BeginTransaction;
begin
  inherited;

end;

function TFireBirdProvider.CloseDB: boolean;
begin

end;

procedure TFireBirdProvider.CommitTransaction;
begin
  inherited;

end;

constructor TFireBirdProvider.Create(Parent: TObject);
begin
  inherited;

end;

function TFireBirdProvider.CreateDB: boolean;
begin

end;

destructor TFireBirdProvider.Destroy;
begin

  inherited;
end;

function TFireBirdProvider.ExistTable(ATableName: string): boolean;
begin

end;

function TFireBirdProvider.FetchRecords: boolean;
begin

end;

function TFireBirdProvider.GetOneRecord(const AId: Int64): TPerson;
begin

end;

procedure TFireBirdProvider.GetRecordCountFromDB;
begin

end;

function TFireBirdProvider.Initialize: boolean;
begin

end;

function TFireBirdProvider.OpenDB: boolean;
begin

end;

procedure TFireBirdProvider.RollbackTransaction;
begin
  inherited;

end;

end.
