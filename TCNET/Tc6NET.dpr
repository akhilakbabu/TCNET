program Tc6NET;

uses
  Forms,
  Windows,
  Dialogs,
  Controls,
  MAIN in 'MAIN.PAS' {MainForm},
  BLOCK1 in 'BLOCK1.PAS' {Blockwin},
  TCGETDIR in 'TCGETDIR.PAS' {GetDirDlg},
  CodeView in 'CodeView.pas' {ViewCodeDialog},
  ADDSCODE in 'ADDSCODE.PAS' {addscodedlg},
  EDTCODE in 'EDTCODE.PAS' {edtcodedlg},
  ADDRCODE in 'ADDRCODE.PAS' {addrcodedlg},
  ADDTCODE in 'ADDTCODE.PAS' {addtcodedlg},
  EDSCODE in 'EDSCODE.PAS' {edscodedlg},
  EDRCODE in 'EDRCODE.PAS' {edrcodedlg},
  DELSCODE in 'DELSCODE.PAS' {DelSCodeDlg},
  DELTCODE in 'DELTCODE.PAS' {deltcodedlg},
  DELRCODE in 'DELRCODE.PAS' {delrcodedlg},
  CODELEN in 'CODELEN.PAS' {codelendlg},
  TCOMMON in 'TCOMMON.PAS',
  EDCLASS in 'EDCLASS.PAS' {edclassdlg},
  EDHOUSE in 'EDHOUSE.PAS' {edhousedlg},
  PREFER in 'PREFER.PAS' {prefdlg},
  GROUPSEL in 'GROUPSEL.PAS' {groupseldlg},
  CNFGYEAR in 'CNFGYEAR.PAS' {ConfigYeardlg},
  CNFGDAY in 'CNFGDAY.PAS' {configdaydlg},
  TTABLE in 'TTABLE.PAS' {Ttablewin},
  TCINFO in 'TCINFO.PAS' {InfoWin},
  SETBLOCK in 'SETBLOCK.PAS' {SetBlocksDlg},
  COPYBLCK in 'COPYBLCK.PAS' {CopyBlockDlg},
  MOVESUB in 'MOVESUB.PAS' {MoveSubDlg},
  SPLITSUB in 'SPLITSUB.PAS' {SplitSubDlg},
  SWAPSUB in 'SWAPSUB.PAS' {SwapSubDlg},
  AUTOALOC in 'AUTOALOC.PAS' {AutoAllocDlg},
  LINKSUB in 'LINKSUB.PAS' {LinkSubDlg},
  STCLASH in 'STCLASH.PAS' {StClashHelpDlg},
  ENTRY in 'ENTRY.PAS' {EntryDlg},
  MANCLASH in 'MANCLASH.PAS' {ManClashDlg},
  EXSUB in 'EXSUB.PAS' {ExcludeSubDlg},
  TTVERS in 'TTVERS.PAS' {VersionDlg},
  CNFGLEV in 'CNFGLEV.PAS' {ConfigureLevels},
  SWAPBLCK in 'SWAPBLCK.PAS' {ExchangeBlockDlg},
  MARGINS in 'MARGINS.PAS' {pmargins},
  TTGOTO in 'TTGOTO.PAS' {GotoDlg},
  TECLASH in 'TECLASH.PAS' {TeacherClashes},
  FNDRODLG in 'FNDRODLG.PAS' {findroomdlg},
  FNDSTDLG in 'FNDSTDLG.PAS' {findstudentdlg},
  FNDTEDLG in 'FNDTEDLG.PAS' {findteacherdlg},
  EDCUSTOM in 'EDCUSTOM.PAS' {EditCustomInfo},
  CHELP in 'CHELP.PAS' {ClashHelpDlg},
  TTPRNSEL in 'TTPRNSEL.PAS' {ttprintselectiondlg},
  TCLOAD in 'TCLOAD.PAS' {About},
  CLASHHLP in 'CLASHHLP.PAS' {ClashHelp},
  TFREEDLG in 'TFREEDLG.PAS' {Teachersfreedlg},
  TEFREE in 'TEFREE.PAS' {TeachersFree},
  ROFREE in 'ROFREE.PAS' {RoomsFree},
  RFREEDLG in 'RFREEDLG.PAS' {Roomsfreedlg},
  PROMODLG in 'PROMODLG.PAS' {promotestudentdlg},
  STUDLIST in 'STUDLIST.PAS' {StudentListWin},
  CREATE in 'CREATE.PAS' {CreateDlg},
  BCLSHDLG in 'BCLSHDLG.PAS' {blockclashesdlg},
  BLKCLASH in 'BLKCLASH.PAS' {BlockClashes},
  CLMATRIX in 'CLMATRIX.PAS' {cmatwin},
  CLMATSEL in 'CLMATSEL.PAS' {cmatsel},
  SUBBSDLG in 'SUBBSDLG.PAS' {SubjectBySubjectDlg},
  TETIMES in 'TETIMES.PAS' {TeacherTimes},
  TETIMDLG in 'TETIMDLG.PAS' {Teachertimesdlg},
  SUBTIMES in 'SUBTIMES.PAS' {SubjectTimes},
  SUTIMDLG in 'SUTIMDLG.PAS' {SubjectTimesdlg},
  GRPOFTE in 'GRPOFTE.PAS' {GroupofTeachers},
  GRPTEDLG in 'GRPTEDLG.PAS' {Groupofteachersdlg},
  ROOMTT in 'ROOMTT.PAS' {RoTtable},
  ROTTDLG in 'ROTTDLG.PAS' {RoomTTdlg},
  TEACHTT in 'TEACHTT.PAS' {TeTtable},
  TETTDLG in 'TETTDLG.PAS' {TeacherTTdlg},
  STUDTTAB in 'STUDTTAB.PAS' {STtable},
  STULIDLG in 'STULIDLG.PAS' {StudListDlg},
  STUTTDLG in 'STUTTDLG.PAS' {Studttabledlg},
  TCOMMON2 in 'TCOMMON2.PAS',
  BCKUPDLG in 'BCKUPDLG.PAS' {BackupDataDlg},
  FINDSTUD in 'FINDSTUD.PAS' {FindStudent},
  ROCLASH in 'ROCLASH.PAS' {RoomClashes},
  SUBJCTTT in 'SUBJCTTT.PAS' {SuTtable},
  SUBBYSLT in 'SUBBYSLT.PAS' {SubByTimeSlotWin},
  SUBBYSUB in 'SUBBYSUB.PAS' {SubBySubjectWin},
  SUBTTDLG in 'SUBTTDLG.PAS' {SubjectTTdlg},
  EDFAC2 in 'EDFAC2.PAS' {EditFac2},
  ADDSTUD in 'ADDSTUD.PAS' {addstuddlg},
  DELSTUD in 'DELSTUD.PAS' {delstuddlg},
  DELYRSUB in 'DELYRSUB.PAS' {delyrsubdlg},
  REPYRSUB in 'REPYRSUB.PAS' {repysdlg},
  SUBYR in 'SUBYR.PAS' {Subyearwin},
  EDSTUD in 'EDSTUD.PAS' {edstuddlg},
  wsAlter in 'wsAlter.pas' {wsAlterDlg},
  SEARCH in 'SEARCH.PAS' {SearchDlg},
  TTBCLASH in 'TTBCLASH.PAS' {ttclashDlg},
  wsTarget in 'wsTarget.PAS' {wsTargetDlg},
  BOXOP in 'BOXOP.PAS' {BoxDlg},
  SOLVE in 'SOLVE.PAS' {SolveDlg},
  STINPUT in 'STINPUT.PAS' {Stuinput},
  STINDLG in 'STINDLG.PAS' {studentinputdlg},
  TTSIZE in 'TTSIZE.PAS' {ttsizedlg},
  ADDCLASS in 'ADDCLASS.PAS' {AddclassDlg},
  DELCLASS in 'DELCLASS.PAS' {DelclassDlg},
  LENCLASS in 'LENCLASS.PAS' {lenClassDlg},
  showclas in 'showclas.pas' {ClassesShowDlg},
  sortgrp in 'sortgrp.pas' {SortGroupDlg},
  cfggrpmn in 'cfggrpmn.pas' {ConfigureGroupMenudlg},
  hints in 'hints.pas' {Hintsdlg},
  cnfgblck in 'cnfgblck.pas' {Configureblocks},
  wsToolbarwin in 'wsToolbarwin.pas' {WorkSheetToolbar},
  blcktool in 'blcktool.pas' {blocktoolbarwin},
  gentool in 'gentool.pas' {gentoolbarwin},
  Stcommon in 'Stcommon.pas',
  segregat in 'segregat.pas' {SegregateDlg},
  STBARC in 'STBARC.PAS',
  ClassDefs in 'ClassDefs.pas',
  TimesWnd in 'TimesWnd.pas' {TimesWindow},
  PrintPreviewForm in 'PrintPreviewForm.pas' {PrntPreviewForm},
  SuWnd in 'SuWnd.pas' {SuWindow},
  TeWnd in 'TeWnd.pas' {TeWindow},
  RoWnd in 'RoWnd.pas' {RoWindow},
  RollClassWnd in 'RollClassWnd.pas' {RollClassWindow},
  FacWnd in 'FacWnd.pas' {FacultyWindow},
  HouseWnd in 'HouseWnd.pas' {HouseWindow},
  fixsub in 'fixsub.pas' {FixSubDlg},
  rocldlg in 'rocldlg.pas' {roomClashdlg},
  TeList in 'TeList.pas' {TeListWin},
  StBlockClash in 'StBlockClash.pas' {StClashWin},
  StudFree in 'StudFree.pas' {StudFreeWin},
  TeListSelect in 'TeListSelect.pas' {TeListSelDlg},
  tcommon5 in 'tcommon5.pas',
  LOGONDLG in 'LOGONDLG.PAS' {LoggingonDlg},
  ADDUSER in 'ADDUSER.PAS' {AddNewUserDlg},
  EDUSER in 'EDUSER.PAS' {EditUserDlg},
  EDPASSWD in 'EDPASSWD.PAS' {edpassworddlg},
  Deluser in 'Deluser.pas' {DeleteUserDlg},
  SHOWUSER in 'SHOWUSER.PAS' {ShowUsersWin},
  GTSPRPSS in 'GTSPRPSS.PAS' {getSuperPasswordDlg},
  Autoload in 'Autoload.pas' {autoloaddlg},
  CustomOutput in 'CustomOutput.pas',
  WebUpdate in 'WebUpdate.pas' {WebUpdateDlg},
  SubReportLen in 'SubReportLen.pas' {SubReportLendlg},
  InUse in 'InUse.pas' {SpecifyCurTtableDlg},
  EDitTIME in 'EDitTIME.PAS' {AllotDlg},
  TrackChoices in 'TrackChoices.pas' {TrackChoicesDlg},
  sbtsdlg in 'sbtsdlg.pas' {SubjectsByTimeSlotDlg},
  tecldlg in 'tecldlg.pas' {teacherclashdlg},
  DlgCommon in 'DlgCommon.pas',
  SubClassSize in 'SubClassSize.pas' {SetSubSizeDlg},
  TTundo in 'TTundo.pas',
  Tagdlg in 'Tagdlg.pas' {TagDialog},
  Worksheet in 'Worksheet.PAS' {Worksheetwin},
  wsMultiple in 'wsMultiple.PAS' {wsMultipleDlg},
  tttoolbarwin in 'tttoolbarwin.pas' {TtableToolbarWin},
  wsENTRY in 'wsENTRY.PAS' {wsEntryDlg},
  BUILD in 'BUILD.PAS' {BuildDlg},
  StripRooms in 'StripRooms.pas' {StripRoomsDlg},
  FlexiPasteQuiz in 'FlexiPasteQuiz.pas' {FlexiPasteQueryDlg},
  FlexiPaste in 'FlexiPaste.pas' {FlexiPasteDlg},
  ALTER in 'ALTER.PAS' {AlterDlg},
  dmTC in 'dmTC.pas' {DM: TDataModule},
  CopyBlockToTT in 'CopyBlockToTT.PAS' {FrmCopyBlockToTT},
  CopyTT in 'CopyTT.PAS' {FrmCopyTT},
  OpenFile in 'OpenFile.pas' {FrmOpenFile},
  SplitSubjectsConvertor in 'SplitSubjectsConvertor.pas' {FrmSplitSubjectConv},
  StudentClashes in 'StudentClashes.pas' {FrmStudentClashes},
  AllTargetTimes in 'AllTargetTimes.pas' {FrmShowAllTargetTimes},
  TimeChartGlobals in '..\Common\TimeChartGlobals.pas',
  uAMGConst in '..\Common\uAMGConst.pas',
  FamilyClash in 'FamilyClash.pas' {FrmFamilyClash},
  uAMGFamily in '..\Common\uAMGFamily.pas',
  LoadProgress in '..\Common\LoadProgress.pas' {FrmLoadProgress},
  uAMGSubject in '..\Common\uAMGSubject.pas',
  uAMGStudent in '..\Common\uAMGStudent.pas',
  uAMGItem in '..\Common\uAMGItem.pas',
  uAMGTimeTable in '..\Common\uAMGTimeTable.pas',
  uAMGFaculty in '..\Common\uAMGFaculty.pas',
  uAMGTeacher in '..\Common\uAMGTeacher.pas',
  uAMGComment in '..\Common\uAMGComment.pas',
  DCPsha256 in '..\Common\DCPsha256.pas',
  DCPrijndael in '..\Common\DCPrijndael.pas',
  DCPsha1 in '..\Common\DCPsha1.pas',
  uAMGClassSubject in '..\Common\uAMGClassSubject.pas',
  VASSStudentChoicesExport in 'VASSStudentChoicesExport.pas' {FrmVASSStudentChoicesExport},
  VASSStudentExport in 'VASSStudentExport.pas' {FrmVASSStudentExport},
  Teacher in 'Teacher.pas' {FrmTeacher},
  BulkRenameSubjects in '..\Common\BulkRenameSubjects.pas' {FrmBulkRenameSubjects},
  EditTag in '..\Common\EditTag.pas' {FrmEditTag},
  uAMGHealthCondition in '..\Common\uAMGHealthCondition.pas',
  RemoveTimetable in '..\Common\RemoveTimetable.pas' {FrmRemoveTimetable},
  CASES21ImportOptions in '..\Common\CASES21ImportOptions.pas' {FrmCASES21ImportOptions},
  CASES21ExportDataView in '..\Common\CASES21ExportDataView.pas' {FrmCASES21ExportDataView},
  ImportCases21 in '..\Common\ImportCases21.pas' {FrmImportCases21},
  HealthCondition in '..\Common\HealthCondition.pas' {FrmHealthCondition},
  EditHealthCondition in '..\Common\EditHealthCondition.pas' {FrmEditHealthCondition},
  CreateHealthCondition in '..\Common\CreateHealthCondition.pas' {FrmAddHealthCondition},
  TimetableStatistics in '..\Common\TimetableStatistics.pas' {FrmTimetableStatistics},
  BlockTeachers in '..\Common\BlockTeachers.pas' {FrmBlockTeachers},
  SearchBlocks in '..\Common\SearchBlocks.pas' {FrmSearchBlocks},
  NewFeatures in '..\Common\NewFeatures.pas' {FrmNewFeatures},
  TeacherLoadOnWS in '..\Common\TeacherLoadOnWS.pas' {FrmTeacherLoadOnWS},
  ExportToCASES21 in '..\Common\ExportToCASES21.pas',
  ExportToTASS in '..\Common\ExportToTASS.pas' {FrmExportTASS},
  MRUList in '..\Common\MRUList.pas',
  WebTC in 'WebTC.pas',
  Unit1 in 'keygen\Unit1.pas' {Form1},
  XML.TTABLE in '..\XMLDatabaseRoutines\XML.TTABLE.pas',
  XML.TTABLE.CLS in '..\XMLDatabaseRoutines\XML.TTABLE.CLS.PAS',
  XML.TTABLE.NAM in '..\XMLDatabaseRoutines\XML.TTABLE.NAM.pas',
  XML.TTABLE.LAB in '..\XMLDatabaseRoutines\XML.TTABLE.LAB.pas',
  XML.TTABLE.TTW in '..\XMLDatabaseRoutines\XML.TTABLE.TTW.PAS',
  XML.USERS in '..\XMLDatabaseRoutines\XML.USERS.pas',
  XML.UTILS in '..\XMLDatabaseRoutines\XML.UTILS.pas',
  GlobalToTcAndTcextra in '..\Common\GlobalToTcAndTcextra.pas',
  XML.DISPLAY in '..\XMLDatabaseRoutines\XML.DISPLAY.pas',
  XML.TEACHERS in '..\XMLDatabaseRoutines\XML.TEACHERS.pas',
  XML.STUDENTS in '..\XMLDatabaseRoutines\XML.STUDENTS.pas';

{$R *.RES}

 // directives below were added to prevent C0000006 exception from occurring
  {$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP
    or IMAGE_FILE_NET_RUN_FROM_SWAP}

begin
 if MessageDlg('This build of Timechart is for testing only and cannot be released to any live site'+#13+
             'It will conert several files in the database into XML format and once this is done it cannot be reversed. '+
             'There will be a release build of this XML update over the next couple of weeks and will include other enhancements aside from the underlying XML updated'+#13+#13+
             'OK to continue?',
             mtConfirmation,[mbYes, mbNo],0) <> mrYes then begin
    Exit;
  end;
  Application.Title := 'Network TimeChart 6';
  Application.HelpFile := '';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TGetDirDlg, GetDirDlg);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TAbout, About);
  Application.CreateForm(TFrmFamilyClash, FrmFamilyClash);
  Application.CreateForm(TFrmLoadProgress, FrmLoadProgress);
  Application.CreateForm(TFrmVASSStudentChoicesExport, FrmVASSStudentChoicesExport);
  Application.CreateForm(TFrmTeacher, FrmTeacher);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
