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

function [retval] = plotBasicChart (filteredCountries, dates, countryData, marker, logChart = false)
  for i = 1:size(filteredCountries)
    country = strtrim(filteredCountries(i, :));
    if(isfield(countryData, country))
      plotData{i, 1} = country;
      plotData{i, 2} = countryData.(country);
    else
      printf("WARN: COULDN'T FIND: %s\n", country);
    endif
  endfor

  if (logChart)
    h = semilogy(cell2mat(dates), cell2mat(plotData(:, 2)), marker);
  else
    h = plot(cell2mat(dates), cell2mat(plotData(:, 2)), marker);
  endif

  legend(plotData(:,1),'Location','northwest');
  colormap(rainbow);
  ax = gca;
  grid on
  set(ax, 'yminorgrid', 'on');
  set(ax, 'yminortick', 'on');
  datetick("x", "dd-mmm", 'keepticks');
  
  q = datacursor();
  x = get (q, "x")(2)
  y = get (q, "y")(2)
  
  
  retval = h;

endfunction
