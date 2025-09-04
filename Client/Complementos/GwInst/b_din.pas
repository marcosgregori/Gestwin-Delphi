unit b_din;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons;

type
  TDiscoInicialForm = class(TForm)
    MessageLabel: TLabel;
    Label2: TLabel;
    NroDiscosCtrl: TComboBox;
    acceptBtn: TBitBtn;
    Bevel1: TBevel;
  private
    { Private declarations }
  public
    { Public declarations }

    constructor create( aOwner : TComponent; unNroDiscos : byte );
  end;

var
  DiscoInicialForm: TDiscoInicialForm;

implementation

{$R *.DFM}

resourceString
     rsMsg1  = 'Esta aplicaci�n utiliza %d discos de distribuci�n. Indique en que n�mero de disco desea iniciar la copia :';

constructor TDiscoInicialForm.create( aOwner : TComponent; unNroDiscos : byte );

var  index : byte;

begin
     inherited create( aOwner );
     messageLabel.caption := format( rsMsg1, [ unNroDiscos ] );
     For index := 1 to unNroDiscos do
       nroDiscosCtrl.items.add( intToStr( index ) );
     nroDiscosCtrl.itemIndex := 0;
end;

end.
