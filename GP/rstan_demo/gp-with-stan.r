## Gaussian Process Regression with RStan
## James Keirstead
## 19 August 2013
##
## This is based on the examples in Rasmussen and William's Gaussian Processes book.
## See http://www.jameskeirstead.ca/blog/gaussian-process-regression-with-r/ 
##   for the long-hand version

## load the required packages
library(rstan);
library(reshape2);
library(plyr);
library(ggplot2);

#______________________________________________________________________________
## 1. Simulate a process with no data
## small sigma_sq value is necessary to avoid an error
x = seq(-5, 5, 0.2);
n = length(x);
fit = stan(file = "gp-sim.stan", data = list(x = x, N = n, eta_sq = 1, rho_sq = 0.5, 
			sigma_sq = 0.0001), iter = 200, chains = 4);
sims = extract(fit, permuted = TRUE);

## rearrange data and plot
data = adply(sims$y, 2);
tmp = melt(data);
names(tmp) = c("xid", "group", "y");
tmp = mutate(tmp, x = x[xid]);
fig2a = ggplot(tmp, aes(x = x, y = y)) +
	geom_line(aes(group = group), colour = "#999999", alpha = 0.3) +
	theme_bw();
fig2a;
ggsave("fig2a-rstan.png", fig2a, width = 6, height = 4, dpi = 150);

#______________________________________________________________________________
## 2. Simulate with 5 noise-free data points
x1 = c(-4, -3, -1, 0, 2);
y1 = c(-2, 0, 1, 2, -1);
            
## parameter value fixed in given example
fit = stan(file = "gp-predict.stan", data = list(x1 = x1, y1 = y1,
			N1 = length(x1), x2 = x, N2 = length(x),
			eta_sq = 1, rho_sq = 0.5, sigma_sq = 0.0001),
            iter = 200, chains = 4);
sims = extract(fit, permuted = TRUE);

## Rearrange the data and plot it
data = adply(sims$y, 2);
tmp = melt(data);
names(tmp) = c("xid", "group", "y");
tmp = mutate(tmp, x = x[xid]);
fig2b = ggplot(tmp, aes(x = x, y = y)) +
	geom_line(aes(group = group), colour = "#999999", alpha = 0.3) +
	theme_bw() +
	geom_point(data = data.frame(x = x1, y = y1));

ggsave("fig2b-rstan.png", fig2b, width = 6, height = 4, dpi = 150);

#______________________________________________________________________________
## 3. Adding noise through sigma_sq
sigma.n = 0.1;
fit = stan(file = "gp-predict.stan", data = list(x1 = x1, y1 = y1, N1 = length(x1), 
			x2 = x, N2 = length(x), eta_sq = 1, rho_sq = 1, sigma_sq = sigma.n^2),
            iter = 200, chains = 4);
sims = extract(fit, permuted = TRUE);

## Rearrange the data and plot
data = adply(sims$y, 2);
tmp = melt(data);
names(tmp) = c("xid", "group", "y");
tmp = mutate(tmp, x = x[xid]);
fig2c = ggplot(tmp, aes(x = x, y = y)) +
	geom_line(aes(group = group), colour = "#999999", alpha = 0.3) +
	theme_bw() +
	geom_point(data = data.frame(x = x1, y = y1)) +
	geom_errorbar(data = data.frame(x = x1, y = y1),
		aes(x = x,y = NULL, ymin = y - 2 * sigma.n, ymax = y + 2 *sigma.n),
		width = 0.2);

ggsave("fig2c-rstan.png", fig2c, width = 6, height = 4, dpi = 150);

