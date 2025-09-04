object BoxSfaForm: TBoxSfaForm
  Left = 455
  Top = 256
  HelpType = htKeyword
  HelpKeyword = 'b_gaa'
  HelpContext = 4104
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  BorderStyle = bsDialog
  Caption = 'Suministro inmediato de facturas '
  ClientHeight = 758
  ClientWidth = 1598
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -20
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
  Position = poDefault
  ShowHint = True
  Visible = True
  PixelsPerInch = 144
  TextHeight = 28
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 704
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alBottom
    PanelStyle.Active = True
    PanelStyle.CaptionIndent = 3
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      1598
      54)
    Height = 54
    Width = 1598
    object Panel3: TcxGroupBox
      Left = 665
      Top = 5
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Anchors = []
      PanelStyle.Active = True
      PanelStyle.CaptionIndent = 3
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 45
      Width = 261
      object OkButton: TgBitBtn
        Left = 2
        Top = 2
        Width = 127
        Height = 42
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = '&Aceptar'
        Enabled = True
        ModalResult = 1
        OptionsImage.ImageIndex = 2
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 6
        OptionsImage.Spacing = 8
        TabOrder = 0
        GlyphBitmap = gmOk
      end
      object CloseButton: TgBitBtn
        Left = 132
        Top = 2
        Width = 128
        Height = 42
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Cancel = True
        Caption = '&Cerrar'
        Enabled = True
        ModalResult = 2
        OptionsImage.ImageIndex = 7
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 6
        OptionsImage.Spacing = 8
        TabOrder = 1
        GlyphBitmap = gmClose
      end
    end
  end
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 8
    Top = 8
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alClient
    Alignment = alCenterCenter
    PanelStyle.Active = True
    PanelStyle.CaptionIndent = 3
    ParentBackground = False
    ParentColor = False
    ParentShowHint = False
    ShowHint = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 0
    PanelKind = epInputPanel
    Height = 696
    Width = 1582
    object FacturasPanel: TcxGroupBox
      Left = 2
      Top = 335
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      Ctl3D = False
      PanelStyle.Active = True
      PanelStyle.CaptionIndent = 3
      ParentBackground = False
      ParentCtl3D = False
      Style.BorderStyle = ebsNone
      TabOrder = 4
      Height = 293
      Width = 1578
      object GridTableViewController1: TGridTableViewController
        Left = 1519
        Top = 2
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alRight
        Enabled = False
        PanelStyle.Active = True
        PanelStyle.CaptionIndent = 3
        Style.BorderStyle = ebsNone
        Style.TransparentBorder = False
        TabOrder = 0
        Visible = False
        TableView = GridView
        ShiftRecords = False
        UseGridFilterBox = False
        OnUserSelection = GridTableViewController1UserSelection
        Height = 289
        Width = 57
      end
      object Grid: TcxGrid
        Left = 2
        Top = 2
        Width = 1517
        Height = 289
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alClient
        BorderWidth = 1
        TabOrder = 1
        object GridView: TcxGridDBTableView
          PopupMenu = FacturasPopupMenu
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          OnCustomDrawCell = GridViewCustomDrawCell
          DataController.DataSource = RelacionFacturasDataSource
          DataController.KeyFieldNames = 'Serie;NroFactura'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <
            item
              Links = <
                item
                end
                item
                end
                item
                end
                item
                end>
              SummaryItems = <
                item
                  Format = 'Fecha : '
                  Kind = skMax
                end
                item
                  Format = 'Importe neto : ,0.00'
                  Kind = skSum
                end>
            end
            item
              Links = <
                item
                end
                item
                end
                item
                end>
              SummaryItems = <
                item
                  Format = 'Importe neto : ,0.00'
                  Kind = skSum
                end>
            end>
          FilterRow.SeparatorWidth = 9
          FixedDataRows.SeparatorWidth = 9
          NewItemRow.SeparatorWidth = 9
          OptionsBehavior.PostponedSynchronization = False
          OptionsBehavior.FocusCellOnTab = True
          OptionsBehavior.FocusFirstCellOnNewRecord = True
          OptionsBehavior.FocusCellOnCycle = True
          OptionsBehavior.PullFocusing = True
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsCustomize.ColumnMoving = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.NavigatorOffset = 75
          OptionsView.ColumnAutoWidth = True
          OptionsView.FixedColumnSeparatorWidth = 3
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Preview.Column = GridViewDescripcionErrorRegistro
          Preview.LeftIndent = 30
          Preview.RightIndent = 8
          Preview.Visible = True
          RowLayout.MinValueWidth = 120
          object GridViewSeleccionada: TcxGridDBColumn
            Caption = 'Sel.'
            DataBinding.FieldName = 'Seleccionada'
            HeaderHint = 'Seleccionada'
            MinWidth = 30
            Width = 54
          end
          object GridViewFecha: TcxGridDBColumn
            DataBinding.FieldName = 'Fecha'
            MinWidth = 30
            Width = 111
          end
          object GridViewSerie: TcxGridDBColumn
            Caption = 'Se.'
            DataBinding.FieldName = 'Serie'
            Visible = False
            MinWidth = 30
            VisibleForCustomization = False
          end
          object GridViewNroFactura: TcxGridDBColumn
            Caption = 'N'#186' factura'
            DataBinding.FieldName = 'NroFactura'
            PropertiesClassName = 'TcxIntegerEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Visible = False
            MinWidth = 30
            VisibleForCustomization = False
            Width = 105
          end
          object GridViewSerieNroFactura: TcxGridDBColumn
            Caption = 'Serie / N'#186' Factura'
            DataBinding.FieldName = 'SerieNroFactura'
            PropertiesClassName = 'TcxTextEditProperties'
            OnGetProperties = GridViewSerieNroFacturaGetProperties
            MinWidth = 30
            Width = 173
          end
          object GridViewSubcuenta: TcxGridDBColumn
            DataBinding.FieldName = 'Subcuenta'
            MinWidth = 30
            Width = 104
          end
          object GridViewDescripcion: TcxGridDBColumn
            Caption = 'Descripci'#243'n'
            DataBinding.FieldName = 'Descripcion'
            MinWidth = 30
            Width = 380
          end
          object GridViewImporte: TcxGridDBColumn
            DataBinding.FieldName = 'Importe'
            MinWidth = 30
            Width = 164
          end
          object GridViewNroAsiento: TcxGridDBColumn
            Caption = 'N'#186' asiento'
            DataBinding.FieldName = 'NroAsiento'
            MinWidth = 30
            Width = 107
          end
          object GridViewPresentacion: TcxGridDBColumn
            Caption = 'Presentaci'#243'n'
            DataBinding.FieldName = 'FechaPresentacion'
            PropertiesClassName = 'TcxDateEditProperties'
            Properties.ShowTime = False
            MinWidth = 30
            Width = 123
          end
          object GridViewImporteRegistro: TcxGridDBColumn
            Caption = 'Imp. pres.'
            DataBinding.FieldName = 'ImporteRegistro'
            Visible = False
            MinWidth = 30
          end
          object GridViewEstado: TcxGridDBColumn
            Caption = 'Estado'
            DataBinding.FieldName = 'EstadoPresentacion'
            PropertiesClassName = 'TcxIndexedComboBoxProperties'
            Properties.Alignment.Horz = taLeftJustify
            Properties.DropDownListStyle = lsFixedList
            Properties.Items.Strings = (
              'Pendiente'
              'Presentada'
              'Anulada'
              'Aceptada con errores'
              'Modificada')
            MinWidth = 30
            Width = 152
          end
          object GridViewDescripcionErrorRegistro: TcxGridDBColumn
            DataBinding.FieldName = 'DescripcionErrorRegistro'
            MinWidth = 30
          end
          object GridViewContraste: TcxGridDBColumn
            DataBinding.FieldName = 'Contraste'
            PropertiesClassName = 'TcxIndexedComboBoxProperties'
            Properties.Alignment.Horz = taLeftJustify
            Properties.DropDownListStyle = lsFixedList
            Properties.Items.Strings = (
              'No contrastable'
              'En proceso'
              'No contrastada'
              'Parcialmente cont.'
              'Contrastada')
            MinWidth = 30
            Width = 125
          end
        end
        object GridLevel: TcxGridLevel
          GridView = GridView
        end
      end
    end
    object cxGroupBox1: TcxGroupBox
      Left = 2
      Top = 211
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      PanelStyle.Active = True
      PanelStyle.CaptionIndent = 3
      Style.BorderStyle = ebsNone
      TabOrder = 3
      DesignSize = (
        1578
        124)
      Height = 124
      Width = 1578
      object cxLabel1: TcxLabel
        Left = 11
        Top = 8
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabStop = False
        Caption = 'Operaci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 7
        Transparent = True
      end
      object TodoButton: TgBitBtn
        Left = 1438
        Top = 39
        Width = 128
        Height = 42
        Hint = 'Alterna la selecci'#243'n de todas las facturas'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Anchors = [akTop, akRight]
        Caption = '&Todas'
        Enabled = True
        OptionsImage.ImageIndex = 9
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 6
        OptionsImage.Spacing = 8
        ParentShowHint = False
        ShowHint = True
        TabOrder = 8
        TabStop = False
        OnClick = TodoButtonClick
        GlyphBitmap = gmAll
      end
      object cxLabel4: TcxLabel
        Left = 11
        Top = 50
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabStop = False
        Caption = 'Fecha presentaci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 9
        Transparent = True
      end
      object FechaPresentacionCtrl: TcxDBDateEdit
        Left = 188
        Top = 45
        Hint = 
          'Pulse [Supr] para suprimir la fecha y seleccionar todo el period' +
          'o.'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        CaptionLabel = cxLabel4
        DataBinding.DataField = 'FechaPresentacion'
        DataBinding.DataSource = DataSource
        Properties.OnValuePosted = FechaPresentacionCtrlPropertiesValuePosted
        Properties.ClearKey = 46
        Properties.DateButtons = [btnClear, btnToday]
        Properties.ImmediatePost = True
        Properties.Nullstring = '<Cualquiera>'
        Properties.SaveTime = False
        Properties.ShowTime = False
        Properties.OnValidate = FechaPresentacionCtrlPropertiesValidate
        TabOrder = 4
        Width = 156
      end
      object AltasCtrl: TcxRadioButton
        Left = 188
        Top = 5
        Width = 76
        Height = 33
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Altas'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = OperacionCtrlClick
        GroupIndex = 1
        Transparent = True
      end
      object ModificacionesCtrl: TcxRadioButton
        Left = 276
        Top = 5
        Width = 174
        Height = 33
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Modificaciones'
        TabOrder = 1
        OnClick = OperacionCtrlClick
        GroupIndex = 1
        Transparent = True
      end
      object AnulacionesCtrl: TcxRadioButton
        Left = 459
        Top = 5
        Width = 138
        Height = 33
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Anulaciones'
        TabOrder = 2
        OnClick = OperacionCtrlClick
        GroupIndex = 1
        Transparent = True
      end
      object ConsultaCtrl: TcxRadioButton
        Left = 614
        Top = 5
        Width = 268
        Height = 33
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Consulta / Sincronizaci'#243'n'
        TabOrder = 3
        OnClick = OperacionCtrlClick
        GroupIndex = 1
        Transparent = True
      end
      object DescFechaPresentacionLabel: TcxLabel
        Left = 359
        Top = 50
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 10
        Transparent = True
        Height = 28
        Width = 666
      end
      object cxLabel7: TcxLabel
        Left = 11
        Top = 90
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabStop = False
        Caption = 'Fecha de factura'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 11
        Transparent = True
      end
      object FechaInicialCtrl: TcxDBDateEdit
        Left = 188
        Top = 86
        Hint = 
          'Pulse [Supr] para suprimir la fecha y seleccionar todo el period' +
          'o.'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        CaptionLabel = cxLabel7
        DataBinding.DataField = 'FechaInicial'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.OnValuePosted = ControlPropertiesValuePosted
        Properties.ClearKey = 46
        Properties.DateButtons = [btnClear, btnToday]
        Properties.ImmediatePost = True
        Properties.Nullstring = '<Cualquiera>'
        Properties.SaveTime = False
        Properties.ShowTime = False
        Properties.ValidationOptions = [evoRaiseException, evoValidateAlways]
        Properties.OnValidate = FechaCtrlPropertiesValidate
        TabOrder = 5
        Width = 156
      end
      object cxLabel8: TcxLabel
        Left = 357
        Top = 90
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabStop = False
        Caption = '...'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 12
        Transparent = True
      end
      object FechaFinalCtrl: TcxDBDateEdit
        Left = 389
        Top = 86
        Hint = 
          'Pulse [Supr] para suprimir la fecha y seleccionar todo el period' +
          'o.'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        CaptionLabel = cxLabel8
        DataBinding.DataField = 'FechaFinal'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.OnValuePosted = ControlPropertiesValuePosted
        Properties.ClearKey = 46
        Properties.DateButtons = [btnClear, btnToday]
        Properties.ImmediatePost = True
        Properties.Nullstring = '<Cualquiera>'
        Properties.SaveTime = False
        Properties.ShowTime = False
        Properties.ValidationOptions = [evoRaiseException, evoValidateAlways]
        Properties.OnValidate = FechaCtrlPropertiesValidate
        TabOrder = 6
        Width = 156
      end
    end
    object FacturaEmitidaGroupBox: TcxGroupBox
      Left = 2
      Top = 131
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      PanelStyle.Active = True
      PanelStyle.CaptionIndent = 3
      Style.BorderStyle = ebsNone
      TabOrder = 2
      Height = 80
      Width = 1578
      object gxRangeBox2: TgxRangeBox
        Left = 162
        Top = 12
        Width = 20
        Height = 56
        Hint = 
          'Los campos situados a la derecha marcan un rango de valores.'#13'Arr' +
          'iba el l'#237'mite inferior y abajo el superior.'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        ParentShowHint = False
        ShowHint = True
      end
      object SerieInicialCtrl: TcxDBTextEdit
        Left = 188
        Top = 0
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        DescriptionLabel = DescSerieInicialLabel
        DataBinding.DataField = 'SerieInicial'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
        Properties.OnValuePosted = ControlPropertiesValuePosted
        Properties.OnValidate = SerieCtrlPropertiesValidate
        TabOrder = 0
        Width = 45
      end
      object SerieFinalCtrl: TcxDBTextEdit
        Left = 188
        Top = 41
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        DescriptionLabel = DescSerieFinalLabel
        DataBinding.DataField = 'SerieFinal'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
        Properties.OnValuePosted = ControlPropertiesValuePosted
        Properties.TextEditPad = tpRightHighest
        Properties.PadAlways = True
        Properties.OnValidate = SerieCtrlPropertiesValidate
        TabOrder = 1
        Width = 45
      end
      object cxLabel2: TcxLabel
        Left = 11
        Top = 5
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabStop = False
        Caption = 'Serie'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
      end
      object DescSerieInicialLabel: TcxLabel
        Left = 359
        Top = 5
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabStop = False
        AutoSize = False
        Enabled = False
        ParentColor = False
        Style.Color = clNavy
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
        Height = 27
        Width = 525
      end
      object DescSerieFinalLabel: TcxLabel
        Left = 359
        Top = 45
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabStop = False
        AutoSize = False
        Enabled = False
        ParentColor = False
        Style.Color = clNavy
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 4
        Transparent = True
        Height = 27
        Width = 525
      end
    end
    object FacturaRecibidaGroupBox: TcxGroupBox
      Left = 2
      Top = 47
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      PanelStyle.Active = True
      PanelStyle.CaptionIndent = 3
      Style.BorderStyle = ebsNone
      TabOrder = 1
      DesignSize = (
        1578
        84)
      Height = 84
      Width = 1578
      object gxRangeBox1: TgxRangeBox
        Left = 162
        Top = 15
        Width = 20
        Height = 56
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        ParentShowHint = False
        ShowHint = True
      end
      object AcreedorInicialCtrl: TcxDBTextEdit
        Left = 188
        Top = 3
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        DescriptionLabel = Label7
        DataBinding.DataField = 'AcreedorInicial'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = AcreedorCtrlPropertiesQueryRequest
        Properties.OnValuePosted = ControlPropertiesValuePosted
        Properties.TextEditPad = tpRightZero
        Properties.PadAlways = True
        Properties.OnValidate = AcreedorCtrlPropertiesValidate
        TabOrder = 0
        Width = 111
      end
      object AcreedorFinalCtrl: TcxDBTextEdit
        Left = 188
        Top = 44
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        DescriptionLabel = Label3
        DataBinding.DataField = 'AcreedorFinal'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = AcreedorCtrlPropertiesQueryRequest
        Properties.OnValuePosted = ControlPropertiesValuePosted
        Properties.TextEditPad = tpRightZero
        Properties.PadAlways = True
        Properties.OnValidate = AcreedorCtrlPropertiesValidate
        TabOrder = 1
        Width = 111
      end
      object Label7: TcxLabel
        Left = 336
        Top = 8
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
        Height = 28
        Width = 1170
      end
      object Label3: TcxLabel
        Left = 336
        Top = 48
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
        Height = 29
        Width = 1170
      end
      object cxLabel3: TcxLabel
        Left = 11
        Top = 8
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabStop = False
        Caption = 'Acreedor'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 4
        Transparent = True
      end
    end
    object cxGroupBox4: TcxGroupBox
      Left = 2
      Top = 2
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      PanelStyle.Active = True
      PanelStyle.CaptionIndent = 3
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        1578
        45)
      Height = 45
      Width = 1578
      object Label1: TcxLabel
        Left = 11
        Top = 11
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabStop = False
        Caption = 'Periodo'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object PeriodoCtrl: TcxDBIndexedComboBox
        Left = 188
        Top = 5
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        DataBinding.DataField = 'Periodo'
        DataBinding.DataSource = DataSource
        Properties.OnValuePosted = PeriodoCtrlPropertiesValuePosted
        Properties.Alignment.Horz = taLeftJustify
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediatePost = True
        Properties.Items.Strings = (
          'Enero'
          'Febrero'
          'Marzo'
          'Abril'
          'Mayo'
          'Junio'
          'Julio'
          'Agosto'
          'Septiembre'
          'Octubre'
          'Noviembre'
          'Diciembre')
        TabOrder = 1
        Width = 202
      end
      object EntornoPruebasLabel: TcxLabel
        Left = 1275
        Top = 9
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabStop = False
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'ENTORNO DE PRUEBAS'
        ParentFont = False
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = -24
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.TextColor = clRed
        Style.TransparentBorder = False
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taRightJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 2
        Transparent = True
        Height = 26
        Width = 283
        AnchorX = 1558
        AnchorY = 22
      end
    end
    object cxGroupBox2: TcxGroupBox
      Left = 2
      Top = 628
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alBottom
      PanelStyle.Active = True
      PanelStyle.CaptionIndent = 3
      Style.BorderStyle = ebsNone
      TabOrder = 5
      Height = 66
      Width = 1578
      object cxLabel5: TcxLabel
        Left = 208
        Top = 2
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabStop = False
        Align = alClient
        AutoSize = False
        Caption = 
          'Acceda al Portal de la Agencia Tributaria para verificar que las' +
          ' facturas han sido correctamente presentadas, as'#237' como para real' +
          'izar la presentaci'#243'n de otros tipos de factura  (bienes de inver' +
          'si'#243'n, ciertas operaciones intracomunitarias, etc..)'
        Style.TextColor = clGrayText
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.WordWrap = True
        TabOrder = 0
        Transparent = True
        Height = 62
        Width = 1171
      end
      object cxGroupBox3: TcxGroupBox
        Left = 2
        Top = 2
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alLeft
        PanelStyle.Active = True
        PanelStyle.CaptionIndent = 3
        Style.BorderStyle = ebsNone
        TabOrder = 1
        Height = 62
        Width = 206
        object cxLabel6: TcxLabel
          Left = 69
          Top = 14
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabStop = False
          Caption = 'versi'#243'n 1.1'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 0
          Transparent = True
        end
        object Image1: TcxImage
          Left = 5
          Top = 0
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Picture.Data = {
            0D546478536D617274496D6167653C3F786D6C2076657273696F6E3D22312E30
            2220656E636F64696E673D225554462D38223F3E0D0A3C737667207769647468
            3D223130302522206865696768743D2231303025222076696577426F783D2230
            2030203234203234222076657273696F6E3D22312E312220786D6C6E733D2268
            7474703A2F2F7777772E77332E6F72672F323030302F7376672220786D6C6E73
            3A786C696E6B3D22687474703A2F2F7777772E77332E6F72672F313939392F78
            6C696E6B2220786D6C3A73706163653D2270726573657276652220786D6C6E73
            3A73657269663D22687474703A2F2F7777772E73657269662E636F6D2F222073
            74796C653D2266696C6C2D72756C653A6576656E6F64643B636C69702D72756C
            653A6576656E6F64643B7374726F6B652D6C696E656A6F696E3A726F756E643B
            7374726F6B652D6D697465726C696D69743A312E34313432313B223E26233130
            3B202020202623393B2623393B2623393B2623393B2623393B2623393B262339
            3B2623393B2623393B2623393B2623393B2623393B3C672069643D22436F7265
            6C454D46222073657269663A69643D22436F72656C454D4622207472616E7366
            6F726D3D226D617472697828302E303238343532362C302C302C302E30323834
            3532362C312E39333938342C362E3535393332292220786D6C3A73706163653D
            227072657365727665223E20202020202020202623393B2623393B2623393B26
            23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
            23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
            23393B2623393B2623393B2623393B2623393B3C67207472616E73666F726D3D
            226D617472697828302E31313831312C302C302C302E31313831312C302C3029
            2220786D6C3A73706163653D227072657365727665223E202020202020202020
            2020202623393B2623393B2623393B2623393B2623393B2623393B2623393B26
            23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
            23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
            23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
            23393B2623393B2623393B2623393B2623393B3C7061746820643D224D35322C
            32323935432D32302C32343838203230342C32393733203430392C3331363643
            3632362C33333731203936352C3334373120313334352C333439314332323031
            2C3335333620323739392C3333343720333034342C3236363543333137382C32
            32393020333034322C3139303920323834382C3136393643323331302C313130
            33203934312C3132363520313230342C38353143313330312C36393820313837
            312C35383920313934372C3131343843323233312C3131363120323536342C31
            31313620323835322C3131303243333030372C3130393520333031392C313035
            3120323930362C37323343323737352C33343420323436392C31353820323034
            352C373743313633332C2D3220313033332C3430203731322C31393843333832
            2C333630203131322C363734203136352C31313635433230362C313535372035
            34392C31383239203839302C3139343543313039332C3230313420313235342C
            3230363720313437372C3231313443323334342C3232393720323031302C3237
            333420313639342C3237363843313130352C3238333120313130332C32333030
            20313038332C3232343843313036332C3231393720313030302C323232312039
            34302C32323236433837392C32323331203831382C32323331203735372C3232
            3336433634312C32323436203131372C323235392035322C323239355A222073
            74796C653D2266696C6C3A726762283232312C34382C3532293B222F3E0D0A09
            093C2F673E0D0A3C67207472616E73666F726D3D226D617472697828302E3131
            3831312C302C302C302E31313831312C302C30292220786D6C3A73706163653D
            227072657365727665223E2020202020202020202020202623393B2623393B26
            23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
            23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
            23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
            23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
            23393B2623393B3C7061746820643D224D353834302C3334343343353837382C
            3333393220353835372C3236383320353835372C323632304C353835372C3530
            3843353835372C34313220353838382C31363220353833322C39364335373931
            2C373920353030392C373520343935312C393443343932322C31373020343933
            362C3238343720343933372C3333303643343933382C3334333420343839352C
            3334353620353033312C3334363043353136312C3334363320353739302C3334
            363820353834302C333434335A22207374796C653D2266696C6C3A7267622832
            35352C3233382C313734293B222F3E0D0A09093C2F673E0D0A3C67207472616E
            73666F726D3D226D617472697828302E31313831312C302C302C302E31313831
            312C302C30292220786D6C3A73706163653D227072657365727665223E202020
            2020202020202020202623393B2623393B2623393B2623393B2623393B262339
            3B2623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
            3B2623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
            3B2623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
            3B2623393B2623393B2623393B2623393B2623393B2623393B3C706174682064
            3D224D333338362C3334333343333531372C3334333920343139302C33343530
            20343237342C333432354C343237352C3131324C333339322C3130364C333338
            362C333433335A22207374796C653D2266696C6C3A72676228302C39392C3137
            33293B222F3E0D0A09093C2F673E0D0A3C67207472616E73666F726D3D226D61
            7472697828302E31313831312C302C302C302E31313831312C302C3029222078
            6D6C3A73706163653D227072657365727665223E202020202020202020202020
            2623393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B
            2623393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B
            2623393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B
            2623393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B
            2623393B2623393B2623393B2623393B3C7061746820643D224D343935382C33
            34323743353037342C3334333720353737302C3334353520353831372C333432
            3143353834322C3333393520353833332C3334303120353833352C3333343843
            353833362C3333313320353833332C3332373420353833332C33323339433538
            32382C3237353320353835312C32363720353832392C31323643353737312C31
            303420353032362C31303320343936322C3132344C343935382C333432375A22
            207374796C653D2266696C6C3A726762283235352C3231342C3630293B222F3E
            0D0A09093C2F673E0D0A093C2F673E0D0A3C2F7376673E0D0A}
          Properties.FitMode = ifmProportionalStretch
          Properties.GraphicClassName = 'TdxSmartImage'
          Properties.ReadOnly = True
          Properties.ShowFocusRect = False
          Style.BorderStyle = ebsNone
          StyleFocused.BorderStyle = ebsNone
          StyleHot.BorderStyle = ebsNone
          TabOrder = 1
          Transparent = True
          Height = 53
          Width = 66
        end
      end
      object cxGroupBox5: TcxGroupBox
        Left = 1379
        Top = 2
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alRight
        PanelStyle.Active = True
        PanelStyle.CaptionIndent = 3
        Style.BorderStyle = ebsNone
        TabOrder = 2
        DesignSize = (
          197
          62)
        Height = 62
        Width = 197
        object WebButton: TgBitBtn
          Left = 69
          Top = 8
          Width = 128
          Height = 42
          Hint = 'Abre en el navegador la p'#225'gina Web del portal de gesti'#243'n del SII'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Anchors = [akTop, akRight]
          Caption = 'Portal'
          Enabled = True
          OptionsImage.Glyph.SourceDPI = 96
          OptionsImage.Glyph.SourceHeight = 22
          OptionsImage.Glyph.SourceWidth = 22
          OptionsImage.Glyph.Data = {
            3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
            462D38223F3E0D0A3C7376672077696474683D22313030252220686569676874
            3D2231303025222076696577426F783D22302030203433203431222076657273
            696F6E3D22312E312220786D6C6E733D22687474703A2F2F7777772E77332E6F
            72672F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F
            2F7777772E77332E6F72672F313939392F786C696E6B2220786D6C3A73706163
            653D2270726573657276652220786D6C6E733A73657269663D22687474703A2F
            2F7777772E73657269662E636F6D2F22207374796C653D2266696C6C2D72756C
            653A6576656E6F64643B636C69702D72756C653A6576656E6F64643B7374726F
            6B652D6C696E656A6F696E3A726F756E643B7374726F6B652D6D697465726C69
            6D69743A312E34313432313B223E262331303B202020202623393B2623393B26
            23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B3C
            67207472616E73666F726D3D226D617472697828302E30303431323136332C30
            2C302C302E30303431323136332C342E343735362C342E343933363429222078
            6D6C3A73706163653D227072657365727665223E20202020202020202623393B
            2623393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B
            2623393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B
            2623393B2623393B2623393B3C7061746820643D224D333938342C3537343643
            343230342C3536373120343839332C3530393320353130332C34393237433532
            37372C3437393020353437382C3436333920353632382C343439394335383036
            2C3433333320353938392E30382C343137342E353220363132372E36382C3430
            33332E3843363033362E34342C333835312E343920353733362C333333372035
            3632312C3331333643353434392C3238333920353239322C3235363520353131
            362C323236354C343131392C35313843333939302E38352C3431312E36303620
            333839352C3430352E38373920333432352C3430352E38373943323835342C34
            30352E38373920313333322C3432372E343835203936312C3432384331303336
            2C36333020323330392C3237393720323436362C333037374C333938342C3537
            34365A22207374796C653D2266696C6C3A72676228392C3130302C313539293B
            222F3E0D0A093C2F673E0D0A3C67207472616E73666F726D3D226D6174726978
            28302E30303431323136332C302C302C302E30303431323136332C342E343735
            362C342E3439333634292220786D6C3A73706163653D22707265736572766522
            3E20202020202020202623393B2623393B2623393B2623393B2623393B262339
            3B2623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
            3B2623393B2623393B2623393B2623393B2623393B2623393B3C706174682064
            3D224D343431322C3634323843343433352C3635313720343435332C36353233
            20343438372C3636313143343539312C3637353020343833362C373137322034
            3839352C373330384C373930352C3733323443383030342C3732363420373936
            342C3734303120373936342C3731383543373734392C3638333620373535392C
            3634363420373334312C3631303843373230342C3538383320363832302E3132
            2C353231302E333220363732362C353035342E303543363635312E35342C3439
            33302E343220363536342C3437393220363532332C343735364C353735342C35
            34333643353332342C3538323420343638342C3631393720343431322C363432
            385A22207374796C653D2266696C6C3A72676228392C3130302C313539293B22
            2F3E0D0A093C2F673E0D0A3C67207472616E73666F726D3D226D617472697828
            302E30303431323136332C302C302C302E30303431323136332C342E34373536
            2C342E3439333634292220786D6C3A73706163653D227072657365727665223E
            20202020202020202623393B2623393B2623393B2623393B2623393B2623393B
            2623393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B
            2623393B2623393B2623393B2623393B2623393B2623393B3C7061746820643D
            224D3736332C3635373243313034362C3530333420323039332C343033312032
            3139312C3338313043323234382C3336383020323132372C3335343520323037
            372C3334303143313936382C3332373720313935372C3331393120313830392C
            3331323343313434342C33333433203430342C35303035203334372C35363437
            433332312C35393433203631352C36343630203736332C363537325A22207374
            796C653D2266696C6C3A726762283235312C35342C3333293B222F3E0D0A093C
            2F673E0D0A3C67207472616E73666F726D3D226D617472697828302E30303431
            323136332C302C302C302E30303431323136332C342E343735362C342E343933
            3634292220786D6C3A73706163653D227072657365727665223E202020202020
            20202623393B2623393B2623393B2623393B2623393B2623393B2623393B2623
            393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B2623
            393B2623393B2623393B2623393B2623393B3C7061746820643D224D37383237
            2C3231303443383037332C3232353120383030352C3237373120373932372C33
            30323543373735322C3335393820373237352C3432323120363836312C343633
            3843363735322C3437343820363636392C3437383020363732362C3530303443
            363736352C3531383820373230342C3538383320373334312C36313038433735
            35392C3634363420373734392C3638333620373936342C373138354338333530
            2C3734363820373734302C3734333720373535322C373433374C353235372C37
            34333843353036362C3734333620353035352C3733393820343930342C373333
            3343353030382C3735383720353330352C3735313220353537372C3735313243
            363035362C3735313220373930382C3735353020383131322C37343737433832
            30332C3732373020373936352C3639393020373836372C363831374337383637
            2C3638313720373138382C3536343120373133302C3535333943363734332C34
            38363420363732322E36312C343935332E3820363931352C3436393143363939
            332C3436313720363939372C3435393920373036322C3435323243373532312C
            3339373720383233392C3331323620383034352C3233333343373938322C3230
            373720373731352C3136363920373438392C3135353543373534362C31363835
            20373734312C3139373820373832372C323130345A22207374796C653D226669
            6C6C3A726762283233322C3233322C323332293B222F3E0D0A093C2F673E0D0A
            3C67207472616E73666F726D3D226D617472697828302E30303431323136332C
            302C302C302E30303431323136332C342E343735362C342E3439333634292220
            786D6C3A73706163653D227072657365727665223E2020202020202020262339
            3B2623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
            3B2623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
            3B2623393B2623393B2623393B3C7061746820643D224D3736332C3635373243
            313032352C36363032203832372C3635343120313137382C3537323543313433
            312C3531333920313733392C3437303820323132302C3432303243323232352C
            3430363320323439352C3338313420323137322C333437374C323037372C3334
            303143323132372C3335343520323234382C3336383020323139312C33383130
            43323039332C3430333120313034362C35303334203736332C363537325A2220
            7374796C653D2266696C6C3A726762283138362C3138362C313836293B222F3E
            0D0A093C2F673E0D0A3C67207472616E73666F726D3D226D617472697828302E
            30303431323136332C302C302C302E30303431323136332C342E343735362C34
            2E3439333634292220786D6C3A73706163653D227072657365727665223E2020
            2020202020202623393B2623393B2623393B2623393B2623393B2623393B2623
            393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B2623
            393B2623393B2623393B2623393B2623393B2623393B3C7061746820643D224D
            313134362C3732343143313436322C3736373220323435332C37343731203239
            33302C3733303043333230392C3731393920333437322C373039332033373339
            2C3639383343333839382C3639313720343333342C3636323520343438372C36
            36313143343435332C3635323320343433352C3635313720343431322C363432
            3843343239342C3634383020343138322C3635363320343035362C3636333343
            333239302C3730353620313937342C3735373220313134362C373234315A2220
            7374796C653D2266696C6C3A726762283138362C3138362C313836293B222F3E
            0D0A093C2F673E0D0A3C67207472616E73666F726D3D226D617472697828302E
            30303431323136332C302C302C302E30303431323136332C342E343735362C34
            2E3439333634292220786D6C3A73706163653D227072657365727665223E2020
            2020202020202623393B2623393B2623393B2623393B2623393B2623393B2623
            393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B2623
            393B2623393B2623393B2623393B2623393B2623393B3C7061746820643D224D
            363532332C3437353643363536342C3437393220363636352C343937332E3234
            20363732362C353032362E323443363636392C343830322E323420363735322C
            3437343820363836312C3436333843373237352C3432323120373735322C3335
            393820373932372C3330323543383030352C3237373120383037332C32323531
            20373832372C3231303443383032332C3239303320373631382C333433392037
            3232342C3339373843363935332C3433343720363730312C3435343020363532
            332C343735365A22207374796C653D2266696C6C3A726762283138362C313836
            2C313836293B222F3E0D0A093C2F673E0D0A3C67207472616E73666F726D3D22
            6D617472697828302E30303431323136332C302C302C302E3030343132313633
            2C342E343735362C342E3439333634292220786D6C3A73706163653D22707265
            7365727665223E20202020202020202623393B2623393B2623393B2623393B26
            23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
            23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B3C
            7061746820643D224D363132372E36382C343034342E39324C363233382E3434
            2C333932302E323943363137312E37332C333836392E323720363134382C3338
            303020353936322C333530354C353639392C3330363643353639352C33303539
            20353639312C3330353020353638372C333034334C353039372C323030374335
            3035362C3139333520353031372C3138373420343936352C313738384C343333
            322C36393343343235382C35343920343236392C35333820343131392C353138
            4C353131362C3232363543353239322C3235363520353434392C323833392035
            3632312C3331333643353733362C3333333720363035382E36382C333834352E
            393220363132372E36382C343034342E39325A22207374796C653D2266696C6C
            3A726762283233322C3233322C323332293B222F3E0D0A093C2F673E0D0A3C67
            207472616E73666F726D3D226D617472697828302E30303431323136332C302C
            302C302E30303431323136332C342E343735362C342E3439333634292220786D
            6C3A73706163653D227072657365727665223E20202020202020202623393B26
            23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
            23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
            23393B2623393B2623393B3C7061746820643D224D343839352C373330384C34
            3930342C3733333343353035352C3733393820353036362C3734333620353235
            372C373433384C373535322C3734333743373734302C3734333720383335302C
            3734363820373936342C3731383543373936342C3734303120383030342C3732
            363420373930352C373332344C343839352C373330385A22207374796C653D22
            66696C6C3A726762283138362C3138362C313836293B222F3E0D0A093C2F673E
            0D0A3C67207472616E73666F726D3D226D617472697828302E30303431323136
            332C302C302C302E30303431323136332C342E343735362C342E343933363429
            2220786D6C3A73706163653D227072657365727665223E202020202020202026
            23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
            23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
            23393B2623393B2623393B2623393B3C7061746820643D224D363436392C3336
            343743363237372E33362C333837302E323420353830362C3433333320353632
            382C3434393943353437382C3436333920353237372C3437393020353130332C
            3439323743343839332C3530393320343230342C3536373120333938342C3537
            343643333831312C3539323620323839382C3633323120323538372C36343331
            43313833392C3636393720313638312C36373235203831372C36363732433838
            312C3639363120313031362C3730373720313134362C3732343143313937342C
            3735373220333239302C3730353620343035362C3636333343343138322C3635
            363320343239342C3634383020343431322C3634323843343638342C36313937
            20353332342C3538323420353735342C353433364C363532332C343735364336
            3730312C3435343020363935332C3433343720373232342C3339373843373631
            382C3334333920383032332C3239303320373832372C3231303443373734312C
            3139373820373534362C3136383520373438392C313535354C373432332C3134
            383143373332332C3236303320373132342C3238383420363436392C33363437
            5A22207374796C653D2266696C6C3A726762283235302C3136392C3432293B22
            2F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
          OptionsImage.Images = ApplicationContainer.ButtonImageList
          OptionsImage.Margin = 6
          OptionsImage.Spacing = 8
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          TabStop = False
          OnClick = WebButtonClick
        end
      end
    end
  end
  object FormManager: TgxFormManager
    BackDropForm = True
    Dataset = Data
    Model = fmPersistentInputForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnPreparedForm = FormManagerPreparedForm
    OnRefreshCurrentRecord = FormManagerRefreshCurrentRecord
    OnOkButton = FormManagerOkButton
    Left = 828
    Top = 12
  end
  object AsientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'Ejercicio;NroAsiento'
    Left = 794
    Top = 42
  end
  object ApunteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 828
    Top = 42
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 797
    Top = 12
    object DataPeriodo: TSmallintField
      FieldName = 'Periodo'
    end
    object DataSerieInicial: TStringField
      FieldName = 'SerieInicial'
      Size = 2
    end
    object DataSerieFinal: TStringField
      FieldName = 'SerieFinal'
      Size = 2
    end
    object DataAcreedorInicial: TStringField
      FieldName = 'AcreedorInicial'
      Size = 9
    end
    object DataAcreedorFinal: TStringField
      FieldName = 'AcreedorFinal'
      Size = 9
    end
    object DataFechaPresentacion: TDateField
      FieldName = 'FechaPresentacion'
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 764
    Top = 12
  end
  object RelacionFacturasQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    SQL.Strings = (
      'SELECT  False AS Seleccionada,'
      '        Asiento.Ejercicio,'
      '        Asiento.NroAsiento,'
      '        Asiento.Fecha,'
      '        Asiento.Serie,'
      '        Asiento.NroFactura,'
      '        Apunte.Subcuenta,'
      '        Cuenta.Descripcion,'
      '        ( Apunte.Debe - Apunte.Haber ) AS Importe,'
      '        RegistroPresentacion.Tipo,'
      '        RegistroPresentacion.Propietario,'
      '        RegistroPresentacion.Importe AS ImporteRegistro,'
      '        RegistroPresentacion.FechaPresentacion,'
      '        RegistroPresentacion.HoraPresentacion,'
      '        RegistroPresentacion.EstadoPresentacion,'
      '        RegistroPresentacion.EstadoRegistro,'
      '        RegistroPresentacion.CodigoErrorRegistro,'
      '        RegistroPresentacion.DescripcionErrorRegistro,'
      '        RegistroPresentacion.Contraste'
      'FROM    Apunte'
      
        '        LEFT JOIN Asiento ON ( Asiento.Ejercicio=Apunte.Ejercici' +
        'o AND Asiento.NroAsiento=Apunte.NroAsiento )'
      '        LEFT JOIN Cuenta ON ( Cuenta.Codigo=Apunte.Subcuenta )'
      
        '        LEFT JOIN RegistroPresentacion ON ( RegistroPresentacion' +
        '.Tipo=0 AND Asiento.Ejercicio=RegistroPresentacion.Ejercicio AND' +
        ' Asiento.Serie=RegistroPresentacion.Serie AND Asiento.NroFactura' +
        '=RegistroPresentacion.NroFactura AND Asiento.NroEfecto=RegistroP' +
        'resentacion.NroEfecto )'
      'WHERE   ( Apunte.NroApunte=1 ) AND'
      
        '        ( Apunte.Fecha BETWEEN :FechaInicial AND :FechaFinal ) A' +
        'ND'
      '        ( Asiento.TipoAsiento=5 ) AND'
      
        '        ( Asiento.Serie BETWEEN :SerieInicial AND :SerieFinal ) ' +
        'AND'
      
        '        ( Asiento.Propietario BETWEEN :AcreedorInicial AND :Acre' +
        'edorFinal )'
      'ORDER BY Apunte.Fecha DESC, Apunte.NroAsiento DESC')
    Left = 549
    Top = 66
    ParamData = <
      item
        DataType = ftDate
        Name = 'FechaInicial'
        ParamType = ptUnknown
      end
      item
        DataType = ftDate
        Name = 'FechaFinal'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'SerieInicial'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'SerieFinal'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'AcreedorInicial'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'AcreedorFinal'
        ParamType = ptUnknown
      end>
  end
  object RelacionFacturasDataSource: TDataSource
    DataSet = RelacionFacturasCacheDataset
    Left = 478
    Top = 66
  end
  object RelacionFacturasCacheDataset: TnxeCachedDataSet
    Database = SessionDataModule.TmpDatabase
    Options = []
    FilterType = ftSqlWhere
    OnCalcFields = RelacionFacturasCacheDatasetCalcFields
    SourceDataSet = RelacionFacturasQuery
    Left = 512
    Top = 66
    object RelacionFacturasCacheDatasetSeleccionada: TBooleanField
      FieldName = 'Seleccionada'
    end
    object RelacionFacturasCacheDatasetEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object RelacionFacturasCacheDatasetTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object RelacionFacturasCacheDatasetNroAsiento: TIntegerField
      FieldName = 'NroAsiento'
    end
    object RelacionFacturasCacheDatasetFecha: TDateField
      FieldName = 'Fecha'
    end
    object RelacionFacturasCacheDatasetPropietario: TWideStringField
      FieldName = 'Propietario'
      Size = 9
    end
    object RelacionFacturasCacheDatasetSerie: TWideStringField
      FieldName = 'Serie'
      Size = 40
    end
    object RelacionFacturasCacheDatasetNroFactura: TIntegerField
      FieldName = 'NroFactura'
    end
    object RelacionFacturasCacheDatasetSerieNroFactura: TStringField
      FieldKind = fkCalculated
      FieldName = 'SerieNroFactura'
      Size = 48
      Calculated = True
    end
    object RelacionFacturasCacheDatasetSubcuenta: TWideStringField
      FieldName = 'Subcuenta'
      Size = 9
    end
    object RelacionFacturasCacheDatasetDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 125
    end
    object RelacionFacturasCacheDatasetImporte: TBCDField
      FieldName = 'Importe'
      Precision = 16
    end
    object RelacionFacturasCacheDatasetImporteRegistro: TBCDField
      FieldName = 'ImporteRegistro'
      Precision = 16
    end
    object RelacionFacturasCacheDatasetPresentacion: TDateField
      FieldName = 'FechaPresentacion'
    end
    object RelacionFacturasCacheDatasetEstadoPresentacion: TSmallintField
      FieldName = 'EstadoPresentacion'
    end
    object RelacionFacturasCacheDatasetEstadoRegistro: TSmallintField
      FieldName = 'EstadoRegistro'
    end
    object RelacionFacturasCacheDatasetCodigoErrorRegistro: TLargeintField
      FieldName = 'CodigoErrorRegistro'
    end
    object RelacionFacturasCacheDatasetDescripcionErrorRegistro: TWideStringField
      FieldName = 'DescripcionErrorRegistro'
      Size = 500
    end
    object RelacionFacturasCacheDatasetContraste: TSmallintField
      FieldName = 'Contraste'
    end
  end
  object RegistroPresentacionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RegistroPresentacion'
    IndexFieldNames = 'Tipo;Ejercicio;Propietario;Serie;NroFactura;NroEfecto'
    Left = 828
    Top = 74
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'FacturasPopupMenu')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 409
    Top = 65
    PixelsPerInch = 144
    object EditarFacturaItem: TdxBarButton
      Caption = '&Editar factura'
      Category = 1
      Visible = ivAlways
      OnClick = EditarFacturaItemClick
    end
    object SuprimirRegistroItem: TdxBarButton
      Caption = 'Suprimir registro de presentaci'#243'n'
      Category = 1
      Visible = ivAlways
      OnClick = SuprimirRegistroItemClick
    end
  end
  object FacturasPopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'EditarFacturaItem'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'SuprimirRegistroItem'
      end>
    UseOwnFont = False
    Left = 442
    Top = 66
    PixelsPerInch = 144
  end
end
