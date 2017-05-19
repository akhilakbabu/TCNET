object FrmListTagNames: TFrmListTagNames
  Left = 0
  Top = 0
  Caption = 'Student Tags'
  ClientHeight = 575
  ClientWidth = 503
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  Position = poDesktopCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object btnEditTag: TButton
    Left = 383
    Top = 31
    Width = 64
    Height = 24
    Caption = '&Edit Tags'
    TabOrder = 0
    OnClick = btnEditTagClick
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 31
    Top = 74
    object EditTag: TMenuItem
      Caption = 'Edit Tag'
      HelpContext = 153
      Hint = 'Change or set code'
      ShortCut = 13
      OnClick = EditTagClick
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object Print2: TMenuItem
      Action = MainForm.MainPrint
    end
  end
end
