proc power;
onwayanova test=overall
alpha = .05
groupmeans = 3 | 7 | 8
stddev = 4
power = .8
ntotal = .;
run;

*with contrast;
proc power;
onwayanova test=contrast
alpha = .05
contrast = (1 0 -1)
groupmeans = 3 | 7 | 8
npergroup = 13
stddev = 4
power = .;
run;

*unbalance design;
proc power;
onewayanova test=overall
groupmeans = 3 | 7| 8
stddev = 4
groupweights = (1 2 2)
ntotal = .
power = .9;
run;