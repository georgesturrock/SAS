%web_drop_table(WORK.RED40);

FILENAME REFFILE '/home/gsturrock0/STAT1/RED40.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.RED40;
	GETNAMES=YES;
RUN;

%web_open_table(WORK.RED40);

PROC UNIVARIATE DATA=WORK.RED40;
class Dosage;
var TimeofDeath;
qqplot / square;
histogram;
run;

proc sgplot data=work.red40;
vbox TimeofDeath / category=Dosage;
run;

proc means data=work.red40;
class Dosage;
var TimeofDeath;
run;

proc npar1way data=work.red40 wilcoxon;
class Dosage;
var TimeofDeath;
*exact wilcoxon HL;
run;

proc glm data=WORK.RED40;
class Dosage;
model TimeofDeath = Dosage;
means Dosage / hovtest=bf dunnett('Control');
lsmeans Dosage / pdiff=control('Control') adjust=dunnett;
run;