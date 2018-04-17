%web_drop_table(WORK.METABOLISM);

FILENAME REFFILE '/home/gsturrock0/STAT1/Metabolism.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.METABOLISM;
	GETNAMES=YES;
RUN;

%web_open_table(WORK.METABOLISM);

/*http://www.stat.purdue.edu/~xuanyaoh/stat350/Lab2.pdf*/
data WORK.METABOLISM;
set WORK.metabolism;
Massto34 = Mass**.75;
run;

proc glm data=work.METABOLISM;
model Metab = Massto34 / solution clparm;
run;

proc reg data=work.metabolism;
title 'Proc Reg CL Mean';
model Metab = Massto34 / clm;
run;
title;

data logmetabolism;
set work.metabolism;
logmetab = log(Metab);
logmassto34 = log(Massto34);
run;

proc reg data=logmetabolism;
title 'Log - Log';
model logmetab = logmassto34 / cli;
run;
title;

/*
proc reg data=logmetabolism;
title 'Log - Linear NO GOOD';
model logmetab = Massto34 / cli;
run;
title;

proc reg data=logmetabolism;
title 'Linear - log NO GOOD';
model metab = logmassto34 / cli;
run;
title;
*/