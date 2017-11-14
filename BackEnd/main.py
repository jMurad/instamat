import sys
from BackEnd.functions import *
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QObject, pyqtSignal, pyqtSlot
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQuick import QQuickView
from PyQt5.QtCore import QUrl

class Calculator(QObject):
    def __init__(self):
        QObject.__init__(self)

    # cигнал передающий сумму
    # обязательно даём название аргументу через arguments=['sum']
    # иначе нельзя будет его забрать в QML
    sumResult = pyqtSignal(int, arguments=['sum'])

    subResult = pyqtSignal(int, arguments=['sub'])

    # слот для суммирования двух чисел
    @pyqtSlot(int, int)
    def sum(self, arg1, arg2):
        # складываем два аргумента и испускаем сигнал
        self.sumResult.emit(arg1 + arg2)

    # слот для вычитания двух чисел
    @pyqtSlot(int, int)
    def sub(self, arg1, arg2):
        # вычитаем аргументы и испускаем сигнал
        self.subResult.emit(arg1 - arg2)


if __name__ == '__main__':

    app = QApplication(sys.argv)
    # Объект QQuickView, в который грузится UI для отображения
    view = QQuickView()
    view.setSource(QUrl('\\FrontEnd\\newTest.qml'))
    #view.show()
    app.exec_()
    sys.exit()
