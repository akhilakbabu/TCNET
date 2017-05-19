unit SynergeticExport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, XML.UTILS,GlobalToTcAndTcextra, XML.DISPLAY,XML.STUDENTS,XML.TEACHERS;

type
  TFrmSynergeticExport = class(TForm)
    GroupBox1: TGroupBox;
    Memo1: TMemo;
    BitBtn2: TBitBtn;
    btnExport: TBitBtn;
    procedure btnExportClick(Sender: TObject);

  private
   FExcludeNonTimetabledChoices: Boolean;
    { Private declarations }
  public

    { Public declarations }
  end;

var
  FrmSynergeticExport: TFrmSynergeticExport;

implementation

uses
  uAMGClassSubject, LoadProgress, TimeChartGlobals, TCommon, uAMGConst, TCommon2;

{$R *.dfm}



procedure TFrmSynergeticExport.btnExportClick(Sender: TObject);
var
  i,j,n,m: integer;
  lMsg: string;
  lList: TStringList;
  lStr: string;
  lSubject: string;
  lClassNo: Integer;
  lTeacher: string;
  lClassSubject: TAMGClassSubject;
  lFrmLoadProgress: TFrmLoadProgress;
  lProgress: Integer;
  lPrevProgress: Integer;
  lTtabledSubjects: TStringList;
  lStudDataFound: Boolean;

  function GetSubject(var pSubject: string; var pClassNo: Integer): Boolean;
  var
    aClass:   string[1];
    aSubject: string;
    ClassPos : integer;
  begin
    Result := False;
    aSubject := pSubject;
    begin
        ClassPos := lencodes[0];
        pSubject := Trim(pSubject);
        aClass   := Trim(Copy(aSubject, ClassPos, 1));
      if (aClass>'') then begin
        pClassNo := Ord(aClass[1])-64;
        if pClassNo<1 then pClassNo:=1;
      end else begin
        pClassNo := 1;
      end;
    end;
    Result := True;
  end;

  procedure RefreshTimetabledSubjects;
  var
    StrtYear, FinDay: Integer;
    YYear, d, p, L, a1: Integer;
    aFnt, bFnt: tpIntPoint;
  begin
      StrtYear := years - 1;
      FinDay := days - 1;
      for YYear := StrtYear downto 0 do
      begin
        for d := 0 to finday do
         for p := 1 to Tlimit[d] do
          for L := 1 to level[yyear] do
          begin
            aFnt := FNT(d, p-1, yyear, L, 0);
            bFnt := aFnt;
            a1 := bFnt^;
            if ((a1 > 0) and (a1 <= LabelBase)) then
            begin
              lSubject := Trim(SubCode[a1]);
              lSubject := Copy(lSubject, 1, lencodes[0]);
              GetSubject(lSubject, lClassNo);
              lTtabledSubjects.Add(lSubject);
            end;
          end; {for L}
      end;
  end;


  function DEETdumpTTableOut: Boolean;
  var
    StrtYear, FinYear, StrtDay, FinDay  : Integer;
    YYear,d,p,L,a1: integer;
    aFnt,bFnt: tpIntPoint;
    tmpStr: string;
    lDataFound: Boolean;
    sub,te,ro :integer;
  begin
    lDataFound := False;
    try
      lList.Clear;
     { StrtYear := years - 1;
      FinYear := 0;
      StrtDay := 0;
      FinDay := days - 1;
      for YYear := StrtYear downto FinYear do
      begin
        for d := strtday to finday do
         for p := 1 to Tlimit[d] do
          for L := 1 to level[yyear] do
          begin
            lStr := '';
            aFnt := FNT(d,p-1,yyear,L,0);
            bFnt := aFnt;
            a1 := bFnt^;
            if ((a1>0) and (a1<=LabelBase)) then
            begin
              lSubject := Trim(FNsub(a1,0));
              lSubject := Copy(lSubject, 1, lencodes[0]);

              // Day
              lStr := Trim(IntToStr(d+1));

              // Period
              lStr := lStr + ',' + Trim(IntToStr(p));

              // Get Teacher
              bFnt := aFnt;
              Inc(bFnt,1);
              a1 := bFnt^;
              tmpStr   := FNsub(a1,1);
              lTeacher := Trim(tmpStr);

              // Get Class number
              GetSubject(lSubject, lClassNo);

              // Yr/Subject
              lStr := lStr + ',' +lSubject;

              // Yr
              lStr := lStr + ',' + yearname[YYear];

              //3. now add them both Teacher
              lStr := lStr  + ',' +lTeacher;    //teacher name

              // Room
              bFnt := aFnt;
              inc(bFnt,2);
              a1 := bFnt^;
              tmpStr := FNsub(a1,2);

              lStr := lStr + ',' + Trim(tmpStr);

              lList.Add(lStr);
              lDataFound := True;
            end;
          end; {for L}
    {  end;  // for Year
    }
         for D:=0 to days-1 do
     for P:=0 to periods-1 do
       for YYear:=0 to years_minus_1 do
         for L:=1 to level[YYear] do
         begin
           aFnt:=FNT(D,P,YYear,L,0);
           sub:=aFnt^; inc(aFnt);
           te:=aFnt^; inc(aFnt);
           ro:=aFnt^;
            if ((sub<=LabelBase))  and ((sub>0) or (te>0) or (ro>0)) then
           begin
             if (XML_DISPLAY.pyear[YYear] and XML_DISPLAY.dprint[D+1] and XML_DISPLAY.TsOn[d,p]) then
             begin
                  lStr:= IntToStr(D+1)+','+ IntToStr(P+1)+',' +Trim(Subcode[sub])+',' + Trim(yearname[YYear])+',' + Trim(XML_TEACHERS.tecode[te,0])+',' + Trim(XML_TEACHERS.tecode[ro,1]);
                  lList.Add(lStr);
                  lDataFound := True;
             end;
           end;
          end;

      if lDataFound then
      begin
        lFrmLoadProgress.UpdateProgress(25, Format(AMG_EXPORTING_YEAR_TTABLE_MSG, ['group', GOSname[GOSmenu[XML_DISPLAY.GroupIndexDisplay]]]), 900);
        lFrmLoadProgress.UpdateProgress(25, AMG_TIMETABLE_EXPORT_COMPLETE, 2500);
      end;
    finally
      lList.SaveToFile('synergetic_timetable.txt');
      Application.ProcessMessages;
      Result := lDataFound;
    end;
  end;

Begin
  lList := TStringList.Create;
  lFrmLoadProgress := TFrmLoadProgress.Create(Application);
  lTtabledSubjects := TStringList.Create;

  try
    lFrmLoadProgress.Title := 'Export Synergetic_Students Data';
    lFrmLoadProgress.Show;
    lProgress := 0;
    lPrevProgress := 0;
    ChDir(Directories.datadir);
    delim :=chr(XML_DISPLAY.Txtsep);
    delim2 :=chr(XML_DISPLAY.Txtlim);
    if XML_DISPLAY.Txtlim = 0 then delim2:='';
    lStudDataFound := False;
    RefreshTimetabledSubjects;
    for j := 1 to GroupNum do
    begin
      i := StGroup[j];
      lstr := '';
      lStr := Trim(XML_STUDENTS.Stud[i].stname);
      lStr := lStr + ',';
      lStr := lStr + Trim(XML_STUDENTS.Stud[i].first);
      lStr := lStr + ',';
      lStr := lStr + Trim(YearName[XML_STUDENTS.Stud[i].TcYear]);
      lStr := lStr + ',';
      lStr := lStr + trim(XML_STUDENTS.Stud[i].Sex);
      lStr := lStr + ',';
      lStr := lStr + trim(XML_STUDENTS.Stud[i].ID);
      lStr := lStr + ',';
      lStr := lStr + trim(ClassCode[XML_STUDENTS.Stud[i].Tcclass]);  //Class code
      lStr := lStr + ',';
      lStr := lStr + trim(HouseName[XML_STUDENTS.Stud[i].house]);    //housename
      lStr := lStr + ''; // add a blank
      for n := 1 to chmax do
      begin
        m := XML_STUDENTS.Stud[i].Choices[n];
        if m <= 0 then continue;
          lSubject := Trim(SubCode[m]);
          lStr     := lStr + ',' + lSubject;
          lStudDataFound := True;

      end;
      if lStudDataFound then
      begin
        lList.Add(lStr);
      if j > 0 then
          lProgress := Round((50 * j) / GroupNum);
        lFrmLoadProgress.UpdateProgress(lProgress - lPrevProgress, Format(AMG_EXPORTING_SUBJECT_SELECTION_MSG, [XML_STUDENTS.Stud[i].ID]), 3);
        lPrevProgress := lProgress;
      end;
    end;
    lList.SaveToFile('synergetic_students.txt');
    Application.ProcessMessages;
    if lStudDataFound then
    begin
      lMsg := Format(AMG_STUDENT_SUBJECTS_EXPORT_MSG, [lList.Count]);
      if lProgress < 50 then
      begin
        if lProgress = 0 then
        begin
          lProgress := 50;
          lMsg := AMG_NO_STUDENTS_TO_EXOPORT_MSG;
        end;
      end;
      lFrmLoadProgress.UpdateProgress(0, lMsg, 3000);
      lFrmLoadProgress.UpdateProgress(lProgress - lPrevProgress, lMsg, 10);
      lPrevProgress := lProgress;
    end;  // if

  //-------------------Timetable------------------------------------------

   if not DEETdumpTTableOut and not lStudDataFound then
      lMsg := AMG_NO_DATA_FOUND_MSG
   else
      lMsg := Format(AMG_DATA_EXPORTED_TO_CASES21_MSG, [QuotedStr(Directories.DataDir)]);

   finally

    FreeAndNil(lTtabledSubjects);
    FreeAndNil(lFrmLoadProgress);
    FreeAndNil(lList);
  end;
end;





end.
