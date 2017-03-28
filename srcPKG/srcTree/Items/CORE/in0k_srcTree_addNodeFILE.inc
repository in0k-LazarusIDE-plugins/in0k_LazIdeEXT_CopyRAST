//in0k_srcTree_addNodeFILE
//function SrcTree_addNodeFILE(const item:tSrcTree_ROOT; const fileName:string; const fileKind:TPkgFileType; const crtFnc:fSrcTree_addNodeFILE_crtNodeFILE; const crtRelPATH:fSrcTree_crtRelPATH_callBACK):tSrcTree_item_fsFile;
var tmp:tSrcTree_item_fsNodeFLDR;
begin
    result:=SrcTree_fndNodeFILE(item, fileName);
    if not Assigned(result) then begin
        tmp:=SrcTree_getRelPATH(item, extractFileDir(fileName), crtRelPATH);
        {$ifOpt D+}Assert(Assigned(tmp));{$endIf}
        result:=crtFnc(fileName, fileKind);
        SrcTree_insert_ChldFrst(tmp,result);
    end;
end;

