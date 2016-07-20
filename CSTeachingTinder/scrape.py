import bs4, requests, console, ui

console.clear()

def get_Text(url):
    return bs4.BeautifulSoup(requests.get(url).text, "html5lib")

soup = get_Text('http://csteachingtips.org/random-tip')
products = soup.findAll('h1')



for href in products:
    print (hreft.get_text())

