unit in0k_CopyRAST__wndPackage;

{$mode objfpc}{$H+}

interface

uses
  in0k_CopyRAST__wndCORE,
  in0k_CopyRAST__wndCORE_00,

  in0k_CopyRAST_STAGEs,

  Classes, SysUtils, FileUtil, CheckBoxThemed, Forms,
  Controls, Graphics, Dialogs, ComCtrls, StdCtrls;

type

 { tWndCopyRAST_Package }

 tWndCopyRAST_Package = class(tWndCopyRAST_CORE)
  private

  protected
    function _copyRastObj_CRT_:tCopyRAST_STAGEs; override;
  end;


implementation

{$R *.lfm}

function tWndCopyRAST_Package._copyRastObj_CRT_:tCopyRAST_STAGEs;
begin
    result:=tCopyRAST_STAGEs_4Package.Create(_parentOBJ_);
end;

end.

