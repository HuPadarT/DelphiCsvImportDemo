unit CsvImportDemo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  uViewModel;

type
  TfrmMainForm = class(TForm)
    lblLastname: TLabel;
    lblFirstname: TLabel;
    lblPersonId: TLabel;
    lblAdrCardId: TLabel;
    lblAdrType: TLabel;
    lblPostcode: TLabel;
    lblCity: TLabel;
    lblStreet: TLabel;
    lblHouseNo: TLabel;
    lblContactType: TLabel;
    lblContact: TLabel;
    DBGrid1: TDBGrid;
    btnLoadFromFile: TButton;
    btnInsertRow: TButton;
    btnSave: TButton;
    btnDeleteRow: TButton;
    edtLastname: TEdit;
    edtFirstname: TEdit;
    edtPersonId: TEdit;
    edtAdrCardId: TEdit;
    cmbAdrType: TComboBox;
    edtPostcode: TEdit;
    edtCity: TEdit;
    edtStreer: TEdit;
    edtHouseNo: TEdit;
    cmbContackType: TComboBox;
    edtContact: TEdit;
    DataSource1: TDataSource;
    OpenDialog1: TOpenDialog;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnInsertRowClick(Sender: TObject);
    procedure btnDeleteRowClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnLoadFromFileClick(Sender: TObject);
  private
    { Private declarations }
    FViewModel: TPersonViewModel;
  public
    { Public declarations }
  end;

var
  frmMainForm: TfrmMainForm;

implementation

uses uEnums;
{$R *.dfm}

procedure TfrmMainForm.btnDeleteRowClick(Sender: TObject);
var s: string;
begin
  s := DBGrid1.DataSource.DataSet.FieldByName('SzemelyiAzon').AsString;
  FViewModel.DeletePerson(s);
end;

procedure TfrmMainForm.btnInsertRowClick(Sender: TObject);
begin
  if Length(edtLastname.Text) < 1 then
    ShowMessage('A vezetéknév nem lehet üres!')
  else if Length(edtFirstname.Text) < 1 then
    ShowMessage('A keresztnév nem lehet üres!')
  else if Length(edtPersonId.Text) < 1 then
    ShowMessage('A személyi igazolvány azonosító nem lehet üres!')
  else if Length(edtAdrCardId.Text) < 1 then
    ShowMessage('A lakcímkártya azonosító nem lehet üres!')
  else
  begin
    FViewModel.AddPerson(edtLastname.Text, edtFirstname.Text, edtPersonId.Text, edtAdrCardId.Text, cmbAdrType.Items[cmbAdrType.ItemIndex],
      edtPostcode.Text, edtCity.Text, edtStreer.Text, edtHouseNo.Text, cmbContackType.Items[cmbContackType.ItemIndex], edtContact.Text);
    StatusBar1.Panels[0].Text := FViewModel.StatusMessage;
  end;

end;

procedure TfrmMainForm.btnLoadFromFileClick(Sender: TObject);
begin
  OpenDialog1.Filter := 'CSV (*.csv)|*.csv';
  if OpenDialog1.Execute then
  begin
    if FileExists(OpenDialog1.FileName) then
    begin
      FViewModel.LoadFromCSV(OpenDialog1.FileName, ';');
    end
    else
    begin
      ShowMessage('A fájl nem létezik!');
    end;
  end;
end;

procedure TfrmMainForm.btnSaveClick(Sender: TObject);
begin
  FViewModel.SaveToDB;
  StatusBar1.Panels[0].Text := FViewModel.StatusMessage;
end;

procedure TfrmMainForm.FormCreate(Sender: TObject);
begin
  FViewModel := TPersonViewModel.Create;
  DataSource1.DataSet := FViewModel.ClientDataSet;
  DBGrid1.DataSource := DataSource1;
  FViewModel.ParseEnum<TAddressTypeEnum>(cmbAdrType.Items);
  FViewModel.ParseEnum<TContactTypeEnum>(cmbContackType.Items);
  StatusBar1.Panels[0].Text := 'Adjon hozzá személyeket, vagy kattintson az import gombra.';
end;

procedure TfrmMainForm.FormDestroy(Sender: TObject);
begin
  FViewModel.Free;
end;

end.
