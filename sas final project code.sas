PROC IMPORT OUT= BOB1.purchase 
            DATAFILE= "C:\Users\Admin\Desktop\SAS project\customer purch
ase.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
     GUESSINGROWS=5000; 
RUN;

TITLE "Customers' Purchasing Behaviour Analysis"; 
TITLE2 "Shaielendra";
TITLE3 "REPORT DATE :&SYSDATE.";
PROC CONTENTS DATA=Berma.Purchase1;
run;
PROC CONTENTS DATA = Berma.Purchase VARNUM SHORT;
RUN;

*PURCHASE AMOUNT INCOME HOMEVAL FREQUENT RECENCY 
MARITAL NTITLE AGE TELIND APRTMNT MOBILE DOMESTIC APPAREL LEISURE 
KITCHEN LUXURY PROMO7 PROMO13 COUNTY RETURN MENSWARE FLATWARE DISHES 
HOMEACC LAMPS LINENS BLANKETS TOWELS OUTDOOR COATS WCOAT WAPPAR HHAPPAR JEWELRY CUSTDATE TMKTORD 
ACCTNUM STATECOD RACE HEAT NUMCARS NUMKIDS 
TRAVTIME EDLEVEL JOB VALRATIO DINING SEX;

PROC MEANS DATA=Berma.Purchase1;
RUN;
*Missing values;

PROC MEANS DATA=Berma.Purchase1 N NMISS MIN MEAN MEDIAN STD MAX MAXDEC=2;
RUN;
*DROPING;
proc sql;   
alter table Berma.Purchase1      
drop VALRATIO, ACCTNUM, HOMEACC, HOMEVAL, TRAVTIME, RETURN, COUNTY, NUMCARS;
quit;

* OUTLIER  BOXPLOT;
PROC SGPLOT DATA = Berma.Purchase1;
 VBOX INCOME;
RUN;
QUIT;

PROC SGPLOT DATA = Berma.Purchase1;
 VBOX PROMO07;
RUN;
QUIT;


PROC SGPLOT DATA = Berma.Purchase1;
 VBOX AMOUNT;
RUN;
QUIT;
PROC SGPLOT DATA = Berma.Purchase1;
 VBOX PROMO13;
RUN;
QUIT;

* replacing outliers with median;
data outliers;
set Berma.Purchase1;
run;
proc print data=outliers(obs=100);run;
proc means data=outliers Q1 mean median Q3 qrange ;
var INCOME;
output out=limit Q1=Q1 mean=mean median=median Q3=Q3 qrange=qrange;
run;
proc print data=limit;
run;
data limit;
set limit;
lower_limit=Q1-1.5*qrange;
upper_limit=Q3+1.5*qrange;
run;
proc print data=limit;
run;
proc sgplot data=outliers;
vbox INCOME;
run;
proc sql;
create table out_INCOME as
select a.INCOME,b.lower_limit,b.upper_limit,b.mean,b.median
from outliers as a, limit as b
;
quit;
proc print data=out_INCOME(obs=100);
run;
data out_INCOME;
set out_INCOME;
if INCOME>upper_limit or INCOME<lower_limit then out_or_not="yes";
else out_or_not="no";
run;
proc print data=out_INCOME(obs=100);
where out_or_not="yes";
run;
data no_outliers;
set out_INCOME;
if out_or_not="yes" then INCOME=median;
run;

proc print data=no_outliers(obs=100);
where out_or_not="yes";
run;
proc sgplot data=no_outliers;
vbox INCOME;
run;
* VARIABLE AMOUNT ;

data outliers;
set Berma.Purchase1;
run;
PROC PRINT DATA=outliers(OBS=100);RUN;
proc means data=outliers Q1 mean median Q3 qrange ;
var AMOUNT;
output out=limit Q1=Q1 mean=mean median=median Q3=Q3 qrange=qrange;
run;

proc print data=limit;
run;
proc sgplot data=outliers;
vbox AMOUNT;
run;
proc sql;
create table out_AMOUNT1 as
select a.AMOUNT,b.lower_limit,b.upper_limit,b.mean,b.median
from outliers as a, limit as b
;
quit;
proc print data=out_AMOUNT1(obs=100);
run;

data out_AMOUNT;
set out_AMOUNT;
if AMOUNT>upper_limit or AMOUNT<lower_limit then out_or_not="yes";
else out_or_not="no";
run;
proc print data=out_AMOUNT(obs=100);
where out_or_not="yes";
run;
data Berma.no_outliers1;
set out_AMOUNT;
if out_or_not="yes" then AMOUNT=median;
run;

proc print data=Berma.no_outliers1(obs=100);
where out_or_not="yes";
run;
proc sgplot data=Berma.no_outliers1;
vbox AMOUNT;
run;
* VARIABLE PROMO13;
data outliers;
set Berma.Purchase1;
run;
proc print data=outliers(obs=100);
run;
proc means data=outliers Q1 mean median Q3 qrange ;
var PROMO13;
output out=limit Q1=Q1 mean=mean median=median Q3=Q3 qrange=qrange;
run;
proc print data=limit;
run;
data limit;
set limit;
lower_limit=Q1-1.5*qrange;
upper_limit=Q3+1.5*qrange;
run;
proc print data=limit;
run;
proc sgplot data=outliers;
vbox PROMO13;
run;
proc sql;
create table out_PROMO13 as
select a.PROMO13,b.lower_limit,b.upper_limit,b.mean,b.median
from outliers as a, limit as b
;
quit;
proc print data=out_PROMO13(obs=100);
run;
data out_PROMO13;
set out_PROMO;
if PROMO13>upper_limit or PROMO13<lower_limit then out_or_not="yes";
else out_or_not="no";
run;
proc print data=out_PROMO13(obs=100);
where out_or_not="yes";
run;
data Berma.no_outliers2;
set out_PROMO13;
if out_or_not="yes" then PROMO13=median;
run;
proc print data=Berma.no_outliers2(obs=100);
where out_or_not="yes";
run;
proc sgplot data=Berma.no_outliers2;
vbox PROMO13;
run;
* VARIABLE PROMO7;
data outliers;
set Berma.Purchase1;
run;
proc print data=outliers(obs=100);
run;
proc means data=outliers Q1 mean median Q3 qrange ;
var PROMO7;
output out=limit Q1=Q1 mean=mean median=median Q3=Q3 qrange=qrange;
run;
proc print data=limit;
run;
data limit;
set limit;
lower_limit=Q1-1.5*qrange;
upper_limit=Q3+1.5*qrange;
run;
proc print data=limit;
run;
proc sgplot data=outliers;
vbox PROMO7;
run;
proc sql;
create table out_PROMO7 as
select a.PROMO7,b.lower_limit,b.upper_limit,b.mean,b.median
from outliers as a, limit as b
;
quit;
proc print data=out_PROMO7(obs=100);
run;
data out_PROMO7;
set out_PROMO7;
if PROMO7>upper_limit or PROMO7<lower_limit then out_or_not="yes";
else out_or_not="no";
run;
proc print data=out_PROMO7(obs=100);
where out_or_not="yes";
run;
data Berma.no_outliers3;
set out_PROMO7;
if out_or_not="yes" then PROMO7=median;
run;
proc print data=Berma.no_outliers3(obs=100);
where out_or_not="yes";
run;
proc sgplot data=Berma.no_outliers3;
vbox PROMO7;
run;
*UNIVERIATE ANALYSIS;
TITLE "UNIVARIATE ANALYSIS : PURCHASE";
PROC FREQ DATA =Berma.Purchase1; 
TABLE PURCHASE; 
RUN;
TITLE "UNIVARIATE ANALYSIS : INCOME";
PROC FREQ DATA =Berma.Purchase1; 
TABLE INCOME; 
RUN;
PROC HPBIN DATA = Berma.Purchase1 OUTPUT = Berma.temp6;
  INPUT INCOME/NUMBIN=5; 
RUN;
PROC FREQ DATA =Berma.temp6; 
run;
TITLE "UNIVARIATE ANALYSIS :AMOUNT";
PROC FREQ DATA =Berma.Purchase1; 
TABLE AMOUNT; 
RUN;
PROC HPBIN DATA = Berma.Purchase1 OUTPUT = Berma.temp1;
  INPUT AMOUNT/NUMBIN=5; 
RUN;
PROC FREQ DATA =Berma.temp1; 
run;
TITLE "UNIVARIATE ANALYSIS :PROMO13";
PROC FREQ DATA =Berma.Purchase1; 
TABLE PROMO13; 
RUN;
PROC HPBIN DATA = Berma.Purchase1 OUTPUT = Berma.temp;
  INPUT PROMO13/NUMBIN=4;
RUN;
PROC FREQ DATA =Berma.temp; 
run;
*UNIVARIATE VISUALIZATION;

proc SGPLOT data = Berma.Purchase1;
vbar PURCHASE;
run;
quit;
proc sgplot Data=Berma.Purchase1;
HISTOGRAM INCOME;
DENSITY  INCOME;
RUN;
QUIT;
*BI-VARIATE ANALYSIS;

Proc UNIVARIATE data=Berma.Purchase1;
 var AMOUNT;
 class PURCHASE;
run;
*TTEST TO DIFFERENT VARIABLES;
PROC TTEST DATA =Berma.Purchase1;
VAR APPAREL;
CLASS PURCHASE;

RUN;
PROC TTEST DATA =Berma.Purchase1;
VAR JEWELRY;
CLASS PURCHASE;

RUN;

PROC TTEST DATA =Berma.Purchase1;
VAR PROMO7;
CLASS PURCHASE;

RUN;
PROC TTEST DATA =Berma.Purchase1;
VAR PROMO13;
CLASS PURCHASE;
RUN;

*ANOVA : ANALYSIS OF VARIANCE;
PROC ANOVA DATA = Berma.Purchase1;
 CLASS PURCHASE;
 MODEL PROMO7 = PURCHASE;
 MEANS PURCHASE/SCHEFFE;
RUN;
*LOGISTIC REGRESSION;

TITLE "LOGISTIC REGRESSION WITH ONE CATEGORICAL PREDICTOR VARIABLE";
PROC LOGISTIC DATA = Berma.Purchase desc;
class JOB;
model Purchase =PROMO7 PROMO13;
output out=outdate p=pred_prob lower =low upper=upp;
run;
quit;
*ADDING MORE  VARIABLE;
data purchase1;
set Berma.purchase;
APP=APPAREL;
JEW=JEWELRY;
RUN;
PROC LOGISTIC DATA =purchase1 desc;
class JOB;
model Purchase =PROMO7 PROMO13 AGE APP JEW ;
output out=outdate p=pred_prob lower =low upper=upp;
run;
quit;
*TITLE "FORWARD,BACKWARD, AND STEPWISE SELECTION METHODS";

PROC LOGISTIC DATA =purchase1 desc;
class JOB;
model Purchase =PROMO7 PROMO13 AGE APP JEW/SELECTION=FORWARD CLODDS=PL;
RUN;
QUIT;
PROC LOGISTIC DATA =purchase1 desc;
class JOB;
model Purchase =PROMO7 PROMO13 AGE APP JEW/SELECTION=BACKWARD;
RUN;
QUIT;
PROC LOGISTIC DATA =purchase1 desc;
class JOB;
model Purchase =PROMO7 PROMO13 AGE APP JEW/SELECTION=STEPWISE;
RUN;
QUIT;

PROC LOGISTIC DATA =purchase1 desc;
model Purchase =PROMO7;
RUN;
QUIT;









