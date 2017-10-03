import requests, re, json



LOGIN = "jmlmurad"
PASSWORD = "M3244dmk"
session = requests.Session()
url = 'https://www.instagram.com/'
url2 = 'https://www.instagram.com/accounts/login/ajax/'
url3 = 'https://www.instagram.com/explore/tags/murad/?__a=1'
url5 = 'https://www.instagram.com/explore/tags/dstu/?__a=1'
url4 = 'https://www.instagram.com/graphql/query/?query_id=17882293912014529&tag_name=murad&first=6&after=J0HWUjw-wAAAF0HWUiMBAAAAFiYA'

def whatistype(var_type):
    if isinstance(var_type, int):
        print("#Тип int")
    elif isinstance(var_type, bytes):
        print("#Тип строка bytes")
    elif isinstance(var_type, str):
        print("#Тип строка str")
    elif isinstance(var_type, tuple):
        print("#Тип кортеж")
    elif isinstance(var_type, dict):
        print("#Тип словарь")
    elif isinstance(var_type, list):
        print("#Тип список")
    elif var_type is None:
        print("#Тип None")

def parce(url):
    page = requests.get(url)
    #print(page.content)
    result = re.search('csrftoken=(.+?);', str(page.headers))
    print(result.group(1))
    result2 = re.search('mid=(.+?);', str(page.headers))
    print(result2.group(1))

    if (result and len(result.group(1)) > 0) and (result2 and len(result2.group(1)) > 0):
        return [result.group(1), result2.group(1)]
    else:
        print("unlucky")



def authLogin(LOGIN, PASSWORD, session, url):
    token = parce(url)
    payload = ("username=%s&password=%s") % (LOGIN, PASSWORD)
    headers = {'Content-Type': 'application/x-www-form-urlencoded',
               'Cookie': 'mid={0}; ig_pr=1; ig_vw=1920; s_network=; csrftoken={1}'.format(token[1],token[0]),
               #'User-Agent': 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Mobile Safari/537.36',
               #'x-csrftoken':'{0}'.format(token[0])
              }
    headers2 = {'accept':'*/*',
                'accept-encoding':'gzip, deflate, br',
                'accept-language':'ru,en-US;q=0.8,en;q=0.6',
                'content-length':'35',
                'content-type':'application/x-www-form-urlencoded',
                'cookie':'mid={0}; '
                         'ig_mcf_shown=1655622802190; '
                         'ig_vw=899; '
                         'ig_pr=2; '
                         'rur=ATN; '
                         'csrftoken={1}'.format(token[1], token[0]),
                'origin':'https://www.instagram.com',
                'referer':'https://www.instagram.com/',
                'user-agent':'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) '
                             'AppleWebKit/537.36 (KHTML, like Gecko) '
                             'Chrome/56.0.2924.87 Mobile Safari/537.36',
                'x-csrftoken':'{0}'.format(token[0]),
                'x-instagram-ajax':'1',
                'x-requested-with':'XMLHttpRequest',
               }
    headers3 = {'accept':'*/*',
                'accept-encoding':'gzip, deflate, sdch, br',
                'accept-language':'ru,en-US;q=0.8,en;q=0.6',
                'cookie':'mid={0}; '
                         'sessionid=IGSC6824a3f05de8a13c92f355f8983615cd57560debdc52b56dd340b1ac9748f6e5%3AQdLd3eTt3vboyaNbYVyuHfTR97Wo0YLn%3A%7B%22_'
                         'auth_user_id%22%3A237422112%2C%22_auth_user_backend%22%3A%22accounts.backends.CaseInsensitiveModelBackend%22%2C%22_'
                         'auth_user_hash%22%3A%22%22%2C%22_token_ver%22%3A2%2C%22_'
                         'token%22%3A%22237422112%3AUj9wVWhGbGRQTdkReebiXZbtOqtlsdoZ%3A35449ce78068bf265f147fc0822934b3f8fa76c54e1a049a729b3d7b99525eaf%22%2C%22_'
                         'platform%22%3A4%2C%22last_refreshed%22%3A1497942822.7143223286%2C%22asns%22%3A%7B%22time%22%3A1497942822%2C%22178.74.156.10%22%3A196991%7D%7D; '
                         'ig_pr=1; '
                         'ig_vw=944; '
                         'ig_mcf_shown=1655625975813; '
                         'rur=ASH; '
                         'csrftoken={1}; '
                         'ds_user_id=237422112'.format(token[1], token[0]),
                'referer':'https://www.instagram.com/explore/',
                'user-agent':'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) '
                             'AppleWebKit/537.36 (KHTML, like Gecko) '
                             'Chrome/56.0.2924.87 Mobile Safari/537.36',
                'x-requested-with':'XMLHttpRequest',
    }
    headers4 = {'accept': '*/*',
                'accept-encoding': 'gzip, deflate, sdch, br',
                'accept-language': 'ru,en-US;q=0.8,en;q=0.6',
                'cookie': 'mid={0}; '
                          'sessionid=IGSC6824a3f05de8a13c92f355f8983615cd57560debdc52b56dd340b1ac9748f6e5%3AQdLd3eTt3vboyaNbYVyuHfTR97Wo0YLn%3A%7B%22_'
                          'auth_user_id%22%3A237422112%2C%22_'
                          'auth_user_backend%22%3A%22accounts.backends.CaseInsensitiveModelBackend%22%2C%22_'
                          'auth_user_hash%22%3A%22%22%2C%22_token_ver%22%3A2%2C%22_'
                          'token%22%3A%22237422112%3AUj9wVWhGbGRQTdkReebiXZbtOqtlsdoZ%3A35449ce78068bf265f147fc0822934b3f8fa76c54e1a049a729b3d7b99525eaf%22%2C%22_'
                          'platform%22%3A4%2C%22last_refreshed%22%3A1497942822.7143223286%2C%22asns%22%3A%7B%22time%22%3A1497942822%2C%22178.74.156.10%22%3A196991%7D%7D; '
                          'ig_vw=899; '
                          'ig_pr=2; '
                          'ig_mcf_shown=1655633280287; '
                          'rur=ASH; '
                          'csrftoken={1}; '
                          'ds_user_id=237422112'.format(token[1], token[0]),
                'referer': 'https://www.instagram.com/explore/tags/murad/',
                'user-agent': 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) '
                              'AppleWebKit/537.36 (KHTML, like Gecko) '
                              'Chrome/56.0.2924.87 Mobile Safari/537.36',
                'x-requested-with': 'XMLHttpRequest',
                }


    page = session.post(url, data=payload, headers=headers, allow_redirects=False)
    page2 = session.post(url2, data=payload, headers=headers2, allow_redirects=False)
    page3 = session.post(url3, data=payload, headers=headers3, allow_redirects=False)
    page4 = session.post(url4, data=payload, headers=headers4, allow_redirects=False)

    resp_cont2 = (re.search("^b'(.+?)'$", str(page4.content))).group(1)
    dat = resp_cont2.replace('\\', '\\\\')
    #dt1 = json.loads(dat)
    print(page2.headers)

    resp_cont = (re.search("^b'(.+?)'$", str(page3.content))).group(1)

    # Ответ
    #print("1:Код ответа1      : ", page.status_code)  # Код ответа
    #print("1:Код ответа2      : ", page2.status_code)  # Код ответа
    #print("1:Код ответа3      : ", page3.status_code)  # Код ответа
    #print("1:Тело ответа3      : ", page3.content)  # Код ответа
    #print("1:Тело ответа3      : ", resp_cont)  # Код ответа

    return resp_cont

rc = authLogin(LOGIN, PASSWORD, session, url)
data =  rc.replace('\\','\\\\')
dt = json.loads(data)
#print(len(dt['tag']['top_posts']['nodes']))


for a in dt['tag']['media']['nodes']:
    print(a['display_src'])

from lxml import etree

def test(self, session):
    self.auth_insta(session)
    html_1 = self.search_tag(session)

    a1=etree.Element('html')
    for el in html_1['tag']['top_posts']['nodes']:
        if not el['is_video']:
            a1.append(etree.Element("img", src="{0}".format(el['display_src'])))
            a1.append(etree.Element("br"))
    buf = etree.Element("div", style="border: 1px; width: 800px; height: 30px; background-color: blue;")
    etree.SubElement(buf, "text").text = ""
    a1.append(buf)

    html_2 = self.next_search_tag(session)

    for el in html_2['data']['hashtag']['edge_hashtag_to_media']['edges']:
        if not el['node']['is_video']:
            a1.append(etree.Element("img", src="{0}".format(el['node']['display_url'])))
            a1.append(etree.Element("br"))
    buf = etree.Element("div", style="border: 1px; width: 800px; height: 30px; background-color: blue;")
    etree.SubElement(buf, "text").text = ""
    a1.append(buf)

    html_2 = self.next_search_tag(session)

    for el in html_2['data']['hashtag']['edge_hashtag_to_media']['edges']:
        if not el['node']['is_video']:
            a1.append(etree.Element("img", src="{0}".format(el['node']['display_url'])))
            a1.append(etree.Element("br"))
    buf = etree.Element("div", style="border: 1px; width: 800px; height: 30px; background-color: blue;")
    etree.SubElement(buf, "text").text = ""
    a1.append(buf)

    html_2 = self.next_search_tag(session)

    for el in html_2['data']['hashtag']['edge_hashtag_to_media']['edges']:
        if not el['node']['is_video']:
            a1.append(etree.Element("img", src="{0}".format(el['node']['display_url'])))
            a1.append(etree.Element("br"))
    buf = etree.Element("div", style="border: 1px; width: 800px; height: 30px; background-color: blue;")
    etree.SubElement(buf, "text").text = ""
    a1.append(buf)

    stroka = etree.tostring(a1, pretty_print=False)
    stroka = stroka.replace(b"<img", b"\n<img")
    stroka = stroka.replace(b"<div", b"\n<div")

    fp = open('insta.qml', 'wb')
    fp.write(stroka)
    fp.close()

