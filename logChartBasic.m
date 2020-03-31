pkg load io;
clf;

Config = Configuration();
location = Config.('location');
baseUrl = Config.('baseUrl');
filteredCountries = Config.('defaultCountryList');
protectorates = Config.('protectorates');

filename = Config.('confirmedFilename');
filePath = [location, '/', filename];
url = [baseUrl, '/', filename];
[dates, countryData, countryProvinceStruct] = processFile (protectorates, filePath, url);
plotBasicChart (filteredCountries, dates, countryData, "-o", true);
ylabel('Confirmed Cases')
figure,

filename = Config.('deathsFilename');
filePath = [location, '/', filename];
url = [baseUrl, '/', filename];
[dates, countryData, countryProvinceStruct] = processFile (protectorates, filePath, url);
plotBasicChart(filteredCountries, dates, countryData, "-*", true);
ylabel('Deaths')
figure,

filename = Config.('recoveredFilename');
filePath = [location, '/', filename];
url = [baseUrl, '/', filename];
[dates, countryData, countryProvinceStruct] = processFile (protectorates, filePath, url);
plotBasicChart(filteredCountries, dates, countryData, "-d", true);
ylabel('Recovered')
