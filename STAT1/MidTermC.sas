%web_drop_table(WORK.myelomac);

FILENAME REFFILE '/home/gsturrock0/STAT1/myelomac.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.myelomac;
	GETNAMES=YES;
RUN;

%web_open_table(WORK.myelomac);

proc univariate data=work.myelomac;
class Drug;
var LambdaDrop;
histogram LambdaDrop;
qqplot LambdaDrop / square;
Run;

proc ttest data=work.myelomac alpha=.01 side=u;
class Drug;
var KappaDrop;
run;