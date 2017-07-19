import functions
import sys
from PyQt5.QtCore import QUrl
from PyQt5.QtWidgets import QApplication, QWidget
from PyQt5.QtQuick import QQuickView

from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QObject, pyqtSignal, pyqtSlot


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

    '''
    app = QApplication(sys.argv)
    view = QQuickView()
    view.setSource(QUrl('insta.qml'))
    view.setResizeMode(QQuickView.SizeRootObjectToView)
    view.setGeometry(100, 100, 1200, 900)
    view.show()
    app.exec_()
    sys.exit()
    '''
    # создаём экземпляр приложения
    app = QApplication(sys.argv)
    # создаём QML движок
    engine = QQmlApplicationEngine()
    # создаём объект калькулятора
    calculator = Calculator()
    # и регистрируем его в контексте QML
    engine.rootContext().setContextProperty("calculator", calculator)
    # загружаем файл qml в движок
    engine.load("insta.qml")

    engine.quit.connect(app.quit)
    sys.exit(app.exec_())