from pig_util import outputSchema


@outputSchema('word:chararray')
def char_to_country(country_code):
    country = None
    if country_code == 'E':
        country = 'England'
    elif country_code == 'F':
        country = 'France'
    elif country_code == 'I':
        country = 'Italy'
    elif country_code == 'G':
        country = 'Germany'
    elif country_code == 'A':
        country = 'Austria'
    elif country_code == 'T':
        country = 'Turkey'
    elif country_code == 'R':
        country = 'Russia'
    return country
