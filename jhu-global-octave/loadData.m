## Copyright (C) 2020 v
## 
## This program is free software: you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see
## <https://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} loadData (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: v <v@PROCYONB>
## Created: 2020-04-03

function [dates, countryDataConfirmed, countryDataRecovered, ...
   countryDataDeaths, countryProvinceStruct, filteredCountries] = loadData ()

  global dates;
  global countryDataConfirmed;
  global countryDataDeaths;
  global countryDataRecovered;
  global countryProvinceStruct;
  global filteredCountries;
 
  Config = Configuration();
  location = Config.('location');
  baseUrl = Config.('baseUrl');
  filteredCountries = Config.('defaultCountryList');
  protectorates = Config.('protectorates');

  filename = Config.('confirmedFilename');
  filePath = [location, '/', filename];
  url = [baseUrl, '/', filename];
  
  [dates, countryDataConfirmed, countryProvinceStruct] = processFile (protectorates, filePath, url);


  filename = Config.('deathsFilename');
  filePath = [location, '/', filename];
  url = [baseUrl, '/', filename];
  [dates, countryDataDeaths, countryProvinceStruct] = processFile (protectorates, filePath, url);

  
  filename = Config.('recoveredFilename');
  filePath = [location, '/', filename];
  url = [baseUrl, '/', filename];
  [dates, countryDataRecovered, countryProvinceStruct] = processFile (protectorates, filePath, url);
  
endfunction
