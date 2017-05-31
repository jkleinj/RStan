
data {
	int<lower=1> K;  # K components
	int<lower=1> N;  # N observations
	real y[N];       # variable of interest
}

parameters {
	simplex[K] theta;  # mixing proportions
	simplex[K] mu_prop;
	real mu_loc;
	real<lower=0> mu_scale;
	real<lower=0> sigma[K];  # sds of the components
}

transformed parameters {
	ordered[K] mu;
	mu = mu_loc + mu_scale * cumulative_sum(mu_prop);  # means of the components
}

model {
	// prior
	mu_loc ~ cauchy(0,5);
	mu_scale ~ cauchy(0,5);
	sigma ~ cauchy(0,5);

	// likelihood
	{
		real ps[K];
		vector[K] log_theta;
		log_theta = log(theta);

		for (n in 1:N) {
			for (k in 1:K) {
				ps[k] = log_theta[k] + normal_lpdf(y[n] | mu[k], sigma[k]);
			}
			target += log_sum_exp(ps);
		}
	}
}

