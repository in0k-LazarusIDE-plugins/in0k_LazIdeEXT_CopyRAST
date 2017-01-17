unit srcTree_item_coreROOT;

{$mode objfpc}{$H+}

interface

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
//< Можно смело убирать, так как будеть работать только в моей специальной
//< "системе имен и папок" `in0k_LazExt_..`.

uses //{$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}in0k_lazIdeSRC_DEBUG,{$endIf}

     FileUtil, LazFileUtils, sysutils,

     srcTree_item_CORE,
     srcTree_item_coreFileSystem,
     srcTree_item_coreMAIN,
     srcTree_item_baseDIR,
     srcTree_item_fsFolder;

type

 tSrcTree_ROOT=class(tSrcTree_item)

  end;


function  SrcTreeROOT_fnd_BaseDIR(const item:tSrcTree_ROOT):tCopyRAST_item_BaseDIR;
function  SrcTreeROOT_get_BaseDIR(const item:tSrcTree_ROOT):tCopyRAST_item_BaseDIR;
procedure SrcTreeROOT_set_BaseDIR(const item:tSrcTree_ROOT; const baseDir:string);

//function  SrcTreeROOT_fnd_relPATH(const item:tSrcTree_ROOT; const folder:string; out lstDir:tSrcTree_item_fsNodeDIR):tSrcTree_item_fsNodeDIR;
function  SrcTreeROOT_fnd_relPATH(const item:tSrcTree_ROOT; const folder:string)                                    :tSrcTree_item_fsNodeFLDR;
function  SrcTreeROOT_get_relPATH(const item:tSrcTree_ROOT; const folder:string)                                    :tSrcTree_item_fsNodeFLDR;


procedure SrcTreeROOT_add_Main   (const item:tSrcTree_ROOT; const MainNode:tSrcTree_MAIN);
procedure SrcTreeROOT_add_File   (const item:tSrcTree_ROOT; const fldrNode:_tSrcTree_item_fsNodeFLDR_; fileNode:_tSrcTree_item_fsNodeFILE_);

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

function SrcTreeROOT_fnd_BaseDIR(const item:tSrcTree_ROOT):tCopyRAST_item_BaseDIR;
var tmp:tSrcTree_item;
begin //< оно ДОЛЖНО быть в корне РЕБЕНКОМ
    {$ifOpt D+}Assert(Assigned(item));{$endIf}
    tmp:=item.ItemCHLD;
    while Assigned(tmp) and not (tmp is tCopyRAST_item_BaseDIR) do tmp:=tmp.ItemNEXT;
    result:=tCopyRAST_item_BaseDIR(tmp);
end;

function SrcTreeROOT_get_BaseDIR(const item:tSrcTree_ROOT):tCopyRAST_item_BaseDIR;
begin
    {$ifOpt D+}Assert(Assigned(item));{$endIf}
    result:=SrcTreeROOT_fnd_BaseDIR(item);
    if not Assigned(result) then begin //< ничего страшного, его еще просто НЕ добавляли
        result:=tCopyRAST_item_BaseDIR.Create('');
        SrcTree_insert_ChldFrst(item,result);
		end;
end;

procedure SrcTreeROOT_set_BaseDIR(const item:tSrcTree_ROOT; const baseDir:string);
var tmp:tCopyRAST_item_BaseDIR;
begin
    {$ifOpt D+}Assert(Assigned(item));{$endIf}
    tmp:=SrcTreeROOT_get_BaseDIR(item);
    SrcTree_re_set_itemTEXT(tmp,baseDir);
end;

//------------------------------------------------------------------------------

function SrcTreeROOT_fnd_relPATH(const item:tSrcTree_ROOT; const folder:string; out lstDir:_tSrcTree_item_fsNodeFLDR_; out mdlDir:string):_tSrcTree_item_fsNodeFLDR_;
var fldr:string;
    tmp :tSrcTree_item;
    //s:string;
begin
    {$ifdef _debug_}DEBUG('SrcTreeROOT_fnd_relPATH',folder);{$endIf}

    {$ifOpt D+}Assert(Assigned(item));{$endIf}
    {$ifOpt D+}Assert(not FilenameIsAbsolute(folder));{$endIf}
    {$ifOpt D+}Assert(not FilenameIsAbsolute(folder));{$endIf}
    result:=nil;
    lstDir:=nil;
    mdlDir:='';
    //---
    fldr:=ChompPathDelim(folder); //< ???
    if (fldr='') then result:=SrcTreeROOT_get_BaseDIR(item)
    else begin
        // исчем РОДИТЕЛЬСКИЙ путь
        fldr:=ExtractFileDir(fldr); //< это родительская директория    //if NOT ( (fld='')or(0=CompareFilenames(fld,prnt.DirPATH)) )
        if (fldr='') or ( CompareFilenames(folder,fldr)=0 ) then result:=SrcTreeROOT_get_BaseDIR(item)
        else result:=SrcTreeROOT_fnd_relPATH(item,fldr,lstDir,mdlDir); //< исчем ГЛУБЖЕ, ближе к корню
				//
        if Assigned(result) then begin // НАШЕЛСЯ прямой родитель
            lstDir:=result;
            result:=nil;
            fldr  :=ExtractFileName( ChompPathDelim(folder) );
            //--- ищем ПРЯМОЕ попадание
            tmp :=lstDir.ItemCHLD;
            while Assigned(tmp) do begin
                if (tmp is _tSrcTree_item_fsNodeFLDR_) and //< проверяем ТОКА папки
                   (CompareFilenames(fldr,_tSrcTree_item_fsNodeFLDR_(tmp).src_Name)=0)
                then begin
                    // надо-же ... нашли ПРЯМОЕ попадание в папку !!!
                    result:=_tSrcTree_item_fsNodeFLDR_(tmp);
                    mdlDir:='';
                    BREAK;
  		 					end;
                //-->
                tmp:=tmp.ItemNEXT;
						end;
        end;
        //--- ищем просто ВХОЖДЕНИЕ
        if not Assigned(result) then begin
            fldr:=ChompPathDelim(folder);
            tmp :=lstDir.ItemCHLD;
            while Assigned(tmp) do begin
                if tmp is _tSrcTree_item_fsNodeFLDR_ then begin //< проверяем ТОКА папки
                    if (CompareFilenames(fldr,_tSrcTree_item_fsNodeFLDR_(tmp).src_Name)=0) or
                       (CompareFilenames(fldr,_tSrcTree_item_fsNodeFLDR_(tmp).src_PATH)=0)
                    then begin // нашли полное соответствие по имени или пути
                        result:=_tSrcTree_item_fsNodeFLDR_(tmp);
                        mdlDir:='';
                        BREAK;
										end
                    else begin
                        if FileIsInPath(_tSrcTree_item_fsNodeFLDR_(tmp).src_PATH,fldr)
                        then begin // нашли ВХОЖДЕНИЕ попадание в папку
                            mdlDir:=fldr;
                            BREAK;
       		 				      end
                       else
                        if FileIsInPath(fldr,_tSrcTree_item_fsNodeFLDR_(tmp).src_PATH)
                        then begin // нашли ВХОЖДЕНИЕ попадание в папку
                            lstDir:=_tSrcTree_item_fsNodeFLDR_(tmp);
                            mdlDir:='';
                            BREAK;
         		   				  end;
									  end;
								end;
								//-->
                tmp:=tmp.ItemNEXT;
  					end;
				end;
		end;
    {$ifOpt D+}Assert( Assigned(result) or ((not Assigned(result)) and Assigned(lstDir)),'Wrong result');{$endIf}

    {$ifdef _debug_}DEBUG('SrcTreeROOT_fnd_relPATH','out'+'"'+mdlDir+'"');{$endIf}
end;

function SrcTreeROOT_fnd_relPATH(const item:tSrcTree_ROOT; const folder:string):tSrcTree_item_fsNodeFLDR;
var lstDir:_tSrcTree_item_fsNodeFLDR_;
    mdlDir:string;
begin
    result:=tSrcTree_item_fsNodeFLDR(SrcTreeROOT_fnd_relPATH(item,folder,lstDir,mdlDir));
end;

//------------------------------------------------------------------------------

function SrcTreeROOT_get_relPATH(const item:tSrcTree_ROOT; const folder:string):tSrcTree_item_fsNodeFLDR;
var lstDir:_tSrcTree_item_fsNodeFLDR_;
    mdlDir:string;
    tmp0  :tSrcTree_item;
    tmp1  :tSrcTree_item;
begin
    {$ifdef _debug_}DEBUG('SrcTreeROOT_get_relPATH',folder);{$endIf}
    result:=tSrcTree_item_fsNodeFLDR(SrcTreeROOT_fnd_relPATH(item,folder,lstDir,mdlDir));
    //--- создаем промежуточный, если необходимо
    while (not Assigned(result))and(mdlDir<>'')and(CompareFilenames(mdlDir,ChompPathDelim(folder))<>0) do begin
        {$ifdef _debug_}DEBUG('SrcTreeROOT_get_relPATH_ADD',mdlDir);{$endIf}
        SrcTreeROOT_get_relPATH(item,mdlDir);
        result:=tSrcTree_item_fsNodeFLDR(SrcTreeROOT_fnd_relPATH(item,folder,lstDir,mdlDir));
		end;
    //--- создаем САМУ папку, если это досих пор необходимо
    if NOT Assigned(result) then begin
        {$ifOpt D+}Assert( Assigned(lstDir) ,'Wrong Find folder "'+folder+'"');{$endIf}
        // создаем и вставляем НОВУЮ "папку"
        result:=tSrcTree_item_fsNodeFLDR.Create(ChompPathDelim(folder));
        {$ifdef _debug_}DEBUG('CRT',folder+' '+result.ItemTEXT+' '+result.ItemHINT);{$endIf}
        SrcTree_insert_ChldLast(lstDir,Result);
        // теперь ВСЕ "файловое" (_tStcTree_item_fsNode_) что лежит в lstDir
        // и попадает по пути в folder должно быть перенесено в result
        tmp0:=lstDir.ItemCHLD;
        while Assigned(tmp0) do begin
            tmp1:=tmp0.ItemNEXT;
            //---
            if tmp0 is _tStcTree_item_fsNode_ then begin
                if FileIsInPath( _tStcTree_item_fsNode_(tmp0).src_PATH, result.src_PATH ) then begin
                    SrcTree_cut_From_Parent(tmp0);
                    SrcTree_insert_ChldLast(result,tmp0);
								end;
						end;
            //-->
            tmp0:=tmp1;
				end;
		end;
end;


//==============================================================================

procedure SrcTreeROOT_add_Main(const item:tSrcTree_ROOT; const MainNode:tSrcTree_MAIN);
begin
    SrcTree_insert_ChldFrst(SrcTreeROOT_get_BaseDIR(item),MainNode);
end;

procedure SrcTreeROOT_add_File(const item:tSrcTree_ROOT; const fldrNode:_tSrcTree_item_fsNodeFLDR_; fileNode:_tSrcTree_item_fsNodeFILE_);
begin
    SrcTree_insert_ChldLast(fldrNode,fileNode);
end;

end.

