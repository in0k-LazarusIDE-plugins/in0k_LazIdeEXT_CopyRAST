unit in0k_CopyRAST__wndCORE_00;

{$mode objfpc}{$H+}

interface

uses syncobjs,
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs;

type

 { TForm4 }

 TForm4 = class(TForm)
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  strict private
    //_STAGEs_:tCopyRAST_STAGEs; //< объект над которым работаем
  protected
    //procedure _STAGEs_acquire_; virtual;
    //procedure _STAGEs_release_; virtual;
  end;

implementation

{$R *.lfm}

{procedure TForm4._STAGEs_acquire_(const value:tCopyRAST_STAGEs);
begin // привязываем к визуальной части
      // todo
end;}

{procedure TForm4._STAGEs_release_;
begin // отвязываем визуальную часть
      // todo
end;}

//------------------------------------------------------------------------------

procedure TForm4.FormClose(Sender: TObject; var CloseAction: TCloseAction);
//var STAGEs:tCopyRAST_STAGEs;
begin{
    CloseAction:=caFree;
   _STAGEs_release_;
   _STAGEs_.FREE;
   }
end;


end.

