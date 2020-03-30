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
## @deftypefn {} {@var{retval} =} processFile (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: V <v@ARCTURUS>
## Created: 2020-03-30

function [dates, countryDataStruct, countryProvinceStruct] = processFile (Config, filePath)
  f = importdata(filePath, ',');
  cellCsv = csv2cell (filePath);
  numDataCols = (size(cellCsv, 2) - 4);

  dateRow = f.textdata(1, 1); %c(1, 5:end); %<- Try that.
  delimiterIdxs = strfind(dateRow, ',');
  delimIdx = delimiterIdxs{1};
  dateRowCell = dateRow{1};
  dateArray = cell();
  for nIdx = 5:size(delimIdx, 2)
    % [dt, nchars] = strptime(dateRowCell(delimIdx(nIdx-1) + 1 : delimIdx(nIdx) - 1), '%m/%d/%y');
    dateArray(nIdx - 4) = datenum(dateRowCell(delimIdx(nIdx-1) + 1 : delimIdx(nIdx) - 1));
  endfor
  % [dt, nchars] = strptime(dateRowCell(delimIdx(nIdx) + 1 : end), '%m/%d/%y');
  dateArray(nIdx - 3) = datenum(dateRowCell(delimIdx(nIdx) + 1 : end));

  dates = dateArray;

  provinceCol = cellCsv(2:end, 1);
  countryCol = cellCsv(2:end, 2);
  provinceList = provinceCol;
  
  countryList = unique(countryCol);
  countryProvinceStruct = struct();
  countryDataStruct = struct();


  for m = 1 : size(countryCol, 1)
    countryName = strtrim(countryCol{m});
    provinceName = strtrim(provinceCol{m});
    if(!isfield(countryProvinceStruct, countryName))
      countryProvinceStruct.(countryName) = [];
      countryDataStruct.(countryName) = zeros(1, numDataCols);
    endif

    if (!isempty(provinceName))
      % Treat protectorates as different countries for now
      % Config.('protectorates') has a list of protectorates
      if(!any(strcmp(cellstr(Config.('protectorates')), provinceName)))
        listOfProvinces = countryProvinceStruct.(countryName);
        countryProvinceStruct.(countryName) = [listOfProvinces; provinceName];
        existingData = countryDataStruct.(countryName);
        rowData = cell2mat(cellCsv(m + 1, 5:(numDataCols + 4)));
        countryDataStruct.(countryName) = existingData + rowData;
      else
        provinceCountryName = [provinceName, '(', countryName, ')'];
        countryList = [countryList; provinceCountryName];
        countryDataStruct.(provinceCountryName) = zeros(1, numDataCols);
        existingData = countryDataStruct.(provinceCountryName);
        rowData = cell2mat(cellCsv(m + 1, 5:(numDataCols + 4)));
        countryDataStruct.(provinceCountryName) = existingData + rowData;
      endif
    else
      existingData = countryDataStruct.(countryName);
      rowData = cell2mat(cellCsv(m + 1, 5:(numDataCols + 4)));
      countryDataStruct.(countryName) = existingData + rowData;
    endif
  endfor
countryData = struct2cell(countryDataStruct);
endfunction
