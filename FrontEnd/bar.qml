import QtQuick 2.0

Item {

    Rectangle {
        id: bar

        width: parent.width*95/100
        height: 35
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        border.width: 1

        Image {
            id: find1

            anchors.right: left_link.left
            anchors.rightMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            height: left_link.height
            width: height
            source: "\\FrontEnd\\back.svg"
            mipmap: true
        }

        Text {
            id: left_link

            anchors.left: parent.left
            anchors.leftMargin: 25
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 15
            text: "Назад"

            MouseArea {
                id: left_link_

                anchors.fill: parent
                hoverEnabled: true

                onEntered: {
                    parent.font.pixelSize = 16

                }

                onExited: {
                    parent.font.pixelSize = 15
                }

                onClicked: {
                    lview.currentIndex = 1
                }
            }
        }

        Image {
            id: find2

            anchors.right: center_link.left
            anchors.rightMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            height: center_link .height
            width: height
            source: "\\FrontEnd\\lupa.svg"
            mipmap: true
        }

        Text {
            id: center_link

            anchors.centerIn: parent
            font.pixelSize: 15
            text: "Новый поиск"

            MouseArea {
                id: center_link_

                anchors.fill: parent
                hoverEnabled: true

                onEntered: {
                    parent.font.pixelSize = 16

                }

                onExited: {
                    parent.font.pixelSize = 15
                }

                onClicked: {
                    lview.currentIndex = 0
                }
            }
        }

     }

}
