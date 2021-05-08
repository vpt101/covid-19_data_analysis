# encoding: utf-8

import sys
sys.path.append(r'./Ind')
from IndParser import IndParser
# from IndStateAnalyzer import IndStateAnalyzer
import IndStateAnalyzer as Isa

from IndStatePlotter import IndStatePlotter
from IndTypes import IndType
import Meta

from cov19sir import PlottingCs


def ind(stateCode, routine=None):
        indParser = IndParser()
        df = indParser.fetchStateWiseData()

        """ 
        print(df.columns)
        print(df.head(2))
        print(Meta.StateAbbrMap['UP'])
        """

        isa = Isa.IndStateAnalyzer(df)
        print ('Running for ' + stateCode)
        if routine is None:
                pdf = isa.singleStateMetric(stateCode,
                        IndType.CONFIRMED.value,
                        lambda series : Isa.gaussianMovAvg(12, 7, series))
        else:
                pdf = isa.singleStateMetric(stateCode,
                        IndType.CONFIRMED.value,
                        lambda series : routine(series))
        IndStatePlotter.basicChart(pdf, stateCode)


def csp(countryName, provinceName):
        global pcs, snl # Just to make it easy when running via iPython
        pcs = PlottingCs.PlottingCs()
        
        snl = pcs.loadOneCountry(countryName, provinceName)
        pcs.trendPeltEbf(snl, 30)
        pcs.defaultEstimate(snl, 10)
        _ = snl.history(target=f"Infected")

if __name__ == '__main__':
        
        # ind('KL')

        # countryName = 'United States of America'
        countryName = 'India'
        # countryName = 'United Kingdom'
        provinceName = None

        # provinceName = 'Uttar Pradesh'
        provinceName = 'Maharashtra'
        # provinceName = 'Chhattisgarh'
        # provinceName = 'Goa'
        # pcs.runForOneCountry(countryName)

        csp(countryName, provinceName)
        print ('Done')

## To run it in an interactive Python Shell
## exec(open('main.py').read()) 

