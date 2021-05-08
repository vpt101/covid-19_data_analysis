conda create --name analisa
conda activate analisa
conda install --name analisa BeautifulSoup4 -y
conda install --name analisa requests -y
conda install --name analisa pandas -y
conda install --name analisa PrettyTable -y
conda install --name analisa matplotlib -y
conda install --name analisa seaborn -y
conda install --name analisa numpy -y
conda install --name analisa numba -y
conda install --name analisa contextlib2 -y
conda install --name analisa rope -y
conda install --name analisa r-geomapdata -y

REM For CovSirPhy lib
conda install --name analisa country_converter
conda install --name analisa geopandas
conda install --name analisa unidecode
conda install --name analisa pip
python -c "import pip; pip.main(['install', 'japanmap'])"
conda install --name analisa dask
conda install --name analisa wbdata
python -c "import pip; pip.main(['install', 'covid19dh'])"
conda install --name analisa ruptures
conda install --name analisa optuna
python -c "import pip; pip.main(['install', 'better_exceptions'])"
