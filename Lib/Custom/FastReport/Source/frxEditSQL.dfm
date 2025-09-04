object frxSQLEditorForm: TfrxSQLEditorForm
  Left = 200
  Top = 107
  Caption = 'Lines'
  ClientHeight = 584
  ClientWidth = 686
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object Splitter: TSplitter
    Left = 0
    Top = 349
    Width = 686
    Height = 6
    Cursor = crVSplit
    Align = alTop
    Beveled = True
  end
  object SQLTextPanel: TPanel
    Left = 0
    Top = 0
    Width = 686
    Height = 349
    Align = alTop
    Alignment = taLeftJustify
    ParentColor = True
    TabOrder = 0
    object SQLToolBar: TToolBar
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 678
      Height = 28
      AutoSize = True
      ButtonHeight = 28
      ButtonWidth = 28
      TabOrder = 0
      object CancelB: TToolButton
        Left = 0
        Top = 0
        Hint = 'Cancel'
        ImageIndex = 55
        OnClick = CancelBClick
      end
      object OkB: TToolButton
        Left = 28
        Top = 0
        Hint = 'OK'
        ImageIndex = 56
        OnClick = OkBClick
      end
      object ToolButton3: TToolButton
        Left = 56
        Top = 0
        Width = 8
        Caption = 'ToolButton3'
        ImageIndex = 57
        Style = tbsSeparator
      end
      object ToolButton4: TToolButton
        Left = 64
        Top = 0
        Hint = 'Par'#225'metros'
        Caption = 'ToolButton4'
        ImageIndex = 54
        OnClick = ToolButton4Click
      end
      object ToolButton1: TToolButton
        Left = 92
        Top = 0
        Hint = 'Variables'
        Caption = 'ToolButton1'
        ImageIndex = 52
        OnClick = ToolButton1Click
      end
      object ToolButton2: TToolButton
        Left = 120
        Top = 0
        Width = 8
        Caption = 'ToolButton2'
        ImageIndex = 55
        Style = tbsSeparator
      end
      object ToolButton5: TToolButton
        Left = 128
        Top = 0
        Hint = 'Ejecutar consulta SQL'
        Caption = 'ToolButton5'
        ImageIndex = 90
        OnClick = ToolButton5Click
      end
    end
    object fieldsPanel: TPanel
      Left = 1
      Top = 35
      Width = 204
      Height = 313
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
      object Splitter1: TSplitter
        Left = 0
        Top = 141
        Width = 204
        Height = 6
        Cursor = crVSplit
        Align = alTop
        Beveled = True
        ExplicitWidth = 160
      end
      object fieldListBox: TListBox
        Left = 0
        Top = 147
        Width = 204
        Height = 137
        Align = alClient
        Ctl3D = True
        DragMode = dmAutomatic
        ItemHeight = 17
        ParentCtl3D = False
        TabOrder = 0
        OnDblClick = fieldListBoxDblClick
        OnDragOver = fieldListBoxDragOver
      end
      object tableListBox: TListBox
        Left = 0
        Top = 0
        Width = 204
        Height = 141
        Align = alTop
        Ctl3D = True
        ItemHeight = 17
        ParentCtl3D = False
        TabOrder = 1
        OnClick = tableListBoxClick
        OnDblClick = tableListBoxDblClick
      end
      object Panel1: TPanel
        Left = 0
        Top = 284
        Width = 204
        Height = 29
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
        object nombreTablaCB: TCheckBox
          Left = 4
          Top = 5
          Width = 187
          Height = 17
          Caption = 'Incluir el nombre de la tabla'
          TabOrder = 0
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 355
    Width = 686
    Height = 229
    Align = alClient
    TabOrder = 1
    object resultDBGrid: TDBGrid
      Left = 185
      Top = 1
      Width = 500
      Height = 227
      Align = alClient
      DataSource = SQLDataSource
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -13
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnColEnter = resultDBGridColEnter
      OnDrawColumnCell = resultDBGridDrawColumnCell
    end
    object ResultFieldsListBox: TListBox
      Left = 1
      Top = 1
      Width = 184
      Height = 227
      Align = alLeft
      Ctl3D = True
      DragMode = dmAutomatic
      ItemHeight = 17
      ParentCtl3D = False
      TabOrder = 1
      OnClick = ResultFieldsListBoxClick
    end
  end
  object SQLDataSource: TDataSource
    AutoEdit = False
    Enabled = False
    Left = 410
    Top = 216
  end
end
