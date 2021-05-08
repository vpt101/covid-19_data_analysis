# encoding: utf-8
"""
PlottingCs.py
"""
import sys
from pprint import pprint

sys.path.append(r'D:/vcvpt/covid19-sir')
import covsirphy as cs
import matplotlib

matplotlib.use('Qt5Agg')

import matplotlib.pyplot as plt


class PlottingCs:
    def __init__(self):
        
        print('Initing PlottingCs')
        # Create DataLoader instance
        self.data_loader = cs.DataLoader("input")
        print('Initing dataloader (jhu)')
        # The number of cases (JHU style)
        self.jhu_data = self.data_loader.jhu()
        print('Initing dataloader (population)')
        # Population in each country
        self.population_data = self.data_loader.population()
        pprint(set(self.jhu_data.countries()) & set(self.population_data.countries()), compact=True)
       
        # Government Response Tracker (OxCGRT)
        self.oxcgrt_data = self.data_loader.oxcgrt()
        # The number of tests
        self.pcr_data = self.data_loader.pcr()
        # The number of vaccinations
        self.vaccine_data = self.data_loader.vaccine()


    def createScenario(self, countryName, provinceName, jhu_data, population_data, oxcgrt_data, pcr_data, vaccine_data):
        print('Creating Scenario for ' + countryName)
        snl = cs.Scenario(country=countryName, province=provinceName)
        snl.interactive = True
        print('Registering data in scenario for ' + countryName)
        # snl.register(jhu_data, population_data, extras=[oxcgrt_data, pcr_data, vaccine_data])
        snl.register(jhu_data, population_data, extras=[oxcgrt_data, vaccine_data])
        # snl.register(jhu_data, population_data)
        return snl

    def defaultEstimate(self, snl, tout=30):
        print('Estimating...')
        snl.estimate(cs.SIRF, timeout=tout)
        print('Finished estimating')
        print('Summary')
        snl.summary()
        print('Better Summary:')
        bs = snl.summary(columns=["Start", "End", "RMSLE", "Trials", "Runtime"])
        print(bs)

        phaseName = "7th"
        snl.estimate_accuracy(phase=phaseName)
        print('Accuracy, ' + phaseName + ' phase:')
        metrics_list = ["MAE", "MSE", "MSLE", "RMSE", "RMSLE"]
        for metrics in metrics_list:
            metrics_name = metrics.rjust(len(max(metrics_list, key=len)))
            print(f"{metrics_name}: {snl.score(metrics=metrics):.3f}")


    def loadOneCountry(self, countryName, provinceName=None):
        jhu_data = self.jhu_data
        population_data = self.population_data
        data_loader = self.data_loader
        oxcgrt_data = self.oxcgrt_data
        pcr_data = self.pcr_data
        vaccine_data = self.vaccine_data

        snl = self.createScenario(countryName, provinceName, jhu_data,\
             population_data, oxcgrt_data, pcr_data, vaccine_data)
        return snl

    def runForOneCountry(self, countryName):
        snl = self.loadOneCountry(countryName)
        print('Getting records')
        df = snl.records()
        pprint(df.tail())
        self.trendDefault(snl)
        self.trendPeltEbf(snl, 30)
        self.defaultEstimate(snl)

        """ 
        print('plotting')
        df.plot(x='Date', y='Infected', figsize=(16,9), grid=True)
        q.plot()
        
        plt.show()
        """

    def trendDefault(self, snl):
        _ = snl.trend()
        print('trend default')
        pprint(_.summary())

    def trendPeltEbf(self, snl, minSize):
        print('trend algo=Pelt-ebf, min_size=' + str(minSize))
        _ = snl.trend(algo="Pelt-rbf", min_size=minSize)
        pprint(_.summary())
        print('Finished trend algo=Pelt-ebf, min_size=' + str(minSize))
