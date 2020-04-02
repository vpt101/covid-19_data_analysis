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
## @deftypefn {} {@var{retval} =} plotSingleCountry (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: V <v@ARCTURUS>
## Created: 2020-03-31

function [hax, h1, h2] = plotSingleCountry (convertDateNumCellArrToStr, dates, xSer, ySer, y2, logAxis = false)
  clf;
  hold on;

  if (logAxis)
    [hax, h1, h2] = plotyy(xSer, cell2mat(ySer(:, 2)), xSer, cell2mat(y2(:, 2)), @semilogy);
  else
    [hax, h1, h2] = plotyy(xSer, cell2mat(ySer(:, 2)), xSer, cell2mat(y2(:, 2)));
  endif
  colormap(rainbow(6));
  set(hax(2),'XGrid','on', 'YGrid', 'on');
  x1ticks = get(hax(1), 'xticklabel');
   
  for (m = 1:size(x1ticks, 2))
    xTicks{1, m} = str2num(x1ticks{1, m}); 
  endfor
  formattedTicks = convertDateNumCellArrToStr(xTicks,'%d-%b');
  set(hax(1),'xticklabel', formattedTicks);
  set(hax(2), 'xticklabel', formattedTicks);
  set(h1, 'Marker', 'o');
  set(h2, 'Marker', ['*'; 'd']);
  legend([ySer{1}; y2(:,1)],'Location','northwest');
  ylabel (hax(1), "Cases");
  ylabel (hax(2), "Recoveries & Deaths");

endfunction
