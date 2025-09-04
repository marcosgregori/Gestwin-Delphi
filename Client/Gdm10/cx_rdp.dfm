object cxRdpForm: TcxRdpForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de remesas de pago '
  ClientHeight = 192
  ClientWidth = 553
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
  KeyPreview = True
  Position = poDefault
  Visible = True
  OnCreate = FormCreate
  TextHeight = 17
  object QueryPanel: TgQueryPanel
    Left = 0
    Top = 156
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SearchField = QueryNombre
    SourceField = QueryNroRemesa
    FixedRangeField = QueryFecha
    SourceQuery = Query
    OnUserSelection = QueryPanelUserSelection
    Height = 36
    Width = 553
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 553
    Height = 156
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object TableView: TcxGridDBTableView
      Tag = 431106960
      Navigator.Buttons.CustomButtons = <>
      FilterBox.Position = fpTop
      FilterBox.Visible = fvNever
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataModeController.GridMode = True
      DataController.DataSource = dataSource
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.IncSearchItem = TableViewNombre
      OptionsBehavior.FocusCellOnCycle = True
      OptionsBehavior.HotTrack = True
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnMoving = False
      OptionsCustomize.ColumnSorting = False
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      Styles.ContentEven = ApplicationContainer.QueryContentEvenStyle
      object TableViewNroRemesa: TcxGridDBColumn
        Caption = 'Remesa'
        DataBinding.FieldName = 'NroRemesa'
        Styles.Content = ApplicationContainer.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 50
      end
      object TableViewFecha: TcxGridDBColumn
        DataBinding.FieldName = 'Fecha'
        Width = 75
      end
      object TableViewCodigoEntidad: TcxGridDBColumn
        Caption = 'Entidad'
        DataBinding.FieldName = 'CodigoEntidad'
        DataBinding.IsNullValueType = True
      end
      object TableViewNombre: TcxGridDBColumn
        DataBinding.FieldName = 'Nombre'
      end
      object TableViewImporte: TcxGridDBColumn
        DataBinding.FieldName = 'Importe'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Width = 75
      end
      object TableViewFechaPago: TcxGridDBColumn
        Caption = 'Pago'
        DataBinding.FieldName = 'FechaPago'
        Visible = False
        Width = 75
      end
      object TableViewImagenEstado: TcxGridDBColumn
        Caption = 'Estado'
        DataBinding.FieldName = 'IndiceImagenEstado'
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.Images = DocumentStatesImageList
        Properties.Items = <
          item
            ImageIndex = 0
            Value = 0
          end
          item
            ImageIndex = 1
            Value = 1
          end
          item
            ImageIndex = 2
            Value = 2
          end>
        Options.ShowCaption = False
        Width = 22
      end
      object TableViewTextoEstado: TcxGridDBColumn
        Caption = 'Estado'
        DataBinding.FieldName = 'TextoEstado'
        HeaderHint = 'Texto de estado'
        Width = 75
      end
      object TableViewEstado: TcxGridDBColumn
        DataBinding.FieldName = 'Estado'
        Visible = False
        HeaderHint = 'C'#243'digo de estado'
        VisibleForCustomization = False
      end
    end
    object GridLevel: TcxGridLevel
      GridView = TableView
    end
  end
  object Query: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    Filtered = True
    OnCalcFields = QueryCalcFields
    OnFilterRecord = QueryFilterRecord
    SQL.Strings = (
      
        'SELECT Ejercicio, NroRemesa, Fecha, SubcuentaEntidad, Banco.Nomb' +
        're, Estado, FechaPago'
      
        'FROM RemesaPago LEFT JOIN Banco On ( SubcuentaEntidad=Banco.Subc' +
        'uenta )'
      'ORDER BY Ejercicio, NroRemesa')
    Left = 282
    Top = 38
    object QueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object QueryNroRemesa: TIntegerField
      FieldName = 'NroRemesa'
    end
    object QueryFecha: TDateField
      FieldName = 'Fecha'
    end
    object QuerySubcuentaEntidad: TWideStringField
      FieldName = 'SubcuentaEntidad'
      Size = 9
    end
    object QueryNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
    object QueryImporte: TBCDField
      FieldKind = fkCalculated
      FieldName = 'Importe'
      Calculated = True
    end
    object QueryEstado: TSmallintField
      FieldName = 'Estado'
    end
    object QueryIndiceImagenEstado: TSmallintField
      FieldKind = fkCalculated
      FieldName = 'IndiceImagenEstado'
      Calculated = True
    end
    object QueryTextoEstado: TWideStringField
      DisplayWidth = 25
      FieldKind = fkCalculated
      FieldName = 'TextoEstado'
      Size = 25
      Calculated = True
    end
    object QueryFechaPago: TDateField
      FieldName = 'FechaPago'
    end
  end
  object dataSource: TDataSource
    DataSet = Query
    Left = 282
    Top = 66
  end
  object DocumentStatesImageList: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 9437468
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000005050E1C0C0B24440B0A23410403
          0A15000000000000000000000000000000000000000000000000000000000000
          000000000000000000000C0B2335252187C14E4ABCFE7572CAFE736FC9FE4642
          B8FC221F7CB20808182600000000000000000000000000000000000000000000
          00000000000015133B554743B7F9CAC9EAFEFDFDFDFEE9E8FCFEECECFCFEFDFD
          FDFEBBBAE5FE3C38ADF10F0E2B3E000000000000000000000000000000000000
          0000090919294441B3F6EBEBF7FEB3B2F7FE433FEDFE2521EAFE2521EAFE4D4A
          EEFEC4C3F8FEDEDDF2FE3732A7EA05040C150000000000000000000000000000
          0000221F76A9C1C0E7FEAAA9F6FE2622EAFE2521EAFE2521EAFE2521EAFE2521
          EAFE2925EBFEC2C1F8FEA7A5DDFE1C1A60890000000000000000000000000101
          03074440B3F6F5F5FCFE3430ECFE2521EAFE2521EAFE2521EAFE2521EAFE2521
          EAFE2521EAFE4844EDFEF5F5FAFE2F2A9CDD0000000000000000000000000706
          13286D69C7FECAC9F9FE2521EAFE2521EAFE2521EAFE2521EAFE2521EAFE2521
          EAFE2521EAFE2521EAFEE5E5FBFE534FBEFE0101040900000000000000000707
          142A706CC8FEC7C6F9FE2521EAFE2521EAFE2521EAFE2521EAFE2521EAFE2521
          EAFE2521EAFE2521EAFEE2E1FBFE5551BFFE0101040A00000000000000000101
          04094B47B9F9F1F1FCFE2E2AEBFE2521EAFE2521EAFE2521EAFE2521EAFE2521
          EAFE2521EAFE3E3AECFEF8F8FCFE342FA1E30000000000000000000000000000
          000023207DB3D0CFEDFE9593F4FE2521EAFE2521EAFE2521EAFE2521EAFE2521
          EAFE2622EAFEB0AEF7FEB6B4E3FE1F1C68940000000000000000000000000000
          00000C0B2234524EBBFAF4F4FAFE9796F4FE302CEBFE2521EAFE2521EAFE3633
          ECFEABAAF6FEEBEBF7FE413DAFF10606121D0000000000000000000000000000
          000000000000181649685B57C0FDE2E2F3FEF4F4FDFECDCCF9FED0CFF9FEF8F8
          FDFED6D6EFFE4C48B8F81311374E000000000000000000000000000000000000
          00000000000000000000111032482C2998D86B67C6FE918FD5FE8F8CD4FE635F
          C3FE28248DCA0C0B253600000000000000000000000000000000000000000000
          0000000000000000000000000000000000010A091E3213113C5B12113A580808
          192A000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000070A051C101B0C4410190B410508
          0415000000000000000000000000000000000000000000000000000000000000
          00000000000000000000101A0C35366125C162914EFE84A975FE81A773FE5B8B
          46FC325922B20B12082600000000000000000000000000000000000000000000
          0000000000001C2C15555C8C47F9D0DECAFEFDFDFDFEEFF7EEFEF1F8F0FEFDFD
          FDFEC3D5BBFE50813CF114200F3E000000000000000000000000000000000000
          00000C130929598944F6EDF2EBFEC9E6C6FE7BC373FE66B95DFE66B95DFE81C6
          7BFED5EBD3FEE1EADEFE4B7B37EA060904150000000000000000000000000000
          0000315522A9C8D8C1FEC3E3C0FE67B95EFE66B95DFE66B95DFE66B95DFE66B9
          5DFE69BA60FED4EBD1FEB1C8A7FE28461C890000000000000000000000000102
          0107588844F6F7FBF7FE71BE68FE66B95DFE66B95DFE66B95DFE66B95DFE66B9
          5DFE66B95DFE7EC477FEF6F8F5FE42722FDD000000000000000000000000090E
          07287DA46DFED9EDD7FE66B95DFE66B95DFE66B95DFE66B95DFE66B95DFE66B9
          5DFE66B95DFE66B95DFEECF6EBFE669453FE0203010900000000000000000A0F
          072A7FA56FFED7ECD5FE66B95DFE66B95DFE66B95DFE66B95DFE66B95DFE66B9
          5DFE66B95DFE66B95DFEEAF5E9FE689555FE0203010A00000000000000000203
          01095F8E4BF9F5F9F4FE6CBC64FE66B95DFE66B95DFE66B95DFE66B95DFE66B9
          5DFE66B95DFE77C16FFEF9FAF8FE477634E30000000000000000000000000000
          0000335B23B3D5E2D0FEB4DDB0FE66B95DFE66B95DFE66B95DFE66B95DFE66B9
          5DFE67B95EFEC7E5C4FEBED1B6FE2C4B1E940000000000000000000000000000
          0000101A0C34669352FAF6F8F5FEB6DDB2FE6EBD65FE66B95DFE66B95DFE72BF
          6AFEC4E4C0FEEDF2EBFE558441F1090E061D0000000000000000000000000000
          000000000000213618686D995BFDE5EDE2FEF7FAF6FEDBEED9FEDEEFDCFEF9FC
          F9FEDBE5D6FE5F8E4CF81929134E000000000000000000000000000000000000
          0000000000000000000017251148406E2CD87BA26BFE9EBB91FE9BB98FFE749D
          63FE3A6628CA111B0C3600000000000000000000000000000000000000000000
          0000000000000000000000000000000000010E160A321A2C135B1A2A12580B12
          082A000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end>
  end
end
