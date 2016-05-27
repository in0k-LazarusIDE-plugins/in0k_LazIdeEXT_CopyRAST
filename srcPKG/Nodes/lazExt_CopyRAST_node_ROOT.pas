unit lazExt_CopyRAST_node_ROOT;

{$mode objfpc}{$H+}

interface

uses sysutils, LazFileUtils,
    //Dialogs,
     lazExt_CopyRAST_from_IDEProcs,
     lazExt_CopyRAST_node,
     lazExt_CopyRAST_node_File,
     lazExt_CopyRAST_node_Folder;

type

 tCopyRAST_ROOT=class(tCopyRAST_node)
  protected
    function  _get_BaseDIR_:tCopyRAST_node_BaseDIR;
    procedure _set_BaseDIR_(const BaseDIR:string);
  protected
    function  _get_PathDIR_(const PathDIR:string):tCopyRAST_node_Folder;
    procedure _add_SrchPTH_(const SrchPTH:string; const KIND:eCopyRAST_node_SrchPath);
    procedure _add_FileXXX_(const FileXXX:tCopyRAST_node_File);
  end;

implementation

// поиск BaseDIR по типу
function tCopyRAST_ROOT._get_BaseDIR_:tCopyRAST_node_BaseDIR;
begin //< оно ДОЛЖНО быть в корне РЕБЕНКОМ
    result:=tCopyRAST_node_BaseDIR(_chldFrst_);
    while Assigned(result) do begin
       if TObject(Result) is tCopyRAST_node_BaseDIR then BREAK;
       result:=tCopyRAST_node_BaseDIR(tCopyRAST_node_BaseDIR(result).NodeNEXT);
    end;
end;

// установить BaseDIR
procedure tCopyRAST_ROOT._set_BaseDIR_(const BaseDIR:string);
var tmp:tCopyRAST_node_BaseDIR;
begin
    tmp:=_get_BaseDIR_;
    if not Assigned(tmp) then begin //< еще просто НЕ добавляли
        tmp:=tCopyRAST_node_BaseDIR.Create(BaseDIR);
       _ins_ChldFrst_(tmp);
    end
    else tCopyRAST_ROOT(tmp)._nodeText_:=BaseDIR;
end;

//------------------------------------------------------------------------------

function tCopyRAST_ROOT._get_PathDIR_(const PathDIR:string):tCopyRAST_node_Folder;
var prnt:tCopyRAST_node_Folder;
var tmp:tCopyRAST_node;
    fld:string;
begin
    result:=nil;
    prnt:=_get_BaseDIR_;
    if not Assigned(prnt) then EXIT; //< это КАСЯК, обработать как-то надо?
    if 0=CompareFilenames(PathDIR+PathDelim,prnt.DirPATH) then begin
        result:=prnt;
    end
    else begin
        // исчем РОДИТЕЛЬСКИЙ путь

        fld:=ExtractFileDir(PathDIR); //< это родительская директория
        //ShowMessage('fld PARENT:'+fld);
        if NOT ( (fld='')or(0=CompareFilenames(fld,prnt.DirPATH)) )
        then prnt:=_get_PathDIR_(fld); //< исчем ГЛУБЖЕ, ближе к корню

        if not Assigned(prnt) then EXIT; //< это КАСЯК, обработать как-то надо?

        // исчем в родителе СЕБЯ
        fld:=ExtractFileName(PathDIR); //< что именно искать будем
        //ShowMessage('fld SELF:'+fld);
        pointer(result):=prnt.NodeCHLD;
        while Assigned(result) do begin
            if TObject(result) is tCopyRAST_node_PathDIR then begin
                if 0=CompareFilenames(fld,result.DirNAME) then begin
                    BREAK; // НАШЛИ
                end;
            end;
            pointer(result):=result.NodeNEXT;
        end;
        //--- добавим искомый путь
        if not Assigned(result) then begin
            result:=tCopyRAST_node_PathDIR.Create(PathDIR);
            prnt.ins_ChldLast(result);
        end;
    end;
end;

// добавить ПУТИ поиска
procedure tCopyRAST_ROOT._add_SrchPTH_(const SrchPTH:string; const KIND:eCopyRAST_node_SrchPath);
var StartPos:Integer;
    singlDir:string;
    FoldrDir:tCopyRAST_node_Folder;
begin
    StartPos:=1;
    singlDir:=GetNextDirectoryInSearchPath(SrchPTH,StartPos);
    while singlDir<>'' do begin

        {todo: чет наверно как-то потестить надо}

        FoldrDir:=_get_PathDIR_(singlDir);
        if Assigned(FoldrDir) then begin
            //--- добавим найденному ТИП пути
            FoldrDir.Add_PathType(KIND);
        end;
        //-->
        singlDir:=GetNextDirectoryInSearchPath(SrchPTH,StartPos);
    end;
end;


procedure tCopyRAST_ROOT._add_FileXXX_(const FileXXX:tCopyRAST_node_File);
var prnt:tCopyRAST_node_Folder;
begin
    //ShowMessage('file PATH:'+FileXXX.FilePATH);

    prnt:=_get_PathDIR_(FileXXX.FilePATH);
    if not Assigned(prnt) then EXIT; //< это КАСЯК, обработать как-то надо?
    //-
    if FileXXX is tCopyRAST_node_fileMainPKG
    then tCopyRAST_ROOT(prnt)._ins_ChldFrst_(FileXXX)
    else prnt.ins_ChldLast(FileXXX);
    //else tCopyRAST_ROOT(prnt)._ins_ChldLast_(FileXXX);
end;

end.

