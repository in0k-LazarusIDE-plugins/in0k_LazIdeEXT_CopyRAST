unit lazExt_CopyRAST_node_Folder;

{$mode objfpc}{$H+}

interface

uses lazExt_CopyRAST_node, lazExt_CopyRAST_StrConsts,
  sysutils, LazFileUtils;

type


 eCopyRAST_node_SrchPath=(CopyRAST_node_SrchPTH__Fu,CopyRAST_node_SrchPTH__Fi,CopyRAST_node_SrchPTH__Fl);
 sCopyRAST_node_SrchPath=set of eCopyRAST_node_SrchPath;


 tCopyRAST_node_Folder=class(tCopyRAST_node)
  protected
   _Paths_:sCopyRAST_node_SrchPath;
  protected
    function _isABSOLUTE_:boolean;
    function _getCaption_:string; override;
    function _getDirNAME_:string;
  public
    property DirNAME:string read _getDirNAME_;
    property DirPATH:string read _nodeText_;
    property inPATHs:sCopyRAST_node_SrchPath read _Paths_;
  public
    constructor Create(const Path:string);
  public
    procedure Add_PathType(const PathType:eCopyRAST_node_SrchPath);
    procedure ins_ChldLast(const node:tCopyRAST_node);
  end;

 tCopyRAST_node_BaseDIR=class(tCopyRAST_node_Folder)
  protected
    //function _getCaption_:string; override;
  end;


 tCopyRAST_node_PathDIR=class(tCopyRAST_node_Folder)
//   _PathTypes_:sCopyRAST_node_SrchPath;
    function _getPathNames_:string;
  public
    //property PathNames:string read _getPathNames_;
  public
    constructor Create(const Path:string);
//    procedure AddPathType(const PathType:eCopyRAST_node_SrchPath);
  end;


//---


 tCopyRAST_node_PathPKG=class(tCopyRAST_node_PathDIR)
  end;


implementation

constructor tCopyRAST_node_Folder.Create(const Path:string);
begin
    inherited Create(Path);
   _Paths_:=[];
end;

function tCopyRAST_node_Folder._getCaption_:string;
begin
    result:=_getDirNAME_;
    //---
    if _Paths_<>[] then begin
        result:=result+' SP';
    end;
end;

function tCopyRAST_node_Folder._getDirNAME_:string;
begin
    if _isABSOLUTE_ then result:=ExtractFilePath(_nodeText_)
    else result:=ExtractFileName(_nodeText_);//   ExtractFileDir(_nodeText_);
end;

function tCopyRAST_node_Folder._isABSOLUTE_:boolean;
begin
    result:=FilenameIsAbsolute(_nodeText_);
end;

procedure tCopyRAST_node_Folder.ins_ChldLast(const node:tCopyRAST_node);
begin
   _ins_ChldLast_(node);
end;

procedure tCopyRAST_node_Folder.Add_PathType(const PathType:eCopyRAST_node_SrchPath);
begin
    Include(_Paths_,PathType);
end;

//----

{function tCopyRAST_node_BaseDIR._getCaption_:string;
begin
   result:=_nodeText_;
end;}

constructor tCopyRAST_node_PathDIR.Create(const Path:string);
begin
    inherited Create(Path);
//   _PathTypes_:=[];
end;

{procedure tCopyRAST_node_PathDIR.AddPathType(const PathType:eCopyRAST_node_SrchPath);
begin
    Include(_PathTypes_,PathType);
end;}

function tCopyRAST_node_PathDIR._getPathNames_:string;
begin
{    result:='';
    if _PathTypes_<>[] then begin
        result:=result+cRes_NodeName_includeIn;
        if CopyRAST_node_SrchPTH__Fu in _PathTypes_ then result:=result+LineEnding+'    '+cRes_NodeName_OtherUnitFiles;
        if CopyRAST_node_SrchPTH__Fi in _PathTypes_ then result:=result+LineEnding+'    '+cRes_NodeName_IncFiles;
        if CopyRAST_node_SrchPTH__Fl in _PathTypes_ then result:=result+LineEnding+'    '+cRes_NodeName_Libraries;
        result:=result+LineEnding;
    end;}
end;


end.

