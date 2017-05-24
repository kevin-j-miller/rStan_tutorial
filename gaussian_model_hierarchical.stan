data {

int<lower=0> n_draws;
int<lower=0> n_subjs;

real draws[n_draws];
int<lower=0,upper=n_subjs> subjs[n_draws];

}

parameters {

real pop_mu_mean;
real<lower=0> pop_mu_var;
real<lower=0> pop_sigma_mean;
real<lower=0> pop_sigma_var;

real mu[n_subjs];
real<lower=0> sigma[n_subjs];

}

model {

int subj;

// Priors for parameters
target += normal_lpdf(pop_mu_mean| 0, 10);
target += cauchy_lpdf(pop_mu_var| 0, 2.5);

target += normal_lpdf(pop_sigma_mean| 0, 10);
target += cauchy_lpdf(pop_sigma_var| 0, 2.5);


// Draw each subj parameters from population parameters
target += normal_lpdf(mu| pop_mu_mean, pop_mu_var);
target += normal_lpdf(sigma| pop_sigma_mean, pop_sigma_var);


// Draw the data from the subj parameters
for (draw_i in 1:n_draws) {

subj = subjs[draw_i];
target += normal_lpdf(draws[draw_i]| mu[subj], sigma[subj]);

}

}
