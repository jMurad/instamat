import QtQuick 2.5

Rectangle {
    id:recMain
    width: 1200; height: 900
    color:"#fff"

    Image {
            x: recGreen.width/2-width/2; y: 10
            width: 250
            height: 63
            source: "abfe7.png"
            fillMode: Image.PreserveAspectCrop
            clip: true
        }

    Rectangle {
        id:recGreen
        width: parent.parent.width*15/16; height: (parent.parent.height*15/16)-50
        color:"#fff"
        radius: 7
        border.color: "#000000"
        border.width: 2
        x: (parent.parent.width-width)/2
        y: 80



        Rectangle {
            id: buttonClick
            width: 130; height: 35
            x: parent.width/2-width/2
            y: parent.height-50
            radius: 6
            border.color: "#000000"
            border.width: 2

            Text {
                id: btnText
                text: "Загрузить еще..."
                anchors.centerIn: parent
                font.pointSize: 10; font.bold: true
            }
        }

    }

}