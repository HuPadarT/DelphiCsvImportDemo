program CsvImportDemoProject;

uses
  Vcl.Forms,
  CsvImportDemo in 'CsvImportDemo.pas' {frmMainForm},
  uViewModel in 'uViewModel.pas',
  uEnums in 'uEnums.pas',
  uPerson in 'uPerson.pas',
  uCustomDBProvider in 'uCustomDBProvider.pas',
  uFireBirdProvider in 'uFireBirdProvider.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMainForm, frmMainForm);
  Application.Run;
end.
