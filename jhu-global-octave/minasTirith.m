pkg load optim
rDataLoad;
leasqrFn = @ (x, p) p(1) * exp (p(2) * x);
leasqrFn1 = @(x, p) p(3) * exp(p(1) .* x) + p(4) * exp(p(2) .* x);
logisticModel = @(x, p) p(3) ./ (1 .+ exp(-(x .- p(2)) ./ p(1)));
expModel = @(x, p) p(1) .* exp(p(2) .* (x .- p(3)));

function [modelFunc, eqn, p0, options] = getExpModel() 
%%  modelFunc = @(x, p) p(1) .* exp(p(2) .* (x .- p(3)));
  modelFunc = @(x, p) p(1) .+ exp(p(2) .* (x .- p(3)));
  eqn = @(eqnParams) ["Y = ", num2str(eqnParams(1), "%d"), "* e^{", num2str(eqnParams(2), 3) , "(X - ", num2str(eqnParams(3), 3), ")}"];
  p0 = [1, 1, 1];
  options = [];
endfunction

function [modelFunc, eqn, p0, options] = getLogisticModel() 
  modelFunc = @(x, p) p(3) ./ (1 .+ exp(-(x .- p(2)) ./ p(1)));
  eqn = @(eqnParams) ["Y = ", num2str(eqnParams(3), "%d"), "/ ( 1 +  e^{(-(X - ", num2str(eqnParams(2), 3), ") / ", num2str(eqnParams(1), 3), ")})"];
  p0 = [4, 100, 39600000];
  options.bounds = [1, 10; 50, 200; 100000, 70000000]
endfunction

function [xmatrix, matrix] = prepFitting(xdata, xmatrix, ydata, matrix) 
  ysz = size(matrix, 1);
%%  yDiffs = diff(ydata);
  yDiffs = ydata;
  matrix(ysz + 1, :) = yDiffs;
  xsz = size(xmatrix, 1);
  xmatrix(xsz + 1, :) = 1:1:size(yDiffs, 2);
  
endfunction

function [f1, eqnParams, kvg1, iter1, corrmatEqnP, covmatEqnP, covmatRes, ... 
  stdresid, confIntervals, r2] = fitMeBabyOneMoreTime(countryNames, xdata, ...
  ydata, p, leasqrfunc, eqn, options) 

  [f1, eqnParams, kvg1, iter1, corrmatEqnP, covmatEqnP, covmatRes, stdresid, confIntervals, r2] = ...
    fitCurve(xdata, ydata, p, leasqrfunc, options);
  printf("SQ Err= \n");
  disp(covmatEqnP)
  titleStr = "";
  for si = 1:size(countryNames, 1)
    titleStr = [titleStr, " ~", strtrim(countryNames(si, :))];
  endfor

  printf("**For ", titleStr, "**");
  printf("r2 = \t");
  disp(r2)
  printf("params = \n")
  disp(eqnParams)

  xdataNew = 1:1:(size(xdata, 2) * 2);
  modelData = f1(1:size(ydata, 1):size(f1, 1));
  iCtr = 1;
  for qCnt = 1:size(modelData, 1)
    modelProjection{1, qCnt} = modelData(qCnt);
    modelProjection{2, qCnt} = NaN;
  endfor

  ydataNew = ydata(1:size(ydata, 2));

  for iCnt = size(xdata, 2):1:size(xdataNew, 2)
    modelProjection{1, iCnt} = NaN;
    modelProjection{2, iCnt} = leasqrfunc(iCnt, eqnParams);
    ydataNew(iCnt) = NaN;
  endfor

  titleStr = ["Actual vs Model for", titleStr, "\n"];
  eqnStr = (eqn(eqnParams));
  titleStr = [titleStr, eqnStr ];
  hold on;
  [ax, h1, h2] = plotyy(xdataNew', cell2mat(modelProjection),
      xdataNew', ydataNew);

  colormap(rainbow(6));
  grid on;
  set(ax(1), "yminorgrid", "on");
  set(ax(1), "yminortick", "on");
  set(ax(1), "xminortick", "on");
  set(ax(1), "xminorgrid", "on");
  set(ax(2), "yminorgrid", "on");
  set(ax(2), "yminortick", "on");

  set(h1(1), "Marker", "p");
  set(h2, "Marker", "h");
  set(h1(2), "LineStyle", "--");
  set(h1(2), "Marker", ".");

  legend(["Model (With Avb Data)"; "Model (Projection)"; countryNames], "Location", "northwest");
  title(titleStr);

  figure,
  plotyy(xdata, ydata, xdata, modelData);
  
endfunction

function doCurveFit(dates, countries, rawdata)
  matrix = [];
  xmatrix = [];
  X = 1:1:size(dates, 2);
  
  for cidx = 1:size(countries, 1)
    country = strtrim(countries(cidx, :));
    [xmatrix, matrix] = prepFitting(X, xmatrix, rawdata.(country), matrix);
  endfor

%%  [leasqrfunc, eqn, p0, options] = getExpModel();

  [leasqrfunc, eqn, p0, options] = getLogisticModel();
  fitMeBabyOneMoreTime(countries, xmatrix, matrix, p0, leasqrfunc, eqn, options);
  
endfunction

X = 1:1:size(dates, 2);


doCurveFit(X, "United Kingdom", countryDataConfirmed);
