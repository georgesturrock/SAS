/* Homework 10 - Question 2.  18.7 from the text. */
proc format;                                                                                                                            
   value DrinksFmt 1='Fewer than 4 Drinks per Week'                                                                                                             
                   0='4 or More Drinks per Week';                                                                                                         
   value RspFmt 1='Cases'                                                                                                            
                0='Control';                                                                                                       
run; 
                                                                                                                                   
data BCancer;                                                                                                                        
   input Drinks Response Count;                                                                                                       
   label Response='Breast Cancer';                                                                                                      
   datalines;                                                                                                                           
0 0  386                                                                                                                                
0 1  204                                                                                                                                 
1 0  658                                                                                                                                 
1 1  330                                                                                                                                 
;                                                                                                                                       
                                                                                                                                        
proc sort data=BCancer;                                                                                                              
by descending Drinks descending Response;
*by Drinks Response;                                                                                        
run;                                                                                                                                    

proc freq data=BCancer order=data;                                                                                                   
   format Drinks DrinksFmt. Response RspFmt.;                                                                                            
   tables Drinks*Response / chisq  riskdiff(equal var=null) relrisk;                                              
   exact pchi or fisher;                                                                                                                
   weight Count;                                                                                                                        
   title 'HW 10 - 18.7 - Question 2';                                                                                                         
run;                              