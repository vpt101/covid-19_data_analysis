pkg load io;
clf

Config = Configuration();
location = Config.('location');
filteredCountries = Config.('defaultCountryList');

filename = Config.('confirmedFilename');
filePath = [location, '/', filename];
url = [baseUrl, '/', filename];
[dates, countryData, countryProvinceStruct] = processFile (Config,filePath, url);
plotLogChart (filteredCountries, dates, countryData, "-o");
ylabel('Confirmed Cases')
figure,

filename = Config.('deathsFilename');
filePath = [location, '/', filename];
url = [baseUrl, '/', filename];
[dates, countryData, countryProvinceStruct] = processFile (Config,filePath, url);
plotLogChart (filteredCountries, dates, countryData, "-*");
ylabel('Deaths')
figure,

filename = Config.('recoveredFilename');
filePath = [location, '/', filename];
url = [baseUrl, '/', filename];
[dates, countryData, countryProvinceStruct] = processFile (Config,filePath, url);
plotLogChart (filteredCountries, dates, countryData, "-d");
ylabel('Recovered')
