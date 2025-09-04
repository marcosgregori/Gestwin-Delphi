object BoxNotForm: TBoxNotForm
  Left = 269
  Top = 122
  BorderIcons = [biSystemMenu]
  Caption = 'Anotaciones'
  ClientHeight = 346
  ClientWidth = 653
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poMainFormCenter
  ShowHint = True
  OnKeyDown = FormKeyDown
  TextHeight = 17
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 310
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      653
      36)
    Height = 36
    Width = 653
    object Panel3: TcxGroupBox
      Left = 235
      Top = 0
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = True
      TabOrder = 0
      Height = 36
      Width = 183
      object OkButton: TgBitBtn
        AlignWithMargins = True
        Left = 2
        Top = 3
        Width = 85
        Height = 30
        Margins.Left = 0
        Margins.Top = 1
        Margins.Right = 6
        Margins.Bottom = 1
        Align = alLeft
        Caption = '&Aceptar'
        Enabled = True
        ModalResult = 1
        OptionsImage.ImageIndex = 2
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 0
        GlyphBitmap = gmOk
      end
      object CloseButton: TgBitBtn
        AlignWithMargins = True
        Left = 93
        Top = 3
        Width = 85
        Height = 30
        Margins.Left = 0
        Margins.Top = 1
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Cancel = True
        Caption = '&Cerrar'
        Enabled = True
        ModalResult = 2
        OptionsImage.ImageIndex = 7
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 1
        GlyphBitmap = gmClose
      end
    end
  end
  object DataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 5
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alClient
    PanelStyle.Active = True
    ParentBackground = False
    ParentColor = False
    ParentShowHint = False
    ShowHint = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 0
    PanelKind = epInputPanel
    Height = 305
    Width = 643
    inline AnnotationFrame: TAnnotationFrame
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 633
      Height = 295
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      ExplicitLeft = 5
      ExplicitTop = 5
      ExplicitWidth = 633
      ExplicitHeight = 295
      inherited AnnotationPanel: TcxGroupBox
        ExplicitWidth = 633
        ExplicitHeight = 263
        Height = 263
        Width = 633
        inherited AnnotationRichEdit: TcxDBRichEdit
          DataBinding.DataField = 'Memo'
          DataBinding.DataSource = DataSource
          ExplicitWidth = 629
          ExplicitHeight = 218
          Height = 218
          Width = 629
        end
        inherited Ruler: TfrxRuler
          Width = 629
          ExplicitWidth = 629
        end
      end
      inherited ButtonsBar: TcxGroupBox
        ExplicitWidth = 633
        Width = 633
        inherited FontNameComboBox: TcxFontNameComboBox
          ExplicitHeight = 28
        end
        inherited FontSizeComboBox: TcxComboBox
          ExplicitHeight = 28
        end
      end
    end
  end
  object MemData: TgxMemData
    Active = True
    Indexes = <>
    SortOptions = []
    Left = 564
    Top = 100
    object DataMemo: TWideMemoField
      FieldName = 'Memo'
      BlobType = ftWideMemo
    end
  end
  object DataSource: TDataSource
    DataSet = MemData
    Left = 532
    Top = 100
  end
  object FormManager: TgxFormManager
    FirstDataControl = AnnotationFrame.AnnotationRichEdit
    ShowQueryOption = False
    OnCreateForm = FormManagerCreateForm
    OnHideForm = FormManagerHideForm
    OnShowForm = FormManagerShowForm
    Left = 564
    Top = 136
  end
end
