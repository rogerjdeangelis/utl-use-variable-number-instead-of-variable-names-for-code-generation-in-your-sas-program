%let pgm=utl-use-variable-number-instead-of-variable-names-for-code-generation-in-your-sas-program;

Use variable number instead of variable name for code generation in your sas program

i would not use macro variables like this in production code but would use the generated code

Compute the quarterly inflation rate

When you run the code you can retrieve long names instead oF the variable numbers
Highlight the code and type debug on the command line to get the generated code or se options mprint

398  +data want
399  +set have;
400  +inflation_q1=mean(INFLATION_JANUARY, INFLATION_FEBRUARY, INFLATION_MARCH);
401  +inflation_q2=mean(INFLATION_APRIL, INFLATION_MAY, INFLATION_JUNE);
402  +inflation_q3=mean(INFLATION_JULY, INFLATION_AUGUST, INFLATION_SEPTEMBER);
403  +inflation_q4=mean(INFLATION_OCTOBER, INFLATION_NOVEMBER, INFLATION_DECEMBER);
404  +keep inflation_q:;
405  +run;

       SOLUTIONS
           1 sas datastep
           2 sas sql
           3 r pyhton excel sql
           4 useful lists for your autoexcec

github
https://tinyurl.com/2mrh23u3
https://github.com/rogerjdeangelis/utl-use-variable-number-instead-of-variable-names-for-code-generation-in-your-sas-program

FYI
  Useful lists for your autoexec file on the end
  Some relational databases use very long varianle names

/*               _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
*/

/************************************************************************************************************************/
/*                            |                                             |                                           */
/*                            |                                             |                                           */
/*            INPUT           |              PROCESS                        |              OUTPUT                       */
/*                            |    Compute the quarterly inflation rate     |                                           */
/* work.have one ob 12 vars   |                                             |                                           */
/*                            |                                             |                                           */
/* Variable             Value | Compute the quarterly monthly inflation     | INFLATION INFLATION INFLATION INFLATION_  */
/*                            |                                             |     Q1        Q2        Q3        Q4      */
/* INFLATION_JANUARY      1   | 1 SAS DATASTEP                              |                                           */
/* INFLATION_FEBRUARY     1   | ==============                              |      1         2         3         4      */
/* INFLATION_MARCH        1   |                                             |                                           */
/* INFLATION_APRIL        2   | %array(_,values=%utl_varlist(have));        |                                           */
/* INFLATION_MAY          2   |                                             |  GENERATED CODE (edited to fit)           */
/* INFLATION_JUNE         2   | %put &_1;   /*---- JANUARY  ----*/          |                                           */
/* INFLATION_JULY         3   | %put &_12;  /*---- DECEMBER ----*/          |  98  +data want                           */
/* INFLATION_AUGUST       3   |                                             |  99  +set have;                           */
/* INFLATION_SEPTEMBER    3   | %put &_N;   /*---- 12       ----*/          |  00  +inflation_q1=mean(                  */
/* INFLATION_OCTOBER      4   |                                             |      INFLATION_JANUARY                    */
/* INFLATION_NOVEMBER     4   | data want;                                  |     ,INFLATION_FEBRUARY                   */
/* INFLATION_DECEMBER     4   |                                             |     ,INFLATION_MARCH);                    */
/*                            |   set have;                                 |  01  +inflation_q2=mean(                  */
/* data have ;                |                                             |      INFLATION_APRIL                      */
/*   retain                   |   inflation_q1=mean(&_1,  &_2,  &_3);       |     ,INFLATION_MAY                        */
/*    Inflation_January   1   |   inflation_q2=mean(&_4,  &_5,  &_6);       |     ,INFLATION_JUNE);                     */
/*    Inflation_February  1   |   inflation_q3=mean(&_7,  &_8,  &_9);       |  02  +inflation_q3=mean(                  */
/*    Inflation_March     1   |   inflation_q4=mean(&_10, &_11, &_12);      |      INFLATION_JULY                       */
/*    Inflation_April     2   |   keep inflation_q:;                        |     ,INFLATION_AUGUST                     */
/*    Inflation_May       2   |                                             |     ,INFLATION_SEPTEMBER);                */
/*    Inflation_June      2   | run;quit;                                   |  03  +inflation_q4=mean(                  */
/*    Inflation_July      3   |                                             |      INFLATION_OCTOBER                    */
/*    Inflation_August    3   |                                             |    ,INFLATION_NOVEMBER                    */
/*    Inflation_September 3   | 2 SQL SAS                                   |    ,INFLATION_DECEMBER);                  */
/*    Inflation_October   4   | ==========                                  |  04  +keep inflation_q:;                  */
/*    Inflation_November  4   |                                             |  05  +run;                                */
/*    Inflation_December  4   | proc sql;                                   |                                           */
/*  ;                         |  select                                     |                                           */
/* run;quit;                  |    mean(&_1,  &_2,  &_3)  as inflation_q1   |                                           */
/*                            |   ,mean(&_4,  &_5,  &_6)  as inflation_q2   |                                           */
/*                 I          |   ,mean(&_7,  &_8,  &_9)  as inflation_q3   |                                           */
/* I I             N   I I    |   ,mean(&_10, &_11, &_12) as inflation_q4   |                                           */
/* N N             F I N N    |  from                                       |                                           */
/* F F           I L N F F    |    have                                     |                                           */
/* L L I I       N A F L L    | ;quit;                                      |                                           */
/* A A N N   I I F T L A A    |                                             |                                           */
/* T T F F I N N L I A T T    |                                             |                                           */
/* I I L L N F F A O T I I    | 3 R PYTHON EXCEL                            |                                           */
/* O O A A F L L T N I O O    | ================                            |                                           */
/* N N T T L A A I _ O N N    |                                             |                                           */
/* _ _ I I A T T O S N _ _    | %utl_rbeginx;                               |                                           */
/* J F O O T I I N E _ N D    | parmcards4;                                 |                                           */
/* A E N N I O O _ P O O E    | library(haven)                              |                                           */
/* N B _ _ O N N A T C V C    | library(sqldf)                              |                                           */
/* U R M A N _ _ U E T E E    | source("c:/oto/fn_tosas9x.R")               |                                           */
/* A U A P _ J J G M O M M    | have<-read_sas("d:/sd1/have.sas7bdat")      |                                           */
/* R A R R M U U U B B B B    | print(have)                                 |                                           */
/* Y R C I A N L S E E E E    | want<-sqldf("                               |                                           */
/*   Y H L Y E Y T R R R R    |    select                                   |                                           */
/*                            |      (&_1+  &_2+  &_3)/3  as inflation_q1   |                                           */
/* 1 1 1 2 2 2 3 3 3 4 4 4    |     ,(&_4+  &_5+  &_6)/3  as inflation_q2   |                                           */
/*                            |     ,(&_7+  &_8+  &_9)/3  as inflation_q3   |                                           */
/*                            |     ,(&_10+ &_11+ &_12)/3 as inflation_q4   |                                           */
/*                            |    from                                     |                                           */
/*                            |      have                                   |                                           */
/*                            |   ")                                        |                                           */
/*                            | want                                        |                                           */
/*                            | fn_tosas9x(                                 |                                           */
/*                            |       inp    = want                         |                                           */
/*                            |      ,outlib ="d:/sd1/"                     |                                           */
/*                            |      ,outdsn ="want"                        |                                           */
/*                            |      )                                      |                                           */
/*                            | ;;;;                                        |                                           */
/*                            | %utl_rendx;                                 |                                           */
/*                            |                                             |                                           */
/*                            | proc print data=sd1.want;                   |                                           */
/*                            | run;quit;                                   |                                           */
/*                            |                                             |                                           */
/*                            |                                             |                                           */
/*                            | 4 USEFUL LIST FOR YOUR AUTOEXEC             |                                           */
/*                            |   see end of this message                   |                                           */
/*                            |                                             |                                           */
/************************************************************************************************************************/


/*  _                     __       _   _ _     _
| || |    _   _ ___  ___ / _|_   _| | | (_)___| |_ ___
| || |_  | | | / __|/ _ \ |_| | | | | | | / __| __/ __|
|__   _| | |_| \__ \  __/  _| |_| | | | | \__ \ |_\__ \
   |_|    \__,_|___/\___|_|  \__,_|_| |_|_|___/\__|___/

*/

/*---- LETTERS ----*/

%let lettersq=
 "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z";
%let letters=A B C D E F G H I J K L M N O P Q R S T U V W X Y Z;
%let letter=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz;

/*---- NUMBERS ----*/

%let numbersq=%str("1","2","3","4","5","6","7","8","9","10");
%let numbers=1 2 3 4 5 6 7 8 9 10;
%let number=12345678910;

/*---- STATES  ----*/

%let states50q="AL","AK","AZ","AR","CA","CO","CT","DE","FL","GA","HI","ID","IL","IN","IA","KS","KY","LA","ME"
,"MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD"
,"TN","TX","UT","VT","VA","WA","WV","WI","WY";

%let states50= %sysfunc(compbl(AL AK AZ AR CA CO CT DE FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS MO MT
NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TN TX UT VT VA WA WV WI WY)) ;

/*---- MONTHS  ----*/

%let monthsq="JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT", "NOV", "DEC" ;
%let months = JAN FEB MAR APR MAY JUN JUL AUG SEP OCT NOV DEC;

%let monthsq=%str("JANUARY","FEBRUARY","MARCH","APRIL","MAY","JUNE","JULY","AUGUST","SEPTEMBER","OCTOBER","NOVEMBER","DECEMBER");
%let months=JANUARY FEBRUARY MARCH APRIL MAY JUNE JULY AUGUST SEPTEMBER OCTOBER NOVEMBER DECEMBER

/*---- DAYS    ----*/

%let daysq="Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday";
%let days=Monday Tuesday Wednesday Thursday Friday Saturday Sunday;

%let daysabvq="Mon","Tue","Wed","Thu","Fri","Sat","Sun";
%let daysabv=Mon Tue Wed Thu Fri Sat Sun;

/*---- STATES LONG NAMES 50  ----*/

%let stateslnq=%sysfunc(compbl(%str(
 "Alabama"        ,"Alaska"         ,"Arizona"        ,"Arkansas"
,"California"     ,"Colorado"       ,"Connecticut"    ,"Delaware"
,"Florida"        ,"Georgia"        ,"Hawaii"         ,"Idaho"
,"Illinois"       ,"Indiana"        ,"Iowa"           ,"Kansas"
,"Kentucky"       ,"Louisiana"      ,"Maine"          ,"Maryland"
,"Massachusetts"  ,"Michigan"       ,"Minnesota"      ,"Mississippi"
,"Missouri"       ,"Montana"        ,"Nebraska"       ,"Nevada"
,"New Hampshire"  ,"New Jersey"     ,"New Mexico"     ,"New York"
,"North Carolina" ,"North Dakota"   ,"Ohio"           ,"Oklahoma"
,"Oregon"         ,"Pennsylvania"   ,"Rhode Island"   ,"South Carolina"
,"South Dakota"   ,"Tennessee"      ,"Texas"          ,"Utah"
,"Vermont"        ,"Virginia"       ,"Washington"     ,"West Virginia"
,"Wisconsin"      ,"Wyoming")));

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
