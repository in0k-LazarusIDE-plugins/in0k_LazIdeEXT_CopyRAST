unit lazExt_CopyRAST_node_ROOT;

{$mode objfpc}{$H+}

interface

uses lazExt_CopyRAST_node,
     lazExt_CopyRAST_node_Folder;

type

  tCopyRAST_ROOT_BaseDIR=class(tCopyRAST_node_Dir) //<

   end;


 tCopyRAST_ROOT=class(tCopyRAST_node)


  protected
    function _get_BaseDIR_:tCopyRAST_ROOT_BaseDIR;
  public

    procedure set_BaseDIR(const BaseDIR:string);


  end;

implementation

// поиск BaseDIR по типу
function tCopyRAST_ROOT._get_BaseDIR_:tCopyRAST_ROOT_BaseDIR;
begin
    result:=tCopyRAST_ROOT_BaseDIR(_chldFrst_);
    while Assigned(result) do begin
       if TObject(Result) is tCopyRAST_ROOT_BaseDIR then BREAK;
       result:=tCopyRAST_ROOT_BaseDIR(tCopyRAST_ROOT_BaseDIR(result)._next_);
    end;
end;

// установить BaseDIR
procedure tCopyRAST_ROOT.set_BaseDIR(const BaseDIR:string);
var tmp:tCopyRAST_ROOT_BaseDIR;
begin
    tmp:=_get_BaseDIR_;
    if not Assigned(tmp) then begin //< еще просто НЕ добавляли
        tmp:=tCopyRAST_ROOT_BaseDIR.Create(BaseDIR);
       _ins_ChldFrst_(tmp);
    end
    else tmp._nodeText_:=BaseDIR;
end;

end.

