*******************************************************
* This SAS code is an example from the text			  *
* SAS ESSENTIALS 2nd Ed, Wiley                        *
* (C) 2016 Elliott, Alan C. and Woodward, Wayne A.    *
*******************************************************;

* This example illustrates Cleaning a MESSY data file;
******************************************************************;
* Note: If you don't already have the MYSASLIB defined, 
        see Chapter 3 Working with SAS Libraries;
****************************************************************** STEP 1;

/*
TODO: 
(1) Change the output libraray from EX_MOD2.CLEANED, MYSASLIB.MESSYDATA 
to your_lib.CLEANED and your_lib.MESSYDATA
(2) in Label, add the more labels to "here" for the columns as follows:
      Married="Married?"
      Single="Single?"
      Age="Age Jan 1, 2014"
      Gender="Gender"
      Race="Race"

*/
DATA MYSASLIB.CLEANED; SET MYSASLIB.MESSYDATA;

LABEL 
      EDUCATION='Years of Schooling'
      HOW_ARRIVED='How Arrived at Clinic'
      TOP_REASON='Top Reason for Coming'
      SATISFACTION='Satisfaction Score'
      Subject="Subject ID"
      DateArrived="Date Arrived"
      TimeArrive="Time Arrived"
      DateLeft="Date Left"
      TimeLeft="Time Left"
      "here"
      Satisfaction="Satisfaction Score";
TEMP=ARRIVAL;
DROP ARRIVAL;
LABEL TEMP='Arrival Temperature';

****************************************************************** STEP 2;
GENDER=UPCASE(GENDER);
RACE=UPCASE(RACE);
HOW_ARRIVED=UPCASE(HOW_ARRIVED);
/* TODO:
(1) replace "here" with the column HOW_ARRIVED set "" when the column is not the values of 'CAR','BUS','WALK'
HINT: use IN
IN ('CAR','BUS','WALK')

*/
IF HOW_ARRIVED NOT IN ('CAR','BUS','WALK') THEN HOW_ARRIVED="";

* FIX 2 - GET RID OF EMPTY ROWS;
IF SUBJECT="" THEN DELETE;
IF GENDER NOT IN ('M','F') THEN GENDER="";

/* TODO:
(1) replace "here" with a condition for RACE column, if RACE="MEX" OR RACE="M" then set RACE "H"
*/
IF RACE="MEX" OR RACE="M" THEN RACE="H";
IF RACE="A" then RACE="AA";
IF RACE="W" then RACE="C";
IF RACE="X" OR RACE="NA" then RACE="";

****************************************************************** STEP 3;

IF HOW_ARRIVED NOT IN ('CAR','BUS','WALK') THEN HOW_ARRIVED="";

IF RACE NOT IN ('AA','H','C') THEN RACE="";

IF TOP_REASON NE "1" AND 
   TOP_REASON NE "2" AND 
   TOP_REASON NE "3" THEN TOP_REASON=.;

DROP MARRIED;

****************************************************************** STEP 4;

IF TEMP=1018 then TEMP=101.8;
IF EDUCATION=99 then EDUCATION=.;
IF TEMP LT 45 THEN TEMP=(9/5)*TEMP+32;
IF SATISFACTION=-99 THEN SATISFACTION=.;

/* TODO:
(1) replace "here" by Converting AGE from character to numeric and assign it to a variable AGEN
hint: INPUT(AGE,5.)
*/
AGEN=INPUT(AGE,5.);

IF AGEN LT 10 OR AGEN GT 99 THEN AGE=.;
DROP AGE;
LABEL AGEN="Age Jan 1, 2014";

*****************************************************************STEP 5;

FORMAT ARRIVEDT DATETIME18.;
/* TODO:
(1) replace "here" by setting the date format of DATEARRIVED2 to DATE10. and TIMEARRIVET to TIME8.
*/
FORMAT DATEARRIVED2 DATE10 TIMEARRIVET TIME8;

DATEARRIVED2=INPUT(TRIM(DATEARRIVED),MMDDYY10.);
I= FIND(TIMEARRIVE," ");
P=FIND(TIMEARRIVE,"P");
TIMEARRIVE2=SUBSTR(TIMEARRIVE,1,I-1);
TIMEARRIVET=INPUT(TRIM(TIMEARRIVE2),TIME8.);
IF P>0 THEN TIMEARRIVET=TIMEARRIVET+43200; * ADD SECONDS FOR 12 HRS;
ARRIVEDT=DHMS(DATEARRIVED2,0,0,TIMEARRIVET) ;

Label ARRIVEDT="Date & Time Arrived";

RUN;


/* TODO:
(1) replace "here" by setting firstobs 1 and the total rows to print out with obs=30
*/

PROC PRINT LABEL 
     DATA=MYSASLIB.CLEANED 
  (firstobs=1 obs=30);
	 var SUBJEcT DATEARRIVED TIMEARRIVE DATEARRIVED2 TIMEARRIVET ARRIVEDT ;
RUN;


