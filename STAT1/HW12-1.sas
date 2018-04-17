%web_drop_table(WORK.crab);

FILENAME REFFILE '/home/gsturrock0/STAT1/Crab17.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.crab;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.crab; RUN;

%web_open_table(WORK.crab);

proc sgscatter data=work.crab;
plot force*height / group=species;
title 'Scatter Plot by Crab Species';
run;
title;

proc glm data=work.crab plots=all;
class Species(ref = "Cancer productus");
model Force = Height | Species / solution clparm;
*model Force = Height Species / solution clparm;
run;