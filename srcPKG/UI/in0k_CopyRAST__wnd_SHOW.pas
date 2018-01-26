unit in0k_CopyRAST__wnd_SHOW;

{$mode objfpc}{$H+}

interface

uses
  ProjectIntf, PackageIntf,
  //
  in0k_CopyRAST__wndCORE,
  in0k_CopyRAST__wndPackage,
  in0k_CopyRAST__wndProject,
  //
  Forms;

// найти (создать), инициализировать и показать форму для объектов-Аргументов
function WndCopyRAST_SHOW(const ideObject:tObject; const ideWindow:tCustomForm):TCustomForm;

implementation

function WndCopyRAST_SHOW(const ideObject:tObject; const ideWindow:tCustomForm):TCustomForm;
var i:integer;
begin
    //{$ifOpt D+}
    //Assert(Assigned(ideObject));
    //{/$endIf}
    result:=nil;
    // ищем, может она УЖЕ создана
    for i:=0 to Screen.FormCount-1 do begin
        result:=Screen.Forms[i];
        if result is tWndCopyRAST_CORE then begin
            if tWndCopyRAST_CORE(result).ideOBJ=ideObject then begin
                BREAK;
            end;
        end;
        result:=nil;
    end;
    // если НЕ нашли ... создаем
    if not Assigned(result) then begin
        if TObject(ideObject) is TLazProject then begin
            result:=tWndCopyRAST_Progect.Create(Application,ideObject);
        end
       else
        if TObject(ideObject) is TIDEPackage then begin
            result:=tWndCopyRAST_Package.Create(Application,ideObject);
        end
       else begin
            {todo:что-то про ошибку надо}
        end;
    end;
    // и наконец показываем
    if Assigned(result) then begin
        tWndCopyRAST_CORE(result).ideWND:=ideWindow;
        Result.Show;
        Result.BringToFront;
    end;
end;

end.

