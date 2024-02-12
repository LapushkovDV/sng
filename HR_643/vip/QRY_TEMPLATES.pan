#declare colorneed (FldCondition)
{Font={BackColor=if(#FldCondition,ColorNeed,0)}}
#end

#declare tableeventtable (table)
TableEvent table #table;
cmSetDefault: {
  if curtable = tnQRY_TMPLTSP {
   if getlast QRY_TMPLTSP1 where ((QRY_TMPLT.nrec == QRY_TMPLTSP1.cTmplt
                                           and 0 <<= QRY_TMPLTSP1.npp)) = tsOK {
         set QRY_TMPLTSP.npp := QRY_TMPLTSP1.npp + 1
       }
    SelectField(#TblTMPLTSP.XF$NAME);
    putcommand(cmpick);
  }
}
cmInsertRecord:
{
  Insert Current #table;
}
cmUpdateRecord:
{
  Update Current #table;
}
cmDeleteRecord:
{
  if curtable = tnQRY_TMPLT {
      if isExistSpecTMPLT then  {
       message('� 蠡���� ���� ᯥ�䨪���, 㤠����� ����������',error);
       stop;abort;exit
     }
  }
 if message('�������?',YesNo)<>cmYes  {
   abort; exit;
  }
  delete Current #table;
}
end; //TableEvent table #table
#end


Window wnQRY_TMPLT_Edit '������஢���� 蠡���� �����' ;
Show at (3,5,120,28);
//---------------------------------------------
Screen ScrQRY_TMPLT_Edit (,,Sci178Esc);
Show at (,,,5);
Table QRY_TMPLT;
Fields
 QRY_TMPLT.CODE        : NoProtect, #colorneed(TRIM(QRY_TMPLT.CODE)='');
 QRY_TMPLT.NAME        : NoProtect, #colorneed(TRIM(QRY_TMPLT.NAME)='');
 QRY_TMPLT.Description : NoProtect;
 TblTMPLT.XF$NAME  : Protect, #colorneed(QRY_TMPLT.TABLECODE =0), PickButton;
 TblTMPLT.XF$TITLE : Skip;
buttons
 cmValue1,,,;
<<
`���` .@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
`������������`.@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   <.�஢���� �����.>
`���ᠭ��`.@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
`��୥��� ⠡��� �����:`
    `������������`.@@@@@@@@@@@@@@@@@@@@@@@@@@@ `���ᠭ��`.@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
>>
end;//Screen ScrQRY_getParameter

//---------------------------------------------
Screen ScrQRY_TMPLT_Edit_panel(,,Sci178Esc);
Show at (,6,,6) Fixed_y;
<<
`���楯�� ⠡��� JOIN`
>>
end;

//---------------------------------------------
Browse brQRY_TMPLTSP;
  Show at (,7,,15);
Table QRY_TMPLTSP;
Fields
  QRY_TMPLTSP.npp            '�','�/�' : [1] , NoProtect,NoPickButton;
  QRY_TMPLTSP.join_type      '⨯ �裡' : [6] , NoProtect,NoPickButton, #colorneed(TRIM(QRY_TMPLTSP.join_type)='');
  TblTMPLTSP.XF$NAME         '������','��⥬���' : [10] , Protect, PickButton;
  QRY_TMPLTSP.SynonimName    '������������','ᨭ�����'   : [10] , NoProtect,NoPickButton;
  'on'                       '',''  : [1] , Skip;
  QRY_TMPLTSP.JoinTerms      '���楯��','�᫮���'  : [20] , NoProtect,NoPickButton, #colorneed(TRIM(QRY_TMPLTSP.JoinTerms)='');
  QRY_TMPLTSP.Description    '���ᠭ��'            : [10] , NoProtect,NoPickButton;
end;//Browse brNormPercent

/*panel pnWhereTerms;
Show at (,16,,16);
Screen ScrWhereTerms(,,Sci178Esc);
Show at (,16,,16) Fixed_y;
<<
`����� WHERE`
>>
end;

end;
*/
panel panWhereTerms;
 show at ( ,16,,);
 table QRY_TMPLT;
// text memoID=memoDepDesc
 text QRY_TMPLT.WhereTerms '����� where';
end;

end;

windowevent wnQRY_TMPLT_Edit;
cmValue1:{
  var iQRY_OUT : QRY_OUT new;
  var _err : string = '';
  if not iQRY_OUT.TestQueryTemplate(QRY_TMPLT.nrec, _err) {
//    message(iQRY_OUT.GetLogFile);
  var __log : string = iQRY_OUT.GetLogFile;
   message('�訡�� ����஥��� �����' +
    + ''#13'' + '���ଠ�� � ����'+
    + ''#13'' +__log,error);
      PutFileToClient(__log,false);
   }
  else {
   message('����� ���४��');
  }
}
end;


browse brQRY_TMPLT;
 table QRY_TMPLT;
  Fields
  QRY_TMPLT.code     '���' : [3] , Protect, nopickbutton, #colorneed(TRIM(QRY_TMPLT.CODE)='');
  QRY_TMPLT.NAME     '������������' : [10] , Protect, nopickbutton, #colorneed(TRIM(QRY_TMPLT.name)='');
  TblTMPLT.XF$NAME   '��୥���','⠡���' : [10] , Protect, nopickbutton, #colorneed(QRY_TMPLT.TABLECODE =0);
end;

#tableeventtable(QRY_TMPLT)
#tableeventtable(QRY_TMPLTSP)
