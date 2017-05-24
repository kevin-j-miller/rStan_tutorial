data {

int<lower=0> n_draws;
real draws[n_draws];

}

parameters {

real mu;
real<lower=0> sigma;

}

model {

// Priors
target += normal_lpdf(mu | 0, 10);
target += cauchy_lpdf(sigma | 0, 2.5);

// Likelihood
target += normal_lpdf(draws | mu, sigma); 

}
