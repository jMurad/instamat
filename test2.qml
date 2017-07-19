import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

ApplicationWindow {
    visible: true
    width: 640
    height: 240
    title: qsTr("PyQt5 love QML")
    color: "whitesmoke"

    GridLayout {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 9

        columns: 4
        rows: 4
        rowSpacing: 10
        columnSpacing: 10

        Text {
            text: qsTr("First number")
        }

        // Поле ввода первого числа
        TextField {
            id: firstNumber
        }

        Text {
            text: qsTr("Second number")
        }

        // Поле ввода второго числа
        TextField {
            id: secondNumber
        }

        Button {
            height: 40
            Layout.fillWidth: true
            text: qsTr("Sum numbers")

            Layout.columnSpan: 2

            onClicked: {
                // Вызываем слот калькулятора, чтобы сложить числа
                calculator.sum(firstNumber.text, secondNumber.text)
            }
        }

        Text {
            text: qsTr("Result")
        }

        // Здесь увидим результат сложения
        Text {
            id: sumResult
        }

        Button {
            height: 40
            Layout.fillWidth: true
            text: qsTr("Subtraction numbers")

            Layout.columnSpan: 2

            onClicked: {
                // Вызываем слот калькулятора, чтобы вычесть числа
                calculator.sub(firstNumber.text, secondNumber.text)
            }
        }

        Text {
            text: qsTr("Result")
        }

        // Здесь увидим результат вычитания
        Text {
            id: subResult
        }
    }

    // Здесь забираем результат сложения или вычитания чисел
    Connections {
        target: calculator

        // Обработчик сигнала сложения
        onSumResult: {
            // sum было задано через arguments=['sum']
            sumResult.text = sum
        }

        // Обработчик сигнала вычитания
        onSubResult: {
            // sub было задано через arguments=['sub']
            subResult.text = sub
        }
    }
}