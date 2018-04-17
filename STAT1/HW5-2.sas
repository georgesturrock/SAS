%web_drop_table(WORK.ex0525q2);

FILENAME REFFILE '/home/gsturrock0/STAT1/ex0525q2.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.ex0525q2;
	GETNAMES=YES;
RUN;

*PROC CONTENTS DATA=WORK.ex0525q2; RUN;

%web_open_table(WORK.ex0525q2);

data ex0525q2;
SET ex0525q2;
logincome = log(Income2005);
run;

proc means data=ex0525q2;
class Educ;
var Income2005 logincome;
run;

proc glm data=ex0525q2;
class grouping;
model logincome = grouping;
*means grouping / hovtest=bf;
title 'Class = grouping';
run;
title;

proc glm data=ex0525;
class Educ;
model logincome = Educ;
*means Educ / hovtest=bf;
title 'Class = Educ';
run;
title;

/*
proc glm data=ex0525q2;
class grouping;
model Income2005 = grouping;
*means grouping / hovtest=bf;
title 'Class = grouping';
run;
title;

proc glm data=ex0525;
class Educ;
model Income2005 = Educ;
*means Educ / hovtest=bf;
title 'Class = Educ';
run;
title;
*/

