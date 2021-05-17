# encoding: utf-8
"""
IndStatePlotter
"""
import pandas as pd
import numpy as np
import matplotlib
matplotlib.use('Qt5Agg')
import matplotlib.pyplot as plt
import Meta as mt

import seaborn as sns
sns.set_theme(style="whitegrid")


class IndStatePlotter:
    
    @staticmethod
    def drawAllCharts():
        plt.show()

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

    """     
    @staticmethod
    def chartMultipleSeries(df, regionCodes, commonLabel="Sum"):
        dates = df['Date'].values
        # print(dates)
        
        sd = np.datetime_as_string(dates[0], unit='D')
        ed = np.datetime_as_string(dates[dates.size - 1], unit='D')
        print(" From:" + sd + " to: " + ed)
        # print("std dev:" + str(df[regionCodes].std()))
        # data = df['Date']
        data = df[ ["Date"] + regionCodes ]
        data2 = df[ ["Date"]  ]

        data = data.set_index("Date")
        
        
        sns.lineplot(data=data, color="gray", dashes=False, linewidth=1.0)
        ax2 = plt.twinx()

        data2[commonLabel] = df[ regionCodes ].sum(axis=1)

        data2 = data2.set_index("Date")
        sns.lineplot(data=data2, color="r", ax=ax2)
        
        plt.show()
    """   

    @staticmethod
    def chartLmfitModel(result):
        from lmfit import report_fit
        report_fit(result.params)
        result.params.pretty_print()
        
        import matplotlib.pyplot as plt
        result.plot()
        plt.show()

        result.plot_fit()
        # plt.show()
        result.plot_residuals()
        # plt.show()

    @staticmethod
    def predict(model, params):
        import matplotlib.pyplot as plt
        x = pd.Series(list(range(0, 750)))
        y_eval = model.eval(params, x=x)
        if type(y_eval) == np.ndarray:
            plt.plot(x, y_eval)
        else:
            y_eval.plot()
        plt.show()
        