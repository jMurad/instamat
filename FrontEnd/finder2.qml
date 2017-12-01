import QtQuick 2.5

Rectangle {
    id: root2

    anchors.fill: parent
    anchors.margins: 10

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
            source: "back.svg"
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
                    lview.currentIndex = 0
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
            source: "loop.svg"
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
                    background.item
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

    Rectangle{
        id: body

        width: parent.width*95/100
        anchors.top: bar.bottom
        anchors.bottom: root2.bottom
        anchors.topMargin: 20
        anchors.bottomMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        border.width: 0

        property int counter: 0

        Component.onCompleted: {
            timer1.running = true
            body.counter = body.counter + 1
            kk1.text = body.counter
        }   //Повторный поиск настроить завтра

        Timer {
            id: timer1

            interval: 1000; running: false; repeat: true
            onTriggered: {
                var data = root.qResultFind;
                if (data.indexOf("{") != -1 ){
                    timer1.running = false

                    root.qResultFind = ""
                    var jsdata = JSON.parse(data)
                    for (var i = 0; i < jsdata.length; i++) {
                        theModel.append( { "qurl": jsdata[i].qurl } );
                    }
                }
            }
        }

        Text {
            id: kk1
            text: "No"
        }

        //Model for GridView
        ListModel {
            id: theModel
        }

        //Grid for viewing images
        GridView  {
            id: view

            anchors.fill: parent
            clip: true
            model: theModel
            cellWidth: (parent.width)/4
            cellHeight: cellWidth


            delegate: Item {

                width: view.cellWidth
                height: width

                Rectangle  {
                    id: greenBox

                    width: parent.width-8
                    height: parent.height-8
                    anchors.centerIn: parent

                    color: "green"
                    border.width: 1

                    Text {
                        text: index
                        anchors.centerIn: parent
                        font.pointSize: 10;
                        font.bold: true
                    }

                    Image {
                        id: pic

                        anchors.fill: parent
                        source: qurl
                    }


                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            seqAnim.start()
                            lview.currentIndex = 2
                        }
                    }

                    SequentialAnimation {
                        id: seqAnim

                        NumberAnimation {
                            target: greenBox;
                            property: "scale";
                            from: 1.057;
                            to: 1;
                            duration: 700;
                            easing.type: Easing.InOutQuad
                        }
                    }
                    /*
                    GridView.onRemove: SequentialAnimation {
                        PropertyAction {
                            target: greenBox;
                            property: "GridView.delayRemove";
                            value: true
                        }
                        NumberAnimation {
                            target: greenBox;
                            property: "scale";
                            to: 0;
                            duration: 250;
                            easing.type: Easing.InOutQuad
                        }
                        PropertyAction {
                            target: greenBox;
                            property: "GridView.delayRemove";
                            value: false
                        }
                    }

                    GridView.onAdd: SequentialAnimation {
                        NumberAnimation {
                            target: greenBox;
                            property: "scale";
                            from: 0;
                            to: 1;
                            duration: 250;
                            easing.type: Easing.InOutQuad
                        }
                    }
                    */
                }
            }
        }
    }
}
