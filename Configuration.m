function [Config] = Configuration()
  Config = struct();
  protectorates = ['French Guiana';'French Polynesia';'Guadeloupe';'Mayotte'];
  protectorates = [protectorates;'New Caledonia';'Reunion';'Saint Barthelemy'];
  protectorates = [protectorates;'St Martin';'Martinique';'Aruba';'Curacao'];
  protectorates = [protectorates;'Sint Maarten';'Bermuda';'Cayman Islands'];
  protectorates = [protectorates;'Channel Islands';'Gibraltar';'Isle of Man'];
  protectorates = [protectorates;'Montserrat';'Diamond Princess'];
  protectorates = [protectorates;'Northwest Territories';'Yukon';'Anguilla'];
  protectorates = [protectorates;'British Virgin Islands';'Turks and Caicos Islands'];
  Config.('protectorates') = protectorates;
  Config.('baseUrl') = 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series';
  Config.('location') = '/tmp';
  Config.('confirmedFilename') = 'time_series_covid19_confirmed_global.csv';
  Config.('deathsFilename') = 'time_series_covid19_deaths_global.csv';
  Config.('recoveredFilename') = 'time_series_covid19_recovered_global.csv';
  Config.('defaultCountryList') = ['China'; 'Italy'; 'Spain'; 'United Kingdom'; 'US'];
  % Anon func that calls cellfun with another anon func 
  Config.('dateAxisFormatter') = @(dtCellArray, fmt) cellfun(@(x) datestr(x, fmt), dtCellArray, 'UniformOutput', false);

endfunction