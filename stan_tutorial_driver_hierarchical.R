library(rstan)
library(shinystan)
setwd('C:/Users/kevin/Documents/Presentations/Stan_tutorial')

# Create some data for the Gaussian model
pop_mu_mean <- 5;
pop_mu_var <- 5;

pop_sigma_mean <- 5;
pop_sigma_var <- 5;

n_draws_per_subj <- 100;
n_subjs <- 10
  
subj_mus <- rnorm(n_subjs, pop_mu_mean, pop_mu_var);
subj_sigmas <- abs(rnorm(n_subjs, pop_sigma_mean, pop_sigma_var));

draws <- c();
subjs <- c();
for (subj_i in 1:n_subjs) {

  draws <- c(draws, rnorm(n_draws_per_subj, subj_mus[subj_i], subj_sigmas[subj_i])); 
  subjs <- c(subjs, array(subj_i,n_draws_per_subj))
}

# Package the data into a list
standata <- list(n_draws = n_draws_per_subj*n_subjs, draws = draws, subjs = subjs)

# Compile the model
gaussian_model_hierarchical <- stan_model(file="gaussian_model_hierarchical.stan");

# Sample the model
model_fit <- sampling(gaussian_model_hierarchical, data = standata, 
                           warmup = 500, iter = 1000,
                           chains = 5, verbose = 1)
# Extract the samples
samples <- extract(model_fit)

# Look at the summary
print(model_fit)

# Look at histograms
hist(samples[["pop_mu_mean"]])
hist(samples[["mu"]][,1])
hist(samples[["mu"]][,2])

# Look at shinystan
launch_shinystan(model_fit)