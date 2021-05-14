# encoding: utf-8
import pandas as pd
import numpy as np
import matplotlib
matplotlib.use('Qt5Agg')
import matplotlib.pyplot as plt
import Meta as mt

"""
IndStatePlotter
"""

class IndStatePlotter:

    @staticmethod
    def chartSingleSeries(df, countryCode):
        ylabel = str(mt.inStateName(countryCode))
        dates = df['Date'].values
        sd = np.datetime_as_string(dates[0], unit='D')
        ed = np.datetime_as_string(dates[dates.size - 1], unit='D')
        print("#:" + str(df[countryCode].size) + " From:" + sd + " to: " + ed)
        print("std dev:" + str(df[countryCode].std()))
        df.plot(x='Date', y=[countryCode],
            figsize=(16,9), grid=True, xlabel="Date", ylabel=ylabel)
        plt.show()


    @staticmethod
    def chartMultipleSeries(df, countryCodes):
        dates = df['Date'].values
        sd = np.datetime_as_string(dates[0], unit='D')
        ed = np.datetime_as_string(dates[dates.size - 1], unit='D')
        print(" From:" + sd + " to: " + ed)
        # print("std dev:" + str(df[countryCode].std()))
        df.plot(x='Date', countryCodes,
            figsize=(16,9), grid=True)
        plt.show()

    @staticmethod
    def chartLmfitModel(result):
        from lmfit import report_fit
        report_fit(result.params)
        result.params.pretty_print()
        
        import matplotlib.pyplot as plt
        result.plot_fit()
        result.plot_residuals()
        result.plot()
        plt.show()

    @staticmethod
    def predict(model, params):
        import matplotlib.pyplot as plt
        x = pd.Series(list(range(1, 500)))
        y_eval = model.eval(params, x=x)
        if type(y_eval) == np.ndarray:
            plt.plot(x, y_eval)
        else:
            y_eval.plot()
        plt.show()
        