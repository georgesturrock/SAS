%web_drop_table(WORK.ifitm3);

FILENAME REFFILE '/home/gsturrock0/STAT2/HW5LongitudinalStudy.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.ifitm3;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.ifitm3; RUN;

%web_open_table(WORK.ifitm3);

*Q1;
proc means data=ifitm3;
class characteristics hours;
var IFITM3;
output out=geneout(drop = _type_ _freq_) mean = mean;
run;

data geneout;
set geneout;
if Hours = '.' then delete;
if characteristics = '' then delete;
run;

proc sgplot data = geneout;
scatter x = Hours y = mean;
series x = Hours y = mean / group=characteristics;
title 'Homework 5 Question 1';
title2 'Mean IFITM3 by Hours';
run;
title;
title2;

*Q2 and Q3a;
proc mixed data=IFITM3 plots=all;
class characteristics hours subject;
model ifitm3 = characteristics hours;
repeated hours / type=cs subject=subject rcorr;
title 'Proc Mixed';
run;
title;

*Q3b;
proc mixed data=IFITM3 plots=all;
class characteristics hours subject;
model ifitm3 = characteristics hours characteristics*hours;
repeated hours / type=cs subject=subject rcorr;
lsmeans characteristics*hours / pdiff tdiff adjust=bon;
slice characteristics*hours;
title 'Proc Mixed';
run;
title;