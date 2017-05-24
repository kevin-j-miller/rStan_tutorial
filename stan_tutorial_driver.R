library(rstan)
library(shinystan)
setwd('C:/Users/kevin/Documents/Presentations/Stan_tutorial')

# Create some data for the Gaussian model
mu <- 5;
sigma <- 5;
n_draws <- 100;
draws <- rnorm(n_draws, mu, sigma);

# Package the data into a list
standata <- list(n_draws = n_draws, draws = draws)

# Compile the model
gaussian_model <- stan_model(file="gaussian_model.stan");

# Sample the Gaussian model
gaussian_model_sampled <- sampling(gaussian_model, data = standata, 
                           warmup = 500, iter = 1000,
                           chains = 5, verbose = 1)

# Extract the samples into a list
samples <- extract(gaussian_model_sampled)

# Look at the summary
print(gaussian_model_sampled)

# Look at histograms
hist(samples[["mu"]])
hist(samples[["sigma"]])

# Look at shinystan
launch_shinystan(gaussian_model_sampled)



# Maumium-a-posteriori the Gaussian model
gaussian_model_MAPed <- optimizing(gaussian_model, data = standata)
print(gaussian_model_MAPed)

# Variational Bayes the Gaussian model
gaussian_model_VBed <- vb(gaussian_model, data = standata)
print(gaussian_model_VBed)