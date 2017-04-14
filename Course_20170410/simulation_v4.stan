transformed data {
  int <lower = 1> N;
  real <lower = 0, upper = 1> p;

  N = 30;
  p = 0.8;
}

model {
}

generated quantities {
  vector[N] xz[2];

  for (i in 1:N) {
    xz[1,i] = uniform_rng(-3, 3);
  }

  for (n in 1:N) {
    xz[1,n] = bernoulli_rng(xz[1,n]);
  }
}
