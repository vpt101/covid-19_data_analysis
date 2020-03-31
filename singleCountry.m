pkg load io;
clf

Config = Configuration();
location = Config.('location');

filename = Config.('confirmedFilename');
filePath = [location, '/', filename];
[dates, countryDataConfirmed, countryProvinceStruct] = processFile(Config,filePath);

filename = Config.('deathsFilename');
filePath = [location, '/', filename];
[dates, countryDataDeaths, countryProvinceStruct] = processFile(Config,filePath);

filename = Config.('recoveredFilename');
filePath = [location, '/', filename];
[dates, countryDataRecovered, countryProvinceStruct] = processFile(Config,filePath);

