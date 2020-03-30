pkg load io;
clf

Config = Configuration();
location = Config.('location');
filename = Config.('confirmedFilename');
filePath = [location, '/', filename];

[dates, countryData, countryProvinceStruct] = processFile (Config,filePath);

filteredCountries = Config.('defaultCountryList');
plotProcessedData (filteredCountries, dates, countryData);
figure,

filename = Config.('deathsFilename');
filePath = [location, '/', filename];

[dates, countryData, countryProvinceStruct] = processFile (Config,filePath);
plotProcessedData (filteredCountries, dates, countryData);

