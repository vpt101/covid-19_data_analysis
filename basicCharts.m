pkg load io; % pkg install -forge io
clf

Config = Configuration();
location = Config.('location');
baseUrl = Config.('baseUrl');
filteredCountries = Config.('defaultCountryList');
protectorates = Config.('protectorates');

filename = Config.('confirmedFilename');
filePath = [location, '/', filename];
url = [baseUrl, '/', filename];

[dates, countryData, countryProvinceStruct] = processFile (protectorates, filePath, url);
plotBasicChart (filteredCountries, dates, countryData, "-o");
ylabel('Confirmed Cases')
figure,

filename = Config.('deathsFilename');
filePath = [location, '/', filename];
url = [baseUrl, '/', filename];

[dates, countryData, countryProvinceStruct] = processFile (protectorates, filePath, url);
plotBasicChart (filteredCountries, dates, countryData, "-*");
ylabel('Deaths')
figure,

filename = Config.('recoveredFilename');
filePath = [location, '/', filename];
url = [baseUrl, '/', filename];
[dates, countryData, countryProvinceStruct] = processFile (protectorates, filePath, url);
plotBasicChart (filteredCountries, dates, countryData, "-d");
ylabel('Recovered')


