%% Scratchpad
% Define functions
 leasqrfunc = @(x, p) p(1) * exp (-p(2) * x);
 leasqrdfdp = @(x, f, p, dp, func) [exp(-p(2)*x), -p(1)*x.*exp(-p(2)*x)];

 % generate test data
 t = [1:10:100]';
 p = [1; 0.1];
 data = leasqrfunc (t, p);
 
 rnd = [0.352509; -0.040607; -1.867061; -1.561283; 1.473191; ...
        0.580767;  0.841805;  1.632203; -0.179254; 0.345208];

 % add noise
 % wt1 = 1 /sqrt of variances of data
 % 1 / wt1 = sqrt of var = standard deviation
 wt1 = (1 + 0 * t) ./ sqrt (data); 
 data = data + 0.05 * rnd ./ wt1; 

 % Note by Thomas Walter :
 %
 % Using a step size of 1 to calculate the derivative is WRONG !!!!
 % See numerical mathbooks why.
 % A derivative calculated from central differences need: s 
 %     step = 0.001...1.0e-8
 % And onesided derivative needs:
 %     step = 1.0e-5...1.0e-8 and may be still wrong

 F = leasqrfunc;
 dFdp = leasqrdfdp; % exact derivative
 % dFdp = dfdp;     % estimated derivative
 dp = [0.001; 0.001];
 pin = [.8; .05]; 
 stol=0.001; niter=50;
 minstep = [0.01; 0.01];
 maxstep = [0.8; 0.8];
 options = [minstep, maxstep];

 global verbose;
 verbose = 1;
 [f1, p1, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r21] = ...
    leasqr (t, data, pin, F, stol, niter, wt1, dp, dFdp, options);