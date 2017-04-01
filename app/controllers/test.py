import requests
from fake_useragent import UserAgent
from bs4 import BeautifulSoup
def getData(urlPerson):
    # #access to the result link web
    pagePerson = requests.get(urlPerson,headers=header)
    saucePerson = pagePerson.text
    soupPerson = BeautifulSoup(saucePerson, 'lxml')

    #scrape the data from the result link webpage
    tablePerson = soupPerson.body.table
    ths = tablePerson.find_all('th')
    tds = tablePerson.find_all('td')

    for i in range(len(ths)):
        print(str(ths[i].text) + '\n')
        print(str(tds[i].text) + '\n')

ua = UserAgent()

header = {'user-agent':ua.chrome}
#access to the search results page
# url_yuxin_cui = 'https://services.tamu.edu/directory-search/?branch=people&cn=yuxin+cui'
searchKey = 'mo+li'
urlSearch = 'https://services.tamu.edu/directory-search/?branch=people&cn=' + searchKey
page = requests.get(urlSearch,headers=header)
sauce = page.text
soup = BeautifulSoup(sauce, 'lxml')

#get the results' links we need to check
#here we assume only one result link
table = soup.body.table
urlPersons = []
for url in table.find_all('a'):
    #print(url.get('href'))
    urlPersons.append('https://services.tamu.edu' + url.get('href'))

for url in urlPersons:
    getData(url)