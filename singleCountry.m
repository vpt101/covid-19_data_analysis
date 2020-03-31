pkg load io;

% Anon func that calls cellfun with another anon func 
convertDateNumCellArrToStr = @(dtCellArray, fmt) cellfun(@(x) datestr(x, fmt), dtCellArray, 'UniformOutput', false);

% clear all;

%if ~nargin
%  % country = 'India'
%  country = 'US'
%else
%  arg_list = argv ();
%  country = arg_list{1}
%endif
%

country = 'India';

Config = Configuration();
location = Config.('location');
baseUrl = Config.('baseUrl');
protectorates = Config.('protectorates');

filename = Config.('confirmedFilename');
url = [baseUrl, '/', filename];
filePath = [location, '/', filename];
[dates, countryData, countryProvinceStruct] = processFile(protectorates, filePath, url);
cases = countryData.(country);

filename = Config.('deathsFilename');
filePath = [location, '/', filename];
url = [baseUrl, '/', filename];
[dates, countryData, countryProvinceStruct] = processFile(protectorates, filePath, url);
deaths = countryData.(country);

filename = Config.('recoveredFilename');
filePath = [location, '/', filename];
url = [baseUrl, '/', filename];
[dates, countryData, countryProvinceStruct] = processFile(protectorates, filePath, url);
recoveries = countryData.(country);

xSer = cell2mat(dates);
ySer{1, 1} = 'Cases';
ySer{1, 2} = cases;

pkg load statistics;
casesRange = nanmax(cases) - nanmin(cases);
recoveriesRange = nanmax(recoveries) - nanmin(recoveries);
deathsRange = nanmax(deaths) - nanmin(deaths);
y2{1, 1} = 'Recovered';
y2{1, 2} = recoveries;
y2{2, 1} = 'Deaths';
y2{2, 2} = deaths;

clf;
hold on;
[hax, h1, h2] = plotyy(xSer, cell2mat(ySer(:, 2)), xSer, cell2mat(y2(:, 2)));
set(hax(2),'XGrid','on', 'YGrid', 'on');
set(hax(1),'xticklabel', convertDateNumCellArrToStr(dates, '%d-%b'));
set(hax(2),'xticklabel', convertDateNumCellArrToStr(dates, '%d-%b'));


legend([ySer{1}; y2(:,1)],'Location','northwest');
ylabel (hax(1), "Confirmed");
ylabel (hax(2), "Recoveries & Deaths");

