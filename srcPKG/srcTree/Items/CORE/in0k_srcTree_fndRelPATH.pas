unit in0k_srcTree_fndRelPATH;

{$mode objfpc}{$H+}

interface

uses
  srcTree_item_CORE,
  srcTree_item_coreFileSystem,
  srcTree_item_coreROOT,
  in0k_srcTree_fndBaseDIR,
  Classes, SysUtils, LazFileUtils;

function SrcTree_fndRelPATH(const item:tSrcTree_ROOT; const folder:string; out lstDir:_tSrcTree_item_fsNodeFLDR_; out mdlDir:string):_tSrcTree_item_fsNodeFLDR_;

implementation

function SrcTree_fndRelPATH(const item:tSrcTree_ROOT; const folder:string; out lstDir:_tSrcTree_item_fsNodeFLDR_; out mdlDir:string):_tSrcTree_item_fsNodeFLDR_;
var fldr:string;
    tmp :tSrcTree_item;
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
    if (fldr='') then begin
        result:=SrcTree_fndBaseDIR(item);
        {$ifOpt D+}Assert(Assigned(result),'BaseDIR NOT found');{$endIf}
    end
    else begin
        // исчем РОДИТЕЛЬСКИЙ путь
        fldr:=ExtractFileDir(fldr); //< это родительская директория    //if NOT ( (fld='')or(0=CompareFilenames(fld,prnt.DirPATH)) )
        if (fldr='') or ( CompareFilenames(folder,fldr)=0 ) then begin
            result:=SrcTree_fndBaseDIR(item);
            {$ifOpt D+}Assert(Assigned(result),'BaseDIR NOT found');{$endIf}
        end
        else result:=SrcTree_fndRelPATH(item,fldr,lstDir,mdlDir); //< исчем ГЛУБЖЕ, ближе к корню
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

end.

