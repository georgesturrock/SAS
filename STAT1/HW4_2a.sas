%web_drop_table(WORK.LOGGING);

FILENAME REFFILE '/home/gsturrock0/STAT1/Logging.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.LOGGING;
	GETNAMES=YES;
RUN;

*PROC CONTENTS DATA=WORK.LOGGING; RUN;

%web_open_table(WORK.LOGGING);

proc univariate data=work.logging;
var PercentLost;
class Action;
histogram PercentLost;
qqplot PercentLost / square;
run;

proc ttest data=work.logging side=l;
var PercentLost;
class Action;
run;

proc npar1way data=work.logging wilcoxon alpha=.05;
var PercentLost;
class Action;
exact wilcoxon HL;
run;
