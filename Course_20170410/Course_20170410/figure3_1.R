#! /usr/bin/R

library(jrRstan);
data(practical1_data);

fig3_1 = stan("figure3_1.stan", data = practical1_data);
