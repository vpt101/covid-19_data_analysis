pkg load io; % pkg install -forge io

clf;

[dates, countryDataConfirmed, countryDataRecovered, countryDataDeaths, countryProvinceStruct, filteredCountries] = loadData();

plotBasicChart (filteredCountries, dates, countryDataConfirmed, "-o");
ylabel('Confirmed Cases (Linear)')
figure,

plotBasicChart (filteredCountries, dates, countryDataDeaths, "-*");
ylabel('Deaths (Linear)')
figure,

plotBasicChart (filteredCountries, dates, countryDataRecovered, "-d");
ylabel('Recovered (Linear)')
