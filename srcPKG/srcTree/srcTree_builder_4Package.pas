unit srcTree_builder_4Package;

{$mode objfpc}{$H+}

interface

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
//< Можно смело убирать, так как будеть работать только в моей специальной
//< "системе имен и папок" `in0k_LazExt_..`.


{$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}
    {$define _DEBUG_}
{$endIf}

uses {$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}
        in0k_lazIdeSRC_DEBUG,
     {$endIf}

   LazFileUtils,
   FileUtil,
   sysutils,
   srcTree_item_CORE,
   srcTree_item_baseDIR,
   srcTree_item_coreROOT,
   srcTree_builder_CORE,
   srcTree_item_coreFileSystem,
   srcTree_item_fsFolder,

   srcTree_item_root4Package,
   srcTree_item_main4Package,

   PackageIntf;



function srcTree_builder_4Package_MAKE(const Package:TIDEPackage):tSrcTree_Root4Package;

implementation

function srcTree_builder_4Package_MAKE(const Package:TIDEPackage):tSrcTree_Root4Package;
var i:integer;
    s:string;
  fldr:tSrcTree_item_fsNodeFLDR;
  flNd:_tSrcTree_item_fsNodeFILE_;
begin
    {$ifOpt D+}Assert(Assigned(Package),'Package is NILL');{$endIf}
    result:=tSrcTree_Root4Package.Create(Package.Name);
    //--- пробиваем БАЗОВЫЙ путь
    SrcTreeROOT_set_BaseDIR(result,Package.DirectoryExpanded);
    //
    //fldr:=;
    //if Assigned(fldr) then begin
        //flNd:=
        srcTree_builder_add_MainFILE(result,tSrcTree_Main4Package.Create(Package.Filename));
  	//end;
    //--- пробиваем пути поиска
    srcTree_builder_add_SearchPATH_DirLIST(result,Package.LazCompilerOptions.OtherUnitFiles,SrcTree_SrchPath__Fu);
    srcTree_builder_add_SearchPATH_DirLIST(result,Package.LazCompilerOptions.IncludePath   ,SrcTree_SrchPath__Fi);
    srcTree_builder_add_SearchPATH_DirLIST(result,Package.LazCompilerOptions.Libraries     ,SrcTree_SrchPath__Fl);
    //--- пробиваем файлы проэкта
    for i:=0 to Package.FileCount-1 do begin
        with Package.Files[i] do begin
            S:=Package.Files[i].GetShortFilename(false);
            fldr:=tSrcTree_item_fsNodeFLDR(SrcTreeROOT_fnd_relPATH(result,ExtractFileDir(S)));
            DEBUG('addFile',Filename);
            if Assigned(fldr) then begin
                flNd:=_tSrcTree_item_fsNodeFILE_.Create(s);
                srcTree_builder_add_FileNode(result,fldr,flNd);
						end
            else DEBUG('addFile','not found '+'"'+ExtractFileDir(S)+'"');

				end;
		end;
end;

end.

