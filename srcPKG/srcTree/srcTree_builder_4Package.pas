unit srcTree_builder_4Package;

{$mode objfpc}{$H+}

interface

uses
   srcTree_item_CORE,
   srcTree_item_baseDIR,
   srcTree_item_coreROOT,
   srcTree_item_root4Package,
   srcTree_builder_CORE,
   srcTree_item_fsFolder,
   PackageIntf;



function srcTree_builder_4Package_MAKE(const Package:TIDEPackage):tSrcTree_Root4Package;

implementation

function srcTree_builder_4Package_MAKE(const Package:TIDEPackage):tSrcTree_Root4Package;
begin
    {$ifOpt D+}Assert(Assigned(Package),'Package is NILL');{$endIf}
    result:=tSrcTree_Root4Package.Create(Package.Name);
    SrcTreeROOT_set_BaseDIR(result,Package.DirectoryExpanded);
    //---
    srcTree_builder_add_SearchPATH(result,Package.LazCompilerOptions.OtherUnitFiles,SrcTree_SrchPath__Fu);
    srcTree_builder_add_SearchPATH(result,Package.LazCompilerOptions.IncludePath   ,SrcTree_SrchPath__Fi);
    srcTree_builder_add_SearchPATH(result,Package.LazCompilerOptions.Libraries     ,SrcTree_SrchPath__Fl);
end;

end.

