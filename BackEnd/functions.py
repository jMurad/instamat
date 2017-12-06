import json
import re
import requests
from BackEnd.endpoints import *


class Instagram:
    CMSD = ['', '', '', '']
    end_cursor = ''
    has_next_page = True
    session = None
    userID = ''

    # Объявление конструктора
    def __init__(self, sess):
        self.session = sess

    # Парсинг значений cookie----------------------|
    def __parse_cookie_cmsd(self, page):
        result = [re.search('csrftoken=(.*?);', str(page.headers)),
                  re.search('mid=(.*?);', str(page.headers)),
                  re.search('sessionid=(.*?);', str(page.headers)),
                  re.search('ds_user_id=(.*?);', str(page.headers)),
                  ]
        iter = 0
        for res in result:
            if res and len(res.group(1)) > 0:
                self.CMSD[iter] = res.group(1)
            iter += 1

    # Авторизация----------------------------------|
    def auth_insta(self):
        self.__parse_cookie_cmsd(requests.get(url_inst))
        payload = "username=%s&password=%s" % (username, password)
        headers = {'content-type': 'application/x-www-form-urlencoded',
                   'cookie': 'mid={0}; '
                             'ig_mcf_shown=1655622802190;'
                             'ig_vw=1920; '
                             'ig_pr=1; '
                             'rur=ATN; '
                             'csrftoken={1}'.format(self.CMSD[1], self.CMSD[0]),
                   'referer': 'https://www.instagram.com/',
                   'x-csrftoken': '{0}'.format(self.CMSD[0]),
        }
        page = self.session.post(url_auth, data=payload, headers=headers, allow_redirects=False)
        self.__parse_cookie_cmsd(page)

    # Начать поиск------------------------------------------------------------------------------------------------------
    def __search(self, search_str, url_req):
        headers = {'cookie': 'mid={0}; '
                             'sessionid={1}; '
                             'ig_pr=1; '
                             'ig_vw=1920; '
                             'ig_mcf_shown=1655625975813; '
                             'rur=ASH; '
                             'csrftoken={2}; '
                             'ds_user_id={3}'.format(self.CMSD[1], self.CMSD[2], self.CMSD[0], self.CMSD[3]),
                   'referer': 'https://www.instagram.com/',
                   }
        page = self.session.get(url_req.format(search_str), headers=headers, allow_redirects=False)
        self.__parse_cookie_cmsd(page)
        json_data = json.loads(page.text)
        return json_data

    # Поиск по тегу--------------------------------|
    def search_tag(self, search_str):
        json_data = self.__search(search_str, url_search_tag)
        self.end_cursor = json_data['tag']['media']['page_info']['end_cursor']
        self.has_next_page = json_data['tag']['media']['page_info']['has_next_page']
        return self.img_grabber(json_data)

    # Поиск по профилю-----------------------------|
    def search_pro(self, search_str):
        json_data = self.__search(search_str, url_search_pro)
        self.userID = json_data['user']['id']
        self.end_cursor = json_data['user']['media']['page_info']['end_cursor']
        self.has_next_page = json_data['user']['media']['page_info']['has_next_page']
        return self.img_grabber(json_data)

    # Загрузить еще-----------------------------------------------------------------------------------------------------
    def __next_search(self, search_str, url_req, state):
        headers = {'cookie': 'mid={0}; '
                             'sessionid={1}; '
                             'ig_pr=1; '
                             'ig_vw=1920; '
                             'ig_mcf_shown=1655625975813; '
                             'rur=ASH; '
                             'csrftoken={2}; '
                             'ds_user_id={3}'.format(self.CMSD[1], self.CMSD[2], self.CMSD[0], self.CMSD[3]),
                   'referer': 'https://www.instagram.com/{0}/'.format(search_str if state else 'explore/tags/{0}'.format(search_str)),
                   }
        page = self.session.get(url_req.format(self.userID if state else search_str, '6', self.end_cursor), headers=headers, allow_redirects=False)
        json_data = json.loads(page.text)
        return json_data

    # Продолжить поиск по тегу---------------------|
    def next_search_tag(self, search_str):
        if self.has_next_page:
            json_data = self.__next_search(search_str, url_next_search_tag, False)
            self.end_cursor = json_data['data']['hashtag']['edge_hashtag_to_media']['page_info']['end_cursor']
            self.has_next_page = json_data['data']['hashtag']['edge_hashtag_to_media']['page_info']['has_next_page']
            return self.img_grabber(json_data)
        else:
            return {'None'}

    # Продолжить поиск по профилю------------------|
    def next_search_pro(self, search_str):
        if self.has_next_page:
            json_data = self.__next_search(search_str, url_next_search_pro, True)
            self.end_cursor = json_data['data']['user']['edge_owner_to_timeline_media']['page_info']['end_cursor']
            self.has_next_page = json_data['data']['user']['edge_owner_to_timeline_media']['page_info']['has_next_page']
            return self.img_grabber(json_data)
        else:
            return {'None'}

    # Трансформировать instagram'овский json, в удобный для меня
    def img_grabber(self, json_str):
        count = 0
        str_res = []
        if 'tag' in json_str:
            for item in json_str['tag']['media']['nodes']:
                if not item['is_video']:
                    # buf = {}
                    buf = dict()
                    buf['date'] = item['date'] if 'date' in item else ''
                    buf['code'] = item['code'] if 'code' in item else ''
                    buf['caption'] = item['caption'] if 'caption' in item else ''
                    buf['display_src'] = item['display_src'] if 'display_src' in item else ''
                    buf['height'] = item['dimensions']['height'] if 'height' in item else ''
                    buf['width'] = item['dimensions']['width'] if 'width' in item else ''
                    index = 0
                    for itemThumb in item['thumbnail_resources']:
                        buf['thumb' + str(index)] = itemThumb['src']
                        index += 1
                    str_res.append(buf)
                    count += 1
        elif 'user' in json_str:
            for item in json_str['user']['media']['nodes']:
                if not item['is_video']:
                    # buf = {}
                    buf = dict()
                    buf['date'] = item['date'] if 'date' in item else ''
                    buf['code'] = item['code'] if 'code' in item else ''
                    buf['caption'] = item['caption'] if 'caption' in item else ''
                    buf['display_src'] = item['display_src'] if 'display_src' in item else ''
                    buf['height'] = item['dimensions']['height'] if 'height' in item else ''
                    buf['width'] = item['dimensions']['width'] if 'width' in item else ''
                    index = 0
                    for itemThumb in item['thumbnail_resources']:
                        buf['thumb' + str(index)] = itemThumb['src']
                        index += 1
                    str_res.append(buf)
                    count += 1
        elif 'data' in json_str:
            if 'hashtag' in json_str['data']:
                for item in json_str['data']['hashtag']['edge_hashtag_to_media']['edges']:
                    if not item['node']['is_video']:
                        # buf = {}
                        buf = dict()
                        item_node = item['node']
                        item_text = item['node']['edge_media_to_caption']['edges']
                        buf['date'] = item_node['taken_at_timestamp'] if 'taken_at_timestamp' in item_node else ''
                        buf['code'] = item_node['shortcode'] if 'shortcode' in item_node else ''
                        buf['caption'] = item_text['text'] if 'text' in item_text else ''
                        buf['display_src'] = item_node['display_url'] if 'display_url' in item_node else ''
                        buf['height'] = item_node['dimensions']['height'] if 'height' in item_node['dimensions'] else ''
                        buf['width'] = item_node['dimensions']['width'] if 'width' in item_node['dimensions'] else ''
                        index = 0
                        for itemThumb in item_node['thumbnail_resources']:
                            buf['thumb' + str(index)] = itemThumb['src']
                            index += 1
                        str_res.append(buf)
                        count += 1
            elif 'user' in json_str['data']:
                for item in json_str['data']['user']['edge_owner_to_timeline_media']['edges']:
                    if not item['node']['is_video']:
                        # buf = {}
                        buf = dict()
                        item_node = item['node']
                        item_text = item['node']['edge_media_to_caption']['edges']
                        buf['date'] = item_node['taken_at_timestamp'] if 'taken_at_timestamp' in item_node else ''
                        buf['code'] = item_node['shortcode'] if 'shortcode' in item_node else ''
                        buf['caption'] = item_text['text'] if 'text' in item_text else ''
                        buf['display_src'] = item_node['display_url'] if 'display_url' in item_node else ''
                        buf['height'] = item_node['dimensions']['height'] if 'height' in item_node['dimensions'] else ''
                        buf['width'] = item_node['dimensions']['width'] if 'width' in item_node['dimensions'] else ''
                        index = 0
                        for itemThumb in item_node['thumbnail_resources']:
                            buf['thumb' + str(index)] = itemThumb['src']
                            index += 1
                        str_res.append(buf)
                        count += 1
            else:
                return json_str
        str_r = {'count': count, 'nodes': str_res}
        return self.img_for_qml(str_r)

    # QML lite
    @staticmethod
    def img_for_qml(json_str):
        nodes = []
        for item in json_str['nodes']:
            # buf = {}
            buf = dict()
            buf['qurl'] = item['display_src']
            buf['thumb320'] = item['thumb2']
            nodes.append(buf)
        return json.dumps(nodes)

if __name__ == '__main__':
    session = requests.Session()
    insta = Instagram(session)
    insta.auth_insta()
    stroke = insta.search_tag("apple")
    # stroke2 = insta.next_search_pro("apple")
    print(stroke)
    # print(stroke2)
