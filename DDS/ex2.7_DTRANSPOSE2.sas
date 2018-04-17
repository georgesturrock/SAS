*******************************************************
* This SAS code is an example from the text			  *
* SAS ESSENTIALS 2nd Ed, Wiley                        *
* (C) 2016 Elliott, Alan C. and Woodward, Wayne A.    *
*******************************************************;

* This example illustrates PROC TRANSPOSE;
* You could use MYSASLIB.COMPLICATIONS in the DATA= Statement;
* Note: If you don't already have the MYSASLIB defined, 
        see Chapter 3 Working with SAS Libraries;

TITLE "Illustrates PROC TRANSPOSE, compressing";
TITLE2 "multiple subject records to a single record.";
TITLE3 "Reports subjects having 3 or more complications.";

/* TODO: your computer has COMPLICATIONS data and you can locate it 
    in Windows with the following path.
PROC TRANSPOSE DATA="C:\SASDATA\COMPLICATIONS"

In SAS OnDemand studio, the path of the data file should be found if you right-click 
on the folder, for example, my_content that has the data file

(1) Change the following DATA path to read COMPLICATIONS data from your SAS onDemand Studio
(2) Change the output libraray from EX_MOD2.COMP_OUT to your_lib.COMP_OUT
*/
PROC TRANSPOSE DATA=MYSASLIB.COMPLICATIONS
	OUT=MYSASLIB.COMP_OUT PREFIX=COMP;
	BY SUBJECT;
	VAR COMPLICATION;
RUN;


/*
TODO: 
(1) Change the output libraray from EX_MOD2.MULTIPLE to your_lib.MULTIPLE
(2) drop _NAME_ column if COMP3 is not equal to ''
hint: replace "here" by using the following syntaxes
DROP _NAME_
IF COMP3 NE ' '
*/
DATA MYSASLIB.MULTIPLE;SET MYSASLIB.COMP_OUT;

DROP _NAME_;
IF COMP3 NE ' ';

/*
TODO: 
(1) Change the output libraray from EX_MOD2.MULTIPLE to your_lib.MULTIPLE
*/
PROC PRINT DATA=MYSASLIB.MULTIPLE; VAR SUBJECT COMP1-COMP4;
FORMAT SUBJECT 10. COMP1-COMP4 $10.;
TITLE "Illustrates MULTIPLE";
RUN;

/*
TODO: 
(1) Change the output libraray from EX_MOD2.RENAL, EX_MOD2.COMP_OUT to your_lib.RENAL
and your_lib.COMP_OUT
(2) replace "here" with CATT function, concatenate all columns (COMP1-COMP7) to a variable CCAT
hint: replace "here" with CATT(OF COMP1-COMP7)
(3) replace "here" with FIND() to find any instance of the capital “RENAL” in CCAT, and create a new variable 
named RENALFAILURE
hint: FIND(UPCASE(CCAT),"RENAL")
*/
DATA MYSASLIB.RENAL;SET MYSASLIB.COMP_OUT;
CCAT=CATT(OF COMP1-COMP7);
IF FIND(UPCASE(CCAT),"RENAL") NE 0 THEN RENALFAILURE="Yes";
   ELSE RENALFAILURE="No";
RUN;
PROC PRINT DATA=MYSASLIB.RENAL;
TITLE "Illustrates RENAL";
* PROC PRINT DATA=EX_MOD2.COMP_OUT;
* TITLE "Illustrates COMP_OUT";
RUN;

* PROC FREQ DATA=EX_MOD2.MULTIPLE;
PROC FREQ DATA=MYSASLIB.RENAL;
TABLES RENALFAILURE; 
TITLE "Illustrates MULTIPLE";
RUN;


TITLE;FOOTNOTE;


