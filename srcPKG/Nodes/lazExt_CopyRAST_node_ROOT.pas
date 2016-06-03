unit lazExt_CopyRAST_node_ROOT;

{$mode objfpc}{$H+}

interface

uses sysutils,  FileUtil, PackageIntf, LazFileUtils, LazIDEIntf, Dialogs,
                            Classes,
    CodeToolManager, CodeCache,
    //Dialogs,
     lazExt_CopyRAST_from_IDEProcs,
     lazExt_CopyRAST_node,
     lazExt_CopyRAST_node_File,
     lazExt_CopyRAST_node_Folder;

type

 tCopyRAST_ROOT=class(tCopyRAST_node)
  protected
    function  _get_BaseDIR_:tCopyRAST_node_BaseDIR;
    procedure _set_BaseDIR_(const BaseDIR:string);
  protected
    function  _tst_FileXXX_haveRES_(const FileXXX:tCopyRAST_node_File):boolean;
    function  _getFileNameLFM      (const FileXXX:tCopyRAST_node_File):string;
  protected
    procedure _prepare_fnd8add_fileRES_(const Folder:tCopyRAST_node_Folder);
    procedure _prepare_fnd8add_fileRES_4ROOT_;
  protected
    function  _get_PathDIR_(const PathDIR:string):tCopyRAST_node_Folder;
    function  _fnd_fileSRC_(const Folder:tCopyRAST_node_Folder; const FileNameWithoutExt:string):tCopyRAST_node;
    procedure _add_SrchPTH_(const SrchPTH:string; const KIND:eCopyRAST_node_SrchPath);
    procedure _add_FileXXX_(const FileXXX:tCopyRAST_node_File);
  end;

implementation

// поиск BaseDIR по типу
function tCopyRAST_ROOT._get_BaseDIR_:tCopyRAST_node_BaseDIR;
begin //< оно ДОЛЖНО быть в корне РЕБЕНКОМ
    result:=tCopyRAST_node_BaseDIR(_chldFrst_);
    while Assigned(result) do begin
       if TObject(Result) is tCopyRAST_node_BaseDIR then BREAK;
       result:=tCopyRAST_node_BaseDIR(tCopyRAST_node_BaseDIR(result).NodeNEXT);
    end;
end;

// установить BaseDIR
procedure tCopyRAST_ROOT._set_BaseDIR_(const BaseDIR:string);
var tmp:tCopyRAST_node_BaseDIR;
begin
    tmp:=_get_BaseDIR_;
    if not Assigned(tmp) then begin //< еще просто НЕ добавляли
        tmp:=tCopyRAST_node_BaseDIR.Create(BaseDIR);
       _ins_ChldFrst_(tmp);
    end
    else tCopyRAST_ROOT(tmp)._nodeText_:=BaseDIR;
end;

//------------------------------------------------------------------------------

function tCopyRAST_ROOT._get_PathDIR_(const PathDIR:string):tCopyRAST_node_Folder;
var prnt:tCopyRAST_node_Folder;
var tmp:tCopyRAST_node;
    fld:string;
begin
    result:=nil;
    prnt:=_get_BaseDIR_;
    if not Assigned(prnt) then EXIT; //< это КАСЯК, обработать как-то надо?
    if 0=CompareFilenames(PathDIR+PathDelim,prnt.DirPATH) then begin
        result:=prnt;
    end
    else begin
        // исчем РОДИТЕЛЬСКИЙ путь

        fld:=ExtractFileDir(PathDIR); //< это родительская директория
        //ShowMessage('fld PARENT:'+fld);
        if NOT ( (fld='')or(0=CompareFilenames(fld,prnt.DirPATH)) )
        then prnt:=_get_PathDIR_(fld); //< исчем ГЛУБЖЕ, ближе к корню

        if not Assigned(prnt) then EXIT; //< это КАСЯК, обработать как-то надо?

        // исчем в родителе СЕБЯ
        fld:=ExtractFileName(PathDIR); //< что именно искать будем
        //ShowMessage('fld SELF:'+fld);
        pointer(result):=prnt.NodeCHLD;
        while Assigned(result) do begin
            if TObject(result) is tCopyRAST_node_PathDIR then begin
                if 0=CompareFilenames(fld,result.DirNAME) then begin
                    BREAK; // НАШЛИ
                end;
            end;
            pointer(result):=result.NodeNEXT;
        end;
        //--- добавим искомый путь
        if not Assigned(result) then begin
            result:=tCopyRAST_node_PathDIR.Create(PathDIR);
            prnt.ins_ChldLast(result);
        end;
    end;
end;

function tCopyRAST_ROOT._fnd_fileSRC_(const Folder:tCopyRAST_node_Folder; const FileNameWithoutExt:string):tCopyRAST_node;
begin
    result:=Folder.NodeCHLD;
    while Assigned(result) do begin
        if (result is tCopyRAST_node_FILE) and
           (0=CompareFilenames(ExtractFileNameWithoutExt(tCopyRAST_node_FILE(result).FileNAME),FileNameWithoutExt)) then begin
            BREAK; // нашли
        end;
        result:=Result.NodeNEXT;
    end;
    if not Assigned(result) then result:=Folder;
end;

// добавить ПУТИ поиска
procedure tCopyRAST_ROOT._add_SrchPTH_(const SrchPTH:string; const KIND:eCopyRAST_node_SrchPath);
var StartPos:Integer;
    singlDir:string;
    FoldrDir:tCopyRAST_node_Folder;
begin
    StartPos:=1;
    singlDir:=GetNextDirectoryInSearchPath(SrchPTH,StartPos);
    while singlDir<>'' do begin

        {todo: чет наверно как-то потестить надо}

        FoldrDir:=_get_PathDIR_(singlDir);
        if Assigned(FoldrDir) then begin
            //--- добавим найденному ТИП пути
            FoldrDir.Add_PathType(KIND);
        end;
        //-->
        singlDir:=GetNextDirectoryInSearchPath(SrchPTH,StartPos);
    end;
end;

procedure tCopyRAST_ROOT._add_FileXXX_(const FileXXX:tCopyRAST_node_File);
var prnt:tCopyRAST_node_Folder;
begin
    prnt:=_get_PathDIR_(FileXXX.FilePATH);
    if not Assigned(prnt) then EXIT; //< это КАСЯК, обработать как-то надо?
    //-
    if FileXXX is tCopyRAST_node_fileMain_CORE
    then tCopyRAST_ROOT(pointer(prnt))._ins_ChldFrst_(FileXXX)
    else begin
        if FileXXX.FileTYPE=pftLFM then begin // вставка ресурсов ОСОБЕННАЯ
           prnt:=tCopyRAST_node_Folder(_fnd_fileSRC_(prnt,ExtractFileNameWithoutExt(FileXXX.FileNAME)));
           if NOT _tst_FileXXX_haveRES_(tCopyRAST_node_FILE(tCopyRAST_node(prnt))) then begin
                prnt.ins_ChldLast(FileXXX);
           end
           else begin
               {todo: чет надо поделать}
           end;
        end
        else begin
            prnt.ins_ChldLast(FileXXX);
        end;
    end;
end;

//------------------------------------------------------------------------------

function tCopyRAST_ROOT._tst_FileXXX_haveRES_(const FileXXX:tCopyRAST_node_File):boolean;
var tmp:tCopyRAST_node;
begin
    result:=false;
    tmp:=FileXXX.NodeCHLD;
    while Assigned(tmp) do begin
        if (tmp is tCopyRAST_node_FILE)and
           (tCopyRAST_node_FILE(tmp).FileTYPE=pftLFM)and
           (0=CompareFilenames(
               ExtractFileNameWithoutExt(tCopyRAST_node_FILE(tmp).FileNAME),
               ExtractFileNameWithoutExt(                 FileXXX.FileNAME))
           )
        then begin //< мда ... это файл с ресурсами
            result:=TRUE;
            BREAK;
        end;
        //--->
        tmp:=tmp.NodeNEXT;
    end;
end;

procedure tCopyRAST_ROOT._prepare_fnd8add_fileRES_(const Folder:tCopyRAST_node_Folder);
var tmp:tCopyRAST_node;
    lll:tCopyRAST_node_FILE;
begin
    tmp:=Folder.NodeCHLD;
    while Assigned(tmp) do begin
        if tmp is tCopyRAST_node_Folder then _prepare_fnd8add_fileRES_(tCopyRAST_node_Folder(tmp))
       else
        {if tmp is tCopyRAST_node_FILE then begin
            if (FilenameIsPascalSource8HasResources(tmp.NodeTXT))and //< они ДОЛЖНЫ быть
               (not _tst_FileXXX_haveRES_(tCopyRAST_node_FILE(tmp))) //< но их НЕТ
            then begin //< ага ... в нем НИЧЕГО не лежит
                // создадим и положим
                lll:=tCopyRAST_node_FILE.Create(FilenameIsPascalSource_getRsrc_Name(tmp.NodeTXT),pftLFM);
               _add_FileXXX_(lll);
            end;
        end;}
        if tmp is tCopyRAST_node_FILE then begin
           ShowMessage(tCopyRAST_node_FILE(tmp).FileNAME);
           _getFileNameLFM(tCopyRAST_node_FILE(tmp))
        end;
        //--->
        tmp:=tmp.NodeNEXT;
    end;
end;


function tCopyRAST_ROOT._getFileNameLFM(const FileXXX:tCopyRAST_node_File):string;
var
  ExpandedFilename: String;
  CodeBuf: TCodeBuffer;
  CB     :TCodeBuffer;
  LinkIndex:integer;
  str:tStrings;
begin
  // make sure the filename is trimmed and contains a full path
  ExpandedFilename:={CleanAndExpandFilename}(FileXXX.NodeTXT);
  // save changes in source editor to codetools
  LazarusIDE.SaveSourceEditorChangesToCodeCache(nil);
  // load the file
  CodeBuf:=CodeToolBoss.LoadFile(ExpandedFilename,true,false);
  //---
  if not Assigned(CodeBuf) then ShowMessage('CodeBuf NOT load');;
  //---
  try
    CodeBuf.Reload;
    LinkIndex:=-1;
    CB:=CodeToolBoss.FindNextResourceFile(CodeBuf,LinkIndex);
    while CB<>nil do begin
        ShowMessage(ExpandedFilename+LineEnding+CB.ToString);
        CB:=CodeToolBoss.FindNextResourceFile(CodeBuf,LinkIndex);
    end;

    // список файлов из USES
    str:=TStringList.Create;
    CodeToolBoss.FindUsedUnitFiles(CodeBuf,str);
    ShowMessage(str.Text);


  //result:=CodeToolBoss.FindLFMFileName(CodeBuf);
    //ShowMessage(ExpandedFilename+LineEnding+result);
  except
    ShowMessage('ERRRR');
  end;
end;


procedure tCopyRAST_ROOT._prepare_fnd8add_fileRES_4ROOT_;
var tmp:tCopyRAST_node;
begin
    tmp:=NodeCHLD;
    while Assigned(tmp) do begin
        if tmp is tCopyRAST_node_Folder then _prepare_fnd8add_fileRES_(tCopyRAST_node_Folder(tmp));
        //--->
        tmp:=tmp.NodeNEXT;
    end;


//    CodeToolBoss.

end;

end.

