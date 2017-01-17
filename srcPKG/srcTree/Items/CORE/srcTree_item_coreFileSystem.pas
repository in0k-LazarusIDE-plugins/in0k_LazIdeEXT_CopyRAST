unit srcTree_item_coreFileSystem;

{$mode objfpc}{$H+}

interface

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
//< Можно смело убирать, так как будеть работать только в моей специальной
//< "системе имен и папок" `in0k_LazExt_..`.


uses //{$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}in0k_lazIdeSRC_DEBUG,{$endIf}
     srcTree_item_CORE,
     FileUtil, LazFileUtils,
    Classes, SysUtils;

type

  // элемент ФАЛОВОЙ системы (файлы, папки)
 _tStcTree_item_fsNode_=class(tSrcTree_item)
  private
    function __src_getDirName__:string;  inline;
    function __src_getObjName__:string;  inline;
    function __src_getPath__   :string;  inline;
    function __src_isABSOLUTE__:boolean; inline;
  protected
    function  _src_getDirName_ :string;  virtual;
    function  _src_getObjName_ :string;  virtual;
  protected
    function  _get_ItemHint_:string;     override;
  public
    property   src_Absolute :boolean read __src_isABSOLUTE__;
    property   src_PATH     :string  read __src_getPath__;    // полный путь (src_Dir+'/'+src_Name)
    property   src_DirName  :string  read __src_getDirName__; // название директории в которой распологаемся (НЕ ДОЛЖЕН содержать завершающий '/')
    property   src_Name     :string  read __src_getObjName__; // наше СОБСТВЕННОЕ название
  public
    constructor Create(const Text:string); override;
  end;

 _tSrcTree_item_fsNodeFILE_=class(_tStcTree_item_fsNode_)
  protected
    function _get_ItemName_:string; override;
  protected
    function _src_getDirName_:string; override;
    function _src_getObjName_:string; override;
  end;

 _tSrcTree_item_fsNodeFLDR_=class(_tStcTree_item_fsNode_)
  protected
    function _get_ItemName_:string; override;
  protected
    function _src_getDirName_:string; override;
    function _src_getObjName_:string; override;
  end;

 _tSrcTree_item_fsBaseDIR_=class(_tSrcTree_item_fsNodeFLDR_);

implementation

{%region --- возня с ДЕБАГОМ -------------------------------------- /fold}
{$if defined(in0k_lazExt_CopyRAST_wndCORE___DebugLOG) AND declared(in0k_lazIde_DEBUG)}
    // `in0k_lazIde_DEBUG` - это функция ИНДИКАТОР что используется
    //                       моя "система имен и папок"
    {$define _debug_}     //< типа да ... можно делать ДЕБАГ отметки
{$else}
    {$undef _debug_}
{$endIf}
{%endregion}


constructor _tStcTree_item_fsNode_.Create(const Text:string);
begin
    inherited Create(ChompPathDelim(Text));
end;

//------------------------------------------------------------------------------

function _tStcTree_item_fsNode_.__src_getDirName__:string;
begin
    result:=ChompPathDelim(_src_getDirName_);
end;

function _tStcTree_item_fsNode_.__src_getObjName__:string;
begin
    result:=ChompPathDelim(_src_getObjName_)
end;

function _tStcTree_item_fsNode_.__src_getPath__:string;
begin
    if (__src_getDirName__<>'') and (__src_getObjName__<>'')
    then result:=DirectorySeparator
    else result:='';
    result:=__src_getDirName__+result+__src_getObjName__;
end;

function _tStcTree_item_fsNode_.__src_isABSOLUTE__:boolean;
begin
    result:=FilenameIsAbsolute(__src_getPath__);
end;

//------------------------------------------------------------------------------

function _tStcTree_item_fsNode_._src_getDirName_:string;
var tmp:tSrcTree_item;
begin
    result:='';
    //--- ищем родителя типа _tStcTree_item_fsNode_
    tmp:=ItemPRNT;
    while Assigned(tmp) and not (ItemPRNT is _tStcTree_item_fsNode_) do tmp:=tmp.ItemPRNT;
    //---
    if Assigned(tmp) then begin // ага ... есть таки у кого спросить
        if ItemPRNT is _tSrcTree_item_fsBaseDIR_ then result:=''
        else begin
            // тока в случае с fsNodeDIR берем его ПОЛНЫЙ путь
            if ItemPRNT is _tSrcTree_item_fsNodeFLDR_
            then result:=_tSrcTree_item_fsNodeFLDR_(ItemPRNT).src_PATH
            else result:=_tStcTree_item_fsNode_   (ItemPRNT).src_DirName;
        end;
		end;
end;

function _tStcTree_item_fsNode_._src_getObjName_:string;
begin
    result:='';
end;

//------------------------------------------------------------------------------

function _tStcTree_item_fsNode_._get_ItemHint_:string;
begin
    result:=src_PATH;
end;


//==============================================================================

function _tSrcTree_item_fsNodeFLDR_._src_getDirName_:string;
begin
    result:=inherited;
end;

function _tSrcTree_item_fsNodeFLDR_._src_getObjName_:string;
var tmp:string;
begin
    tmp:=src_DirName;
		if FileIsInPath(_item_Text_,tmp) then begin

        result:=CreateRelativePath(_item_Text_,tmp);

        //result:=_item_Text_;

        {ChompPathDelim(
        );}

        //delete(result,1,Length(tmp));
		end
    else begin
        result:=_item_Text_;// ExtractFileName(ExtractFileDir(_item_Text_));
		end;
end;

//------------------------------------------------------------------------------

function _tSrcTree_item_fsNodeFLDR_._get_ItemName_:string;
begin
    result:=_src_getObjName_;
end;

//==============================================================================

function _tSrcTree_item_fsNodeFILE_._get_ItemName_:string;
begin
    result:=_src_getObjName_;
end;

function _tSrcTree_item_fsNodeFILE_._src_getDirName_:string;
begin
    result:=inherited;
end;

function _tSrcTree_item_fsNodeFILE_._src_getObjName_:string;
begin
    result:=ExtractFileName(_item_Text_);
end;

end.
