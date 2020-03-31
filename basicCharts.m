pkg load io;
clf

Config = Configuration();
location = Config.('location');
filteredCountries = Config.('defaultCountryList');

filename = Config.('confirmedFilename');
filePath = [location, '/', filename];
[dates, countryData, countryProvinceStruct] = processFile (Config,filePath);
plotBasicChart (filteredCountries, dates, countryData);
figure,

filename = Config.('deathsFilename');
filePath = [location, '/', filename];
[dates, countryData, countryProvinceStruct] = processFile (Config,filePath);
plotBasicChart (filteredCountries, dates, countryData);
figure,

filename = Config.('recoveredFilename');
filePath = [location, '/', filename];
[dates, countryData, countryProvinceStruct] = processFile (Config,filePath);
plotBasicChart (filteredCountries, dates, countryData);
