pkg load io;

[dates, countryDataConfirmed, countryDataRecovered, countryDataDeaths, countryProvinceStruct, filteredCountries] = loadData();

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
