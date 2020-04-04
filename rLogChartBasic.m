pkg load io;


[dates, countryDataConfirmed, countryDataRecovered, countryDataDeaths, countryProvinceStruct, filteredCountries] = loadData();

plotBasicChart (filteredCountries, dates, countryData, "-o", true);
ylabel('Confirmed Cases (Logarthmic)')
figure,

plotBasicChart(filteredCountries, dates, countryData, "-*", true);
ylabel('Deaths (Logarthmic)')
figure,


plotBasicChart(filteredCountries, dates, countryData, "-d", true);
ylabel('Recovered (Logarthmic)')
