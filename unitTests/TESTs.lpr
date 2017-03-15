program TESTs;

{$mode objfpc}{$H+}

uses
  Interfaces, Forms, GuiTestRunner, fpcunittestrunner,


uTST_001_srcTree_itemROOT__BaseDIR, uTST_001_srcTree_itemROOT__fnd_relPATH_000,
uTST_003_srcTree_itemROOT__get_relPATH_a_b_c,
uTST_003_srcTree_itemROOT__get_relPATH_a_b_c__xn,
uTST_003_srcTree_itemROOT__get_relPATH_W_b_c__xn,
uTST_003_srcTree_itemROOT__get_relPATH_a_W_c__xn,
uTST_003_srcTree_itemROOT__get_relPATH_a_b_W__xn,
uTST_004_srcTree_itemROOT__get_relPATH_a_ab_abc,
uTST_004_srcTree_itemROOT__get_relPATH_abc_ab_a,
uTST_004_srcTree_itemROOT__get_relPATH_ab_ac_ad,
uTST_004_srcTree_itemROOT__realCase_001, in0k_srcTree_getRelPATH,
in0k_srcTree_fndRelPATH, in0k_srcTree_fndBaseDIR, in0k_srcTree_setBaseDIR;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TGuiTestRunner, TestRunner);
  Application.Run;
end.

