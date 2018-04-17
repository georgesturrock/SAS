*******************************************************
* This SAS code is an example from the text			  *
* SAS ESSENTIALS 2nd Ed, Wiley                        *
* (C) 2016 Elliott, Alan C. and Woodward, Wayne A.    *
*******************************************************;

* This example illustrates the use of PROC TRANSPOSE;

/* DONE - TODO: you need to change the following data location with your library  
   EX_LECTU.SUBJECTS means data SUBJECTS in EX_LECTU library
*/
DATA MYSASLIB.SUBJECTS;                                                         

INPUT SUB1 $ SUB2 $ SUB3 $ SUB4 $;                                     
DATALINES;                                                             
12 21 13 14
13 21 12 14
15 31 23 23
15 33 21 32
 M  F  F  M
;          
                                                         
/* DONE - TODO:  complete the following transpose function with DATA: SUBJECTS and OUTPUT: TRANSPOSED
for columns SUB1 SUB2 SUB3 SUB4 

hint: replace "here" by adding the following expression
DATA=EX_LECTU.SUBJECTS OUT=EX_LECTU.TRANSPOSED
VAR SUB1 SUB2 SUB3 SUB4

*/
PROC TRANSPOSE DATA=MYSASLIB.SUBJECTS OUT=MYSASLIB.TRANSPOSED;                       
  VAR SUB1 SUB2 SUB3 SUB4; 
RUN;                                                                   

/* DONE - TODO:  new column name INFO instead of SUB1 SUB2 SUB3 SUB4 
hint: replace "here" with PREFIX=INFO 
*/
PROC TRANSPOSE DATA=MYSASLIB.SUBJECTS OUT=MYSASLIB.TRANSPOSED2 PREFIX=INFO;          
  VAR SUB1 SUB2 SUB3 SUB4; 
RUN;                                                                   

/* DONE - TODO: you need to change the following data location with your library  
*/
PROC PRINT DATA=MYSASLIB.TRANSPOSED2;
RUN;

* new column name;
DATA MYSASLIB.NEW_SUBJ;
/* TODO: 
(1) you need to change the following data location with your library 
(2) replace "here" by renaming columns adding the following: 
       INFO5=GENDER _NAME_=SUBJECT
*/
SET MYSASLIB.TRANSPOSED2;
RENAME INFO1=T1 INFO2=T2
       INFO3=T3 INFO4=T4 
       INFO5=GENDER _NAME_=SUBJECT;
RUN;
/* TODO: you need to change the following data location with your library  
*/
PROC PRINT DATA=MYSASLIB.NEW_SUBJ;
RUN;
TITLE 'transpose function';
FOOTNOTE 'result of TP';
