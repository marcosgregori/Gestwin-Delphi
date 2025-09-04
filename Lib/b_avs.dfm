object avisoForm: TavisoForm
  Left = 488
  Top = 350
  HelpType = htKeyword
  HelpKeyword = 'b_not'
  ActiveControl = CloseButton
  Caption = 'AVISO'
  ClientHeight = 281
  ClientWidth = 618
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  HelpFile = 'hs00'
  Position = poScreenCenter
  TextHeight = 15
  object ButtonPanel: TdxPanel
    Left = 516
    Top = 0
    Width = 102
    Height = 281
    Align = alRight
    Frame.Visible = False
    TabOrder = 0
    object CloseButton: TgBitBtn
      Left = 1
      Top = 5
      Width = 94
      Height = 30
      Cancel = True
      Caption = '&Cerrar'
      Enabled = True
      ModalResult = 1
      OptionsImage.ImageIndex = 7
      OptionsImage.Images = ApplicationContainer.ButtonImageList
      OptionsImage.Margin = 4
      OptionsImage.Spacing = 5
      TabOrder = 0
      GlyphBitmap = gmClose
    end
  end
  object DataScreen: TdxPanel
    AlignWithMargins = True
    Left = 5
    Top = 5
    Width = 506
    Height = 271
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    Frame.Visible = False
    TabOrder = 1
    object Panel1: TdxPanel
      Left = 0
      Top = 0
      Width = 42
      Height = 271
      Align = alLeft
      Frame.Visible = False
      TabOrder = 0
      object Image: TcxImage
        Left = 2
        Top = 4
        Picture.Data = {
          0D546478536D617274496D6167653C3F786D6C2076657273696F6E3D22312E30
          2220656E636F64696E673D225554462D38223F3E0D0A3C737667207665727369
          6F6E3D22312E31222069643D224C617965725F312220786D6C6E733D22687474
          703A2F2F7777772E77332E6F72672F323030302F7376672220786D6C6E733A78
          6C696E6B3D22687474703A2F2F7777772E77332E6F72672F313939392F786C69
          6E6B2220783D223070782220793D22307078222077696474683D223234707822
          206865696768743D2232347078222076696577426F783D223020302032342032
          342220656E61626C652D6261636B67726F756E643D226E657720302030203234
          2032342220786D6C3A73706163653D227072657365727665223E262331303B20
          203C672069643D2269636F6E2220786D6C3A73706163653D2270726573657276
          65223E262331333B262331303B3C7061746820643D224D31302E353730372C32
          2E383437324C312E343335392C31382E3433393443302E373731362C31392E35
          3733322C312E353839332C32312C322E393033342C32314832312E3137336331
          2E333134312C302C322E313331382C2D312E343236382C312E343637352C2D32
          2E353630364C31332E353035382C322E383437324331322E383438382C312E37
          3235382C31312E323237372C312E373235382C31302E353730372C322E383437
          327A222066696C6C3D2223464643453535222F3E0D0A3C7061746820643D224D
          32322E363430362C31382E343339344C31332E353035372C322E38343732632D
          302E333335392C2D302E353733332C2D302E393233362C2D302E383532372C2D
          312E353035372C2D302E3833393956323168392E3137334332322E343837312C
          32312C32332E333034382C31392E353733322C32322E363430362C31382E3433
          39347A222066696C6C3D2223463642423433222F3E0D0A3C7061746820643D22
          4D31322E362C31342E36682D312E32632D302E32322C302C2D302E342C2D302E
          31382C2D302E342C2D302E3456372E3463302C2D302E32322C302E31382C2D30
          2E342C302E342C2D302E3468312E3263302E32322C302C302E342C302E31382C
          302E342C302E3476362E384331332C31342E34322C31322E38322C31342E362C
          31322E362C31342E367A4D31332C31372E36762D312E3263302C2D302E32322C
          2D302E31382C2D302E342C2D302E342C2D302E34682D312E32632D302E32322C
          302C2D302E342C302E31382C2D302E342C302E3476312E3263302C302E32322C
          302E31382C302E342C302E342C302E3468312E324331322E38322C31382C3133
          2C31372E38322C31332C31372E367A222066696C6C3D2223353336383830222F
          3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
        Properties.FitMode = ifmProportionalStretch
        Properties.ShowFocusRect = False
        Style.BorderStyle = ebsNone
        Style.HotTrack = False
        TabOrder = 0
        Transparent = True
        Height = 36
        Width = 36
      end
    end
    object Panel2: TdxPanel
      Left = 42
      Top = 0
      Width = 464
      Height = 271
      Align = alClient
      Frame.Visible = False
      TabOrder = 1
      ExplicitLeft = 39
      ExplicitWidth = 467
      object AnnotationRichEdit: TcxDBRichEdit
        Left = 0
        Top = 0
        Align = alClient
        DataBinding.DataField = 'Memo'
        DataBinding.DataSource = DataSource
        ParentFont = False
        Properties.ReadOnly = True
        Properties.ScrollBars = ssBoth
        Properties.WantReturns = False
        Style.BorderStyle = ebsSingle
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.HotTrack = False
        Style.ReadOnly = True
        Style.IsFontAssigned = True
        StyleDisabled.BorderColor = clWindowFrame
        StyleDisabled.Color = clWindow
        StyleReadOnly.Color = clWindow
        TabOrder = 0
        ExplicitLeft = 2
        ExplicitTop = 43
        ExplicitWidth = 467
        Height = 271
        Width = 464
      end
    end
  end
  object FormManager: TgxFormManager
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnCreateForm = FormManagerCreateForm
    OnDestroyForm = FormManagerDestroyForm
    Left = 586
    Top = 88
  end
  object DataSource: TDataSource
    DataSet = MemData
    Left = 522
    Top = 88
  end
  object MemData: TgxMemData
    Active = True
    Indexes = <>
    SortOptions = []
    Left = 554
    Top = 88
    object DataMemo: TWideMemoField
      FieldName = 'Memo'
      BlobType = ftWideMemo
    end
  end
end
