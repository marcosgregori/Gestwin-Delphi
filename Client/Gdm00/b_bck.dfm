object BoxBckForm: TBoxBckForm
  Left = 501
  Top = 313
  HelpType = htKeyword
  HelpKeyword = 'b_bck'
  HelpContext = 224
  ActiveControl = SiguienteButton
  BorderStyle = bsDialog
  Caption = 'COPIA DE SEGURIDAD'
  ClientHeight = 242
  ClientWidth = 568
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  HelpFile = 'hs00'
  Position = poMainFormCenter
  OnShow = FormShow
  TextHeight = 17
  object Panel1: TgxEditPanel
    Left = 0
    Top = 206
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epButtonsPanel
    Height = 36
    Width = 568
    object Panel3: TcxGroupBox
      Left = 143
      Top = 3
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 0
      Height = 30
      Width = 282
      object SiguienteButton: TgBitBtn
        AlignWithMargins = True
        Left = 94
        Top = 0
        Width = 90
        Height = 30
        Margins.Left = 4
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = '&Siguiente'
        Default = True
        Enabled = True
        OptionsImage.ImageIndex = 43
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 1
        OnClick = SiguienteButtonClick
        GlyphBitmap = gmRight
      end
      object CloseButton: TgBitBtn
        AlignWithMargins = True
        Left = 188
        Top = 0
        Width = 90
        Height = 30
        Margins.Left = 4
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Cancel = True
        Caption = '&Cerrar'
        Enabled = True
        ModalResult = 2
        OptionsImage.ImageIndex = 7
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 2
        OnClick = CloseButtonClick
        GlyphBitmap = gmClose
      end
      object AnteriorButton: TgBitBtn
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 90
        Height = 30
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = 'A&nterior'
        Enabled = False
        OptionsImage.ImageIndex = 42
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 0
        OnClick = AnteriorButtonClick
        GlyphBitmap = gmLeft
      end
    end
  end
  object Panel2: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 5
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alClient
    Alignment = alCenterCenter
    PanelStyle.Active = True
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 1
    PanelKind = epInputPanel
    Height = 201
    Width = 558
    object Image1: TcxImage
      Left = 7
      Top = 7
      TabStop = False
      ParentColor = True
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
        203C672069643D2269636F6E223E0D0A09093C673E0D0A0909093C7061746820
        643D224D31312C31302E3437333956372E313538344331302E303837352C372E
        303533372C392E303636382C372C372E393931382C37632D332E383335332C30
        2C2D362E393634332C302E363832372C2D362E393634332C312E393332356330
        2C302E3032362C2D302E303030322C302E303531372C302E303032352C302E30
        373733632D302E303031342C2D302E303032322C2D302E303034322C2D302E30
        3034342C2D302E303035362C2D302E3030363763302C302E313135322C302E30
        3135332C31302E383430382C302E303135332C31302E39323736632D302E3030
        30332C312E323739362C332E313235332C332E303637372C362E393630352C33
        2E3036373763302E303237392C302C2D302E313030332C302E303031332C302E
        303939372C302E303031325631302E3933393163312E303439372C2D302E3030
        332C322E303433332C2D302E303633312C322E393332362C2D302E3137343243
        31312E303131322C31302E363638392C31312C31302E353731342C31312C3130
        2E343733397A222066696C6C2D72756C653D226576656E6F6464222066696C6C
        3D2223464643453535222F3E0D0A0909093C7061746820643D224D31332E3634
        32372C3133632D302E333831312C302C2D302E3734352C2D302E313438382C2D
        312E303234372C2D302E343037366C2D312E313234362C2D312E30343036632D
        302E323937352C2D302E323735342C2D302E343732342C2D302E363434352C2D
        302E343839392C2D312E30313731632D302E393131392C302E313230322C2D31
        2E393235362C302E313836382C2D322E3938342C302E31383638632D302E3032
        352C302C2D302E313139342C2D302E303030322C2D302E313139342C2D302E30
        30303456323363342C2D302E303031332C362E393830332C2D312E373136392C
        372E303131332C2D332E3037333563302E303031342C2D302E303632312C302E
        3031372C2D332E3833332C302E303239342C2D362E393236354831332E363432
        377A222066696C6C2D72756C653D226576656E6F6464222066696C6C3D222346
        3642423433222F3E0D0A0909093C673E0D0A090909093C7061746820643D224D
        372E393833372C31312E3336333563312E323039322C302C322E3238312C2D30
        2E303735322C332E323032382C2D302E32303135632D302E313230332C2D302E
        323134372C2D302E313836352C2D302E343531342C2D302E313836352C2D302E
        36383831762D302E303239632D302E393131372C302E313239342C2D312E3932
        36372C302E3230362C2D322E393838342C302E323036632D332E353434372C30
        2C2D362E333734332C2D302E383431382C2D362E393538342C2D312E36343433
        632D302E303334372C302E303636312C2D302E303338362C302E373439322C2D
        302E303133392C302E3738333843312E373132362C31302E353336352C342E31
        3438342C31312E333633352C372E393833372C31312E333633357A222066696C
        6C3D222343313846333622206F7061636974793D22302E37222F3E0D0A090909
        093C7061746820643D224D372E393833372C31352E3534373663332E38333533
        2C302C362E323932342C2D312E303739392C362E393434342C2D312E38353832
        63302C2D302E303537382C302E303138352C2D302E343432382C302E30323032
        2C2D302E36383934682D302E31363734632D302E37362C302E383235322C2D33
        2E353532322C312E383034332C2D362E373639332C312E38303433632D332E35
        3434372C302C2D362E333734332C2D312E303935342C2D362E393538342C2D31
        2E39333235632D302E303334372C302E3036392C2D302E303338362C302E3738
        31352C2D302E303133392C302E3831373643312E373132362C31342E34363737
        2C342E313438342C31352E353437362C372E393833372C31352E353437367A22
        2066696C6C3D222343313846333622206F7061636974793D22302E37222F3E0D
        0A090909093C7061746820643D224D31342E393239332C31362E36373938632D
        302E343434322C302E393936322C2D332E343332362C322E323132352C2D362E
        393137372C322E32313235632D332E353434372C302C2D362E333734332C2D31
        2E323635322C2D362E393538342C2D322E32333736632D302E303334372C302E
        303830312C2D302E303338362C302E373735372C2D302E303133392C302E3831
        373663302E363733332C302E3930342C332E313039312C322E313633332C362E
        393434342C322E3136333363332E383335332C302C362E323932342C2D312E31
        3339382C362E393434342C2D322E303433384331342E393238312C31372E3438
        37322C31342E3937332C31362E353831362C31342E393239332C31362E363739
        387A222066696C6C3D222343313846333622206F7061636974793D22302E3722
        2F3E0D0A0909093C2F673E0D0A09093C2F673E0D0A09093C673E0D0A0909093C
        7061746820643D224D31322E363630372C314832322E333463302E333634352C
        302C302E36362C302E323935352C302E36362C302E363676392E363637366330
        2C302E333634352C2D302E323935352C302E36362C2D302E36362C302E363668
        2D382E36393734632D302E313238312C302C2D302E323531362C2D302E303438
        332C2D302E333435362C2D302E313335346C2D312E313235322C2D312E303338
        34632D302E303934372C2D302E303837362C2D302E313731322C2D302E323130
        382C2D302E313731322C2D302E3333393856312E36364331322E303030372C31
        2E3239372C31322E323937372C312C31322E363630372C317A222066696C6C3D
        2223344238394443222F3E0D0A0909093C7061746820643D224D31352E313936
        352C372E3933333868352E3139343463302E353239372C302C302E393539322C
        302E343239342C302E393539322C302E3935393276332E31303534682D372E31
        35333656382E393333384331342E313936352C382E333831352C31342E363434
        322C372E393333382C31352E313936352C372E393333387A222066696C6C3D22
        23334437334144222F3E0D0A0909093C7061746820643D224D31352E32303036
        2C372E3933333868332E3536333263302E353137322C302C302E393336352C30
        2E343139332C302E393336352C302E3933363576332E31323831682D352E3439
        393656382E393333384331342E323030362C382E333831352C31342E36343833
        2C372E393333382C31352E323030362C372E393333387A222066696C6C3D2223
        434344304439222F3E0D0A0909093C7061746820643D224D31342E313130362C
        3168362E3933393563302E313635372C302C302E332C302E313334332C302E33
        2C302E3376342E3339383963302C302E343431382C2D302E333538322C302E38
        2C2D302E382C302E38682D362E30393935632D302E343431382C302C2D302E38
        2C2D302E333538322C2D302E382C2D302E3856312E34364331332E363530362C
        312E323035392C31332E383536362C312C31342E313130362C317A222066696C
        6C3D2223453645394545222F3E0D0A0909093C7061746820643D224D31352E36
        3037332C382E3331333868312E3033363463302E313639342C302C302E333036
        382C302E313337332C302E333036382C302E3330363876322E3739363363302C
        302E313639342C2D302E313337332C302E333036382C2D302E333036382C302E
        33303638682D312E30333634632D302E313639342C302C2D302E333036382C2D
        302E313337332C2D302E333036382C2D302E3330363856382E36323035433135
        2E333030352C382E343531312C31352E343337382C382E333133382C31352E36
        3037332C382E333133387A222066696C6C3D2223363536443738222F3E0D0A09
        09093C7061746820643D224D31352E303235352C342E32393968342E38393437
        63302E313531392C302C302E3237352C302E313233312C302E3237352C302E32
        3735763063302C302E313531392C2D302E313233312C302E3237352C2D302E32
        37352C302E323735682D342E38393437632D302E313531392C302C2D302E3237
        352C2D302E313233312C2D302E3237352C2D302E32373576304331342E373530
        352C342E343232312C31342E383733372C342E3239392C31352E303235352C34
        2E3239397A4D31342E373530352C322E393234314C31342E373530352C322E39
        32343163302C302E313531392C302E313233312C302E3237352C302E3237352C
        302E32373568342E3839343763302E313531392C302C302E3237352C2D302E31
        3233312C302E3237352C2D302E323735763063302C2D302E313531392C2D302E
        313233312C2D302E3237352C2D302E3237352C2D302E323735682D342E383934
        374331342E383733372C322E363439312C31342E373530352C322E373732322C
        31342E373530352C322E393234317A222066696C6C3D22233533363838302220
        6F7061636974793D22302E37222F3E0D0A09093C2F673E0D0A09093C70617468
        20643D224D32332C31362E3630393463302C2D302E303838352C2D302E303334
        332C2D302E313731352C2D302E303936362C2D302E323333386C2D322E343431
        342C2D322E34343937632D302E303632332C2D302E303632342C2D302E313435
        342C2D302E303936372C2D302E3233342C2D302E30393637632D302E30383835
        2C302C2D302E313731362C302E303334332C2D302E323333392C302E30393636
        6C2D302E343839342C302E343839346C2D312E393031392C312E39363135632D
        302E303631322C302E303631322C2D302E303935352C302E313434322C2D302E
        303935352C302E3233323863302C302E303838352C302E303334332C302E3137
        31352C302E303936362C302E323333386C302E343839342C302E343839346330
        2E303631322C302E303631322C302E313338362C302E303939352C302E323137
        362C302E3130373663302E303839372C302E303039322C302E313939332C2D30
        2E303230382C302E3236332C2D302E303834364C31392E362C31362E33303933
        76312E3033323563302C312E3730342C2D302E353836372C322E323538322C2D
        322E313736392C322E323538324831362E323834632D302E313532342C302C2D
        302E3238342C302E313034382C2D302E3238342C302E3530343376302E343732
        3563302C302E323934372C302E303630372C302E343233322C302E323739342C
        302E3432333268312E313433384331392E373633332C32312C32312C31392E37
        3833312C32312C31372E33343138762D312E303335376C302E393936312C312E
        3034383663302E303634382C302E303634382C302E313334362C302E30393438
        2C302E323230332C302E3038353463302E303735342C2D302E303038322C302E
        313431382C2D302E303435342C302E323033382C2D302E313037356C302E3438
        36332C2D302E343839344332322E393638392C31362E3738312C32332C31362E
        363937392C32332C31362E363039347A222066696C6C3D222344423434353322
        2F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
      Properties.FitMode = ifmProportionalStretch
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Transparent = True
      Height = 52
      Width = 48
    end
    object PageControl: TcxPageControl
      Left = 61
      Top = 2
      Width = 495
      Height = 197
      Align = alRight
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 0
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      Properties.HideTabs = True
      Properties.Options = [pcoGoDialog, pcoRedrawOnResize]
      LookAndFeel.Kind = lfUltraFlat
      LookAndFeel.NativeStyle = False
      OnChange = PageControlChange
      ClientRectBottom = 197
      ClientRectRight = 495
      ClientRectTop = 0
      object TabSheet1: TcxTabSheet
        TabVisible = False
        object cxGroupBox1: TcxGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 3
          Align = alClient
          Caption = 'Proceso de COPIA DE SEGURIDAD concurrente'
          PanelStyle.Active = True
          ParentFont = False
          Style.BorderStyle = ebsNone
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = -13
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = [fsBold]
          Style.IsFontAssigned = True
          TabOrder = 0
          Height = 191
          Width = 489
          object cxLabel1: TcxLabel
            AlignWithMargins = True
            Left = 10
            Top = 81
            Margins.Left = 8
            Margins.Top = 0
            Margins.Bottom = 0
            TabStop = False
            Align = alTop
            Caption = 
              'Se realiza una copia primaria en el subdirectorio Backup de la a' +
              'plicaci'#243'n (por ejemplo C:\Gestwin\Backup) y una segunda copia en' +
              ' la ubicaci'#243'n seleccionada a continuaci'#243'n.'
            Style.TextStyle = []
            Properties.WordWrap = True
            TabOrder = 0
            Transparent = True
            Width = 474
          end
          object cxLabel2: TcxLabel
            AlignWithMargins = True
            Left = 10
            Top = 26
            Margins.Left = 8
            Margins.Top = 24
            Margins.Bottom = 0
            TabStop = False
            Align = alTop
            Caption = 
              'Este proceso permite realizar una copia de todos los ficheros de' +
              ' datos en cualquier ubicaci'#243'n accesible desde su equipo aunque H' +
              'AYAN OTROS USUARIOS CONECTADOS Y TRABAJANDO con la aplicaci'#243'n.'
            Style.TextStyle = []
            Properties.WordWrap = True
            TabOrder = 1
            Transparent = True
            Width = 474
          end
        end
      end
      object TabSheet2: TcxTabSheet
        Caption = 'TabSheet2'
        ImageIndex = 0
        TabVisible = False
        object cxGroupBox2: TcxGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 3
          Align = alClient
          Caption = 'Opciones de copia'
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 0
          DesignSize = (
            489
            191)
          Height = 191
          Width = 489
          object TodoCheckBox: TcxCheckBox
            Left = 10
            Top = 28
            Caption = ' Copiar los datos de todas las Empresas existentes'
            State = cbsChecked
            TabOrder = 0
            Transparent = True
          end
          object DestinoTextEdit: TcxTextEdit
            Left = 32
            Top = 78
            Anchors = [akLeft, akTop, akRight]
            Properties.OnEnter = DestinoTextEditPropertiesEnter
            Properties.MaxLength = 128
            TabOrder = 2
            Width = 350
          end
          object ExaminarButton: TgBitBtn
            Left = 388
            Top = 74
            Width = 94
            Height = 31
            Anchors = [akTop, akRight]
            Caption = 'E&xaminar'
            Enabled = True
            OptionsImage.ImageIndex = 21
            OptionsImage.Images = ApplicationContainer.ButtonImageList
            OptionsImage.Margin = 4
            OptionsImage.Spacing = 5
            TabOrder = 3
            OnClick = ExaminarButtonClick
            GlyphBitmap = gmFolder
          end
          object EnviarFicherosCheckBox: TcxCheckBox
            Left = 10
            Top = 50
            Caption = ' Enviar los ficheros copiados a ...'
            Properties.OnChange = EnviarFicherosCtrlPropertiesChange
            State = cbsChecked
            TabOrder = 1
            Transparent = True
          end
        end
      end
      object TabSheet3: TcxTabSheet
        TabVisible = False
        object BackupProgressBar: TcxProgressBar
          Left = 10
          Top = 39
          Properties.BarStyle = cxbsGradient
          Properties.BeginColor = 15448477
          Properties.EndColor = 8404992
          Properties.PeakValue = 100.000000000000000000
          Properties.SolidTextColor = True
          Style.LookAndFeel.NativeStyle = True
          StyleDisabled.LookAndFeel.NativeStyle = True
          StyleFocused.LookAndFeel.NativeStyle = True
          StyleHot.LookAndFeel.NativeStyle = True
          TabOrder = 0
          Width = 431
        end
        object TableProgressBar: TcxProgressBar
          Left = 10
          Top = 93
          Properties.BarStyle = cxbsGradient
          Properties.BeginColor = 15448477
          Properties.EndColor = 8404992
          Properties.PeakValue = 100.000000000000000000
          Properties.SolidTextColor = True
          Style.LookAndFeel.NativeStyle = True
          StyleDisabled.LookAndFeel.NativeStyle = True
          StyleFocused.LookAndFeel.NativeStyle = True
          StyleHot.LookAndFeel.NativeStyle = True
          TabOrder = 1
          Width = 431
        end
        object PassLabel: TcxLabel
          Left = 453
          Top = 2
          TabStop = False
          AutoSize = False
          Caption = '1'
          ParentFont = False
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clGray
          Style.Font.Height = -48
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = [fsBold]
          Style.TextColor = clScrollBar
          Style.IsFontAssigned = True
          Properties.Alignment.Horz = taCenter
          Properties.Alignment.Vert = taVCenter
          TabOrder = 2
          Transparent = True
          Height = 51
          Width = 33
          AnchorX = 470
          AnchorY = 28
        end
        object Label9: TcxLabel
          Left = 16
          Top = 68
          TabStop = False
          Caption = 'Copiando el fichero ...'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 3
          Transparent = True
        end
        object FicheroLabel: TcxLabel
          Left = 150
          Top = 68
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 4
          Transparent = True
          Height = 19
          Width = 291
        end
        object Label2: TcxLabel
          Left = 16
          Top = 15
          TabStop = False
          Caption = 'Procesando ...'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 5
          Transparent = True
        end
        object ProcesoLabel: TcxLabel
          Left = 150
          Top = 15
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 6
          Transparent = True
          Height = 17
          Width = 291
        end
      end
    end
  end
  object BackupDatabase: TnxDatabase
    Left = 15
    Top = 144
  end
  object EmpresaTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'Empresa'
    IndexFieldNames = 'Codigo'
    Left = 45
    Top = 144
    object EmpresaTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 3
    end
    object EmpresaTableDataPath: TWideStringField
      FieldName = 'DataPath'
      Size = 127
    end
  end
  object BackupController: TnxBackupController
    OnIncludeTable = BackupControllerIncludeTable
    OnTableProgress = BackupControllerTableProgress
    KeepIndexes = True
    Options = [bcoCloseInactiveOnTarget]
    SourceThreadPriority = NORMAL
    TargetThreadPriority = NORMAL
    SkippedTablesCount = 0
    UseLZCompression = False
    Left = 15
    Top = 108
  end
  object ZipForge: TZipForge
    ExtractCorruptedFiles = False
    CompressionLevel = clNormal
    CompressionMode = 6
    CurrentVersion = '6.93 '
    SpanningMode = smNone
    SpanningOptions.AdvancedNaming = True
    SpanningOptions.FirstVolumeSize = 0
    SpanningOptions.VolumeSize = vsAutoDetect
    SpanningOptions.CustomVolumeSize = 65536
    Options.FlushBuffers = True
    Options.OEMFileNames = True
    InMemory = False
    OnOverallProgress = ZipForgeOverallProgress
    Zip64Mode = zmAuto
    UnicodeFilenames = True
    EncryptionMethod = caPkzipClassic
    Left = 14
    Top = 74
  end
end
