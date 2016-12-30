unit lazExt_CopyRAST_node;

{$mode objfpc}{$H+}

interface

uses lazExt_CopyRAST_StrConsts,
  srcTree_item_CORE,
  Classes, SysUtils, LazFileUtils;

type

 tCopyRAST_node=class(tSrcTree_item)
  public
    function _source_Text_:string;
  protected
    function _src_getNodeTXT_:string; virtual;
    function _src_getHintTXT_:string; virtual;
  public
    property source_Text:string read _item_Text_;    // ПОЛНЫЙ текст
    property src_NodeTXT:string read _src_getNodeTXT_; // заголовок для узла
    property src_HintTXT:string read _src_getNodeTXT_; // заголовок для узла
  public
    function nodePRNT:tCopyRAST_node;
    function nodeNext:tCopyRAST_node;
    function nodeChld:tCopyRAST_node;



  public
    //function _clc_Source_dir_Name_:string;
  public
//             get_absolute
//                 relative

    //Name
    //Path

    function Get_Source_obj_Name:string; virtual;

    function Get_Source_dir_Name:string; virtual;

    function Get_Target_obj_Name:string; virtual;
    function Get_Target_dir_Name:string; virtual;
    //---
    function Get_Source_fullName:string; virtual;
    function Get_Target_fullName:string; virtual;
  end;

implementation


//------------------------------------------------------------------------------

function tCopyRAST_node._source_Text_:string;
begin
    result:=_item_Text_;
end;

function tCopyRAST_node._src_getNodeTXT_:string;
begin
    result:=_item_Text_;
end;

function tCopyRAST_node._src_getHintTXT_:string;
begin
    result:='';
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
    if Assigned(_prnt_) then result:=tCopyRAST_node(_prnt_).Get_Source_fullName;
end;

function tCopyRAST_node.Get_Target_dir_Name:string;
begin
    result:='';
    if Assigned(_prnt_) then result:=tCopyRAST_node(_prnt_).Get_Target_fullName;
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
    result:=Get_Target_dir_Name;
    if result<>'' then result:=result+DirectorySeparator;
    result:=result+Get_Target_obj_Name;
end;


function tCopyRAST_node.nodePRNT:tCopyRAST_node;
begin
    result:=tCopyRAST_node(ItemPRNT)
end;

function tCopyRAST_node.nodeNext:tCopyRAST_node;
begin
    result:=tCopyRAST_node(ItemNEXT)
end;

function tCopyRAST_node.nodeChld:tCopyRAST_node;
begin
    result:=tCopyRAST_node(ItemCHLD)
end;



end.

