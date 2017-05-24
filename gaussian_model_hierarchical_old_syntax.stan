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
pop_mu_mean ~ normal(0,10);
pop_mu_var ~ cauchy(0,2.5);
pop_sigma_mean ~ cauchy(0,2.5);
pop_sigma_var ~ cauchy(0,2.5);

// Draw each subj parameters from population parameters
mu ~ normal(pop_mu_mean,pop_mu_var);
sigma ~ normal(pop_sigma_mean,pop_sigma_var);

// Draw the data from the subj parameters
for (draw_i in 1:n_draws) {

subj = subjs[draw_i];
draws[draw_i] ~ normal(mu[subj],sigma[subj]);

}

}
