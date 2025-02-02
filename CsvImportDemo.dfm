object frmMainForm: TfrmMainForm
  Left = 0
  Top = 0
  Caption = 'frmMainForm'
  ClientHeight = 455
  ClientWidth = 847
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    847
    455)
  TextHeight = 15
  object lblLastname: TLabel
    Left = 16
    Top = 16
    Width = 61
    Height = 15
    Caption = 'Vezet'#233'kn'#233'v:'
    FocusControl = edtLastname
  end
  object lblFirstname: TLabel
    Left = 16
    Top = 45
    Width = 59
    Height = 15
    Caption = 'Keresztn'#233'v:'
    FocusControl = edtFirstname
  end
  object lblPersonId: TLabel
    Left = 16
    Top = 74
    Width = 80
    Height = 15
    Caption = 'Szem'#233'lyi azon.:'
    FocusControl = edtPersonId
  end
  object lblAdrCardId: TLabel
    Left = 288
    Top = 16
    Width = 104
    Height = 15
    Caption = 'Lakc'#237'mk'#225'rtya azon.:'
    FocusControl = edtAdrCardId
  end
  object lblAdrType: TLabel
    Left = 288
    Top = 45
    Width = 73
    Height = 15
    Caption = 'Lakc'#237'm t'#237'pusa'
    FocusControl = cmbAdrType
  end
  object lblPostcode: TLabel
    Left = 17
    Top = 103
    Width = 70
    Height = 15
    Caption = 'Ir'#225'ny'#237't'#243'sz'#225'm:'
    FocusControl = edtPostcode
  end
  object lblCity: TLabel
    Left = 593
    Top = 16
    Width = 28
    Height = 15
    Caption = 'V'#225'ros'
    FocusControl = edtCity
  end
  object lblStreet: TLabel
    Left = 288
    Top = 75
    Width = 55
    Height = 15
    Caption = 'Utca neve:'
    FocusControl = edtStreer
  end
  object lblHouseNo: TLabel
    Left = 288
    Top = 103
    Width = 50
    Height = 15
    Caption = 'H'#225'zsz'#225'm:'
    FocusControl = edtHouseNo
  end
  object lblContactType: TLabel
    Left = 593
    Top = 45
    Width = 96
    Height = 15
    Caption = 'El'#233'rhet'#337's'#233'g t'#237'pusa'
    FocusControl = cmbContackType
  end
  object lblContact: TLabel
    Left = 593
    Top = 74
    Width = 55
    Height = 15
    Caption = 'Utca neve:'
    FocusControl = edtContact
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 132
    Width = 722
    Height = 298
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object btnLoadFromFile: TButton
    Left = 726
    Top = 216
    Width = 113
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Import data'
    TabOrder = 1
    OnClick = btnLoadFromFileClick
  end
  object btnInsertRow: TButton
    Left = 728
    Top = 101
    Width = 113
    Height = 25
    Caption = 'Add person'
    TabOrder = 2
    OnClick = btnInsertRowClick
  end
  object btnSave: TButton
    Left = 728
    Top = 361
    Width = 113
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Save data'
    TabOrder = 3
    OnClick = btnSaveClick
  end
  object btnDeleteRow: TButton
    Left = 728
    Top = 392
    Width = 113
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Delete person'
    TabOrder = 4
    OnClick = btnDeleteRowClick
  end
  object edtLastname: TEdit
    Left = 102
    Top = 13
    Width = 171
    Height = 23
    TabOrder = 5
    TextHint = 'vezet'#233'kn'#233'v'
  end
  object edtFirstname: TEdit
    Left = 102
    Top = 42
    Width = 171
    Height = 23
    TabOrder = 6
    TextHint = 'keresztn'#233'v'
  end
  object edtPersonId: TEdit
    Left = 102
    Top = 71
    Width = 171
    Height = 23
    TabOrder = 7
    TextHint = 'szem'#233'lyi igazolv'#225'ny azonons'#237't'#243
  end
  object edtAdrCardId: TEdit
    Left = 398
    Top = 13
    Width = 171
    Height = 23
    TabOrder = 8
    TextHint = 'lakc'#237'mk'#225'rtya sz'#225'ma'
  end
  object cmbAdrType: TComboBox
    Left = 398
    Top = 42
    Width = 171
    Height = 23
    TabOrder = 9
    TextHint = 'lakc'#237'm t'#237'pusa'
  end
  object edtPostcode: TEdit
    Left = 102
    Top = 100
    Width = 171
    Height = 23
    TabOrder = 10
    TextHint = 'Ir'#225'ny'#237't'#243'sz'#225'm'
  end
  object edtCity: TEdit
    Left = 695
    Top = 13
    Width = 146
    Height = 23
    TabOrder = 11
    TextHint = 'V'#225'ros'
  end
  object edtStreer: TEdit
    Left = 398
    Top = 72
    Width = 171
    Height = 23
    TabOrder = 12
    TextHint = 'utca neve'
  end
  object edtHouseNo: TEdit
    Left = 398
    Top = 100
    Width = 171
    Height = 23
    TabOrder = 13
    TextHint = 'h'#225'z sz'#225'ma'
  end
  object cmbContackType: TComboBox
    Left = 695
    Top = 42
    Width = 146
    Height = 23
    TabOrder = 14
    TextHint = 'el'#233'rhet'#337's'#233'g t'#237'pusa'
  end
  object edtContact: TEdit
    Left = 695
    Top = 72
    Width = 146
    Height = 23
    TabOrder = 15
    TextHint = 'el'#233'rhet'#337's'#233'g'
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 436
    Width = 847
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    ExplicitTop = 434
  end
  object DataSource1: TDataSource
    Left = 584
    Top = 376
  end
  object OpenDialog1: TOpenDialog
    Left = 272
    Top = 288
  end
end
