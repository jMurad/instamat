import QtQuick 2.5

Rectangle {
    id: root
    width: 1200; height: 900
    //color:"#fff"

    Image {
            x: blackLine.width/2-width/2; y: 10
            width: 250
            height: 63
            source: "abfe7.png"
            fillMode: Image.PreserveAspectCrop
            clip: true
        }

    Rectangle {

        id:blackLine
        width: parent.parent.width*15/16; height: (parent.parent.height)-150
        color:"#fff"
        radius: 7
        border.color: "#000000"
        border.width: 2
        x: (parent.parent.width-width)/2
        y: 80
        property variant colorArray: ["#00bde3", "#67c111", "#ea7025"]
        property int count: 9

        ListModel {
            id: theModel
            ListElement { number: 0 }
            ListElement { number: 1 }
            ListElement { number: 2 }
            ListElement { number: 3 }
            ListElement { number: 4 }
            ListElement { number: 5 }
            ListElement { number: 6 }
            ListElement { number: 7 }
            ListElement { number: 8 }
            ListElement { number: 9 }
        }

        GridView  {
            id: view
            anchors.fill:  parent
            anchors.margins:  20

            clip:  true

            model:  theModel
            property variant side: (blackLine.width-2*view.anchors.margins)/4
            cellWidth:  side
            cellHeight:  side

            delegate:  numberDelegate
        }

        Component  {
            id: numberDelegate

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
                theModel.append({"number": ++blackLine.count});
            }
        }
    }
}
