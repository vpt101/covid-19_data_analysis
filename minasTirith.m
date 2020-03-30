pkg load io;

Config = Configuration();
location = Config.('location');
filename = Config.('globalFilename');
filePath = [location, '/', filename];

[dates, countryData, countryProvinceStruct] = processFile (Config,filePath);

filteredCountries = Config.('defaultCountryList');
for i = 1:size(filteredCountries)
  country = strtrim(filteredCountries(i, :));
  if(isfield(countryData, country))
    plotData{i, 1} = country;
    plotData{i, 2} = countryData.(country);
  else
    printf("WARN: COULDN'T FIND: %s\n", country);
  endif
endfor

plot(cell2mat(dates), cell2mat(plotData(:, 2)));
% figure,
% ax = gca;
legend(plotData(:,1),'Location','northwest')

