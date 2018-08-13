library(tidyverse)
library(viridis)
library(scales)
options(scipen=999999)

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





## Botton Quintile vs Top Decile, Revenue as Color
ggplot(tcja, aes(x=PctChginAftTaxIncPercent_PCT_2, y=PctChginAftTaxIncPercent_PCT_14, color=REV_CHG)) + 
  geom_hline(yintercept = 0, color = "black") + 
  geom_vline(xintercept = 0, color = "black")+ 
  geom_point(alpha=0.5) +
  # scale_x_continuous(limits=c(-3.5,3.5)) +
  scale_y_continuous(limits=c(-3.5,3.5)) +
  scale_color_viridis(labels=function(x) (x/10^9), breaks=pretty_breaks(n = 5)) + 
  labs(x="%Chg AftTaxInx - Bottom Quintile",
       y= "%Chg AftTaxInx - Top Decile",
       color="Revenue Change \n in Billions USD") +
  theme_minimal() + 
  guides(color = guide_colorbar(barheight = unit(8, "cm")))


# There is more variation in the after tax income of the top decile than bottom quintile, and so setting limits for the scales matters a lot. 




## Filtering that allows for looking at similar revenue changes across the data points:
ggplot(data=tcja, mapping=aes(x=PctChginAftTaxIncPercent_PCT_2, y=PctChginAftTaxIncPercent_PCT_14)) + 
  geom_hline(yintercept = 0, color = "black") + 
  geom_vline(xintercept = 0, color = "black") + 
  geom_point(data=filter(tcja, REV_CHG > (1*10^11) & REV_CHG < (2*10^11)), aes(color=REV_CHG), alpha=1) +
  geom_point(data=filter(tcja, ((REV_CHG < (1*10^11)) | (REV_CHG > (2*10^11)))), alpha=0.1, color="#cccccc") +
  scale_y_continuous(limits=c(-3.5,3.5)) +
  scale_color_viridis(limits=range(tcja$REV_CHG),
                      labels=function(x) (x/10^9), 
                      breaks=pretty_breaks(n = 5)) + 
  labs(x="%Chg AftTaxInx - Bottom Quintile",
       y= "%Chg AftTaxInx - Top Decile",
       color="Revenue Change \n in Billions USD") +
  theme_minimal() + 
  guides(color = guide_colorbar(barheight = unit(8, "cm")))




