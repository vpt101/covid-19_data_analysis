# encoding: utf-8
"""
Meta.py
General MetaData
"""

import country_converter as coco

IndStateAbbrMap = {
'AN': 'Andaman And Nicobar Islands', 'AP': 'Andhra Pradesh', 'AR': 'Arunachal Pradesh', 'AS': 'Assam', 'BR': 'Bihar',
'CH': 'Chandigarh', 'CT': 'Chattisgarh', 'DN': 'Dadra & Nagar Haveli', 'DD': 'Diu & Daman', 'DL': 'Delhi', 'GA': 'Goa',
'GJ': 'Gujarat', 'HR': 'Haryana', 'HP': 'Himachal Pradesh', 'JK': 'Jammu And Kashmir', 'JH': 'Jharkhand',
'KA': 'Karnataka', 'KL': 'Kerala', 'LA': 'LA?', 'LD': 'Lakshadweep?', 'MP': 'Madhya Pradesh', 'MH': 'Maharashtra',
'MN': 'Manipur', 'ML': 'Meghalaya', 'MZ': 'Mizoram', 'NL': 'Nagaland', 'OR': 'Orissa', 'PY': 'Pondicherry',
'PB': 'Punjab', 'RJ': 'Rajasthan', 'SK': 'Sikkim', 'TN': 'Tamil Nadu',
'TG': 'TG?', 'TR': 'Tripura', 'UP': 'Uttar Pradesh', 'UT': 'Uttarakhand', 'WB': 'West Bengal'
}


IndStateAbbrMapRev = {v:k for k, v in IndStateAbbrMap.items()}

def inStateName(identifier):
    ident = identifier.upper()
    if (ident in IndStateAbbrMap):
        return IndStateAbbrMap[ident]
    else:
        return None

def inStateCode(identifier):
    if (identifier in IndStateAbbrMapRev):
        return IndStateAbbrMapRev[identifier]
    else:
        return None


def longName(identifier):
    return coco.convert(identifier, to='name_official')

def shortName(identifier):
    return coco.convert(identifier, to='name_short')