unit lazExt_CopyRAST__xmlConfig_Base;

{$mode objfpc}{$H+}

interface

uses
  lazExt_CopyRAST__xmlConfig;


function  CRxC_BASE__SettingsPRESENT(const CNF:tLazExt_CopyRAST_CONFIG):boolean;

procedure CRxC_BASE__SettingsEXCLUDE(const CNF:tLazExt_CopyRAST_CONFIG; const value:boolean);
function  CRxC_BASE__SettingsEXCLUDE(const CNF:tLazExt_CopyRAST_CONFIG):boolean;

implementation

const
 _cROOT_           =cLazExt_CopyRAST__xmlConfig_SECTION;
 _cSettingsEXCLUDE_='SettingsEXCLUDE';


function CRxC_BASE__SettingsPRESENT(const CNF:tLazExt_CopyRAST_CONFIG):boolean;
begin
    result:=NOT (''=CNF.GetValue(lERxC_sctn8Name(_cROOT_,_cSettingsEXCLUDE_),''));
end;

//------------------------------------------------------------------------------

procedure CRxC_BASE__SettingsEXCLUDE(const CNF:tLazExt_CopyRAST_CONFIG; const value:boolean);
begin
    CNF.SetValue(lERxC_sctn8Name(_cROOT_,_cSettingsEXCLUDE_),VALUE);
end;

function CRxC_BASE__SettingsEXCLUDE(const CNF:tLazExt_CopyRAST_CONFIG):boolean;
begin
    result:=CNF.GetValue(lERxC_sctn8Name(_cROOT_,_cSettingsEXCLUDE_),true);
end;

end.

