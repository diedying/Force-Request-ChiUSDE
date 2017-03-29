import requests
from fake_useragent import UserAgent
from bs4 import BeautifulSoup
def getData(urlPerson):
    #access to the search results page as fake_client# #access to the result link web
    ua = UserAgent()
    header = {'user-agent':ua.chrome}
    pagePerson = requests.get(urlPerson,headers=header)
    saucePerson = pagePerson.text
    soupPerson = BeautifulSoup(saucePerson, 'lxml')

    #scrape the data from the result link webpage
    tablePerson = soupPerson.body.table
    ths = tablePerson.find_all('th')
    tds = tablePerson.find_all('td')
    record = {}
    for i in range(len(ths)):
        tableName = ths[i].text
        record[tableName[:-1]] = tds[i].text
    return record
#access to the search results page as fake_client
ua = UserAgent()
header = {'user-agent':ua.chrome}
#make the url
searchKey = 'mo+li'
realEmail = 'king_lm@tamu.edu'

urlSearch = 'https://services.tamu.edu/directory-search/?branch=people&cn=' + searchKey
page = requests.get(urlSearch,headers=header)
sauce = page.text
soup = BeautifulSoup(sauce, 'lxml')

#get the results' links we need to check
table = soup.body.table
#store all search results
urlPersons = []
for url in table.find_all('a'):
    urlPersons.append('https://services.tamu.edu' + url.get('href'))
#store all search resuls' information
records = []#store all records
for url in urlPersons:
    record = getData(url)
    if record['Email Address'] == realEmail:
        result = record
        break
print(result)
