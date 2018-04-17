data donner;                                                                                                                            
input Age      Sex $      Status $;                                                                                                     
datalines;                                                                                                                              
23      Male      Died                                                                                                                  
40      Female      Survived                                                                                                            
40      Male      Survived                                                                                                              
30      Male      Died                                                                                                                  
28      Male      Died                                                                                                                  
40      Male      Died                                                                                                                  
45      Female      Died                                                                                                                
62      Male      Died                                                                                                                  
65      Male      Died                                                                                                                  
45      Female      Died                                                                                                                
25      Female      Died                                                                                                                
28      Male      Survived                                                                                                              
28      Male      Died                                                                                                                  
23      Male      Died                                                                                                                  
22      Female      Survived                                                                                                            
23      Female      Survived                                                                                                            
28      Male      Survived                                                                                                              
15      Female      Survived                                                                                                            
47      Female      Died                                                                                                                
57      Male      Died                                                                                                                  
20      Female      Survived                                                                                                            
18      Male      Survived                                                                                                              
25      Male      Died                                                                                                                  
60      Male      Died                                                                                                                  
25      Male      Survived                                                                                                              
20      Male      Survived                                                                                                              
32      Male      Survived                                                                                                              
32      Female      Survived                                                                                                            
24      Female      Survived                                                                                                            
30      Male      Survived                                                                                                              
15      Male      Died                                                                                                                  
50      Female      Died                                                                                                                
21      Female      Survived                                                                                                            
25      Male      Died                                                                                                                  
46      Male      Survived                                                                                                              
32      Female      Survived                                                                                                            
30      Male      Died                                                                                                                  
25      Male      Died                                                                                                                  
25      Male      Died                                                                                                                  
25      Male      Died                                                                                                                  
30      Male      Died                                                                                                                  
35      Male      Died                                                                                                                  
23      Male      Survived                                                                                                              
24      Male      Died                                                                                                                  
25      Female      Survived                                                                                                            
;                                                                                                                                       

* HW12 Q1A,B,2;                                                                                                                                       
proc logistic data=donner plots=all;
class Sex (ref = 'Male') Status (ref = 'Died') / param=ref;
model Status = Age Sex / scale=none ctable clparm=wald lackfit;
output out = propout predictedprob = l;
run;

* HW12 Q1C experiment with females as the reference;                                                                                                                                       
proc logistic data=donner plots=all;
class Sex (ref = 'Female') Status (ref = 'Died') / param=ref;
model Status = Age Sex / scale=none ctable clparm=wald lackfit;
*output out = propout predictedprob = l;
run;

* HW12 Q2 Maybe;
*proc logistic data=donner plots=all;
*class Sex (ref = 'Male') Status (ref = 'Survived') / param=ref;
*model Status = Age Sex / scale=none ctable clparm=wald lackfit;
*run;

