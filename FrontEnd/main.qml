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
                ListElement { sourceName: "frame1"; }
                ListElement { sourceName: "frame2"; }
                ListElement { sourceName: "frame3"; }
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
                    sourceComponent: sourceName
                }
            }
        }
    }

    Component {
        id: frame1

        Rectangle {
            id: root1

            anchors.fill: parent
            anchors.margins: 10

            Rectangle {
                id: labelText

                width: 550
                height: 35
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 50

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "(#) хештэг или (@) название профиля:"
                    font.pointSize: 20
                }
            }

            Rectangle {
                id: inputText

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 50
                anchors.rightMargin: 50
                height: 100
                anchors.top: labelText.bottom
                anchors.topMargin: 15
                border.width: 1

                TextInput {
                    id: intxt

                    anchors.fill: parent
                    font.pixelSize: 60
                    text: ""
                    cursorVisible: true
                    anchors.margins: 7

                    validator: RegExpValidator{
                        regExp: /^(@|#)\w*$/
                    }
                }
            }

            Rectangle {
                id: keyBoard

                anchors.top: inputText.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 15

                Column {
                    anchors.fill: parent
                    spacing: 3
                    Repeater {
                        model: theModel
                        Row {
                            spacing: 3
                            anchors.horizontalCenter: parent.horizontalCenter
                            Repeater {
                                model: modelData

                                Rectangle {
                                    width: ((root1.width-100-((11-1)*parent.parent.spacing))/11)*w
                                    height: width * h
                                    radius: 3
                                    border.color: "#000000"
                                    border.width: 1
                                    color: clr

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

                                    Text {
                                        id: textName

                                        anchors.centerIn: parent
                                        text: name
                                        font.pixelSize: 25
                                    }

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
                                                            instamat.firstFind(intxt.text)
                                                            lview.currentIndex = 1
                                                            parent.parent.item2Clicked()
                                                        }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            ListModel {
                id: theModel
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
    }

    Component {
        id: frame2

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
                        }
                    }
                }
            }
        }
    }

    Component {
        id: frame3

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
