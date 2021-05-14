# encoding: utf-8
"""
IndStateAnalyzer.py
"""
import sys

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
