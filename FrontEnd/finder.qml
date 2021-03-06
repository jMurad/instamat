import QtQuick 2.5

Rectangle{
    id: root1

    anchors.fill: parent
    anchors.margins: 10

    //Сигнал бэкЭнд`у для выдачи данных
    signal nextFrame()

    //Описание строки ввода
    Rectangle {
        id: labelText

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 50
        width: 550
        height: 35

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "(#) хештэг или (@) название профиля:"
            font.pointSize: 20
        }
    }

    //Строка ввода
    Rectangle {
        id: inputText

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 50
        anchors.rightMargin: 50
        anchors.top: labelText.bottom
        anchors.topMargin: 15
        height: 100
        border.width: 1

        TextInput {
            id: intxt

            anchors.fill: parent
            anchors.margins: 7
            font.pixelSize: 60
            text: ""
            cursorVisible: true

            validator: RegExpValidator{
                regExp: /^(@|#)\w*$/
            }
        }
    }

    //Клавиатура
    Rectangle {
        id: keyBoard

        anchors.top: inputText.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 15
        //Столбец (1 столбец)
        Column {
            anchors.fill: parent
            spacing: 3

            //Повтор строк 4 раза (из модели)
            Repeater {
                model: keyBoardModel

                //Строка
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 3

                    //Повтор столбцов в строке N раз (N - из модели)
                    Repeater {
                        model: modelData

                        //Клавиши
                        Rectangle {
                            width: ((root1.width-100-((11-1)*parent.parent.spacing))/11)*w
                            height: width * h
                            radius: 3
                            border.color: "#000000"
                            border.width: 1
                            color: clr

                            //Изображение на клавише
                            Image {
                                id: backImg
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                anchors.topMargin: parent.width*10/100
                                anchors.bottomMargin: parent.width*10/100
                                width: parent.width
                                fillMode: Image.PreserveAspectFit
                                horizontalAlignment: Image.AlignHCenter
                                source: imag
                                mipmap: true
                            }

                            //Текст на клавише
                            Text {
                                id: textName
                                anchors.centerIn: parent
                                text: name
                                font.pixelSize: 25
                            }

                            //Обработчик нажатий на клавишу
                            MouseArea {
                                id: button_mouse_area

                                anchors.fill: parent
                                hoverEnabled: true

                                onEntered: {
                                    parent.border.color = "gray"
                                    parent.border.width = 4
                                }

                                onExited: {
                                    parent.border.color = "black"
                                    parent.border.width = 1
                                }

                                onClicked: {
                                    parent.border.color = "black"
                                    if((name != "<")&&(name != "(c)")&&(named != "next")) {
                                        var oldPos = intxt.cursorPosition
                                        var postStr = intxt.text.substring(intxt.cursorPosition, intxt.text.length)
                                        var preStr = intxt.text.substring(0,intxt.cursorPosition)
                                        intxt.text = preStr + textName.text.toLowerCase() + postStr
                                        if(intxt.text.search(/^(@|#)\w*$/))
                                            intxt.text = preStr + postStr
                                        else
                                            intxt.cursorPosition = oldPos + 1

                                    }
                                    else
                                        if(name == "<") {
                                            oldPos = intxt.cursorPosition
                                            var oldStr = intxt.text
                                            postStr = intxt.text.substring(intxt.cursorPosition, intxt.text.length)
                                            preStr = intxt.text.substring(0,intxt.cursorPosition - 1)
                                            intxt.text = preStr + postStr
                                            if((!intxt.text.search(/^(@|#)\w*$/))||(intxt.text == ""))
                                                intxt.cursorPosition = oldPos - 1
                                            else
                                                intxt.text = oldStr
                                        }
                                        else
                                            if(name == "(c)")
                                                intxt.text = ""
                                            else
                                                if(named == "next") {
                                                    instamat.first_find(intxt.text)
                                                    rootModel.append({"sourceName": "finder2.qml"})
                                                    lview.currentIndex = 1
                                                }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    //Модель для клавиатуры
    ListModel {
        id: keyBoardModel

        ListElement {
            modelName: [
                ListElement { name: "Q"; w: 1; h: 1},
                ListElement { name: "W"; w: 1; h: 1},
                ListElement { name: "E"; w: 1; h: 1},
                ListElement { name: "R"; w: 1; h: 1},
                ListElement { name: "T"; w: 1; h: 1},
                ListElement { name: "Y"; w: 1; h: 1},
                ListElement { name: "U"; w: 1; h: 1},
                ListElement { name: "I"; w: 1; h: 1},
                ListElement { name: "O"; w: 1; h: 1},
                ListElement { name: "P"; w: 1; h: 1}
            ]
        }
        ListElement {
            modelName: [
                ListElement { name: "A"; w: 1; h: 1},
                ListElement { name: "S"; w: 1; h: 1},
                ListElement { name: "D"; w: 1; h: 1},
                ListElement { name: "F"; w: 1; h: 1},
                ListElement { name: "G"; w: 1; h: 1},
                ListElement { name: "H"; w: 1; h: 1},
                ListElement { name: "J"; w: 1; h: 1},
                ListElement { name: "K"; w: 1; h: 1},
                ListElement { name: "L"; w: 1; h: 1}
            ]
        }
        ListElement {
            modelName: [
                ListElement { name: "Z"; w: 1; h: 1},
                ListElement { name: "X"; w: 1; h: 1},
                ListElement { name: "C"; w: 1; h: 1},
                ListElement { name: "V"; w: 1; h: 1},
                ListElement { name: "B"; w: 1; h: 1},
                ListElement { name: "N"; w: 1; h: 1},
                ListElement { name: "M"; w: 1; h: 1},
                ListElement { named: "next"; imag: "search.png"; clr: "#FFFFEE"; w: 1.25; h: 0.8}
            ]
        }
        ListElement {
            modelName: [
                ListElement { name: "#"; clr: "#FFFFE0"; w: 1; h: 1},
                ListElement { name: "@"; clr: "#FFFFE0"; w: 1; h: 1},
                ListElement { name: "_"; clr: "#FFFFE0"; w: 1; h: 1},
                ListElement { name: "<"; clr: "#CCCCCC"; w: 1; h: 1},
                ListElement { name: "(c)"; clr: "#CCCCCC"; w: 1; h: 1}
            ]
        }
    }
}
