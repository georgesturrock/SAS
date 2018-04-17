*******************************************************
* This SAS code is an example from the text			  *
* SAS ESSENTIALS 2nd Ed, Wiley                        *
* (C) 2016 Elliott, Alan C. and Woodward, Wayne A.    *
*******************************************************;

* This example illustrates Cleaning a MESSY data file;
******************************************************************;
* Note: If you don't already have the MYSASLIB defined, 
        see Chapter 3 Working with SAS Libraries
******************************************************************

************************************************************STEP 1;

DATA MYSASLIB.CLEANED;SET MYSASLIB.MESSYDATA;

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
      Married="Married?"
      Single="Single?"
      Age="Age Jan 1, 2014"
      Gender="Gender"
      Race="Race"
      Satisfaction="Satisfaction Score";
TEMP=ARRIVAL;
DROP ARRIVAL;
LABEL TEMP='Arrival Temperature';

****************************************************************** STEP 2;
* FIX 1 - Convert text values to all uppercase;
GENDER=UPCASE(GENDER);
RACE=UPCASE(RACE);
HOW_ARRIVED=UPCASE(HOW_ARRIVED);
* FIX 2 SET BAD UNKNOWN VALUES TO MISSING;
IF HOW_ARRIVED NOT IN ('CAR','BUS','WALK') THEN HOW_ARRIVED="";
* FIX 2 - GET RID OF EMPTY ROWS;
IF SUBJECT="" THEN DELETE;
IF GENDER NOT IN('M','F') THEN GENDER="";
*Fix RACE using the code;
IF RACE="MEX" OR RACE="M" then RACE="H";
IF RACE="A" then RACE="AA";
IF RACE="W" then RACE="C";
IF RACE="X" OR RACE="NA" then RACE="";
RUN;

* DISPLAY SOME OF THE CORRECTED VARIABLES;
PROC PRINT LABEL 
     DATA=MYSASLIB.CLEANED 
     (firstobs=1 obs=30);
	  VAR SUBJEcT GENDER RACE HOW_ARRIVED;
RUN;


TITLE;FOOTNOTE;
