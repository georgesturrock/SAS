/* A2.2.a Import saledata1.txt */

%web_drop_table(MYSASLIB.SALE1);

FILENAME REFFILE '/home/gsturrock0/UNIT2/saledata1.txt';

PROC IMPORT DATAFILE=REFFILE
	DBMS=DLM
	OUT=MYSASLIB.SALE1 (RENAME=(VAR1=ID VAR2=REGION VAR3=CITYSIZE VAR4=POP VAR5=PRODUCT));
	GETNAMES=NO;
	DATAROW=1;
RUN;

PROC CONTENTS DATA=MYSASLIB.SALE1; 
TITLE 'Assignment 2.2.a';
RUN;

%web_open_table(MYSASLIB.SALE1);

/* A2.2.B Import saledata2.txt */

%web_drop_table(MYSASLIB.SALE2);

FILENAME REFFILE '/home/gsturrock0/UNIT2/saledata2.txt';

PROC IMPORT DATAFILE=REFFILE
	DBMS=DLM
	OUT=MYSASLIB.SALE2 (RENAME=(VAR1=ID VAR2=SALETYPE VAR3=QUANTITY VAR4=AMOUNT));
	GETNAMES=NO;
	DATAROW=1;
RUN;

PROC CONTENTS DATA=MYSASLIB.SALE2; 
TITLE 'Assignment 2.2.b';
RUN;

%web_open_table(MYSASLIB.SALE2);

/* A2.2.C Merge Sale1 and Sale2. */ 

proc sort data=MYSASLIB.SALE1 out=SSALE1;
by ID;
run;

proc sort data=MYSASLIB.SALE2 out=SSALE2;
by ID;
run;

/* USE IN and subsetting IF to merge and exclude records not in both data sets */
data SALEDATA; 
merge SSALE1 (IN=INSALE1) SSALE2 (IN=INSALE2);
by ID;
IF INSALE1 AND INSALE2;
run;

PROC PRINT DATA=SALEDATA;
TITLE 'Assignment 2.2.C';
RUN;

/* A2.2.D RUN PROC MEANS */
PROC MEANS DATA=SALEDATA MEAN STD MIN Q1 MEDIAN Q3 MAX MAXDEC=2;
VAR POP QUANTITY AMOUNT;
TITLE 'Assignment 2.2.D';
RUN;

/* A2.2.E PROC MEANS AND PROC FORMAT FOR SALEDATA */
PROC FORMAT;
VALUE $FMTSALETYPE R="Retail" W="Online";
RUN;

PROC MEANS DATA=SALEDATA MEAN STD MIN Q1 MEDIAN Q3 MAX MAXDEC=2;
CLASS PRODUCT SALETYPE;
LABEL POP='Population Size'
      QUANTITY='No. of Items'
      AMOUNT='Invoice Amount';
FORMAT SALETYPE $FMTSALETYPE.;
VAR POP QUANTITY AMOUNT;
TITLE 'Summary Statistics of the Sales Data';
RUN;

/* A2.2.F CREATE SALESUMMARY DATA SET. */ 
PROC MEANS DATA=SALEDATA MEAN MEDIAN SKEWNESS KURTOSIS MAXDEC=2;
CLASS SALETYPE;
VAR QUANTITY AMOUNT;
TITLE 'Assignment 2.2.F';
OUTPUT OUT=SALESUMMARY (DROP=_TYPE_ _FREQ_)
                       N=OBS
                       MEAN(QUANTITY)=MEAN_QTY 
                       MEDIAN(QUANTITY)=MEDIAN_QTY 
                       SKEWNESS(QUANTITY)=SKEWNESS_QTY 
                       KURTOSIS(QUANTITY)=KURTOSIS_QTY 
                       MEAN(AMOUNT)=MEAN_AMT 
                       MEDIAN(AMOUNT)=MEDIAN_AMT 
                       SKEWNESS(AMOUNT)=SKEWNESS_AMT 
                       KURTOSIS(AMOUNT)=KURTOSIS_AMT;
RUN;

PROC PRINT DATA=WORK.SALESUMMARY;
TITLE 'Assignment 2.2.F Output';
RUN;

TITLE;