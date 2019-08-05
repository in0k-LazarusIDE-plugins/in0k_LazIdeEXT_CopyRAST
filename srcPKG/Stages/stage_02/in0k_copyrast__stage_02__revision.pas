unit in0k_CopyRAST__STAGE_02__Revision;

{$mode objfpc}{$H+}

interface

uses
  Dialogs, sysutils,
  PackageIntf,
  in0k_CopyRAST_srcTree_ITEMs,
  in0k_CopyRAST_STAGEs_CORE,
  lazExt_CopyRAST__xmlConfig,
  lazExt_CopyRAST__xmlConfig__reVision__FILEs,
  in0k_CopyRAST__STAGE_02__cnfg_FILEsAdd;

type

 tCopyRast__stage_02__Revision=class(tCopyRast_SrcTree_STAGE_L_R)
  private   //< наша конфигурация
   _cnfg_FILEsADD_:tCopyRAST_HandlerCNFGs_reVision__FILEsAdd_List; //< собственные названия для ROOT
  protected //< работа с Конфигурацией
    procedure _CNFGs_INIT_;                                        override;
    procedure _CNFGs_FREE_;                                        override;
    procedure _CNFGs_LOAD_(const Configs:tLazExt_CopyRAST_CONFIG); override;
    procedure _CNFGs_SAVE_(const Configs:tLazExt_CopyRAST_CONFIG); override;
  protected //< работа
    function  EXECUTE(const srcROOT:tCopyRast_stROOT):boolean; override;
  end;


implementation

procedure tCopyRast__stage_02__Revision._CNFGs_INIT_;
begin
    inherited;
   _cnfg_FILEsADD_:=tCopyRAST_HandlerCNFGs_reVision__FILEsAdd_List.Create;
end;

procedure tCopyRast__stage_02__Revision._CNFGs_FREE_;
begin
    inherited;
   _cnfg_FILEsADD_.FREE;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tCopyRast__stage_02__Revision._CNFGs_LOAD_(const Configs:tLazExt_CopyRAST_CONFIG);
begin
    inherited;
    CRxC_rV_FInC__LIST__Load(Configs,'',_cnfg_FILEsADD_);
end;

procedure tCopyRast__stage_02__Revision._CNFGs_SAVE_(const Configs:tLazExt_CopyRAST_CONFIG);
begin
    inherited;
    //CRxC_aF2N__customerROOT__Save(Configs,'',_cnfg_FILEsADD_);
end;

//------------------------------------------------------------------------------

function tCopyRast__stage_02__Revision.EXECUTE(const srcROOT:tCopyRast_stROOT):boolean;
var i:integer;
begin
    result:=inherited;
    //

    for i:=0 to _cnfg_FILEsADD_.Count-1 do begin
        self._owner_Builder.add_FILE(self._resultROOT_, _cnfg_FILEsADD_.Items[i].fileName,pftUnit);

            //PkgFileTypeIdentToType()
      ShowMessage(inttostr(i)+' '+'"'+_cnfg_FILEsADD_.Items[i].fileName+'"');
    end;
end;

end.

