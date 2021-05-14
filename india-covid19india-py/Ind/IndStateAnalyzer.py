# encoding: utf-8
"""
IndStateAnalyzer.py
"""
import sys

from lmfit import report_fit
import Meta
import numba


cumsum = lambda series : series.cumsum().iloc[:]
movavg_cumulative = lambda n, series : cumsum(series).iloc[:].rolling(window=n).mean()
movavg = lambda n, series : series.iloc[:].rolling(window=n).mean()
gaussMovAvg_cumulative = lambda n, std, series : cumsum(series).iloc[:].rolling(window=n, win_type='gaussian').mean(std=std)
gaussMovAvg = lambda n, std, series : series.iloc[:].rolling(window=n, win_type='gaussian').mean(std=std)
pctChg = lambda series : series.pct_change()


class IndStateAnalyzer:
    def __init__(self, df):
        self.df = df
    
    def singleStateMetric(self, stateCode, indTypeName, routine):
        pdf = self.df.filter(items=['Date', 'Status', stateCode])
        for name  in pdf.columns:
            if (name in Meta.IndStateAbbrMap.keys()):
                pdf[name] = routine(pdf[name])
        return pdf[pdf['Status'].str.contains(indTypeName)]

    @staticmethod
    def guessAndFit(df, model, stateCode, fill):
        mdf = df.head(300).reset_index(drop=True) #.dropna()
        # mdf = df.reset_index(drop=True) #.dropna()
        mdf = fill(mdf)

        params = model.guess(mdf[stateCode], x=mdf['Date'].index)
        fdf = df.tail(150).reset_index(drop=True)
        # fdf = df.reset_index(drop=True)
        fdf = fill(fdf)
        result = model.fit(fdf[stateCode], params, x=fdf['Date'].index)
        return [params, model, result]

    @staticmethod
    def lorentzianModel(df, stateCode):
        from lmfit.models import LorentzianModel
        model = LorentzianModel()
        return IndStateAnalyzer.guessAndFit(df, model, stateCode, lambda x: x.fillna(0))
    
    @staticmethod
    def expModel(df, stateCode):
        from lmfit.models import ExponentialModel
        model = ExponentialModel()
        return IndStateAnalyzer.guessAndFit(df, model, stateCode, lambda x: x.dropna())

    @staticmethod
    def polyModel(df, stateCode):
        from lmfit.models import PolynomialModel
        model = PolynomialModel(2)
        return IndStateAnalyzer.guessAndFit(df, model, stateCode, lambda x: x.dropna())

    @staticmethod
    def gaussianModel(df, stateCode):
        from lmfit.models import GaussianModel
        model = GaussianModel()
        return IndStateAnalyzer.guessAndFit(df, model, stateCode, lambda x: x.fillna(0))

