# encoding: utf-8

import sys
sys.path.append(r'./Ind')


from Ind import IndStateAnalyzer as Isa
from Ind import IndParser
# from IndStateAnalyzer import IndStateAnalyzer

from IndStatePlotter import IndStatePlotter
from IndTypes import IndType
import Meta as cc


drawChart = lambda pdf, stateCode: IndStatePlotter.basicChart(pdf, stateCode)

lorentz = lambda df, stateCode : fitter(df, stateCode, Isa.IndStateAnalyzer.lorentzianModel)
exp = lambda df, stateCode: fitter(df, stateCode, Isa.IndStateAnalyzer.expModel)
poly = lambda df, stateCode: fitter(df, stateCode, Isa.IndStateAnalyzer.polyModel)
gauss = lambda df, stateCode: fitter(df, stateCode, Isa.IndStateAnalyzer.gaussianModel)

def model(stateCode, routine=poly):
        # [idf, sdf] = indChart(lambda x: x.fillna(0), stateCode)
        [idf, sdf] = ind(stateCode)
        IndStatePlotter.chartSingleSeries(sdf, stateCode)
        IndStatePlotter.chartMultipleSeries(sdf, list(cc.IndStateAbbrMap.keys()))
        routine(sdf, stateCode)


def ind(stateCode, routine=None):
        indParser = IndParser.IndParser()
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
                        lambda series : Isa.movavg(6, series))
        else:
                pdf = isa.singleStateMetric(stateCode,
                        IndType.CONFIRMED.value,
                        lambda series : routine(series))
        return [df, pdf]


def csp(countryName, provinceName):
        global pcs, snl # Just to make it easy when running via iPython
        from cov19sir import PlottingCs
        pcs = PlottingCs.PlottingCs()
        
        snl = pcs.loadOneCountry(countryName, provinceName)
        pcs.trendPeltEbf(snl, 7)
        pcs.defaultEstimate(snl, 10, '8th')
        return snl
        
def indChart(smoothingFunc, stateCode):
        [idf, sdf] = ind(stateCode)
        drawChart(smoothingFunc(sdf), stateCode)
        return [idf, sdf]

def fitter(df, stateCode, fitterFunction):
        [params, model, result] = fitterFunction(df, stateCode)
        IndStatePlotter.chartLmfitModel(result)
        IndStatePlotter.predict(model, params)


if __name__ == '__main__':
        province = None
        # country = 'USA'
        country = 'IN'
        # country = 'UK'
#        province = 'KL'

        # csp(cc.longName(country), cc.inStateName(province))


        model('UP')
       
        print ('Done')


## To run it in an interactive Python Shell
## exec(open('main.py').read()) 
##      OR 
## In IPython
## import main as m
## [idf, sdf] = m.indChart(lambda x: x.tail(60), 'KL')
## OR for the lorentzianModel() :: [idf, sdf] = m.indChart(lambda x: x.tail(60), 'KL')

"""
https://stackoverflow.com/questions/3433486/how-to-do-exponential-and-logarithmic-curve-fitting-in-python-i-found-only-poly
https://lmfit.github.io/lmfit-py/builtin_models.html
"""
