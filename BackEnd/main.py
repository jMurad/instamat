import sys
from BackEnd.functions import *
from PyQt5.QtCore import QUrl
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QObject, pyqtSignal, pyqtSlot

class Instamat(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.session = requests.Session()
        self.insta = Instagram(self.session)
        self.insta.auth_insta()
        self.find_str = ""


    resultFind = pyqtSignal(str, arguments=['resultFind'])
    nextResultFind = pyqtSignal(str, arguments=['nextResultFind'])

    @pyqtSlot(str)
    def firstFind(self, arg1):
        self.find_str = arg1
        if arg1[0] == "#":
            result = self.insta.search_tag(arg1[1:])
        else:
            result = self.insta.search_pro(arg1[1:])
        self.resultFind.emit(result)
        print(result)

    @pyqtSlot()
    def nextFind(self):
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

    engine.load(QUrl("FrontEnd/main.qml"))
    engine.quit.connect(app.quit)
    sys.exit(app.exec_())
