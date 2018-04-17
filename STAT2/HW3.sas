data growth1;                                                                                                                           
input Fertilizer Growth;                                                                                                                
datalines;                                                                                                                              
1    10                                                                                                                                 
2    15                                                                                                                                 
3    8                                                                                                                                  
4    19                                                                                                                                 
1    20                                                                                                                                 
2    25                                                                                                                                 
3    18                                                                                                                                 
4    29                                                                                                                                 
1    12                                                                                                                                 
2    17                                                                                                                                 
3    10                                                                                                                                 
4    21                                                                                                                                
;                                                                                                                                       

data growth2;                                                                                                                            
input Fertilizer ENV $ Growth;                                                                                                           
datalines;                                                                                                                              
1  MOSTLY_SHADY  10                                                                                                                                
2  MOSTLY_SHADY  15                                                                                                                                
3  MOSTLY_SHADY  8                                                                                                                                 
4  MOSTLY_SHADY  19                                                                                                                                
1  WETLANDS  20                                                                                                                                
2  WETLANDS  25                                                                                                                                
3  WETLANDS  18                                                                                                                                
4  WETLANDS  29                                                                                                                                
1  SUNNY  12                                                                                                                                
2  SUNNY  17                                                                                                                                
3  SUNNY  10                                                                                                                                
4  SUNNY  21                                                                                                                              
;    

data growth3;                                                                                                                           
input Fertilizer Growth;                                                                                                                
datalines;                                                                                                                              
1    10                                                                                                                                 
2    15                                                                                                                                 
3    8                                                                                                                                  
4    19                                                                                                                                 
1    20                                                                                                                                 
2    25                                                                                                                                 
3    18                                                                                                                                 
4    29                                                                                                                                 
1    12                                                                                                                                 
2    17                                                                                                                                 
3    10                                                                                                                                 
4    22                                                                                                                                
;                                                                                                                                       
    
data growth4;                                                                                                                            
input Fertilizer ENV $ Growth;                                                                                                           
datalines;                                                                                                                              
1  MOSTLY_SHADY  10                                                                                                                                
2  MOSTLY_SHADY  15                                                                                                                                
3  MOSTLY_SHADY  8                                                                                                                                 
4  MOSTLY_SHADY  19                                                                                                                                
1  WETLANDS  20                                                                                                                                
2  WETLANDS  25                                                                                                                                
3  WETLANDS  18                                                                                                                                
4  WETLANDS  29                                                                                                                                
1  SUNNY  12                                                                                                                                
2  SUNNY  17                                                                                                                                
3  SUNNY  10                                                                                                                                
4  SUNNY  22                                                                                                                               
;    

*Question 1;
proc glm data=growth3 plots=(diagnostics residuals);
class fertilizer;
model growth = fertilizer;
lsmeans fertilizer / pdiff tdiff  CL adjust=tukey;
run;

proc mixed data=growth3 PLOTS=(residualpanel);
class fertilizer;
model growth = fertilizer;
lsmeans fertilizer / pdiff tdiff CL adjust=tukey;
run;

*Question 2.1, 2.2, 2.3;
proc glm data=growth4 plots=(diagnostics residuals);
class fertilizer env;
model growth = fertilizer env;
lsmeans fertilizer env / pdiff tdiff  CL adjust=tukey;
run;

proc mixed data=growth4 PLOTS=(residualpanel);
class fertilizer env;
model growth = fertilizer env fertilizer*env;
lsmeans fertilizer env fertilizer*env / pdiff tdiff CL adjust=tukey;
run;

*Question 2.2.a;
proc means mean clm data=growth4;
var growth;
run;

*Question 2.3.b and c;
proc glm data=growth4 plots=(diagnostics residuals);
class fertilizer env;
*model growth = fertilizer env;
model growth = fertilizer env fertilizer*env;
*lsmeans fertilizer env / pdiff tdiff cl adjust=tukey;
lsmeans fertilizer env fertilizer*env / pdiff tdiff CL adjust=tukey;
*contrast "fertilizer 4" fertilizer -1 -1 -1 3 
                        env 1 1 1 
                        fertilizer*env -1 -1 -1 -1 -1 -1 -1 -1 -1 3 3 3;
*estimate "fertilizer 4" fertilizer -1 -1 -1 3 
                        env 1 1 1 
                        fertilizer*env -1 -1 -1 -1 -1 -1 -1 -1 -1 3 3 3;
contrast "fertilizer 4" fertilizer -1 -1 -1 3
                        env -1 -1 2;
estimate "fertilizer 4" fertilizer -1 -1 -1 3
                        env -1 -1 2;                        
run;

*Question 4;
proc glm data=growth4 plots=(diagnostics residuals);
class fertilizer env;
model growth = fertilizer env fertilizer*env;
lsmeans fertilizer env fertilizer*env / pdiff tdiff  CL adjust=tukey;
run;

*Extra credit;
proc glm data=growth4 plots=(diagnostics residuals);
class fertilizer env;
model growth = fertilizer env  /solution;
run;
