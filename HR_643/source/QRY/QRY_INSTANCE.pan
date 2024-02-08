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
      if isExistSpec then  {
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

#declare colorneed (FldCondition)
{Font={BackColor=if(#FldCondition,ColorNeed,0)}}
#end


window wintFields '�롮� ���� ⠡���', cyan;
browse brwintFields;
 table tFields;
  Fields
   tFields.SYSNAMETBL '������','��⥬���'    : [8], Protect, NoPickButton;
   tFields.NAMETBL    '�������','� �����'    : [8], Protect, NoPickButton;
   tFields.NAME       '����'      :[10], Protect, NoPickButton;
   tFields.TITLE      '���ᠭ��'  :[15], Protect, NoPickButton;
   tFields.DATATYPE   '��� ������'   : [4], Protect, NoPickButton;
end;
end;
windowevent wintFields ;
 cmdefault: {
   closewindowex(wintFields, cmDefault)
 }
end;



Window wnQRY_INSTANCE_Edit '������஢���� ������� �����' ;
Show at (3,5,120,28);
//---------------------------------------------
Screen ScrQRY_INSTANCE_Edit (,,Sci178Esc);
Show at (,,,5);
Table QRY_INSTANCE;
Fields
 QRY_TMPLT.CODE        : NoProtect, #colorneed(QRY_TMPLT.CODE='');
 QRY_TMPLT.NAME        : NoProtect, #colorneed(QRY_TMPLT.NAME='');
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
  QRY_TMPLTSP.join_type      '⨯ �裡' : [6] , NoProtect,NoPickButton;
  TblTMPLTSP.XF$NAME         '������','��⥬���' : [10] , Protect, PickButton;
  QRY_TMPLTSP.SynonimName    '������������','ᨭ�����'   : [10] , NoProtect,NoPickButton;
  'on'                       '',''  : [1] , Skip;
  QRY_TMPLTSP.JoinTerms      '���楯��','�᫮���'  : [20] , NoProtect,NoPickButton;
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
 table QRY_INST_TMPLT;
// text memoID=memoDepDesc
 text QRY_INST_TMPLT.WhereTerms '����� where �� 蠡����';
end;

end;

windowevent wnQRY_TMPLT_Edit;
cmValue1:{
  var iQRY_OUT : QRY_OUT new;
  var _err : string = '';
  if not iQRY_OUT.TestQueryTemplate(QRY_TMPLT.nrec, _err) {
//    message(iQRY_OUT.GetLogFile);
   if message('�訡�� ����஥��� �����' +
    + ''#13'' + _err
    +''#13''+ '�������� ���?', error+ YesNo) = cmYes {
      ProcessText(iQRY_OUT.GetLogFile, vfDefault , '������� �஢�ન �����');
    }

  }
  else {
   message('����� ���४��');
  }
}
end;

         and QRY_INST.nrec == QRY_INST_FLD.nrec
         and QRY_INST.nrec == QRY_INST_FLD_LVL.cInstance
                    and 0 <<= QRY_INST_FLD_LVL.level (noindex)
         and QRY_INST_FLD.cLevel == QRY_INST_FLD_LVL_FLD.nrec
       and QRY_INST.cTmplt == QRY_INST_TMPLT.nrec
   and QRY_INST_TMPLT.nrec == QRY_INST_TMPLTSP.cTmplt

browse brQRY_INST;
 table QRY_INST;
  Fields
  QRY_INST.code        '���'          : [3] , Protect, nopickbutton, #colorneed(QRY_INST.CODE='');
  QRY_INST.NAME        '������������' : [10] , Protect, nopickbutton, #colorneed(QRY_INST.name='');
  QRY_INST.Description '���ᠭ��'     : [10] , Protect, nopickbutton;
  QRY_INST_TMPLT.code  '������','���'          : [3]  , Protect, nopickbutton, #colorneed(QRY_INST_TMPLT.CODE='');
  QRY_INST_TMPLT.NAME  '������','������������' : [10] , Protect, nopickbutton, #colorneed(QRY_INST_TMPLT.name='');
  TblINST.XF$NAME      '��୥���','⠡���'    : [10] , Protect, nopickbutton, #colorneed(QRY_INST_TMPLT.TABLECODE =0);
end;

#tableeventtable(QRY_INST)
#tableeventtable(QRY_INST_TMPLT)
#tableeventtable(QRY_INST_FLD_LVL)
