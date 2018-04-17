/* Assignment 2.1 */

data Purchase;
input CustNumber Model $ Quantity;
datalines;
101 L776 1
102 M123 10
103 X999 2
103 M567 1
;
RUN;

data Inventory;
input Model $ Price; format Price dollar8.2;
datalines;
M567 23.50
S888 12.99
L776 159.98
X999 29.95
M123 4.59
S776 1.99
;
run;

proc print data=Inventory;
title '2.1.a - Inventory';
run;

data NewProducts; 
input Model $ Price;
format Price dollar8.2; 
datalines;
L939 10.99
M135 .75
;
run;

proc print data=NewProducts;
title '2.1.a - New Products';
run;

/* 2.1.a Append and Sort Inventory and NewProducts by Model */
data updated; set Inventory NewProducts;
run;

proc sort data=updated;
by Model;
run;

proc print data=updated;
title '2.1.a - Inventory + New Products by Model';
run;

/* 2.1.b - Sort and Interleave*/
proc sort data=Inventory out=SInv;
by Model;
run;

proc sort data=NewProducts out=SNP;
by Model;
run;

*** Interleaving ***;
data updated2;
  set SInv SNP;
  by Model;
run;

proc print data=updated2;
title '2.1.b - Inventory and New Products';
title2 'Sorted and Interleaved';
run;

title; footnote;

/* 2.1.c - Merge Purchase and Inventory */
proc sort data=Purchase out=SPur;
by Model;
run;

data PurPrice; 
merge SPur SInv;
by Model;
TotalCost=(Quantity*Price);
run;

proc print data=purprice;
title '2.1.c - Purchase and Inventory Merge';
run;

/* 2.1.d - Models Not Purchased */
data Purchased; set PurPrice;
DROP CustNumber TotalCost;
IF Quantity = '.';
DROP QUANTITY;
RUN;

PROC PRINT DATA=Purchased;
title '2.1.d - Models Not Purchased';
run;

/* 2.1.e - New Prices */
data NewPrices; set Inventory;
IF Model='M567' then Price=27.95;
IF Model='X999' then Price=38.99;
run;

proc print data=NewPrices;
title '2.1.e - New Prices';
run;

title; footnote;
