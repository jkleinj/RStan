transformed data {
  int <lower = 1> N;
  real <lower = 0, upper = 1> p;

  N = 30;
  p = 0.8;
}

model {
}

generated quantities {
  int x[N];
  vector<lower=-3,upper=3>[30] z;

  for (i in 1:N) {
    z[i] = uniform_rng(-3, 3);
  }

  for (n in 1:N) {
    x[n] = bernoulli_rng(p[n]);
  }
}
