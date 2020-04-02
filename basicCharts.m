pkg load io; % pkg install -forge io
clear all
clf;
Config = Configuration();
location = Config.('location');
baseUrl = Config.('baseUrl');
filteredCountries = Config.('defaultCountryList');
protectorates = Config.('protectorates');

filename = Config.('confirmedFilename');
filePath = [location, '/', filename];
url = [baseUrl, '/', filename];
[dates, countryDataConfirmed, countryProvinceStruct] = processFile (protectorates, filePath, url);

filename = Config.('recoveredFilename');
filePath = [location, '/', filename];
url = [baseUrl, '/', filename];
[dates, countryDataRecovered, countryProvinceStruct] = processFile (protectorates, filePath, url);

filename = Config.('deathsFilename');
filePath = [location, '/', filename];
url = [baseUrl, '/', filename];
[dates, countryDataDeaths, countryProvinceStruct] = processFile (protectorates, filePath, url);

plotBasicChart (filteredCountries, dates, countryDataConfirmed, "-o");
ylabel('Confirmed Cases (Linear)')
figure,

plotBasicChart (filteredCountries, dates, countryDataDeaths, "-*");
ylabel('Deaths (Linear)')
figure,

plotBasicChart (filteredCountries, dates, countryDataRecovered, "-d");
ylabel('Recovered (Linear)')
