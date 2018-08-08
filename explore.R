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



## Outcome Variables for After Tax Income: 
# By INCOME LEVELS: PctChginAftTaxIncPercent_LEVEL_ 2-9
# BY INCOME PERCENTILES: PctChginAftTaxIncPercent_PCT_ 1-18
# PctofPreTaxIncClPercent_LEVEL_1 - what is this?

## Outcome Variables for Revenue Change:
# REV_CHG









## Outcome variables thoughts:
## How do people under 30k do? How do they do relative to people over 100K?



