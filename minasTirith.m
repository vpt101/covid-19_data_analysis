pkg load optim
rDataLoad;
leasqrFn = @ (x, p) p(1) * exp (p(2) * x);
leasqrFn1 = @(x, p) p(3) * exp(p(1) .* x) + p(4) * exp(p(2) .* x);
logisticFn = @(x, p) p(3) ./ (1 .+ exp(-(x .- p(2)) ./ p(1)));
leasqrfunc = logisticFn

function [xmatrix, matrix] = prepFitting(xdata, xmatrix, ydata, matrix) 
  ysz = size(matrix, 1);
  yDiffs = diff(ydata);
  matrix(ysz + 1, :) = yDiffs;
  xsz = size(xmatrix, 1);
  xmatrix(xsz + 1, :) = 1:1:size(yDiffs, 2);
  
endfunction

function fitMeBabyOneMoreTime(countryNames, xdata, ydata, p, leasqrfunc) 

  [f1, eqnParams, kvg1, iter1, corrmat, covp, covr1, stdresid1, Z1, r2] = ...
    fitCurve(xdata, ydata, p, leasqrfunc);

  titleStr = "";
  for si = 1:size(countryNames, 1)
    titleStr = [titleStr, " ~", strtrim(countryNames(si, :))];
  endfor

  ["**For ", titleStr, "**"]
  "\tr2 = "
  r2
  "\tparams = "
  eqnParams
  
  stdresid1
  titleStr = ["Actual vs Model for", titleStr, "\n"];
  eqnStr = ["Y = ", num2str(eqnParams(3)), "/ ( 1 +  e^{(-(X - ", num2str(eqnParams(2), 3), ") / ", num2str(eqnParams(1), 3), ")})"]
  titleStr = [titleStr, eqnStr ];
  [ax, h1, h2] = plotyy(xdata(1, :), f1(1:size(ydata, 1):size(f1, 1)), xdata(1, :), ydata);
  legend(["Model"; countryNames],"Location","northwest");
  title(titleStr);
  grid on;
endfunction

function doCurveFit(dates, countries, rawdata, leasqrfunc)
  matrix = [];
  xmatrix = [];
  X = 1:1:size(dates, 2);
  for cidx = 1:size(countries, 1)
    country = strtrim(countries(cidx, :));
    [xmatrix, matrix] = prepFitting(X, xmatrix, rawdata.(country), matrix);
  endfor
  fitMeBabyOneMoreTime(countries, xmatrix, matrix, [ 4, 100, 25000 ], leasqrfunc);
endfunction

X = 1:1:size(dates, 2);

%%doCurveFit(X, ["Italy"; "Spain"; "US"; "United Kingdom"; "Germany"], countryDataConfirmed, leasqrfunc);
%%figure,
%%doCurveFit(X, ["US"; "United Kingdom"], countryDataConfirmed, leasqrfunc);
%%figure,
doCurveFit(X, 'Italy', countryDataConfirmed, leasqrfunc);
return;
figure,
doCurveFit(X, 'Spain', countryDataConfirmed, leasqrfunc);
figure,
doCurveFit(X, 'US', countryDataConfirmed, leasqrfunc);
figure,
doCurveFit(X, 'United Kingdom', countryDataConfirmed, leasqrfunc);
figure,
doCurveFit(X, 'Germany', countryDataConfirmed, leasqrfunc);


%% Commented lines below for creating charts of model against raw numbers as opposed to the diff(CoD) as doCurveFit is wont to do.
%% The model is always constructed from the diffs but the remaining series can be constructed from actual data.
%% 
%%matrix = [];
%%xmatrix = [];
%%[xmatrix, matrix] = prepFitting(X, xmatrix, countryDataConfirmed.("Italy"), matrix);
%%[xmatrix, matrix] = prepFitting(X, xmatrix, countryDataConfirmed.("Spain"), matrix);
%%[xmatrix, matrix] = prepFitting(X, xmatrix, countryDataConfirmed.("US"), matrix);
%%[xmatrix, matrix] = prepFitting(X, xmatrix, countryDataConfirmed.("United Kingdom"), matrix);
%%[xmatrix, matrix] = prepFitting(X, xmatrix, countryDataConfirmed.("Germany"), matrix);
%%
%%[f1, p1, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r21] = ...
%%    fitCurve(xmatrix, matrix, [ 4, 100, 25000 ], leasqrfunc);
%%
%%
%%ySer{1, 1} = "Spain";
%%ySer{1, 2} = countryDataConfirmed.("Spain");
%%ySer{2, 1} = "Italy";
%%ySer{2, 2} = countryDataConfirmed.("Italy");
%%ySer{3, 1} = "US";
%%ySer{3, 2} = countryDataConfirmed.("US");
%%ySer{4, 1} = "United Kingdom";
%%ySer{4, 2} = countryDataConfirmed.("United Kingdom");
%%ySer{5, 1} = "Germany";
%%ySer{5, 2} = countryDataConfirmed.("Germany");
%%
%%plotyy(xmatrix(1, :), f1(1:size(matrix, 1):size(f1, 1)), X, cell2mat(ySer(:, 2)));
%%legend(["Model"; "Spain"; "Italy"; "US"; "UK"; "Germany"],"Location","northwest");
%%figure,
%%xmatrix = [];
%%matrix = [];
%%country = "Italy";
%%[xmatrix, matrix] = prepFitting(X, xmatrix, countryDataConfirmed.(country), matrix);
%%fitMeBabyOneMoreTime(country, xmatrix, matrix, [ 4, 100, 25000 ], leasqrfunc);
%%figure,
%%

