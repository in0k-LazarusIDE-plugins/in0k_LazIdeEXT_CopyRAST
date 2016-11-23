unit prcNode_core_xmlEdit;

{$mode objfpc}{$H+}

interface

uses Laz2_XMLCfg, Classes, sysutils,
     CodeCache,
     LazFileUtils,
     CodeToolManager,
     lazExt_CopyRAST_node,
     Processing_CORE,
     lazExt_CopyRAST_processingNODE;

type

 tPrcNODE_core_xmlEdit=class(tPrcNODE_Base)
  protected
    CodeBuff:TCodeBuffer;
    XMLConfg:TXMLConfig;
  protected
    function doEditFile(const t_eItem:tOperationNode_TYPE; const Node:tCopyRAST_node):boolean;
    function doEditFile(const t_eItem:tOperationNode_TYPE):boolean;
  end;

 tPrcNODE_core_xmlEditDO=class(tPrcNODE_Base)
  private
    function _get_prntEdit_:tPrcNODE_core_xmlEdit;
    function _get_XMLConfg_:TXMLConfig;
  protected
    property XMLConfg:TXMLConfig read _get_XMLConfg_;
  end;

implementation

(*
function LoadXMLConfigFromCodeBuffer(const Filename: string;
  Config: TXMLConfig; out ACodeBuffer: TCodeBuffer; Flags: TLoadBufferFlags;
  ShowAbort: boolean): TModalResult;
var
  ms: TMemoryStream;
begin
  Result:=LoadCodeBuffer(ACodeBuffer,Filename,Flags,ShowAbort);
  if Result<>mrOk then begin
    Config.Clear;
    exit;
  end;
  ms:=TMemoryStream.Create;
  try
    ACodeBuffer.SaveToStream(ms);
    ms.Position:=0;
    try
      if Config is TCodeBufXMLConfig then
        TCodeBufXMLConfig(Config).KeepFileAttributes:=true;
      Config.ReadFromStream(ms);
    except
      on E: Exception do begin
        if (lbfQuiet in Flags) then begin
          Result:=mrCancel;
        end else begin
          Result:=IDEMessageDialog(lisXMLError,
            Format(lisXMLParserErrorInFileError, [Filename, LineEnding, E.Message]),
              mtError, [mbCancel]);
        end;
      end;
    end;
  finally
    ms.Free;
  end;
end;

function SaveXMLConfigToCodeBuffer(const Filename: string;
  Config: TXMLConfig; var ACodeBuffer: TCodeBuffer; KeepFileAttributes: boolean
  ): TModalResult;
var
  ms: TMemoryStream;
begin
  if ACodeBuffer=nil then begin
    if KeepFileAttributes and FileExistsCached(Filename) then
      ACodeBuffer:=CodeToolBoss.LoadFile(Filename,true,false)
    else
      ACodeBuffer:=CodeToolBoss.CreateFile(Filename);
    if ACodeBuffer=nil then
      exit(mrCancel);
  end;
  ms:=TMemoryStream.Create;
  try
    try
      Config.WriteToStream(ms);
    except
      on E: Exception do begin
        Result:=IDEMessageDialog(lisXMLError,
          Format(lisUnableToWriteXmlStreamToError, [Filename, LineEnding, E.Message]),
            mtError, [mbCancel]);
      end;
    end;
    ms.Position:=0;
    ACodeBuffer.LoadFromStream(ms);
    Result:=SaveCodeBuffer(ACodeBuffer);
  finally
    ms.Free;
  end;
end;
*)

function tPrcNODE_core_xmlEdit.doEditFile(const t_eItem:tOperationNode_TYPE; const Node:tCopyRAST_node):boolean;
var ms:TMemoryStream;

begin
    XMLConfg:=TXMLConfig.Create(nil);


    result:=TRUE; //< НЕ останавливаться на достигнутом :-)

    // Step 0: проверим ... он вообще есть? ... он не может не есть
    if NOT FileExistsUTF8(Node.Get_Target_fullName) then begin
        doEvent_on_ERROR('TARGET file NOT exists:'+'"'+Node.Get_Target_fullName+'"');
    end;
    // Step 1: load the file to CodeBuff
    CodeBuff:=CodeToolBoss.LoadFile(Node.Get_Target_fullName,true,false);
    if NOT Assigned(CodeBuff) then begin
        doEvent_on_ERROR('CodeBuffer NOT received:"'+Node.Get_Target_fullName+'"');
    end;
    // Step 2: load the file to XmlConf
    try
        ms:=TMemoryStream.Create;
        //CodeBuff.Count;

        CodeBuff.SaveToStream(ms);
        ms.Position:=0;
        XMLConfg.ReadFromStream(ms);
	except
      on E: Exception do begin
        doEvent_on_ERROR('ASDASDASDASD '+E.ToString);

	  end;
	end;
    ms.Clear;

    // Step 3: EDIT
    result:=EXECUTE_4NODE(t_eItem);


    // Step 4: Apply the changes  to CodeBuff
    XMLConfg.WriteToStream(ms);
    ms.Position:=0;
    CodeBuff.LoadFromStream(ms);
    ms.FREE;
    // Step 5: SAVE the changes
    if NOT CodeBuff.Save then begin
         doEvent_on_ERROR('CodeBuff.Save ERROR:"'+Node.Get_Target_fullName+'" ER');
    end;

    XMLConfg.Free;
    XMLConfg:=NIL;

end;

{
function LoadXMLConfigViaCodeBuffer(Filename: string): TXMLConfig;
var
  Code: TCodeBuffer;
begin
  Result:=nil;
  Code:=CodeToolBoss.LoadFile(Filename,true,false);
  if Code=nil then exit;
  try
    Result:=TCodeBufXMLConfig.CreateWithCache(Filename);
  except
    on E: Exception do begin
      debugln(['LoadXMLConfigViaCodeBuffer Filename="',Filename,'": ',E.Message]);
    end;
  end;
end;}


function tPrcNODE_core_xmlEdit.doEditFile(const t_eItem:tOperationNode_TYPE):boolean;
begin
    result:=doEditFile(t_eItem,node4Execut);
end;

//------------------------------------------------------------------------------

function tPrcNODE_core_xmlEditDO._get_prntEdit_:tPrcNODE_core_xmlEdit;
var tmp:tOperationNode_CORE;
begin
    result:=nil;
    //---
    tmp:=self.Tool_Parent;
    while Assigned(tmp) do begin
        if tmp is tPrcNODE_core_xmlEdit then begin
            result:=tPrcNODE_core_xmlEdit(tmp);
            BREAK;
		end;
        tmp:=tmp.Tool_Parent;
	end;
end;

function tPrcNODE_core_xmlEditDO._get_XMLConfg_:TXMLConfig;
var tmp:tPrcNODE_core_xmlEdit;
begin
    result:=nil;
    tmp:=_get_prntEdit_;
    if Assigned(tmp) then result:=tmp.XMLConfg;
end;


end.

