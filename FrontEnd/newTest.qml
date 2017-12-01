import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4


ApplicationWindow {
    id: root

    visible: true
    title: qsTr("PyQt5 plus QML")
    width: 1200
    height: 900
    style: ApplicationWindowStyle {
        background: Rectangle {
            color: "#fff"
        }
    }

    property string qResultFind: ""
    property string qNextResultFind: ""

    //Логотип
    Image {
        x: root.width/2-width/2; y: 20
        width: 250
        height: 63
        source: "logo.png"
        fillMode: Image.PreserveAspectCrop
        clip: true
    }

    Rectangle {
        anchors.fill: parent
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.bottomMargin: 30
        anchors.topMargin: 100
        color: "#fff"

        //Горизонтальный скроллинг вкладок
        ListView {
            id: lview

            anchors.fill: parent
            layoutDirection: Qt.LeftToRight
            orientation: ListView.Horizontal
            clip: true
            interactive: false
            preferredHighlightBegin: 20
            preferredHighlightEnd: width - 20
            highlightRangeMode: ListView.StrictlyEnforceRange
            spacing: 70

            highlightFollowsCurrentItem: true
            highlightMoveVelocity: 1200

            move: Transition {
                NumberAnimation { properties: "x,y";
                    duration: 100
                }
            }

            model: ListModel {
                ListElement { sourceName: "finder.qml"; }
                ListElement { sourceName: "finder2.qml"; }
                ListElement { sourceName: "finder3.qml"; }
            }

            //Прямоугольник с черной рамкой
            delegate: Rectangle {
                id:blackLine

                width: root.width - 40
                height: root.height - 130


                color:"#fff"
                radius: 10
                border.color: "#000000"
                border.width: 2

                Loader {
                    id: background.item
                    anchors.fill: parent

                    //anchors.centerIn: blackLine
                    source: sourceName
                }
            }
        }
    }

     Connections {
        target: instamat

        onResultFind: {
            root.qResultFind = resultFind
        }

        onNextResultFind: {
            root.qNextResultFind = nextResultFind
        }
    }
}
