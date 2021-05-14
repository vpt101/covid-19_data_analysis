# encoding: utf-8

import sys
sys.path.append(r'./Ind')


from Ind import IndStateAnalyzer as Isa
from Ind import IndParser
# from IndStateAnalyzer import IndStateAnalyzer

from IndStatePlotter import IndStatePlotter
from IndTypes import IndType
import Meta as cc


def drawChart(pdf, stateCode):
        IndStatePlotter.basicChart(pdf, stateCode)

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
        IndStatePlotter.basicChart(pdf, stateCode)
        return [df, pdf]


def csp(countryName, provinceName):
        global pcs, snl # Just to make it easy when running via iPython
        from cov19sir import PlottingCs
        pcs = PlottingCs.PlottingCs()
        
        snl = pcs.loadOneCountry(countryName, provinceName)
        pcs.trendPeltEbf(snl, 7)
        pcs.defaultEstimate(snl, 10, '8th')
        return snl
        
def indChart(routine, stateCode):
        [idf, sdf] = ind(stateCode)
        drawChart(routine(sdf), stateCode)
        return [idf, sdf]

def lorentzianModel(df, stateCode):
        from lmfit.models import LorentzianModel
        model = LorentzianModel()
        mdf=df.reset_index(drop=True).fillna(0)
        params = model.guess(mdf[stateCode], x=mdf['Date'].index)
        result = model.fit(mdf[stateCode], params, x=mdf['Date'].index)
        result.plot_fit()
        import matplotlib.pyplot as plt
        plt.show()


if __name__ == '__main__':
        province = None
        # country = 'USA'
        country = 'IN'
        # country = 'UK'
#        province = 'KL'

        # csp(cc.longName(country), cc.inStateName(province))
        [ind, sdf] = ind('MH')
        print ('Done')


## To run it in an interactive Python Shell
## exec(open('main.py').read()) 
## OR 
## In IPython
## import main as m
## [idf, sdf] = m.indChart(lambda x: x.tail(60), 'KL')
## OR for the lorentzianModel() :: [idf, sdf] = m.indChart(lambda x: x.tail(60), 'KL')

"""
## https://cars9.uchicago.edu/software/python/lmfit/examples/example_use_pandas.html
from lmfit.models import LorentzianModel
model = LorentzianModel()
mdf=sdf.reset_index(drop=True)
params = model.guess(mdf['KL'], x=mdf['Date'].index)
result = model.fit(mdf['KL'], params, x=mdf['Date'].index)
"""


"""
https://stackoverflow.com/questions/3433486/how-to-do-exponential-and-logarithmic-curve-fitting-in-python-i-found-only-poly
https://lmfit.github.io/lmfit-py/builtin_models.html
"""