pkg load dataframe

location = '/home/v/vcvpt/COVID-19/csse_covid_19_data/csse_covid_19_time_series';
filename = 'time_series_covid19_confirmed_global.csv';
filePath = [location, '/', filename];
gdf = dataframe(filePath);
f = importdata(filePath);



dateRow = f(1, 1);
delimiterIdxs = strfind(dateRow, ',');
dateArray = [];
delimIdx = delimiterIdxs{1};
dateRowCell = dateRow{1};
for nIdx = 5:size(delimIdx, 2)
  dateArray = [dateArray; dateRowCell(delimIdx(nIdx-1) + 1 : delimIdx(nIdx) - 1)];
endfor
dateArray = [dateArray; dateRowCell(delimIdx(nIdx) + 1 : end)];

