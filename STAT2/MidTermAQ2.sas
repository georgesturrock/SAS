%web_drop_table(WORK.aq2train);
FILENAME REFFILE '/home/gsturrock0/STAT2/aq2train.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.aq2train;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.aq2train; RUN;
%web_open_table(WORK.aq2train);

%web_drop_table(WORK.aq2test);
FILENAME REFFILE '/home/gsturrock0/STAT2/aq2test.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.aq2test;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.aq2test; RUN;
%web_open_table(WORK.aq2test);

*subset for relavent variables;
data subaq2train;
set aq2train;
keep lotfrontage lotarea grlivarea yearbuilt totalbsmtsf housestyle;
*lotfrontage = '.';
run;

data subaq2test;
set aq2test;
keep lotfrontage lotarea grlivarea yearbuilt totalbsmtsf housestyle;
*lotfrontage = '.';
run;

*LASSO model with external cross validation;
ods graphics on;
title 'LASSO with external CV and Model Averaging';
proc glmselect data=subaq2train testdata=subaq2test seed=1 plots(stepAxis=number)=(criterionPanel ASEPlot CRITERIONPANEL);
class housestyle;
model lotfrontage = lotarea grlivarea yearbuilt totalbsmtsf housestyle / selection=lasso(choose=cv stop=cv) CVdetails=all showpvalues stats=all;
*modelaverage tables=(effectselectpct(all) parmest(all)) alpha=0.05;
run;
quit;
title;
ods graphics off;

*OLS model;
ods graphics on;
title 'OLS Selection with external CV';
proc glmselect data=subaq2train testdata=subaq2test seed=1 plots(stepAxis=number)=(criterionPanel ASEPlot CRITERIONPANEL);
class housestyle;
model lotfrontage = lotarea grlivarea yearbuilt totalbsmtsf housestyle / selection=stepwise(choose=aic stop=aic) CVDETAILS=all showpvalues stat=all;
run;
quit;
title;

proc glm data=subaq2train plots=all;
class housestyle;
model lotfrontage = lotarea grlivarea yearbuilt totalbsmtsf housestyle / clparm;
lsmeans housestyle / pdiff tdiff cl adjust=tukey;
run;

proc mixed data=subaq2train plots=all;
class housestyle;
model lotfrontage = lotarea grlivarea yearbuilt totalbsmtsf housestyle / clparm;
lsmeans housestyle / pdiff tdiff cl adjust=tukey;
run;
