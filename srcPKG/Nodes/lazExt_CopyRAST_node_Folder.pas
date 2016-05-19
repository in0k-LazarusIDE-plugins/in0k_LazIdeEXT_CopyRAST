unit lazExt_CopyRAST_node_Folder;

{$mode objfpc}{$H+}

interface

uses lazExt_CopyRAST_node, lazExt_CopyRAST_StrConsts,
  sysutils, LazFileUtils;

type


 tCopyRAST_node_Dir=class(tCopyRAST_node)
  end;

 tCopyRAST_node_Dir_BASE=class(tCopyRAST_node_Dir)
  end;

 eCopyRAST_node_Path=(eCopyRAST_node_Path_Fu,eCopyRAST_node_Path_Fi,eCopyRAST_node_Path_Fl);
 sCopyRAST_node_Path=set of eCopyRAST_node_Path;

 tCopyRAST_node_Dir_Path=class(tCopyRAST_node)
  protected
   _PathTypes_:sCopyRAST_node_Path;
    function _getPathNames_:string;
    function _getCaption_:string; override;
  public
    property PathNames:string read _getPathNames_;
  public
    constructor Create(const Path:string);
    procedure AddPathType(const PathType:eCopyRAST_node_Path);
  end;


//---


 tCopyRAST_node_PathPKG=class(tCopyRAST_node_Dir_Path)
  end;


implementation

constructor tCopyRAST_node_Dir_Path.Create(const Path:string);
begin
    inherited Create(Path);
   _PathTypes_:=[];
end;

procedure tCopyRAST_node_Dir_Path.AddPathType(const PathType:eCopyRAST_node_Path);
begin
    Include(_PathTypes_,PathType);
end;

function tCopyRAST_node_Dir_Path._getPathNames_:string;
begin
    result:='';
    if _PathTypes_<>[] then begin
        result:=result+cRes_NodeName_includeIn;
        if eCopyRAST_node_Path_Fu in _PathTypes_ then result:=result+LineEnding+'    '+cRes_NodeName_OtherUnitFiles;
        if eCopyRAST_node_Path_Fi in _PathTypes_ then result:=result+LineEnding+'    '+cRes_NodeName_IncFiles;
        if eCopyRAST_node_Path_Fl in _PathTypes_ then result:=result+LineEnding+'    '+cRes_NodeName_Libraries;
        result:=result+LineEnding;
    end;
end;

function tCopyRAST_node_Dir_Path._getCaption_:string;
begin
    result:=ExtractFileName(_nodeText_);//   ExtractFileDir(_nodeText_);
end;



end.

