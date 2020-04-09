pkg load optim
rDataLoad;
% leasqrfunc = @ (x, p) p(1) * exp (p(2) * x);
% leasqrfunc = @(x, p) p(3) * exp(p(1) .* x) + p(4) * exp(p(2) .* x);
leasqrfunc = @(x, p) p(3) ./ (1 + exp(-(x .- p(2)) ./ p(1)))

X = 1:1:size(dates, 2);

%%function [Q] = leasqrfunc1(x, p)
%%  "p="
%%  disp(p);
%%  "x="
%%  disp(x);
%%  % Q = p(1) * exp (p(2) * x);
%%  Q = p(3) * exp(p(1) * x) + p(4) * exp(p(2) * x);
%%endfunction

# leasqrfunc = @(x, p) leasqrfunc1(x, p)

function [xmatrix, matrix] = prepFitting(xdata, xmatrix, ydata, matrix) 
  xsz = size(xmatrix, 1);
  xmatrix(xsz + 1, :) = xdata;
  ysz = size(matrix, 1);
  matrix(ysz + 1, :) = ydata;
  # datamatrix = matrix;
endfunction

function doFitting(countryName, xdata, ydata, leasqrfunc) 
  rawCountryData = ydata;
  ydata = rawCountryData(find(rawCountryData));
  xdata = 1:1:size(ydata, 2);

  [f1, p1, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r21] = ...
    fitCurve(xdata, ydata, leasqrfunc);
  ['**For ', countryName, '**']
  "\tr2 = "
  r21
  "\tparams = "
  p1

  plot(xdata, ydata, '-o',xdata, f1, '-*' ),
  legend([countryName; 'Model'],'Location','northwest'),
  title(['Actual vs Model ', countryName]);
endfunction

matrix = [];
xmatrix = [];
[xmatrix, matrix] = prepFitting(X, xmatrix, countryDataConfirmed.('Italy'), matrix);
[xmatrix, matrix] = prepFitting(X, xmatrix,  countryDataConfirmed.('Spain'), matrix);
[xmatrix, matrix] = prepFitting(X, xmatrix, countryDataConfirmed.('US'), matrix);
[xmatrix, matrix] = prepFitting(X, xmatrix, countryDataConfirmed.('United Kingdom'), matrix);
[xmatrix, matrix] = prepFitting(X, xmatrix, countryDataConfirmed.('Germany'), matrix);
[xmatrix, matrix] = prepFitting(X, xmatrix, countryDataConfirmed.('India'), matrix);

%%[alpha, C, rms] = expfit (2, 1, 1, countryDataConfirmed.('Italy'))
%%[alpha, C, rms] = expfit (2, 1, 1, countryDataConfirmed.('Spain'))
%%plot(X, f1, X, countryDataConfirmed.('Spain'));

[f1, p1, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r21] = ...
    fitCurve(xmatrix, matrix, leasqrfunc);
size(f1)


#xSer = cell2mat(X);
# plot(X, f1, xmatrix(1, :), f1, xmatrix(1, :), cell2mat(ySer(:, 2)));

ySer{1, 1} = 'Spain';
ySer{1, 2} = countryDataConfirmed.('Spain');
ySer{2, 1} = 'Italy';
ySer{2, 2} = countryDataConfirmed.('Italy');

plotyy(X, f1(1:size(matrix, 1):size(f1, 1)), xmatrix(1, :), cell2mat(ySer(:, 2)));

return
figure,


%%matrix = [];
%%xmatrix = [];
[xmatrix, matrix] = prepFitting(X, xmatrix, countryDataConfirmed.('US'), matrix);
[xmatrix, matrix] = prepFitting(X, xmatrix, countryDataConfirmed.('United Kingdom'), matrix);



%%matrix = [];
%%xmatrix = [];
[xmatrix, matrix] = prepFitting(X, xmatrix, countryDataConfirmed.('Germany'), matrix);

[f1, p1, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r21] = ...
    fitCurve('IT_ES_US_UK_DE', X, matrix, leasqrfunc);


##country = 'India';
##doFitting(country, X, countryDataConfirmed.(country), leasqrfunc);
##
##return;

country = 'Spain';
doFitting(country, X, countryDataConfirmed.(country), leasqrfunc);
return


figure,
country = 'Italy';
doFitting(country, X, countryDataConfirmed.(country), leasqrfunc);

figure,
country = 'US';
doFitting(country, X, countryDataConfirmed.(country), leasqrfunc);

figure,
country = 'United Kingdom';
doFitting(country, X, countryDataConfirmed.(country), leasqrfunc);

figure,
country = 'Germany';
doFitting(country, X, countryDataConfirmed.(country), leasqrfunc);
