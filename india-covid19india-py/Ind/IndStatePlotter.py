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
    def basicChart(df, countryCode):
        ylabel = str(mt.inStateName(countryCode))
        dates = df['Date'].values
        sd = np.datetime_as_string(dates[0], unit='D')
        ed = np.datetime_as_string(dates[dates.size - 1], unit='D')
        print("#:" + str(df[countryCode].size) + " From:" + sd + " to: " + ed)
        print("std dev:" + str(df[countryCode].std()))
        df.plot(x='Date', y=[countryCode], figsize=(16,9), grid=True, xlabel="Date", ylabel=ylabel)
        plt.show()
        # plt.draw()

    
