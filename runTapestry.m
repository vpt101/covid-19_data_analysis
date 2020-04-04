pkg load io; % pkg install -forge io

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
[dates, countryDataRecovered, ~] = processFile (protectorates, filePath, url);

filename = Config.('deathsFilename');
filePath = [location, '/', filename];
url = [baseUrl, '/', filename];
[dates, countryDataDeaths, ~] = processFile (protectorates, filePath, url);


subplot (3, 2, 1)
plotBasicChart (filteredCountries, dates, countryDataConfirmed, "-o");
ylabel('Confirmed Cases (Linear)')
subplot (3, 2, 2)
plotBasicChart (filteredCountries, dates, countryDataConfirmed, "-o", true);
ylabel('Confirmed Cases (Logarithmic)')

subplot (3, 2, 3)
plotBasicChart (filteredCountries, dates, countryDataDeaths, "-*");
ylabel('Deaths (Linear)')
subplot (3, 2, 4)
plotBasicChart (filteredCountries, dates, countryDataDeaths, "-*", true);
ylabel('Deaths (Logarithmic)')


subplot (3, 2, 5)
plotBasicChart (filteredCountries, dates, countryDataRecovered, "-d");
ylabel('Recovered (Linear)')
subplot (3, 2, 6)
plotBasicChart (filteredCountries, dates, countryDataRecovered, "-d", true);
ylabel('Recovered (Logarithmic)')
