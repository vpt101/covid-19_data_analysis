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
## @deftypefn {} {@var{retval} =} fitCurve (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: v <v@PROCYONB>
## Created: 2020-04-04

function [f1, p1, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r21] = fitCurve (dataX, dataY, p, leasqrfunc)
  Y = dataY;
  X = dataX;
  pin = p;
%%  wt1 = (1 + 0 * X) ./ sqrt(Y);
  pin
  stol=0.1; niter=150;
  
  dp = 0.001 * ones (size (pin));
%%  global verbose;
%%  verbose = 1;
  [f1, p1, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r21] = ... 
    leasqr (X, Y, pin, ... 
    % fromTheEgOfLeasqr,
    leasqrfunc,...
    stol, niter); %, wt1, dp);

endfunction
