# encoding: utf-8
"""
IndParser.py
"""
import csv
import io
import os
import urllib.request
from datetime import datetime, timedelta

import pandas as pd

import Constants
import Meta

class IndParser:
    STATE_WISE_DAILY_FILENAME = 'state_wise_daily.csv'
    COLUMNS_TO_REMOVE = ['Date', 'UN', 'TT']
    COLUMN_RENAME_MAP = {'Date_YMD': 'Date'}
    
    def __init__(self):
        None

    def constructCsvUrl(self):
        return Constants.BASE_URL + '/' + Constants.CSV_URL

    def constructLatestUrl(self):
        return self.constructCsvUrl() + '/' + Constants.LATEST_SYM_LINK 
        
    def constructStateWiseCsvUrl(self):
        return self.constructLatestUrl() + '/' + self.STATE_WISE_DAILY_FILENAME

    def downloadFile(self, fileName):
        absoluteFileName = os.path.abspath(Constants.DOWNLOAD_LOCATION + fileName)
        if (os.path.isfile(absoluteFileName)):
            mtime = datetime.utcfromtimestamp(os.path.getmtime(absoluteFileName))
            if((datetime.utcnow() - timedelta(hours=Constants.MAX_AGE_IN_HOURS)) < mtime):
                print(absoluteFileName + ' not older than 4 hours. Not downloading')
                return absoluteFileName
        print('Downloading ' + absoluteFileName)
        urllib.request.urlretrieve(self.constructStateWiseCsvUrl(), absoluteFileName)
        return absoluteFileName

    def extractStatewiseData(self, absoluteFileName):
        df = pd.read_csv(absoluteFileName)
        df = df.drop(columns=self.COLUMNS_TO_REMOVE)
        df = df.rename(columns=self.COLUMN_RENAME_MAP)
        # df = df.rename(columns=Meta.StateAbbrMap)
        return df
    
    def extractAndFormatStatewiseData(self, absoluteFileName):
        df = self.extractStatewiseData(absoluteFileName)
        df['Date'] = df['Date'].astype('datetime64[ns]')
        stateAbbrs = Meta.IndStateAbbrMap
        for name  in df.columns:
            if (name in Meta.IndStateAbbrMap.keys()):
                df[name] = df[name].astype('double')
        return df
        
    def fetchStateWiseData(self): 
        absoluteFileName = self.downloadFile(self.STATE_WISE_DAILY_FILENAME)
        return self.extractAndFormatStatewiseData(absoluteFileName)
        
        
        """
        with requests.get(self.constructStateWiseCsvUrl(), stream=True) as r:
            df = pd.read_csv(io.StringIO(r.text))
            df = df.drop(columns=['Date', 'UN'])
            df = df.rename(columns={'Date_YMD': 'Date'})
            self.statewiseData = df
        print(self.statewiseData.columns)
        print(self.statewiseData.head(2))
        """


            
             
            

            
                
