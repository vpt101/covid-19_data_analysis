clf;

rDataLoad;
leasqrfunc = @(x, p) p(3) * exp(p(1) * x) + p(4) * exp(p(2) * x);
X = 1:1:size(dates, 2);

function doFitting(countryName, xdata, ydata, leasqrfunc) 
  [f1, p1, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r21] = ...
    fitCurve(countryName, xdata, ydata, leasqrfunc);
  ['**For ', countryName, '**']
  "\tr2 = "
  r21
  "\tparams = "
  p1
  plot(xdata, ydata, xdata, f1), legend([countryName; 'Model'],'Location','northwest');
  title(['Actual vs Model ', countryName]);
endfunction

country = 'Spain';
doFitting(country, X, countryDataConfirmed.(country), leasqrfunc);
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
figure,

country = 'India';
doFitting(country, X, countryDataConfirmed.(country), leasqrfunc, true);
