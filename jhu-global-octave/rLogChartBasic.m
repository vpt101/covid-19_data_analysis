pkg load io;


[dates, countryDataConfirmed, countryDataRecovered, countryDataDeaths, countryProvinceStruct, filteredCountries] = loadData();

plotBasicChart (filteredCountries, dates, countryDataConfirmed, "-o", true);
ylabel('Confirmed Cases (Logarthmic)')
figure,

plotBasicChart(filteredCountries, dates, countryDataDeaths, "-*", true);
ylabel('Deaths (Logarthmic)')
figure,


plotBasicChart(filteredCountries, dates, countryDataRecovered, "-d", true);
ylabel('Recovered (Logarthmic)')
