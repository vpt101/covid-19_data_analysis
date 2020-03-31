## Copyright (C) 2020 V
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} oneCountry (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: V <v@ARCTURUS>
## Created: 2020-03-31

function [retval] = processOneCountry(country)
  if ~nargin
    country = 'US'
  endif
  Config = Configuration();
  location = Config.('location');
  baseUrl = Config.('baseUrl');
  protectorates = Config.('protectorates');

  filename = Config.('confirmedFilename');
  url = [baseUrl, '/', filename];
  filePath = [location, '/', filename];
  [dates, countryData, countryProvinceStruct] = processFile(protectorates, filePath, url);
  cases = countryData.(country);

  filename = Config.('deathsFilename');
  filePath = [location, '/', filename];
  url = [baseUrl, '/', filename];
  [dates, countryData, countryProvinceStruct] = processFile(protectorates, filePath, url);
  deaths = countryData.(country);

  filename = Config.('recoveredFilename');
  filePath = [location, '/', filename];
  url = [baseUrl, '/', filename];
  [dates, countryData, countryProvinceStruct] = processFile(protectorates, filePath, url);
  recoveries = countryData.(country);

  xSer = cell2mat(dates);
  ySer{1, 1} = 'Cases';
  ySer{1, 2} = cases;
  y2{1, 1} = 'Recovered';
  y2{1, 2} = recoveries;
  y2{2, 1} = 'Deaths';
  y2{2, 2} = deaths;
  
  range(xSer);

  convertDateNumCellArrToStr = Config.('dateAxisFormatter');
  % Regular chart
  [hax, h1, h2] = plotSingleCountry(convertDateNumCellArrToStr, dates, xSer, ySer, y2);
  title([country, '(Linear)' ])
  figure,
  
  % Logarithmic chart
  plotSingleCountry(convertDateNumCellArrToStr, dates, xSer, ySer, y2, true);
  title([country, '(Logarithmic)' ])

  endfunction