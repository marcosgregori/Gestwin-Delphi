object MntPdcForm: TMntPdcForm
  Left = 450
  Top = 318
  HelpType = htKeyword
  HelpKeyword = 'a_pdc'
  BorderStyle = bsDialog
  Caption = 'Personas de contacto'
  ClientHeight = 388
  ClientWidth = 735
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs80'
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 17
  object KeyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    ExplicitTop = -1
    DesignSize = (
      735
      36)
    Height = 36
    Width = 735
    object CodigoCtrl: TcxDBTextEdit
      Left = 110
      Top = 6
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = ClienteDataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      TabOrder = 0
      Width = 46
    end
    object NombreClienteLabel: TcxDBLabel
      Left = 175
      Top = 7
      TabStop = False
      DataBinding.DataField = 'Nombre'
      DataBinding.DataSource = ClienteDataSource
      Transparent = True
      Height = 19
      Width = 299
    end
    object Label10: TcxLabel
      Left = 14
      Top = 9
      TabStop = False
      Caption = 'Cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 352
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      735
      36)
    Height = 36
    Width = 735
    object Panel3: TcxGroupBox
      Left = 279
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 174
      object OkButton: TgBitBtn
        Left = 1
        Top = 1
        Width = 85
        Height = 28
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
        Left = 88
        Top = 1
        Width = 85
        Height = 28
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
    object Time1Label: TcxLabel
      Left = 14
      Top = 8
      TabStop = False
      AutoSize = False
      Caption = '0'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taRightJustify
      Transparent = True
      Height = 19
      Width = 53
      AnchorX = 67
    end
    object Time2Label: TcxLabel
      Left = 86
      Top = 8
      TabStop = False
      AutoSize = False
      Caption = '0'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taRightJustify
      Transparent = True
      Height = 19
      Width = 53
      AnchorX = 139
    end
  end
  object DataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 36
    Margins.Left = 5
    Margins.Top = 0
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alClient
    Alignment = alCenterCenter
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 1
    PanelKind = epDataPanel
    ExplicitTop = 29
    ExplicitHeight = 326
    Height = 316
    Width = 725
    object DBCtrlGrid1: TDBCtrlGrid
      Left = 2
      Top = 2
      Width = 689
      Height = 312
      Align = alClient
      DataSource = PersonaContactoDataSource
      PanelHeight = 104
      PanelWidth = 672
      TabOrder = 0
      OnKeyDown = DBCtrlGrid1KeyDown
      ExplicitHeight = 322
      object cxDBTextEdit1: TcxDBTextEdit
        Left = 106
        Top = 10
        DataBinding.DataField = 'Nombre'
        DataBinding.DataSource = PersonaContactoDataSource
        TabOrder = 0
        Width = 389
      end
      object cxDBLabel1: TcxDBLabel
        Left = 5
        Top = 3
        TabStop = False
        DataBinding.DataField = 'NroRegistro'
        DataBinding.DataSource = PersonaContactoDataSource
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = -20
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.TextColor = clBtnShadow
        Style.IsFontAssigned = True
        Height = 28
        Width = 23
      end
      object cxLabel1: TcxLabel
        Left = 34
        Top = 13
        TabStop = False
        Caption = 'Nombre'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object cxLabel2: TcxLabel
        Left = 34
        Top = 40
        TabStop = False
        Caption = 'Asignado a'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object cxDBTextEdit2: TcxDBTextEdit
        Left = 106
        Top = 37
        DescriptionLabel = DescAsignadoLabel
        DataBinding.DataField = 'AsignadoA'
        DataBinding.DataSource = PersonaContactoDataSource
        Properties.Required = True
        Properties.TextEditPad = tpLeftZero
        Properties.PadAlways = True
        Properties.OnValidate = cxDBTextEdit2PropertiesValidate
        TabOrder = 4
        Width = 29
      end
      object DescAsignadoLabel: TcxLabel
        Left = 150
        Top = 40
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 19
        Width = 293
      end
    end
    object Panel1: TcxGroupBox
      Left = 691
      Top = 2
      Align = alRight
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      ExplicitLeft = 693
      Height = 312
      Width = 32
      object AñadirContactoButton: TcxButton
        Left = 2
        Top = 2
        Width = 28
        Height = 29
        Align = alTop
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.Data = {
          3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
          462D38223F3E0D0A3C73766720786D6C6E733A64633D22687474703A2F2F7075
          726C2E6F72672F64632F656C656D656E74732F312E312F2220786D6C6E733A63
          633D22687474703A2F2F6372656174697665636F6D6D6F6E732E6F72672F6E73
          232220786D6C6E733A7264663D22687474703A2F2F7777772E77332E6F72672F
          313939392F30322F32322D7264662D73796E7461782D6E73232220786D6C6E73
          3A7376673D22687474703A2F2F7777772E77332E6F72672F323030302F737667
          2220786D6C6E733D22687474703A2F2F7777772E77332E6F72672F323030302F
          7376672220786D6C6E733A736F6469706F64693D22687474703A2F2F736F6469
          706F64692E736F75726365666F7267652E6E65742F4454442F736F6469706F64
          692D302E6474642220786D6C6E733A696E6B73636170653D22687474703A2F2F
          7777772E696E6B73636170652E6F72672F6E616D657370616365732F696E6B73
          63617065222076657273696F6E3D22312E31222069643D224C617965725F3122
          20783D223070782220793D22307078222077696474683D223136222068656967
          68743D223136222076696577426F783D223020302031362031362220656E6162
          6C652D6261636B67726F756E643D226E6577203020302032342032342220736F
          6469706F64693A646F636E616D653D2273796D626F6C2D6164642E7376672220
          696E6B73636170653A76657273696F6E3D22302E39322E322028356333653830
          642C20323031372D30382D303629223E0D0A093C6D657461646174612069643D
          226D6574616461746131393734223E0D0A09093C7264663A5244463E0D0A0909
          093C63633A576F726B207264663A61626F75743D22223E0D0A090909093C6463
          3A666F726D61743E696D6167652F7376672B786D6C3C2F64633A666F726D6174
          3E0D0A090909093C64633A74797065207264663A7265736F757263653D226874
          74703A2F2F7075726C2E6F72672F64632F64636D69747970652F5374696C6C49
          6D616765222F3E0D0A090909093C64633A7469746C652F3E0D0A0909093C2F63
          633A576F726B3E0D0A09093C2F7264663A5244463E0D0A093C2F6D6574616461
          74613E0D0A093C646566732069643D226465667331393732222F3E0D0A093C73
          6F6469706F64693A6E616D6564766965772070616765636F6C6F723D22236666
          666666662220626F72646572636F6C6F723D22233636363636362220626F7264
          65726F7061636974793D223122206F626A656374746F6C6572616E63653D2231
          30222067726964746F6C6572616E63653D22313022206775696465746F6C6572
          616E63653D2231302220696E6B73636170653A706167656F7061636974793D22
          302220696E6B73636170653A70616765736861646F773D22322220696E6B7363
          6170653A77696E646F772D77696474683D22313330362220696E6B7363617065
          3A77696E646F772D6865696768743D22383739222069643D226E616D65647669
          657731393730222073686F77677269643D2266616C73652220696E6B73636170
          653A7A6F6F6D3D22392E383333333333332220696E6B73636170653A63783D22
          31322220696E6B73636170653A63793D2231322220696E6B73636170653A7769
          6E646F772D783D22302220696E6B73636170653A77696E646F772D793D223522
          20696E6B73636170653A77696E646F772D6D6178696D697A65643D2230222069
          6E6B73636170653A63757272656E742D6C617965723D224C617965725F31222F
          3E0D0A093C67207472616E73666F726D3D226D617472697828302E3733363834
          3231312C302C302C302E37333638343231312C2D312E313736363237392C2D30
          2E393930313837363429222069643D2269636F6E2D32223E0D0A09093C706174
          6820643D224D2032312E342C31312048203134205620332E3620432031342C33
          2E32372031332E37332C332031332E342C3320482031312E3620432031312E32
          372C332031312C332E32372031312C332E362056203131204820332E36204320
          332E32372C313120332C31312E323720332C31312E36207620312E3820432033
          2C31332E373320332E32372C313420332E362C31342048203131207620372E34
          206320302C302E333320302E32372C302E3620302E362C302E36206820312E38
          20432031332E37332C32322031342C32312E37332031342C32312E3420562031
          34206820372E3420432032312E37332C31342032322C31332E37332032322C31
          332E3420562031312E3620432032322C31312E32372032312E37332C31312032
          312E342C3131205A222069643D2270617468333735372220696E6B7363617065
          3A636F6E6E6563746F722D6375727661747572653D223022207374796C653D22
          66696C6C3A23333662633962222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
        SpeedButtonOptions.Flat = True
        SpeedButtonOptions.Transparent = True
        TabOrder = 0
        OnClick = AñadirContactoButtonClick
      end
    end
  end
  object ClienteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 15000
    TableName = 'Cliente'
    IndexFieldNames = 'Codigo'
    CanInsert = False
    CanModify = False
    Left = 544
    Top = 2
    object ClienteTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 5
    end
    object ClienteTableNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
    object ClienteTableVendedor: TWideStringField
      FieldName = 'Vendedor'
      Size = 2
    end
  end
  object FormManager: TgxFormManager
    Dataset = ClienteTable
    Model = fmEditForm
    
    FirstKeyControl = CodigoCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    Left = 576
    Top = 2
  end
  object ClienteDataSource: TDataSource
    DataSet = ClienteTable
    Left = 508
    Top = 2
  end
  object PersonaContactoDataSource: TDataSource
    DataSet = PersonaContactoTable
    Left = 518
    Top = 74
  end
  object PersonaContactoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 15000
    BeforeInsert = PersonaContactoTableBeforeInsert
    AfterInsert = PersonaContactoTableAfterInsert
    TableName = 'PersonaContacto'
    IndexFieldNames = 'Tipo;Propietario;NroRegistro'
    MasterSource = ClienteDataSource
    AutoIncFieldName = 'NroRegistro'
    CanInsert = False
    CanModify = False
    MasterRelation = mrBalanced
    Left = 552
    Top = 74
    object PersonaContactoTableTipo: TSmallintField
      FieldName = 'Tipo'
      Required = True
    end
    object PersonaContactoTablePropietario: TWideStringField
      FieldName = 'Propietario'
      Required = True
      Size = 5
    end
    object PersonaContactoTableNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
      Required = True
    end
    object PersonaContactoTableNombre: TWideStringField
      FieldName = 'Nombre'
      Required = True
      Size = 40
    end
    object PersonaContactoTableTelefonoOficina: TWideStringField
      FieldName = 'TelefonoOficina'
    end
    object PersonaContactoTableMovil: TWideStringField
      FieldName = 'Movil'
    end
    object PersonaContactoTableTelefonoParticular: TWideStringField
      FieldName = 'TelefonoParticular'
    end
    object PersonaContactoTableFax: TWideStringField
      FieldName = 'Fax'
    end
    object PersonaContactoTableNoLlamar: TBooleanField
      FieldName = 'NoLlamar'
    end
    object PersonaContactoTableEMail: TWideStringField
      FieldName = 'EMail'
      Size = 80
    end
    object PersonaContactoTableFechaNacimiento: TDateField
      FieldName = 'FechaNacimiento'
    end
    object PersonaContactoTableAsignadoA: TWideStringField
      FieldName = 'AsignadoA'
      Size = 2
    end
    object PersonaContactoTableObservaciones: TWideMemoField
      FieldName = 'Observaciones'
      BlobType = ftWideMemo
    end
  end
  object LineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 15000
    BeforeInsert = PersonaContactoTableBeforeInsert
    AfterInsert = PersonaContactoTableAfterInsert
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    AutoIncFieldName = 'NroLinea'
    CanInsert = False
    CanModify = False
    Left = 552
    Top = 124
  end
end
