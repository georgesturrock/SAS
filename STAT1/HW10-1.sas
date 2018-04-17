%web_drop_table(WORK.BASEBALL2010);

FILENAME REFFILE '/home/gsturrock0/STAT1/Male Display Data Set.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.WHEATEARS;
	GETNAMES=YES;
RUN;

%web_open_table(WORK.WHEATEARS);

proc glm data=work.WHEATEARS;
model Tcell = Mass / solution clparm;
run;

proc reg data=work.wheatears;
title 'Proc Reg CL Mean';
model Tcell = Mass / clm;
run;
title;

proc reg data=work.wheatears;
title 'Proc Req CL Individual Prediction';
model Tcell = Mass / cli;
run;
title;

data addwheatear;
input Mass Tcell;
datalines;
4.5 .
;

data wheatear2;
set work.wheatears work.addwheatear;
run;

* 1.vi;
proc reg data=work.wheatear2;
title '95% Mean Tcell Prediction Interval for Stone Mass = 4.5';
model Tcell = Mass / clm;
run;
title;

* 1.vii;
proc reg data=work.wheatear2;
title '95% Individual Tcell Prediction Interval for Stone Mass = 4.5';
model Tcell = Mass / cli;
run;
title;
