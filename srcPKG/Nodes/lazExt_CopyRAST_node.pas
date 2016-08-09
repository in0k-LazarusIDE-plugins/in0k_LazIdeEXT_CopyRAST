unit lazExt_CopyRAST_node;

{$mode objfpc}{$H+}

interface

uses lazExt_CopyRAST_StrConsts,
  Classes, SysUtils, LazFileUtils;

type

 tCopyRAST_node=class
  protected
   _prnt_:tCopyRAST_node;
   _next_:tCopyRAST_node;
   _chld_:tCopyRAST_node;
  protected
   _nodeText_:string;
    function _getCaption_:string; virtual;
  public
    property Caption:string read _getCaption_; // заголовок для узла
    property NodeTXT:string read _nodeText_;   // ПОЛНЫЙ текст
  public
    property NodePRNT:tCopyRAST_node read _prnt_;
    property NodeNEXT:tCopyRAST_node read _next_;
    property NodeCHLD:tCopyRAST_node read _chld_;
  protected
    function  _chldFrst_:tCopyRAST_node;
    function  _chldLast_:tCopyRAST_node;
  protected
    procedure _ins_nodeAfte_(const node:tCopyRAST_node);
    procedure _ins_ChldFrst_(const node:tCopyRAST_node);
    procedure _ins_ChldLast_(const node:tCopyRAST_node);
  public
    constructor Create(const nodeText:string);
    destructor DESTROY; override;
  public
    //function _clc_Source_dir_Name_:string;
  public
    function Get_Source_obj_Name:string; virtual;
    function Get_Source_dir_Name:string; virtual;
    function Get_Target_obj_Name:string; virtual;
    function Get_Target_dir_Name:string; virtual;
    //---
    function Get_Source_fullName:string; virtual;
    function Get_Target_fullName:string; virtual;
  end;

implementation

constructor tCopyRAST_node.Create(const nodeText:string);
begin
   _nodeText_:=nodeText;
   _prnt_    :=nil;
   _next_    :=nil;
   _chld_    :=nil;
end;

destructor tCopyRAST_node.DESTROY;
begin
   _nodeText_:=''; //< наследие мифов
   _prnt_    :=nil;
   _next_    :=nil;
   _chld_    :=nil;
end;

//------------------------------------------------------------------------------

function tCopyRAST_node._getCaption_:string;
begin
    result:=_nodeText_;
end;

//------------------------------------------------------------------------------

function tCopyRAST_node._chldFrst_:tCopyRAST_node;
begin
    result:=_chld_;
end;

function tCopyRAST_node._chldLast_:tCopyRAST_node;
begin
    result:=_chld_;
    while Assigned(result) do begin
        if not Assigned(result._next_) then break;
        result:=result._next_;
    end;
end;

//------------------------------------------------------------------------------

procedure tCopyRAST_node._ins_nodeAfte_(const node:tCopyRAST_node);
begin
    {$IfOpt D+}Assert(Assigned(node));{$endIf}
    node._prnt_:=self._prnt_;
    node._next_:=self._next_;
    self._next_:=node;
end;

procedure tCopyRAST_node._ins_ChldFrst_(const node:tCopyRAST_node);
begin
    {$IfOpt D+}Assert(Assigned(node));{$endIf}
    node._prnt_:=self;
    node._next_:=self._chld_;
    self._chld_:=node;
end;

procedure tCopyRAST_node._ins_ChldLast_(const node:tCopyRAST_node);
var tmp:tCopyRAST_node;
begin
    {$IfOpt D+}Assert(Assigned(node));{$endIf}
    tmp:=_chldLast_;
    if Assigned(tmp) then tmp._ins_nodeAfte_(node)
    else self._ins_ChldFrst_(node);
end;


//------------------------------------------------------------------------------

function tCopyRAST_node.Get_Source_obj_Name:string;
begin
    result:='';
end;

function tCopyRAST_node.Get_Target_obj_Name:string;
begin
    result:='';
end;

function tCopyRAST_node.Get_Source_dir_Name:string;
begin
    result:='';
    if Assigned(_prnt_) then result:=_prnt_.Get_Source_fullName;
end;

function tCopyRAST_node.Get_Target_dir_Name:string;
begin
    result:='';
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tCopyRAST_node.Get_Source_fullName:string;
begin
    result:=Get_Source_dir_Name;
    if result<>'' then result:=result+DirectorySeparator;
    result:=result+Get_Source_obj_Name;
end;

function tCopyRAST_node.Get_Target_fullName:string;
begin
    result:=Get_Target_dir_Name+DirectorySeparator+Get_Target_obj_Name;
end;



end.

