//function SrcTree_getRelPATH(const item:tSrcTree_ROOT; const folder:string; const crtFnc:fSrcTree_crtRelPATH_callBACK):tSrcTree_item_fsNodeFLDR;
var lstDir:_tSrcTree_item_fsNodeFLDR_;
    mdlDir: string;
begin
    //--- прямой поиск, а вдруг оно уже есть
    result:=tSrcTree_item_fsNodeFLDR(SrcTree_fndRelPATH(item,folder,lstDir,mdlDir));
    //--- создаем промежуточный, если необходимо
    while (not Assigned(result))and(mdlDir<>'')and(CompareFilenames(mdlDir,ChompPathDelim(folder))<>0) do begin
        SrcTree_getRelPATH(item,mdlDir,crtFnc);
        {$ifdef _debug_}DEBUG('SrcTree_getRelPATH','add mdlDir',mdlDir);{$endIf}
        result:=tSrcTree_item_fsNodeFLDR(SrcTree_fndRelPATH(item,folder,lstDir,mdlDir));
    end;
    //--- создаем САМУ папку, если это досих пор необходимо
    if NOT Assigned(result) then begin
        {$ifOpt D+}Assert( Assigned(lstDir) ,'Wrong Find folder "'+folder+'"');{$endIf}
        // создаем НОВУЮ, , и  НОВУЮ
        result:=crtFnc(ChompPathDelim(folder));//tSrcTree_item_fsNodeFLDR.Create(ChompPathDelim(folder));
       _move_All_Child_4fsNode_(lstDir,Result); //< перемещаем в неё все файловое
        SrcTree_insert_ChldLast(lstDir,Result); //< вставляем положенное место
        {$ifdef _debug_}DEBUG('SrcTree_getRelPATH','CRT folder',folder+' '+result.ItemTEXT+' '+result.ItemHINT);{$endIf}
    end;
end;

