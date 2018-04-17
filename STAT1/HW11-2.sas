%web_drop_table(WORK.autism);

FILENAME REFFILE '/home/gsturrock0/STAT1/autism.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.autism;
	GETNAMES=YES;
RUN;

%web_open_table(WORK.autism);

proc glm data=work.autism plots=all;
model Prevalence = Year / solution clparm;
run;

data logautism;
set work.autism;
logPrevalence = log(Prevalence);
run;

proc reg data=logautism;
title 'Log - Linear';
model logPrevalence = Year / cli;
run;
title;
