import sys
from BackEnd.functions import *
from PyQt5.QtCore import QUrl
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QObject, pyqtSignal, pyqtSlot
import urllib.request
import re
from threading import Thread


class DownloadThread(Thread):
    def __init__(self, url, name):
        Thread.__init__(self)
        self.name = name
        self.url = url

    def run(self):
        handle = urllib.request.urlopen(self.url)
        fname = self.name
        with open(fname, "wb") as f_handler:
            while True:
                chunk = handle.read(1024)
                if not chunk:
                    break
                f_handler.write(chunk)


class Instamat(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.session = requests.Session()
        self.insta = Instagram(self.session)
        self.insta.auth_insta()
        self.find_str = ""

    resultFind = pyqtSignal(str, arguments=['resultFind'])
    nextResultFind = pyqtSignal(str, arguments=['nextResultFind'])
    list_loc_url = []

    def downloader(self, parse_obj):
        for r_s in json.loads(parse_obj):
            loc_url = re.search('\/([^\/]+\.\w+)$', r_s['thumb320']).group(1)
            thread = DownloadThread(r_s['thumb320'], "FrontEnd/cache/"+loc_url)
            thread.start()
            buf = dict()
            buf['thumb'] = "cache/"+loc_url
            self.list_loc_url.append(buf)
        thread.join()
        return json.dumps(self.list_loc_url)

    @pyqtSlot(str)
    def first_find(self, arg1):
        self.find_str = arg1
        if arg1[0] == "#":
            result = self.downloader(self.insta.search_tag(arg1[1:]))
        else:
            result = self.downloader(self.insta.search_pro(arg1[1:]))
        self.resultFind.emit(result)

    @pyqtSlot()
    def next_find(self):
        if self.find_str == "#":
            result = self.insta.next_search_tag(self.find_str[1:])
        else:
            result = self.insta.next_search_pro(self.find_str[1:])
        self.nextResultFind.emit(result)

if __name__ == '__main__':

    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    instamat = Instamat()
    engine.rootContext().setContextProperty("instamat", instamat)

    engine.load(QUrl("FrontEnd/newTest.qml"))
    engine.quit.connect(app.quit)
    sys.exit(app.exec_())
