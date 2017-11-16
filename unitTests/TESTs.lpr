program TESTs;

{$mode objfpc}{$H+}

uses
  Interfaces, Forms, GuiTestRunner, fpcunittestrunner,


uTST_001_srcTree_itemROOT__BaseDIR_fnk,
uTST_001_srcTree_itemROOT__BaseDIR_mtd,
//
uTST_002_srcTree__PATH_fnd_REL,
uTST_002_srcTree__PATH_get_REL__asFND,
uTST_002_srcTree__PATH_get_REL__asNEW,
uTST_003_srcTree__PATH_fnd_ABS,
uTST_003_srcTree__PATH_get_ABS__asFND,
uTST_003_srcTree__PATH_get_ABS__asNEW,
uTST_004_srcTree__FILE_fnd_REL,

in0k_lazIdeSRC_srcTree_FNK_fsFLDR_GET;

//
//uTST_003_srcTree_itemROOT__get_relPATH_____a_b_c,
//uTST_003_srcTree_itemROOT__get_relPATH_4m__a_b_c,
//
//uTST_003_srcTree_itemROOT__get_relPATH_a_b_c__xn,
//uTST_003_srcTree_itemROOT__get_relPATH_W_b_c__xn,
//uTST_003_srcTree_itemROOT__get_relPATH_a_W_c__xn,
//uTST_003_srcTree_itemROOT__get_relPATH_a_b_W__xn,
//
//uTST_004_srcTree_itemROOT__get_relPATH_a_ab_abc,
//uTST_004_srcTree_itemROOT__get_relPATH_abc_ab_a,
//uTST_004_srcTree_itemROOT__get_relPATH_ab_ac_ad,
//uTST_004_srcTree_itemROOT__realCase_001,
//in0k_lazIdeSRC_srcTree_FNK_PATH_FND,

//uTST_005_srcTree__PATH_fnd_ABS,
//uTST_006_srcTree__PATH_fnd__inBaseDIR;
//
{in0k_lazIdeSRC_srcTree_CORE_item,
in0k_srcTree_getRelPATH,
in0k_srcTree_fndRelPATH,
in0k_srcTree_fndBaseDIR,
in0k_srcTree_setBaseDIR}


{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TGuiTestRunner, TestRunner);
  Application.Run;
end.

