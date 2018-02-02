unit in0k_lazarusIdeSRC_MacrosLIST;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;


function MacrosLIST_Count:integer;
function MacrosLIST_Value(const index:integer):string;

implementation

var _MacrosLIST_:tStrings;

function MacrosLIST_Count:integer;
begin
    result:=_MacrosLIST_.Count;
end;

function MacrosLIST_Value(const index:integer):string;
begin
    result:=_MacrosLIST_.Strings[index];
end;


(*
{%region --- определение способа поиска ----------------------- /fold}
// тут возможно в разных версиях Лазаруса придется поступать по разному
{$if     (lcl_major=1) and (lcl_minor=4) and (lcl_release=4)}
    {$WARNING 'NOT Tested in this LazarusIDE version'}
    tmp:=Sender;
{$elseif (lcl_major=1) and (lcl_minor=6) and (lcl_release=0)}
    tmp:=Sender;
{$elseif (lcl_major=1) and (lcl_minor=6) and (lcl_release=2) and (lcl_patch=0)}
    tmp:=TIDEMenuCommand(sender).MenuItem;
{$elseif (lcl_major=1) and (lcl_minor=6) and (lcl_release=4) and (lcl_patch=0)}
    tmp:=TIDEMenuCommand(sender).MenuItem;
{$elseif (lcl_major=1) and (lcl_minor=8) and (lcl_release=0)}
    tmp:=TIDEMenuCommand(sender).MenuItem;
{$else} //< способ по умолчанию
    {$WARNING 'NOT Tested in this LazarusIDE version'}
    tmp:=Sender;
{$endif}
{%endregion}
*)

{$define lm__1_8_0_6}


procedure _full_MacrosLIST_buildmanager_(const List:tStrings);
begin // добавляем ИЗВЕСТНЫЕ на данный момент НАЗВАНИЯ макросов
    {$ifDef lm__1_8_0_6}
        {%region /fold}
            // $(LazarusDir)\buildmanager.pas : TBuildManager.SetupTransferMacros
            List.Add('Project');
            List.Add('BuildMode');
            List.Add('LCLWidgetType');
            List.Add('TargetCPU');
            List.Add('TargetOS');
            List.Add('SrcOS');
            List.Add('CompPath');
            List.Add('FPCVer');
            List.Add('FPC_FULLVERSION');
            List.Add('FPCMsgFile');
            List.Add('Params');
            List.Add('ProjFile');
            List.Add('ProjPath');
            List.Add('TargetFile');
            List.Add('TargetCmdLine');
            List.Add('RunCmdLine');
            List.Add('ProjPublishDir');
            List.Add('ProjUnitPath');
            List.Add('ProjIncPath');
            List.Add('ProjSrcPath');
            List.Add('ProjOutDir');
            List.Add('Env');
            List.Add('MakeExe');
            List.Add('MakeLib');
            List.Add('Make');
            List.Add('InstantFPCCache');
            List.Add('IDEBuildOptions');
            List.Add('PrimaryConfigPath');
            List.Add('SecondaryConfigPath');
            List.Add('FallbackOutputRoot');
            List.Add('LAZVer');
        {%endregion}
    {$endIf}
end;

procedure _full_MacrosLIST_EnvironmentOptions_(const List:tStrings);
begin
    {$ifDef lm__1_8_0_6}
        {%region /fold}
            // $(LazarusDir)\EnvironmentOpts.pas : TEnvironmentOptions.InitMacros
            List.Add('FPCSrcDir');
            List.Add('LazarusDir');
            List.Add('ExeExt');
            List.Add('LanguageID');
            List.Add('LanguageName');
            List.Add('TestDir');
            List.Add('ConfDir');
            List.Add('Home');
        {%endregion}
    {$endIf}
end;

procedure _full_MacrosLIST_LazPackageGraph_(const List:tStrings);
begin
    {$ifDef lm__1_8_0_6}
        {%region /fold}
            // $(LazarusDir)\packagesystem.pas : TLazPackageGraph.Create
            List.Add('PkgDir');
            List.Add('PkgSrcPath');
            List.Add('PkgUnitPath');
            List.Add('PkgIncPath');
            List.Add('PkgName');
            List.Add('PkgOutDir');
        {%endregion}
    {$endIf}
end;

initialization
 _MacrosLIST_:=TStringList.Create;
 _full_MacrosLIST_buildmanager_      (_MacrosLIST_);
 _full_MacrosLIST_EnvironmentOptions_(_MacrosLIST_);
 _full_MacrosLIST_LazPackageGraph_   (_MacrosLIST_);

finalization;
 _MacrosLIST_.FREE;

end.

