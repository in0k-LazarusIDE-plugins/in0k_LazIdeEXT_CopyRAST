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
        sysutils,
     {$endIf}

   //LazFileUtils,
   //FileUtil,
   srcTree_item_CORE,
   //srcTree_item_baseDIR,
   srcTree_item_coreROOT,

        srcTree_item_coreMAIN,
   srcTree_builder_CORE,
   //srcTree_item_coreFileSystem,
   srcTree_item_fsFolder,
   srcTree_item_fsFile,
        srcTree_item_baseDIR,
        srcTree_FNC,

        in0k_srcTree_getBaseDIR,
        in0k_srcTree_setBaseDIR,
        in0k_srcTree_setMainFILE,

        //srcTree_fnd_relPATH,
   srcTree_item_4Package,
   PackageIntf;



type

 tSrcTree_Builder_4Package=class(tSrcTree_Builder_CORE)
  protected
    function new_ROOT(const name:string):tSrcTree_ROOT; override;
    function new_Base(const name:string):tSrcTree_BASE; override;
    function new_Main(const name:string):tSrcTree_MAIN; override;
  protected
    //function Crt_BaseDIR (const MainOBJ:pointer; const ROOT:tSrcTree_ROOT):tSrcTree_BASE; override;
  protected
    function Set_ROOT(const MainOBJ:pointer                          ):tSrcTree_ROOT; override;
    function Set_Base(const MainOBJ:pointer; const ROOT:tSrcTree_ROOT):tSrcTree_BASE; override;
    function Set_Main(const MainOBJ:pointer; const ROOT:tSrcTree_ROOT):tSrcTree_MAIN; override;


    //function _make_SourceTREE_root_(const MainOBJ:pointer):tSrcTree_ROOT; override;
  end;




function srcTree_builder_4Package_MAKE(const Package:TIDEPackage):tSrcTree_Root4Package;

function srcTree_builder_4Package_MAKE(const Package:TIDEPackage; const nodeCreator:pSrcTree_builder_nodeCreator):tSrcTree_Root4Package;


implementation

function tSrcTree_Builder_4Package.new_ROOT(const name:string):tSrcTree_ROOT;
begin
    result:=tSrcTree_Root4Package.Create(name);
end;

function tSrcTree_Builder_4Package.new_Base(const name:string):tSrcTree_BASE;
begin
    result:=tSrcTree_BASE.Create(name);
end;

function tSrcTree_Builder_4Package.new_Main(const name:string):tSrcTree_MAIN;
begin
    result:=tSrcTree_Main4Package.Create(name);
end;

//------------------------------------------------------------------------------

function tSrcTree_Builder_4Package.Set_ROOT(const MainOBJ:pointer):tSrcTree_ROOT;
begin
    result:=new_ROOT(TIDEPackage(MainOBJ).Name);
end;

function tSrcTree_Builder_4Package.Set_Base(const MainOBJ:pointer; const ROOT:tSrcTree_ROOT):tSrcTree_BASE;
begin
    result:=SrcTree_setBaseDIR(ROOT, TIDEPackage(MainOBJ).DirectoryExpanded, @new_Base);
end;

function tSrcTree_Builder_4Package.Set_Main(const MainOBJ:pointer; const ROOT:tSrcTree_ROOT):tSrcTree_MAIN;
begin
    result:=SrcTree_setMainFILE(ROOT, TIDEPackage(MainOBJ).Filename, @new_Main,@new_Base);
end;






function srcTree_builder_4Package_MAKE(const Package:TIDEPackage; const nodeCreator:pSrcTree_builder_nodeCreator):tSrcTree_Root4Package;
begin

end;

function srcTree_builder_4Package_MAKE(const Package:TIDEPackage):tSrcTree_Root4Package;
var i:integer;
    s:string;
  fldr:tSrcTree_item_fsNodeFLDR;
  flNd:tSrcTree_item_fsFile;
begin
   (* {$ifOpt D+}Assert(Assigned(Package),'Package is NILL');{$endIf}

    //--------------
    {$ifDef _DEBUG_}DEBUG('srcTree_builder_4Package_MAKE','START at '+DateTimeToStr(NOW));{$endIf}
    //--------------

    {$ifDef _DEBUG_}DEBUG('srcTree_builder_4Package_MAKE','create Root4Package');{$endIf}
    result:=tSrcTree_Root4Package.Create(Package.Name);
    //--- пробиваем БАЗОВЫЙ путь
    {$ifDef _DEBUG_}DEBUG('srcTree_builder_4Package_MAKE','set BaseDIR="'+Package.DirectoryExpanded+'"');{$endIf}
    SrcTreeROOT_set_BaseDIR(result,Package.DirectoryExpanded);
    //--- главный файл
    {$ifDef _DEBUG_}DEBUG('srcTree_builder_4Package_MAKE','add MainFILE="'+Package.Filename+'"');{$endIf}
    srcTree_builder_add_MainFILE(result,tSrcTree_Main4Package.Create(Package.Filename));
    //--- пробиваем пути поиска
    {$ifDef _DEBUG_}DEBUG('srcTree_builder_4Package_MAKE','add Search Paths');{$endIf}
    srcTree_builder_add_SearchPATH_DirLIST(result,Package.LazCompilerOptions.OtherUnitFiles,SrcTree_SrchPath__Fu);
    srcTree_builder_add_SearchPATH_DirLIST(result,Package.LazCompilerOptions.IncludePath   ,SrcTree_SrchPath__Fi);
    srcTree_builder_add_SearchPATH_DirLIST(result,Package.LazCompilerOptions.Libraries     ,SrcTree_SrchPath__Fl);
    //--- пробиваем файлы проэкта
    {$ifDef _DEBUG_}DEBUG('srcTree_builder_4Package_MAKE','add used files');{$endIf}
    for i:=0 to Package.FileCount-1 do begin
        with Package.Files[i] do begin
            S:=Package.Files[i].GetShortFilename(false);
            fldr:=tSrcTree_item_fsNodeFLDR(SrcTreeROOT_fnd_relPATH(result,ExtractFileDir(S)));
            DEBUG('addFile',Filename);
            if Assigned(fldr) then begin
                flNd:=tSrcTree_item_fsFile.Create(s,Package.Files[i].FileType);
                srcTree_builder_add_FileNode(result,fldr,flNd);
						end
            else DEBUG('addFile','not found '+'"'+ExtractFileDir(S)+'"');
				end;
		end;

    //--------------
    {$ifDef _DEBUG_}DEBUG('srcTree_builder_4Package_MAKE','END at '+DateTimeToStr(NOW));{$endIf}
    //--------------   *)
end;

end.

