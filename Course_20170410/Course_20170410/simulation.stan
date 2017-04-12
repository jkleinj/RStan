data {
  int <lower = 1> N;
  real <lower = 0, upper = 1> p;
}

model {
}

generated quantities {
  int x[N];
  for (n in 1:N) {
    x[n] = bernoulli_rng(p);
  }
}
