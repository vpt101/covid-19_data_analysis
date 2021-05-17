# encoding: utf-8
"""
IndStateAnalyzer.py
"""
import sys

from lmfit import report_fit
import Meta as mt
import numba
from IndTypes import IndType
from ModellingMode import ModellingMode as mm

cumsum = lambda series : series.cumsum().iloc[:]
movavg_cumulative = lambda n, series : cumsum(series).iloc[:].rolling(window=n).mean()
movavg = lambda n, series : series.iloc[:].rolling(window=n).mean()
gaussMovAvg_cumulative = lambda n, std, series : cumsum(series) \
                                                    .iloc[:].rolling(window=n, win_type='gaussian').mean(std=std)
gaussMovAvg = lambda n, std, series : series.iloc[:].rolling(window=n, win_type='gaussian').mean(std=std)
pctChg = lambda series : series.pct_change()


class IndStateAnalyzer:
    def __init__(self, df, mode):
        self.df = df
        self.mode = mode
    
    def singleStateMetric(self, stateCode, indTypeName, routine):
        pdf = self.df.filter(items=['Date', 'Status', stateCode])
        for name  in pdf.columns:
            if (name in mt.IndStateAbbrMap.keys()):
                pdf[name] = routine(pdf[name])
        return pdf[pdf['Status'].str.contains(indTypeName)]

    def guessAndFit(self, model, stateCode, fill,
                    status = IndType.CONFIRMED.value):
        df = self.singleStateMetric(stateCode, status, lambda x:x)
        mdf = self.paramsDatatable(df)
        
        mdf = fill(mdf)
        params = model.guess(mdf[stateCode], x=mdf['Date'].index)

        """ 
        import numpy as np
        import matplotlib.pyplot as plt
        y_eval = model.eval(params, x=mdf['Date'].index)
        plt.plot(mdf['Date'].index, y_eval)
        plt.show() """

        fdf = self.fittingDatatable(df)
        
        fdf = fill(fdf)
        result = model.fit(fdf[stateCode], params, x=fdf['Date'].index)
        return [params, model, result]

    def paramsDatatable(self, df):
        if(self.mode == mm.FIRST_SECOND or self.mode == mm.FIRST_ALL):
            mdf = df.head(365).tail(325).reset_index(drop=True) 
        elif (self.mode == mm.ALL or self.mode == mm.ALL_SECOND):
            mdf = df.reset_index(drop=True)
        return mdf

    def fittingDatatable(self, df):
        if(self.mode == mm.ALL_SECOND or self.mode == mm.FIRST_SECOND):
            fdf = df.tail(150).reset_index(drop=True)
        elif (self.mode == mm.ALL or self.mode == mm.FIRST_ALL):
            fdf = df.reset_index(drop=True)
        return fdf

    def lorentzianModel(self, stateCode):
        from lmfit.models import LorentzianModel
        model = LorentzianModel()
        return self.guessAndFit(model, stateCode, lambda x: x.fillna(0))
    
    def expModel(self, stateCode):
        from lmfit.models import ExponentialModel
        model = ExponentialModel()
        return self.guessAndFit(model, stateCode, lambda x: x.dropna())

    def polyModel(self, stateCode):
        from lmfit.models import PolynomialModel
        model = PolynomialModel(4)
        return self.guessAndFit(model, stateCode, lambda x: x.dropna())

    def gaussianModel(self, stateCode):
        from lmfit.models import GaussianModel
        model = GaussianModel()
        return self.guessAndFit(model, stateCode, lambda x: x.fillna(0))

