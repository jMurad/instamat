import QtQuick 2.5

Rectangle {
    id: root3

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

    Rectangle {
        id: photoCard

        anchors.left: bar.left
        //height: 1205
        width: height*(3/2)
        anchors.top: bar.bottom
        anchors.bottom: root3.bottom
        anchors.topMargin: 20
        anchors.bottomMargin: 150
        border.width: 1

        Image {
            id: imgEnd

            fillMode: Image.PreserveAspectFit
            height: parent.height-20
            source: "pic/606870.jpg"
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: txtEnd

            anchors.top: photoCard.top
            anchors.bottom: photoCard.bottom
            anchors.left: imgEnd.right
            anchors.right: photoCard.right
            anchors.margins: 10
            anchors.rightMargin: 10
            wrapMode: Text.WordWrap
            smooth: true
            minimumPixelSize: 5
            font.pixelSize: 10
            fontSizeMode: Text.Fit

            text: "@Regrann from @fcbarcelona - FC Barcelona away kit 17/18
THE SHIRT NEVER SLEEPS
La samarreta que mai no dorm.
La camiseta que nunca duerme.
nike.com/fcb www.tubarcelona.com
@PenyaFCBdeCCS
#FCBVenezuela #FCB
#D10S #MESSI #Suarez #Neimar #Futbol #Soccer #magia #TikiTaka #Iniesta #LaLiga #PeñaDeCaracas
#MesQueUnaPenya
#Barça #CCS
#CARACAS #PenyesFCB
#ForçaBarça
#FCBarcelona
@FCB_Adictos - #regrann"
        }
    }

    Rectangle {
        id: hide_photoCard

        height: 1205
        width: height*(3/2)
        anchors.top: root3.bottom
        anchors.left: root3.right
        border.width: 1
        anchors.margins: 0

        Image {
            id: hide_imgEnd

            fillMode: Image.PreserveAspectCrop
            height: parent.height-20
            source: "pic/606870.jpg"
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: hide_txtEnd

            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: hide_imgEnd.right
            anchors.right: parent.right
            anchors.margins: 10
            anchors.rightMargin: 10
            wrapMode: Text.WordWrap
            smooth: true
            minimumPixelSize: 11
            font.pixelSize: 20
            fontSizeMode: Text.Fit

            text: "@Regrann from @fcbarcelona - FC Barcelona away kit 17/18
THE SHIRT NEVER SLEEPS
La samarreta que mai no dorm.
La camiseta que nunca duerme.
nike.com/fcb www.tubarcelona.com
@PenyaFCBdeCCS
#FCBVenezuela #FCB
#D10S #MESSI #Suarez #Neimar #Futbol #Soccer #magia #TikiTaka #Iniesta #LaLiga #PeñaDeCaracas
#MesQueUnaPenya
#Barça #CCS
#CARACAS #PenyesFCB
#ForçaBarça
#FCBarcelona
@FCB_Adictos - #regrann"
        }
    }

    Rectangle {
        id: btnPrint

        anchors.top: photoCard.top
        anchors.bottom: photoCard.bottom
        anchors.left: photoCard.right
        anchors.right: bar.right
        anchors.leftMargin: 10

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                canvas.setColor("#CCCCCC")
            }

            onExited: {

                canvas.setColor("white")
            }

            onPressed: {
                canvas.setColor("#999999")
            }

            onReleased: {
                canvas.setColor("#CCCCCC")
            }
        }

        Canvas {
            id: canvas

            anchors.fill: parent

            property string colr: "white"

            function paintBtn(bgclr) {
                // get context to draw with
                var ctx = getContext("2d")
                ctx.clearRect(0, 0, width, height);
                // setup the stroke
                ctx.lineWidth = 1
                ctx.strokeStyle = "black"
                // setup the fill
                ctx.fillStyle = bgclr
                // begin a new path to draw
                ctx.beginPath()
                // top-left start point
                ctx.moveTo(0,0)
                ctx.lineTo(width-20,0)
                ctx.lineTo(width,height/2)
                ctx.lineTo(width-20,height)
                ctx.lineTo(0,height)
                // left line through path closing
                ctx.closePath()
                // fill using fill style
                ctx.fill()
                // stroke using line width and stroke style
                ctx.stroke()
                canvas.requestPaint();
            }

            function setColor(clr) {
                colr = clr
                paint(canvas)
            }

            Text {
                id: name

                text: "Печать"
                anchors.centerIn: parent
                font.pixelSize: 20
            }

            onPaint: {
                paintBtn(colr)
            }
        }

    }

    Rectangle {
        id: toolBar

        width: parent.width*95/100
        anchors.top: photoCard.bottom
        anchors.bottom: root3.bottom
        anchors.topMargin: 20
        anchors.bottomMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        border.width: 1

        Rectangle {
            id: click

            width: 50
            height: 25
            border.width: 1

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.margins: 20

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    //photoCard.height = 700
                    hide_photoCard.grabToImage(function(result) {result.saveToFile("something.png");});
                }
            }
        }
    }
}
