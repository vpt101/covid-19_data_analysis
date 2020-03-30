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
## @deftypefn {} {@var{retval} =} plotProcessedData (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: V <v@ARCTURUS>
## Created: 2020-03-30

function [retval] = plotProcessedData (filteredCountries, dates, countryData)
  for i = 1:size(filteredCountries)
    country = strtrim(filteredCountries(i, :));
    if(isfield(countryData, country))
      plotData{i, 1} = country;
      plotData{i, 2} = countryData.(country);
    else
      printf("WARN: COULDN'T FIND: %s\n", country);
    endif
  endfor

  plot(cell2mat(dates), cell2mat(plotData(:, 2)), '-o');
  ax = gca
  legend(plotData(:,1),'Location','northwest')
  datetick("x", "dd-mmm");
  retval = 1;
endfunction
