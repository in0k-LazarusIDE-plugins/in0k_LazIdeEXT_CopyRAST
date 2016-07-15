unit lazExt_CopyRAST_node_ROOT;

{$mode objfpc}{$H+}

interface

{$define _DEBUG_}

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
//< Можно смело убирать, так как будеть работать только в моей специальной
//< "системе имен и папок" `in0k_LazExt_..`.


uses {$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}in0k_lazIdeSRC_DEBUG,{$endIf}
     sysutils,  FileUtil, PackageIntf, LazFileUtils, LazIDEIntf, Dialogs,
                            Classes,

    CodeToolManager, CodeCache,  CustomCodeTool,
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
    function  _get_BaseDIR_PATH_:string;
    function  _get_rltvDIR_(const Folder:tCopyRAST_node_Folder):string;
  protected
    function  _tst_FileSRC_lfmHAVE_(const FileName:string):boolean;
    function  _tst_FileSRC_lfmNAME_(const FileName:string):string;
    function  _tst_FileXXX_haveLFM_(const FileXXX:tCopyRAST_node_File):boolean;
  protected
    function _LazIDE_loadFile_(const node:tCopyRAST_node_FILE):TCodeBuffer;

  protected
    procedure _prepare_fileLFM_fnd8add_(const Folder:tCopyRAST_node_Folder);
    procedure _prepare_fileLFM_fnd8add_;
  protected
    procedure _prepare_fileUSE_fnd8add_(const fullFileName:string);
    procedure _prepare_fileUSE_fnd8add_(const nameLst:TStringList);
    procedure _prepare_fileUSE_fnd8add_(const FileXXX:tCopyRAST_node_File);
    procedure _prepare_fileUSE_fnd8add_(const Folder:tCopyRAST_node_Folder);
    procedure _prepare_fileUSE_fnd8add_;
  protected
    function  _PathFLDR_fnd_(const PathFLDR:string):tCopyRAST_node_Folder;
    function  _PathFLDR_GET_(const PathFLDR:string):tCopyRAST_node_Folder;
  protected
    function  _fileXXXX_fnd_(const Folder:tCopyRAST_node_Folder; const FileName:string):tCopyRAST_node_FILE;
    function  _fileXXXX_fnd_(const FullFileName:string):tCopyRAST_node_FILE;
  protected
    function  _fnd_fileSRC_(const Folder:tCopyRAST_node_Folder; const FileNameWithoutExt:string):tCopyRAST_node;
    procedure _add_SrchPTH_(const SrchPTH:string; const KIND:eCopyRAST_node_SrchPath);
    procedure _add_FileXXX_(const FileXXX:tCopyRAST_node_File);
  protected
    function  _copyRast_txt(const node:tCopyRAST_node_FILE):boolean;
    function  _copyRast_bin(const node:tCopyRAST_node_FILE):boolean;

    function  _copyRast_getOldPATH_(const node:tCopyRAST_node_FILE):string;
    function  _copyRast_getNewPATH_(const node:tCopyRAST_node_FILE; const BaseDir:string):string;
    function  _copyRast_COPY_FILE_ (const node:tCopyRAST_node_FILE; const BaseDir:string):boolean;
    function  _copyRast_COPY_      (const node:tCopyRAST_node;      const BaseDir:string):boolean;

  protected
    function _copyRast_prepare_Target_BaseDIR_(out   BaseDir:string; const Clear:boolean=true):boolean;
    function _copyRast_prepare_Target_DirTREE_(const BaseDir:string; const Node:tCopyRAST_node):boolean;
  public
    function CopyRAST:boolean;

  end;

implementation

{%region --- возня с ДЕБАГОМ -------------------------------------- /fold}
{$if defined(in0k_lazIdeSRC_FuckUpForm___DebugLOG) AND declared(in0k_lazIde_DEBUG)}
    // `in0k_lazIde_DEBUG` - это функция ИНДИКАТОР что используется
    //                       моя "система имен и папок"
    {$define _debugLOG_}     //< типа да ... можно делать ДЕБАГ отметки
{$else}
    {$undef _debugLOG_}
{$endIf}
{%endregion}


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

function tCopyRAST_ROOT._get_BaseDIR_PATH_:string;
var tmp:tCopyRAST_node_BaseDIR;
begin
    tmp:=_get_BaseDIR_;
    if Assigned(tmp) then begin
        result:=tmp.NodeTXT;
    end;
end;

function tCopyRAST_ROOT._get_rltvDIR_(const Folder:tCopyRAST_node_Folder):string;
var baseDir:tCopyRAST_node_BaseDIR;
begin
    result:='';
    baseDir:=_get_BaseDIR_;
    if baseDir<>Folder then begin
        if Folder.NodePRNT=baseDir then result:=''
        else begin
            if Folder.NodePRNT is tCopyRAST_node_Folder then result:=_get_rltvDIR_(tCopyRAST_node_Folder(Folder.NodePRNT))
        end;
        result:=result+DirectorySeparator+Folder.DirNAME;
    end
    else result:='';
end;

//------------------------------------------------------------------------------

// найти или СОЗДАТЬ путь к "ПАПКЕ" от корневой
function tCopyRAST_ROOT._PathFLDR_fnd_(const PathFLDR:string):tCopyRAST_node_Folder;
var prnt:tCopyRAST_node_Folder;
var tmp:tCopyRAST_node;
    fld:string;
begin
    result:=nil;
    prnt:=_get_BaseDIR_;
    if not Assigned(prnt) then EXIT; //< это КАСЯК, обработать как-то надо?
    if 0=CompareFilenames(PathFLDR+PathDelim,prnt.DirPATH) then begin
        result:=prnt;
    end
    else begin
        // исчем РОДИТЕЛЬСКИЙ путь
        fld:=ExtractFileDir(PathFLDR); //< это родительская директория
        if NOT ( (fld='')or(0=CompareFilenames(fld,prnt.DirPATH)) )
        then prnt:=_PathFLDR_fnd_(fld); //< исчем ГЛУБЖЕ, ближе к корню
        if not Assigned(prnt) then EXIT; //< это КАСЯК, обработать как-то надо?
        // исчем в родителе СЕБЯ
        fld:=ExtractFileName(PathFLDR); //< что именно искать будем
        pointer(result):=prnt.NodeCHLD;
        while Assigned(result) do begin
            if TObject(result) is tCopyRAST_node_PathDIR then begin
                if 0=CompareFilenames(fld,result.DirNAME) then begin
                    BREAK; // НАШЛИ
                end;
            end;
            pointer(result):=result.NodeNEXT;
        end;
    end;
end;

// найти или СОЗДАТЬ путь к "ПАПКЕ" от корневой
function tCopyRAST_ROOT._PathFLDR_GET_(const PathFLDR:string):tCopyRAST_node_Folder;
var prnt:tCopyRAST_node_Folder;
var tmp:tCopyRAST_node;
    fld:string;
begin
    result:=nil;
    prnt:=_get_BaseDIR_;
    if not Assigned(prnt) then EXIT; //< это КАСЯК, обработать как-то надо?
    if 0=CompareFilenames(PathFLDR+PathDelim,prnt.DirPATH) then begin
        result:=prnt;
    end
    else begin
        // исчем РОДИТЕЛЬСКИЙ путь

        fld:=ExtractFileDir(PathFLDR); //< это родительская директория
        //ShowMessage('fld PARENT:'+fld);
        if NOT ( (fld='')or(0=CompareFilenames(fld,prnt.DirPATH)) )
        then prnt:=_PathFLDR_GET_(fld); //< исчем ГЛУБЖЕ, ближе к корню

        if not Assigned(prnt) then EXIT; //< это КАСЯК, обработать как-то надо?

        // исчем в родителе СЕБЯ
        fld:=ExtractFileName(PathFLDR); //< что именно искать будем
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
            result:=tCopyRAST_node_PathDIR.Create(PathFLDR);
            prnt.ins_ChldLast(result);
            {$ifdef _DEBUG_}DEBUG('_PathFLDR_GET_','CREATE: '+PathFLDR);{$endIf}
        end;
    end;
end;

//------------------------------------------------------------------------------

function tCopyRAST_ROOT._fileXXXX_fnd_(const Folder:tCopyRAST_node_Folder; const FileName:string):tCopyRAST_node_FILE;
begin
    result:=tCopyRAST_node_FILE(Folder.NodeCHLD);
    while Assigned(result) do begin
        if (tCopyRAST_node(result) is tCopyRAST_node_FILE) and
           (0=CompareFilenames(result.FileNAME,FileName)) then begin
            BREAK; // нашли
        end;
        result:=tCopyRAST_node_FILE(result.NodeNEXT);
    end;
end;

function tCopyRAST_ROOT._fileXXXX_fnd_(const FullFileName:string):tCopyRAST_node_FILE;
var prnt:tCopyRAST_node_Folder;
begin
    result:=nil;
    //--- ищем родительскую директорию
    prnt:=_PathFLDR_GET_(ExtractFileDir(FullFileName));
    if not Assigned(prnt) then EXIT;
    //---
    result:=_fileXXXX_fnd_(prnt, ExtractFileName(FullFileName))
end;

// найти файл исходник, с названием
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
        {$ifdef _DEBUG_}DEBUG('add_SrchPTH','{'+eCopyRAST_node_SrchPath__2__text(KIND)+'}'+singlDir);{$endIf}
        {todo: чет наверно как-то потестить надо}
        FoldrDir:=_PathFLDR_GET_(singlDir);
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
    prnt:=_PathFLDR_GET_(FileXXX.FilePATH);
    if not Assigned(prnt) then begin
        {$ifOpt D+}ShowMessage('ERR: _add_FileXXX_, _get_PathDIR_=nil');{$endif}
        EXIT; //< это КАСЯК, обработать как-то надо?
    end;
    //-
    if FileXXX is tCopyRAST_node_fileMain_CORE
    then tCopyRAST_ROOT(pointer(prnt))._ins_ChldFrst_(FileXXX)
    else begin
        if FileXXX.FileTYPE=pftLFM then begin // вставка ресурсов ОСОБЕННАЯ
            prnt:=tCopyRAST_node_Folder(_fnd_fileSRC_(prnt,ExtractFileNameWithoutExt(FileXXX.FileNAME)));
            if NOT _tst_FileXXX_haveLFM_(tCopyRAST_node_FILE(tCopyRAST_node(prnt))) then begin
                prnt.ins_ChldLast(FileXXX);
                {$ifdef _DEBUG_}DEBUG('_add_FileXXX_','{'+'LFM'+'}'+FileXXX.NodeTXT);{$endIf}
            end
            else begin
                {todo: чет надо поделать}
                {$ifOpt D+}ShowMessage('ERR: _add_FileXXX_, ???????????=nil');{$endif}
                prnt.ins_ChldLast(FileXXX);
                //EXIT; //< это КАСЯК, обработать как-то надо?
            end;
        end
        else begin
            prnt.ins_ChldLast(FileXXX);
            {$ifdef _DEBUG_}DEBUG('_add_FileXXX_','{'+'}'+FileXXX.NodeTXT);{$endIf}
        end;
    end;
end;

//------------------------------------------------------------------------------

// файл с таким именем ИМЕЕТ доп файл
function tCopyRAST_ROOT._tst_FileSRC_lfmHAVE_(const FileName:string):boolean;
begin
    result:=FilenameIsPascalSource8HasResources(FileName);
end;

// название доп Файла по имени исходника
function tCopyRAST_ROOT._tst_FileSRC_lfmNAME_(const FileName:string):string;
begin
    result:=FilenameIsPascalSource_getRsrc_Name(FileName);
end;

//----

function tCopyRAST_ROOT._tst_FileXXX_haveLFM_(const FileXXX:tCopyRAST_node_File):boolean;
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

//------------------------------------------------------------------------------

procedure tCopyRAST_ROOT._prepare_fileLFM_fnd8add_(const Folder:tCopyRAST_node_Folder);
var tmp:tCopyRAST_node;
    lll:tCopyRAST_node_FILE;
begin
    tmp:=Folder.NodeCHLD;
    while Assigned(tmp) do begin
        if tmp is tCopyRAST_node_Folder then _prepare_fileLFM_fnd8add_(tCopyRAST_node_Folder(tmp))
       else
        if (tmp is tCopyRAST_node_FILE) then begin
            if pftLFM<>tCopyRAST_node_FILE(tmp).FileTYPE then begin
                if (NOT _tst_FileXXX_haveLFM_(tCopyRAST_node_FILE(tmp)))and
                   (_tst_FileSRC_lfmHAVE_(tCopyRAST_node_FILE(tmp).NodeTXT))
                then begin
                    lll:=tCopyRAST_node_FILE.Create(FilenameIsPascalSource_getRsrc_Name(tmp.NodeTXT),pftLFM);
                   _add_FileXXX_(lll);
                end;
            end;
        end;
        //--->
        tmp:=tmp.NodeNEXT;
    end;
end;

procedure tCopyRAST_ROOT._prepare_fileLFM_fnd8add_;
var tmp:tCopyRAST_node;
begin
    tmp:=NodeCHLD;
    while Assigned(tmp) do begin
        if tmp is tCopyRAST_node_Folder then _prepare_fileLFM_fnd8add_(tCopyRAST_node_Folder(tmp));
        //--->
        tmp:=tmp.NodeNEXT;
    end;
end;

//------------------------------------------------------------------------------

procedure tCopyRAST_ROOT._prepare_fileUSE_fnd8add_(const fullFileName:string);
var fileXXX:tCopyRAST_node_FILE;
begin
    if FileIsInPath(fullFileName,_get_BaseDIR_.DirPATH) then begin
        fileXXX:=_fileXXXX_fnd_(fullFileName);
        if NOT Assigned(fileXXX) then begin
            fileXXX:=tCopyRAST_node_FILE.Create(fullFileName,pftUnit);
           _add_FileXXX_(fileXXX);
           _prepare_fileUSE_fnd8add_(fileXXX);
        end;
    end;
end;

procedure tCopyRAST_ROOT._prepare_fileUSE_fnd8add_(const nameLst:TStringList);
var i:integer;
begin
    for i:=0 to nameLst.Count-1 do begin
       _prepare_fileUSE_fnd8add_(nameLst.Strings[i]);
    end;
end;

procedure tCopyRAST_ROOT._prepare_fileUSE_fnd8add_(const FileXXX:tCopyRAST_node_File);
var
  ExpandedFilename: String;
  CodeBuf: TCodeBuffer;
  var MainUsesSection,ImplementationUsesSection:TStrings;
begin
      // make sure the filename is trimmed and contains a full path
      ExpandedFilename:=CleanAndExpandFilename(FileXXX.NodeTXT);
      // save changes in source editor to codetools
      LazarusIDE.SaveSourceEditorChangesToCodeCache(nil);

      // load the file
      CodeBuf:=CodeToolBoss.LoadFile(ExpandedFilename,true,false);

      MainUsesSection          :=TStringList.Create;
      ImplementationUsesSection:=TStringList.Create;

      if CodeToolBoss.FindUsedUnitFiles(CodeBuf, MainUsesSection,ImplementationUsesSection) then begin
         _prepare_fileUSE_fnd8add_(TStringList(MainUsesSection));
         _prepare_fileUSE_fnd8add_(TStringList(ImplementationUsesSection));
          //ShowMessage('file:'+LineEnding+FileXXX.NodeTXT+LineEnding+'inMAIN:'+LineEnding+MainUsesSection.Text+LineEnding+'inIMPL:'+LineEnding+ImplementationUsesSection.Text);
      end
      else begin
          //ShowMessage('file:'+LineEnding+FileXXX.NodeTXT+LineEnding+'Uses NOT FOUND');
      end;

      MainUsesSection          .FREE;
      ImplementationUsesSection.FREE;
end;

procedure tCopyRAST_ROOT._prepare_fileUSE_fnd8add_(const Folder:tCopyRAST_node_Folder);
var tmp:tCopyRAST_node;
begin
    tmp:=Folder.NodeCHLD;
    while Assigned(tmp) do begin
        if tmp is tCopyRAST_node_Folder then _prepare_fileUSE_fnd8add_(tCopyRAST_node_Folder(tmp))
       else
        if (tmp is tCopyRAST_node_FILE) then _prepare_fileUSE_fnd8add_(tCopyRAST_node_FILE(tmp));
        //--->
        tmp:=tmp.NodeNEXT;
    end;
end;

procedure tCopyRAST_ROOT._prepare_fileUSE_fnd8add_;
var tmp:tCopyRAST_node;
begin
    tmp:=NodeCHLD;
    while Assigned(tmp) do begin
        if tmp is tCopyRAST_node_Folder then _prepare_fileUSE_fnd8add_(tCopyRAST_node_Folder(tmp));
        //--->
        tmp:=tmp.NodeNEXT;
    end;
end;



//------------------------------------------------------------------------------

function tCopyRAST_ROOT._LazIDE_loadFile_(const node:tCopyRAST_node_FILE):TCodeBuffer;
begin
    // save changes in source editor to codetools
    LazarusIDE.SaveSourceEditorChangesToCodeCache(nil);
    // load the file
    result:=CodeToolBoss.LoadFile(node.NodeTXT,false,false);
end;

//------------------------------------------------------------------------------

function tCopyRAST_ROOT._copyRast_bin(const node:tCopyRAST_node_FILE):boolean;
begin
    result:=FALSE;
end;

function tCopyRAST_ROOT._copyRast_txt(const node:tCopyRAST_node_FILE):boolean;
var cb:TCodeBuffer;
    fs:TFileStream;
begin
    result:=FALSE;
    //---
    cb:=_LazIDE_loadFile_(node);
    if Assigned(cb) then begin
        //fs.Create('D:\'+node.FileNAME,fmCreate);
        //cb.SaveToStream(fs);
        //fs.free;
    end;
end;


//------------------------------------------------------------------------------

function tCopyRAST_ROOT._copyRast_getOldPATH_(const node:tCopyRAST_node_FILE):string;
begin
    result:=node.NodeTXT;
end;

function tCopyRAST_ROOT._copyRast_getNewPATH_(const node:tCopyRAST_node_FILE; const BaseDir:string):string;
var tmp:tCopyRAST_node;
begin
    result:='';
    //---
    tmp:=node.NodePRNT;
    while Assigned(tmp) do begin
        if tmp is tCopyRAST_node_Folder then begin
            result:=_get_rltvDIR_(tCopyRAST_node_Folder(tmp));
            BREAK;
        end;
        //---
        tmp:=tmp.NodePRNT;
    end;
    //---
    result:=BaseDir+DirectorySeparator+result+DirectorySeparator+node.FileNAME;
end;

function tCopyRAST_ROOT._copyRast_COPY_FILE_(const node:tCopyRAST_node_FILE; const BaseDir:string):boolean;
begin
    result:=CopyFile(_copyRast_getOldPATH_(node),_copyRast_getNewPATH_(node,BaseDir){,[cffOverwriteFile,cffPreserveTime]});
    {$ifdef _DEBUG_}
        if Result
        then DEBUG(' ok :'+'_copyRast_COPY_FILE_','"'+_copyRast_getOldPATH_(node)+'"'+'->'+'"'+_copyRast_getNewPATH_(node,BaseDir)+'"')
        else DEBUG(' ER :'+'_copyRast_COPY_FILE_','"'+_copyRast_getOldPATH_(node)+'"'+'->'+'"'+_copyRast_getNewPATH_(node,BaseDir)+'"')
    {$endIf}
end;

function tCopyRAST_ROOT._copyRast_COPY_(const node:tCopyRAST_node; const BaseDir:string):boolean;
var tmp:tCopyRAST_node;
    str:string;
begin // глупо и тупо рекурсией
    tmp:=node;
    if not Assigned(tmp) then tmp:=self;
    //---
    if tmp is tCopyRAST_node_FILE then begin
        result:=_copyRast_COPY_FILE_(tCopyRAST_node_FILE(node),BaseDir);
    end;
    //---
    tmp:=tmp.NodeCHLD;
    while Assigned(tmp) do begin
       _copyRast_COPY_(tmp,BaseDir);
        //--->
        tmp:=tmp.NodeNEXT;
    end;
end;


//------------------------------------------------------------------------------


function tCopyRAST_ROOT._copyRast_prepare_Target_BaseDIR_(out BaseDir:string; const Clear:boolean=true):boolean;
begin
    if BaseDir='' then BaseDir:=_get_BaseDIR_PATH_+'\CopyRast';
    {$ifdef _DEBUG_}DEBUG('_copyRast_prepare_TargetDIG_','path: '+BaseDir);{$endIf}
    if Clear then begin

        Result:=DeleteDirectory(BaseDir,True);
        if Result then begin
            {$ifdef _DEBUG_}DEBUG('_copyRast_prepare_TargetDIG_','DeleteDirectory: OK');{$endIf}
            Result:=RemoveDirUTF8(BaseDir);
            if result then begin
                {$ifdef _DEBUG_}DEBUG('_copyRast_prepare_TargetDIG_','RemoveDirUTF8: OK');{$endIf}
            end;
        end;

        {if RemoveDirUTF8(BaseDir) then begin
            {$ifdef _DEBUG_}DEBUG('_copyRast_prepare_TargetDIG_','RemoveDirUTF8: OK');{$endIf}
        end;}
        if ForceDirectoriesUTF8(BaseDir) then begin
            {$ifdef _DEBUG_}DEBUG('_copyRast_prepare_TargetDIG_','ForceDirectoriesUTF8: OK');{$endIf}
        end;
    end
    else begin
        {$ifdef _DEBUG_}DEBUG('_copyRast_prepare_TargetDIG_','Clear: FALSE');{$endIf}
    end;
end;

function tCopyRAST_ROOT._copyRast_prepare_Target_DirTREE_(const BaseDir:string; const Node:tCopyRAST_node):boolean;
var tmp:tCopyRAST_node;
    str:string;
begin // глупо и тупо рекурсией
    tmp:=node;
    if not Assigned(tmp) then tmp:=self;
    //---
    if tmp is tCopyRAST_node_Folder then begin
        //---
        str:=BaseDir+DirectorySeparator+_get_rltvDIR_(tCopyRAST_node_Folder(tmp));
        if ForceDirectoriesUTF8(str) then begin
            {$ifdef _DEBUG_}DEBUG('_copyRast_prepare_TargetDIG_','ForceDirectoriesUTF8:'+str+' [ok]');{$endIf}
        end
        else begin
            {$ifdef _DEBUG_}DEBUG('_copyRast_prepare_TargetDIG_','ForceDirectoriesUTF8:'+str+' [ER]');{$endIf}
        end;
    end;
    //---
    tmp:=tmp.NodeCHLD;
    while Assigned(tmp) do begin
       _copyRast_prepare_Target_DirTREE_(BaseDir,tmp);
        //--->
        tmp:=tmp.NodeNEXT;
    end;
end;

function tCopyRAST_ROOT.CopyRAST:boolean;
var TargetDirPATH:string;
begin
    //
    TargetDirPATH:='';
   _copyRast_prepare_Target_BaseDIR_(TargetDirPATH);
   _copyRast_prepare_Target_DirTREE_(TargetDirPATH,nil);
   _copyRast_COPY_(nil,TargetDirPATH);
end;





end.

