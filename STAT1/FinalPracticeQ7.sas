%web_drop_table(WORK.repincome);

FILENAME REFFILE '/home/gsturrock0/STAT1/RepIncome..csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.repincome;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.repincome; RUN;

%web_open_table(WORK.repincome);

proc sgplot data=work.repincome;
vbox income / category=candidate;
run;

proc sgplot data=work.repincome;
scatter y=income x=candidate;
run;

*Trump Carson comparison;
DATA TrumpCarson; SET work.repincome; 
  IF code NE 3;
RUN;

proc npar1way data=TrumpCarson wilcoxon alpha=.05;
var income;
class candidate;
exact wilcoxon HL;
title 'Trump Carson';
run;
title;

*Trump Cruz Comparison;
DATA TrumpCruz; SET work.repincome; 
  IF code NE 2;
RUN;

proc npar1way data=TrumpCruz wilcoxon alpha=.05;
var income;
class candidate;
exact wilcoxon HL;
title 'Trump Cruz';
run;
title;

*Cruz Carson comparison;
DATA CruzCarson; SET work.repincome; 
  IF code NE 1;
RUN;

proc npar1way data=CruzCarson wilcoxon alpha=.05;
var income;
class candidate;
exact wilcoxon HL;
title 'Cruz Carson';
run;
title;
