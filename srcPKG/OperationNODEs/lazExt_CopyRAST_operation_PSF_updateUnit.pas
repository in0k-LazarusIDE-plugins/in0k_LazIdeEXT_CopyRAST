unit lazExt_CopyRAST_operation_PSF_updateUnit;
{$mode objfpc}{$H+}

interface

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
//< Можно смело убирать, так как будеть работать только в моей специальной
//< "системе имен и папок" `in0k_LazExt_..`.

{$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}
    {$define _DEBUG_}
{$endIf}

uses {$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}in0k_lazIdeSRC_DEBUG,{$endIf}
  lazExt_CopyRAST_node,  lazExt_CopyRAST_node_ROOT,
  lazExt_CopyRAST_node_File,
  FileUtil, LazFileUtils,
  CodeToolManager, CodeCache;

type

 tLazExt_CopyRAST_operation_PSF_updateUnit=class(tLazExt_CopyRAST_operation_CORE)
  protected
    function _getOperationName_:string; override;
  public
    function Is_Possible(const Node:tCopyRAST_node):boolean; override;
    function doOperation(const Node:tCopyRAST_node):boolean; override;
  end;

implementation

function tLazExt_CopyRAST_operation_PSF_updateUnit._getOperationName_:string;
begin
    result:='Pascal source files update UNIT name';
end;

//------------------------------------------------------------------------------

function tLazExt_CopyRAST_operation_PSF_updateUnit.Is_Possible(const Node:tCopyRAST_node):boolean;
begin
    result:=(node is tCopyRAST_node_File_CORE) and (FilenameIsPascalUnit(node.Get_Target_fullName));
end;

function tLazExt_CopyRAST_operation_PSF_updateUnit.doOperation(const Node:tCopyRAST_node):boolean;
var Code:TCodeBuffer;
    Tool:TCodeTool;
begin
   _mssge_:=Node.Get_Target_fullName;
    result:=FileExistsUTF8(Node.Get_Target_fullName);
    if result then begin
        //---
        Code:=CodeToolBoss.LoadFile(node.Get_Target_fullName,true,false);
        result:=Assigned(Code);
        if not result then _mssge_:='CodeBuffer:"'+_mssge_+'" NOT received';
        //---
        if result then begin
            CodeToolBoss.Explore(Code,Tool,false);
            result:=Assigned(Tool);
            if not result then _mssge_:='CodeTool:"'+_mssge_+'" NOT received'
        end;
        //---
        if result then begin
            result:=Tool.RenameSource(ExtractFileNameOnly(Node.Get_Target_obj_Name),CodeToolBoss.SourceChangeCache);
            if not result then _mssge_:='Tool.RenameSource:"'+_mssge_+'" ER';
        end;
        //---
        if result then begin
            result:=code.Save;
            if not result then _mssge_:='code.Save:"'+_mssge_+'" ER'
        end;
        //----------
        if result then begin
            _mssge_:='changes APPLIED: unit "'+ExtractFileNameOnly(Node.Get_Source_obj_Name)+'" -> "'+ExtractFileNameOnly(Node.Get_Target_obj_Name)+'" in file "'+Node.Get_Target_fullName+'"';
        end;
     end
     else begin
        _mssge_:='TARGET File:'+'"'+Node.Get_Target_fullName+'"'+' NOT exists';
     end;
end;

end.


begin
   DEBUG(node.NewFilePATH);
   try


        // Step 1: load the file and parse it
        Code:=CodeToolBoss.LoadFile(node.NewFilePATH,true,false);
        //if Code=nil then raise Exception.Create('loading failed '+Filename);
        CodeToolBoss.Explore(Code,Tool,false);
        //  if not CodeToolBoss.Explore(Code,Tool,false) then
          //  ...;// parse error ...

        // Step 2: connect the SourceChangeCache
        CodeToolBoss.SourceChangeCache.MainScanner:=Tool.Scanner;



         //Code.


          DEBUG(' ok :'+'_copyRast_FileUPDATE_File',Tool.GetCachedSourceName);
          result:=Tool.RenameSource('asdfasdfasdf',CodeToolBoss.SourceChangeCache);
          if result
          then DEBUG('OKOKOKOK')
          else DEBUG('ERRRRRRR');


           //CodeToolBoss.SourceChangeCache.Replace(gtNone,gtNone,1,1,'qwerqwerqwerqwerqwe');


        //Tool.FindEmptyMethods();


        {

          // Step 3: use Replace to insert and/or delete code
          // The first two parameters are the needed spaces in front and behind the insertion
          // The FromPos,ToPos defines the deleted/replaced range in CleanPos positions.
          // The NewCode is the string of new code. Use '' for a delete.
          if not CodeToolBoss.SourceChangeCache.Replace(gtNone,gtNone,FromPos,ToPos,NewCode) then
            exit; // e.g. source read only or a former Replace has deleted the place
     //     ...do some more Replace...
       //}
          // Step 4: Apply the changes
        //  CodeToolBoss.SourceChangeCache.Apply;
        if not CodeToolBoss.SourceChangeCache.Apply then begin
            {$ifdef _DEBUG_}
                DEBUG(' ER :'+'_copyRast_FileUPDATE_File','CodeToolBoss.SourceChangeCache.Apply');
            {$endIf}
            result:=FALSE;
        end;

        //Code.

        //CodeToolBoss.sa
        {$ifdef _DEBUG_}
            if Result
            then DEBUG(' ok :'+'_copyRast_FileUPDATE_File','ghjk')
            else DEBUG(' ER :'+'_copyRast_FileUPDATE_File','sdf')
        {$endIf}
    except
        result:=FALSE;
        {$ifdef _DEBUG_}
            DEBUG('EXPT:'+'_copyRast_FileUPDATE_File','"'+node.NewFilePATH+'"');
        {$endIf}
    end;
    Code.Save;


