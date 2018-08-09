library(tidyverse)

################################
## Data Version Note:
## Data can be traced to 7/31 email at 2:30PM, named dberger_tcja_tiny.csv. Email is entitled "output".
################################

## Read in data:
tcja <- read_csv("tcja_tiny.csv")

## 6910 Models Runs:
dim(tcja) 
glimpse(tcja)


View(tcja[1,])

########## INPUTS ########## 
## Helper function to return number of unique elements in a vector:
len_unq <- function(col){
  output <- length(unique(col))
  return(output)
}

################

## Four marginal tax rate structures. Three standard deduction permutations 36 permutations of AMT variables. Two child refund thresholds. 
4*3*36*2


## There are four sets of marginal rates being passed in:
## This does not change when looking at just RATES, or RATES and BRACK variables:
tcja %>%
  select(contains("RATES"), contains("BRACK")) %>%
  summarise_all(funs(uniques = len_unq))

marg_rates <- tcja %>%
  select(NBRACK, contains("RATES"), contains("BRACK")) %>% 
  mutate_all(round, 3) %>%
  unite(sep="--")


## One scenario with 8 tax brackets and three scenarios with 10 tax brackets.
## QUESTION: Though number of rows differs slightly, why 1726, 1728, 1728, 1728?
table(marg_rates)


## Two Child refund threshdolds:
table(tcja$CHILDREFUND_THRESH)


## Two of whatever this is:
table(tcja$CG_HIGHER_BRACK)
table(tcja$CPIBRK_BY)





childcredit_permutations <- tcja %>%
  select(contains("CHILDCREDIT_THRESH")) %>% 
  unite(sep="--")
table(childcredit_permutations)






table(tcja$CHILDREFUND_THRESH)


## 36 AMT Permutations (Across AMTX, AMTTHRSH, and EXAMT variables.)
View(tcja %>%
  select(contains("AMT")) %>%
  summarise_all(funs(uniques = len_unq)))

amt_permutations1 <- tcja %>%
  select(contains("AMTHRSH")) %>% 
  unite(sep="--")
table(amt_permutations1)

amt_permutations2 <- tcja %>%
  select(contains("AMTX")) %>% 
  unite(sep="--")
table(amt_permutations2)

amt_permutations_all <- tcja %>%
  select(contains("AMT")) %>% 
  unite(sep="--")
table(amt_permutations_all)
## Adding EXEMPT_SWITCH to the above caused no change.





## Three standard deduction permutations:
standard_deduction_permutations <- tcja %>%
  select(contains("STANDARD")) %>% 
  unite(sep="--")
table(standard_deduction_permutations)
















##########################################
## Outcome Variables for After Tax Income: 
# By INCOME LEVELS: PctChginAftTaxIncPercent_LEVEL_ 2-9
# BY INCOME PERCENTILES: PctChginAftTaxIncPercent_PCT_ 1-18
# PctofPreTaxIncClPercent_LEVEL_1 - what is this?

## Outcome Variables for Revenue Change:
# REV_CHG


## Outcome variables thoughts:
## How do people under 30k do? How do they do relative to people over 100K?



