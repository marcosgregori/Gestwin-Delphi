

unit l_esf;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  LibUtils,Mask,

  Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  ReportManager, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  dxmdaset,

  dm_sal, cxMaskEdit, cxDropDownEdit, cxCalendar,

  Gim10Fields,
  Gim00Fields, cxGraphics, cxIndexedComboBox, cxLookAndFeels, dxSkinsCore,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox, AppContainer;


type

    TCabeceraFields = class( TnxeDatasetFields)
     public
       Subcuenta,
       Descripcion,
       Entidad,
       NombreEntidad : TWideStringField;
       Saldo,
       Limite : TBCDField;
     end;

    TLineasFields = class( TnxeDatasetFields)
     public
       Entidad : TWideStringField;
       Fecha : TDateField;
       ImporteCobro,
       ImportePago : TBCDField;
       Propietario,
       Concepto : TWideStringField;
       NroFactura : TIntegerField;
       Serie : TWideStringField;
       NroEfecto : TSmallIntField;
     end;

    TRptEsfForm = class(TgxForm)
    Panel1: TgxEditPanel;
    EntidadFinalCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    EfectoCobrarTable: TnxeTable;
    EntidadInicialCtrl: TcxDBTextEdit;
    AsientoTable: TnxeTable;
    BancoTable: TnxeTable;
    VencimientoInicialCtrl: TcxDBDateEdit;
    DisponibilidadTable: TnxeTable;
    EfectoPagarTable: TnxeTable;
    VencimientoFinalCtrl: TcxDBDateEdit;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataEntidadInicial: TWideStringField;
    DataEntidadFinal: TWideStringField;
    DataVencimientoInicial: TDateField;
    DataVencimientoFinal: TDateField;
    gxRangeBox3: TgxRangeBox;
    gxRangeBox1: TgxRangeBox;
    DataPeriodicidad: TSmallintField;
    PeriodicidadCtrl: TcxDBIndexedComboBox;
    Label2: TcxLabel;
    EntidadInicialLabel: TcxLabel;
    EntidadFinalLabel: TcxLabel;
    Label3: TcxLabel;
    Label1: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure EntidadCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure EntidadCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ReportBeforeStart;
    private
    procedure SeleccionaRegistros;

    public

    CabeceraTable : TnxeTable;
    CabeceraFields : TCabeceraFields;
    LineasTable : TnxeTable;
    LineasFields : TLineasFields;

    EfectoCobrarFields : TEfectoCobrarFields;
    EfectoPagarFields : TEfectoPagarFields;
    AsientoFields : TAsientoFields;
    BancoFields : TBancoFields;
    DisponibilidadFields : TDisponibilidadFields;
    end;

var RptEsfForm: TRptEsfForm = nil;

procedure listadoEvolucionFinanciera;


implementation

uses   EnterpriseDataAccess,
       DateUtils,

       dm_sub,
       dm_ban,
       dm_ecc,
       dm_ecp,

       cx_ban;

{$R *.DFM}

procedure ListadoEvolucionFinanciera;
begin
     CreateReportForm( TRptEsfForm, RptEsfForm );
end;

procedure TRptEsfForm.InitializeForm;
begin
     EfectoCobrarFields := TEfectoCobrarFields.Create( EfectoCobrarTable );
     EfectoPagarFields := TEfectoPagarFields.Create( EfectoPagarTable );
     BancoFields := TBancoFields.Create( BancoTable );
     DisponibilidadFields := TDisponibilidadFields.Create( DisponibilidadTable );

     DataEntidadInicial.Value := '572000000';
     DataEntidadFinal.Value := '572999999';
     DataVencimientoInicial.Value := ApplicationContainer.TodayDate;
     DataVencimientoFinal.Value := EncodeDate( YearOf( ApplicationContainer.TodayDate ), 12, 31 );
     DataPeriodicidad.Value := 1;
end;

procedure TRptEsfForm.ReportBeforeStart;
begin
     With Report do
       begin
       CabeceraTable  := CreateEmptyTable( 'Cabecera', SQLSet.GetSQLText( 'Cabecera' ) );
       CabeceraFields := TCabeceraFields.create( CabeceraTable );

       LineasTable  := CreateEmptyTable( 'Lineas', SQLSet.GetSQLText( 'Lineas' ) );
       LineasFields := TLineasFields.create( LineasTable );

       SeleccionaRegistros;

       SetValue( 'TextoPeriodicidad', PeriodicidadCtrl.Text );
       end;
end;

procedure TRptEsfForm.EntidadCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Banco.Valida( Sender, DisplayValue, ErrorText, Error, BancoFields, True );
end;

procedure TRptEsfForm.SeleccionaRegistros;

var   FechaPeriodo : TDateTime;
      CodigosEntidadList : TStringList;
      Index : Integer;

function ObtenFechaPeriodo( Date : TDateTime ) : TDateTime;

var  Day, Year, Month : Word;

begin
     DecodeDate( Date, Year, Month, Day );
     If   DataPeriodicidad.Value=0
     then Result := Date
     else If   DayOf( Date )<=15
          then Result := EncodeDate( Year, Month, 15 )
          else Result := EncodeDate( Year, Month, DaysInAMonth( Year, Month ) );
end;

procedure InsertaCabecera( Subcuenta   : String;
                           Descripcion : String;
                           Limite      : Decimal );
begin
     If   not CodigosEntidadList.Find( Subcuenta, Index )
     then With CabeceraTable do
            begin
            Append;
            CabeceraFields.Subcuenta.Value := Subcuenta;
            CabeceraFields.Descripcion.Value := Descripcion;
            CabeceraFields.Entidad.Value := BancoFields.Subcuenta.Value;
            CabeceraFields.NombreEntidad.Value := Banco.Descripcion( BancoFields.Subcuenta.Value, True );
            CabeceraFields.Saldo.Value := Saldos.SaldoPeriodo( Subcuenta, '', True, ApplicationContainer.Ejercicio, 0, ApplicationContainer.NroMesFinal ).Saldo;
            CabeceraFields.Limite.Value := Limite;
            Post;
            CodigosEntidadList.Add( Subcuenta );
            end;
end;

begin

     ApplicationContainer.StartProgression( EfectoCobrarTable.RecordCount );

     CodigosEntidadList := TStringList.Create;

     try

       CodigosEntidadList.Sorted := True;

       With BancoTable do
         begin
         SetRange( [ DataEntidadInicial.Value ], [ DataEntidadFinal.Value ] );
         First;
         While not Eof do
           begin

           CodigosEntidadList.Clear;  // limpio la lista de códigos de entidad

           With DisponibilidadTable do
             begin
             SetRange( [ BancoFields.Subcuenta.Value, 1 ], [ BancoFields.Subcuenta.Value, MaxSmallint ] );
             First;
             If   Eof
             then InsertaCabecera( BancoFields.Subcuenta.Value, BancoFields.Nombre.Value, BancoFields.Riesgo.Value )
             else While not Eof do
                    begin
                    InsertaCabecera( DisponibilidadFields.Subcuenta.Value,
                                     Cuenta.Descripcion( DisponibilidadFields.Subcuenta.Value, True, False ),
                                     DisponibilidadFields.Limite.Value );
                    Next;
                    end;

             end;

           LineasTable.IndexFieldNames := 'Entidad;Fecha';

           //** 28.12.2006 Utilizo las funciones de efectos pendientes ( EfectoCobrar.Pendiente y EfectoPagar.Pendiente )

           // Seleccionando efectos a cobrar pendientes de cobro

           With EfectoCobrarTable do
             begin
             SetRange( [ DataVencimientoInicial.Value ], [ DataVencimientoFinal.Value ] );
             First;
             While not Eof do
               begin

               If   EfectoCobrarFields.NroRemesa.Value=0
               then If   CodigosEntidadList.Find( EfectoCobrarFields.SubcuentaEntidad.Value, Index )
                    then If   EfectoCobrar.EfectoPendiente( EfectoCobrarFields )
                         then With LineasFields do
                                begin
                                FechaPeriodo := ObtenFechaPeriodo( EfectoCobrarFields.FechaVencimiento.Value );
                                If   LineasTable.FindKey( [ EfectoCobrarFields.SubcuentaEntidad.Value, FechaPeriodo ] )
                                then begin
                                     LineasTable.Edit;
                                     ImporteCobro.Value := ImporteCobro.Value + EfectoCobrarFields.Importe.Value;
                                     end
                                else begin
                                     LineasTable.Append;

                                     Entidad.Value := EfectoCobrarFields.SubcuentaEntidad.Value;
                                     Fecha.Value := FechaPeriodo;
                                     ImporteCobro.Value := EfectoCobrarFields.Importe.Value;
                                     Propietario.Value := EfectoCobrarFields.SubcuentaCliente.Value;
                                     Concepto.Value := EfectoCobrarFields.Concepto.Value;
                                     NroFactura.Value := EfectoCobrarFields.NroFactura.Value;
                                     Serie.Value := EfectoCobrarFields.Serie.Value;
                                     NroEfecto.Value := EfectoCobrarFields.NroEfecto.Value;
                                     end;

                                LineasTable.Post;
                                end;

               ApplicationContainer.ShowProgression;

               Next;
               end;

             end;

           // Seleccionando efectos a pagar pendientes de pago

           With EfectoPagarTable do
             begin
             SetRange( [ DataVencimientoInicial.Value ], [ DataVencimientoFinal.Value ] );
             First;
             While not Eof do
               begin

               If   CodigosEntidadList.Find( EfectoPagarFields.SubcuentaEntidad.Value, Index )
               then If   EfectoPagar.EfectoPendiente( EfectoPagarFields )
                    then  With LineasFields do
                            begin
                            FechaPeriodo := ObtenFechaPeriodo( EfectoPagarFields.FechaVencimiento.Value );
                            If   LineasTable.FindKey( [ EfectoPagarFields.SubcuentaEntidad.Value, FechaPeriodo ] )
                            then begin
                                 LineasTable.Edit;
                                 ImportePago.Value := ImportePago.Value + EfectoPagarFields.Importe.Value;
                                 end
                            else begin
                                 LineasTable.Append;
                                 Entidad.Value := EfectoPagarFields.SubcuentaEntidad.Value;
                                 Fecha.Value := FechaPeriodo;
                                 ImportePago.Value := EfectoPagarFields.Importe.Value;
                                 Propietario.Value := EfectoPagarFields.SubcuentaProveedor.Value;
                                 Concepto.Value := EfectoPagarFields.Concepto.Value;
                                 NroFactura.Value := EfectoPagarFields.NroFactura.Value;
                                 Serie.Value := EfectoPagarFields.Serie.Value;
                                 NroEfecto.Value := EfectoPagarFields.NroEfecto.Value;
                                 end;

                           LineasTable.Post;
                           end;

               ApplicationContainer.ShowProgression;

               Next;
               end;

             end;

           ApplicationContainer.ShowProgression;

           Next;
           end;

         end;

       ApplicationContainer.EndProgression;

     finally
       CodigosEntidadList.Free;
       end;

end;

procedure TRptEsfForm.FormManagerOkButton;
begin
     Report.Launch;
end;

procedure TRptEsfForm.EntidadCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaBancos( Sender );
end;

end.
