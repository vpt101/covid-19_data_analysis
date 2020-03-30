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
  Config.('location') = '/home/v/vcvpt/COVID-19/csse_covid_19_data/csse_covid_19_time_series';
  Config.('globalFilename') = 'time_series_covid19_confirmed_global.csv';
  Config.('defaultCountryList') = ['US'; 'China'; 'India'; 'Italy'; 'Spain'];
  
  
endfunction