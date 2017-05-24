data {

int nTrials;
int choices[nTrials];
int rewards[nTrials];


}

parameters {

real betaTD;
real<lower=0,upper=1> alphaTD;

}

model {

// Define a helper variable Q
vector[2] Q;

// Priors for parameters
target += normal_lpdf(betaTD| 0, 10);
target += beta_lpdf(alphaTD| 2, 2);

// Assign initial values to Q
Q[1] = 0; Q[2] = 0;

// Draw each trial's data, using the observed choices and rewards, as well as the parameters
for (trial_i in 1:nTrials) {

	//choices[trial_i] ~ categorical(softmax(betaTD * Q));
	target += categorical_lpmf(choices[trial_i]| softmax(betaTD * Q);
	
	Q[choices[trial_i]] = Q[choices[trial_i]] * (1-alphaTD)+ rewards[trial_i] * alphaTD;

}


}
