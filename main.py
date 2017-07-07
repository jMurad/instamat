import functions
import sys
from PyQt5.QtCore import QUrl
from PyQt5.QtWidgets import QApplication, QWidget
from PyQt5.QtQuick import QQuickView

if __name__ == '__main__':
    app = QApplication(sys.argv)
    view = QQuickView()
    view.setSource(QUrl('insta.qml'))
    view.setResizeMode(QQuickView.SizeRootObjectToView)
    view.setGeometry(100, 100, 1200, 900)
    view.show()
    app.exec_()
    sys.exit()
