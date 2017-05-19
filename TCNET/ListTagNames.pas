unit ListTagNames;

interface

uses
 Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
 Dialogs,ClassDefs,  XML.STUDENTS, StdCtrls, FMTBcd, DB, SqlExpr, DBClient,
  DBTables, DBGrids, Grids, AdvObj, BaseGrid, AdvGrid, Menus,XML.DISPLAY,printers;
    

type
  TFrmListTagNames = class(TCodeWin)
    PopupMenu1: TPopupMenu;
    EditTag: TMenuItem;
    N7: TMenuItem;
    Print2: TMenuItem;
    btnEditTag: TButton;

    procedure View1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure EditTagClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Print2Click(Sender: TObject);
    procedure PrintSetup2Click(Sender: TObject);
    procedure btnEditTagClick(Sender: TObject);

   private
    procedure GetTagList ;
   protected
    procedure PaintItem(i:integer;SelFlag:boolean); override;
    procedure SetTabs; override;
    procedure PaintHead; override;
    function MyCodePoint(i:integer): integer; override;
  end;
 procedure SuTagPrint;
 procedure SuTagOut;

var
  FrmListTagNames: TFrmListTagNames;
   printview :integer;

implementation
         uses main,tcommon,tcommon2,edhouse,tcommon5,TimeChartGlobals,dlgcommon,stcommon, EditTag,uAMGStudent,
         Tagdlg;

{$R *.dfm}


 type TprinttagWin=class(TPrintCodeWin)
  public
    procedure head; override;
    procedure SetTabs; override;


 end;

 type TOuttagWin=class(TOutCodeWin)
  public
   procedure head; override;
  function CodeToPrint(i:integer):string; override;


 end;




var
 printtagWin: TprinttagWin;
 OuttagWin: TOuttagWin;


const
 mycode=0;



procedure TFrmListTagNames.FormResize(Sender: TObject);
begin
  Self.SetTabs;
   Refresh;
end;
function TFrmListTagNames.MyCodePoint(i:integer): integer;
begin
 result:=codepoint[i,mycode];
end;



procedure TFrmListTagNames.btnEditTagClick(Sender: TObject);
begin
  if NoStuds then exit;
 if CheckAccessRights(utStud,36,true) then
  begin
   if CheckAccessRights(utStud,5,true) then
    begin
     TagDialog:=tTagDialog.create(self);
     TagDialog.showmodal;
     TagDialog.free;   {release dlg}
     CheckAccessRights(utStud,5,false);
    end;
   CheckAccessRights(utStud,36,false)
  end;
end;

procedure TFrmListTagNames.EditTagClick(Sender: TObject);
begin
    if NoStuds then exit;
 if CheckAccessRights(utStud,36,true) then
  begin
   if CheckAccessRights(utStud,5,true) then
    begin
     TagDialog:=tTagDialog.create(self);
     TagDialog.showmodal;
     TagDialog.free;   {release dlg}
     CheckAccessRights(utStud,5,false);
    end;
   CheckAccessRights(utStud,36,false)
  end;
end;

procedure TFrmListTagNames.setTabs;
var
 A1: integer;
begin

 setlength(Tabs,5);
 TotalCodes:=nmbrTags ;
 headwidth:=canvas.textwidth('Student Tags’');
 CodeWidth:=canvas.textwidth(inttostr(nmbrTags)+': ')+fwTag+blankWidth;
 //CodeFit:= trunc(screen.width*0.9) div CodeWidth;
 CalcScreenCodeFit;
  if CodeWidth <> 0 then
    CodeFit := Trunc(Self.Width - HMargin) div CodeWidth
  else
    CodeFit := 1;
 if CodeFit>TotalCodes then CodeFit:=TotalCodes;
 if Codefit=0 then Codefit:=1;

 Hmargin:=40;
 maxW:=Hmargin+CodeWidth*CodeFit;
 maxH:=txtheight*((TotalCodes div CodeFit)+5);


 maxTab(1,10,'Tag');
 maxTab(2,10,'Tag Code ');
 maxTab(3,100,'Tag Name ');


end;
procedure TFrmListTagNames.PaintItem(i:integer;SelFlag:boolean);
var
    lTag: TAMGTag;
  x1,y1,x2,y2: integer ;
begin

// fcolor(cpNormal);
    // codeColor:=cpStList;

  // canvas.font.color:=clBlack ;

 //  fcolor(codeColor);

 for I := 1 to nmbrTags do
begin

 x:=Tabs[1]; printw(inttostr(i));
 x:=Tabs[2]; printw('  '+TagCode[i]);
 x:=Tabs[3]; printw(TagName[i]);
 newline;
 newline;
 newline;
end;
 if i>=9 then
 begin
  GetTagList;
 end;
 //fcolor(codecolor);
end;

procedure TFrmListTagNames.PopupMenu1Popup(Sender: TObject);
begin
EditTag.Enabled :=True;


end;

procedure TFrmListTagNames.Print2Click(Sender: TObject);
begin
printview:=1;
end;

procedure TFrmListTagNames.PrintSetup2Click(Sender: TObject);
begin
printview :=0;
end;

procedure TFrmListTagNames.PaintHead;
begin
// codeColor:=cpSub;
 {Headings}

   newline;
   newline;



 fcolor(cpNormal);
    x:= Tabs[1];  printwl('Tag');
          x:= Tabs[2]; printw('Tag Code');
          x:= Tabs[3]; printw('Tag Name');
 newline;
 newline;
 newline;
end;


procedure TFrmListTagNames.View1Click(Sender: TObject);
begin
 if ChangeCodeView(wnStudentTag,mycode) then UpdateWin;
end;  

procedure TFrmListTagNames.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action:=cafree;
end;

procedure TFrmListTagNames.FormCreate(Sender: TObject);
begin
 setWindowDefaults(self,wnStudentTag); //wnHouse    wnStudentTag
  printview:=1;
end;

procedure TFrmListTagNames.GetTagList;
var
 dI,dI2,Ip,p,i ,x1,y1,x2,y2:      integer;
 y1t,y2t:                 integer;
 firstOne:                   bool;
 dayStart: array[0..3] of integer;
begin

     i:=1;
  if (nmbrTags>=0) then
  begin
       x1:= hmargin-30; //0-8;
       y1:= hmargin-8;//70;
       x2:= Tabs[3]+140; // 90
       y2:= y1;//68;

     for i := 0 to nmbrTags+1 do    //nmbrTags
     begin
       drawmyline(x1,y1,x2,y2)  ;    //horixontal line
       y1:=y1+42;
       y2:=y2+42;
     end;

       x1:=hmargin-30;
       y1:= hmargin-8;
       x2:= hmargin-30;
       y2:= 452;

     for p := 1 to 2 do
     begin
          drawmyline(x1,y1,x2,y2)  ;
         
           x1:=Tabs[p]+33;
           x2:=Tabs[p]+33;
     end;

       x1:=Tabs[p]-40;
       y1:= hmargin-8;
       x2:=Tabs[p]-40;
       y2:= 452;

     for p:=3 to  4 do
     begin

           drawmyline(x1,y1,x2,y2)  ;
           x1:=Tabs[p]+140;
           x2:=Tabs[p]+140;
     end;
  end;
end;

//----------start----------print-----------------------------------------------


procedure SuTagPrint;
var
 i,k: integer;

 dI,dI2,Ip,p,x1,y1,x2,y2:      integer;
 y1t,y2t:                 integer;
 firstOne:                   bool;
 dayStart: array[0..3] of integer;
begin
 printtagWin:=TPrinttagWin.Create;
 with printtagWin do
  try
   PrintHead;
   newline;
     if TotalCodes<=0 then exit;
     for i:=1 to TotalCodes do
      begin
       k:=codepoint[i,mycode];

        x:= prntTabs[1]; printw('   '+inttostr(i));
        x:= prntTabs[2]; printw('    '+TagCode[k]);
        x:= prntTabs[3]; printw('     '+TagName[k]);
          newline;
          newline;
          newline;


       end;  {for i  to totalcodes}
     fcolor(cpNormal);

  If printview <>0 then
  begin
           i:=1;
    if (nmbrTags>=0) then
    begin
       x1:= 100;
       y1:= 300;
       x2:= 1800; // 90
       y2:= 300;//68;

     for i := 0 to nmbrTags+1 do
     begin                               //horizontal
       drawmyline(x1,y1,x2,y2)  ;
       y1:=y1+230;
       y2:=y2+230;
     end;

       if (nmbrTags>=0) then
    begin
       x1:= 100;
       y1:= 300;
       x2:= 100; // 90
       y2:= 2600;//68;



       for p := 1 to 2 do
     begin                          //vertical
          drawmyline(x1,y1,x2,y2)  ;
          x1:=X1+300;
          x2:=X2+300;

     end;
          x1:=X1+200;
          x2:=X2+200;

        for p := 3 to 4 do
     begin                          //vertical
          drawmyline(x1,y1,x2,y2)  ;
          x1:=X1+920;
          x2:=X2+920;

     end;



  end
  else
  begin


       i:=1;
  if (nmbrTags>=0) then
  begin
       x1:= hmargin-30; //0-8;
       y1:= hmargin+4;//70;
       x2:= prntTabs[3]+140; // 90
       y2:= y1;//68;

     for i := 0 to nmbrTags+1 do    //nmbrTags
     begin
       drawmyline(x1,y1,x2,y2)  ;    //horixontal line
       y1:=y1+42;  //42
       y2:=y2+42;   //42
     end;

       x1:=hmargin-30;//  Tabs[p]; //hmargin-30; //0-8;
       y1:= hmargin+4;;//70;
       x2:= hmargin-30;//;Tabs[p]; // 288
       y2:= 468;//68;

     for p := 1 to 2 do
     begin                          //vertical
          drawmyline(x1,y1,x2,y2)  ;
          // x1:=X1+50;
          // x2:=X2+50;
           x1:=prntTabs[p]+33;
           x2:=prntTabs[p]+33;
     end;

       x1:=prntTabs[p]-40;
       y1:= hmargin+4;
       x2:=prntTabs[p]-40;
       y2:= 468;

     for p:=3 to  4 do
     begin
        if p=3 then
        begin
           drawmyline(x1,y1,x2,y2)  ;
            x1:=prntTabs[p]+140;
            x2:=prntTabs[p]+140;

        end
        else
        begin

           drawmyline(x1,y1,x2,y2)  ;


        end;
     end;
  end;


end;
    end;
  end;
   printCustomAddon;

  finally; {with PrintTeWin}
   printtagWin.Free;
  end;
end; {main print}


procedure SuTagOut;
var
 i,k: integer;

begin
 OuttagWin:=TOuttagWin.Create;
 with OuttagWin do
  try
   Setup(codeCount[mycode]);
   if TotalCodes<=0 then exit;
   for i:=1 to TotalCodes do
    begin
     k:=codepoint[i,mycode];

      printLine([inttostr(i),TagCode[k], TagName[k]]);

    end;  {for i  to totalcodes}
    newline;
   printCustomAddon;
  finally; {with OutTeWin}
   OuttagWin.Free;
  end;
end; {main text output}


procedure  TPrinttagWin.head;
begin
 codeColor:=cpSub;


    x:=15;
     y:=y+PrnttxtHeight;
    fcolor(cpNormal);

   fcolor(cpNormal);
          x:= prntTabs[1]; printwl('Tag');
          x:= prntTabs[2]; printw(' Tag Code');
          x:= prntTabs[3]; printw('    Tag Name');
 newline;
 

  x:=15;
   y:=y+PrnttxtHeight;

  fcolor(cpNormal);
end;

procedure TPrinttagWin.SetTabs;
begin
 setlength(PrntTabs,5);
 TotalCodes:=nmbrTags;
 CodeWidth:=fwPrntCode[mycode]+prntBlankwidth;

 maxTab(1,5,'Tag');
 maxTab(2,10,'Tag Code ');
 maxTab(3,100,'Tag Name ');

 codefit:=1;
 end;



procedure TOuttagWin.head;
begin
 printLine(['Tag ','    Tag Code ','   Tag Name']);
 newline;
 newline;
 newline;


end;

function TOuttagWin.CodeToPrint(i:integer):string;
begin

  codepoint[i,mycode];
end;

//--------end------------print-----------------------------------------------

end.
