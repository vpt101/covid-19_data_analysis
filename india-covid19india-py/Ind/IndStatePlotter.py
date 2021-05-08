# encoding: utf-8
import pandas as pd
import numpy as np
import matplotlib
matplotlib.use('Qt5Agg')
import matplotlib.pyplot as plt
"""
IndStatePlotter
"""

class IndStatePlotter:

    @staticmethod
    def basicChart(df, countryCode):
        df.plot(x='Date', y=[countryCode], figsize=(16,9))
        plt.show()

    
