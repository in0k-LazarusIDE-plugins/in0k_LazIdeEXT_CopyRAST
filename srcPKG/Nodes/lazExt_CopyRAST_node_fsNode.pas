unit lazExt_CopyRAST_node_fsNode;

{$mode objfpc}{$H+}

interface

uses lazExt_CopyRAST_node,
      LazFileUtils,
    Classes, SysUtils;


type

  // элемент ФАЛОВОЙ системы (файлы, папки)
 tCopyRAST_node_fsNode=class(tCopyRAST_node)
  private
    function __src_get_Dir__:string; inline;
    function __src_getName__:string; inline;
    function __src_getPath__:string; inline;
  protected
    function  _src_getDir_  :string; virtual;
    function  _src_getName_ :string; virtual;
    function  _src_getPath_ :string; virtual;
  public
    property   src_Dir      :string read __src_get_Dir__; // название директории в которой распологаемся (НЕ должен содержать завершающий '/')
    property   src_Name     :string read __src_getName__; // наше СОБСТВЕННОЕ название
    property   src_PATH     :string read __src_getPath__; // полный путь (src_Dir+'/'+src_Name)
  end;


 tCopyRAST_node_fsNodeFILE=class(tCopyRAST_node_fsNode)
  protected
    function _src_getDir_ :string; virtual;
    function _src_getName_:string; virtual;
    function _src_getPath_:string; virtual;
  end;

 tCopyRAST_node_fsNodeDIR=class(tCopyRAST_node_fsNode)
  protected
    function _src_getDir_ :string; virtual;
    function _src_getName_:string; virtual;
    function _src_getPath_:string; virtual;
  end;

implementation

function tCopyRAST_node_fsNode.__src_get_Dir__:string;
begin
    result:=ChompPathDelim(_src_getPath_);
end;

function tCopyRAST_node_fsNode.__src_getName__:string;
begin
    result:=_src_getName_;
end;

function tCopyRAST_node_fsNode.__src_getPath__:string;
begin
    result:=_src_getPath_;
end;

//------------------------------------------------------------------------------

function tCopyRAST_node_fsNode._src_getDir_ :string;
begin
    result:='';
end;

function tCopyRAST_node_fsNode._src_getName_:string;
begin
    result:='';
end;

function tCopyRAST_node_fsNode._src_getPath_:string;
begin
    result:=_src_getDir_+DirectorySeparator+_src_getName_;
end;


//==============================================================================

function tCopyRAST_node_fsNodeDIR._src_getDir_ :string;
begin

end;

function tCopyRAST_node_fsNodeDIR._src_getName_:string;
begin

end;

function tCopyRAST_node_fsNodeDIR._src_getPath_:string;
begin

end;

//==============================================================================

function tCopyRAST_node_fsNodeFILE._src_getDir_ :string;
begin

end;

function tCopyRAST_node_fsNodeFILE._src_getName_:string;
begin

end;

function tCopyRAST_node_fsNodeFILE._src_getPath_:string;
begin

end;


end.

