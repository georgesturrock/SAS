%web_drop_table(WORK.brain);

FILENAME REFFILE '/home/gsturrock0/STAT1/Brain.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.brain;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.brain; RUN;

%web_open_table(WORK.brain);

data work.brain;
set work.brain;
logBrain = log(brain);
logBody = log(body);
logGestation = log(gestation);
logLitter = log(litter);
run;

proc sgscatter data=work.brain;
matrix body brain gestation litter;
run;

proc sgscatter data=work.brain;
matrix logbody logbrain loggestation loglitter;
run;

proc glm data=work.brain plots=all;
model logbrain = logbody loggestation loglitter / solution clparm;
run;