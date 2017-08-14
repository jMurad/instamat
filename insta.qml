import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtQuick.Controls.Styles 1.4

ApplicationWindow {
    id: root

    visible: true
    title: qsTr("PyQt5 love QML")
    width: 1200
    height: 900
    style: ApplicationWindowStyle {
        background: Rectangle {
            color: "#FFFFFF"
        }
    }

    //Logo:::::::::::::::::::::::::::::::::::::::::
    Image {
        x: blackLine.width/2-width/2; y: 10
        width: 250
        height: 63
        //source: "abfe7.png"
        fillMode: Image.PreserveAspectCrop
        clip: true
    }

    //Horizontal scroll
    ListView {
        id: lview

        Layout.alignment: Qt.AlignCenter
        Layout.minimumWidth: root.width - 50
        Layout.preferredHeight: root.height - 50

        anchors.fill: parent
        anchors.margins: 10
        orientation: ListView.Horizontal
        layoutDirection: Qt.LeftToRight
        clip: true
        interactive: true
        spacing: 200

        //Model from 5 elements
        model: 5

        delegate: Item {

            width: root.width - 100
            height: root.height - 100

            //Rectangle with black line
            Rectangle {
                id:blackLine

                width: root.width*15/16; height: (root.height)-150
                color:"#fff"
                radius: 7
                border.color: "#000000"
                border.width: 2
                x: (parent.parent.width-width)/2
                y: 80
                property int count: 9

                //Model for GridView
                ListModel {
                    id: theModel

                    ListElement { number: 0 }
                    ListElement { number: 1 }
                    ListElement { number: 2 }
                    ListElement { number: 3 }
                    ListElement { number: 4 }
                    ListElement { number: 5 }
                    ListElement { number: 6 }
                }

                //Grid for viewing images
                GridView  {
                    id: view

                    anchors.fill:  parent
                    anchors.margins:  20
                    clip:  true
                    model:  theModel
                    property variant side: (blackLine.width-2*view.anchors.margins)/4
                    cellWidth:  side
                    cellHeight:  side

                    delegate:  Item  {

                        width: 500
                        height: 300

                        //Rectangles for images
                        Rectangle  {
                            id: greenBox

                            width: view.side-1
                            height: view.side-1
                            color: "#f04"
                            border.width: 1

                            Text {
                                text: index
                                anchors.centerIn: parent
                                font.pointSize: 10; font.bold: true
                            }

                            MouseArea {
                                anchors.fill: parent

                                onClicked: {
                                    theModel.remove(index);
                                }
                            }

                            GridView.onRemove: SequentialAnimation {
                                PropertyAction { target: greenBox; property: "GridView.delayRemove"; value: true }
                                NumberAnimation { target: greenBox; property: "scale"; to: 0; duration: 250; easing.type: Easing.InOutQuad }
                                PropertyAction { target: greenBox; property: "GridView.delayRemove"; value: false }
                            }

                            GridView.onAdd: SequentialAnimation {
                                NumberAnimation { target: greenBox; property: "scale"; from: 0; to: 1; duration: 250; easing.type: Easing.InOutQuad }
                            }
                        }
                    }
                }


            }
        }

        preferredHighlightBegin: width - 10
        preferredHighlightEnd: 10
        highlightRangeMode: ListView.StrictlyEnforceRange
        Component.onCompleted: currentIndex = count / 2
    }

    Rectangle {
        id: buttonClick

        width: 130; height: 35
        x: parent.parent.width/2-width/2
        y: (parent.parent.height)-50
        radius: 6
        border.color: "#000000"
        border.width: 2

        Text {
            id: btnText

            text: "Загрузить еще..."
            anchors.centerIn: parent
            font.pointSize: 10; font.bold: true
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                //theModel.append({"number": ++blackLine.count});
                btnText.text = lview.visibleArea.xPosition
            }
        }
    }

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