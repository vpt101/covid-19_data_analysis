# encoding: utf-8

import sys

sys.path.append(r'./Ind')


from IndStatePlotter import IndStatePlotter
from IndTypes import IndType
from ModellingMode import ModellingMode

import Meta as cc
from Ind import IndParser
from Ind import IndStateAnalyzer as Isa

# from IndStateAnalyzer import IndStateAnalyzer


DEFAULT_MODE = ModellingMode.FIRST_SECOND
drawChart = lambda pdf, stateCode: IndStatePlotter.basicChart(pdf, stateCode)

lorentz = lambda isa, df, stateCode: fitter(stateCode, isa.lorentzianModel)
poly    = lambda isa, df, stateCode: fitter(stateCode, isa.polyModel)
exp     = lambda isa, df, stateCode: fitter(stateCode, isa.expModel)
gauss   = lambda isa, df, stateCode: fitter(stateCode, isa.gaussianModel)

def model(stateCode, fittingFunc=poly, mode=DEFAULT_MODE):
        [idf, sdf, isa] = ind(stateCode, mode=mode)
        
        IndStatePlotter.chartSingleSeries(sdf, stateCode)
        """ 
        IndStatePlotter.chartMultipleSeries(idf[idf['Status'].str.contains(IndType.CONFIRMED.value)],
                [*cc.IndStateAbbrMap.keys()])
        """
        fittingFunc(isa, sdf, stateCode)
        # IndStatePlotter.drawAllCharts()


def ind(stateCode, routine=None, mode=DEFAULT_MODE):
        indParser = IndParser.IndParser()
        df = indParser.fetchStateWiseData()
        """ 
        print(df.columns)
        print(df.head(2))
        print(Meta.StateAbbrMap['UP'])
        """

        isa = Isa.IndStateAnalyzer(df, mode)
        print ('Running for ' + stateCode)
        if routine is None:
                pdf = isa.singleStateMetric(stateCode,
                        IndType.CONFIRMED.value,
                        lambda series : Isa.movavg(5, series))
        else:
                pdf = isa.singleStateMetric(stateCode,
                        IndType.CONFIRMED.value,
                        lambda series : routine(series))
        return [df, pdf, isa]


def csp(countryName, provinceName):
        global pcs, snl # Just to make it easy when running via iPython
        from cov19sir import PlottingCs
        pcs = PlottingCs.PlottingCs()
        
        snl = pcs.loadOneCountry(countryName, provinceName)
        pcs.trendPeltEbf(snl, 7)
        pcs.defaultEstimate(snl, 10, '8th')
        return snl
        
def indChart(smoothingFunc, stateCode):
        [idf, sdf, isa] = ind(stateCode)
        drawChart(smoothingFunc(sdf), stateCode)
        return [idf, sdf, isa]

def fitter(stateCode, fitterFunction):
        [params, model, result] = fitterFunction(stateCode)
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
