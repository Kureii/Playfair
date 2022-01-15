import QtQuick 
import QtQuick.Controls
import QtQuick.Layouts 6.0
import QtQuick.Dialogs
import Qt5Compat.GraphicalEffects


Window {
    id: mainWindow
    visible: true
    width: 600
    height: 628
    color: "transparent"
    
    flags:  Qt.Window | Qt.WindowMinimizeButtonHint | Qt.FramelessWindowHint

    property string lang: "Language / Jazyk"
    property string eng: "English"
    property string cs: "Czech (Česky)"
    property string filename: ""
    property string textChoseFile: engCsTab.currentIndex == 0 ? "File unchosed" : "Soubor nevybrán"
    property string spcChar: "X"
    property string myInputText: ""
    property string illChar: ""
    property string myOpenText: ""
    property string myEncodeText: ""

    readonly property string alpha: "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    readonly property string solidEngAlpha: "ABCDEFGHIKLMNOPQRSTUVWXYZ"
    readonly property string solidCsVAlpha: "ABCDEFGHIJKLMNOPQRSTUVXYZ"
    readonly property string solidCsKAlpha: "ABCDEFGHIJKLMNOPRSTUVWXYZ"

    readonly property color myUpperBar: "#1a1512"
    readonly property color myBackground: "#201e1b"
    readonly property color myWhiteFont: "#e4f8ff"
    readonly property color myBackground2: "#acb1aa"
    readonly property color myHighLighht: "#3fa108"
    readonly property color myCloseImg: "#fcf8fe"
    readonly property color myCloseImgUnA: "#878589"
    readonly property color myCloseBtn: "#de2f05"

    property bool activeWindow: true
    property bool keyErr: false
    property bool emptyErr: false
    property bool err: false
    property bool err2: false
    property bool encOrDec: false

    property int spaceValue: 5
    property int rplSpcValue: 22
    property int repCount: 0

    readonly property var engAlpha: ["A","B","C","D","E","F","G","H","I","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"] 
    readonly property var csVAlpha: ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","X","Y","Z"] //cs V
    readonly property var csKAlpha: ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","R","S","T","U","V","W","X","Y","Z"] // cs K
    property var badChar: ["1","2"]
    
    function enableEncDec() {
        if (key.text == "") {
            emptyErr = true
            keyErr = true
            err = true
        } else if (alpha.substring(0 , key.text.length) == key.text) {
            emptyErr = false
            keyErr = true
            err = true
        } else if (solidEngAlpha.substring(0 , key.text.length) == key.text) {
            emptyErr = false
            keyErr = true
            err = true
        } else if (solidCsVAlpha.substring(0 , key.text.length) == key.text) {
            emptyErr = false
            keyErr = true
            err = true
        } else if (solidCsKAlpha.substring(0 , key.text.length) == key.text) {
            emptyErr = false
            keyErr = true
            err = true
        } else {
            emptyErr = false
            keyErr = false
            keyErrText.visible = false
            if (textFileTab.currentIndex == 0 && inputText.text == ""){
                err = true
            } else if (textFileTab.currentIndex == 1 && (fileState.color == myCloseBtn || fileState.text == textChoseFile)) {
                err = true
            } else {
                err = false
                keyErrText.visible = false
                spcCharErr.visible = false
                emptyInErr.visible = false
            }
        }  
    }

    function rplSpcSwitch(inAbc) {
        let myIn
        let myAbc = Array.from(inAbc)
        if (textFileTab.currentIndex) {
            myIn =  myInputText
        } else {
            myIn = inputText.text
        }
        if (myIn != "" && !encOrDec) {
            for (let i = 0; i < myIn.length; i++) {
                let index = myAbc.indexOf(myIn[i])
                if (index != -1) {
                    myAbc.splice(index, 1)
                }
            }
        }
        return myAbc
    }

    function rplSpcIndex() {
        let myAbc = []
        if (!engCsTab.currentIndex) {
            myAbc = rplSpcSwitch(engAlpha)
        } else {
            if (csVKTab.currentIndex) {
                myAbc = rplSpcSwitch(csKAlpha)
            } else {
                myAbc = rplSpcSwitch(csVAlpha)
            }
        }
        if (myAbc.includes(spcChar)) {
            return myAbc.indexOf(spcChar)
        } else {
            if (myAbc.length > 0) {
                spcChar = myAbc[0]
            } else {
                activeWindow = false
                let component = Qt.createComponent("Overflow.qml")
                let win = component.createObject()
            }
            rplSpcValue = 0
            return 0
        }

    }

    Flickable {
        anchors.fill: parent

        Rectangle {
            id: window
            color: myBackground2
            width: 600
            height: 428
            radius: 8
            border.color: myUpperBar
            border.width: 4
            anchors.fill: parent
            anchors.rightMargin: 12
            anchors.leftMargin: 12
            anchors.bottomMargin: 212
            anchors.topMargin: 12

            GridLayout {
                id: windowLayout
                anchors.fill: parent
                rowSpacing: 0
                columns: 1
                columnSpacing: 0
                
                //upperBar
                Rectangle {
                    width: 200
                    height: 200
                    color: myUpperBar
                    radius: 8
                    Layout.topMargin: 0
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    Layout.maximumHeight: 30
                    Layout.minimumHeight: 30
                    Layout.fillWidth: true
                    
                    Rectangle {
                        width: 200
                        height: 8
                        color: myUpperBar
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        anchors.bottomMargin: 0
                    }

                    RowLayout {
                        anchors.fill: parent

                        MouseArea {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            property variant clickPos: "1,1"
                            onPressed: {
                                if (activeWindow) {
                                    clickPos  = Qt.point(mouseX,mouseY)
                                }
                            }

                            onPositionChanged: {
                                if (activeWindow) {
                                    let delta = Qt.point(mouseX-clickPos.x, mouseY-clickPos.y)
                                    mainWindow.x += delta.x;
                                    mainWindow.y += delta.y;
                                }
                            }
                        }

                        RowLayout {
                            width: 52
                            Layout.rightMargin: 6
                            layoutDirection: Qt.LeftToRight
                            Layout.columnSpan: 2
                            Layout.fillWidth: false
                            Layout.fillHeight: true
                            spacing: 6

                            Button {
                                id: minimalise
                                width: 20
                                height: 20
                                flat: false
                                enabled: activeWindow
                                Layout.minimumWidth: 20
                                Layout.minimumHeight: 20
                                Layout.fillHeight: false
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                background: Rectangle{
                                    id: rectangle
                                    color: activeWindow ? (minimalise.pressed ? Qt.tint(Qt.lighter(myUpperBar, 2.5), "#100c03FF") : (minimalise.hovered ? Qt.tint(Qt.lighter(myUpperBar, 3), "#100c03FF") : myUpperBar)) : myUpperBar
                                    radius: 4
                                    Rectangle{
                                        width: 12
                                        height: 2
                                        color: minimalise.pressed ? Qt.darker(myCloseImg, 1.5) : myCloseImg
                                        anchors.bottom: parent.bottom
                                        anchors.bottomMargin: 4
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        radius: 1
                                    }

                                }
                                onClicked: mainWindow.showMinimized()

                            }

                            Button {
                                id: myClose
                                width: 20
                                height: 20
                                flat: true
                                enabled: activeWindow
                                Layout.minimumWidth: 20
                                Layout.minimumHeight: 20
                                Layout.fillHeight: false
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                                background: Rectangle{
                                    color: activeWindow ? (myClose.pressed ? Qt.darker(myCloseBtn, 1.5) : (myClose.hovered ? myCloseBtn : myUpperBar)) : myUpperBar
                                    radius: 4
                                    Rectangle{
                                        width: 16
                                        height: 2
                                        radius: 1
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        rotation: 45
                                        color: myClose.pressed ? Qt.darker(myCloseImg, 1.5) : myCloseImg
                                    }
                                    Rectangle{
                                        width: 16
                                        height: 2
                                        radius: 1
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        rotation: -45
                                        color: myClose.pressed ? Qt.darker(myCloseImg, 1.5) : myCloseImg
                                    }

                                }
                                onClicked: mainWindow.close()
                            }

                        }
                    }

                    Text {
                        y: 7
                        text: "Playfair"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        font.pixelSize: 12
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        anchors.leftMargin: 30
                        font.family: "Roboto Medium"
                        font.weight: Font.Medium
                        color: myWhiteFont
                    }

                    Image {
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        horizontalAlignment: Image.AlignLeft
                        source: "icons/TaskBar.svg"
                        anchors.leftMargin: 5
                        anchors.topMargin: 5
                        anchors.bottomMargin: 5
                        sourceSize.height: 20
                        sourceSize.width: 20
                    }
                }


                // lang
                Label {
                    color: myWhiteFont
                    text: lang
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    bottomPadding: 8
                    topPadding: 8
                    Layout.bottomMargin: 0
                    Layout.topMargin: 0
                    Layout.margins: 4
                    Layout.fillWidth: true
                    font.family: "Roboto Medium"
                    background: Rectangle {color: myBackground}
                }

                // lang
                TabBar {
                    id: engCsTab
                    height: 35
                    enabled: activeWindow
                    position: TabBar.Footer
                    currentIndex: 0
                    Layout.fillHeight: false
                    font.family: "Roboto Medium"
                    Layout.rightMargin: 4
                    Layout.leftMargin: 4
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.fillWidth: true

                    TabButton {
                        id: engBtn
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        bottomPadding: 18
                        padding: 8
                        background: Rectangle {
                            color: engBtn.hovered && activeWindow ? Qt.lighter( myBackground, 2) : myBackground
                            anchors.fill: parent
                            Label {
                                text: eng
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.verticalCenterOffset: engCsTab.currentIndex == 0 ? -2 : 0
                                anchors.horizontalCenter: parent.horizontalCenter
                                color: engBtn.hovered && activeWindow ? Qt.lighter(myWhiteFont, 2) : myWhiteFont
                            }

                            Rectangle {
                                height: 4
                                color: engCsTab.currentIndex == 0 ? myHighLighht : (engBtn.hovered && activeWindow ? Qt.lighter(myBackground, 2) : myBackground)
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.bottom: parent.bottom
                                anchors.rightMargin: 0
                                anchors.leftMargin: 0
                                anchors.bottomMargin: 0
                            }
                        }
                        onClicked: {
                            enableEncDec()
                            myData.getLang([0])
                            rplSpc.currentIndex = rplSpcValue
                            spcChar = csVAlpha[rplSpc.currentIndex]
                        }
                    }

                    TabButton {
                        id: csBtn
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        bottomPadding: 18
                        padding: 8
                        background: Rectangle {
                            color: csBtn.hovered && activeWindow ? Qt.lighter(myBackground,2) : myBackground
                            anchors.fill: parent
                            Label {
                                text: cs
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.verticalCenterOffset: engCsTab.currentIndex == 1 ? -2 : 0
                                anchors.horizontalCenter: parent.horizontalCenter
                                color: csBtn.hovered && activeWindow ? Qt.lighter(myWhiteFont, 2) : myWhiteFont
                            }

                            Rectangle {
                                height: 4
                                color: engCsTab.currentIndex == 1 ? myHighLighht : (csBtn.hovered && activeWindow ? Qt.lighter(myBackground, 2) : myBackground)
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.bottom: parent.bottom
                                anchors.rightMargin: 0
                                anchors.leftMargin: 0
                                anchors.bottomMargin: 0
                            }
                        }
                        onClicked: {
                            enableEncDec()
                            myData.getLang([1, csVKTab.currentIndex])
                            rplSpc.currentIndex = rplSpcValue
                            if (csVKTab.currentIndex == 0) {
                                spcChar = csVAlpha[rplSpc.currentIndex]
                            } else {
                                spcChar = csKAlpha[rplSpc.currentIndex]
                            }
                        }
                    }
                }

                GridLayout {
                    rowSpacing: 0
                    columnSpacing: 0
                    columns: 8
                    Layout.fillWidth: true
                    Layout.fillHeight: true


                    // grids
                    StackLayout {
                        width: 100
                        height: 100
                        currentIndex: engCsTab.currentIndex
                        Layout.maximumWidth: engCsTab.currentIndex === 0 ? 250 : 200
                        Layout.topMargin: 12
                        Layout.margins: 16
                        Layout.columnSpan: 3

                        Image {
                            width: 100
                            height: 100
                            source: "icons/BaseGrid.svg"
                            antialiasing: true
                            Layout.margins: 0
                            Layout.minimumHeight: 250
                            Layout.minimumWidth: 250
                            Layout.maximumWidth: 250
                            Layout.maximumHeight: 250
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            sourceSize.height: 500
                            sourceSize.width: 500
                            fillMode: Image.PreserveAspectFit

                            Image {
                                id: gridEng
                                width: 100
                                height: 100
                                source: "icons/EngGrid.svg"
                                antialiasing: true
                                cache: false
                                asynchronous: true
                                anchors.fill: parent
                                sourceSize.height: 500
                                sourceSize.width: 500
                                fillMode: Image.PreserveAspectFit
                            }
                        }

                        ColumnLayout {
                            width: 100
                            height: 100
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            spacing:0

                            StackLayout {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                currentIndex: csVKTab.currentIndex

                                Image {
                                    width: 100
                                    height: 100
                                    source: "icons/BaseGrid.svg"
                                    antialiasing: true
                                    Layout.margins: 0
                                    Layout.minimumHeight: 218
                                    Layout.minimumWidth: 218
                                    Layout.maximumWidth: 218
                                    Layout.maximumHeight: 218
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    sourceSize.height: 500
                                    sourceSize.width: 500
                                    fillMode: Image.PreserveAspectFit
                                    
                                    Image {
                                        id: gridCsV
                                        width: 100
                                        height: 100
                                        source: "icons/CsVGrid.svg"
                                        antialiasing: true
                                        cache: false
                                        asynchronous: true
                                        anchors.fill: parent
                                        sourceSize.height: 500
                                        sourceSize.width: 500
                                        fillMode: Image.PreserveAspectFit
                                    }
                                }

                                Image {
                                    width: 100
                                    height: 100
                                    source: "icons/BaseGrid.svg"
                                    antialiasing: true
                                    Layout.margins: 0
                                    Layout.minimumHeight: 218
                                    Layout.minimumWidth: 218
                                    Layout.maximumWidth: 218
                                    Layout.maximumHeight: 218
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    sourceSize.height: 500
                                    sourceSize.width: 500
                                    fillMode: Image.PreserveAspectFit

                                    Image {
                                        id: gridCsK
                                        width: 100
                                        height: 100
                                        source: "icons/CsKGrid.svg"
                                        antialiasing: true
                                        cache: false
                                        asynchronous: true
                                        anchors.fill: parent
                                        sourceSize.height: 500
                                        sourceSize.width: 500
                                        fillMode: Image.PreserveAspectFit
                                    }
                                }
                            }

                            TabBar {
                                id: csVKTab
                                height: 33
                                position: TabBar.Footer
                                Layout.minimumHeight: 33
                                Layout.maximumHeight: 33
                                Layout.topMargin: -20
                                Layout.bottomMargin : -1
                                currentIndex: 0
                                Layout.fillWidth: true
                                enabled: activeWindow
                                Layout.leftMargin: 0
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                                Layout.fillHeight: true
                                font.family: "Poppins Medium"
                                Layout.rightMargin: 0
                                TabButton {
                                    id: csVBtn
                                    anchors.top: parent.top
                                    anchors.bottom: parent.bottom
                                    padding: 8
                                    bottomPadding: 18
                                    background: Rectangle {
                                        color: csVBtn.hovered && activeWindow ? Qt.darker( myBackground2, 1.25) : myBackground2
                                        anchors.fill: parent
                                        Label {
                                            color: csVBtn.hovered && activeWindow ? Qt.lighter(myUpperBar, 2) : myUpperBar
                                            text: "W ❱❱ V"
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.verticalCenterOffset: csVKTab.currentIndex == 0 ? -2 : 0
                                            anchors.horizontalCenter: parent.horizontalCenter
                                        }

                                        Rectangle {
                                            height: 4
                                            color: csVKTab.currentIndex == 0 ? myHighLighht : (csVBtn.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) : myBackground2)
                                            anchors.left: parent.left
                                            anchors.right: parent.right
                                            anchors.bottom: parent.bottom
                                            anchors.rightMargin: 0
                                            anchors.leftMargin: 0
                                            anchors.bottomMargin: 0
                                        }
                                    }
                                    onClicked: {
                                        rplSpc.currentIndex = rplSpcValue
                                        enableEncDec()
                                    }
                                }

                                TabButton {
                                    id: csKBtn
                                    anchors.top: parent.top
                                    anchors.bottom: parent.bottom
                                    padding: 8
                                    bottomPadding: 18
                                    background: Rectangle {
                                        color: csKBtn.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) : myBackground2
                                        anchors.fill: parent
                                        Label {
                                            color: csKBtn.hovered && activeWindow ? Qt.lighter(myUpperBar, 2) : myUpperBar
                                            text: "Q ❱❱ K"
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.verticalCenterOffset: csVKTab.currentIndex == 1 ? -2 : 0
                                            anchors.horizontalCenter: parent.horizontalCenter
                                        }

                                        Rectangle {
                                            height: 4
                                            color: csVKTab.currentIndex == 1 ? myHighLighht : (csKBtn.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) : myBackground2)
                                            anchors.left: parent.left
                                            anchors.right: parent.right
                                            anchors.bottom: parent.bottom
                                            anchors.rightMargin: 0
                                            anchors.leftMargin: 0
                                            anchors.bottomMargin: 0
                                        }
                                    }
                                    onClicked: {
                                        rplSpc.currentIndex = rplSpcValue
                                        enableEncDec()
                                    }
                                }
                            }
                        }

                    }

                    ColumnLayout {
                        Layout.columnSpan: 5
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.leftMargin: engCsTab.currentIndex == 0 ? -4 : 16
                        Layout.margins: 16

                        // decoding or encoding
                        TabBar {
                            id: decEncBar
                            width: 240
                            height: 35
                            enabled: activeWindow
                            position: TabBar.Footer
                            font.family: "Roboto Medium"
                            Layout.topMargin: -6
                            Layout.rightMargin: 4
                            Layout.leftMargin: 4
                            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                            Layout.fillWidth: true

                            TabButton {
                                id: encTabButtno
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                bottomPadding: 18
                                padding: 8
                                background: Rectangle {
                                    color: encTabButtno.hovered
                                            && activeWindow ? Qt.darker(myBackground2, 1.25) : myBackground2
                                    anchors.fill: parent
                                    Label {
                                        text: engCsTab.currentIndex == 0 ? "Encode" : "Šifrovat"
                                        anchors.verticalCenter: parent.verticalCenter
                                        font.weight: Font.Medium
                                        font.family: "Poppins Medium"
                                        anchors.verticalCenterOffset: decEncBar.currentIndex == 0 ? 2 : 0
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        color: encTabButtno.hovered
                                                && activeWindow ? Qt.darker(myWhiteFont, 1.25) : myUpperBar
                                    }

                                    Rectangle {
                                        height: 4
                                        color: decEncBar.currentIndex == 0 ? myHighLighht : (encTabButtno.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) : 
                                                myBackground2)
                                        radius: 4
                                        anchors.left: parent.left
                                        anchors.right: parent.right
                                        anchors.top: parent.top
                                        anchors.rightMargin: 0
                                        anchors.leftMargin: 0
                                        anchors.topMargin: 0
                                    }
                                }
                                onClicked: {
                                    enableEncDec()
                                    encOrDec = false
                                }
                            }

                            TabButton {
                                id: decTabButton
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                bottomPadding: 18
                                padding: 8
                                background: Rectangle {
                                    color: decTabButton.hovered
                                            && activeWindow ? Qt.darker(myBackground2, 1.25) : myBackground2
                                    anchors.fill: parent
                                    Label {
                                        text: engCsTab.currentIndex == 0 ? "Decode" : "Dešifrovat"
                                        anchors.verticalCenter: parent.verticalCenter
                                        font.weight: Font.Medium
                                        font.family: "Poppins Medium"
                                        anchors.verticalCenterOffset: decEncBar.currentIndex == 1 ? 2 : 0
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        color: decTabButton.hovered
                                                && activeWindow ? Qt.darker(myWhiteFont, 1.25) : myUpperBar
                                    }

                                    Rectangle {
                                        height: 4
                                        color: decEncBar.currentIndex == 1 ? myHighLighht : (decTabButton.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) : 
                                                myBackground2)
                                        anchors.left: parent.left
                                        anchors.right: parent.right
                                        anchors.top: parent.top
                                        anchors.rightMargin: 0
                                        anchors.leftMargin: 0
                                        anchors.topMargin: 0
                                    }
                                }
                                onClicked: {
                                    enableEncDec()
                                    encOrDec = true
                                }
                            }
                        } 

                        // key
                        TextField {
                            id: key
                            selectByMouse: true
                            color: myUpperBar
                            enabled: activeWindow
                            horizontalAlignment: Text.AlignHCenter
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.leftMargin: 0
                            font.capitalization: Font.AllUppercase
                            font.family: "Poppins Medium"
                            placeholderTextColor: Qt.lighter(myUpperBar, 2)
                            placeholderText: engCsTab.currentIndex == 0 ? "KEY" : "KLÍČ"
                            validator: RegularExpressionValidator { regularExpression:  /^[a-zA-Zá-žÁ-Ž]+$/ }
                            Layout.rightMargin: 0
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Layout.maximumHeight: 24
                            background: Rectangle {
                                color: myBackground2
                                border.width: 1
                                border.color: Qt.darker(myBackground2, 1.1)
                                radius: 8
                            }
                            onTextChanged: {
                                keyErrText.visible = false
                                if(key.text != "") {
                                    let tmp = key.cursorPosition
                                    keyErr = false
                                    emptyErr = false
                                    let myKey = key.text
                                    myKey = myKey.normalize("NFD").replace(/[\u0300-\u036f]/g, "")
                                    myKey = myKey.replace(" ", "")
                                    myKey = myKey.toUpperCase()
                                    key.text = myKey
                                    enableEncDec()
                                    key.cursorPosition = tmp
                                    if(!keyErr){
                                        myData.getKey(myKey)
                                        gridEng.source = ""
                                        gridCsV.source = ""
                                        gridCsK.source = ""
                                        gridEng.source = "icons/EngGrid.svg"
                                        gridCsV.source = "icons/CsVGrid.svg"
                                        gridCsK.source = "icons/CsKGrid.svg"
                                    } else {
                                        keyErrText.visible = true
                                    }
                                }
                            }
                        }

                        // Err: char in input
                        Label {
                            id: keyErrText
                            text: emptyErr ? (engCsTab.currentIndex ? "Prázdný klíč." : "Empty key") : (engCsTab.currentIndex ? "Klíč je stejný jako abeceda." : "Key is same like alphabet." )
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Layout.topMargin: -4
                            visible: false
                            font.pixelSize: 12
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            font.family: "Poppins Medium"
                            color: myCloseBtn
                        }

                        // file / text
                        StackLayout {
                            width: 200
                            height: 100
                            Layout.minimumHeight: 100
                            Layout.maximumHeight: 100
                            Layout.fillWidth: true
                            Layout.fillHeight: false
                            currentIndex: textFileTab.currentIndex

                            Flickable {
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                TextArea.flickable: TextArea {
                                    id: inputText
                                    visible: true
                                    selectByMouse: true
                                    color: myWhiteFont
                                    enabled: activeWindow
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    wrapMode: Text.WrapAnywhere
                                    textFormat: Text.AutoText
                                    placeholderTextColor: Qt.darker(myWhiteFont, 2)
                                    font.family: "Roboto Medium"
                                    font.hintingPreference: Font.PreferFullHinting
                                    font.capitalization: Font.AllUppercase
                                    placeholderText: engCsTab.currentIndex == 0 ? "TEXT HERE" : "PIŠTE SEM"
                                    background: Rectangle {
                                        color: myBackground
                                        radius: 8
                                    }
                                    onTextChanged: {
                                        
                                            spcCharErr.visible = false
                                            let tmp = inputText.cursorPosition
                                            let nl = false
                                            if (inputText.text.includes("\n") || inputText.text.includes("\t")) {
                                                inputText.text = inputText.text.replace("\n", "")
                                                inputText.text = inputText.text.replace("\t", "")
                                                nl = true
                                            }
                                            let myinputText = inputText.text
                                            myinputText = myinputText.normalize("NFD").replace(/[\u0300-\u036f]/g, "")
                                            myinputText = myinputText.toUpperCase()
                                            inputText.text = myinputText
                                            if (nl) {
                                                inputText.cursorPosition = tmp - 1
                                            } else {
                                                inputText.cursorPosition = tmp
                                            }
                                            myData.getRepSpc(spcChar)
                                            rplSpc.currentIndex = rplSpcIndex()
                                            enableEncDec()
                                        
                                    }
                                }
                                ScrollBar.vertical: ScrollBar {}

                            }

                            ColumnLayout {
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillWidth: true
                                Layout.fillHeight: true

                                Button {
                                    id: btnChoseFile
                                    enabled: activeWindow
                                    Layout.topMargin: 16
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    background: Rectangle {
                                        anchors.fill: parent
                                        color: btnChoseFile.down ? myHighLighht : (btnChoseFile.hovered && activeWindow ? Qt.lighter(myBackground, 2) : myBackground)
                                        radius: 8

                                        Label {
                                            text: engCsTab.currentIndex == 0 ? "Chose file" : "Vyberte soubor"
                                            anchors.fill: parent
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                            font.family: "Roboto Medium"
                                            color: myWhiteFont
                                        }
                                    }
                                    onClicked: {
                                        fileDialog.visible = true
                                        if (spcCharErr.visible || keyErrText.visible) {err = true} else {err = false}
                                    }
                                }


                                Label {
                                    id: fileState
                                    Layout.fillWidth: true
                                    text: textChoseFile
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    topPadding: 8
                                    bottomPadding: 16
                                    font.family: "Poppins Medium"
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    color: myUpperBar
                                }
                                
                            }
                
                        }

                        // text / file button tab
                        TabBar {
                            id: textFileTab
                            width: 240
                            height: 35
                            enabled: activeWindow
                            position: TabBar.Footer
                            font.family: "Roboto Medium"
                            Layout.topMargin: -6
                            Layout.rightMargin: 4
                            Layout.leftMargin: 4
                            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                            Layout.fillWidth: true

                            TabButton {
                                id: textButtno
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                bottomPadding: 18
                                padding: 8
                                background: Rectangle {
                                    color: textButtno.hovered
                                            && activeWindow ? Qt.darker(myBackground2, 1.25) : myBackground2
                                    anchors.fill: parent
                                    Label {
                                        text: "Text"
                                        anchors.verticalCenter: parent.verticalCenter
                                        font.weight: Font.Medium
                                        font.family: "Poppins Medium"
                                        anchors.verticalCenterOffset: textFileTab.currentIndex == 0 ? 2 : 0
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        color: textButtno.hovered
                                                && activeWindow ? Qt.darker(myWhiteFont, 1.25) : myUpperBar
                                    }

                                    Rectangle {
                                        height: 4
                                        color: textFileTab.currentIndex == 0 ? myHighLighht : (textButtno.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) : 
                                                myBackground2)
                                        radius: 4
                                        anchors.left: parent.left
                                        anchors.right: parent.right
                                        anchors.top: parent.top
                                        anchors.rightMargin: 0
                                        anchors.leftMargin: 0
                                        anchors.topMargin: 0
                                    }
                                }
                                onClicked: {
                                    myData.getInputIndex(textFileTab.currentIndex)
                                    if(inputText.text != "") {
                                        myData.getInput(inputText.text)
                                    }
                                    enableEncDec()
                                }
                            }

                            TabButton {
                                id: fileButton
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                bottomPadding: 18
                                padding: 8
                                background: Rectangle {
                                    color: fileButton.hovered
                                            && activeWindow ? Qt.darker(myBackground2, 1.25) : myBackground2
                                    anchors.fill: parent
                                    Label {
                                        text: engCsTab.currentIndex == 0 ? "File" : "Soubor"
                                        anchors.verticalCenter: parent.verticalCenter
                                        font.weight: Font.Medium
                                        font.family: "Poppins Medium"
                                        anchors.verticalCenterOffset: textFileTab.currentIndex == 1 ? 2 : 0
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        color: fileButton.hovered
                                                && activeWindow ? Qt.darker(myWhiteFont, 1.25) : myUpperBar
                                    }

                                    Rectangle {
                                        height: 4
                                        color: textFileTab.currentIndex == 1 ? myHighLighht : (fileButton.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) : 
                                                myBackground2)
                                        anchors.left: parent.left
                                        anchors.right: parent.right
                                        anchors.top: parent.top
                                        anchors.rightMargin: 0
                                        anchors.leftMargin: 0
                                        anchors.topMargin: 0
                                    }
                                }
                                onClicked: {
                                    myData.getInputIndex(textFileTab.currentIndex)
                                    emptyInErr.visible = false
                                    spcCharErr.visible = false
                                    if (fileState.text != textChoseFile) {
                                        myData.getInput(fileDialog.currentFile)
                                    }
                                    enableEncDec()
                                }
                            }
                        } 

                        //empty err
                        Label {
                            id: emptyInErr
                            text: engCsTab.currentIndex ? "Není zadán vstupní text." : "Input text missing"
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Layout.topMargin: -8
                            visible: false
                            font.pixelSize: 12
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            font.family: "Poppins Medium"
                            color: myCloseBtn
                        }
                        // replace spaces
                        RowLayout {
                            Layout.columnSpan: 5
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            
                            Label {
                                text: engCsTab.currentIndex ? "Doplňkový znak:" : "Supplement characer:" 
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                font.pixelSize: 12
                                horizontalAlignment: Text.AlignRight
                                verticalAlignment: Text.AlignVCenter
                                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                font.family: "Poppins Medium"
                                color: myUpperBar
                            }

                            ComboBox {
                                id: rplSpc
                                Layout.minimumHeight: 24
                                Layout.maximumHeight: 24
                                Layout.minimumWidth: 48
                                Layout.rightMargin: engCsTab.currentIndex == 0 ? 60 : 76
                                Layout.maximumWidth: 48
                                Layout.fillWidth: true
                                currentIndex: rplSpcIndex()
                                font.family: "Poppins Medium"
                                model: engCsTab.currentIndex == 0 ? rplSpcSwitch(engAlpha) : (csVKTab.currentIndex == 0 ? rplSpcSwitch(csVAlpha) : rplSpcSwitch(csKAlpha))
                                
                                delegate: ItemDelegate {
                                    width: rplSpc.width - 10
                                    height: 22
                                    contentItem: Text {
                                        text: modelData
                                        color: myWhiteFont
                                        elide: Text.ElideRight
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        anchors.topMargin: -628
                                        anchors.bottomMargin: -15
                                        anchors.leftMargin: -600
                                        anchors.rightMargin: -71
                                        anchors.horizontalCenter: mainWindow.horizontalCenter
                                        font.family: "Roboto Medium"
                                    }
                                    highlighted: rplSpc.highlightedIndex === index
                                    Component.onCompleted: {
                                        background.color =  myBackground
                                        background.radius = 6
                                    }
                                    Binding {
                                        target: background
                                        property: "color"
                                        value: highlighted ? myHighLighht : myBackground
                                    }                                    
                                }

                                indicator: Image {
                                    anchors.verticalCenter: rplSpc.verticalCenter
                                    anchors.right: rplSpc.right
                                    source: "icons/UpDown.svg"
                                    anchors.rightMargin: 6
                                    sourceSize.height: 10
                                    sourceSize.width: 10
                                    fillMode: Image.Pad                                        
                                        
                                }

                                contentItem: Text {
                                    text: rplSpc.displayText
                                    font: rplSpc.font
                                    color: rplSpc.pressed ? myBackground : myUpperBar
                                    verticalAlignment: Text.AlignVCenter
                                    anchors.horizontalCenter: rplSpc.horizontalCenter
                                    elide: Text.ElideRight
                                    anchors.verticalCenter: rplSpc.verticalCenter
                                    
                                }

                                background: Rectangle {
                                    implicitWidth: 100
                                    implicitHeight: 25
                                    border.color: rplSpc.pressed ? myBackground2 : Qt.darker(myBackground2, 1.1)
                                    border.width: rplSpc.visualFocus ? 2 : 1
                                    radius: 8
                                    color: myBackground2
                                }

                                popup: Popup {
                                    y: rplSpc.height
                                    width: rplSpc.width
                                    implicitHeight: contentItem.implicitHeight
                                    padding: 5
                                    contentItem: ListView {
                                        clip: true
                                        implicitHeight: contentHeight + 10
                                        model: rplSpc.popup.visible ? rplSpc.delegateModel : null
                                        currentIndex: rplSpc.highlightedIndex
                                        //ScrollIndicator.vertical: ScrollIndicator {active: false}
                                    }                                        

                                    background: Rectangle {
                                        border.width: 1
                                        border.color: myHighLighht
                                        radius:8
                                        color: myBackground
                                    }
                                }

                                onActivated: {
                                    spcCharErr.visible = false
                                    rplSpcValue = rplSpc.currentIndex
                                    if (engCsTab.currentIndex == 0) {
                                        spcChar = engAlpha[rplSpc.currentIndex]
                                    } else {
                                        if (csVKTab.currentIndex == 0) {
                                            spcChar = csVAlpha[rplSpc.currentIndex]
                                        } else {
                                            spcChar = csKAlpha[rplSpc.currentIndex]
                                        }
                                    }
                                    myData.getRepSpc(spcChar)
                                    if (rplSpcValue != 0 && keyErrText.visible == false){
                                        if (inputText.text.includes(spcChar) || myInputText.includes(spcChar)) {
                                            spcCharErr.visible = true
                                        } else if (engCsTab.currentIndex == 0 && spcChar == "I" ) {
                                            if (inputText.text.includes("J") || myInputText.includes("J")) {
                                                spcCharErr.visible = true
                                            }
                                        } else {
                                            if (csVKTab.currentIndex == 0 && spcChar == "K") {
                                                if (inputText.text.includes("Q") || myInputText.includes("Q")) {
                                                    spcCharErr.visible = true
                                                }
                                            } else if (spcChar == "V"){
                                                if (inputText.text.includes("W") || myInputText.includes("W")) {
                                                    spcCharErr.visible = true
                                                }
                                            }
                                        }
                                    }
                                    enableEncDec()
                                }
                            }
                        }

                        // Err: char in input
                        Label {
                            id: spcCharErr
                            text: engCsTab.currentIndex ? (csVKTab.currentIndex == 0 ? "Znak pro náhradu mezer je ve vstupu. (W ❱❱ V)" : 
                                        "Znak pro náhradu mezer je ve vstupu. (Q ❱❱ K)") : "Character for replace spaces is in input. (J ❱❱ I)" 
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Layout.topMargin: -8
                            visible: false
                            font.pixelSize: 12
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            font.family: "Poppins Medium"
                            color: myCloseBtn
                        }


                        // devide spaces
                        RowLayout {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Layout.maximumHeight: 50

                            Label {
                                text: engCsTab.currentIndex == 0 ? "Output devide by" :"Výstup dělit po"
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                font.pixelSize: 12
                                horizontalAlignment: Text.AlignRight
                                verticalAlignment: Text.AlignVCenter
                                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                font.family: "Poppins Medium"
                                color: myUpperBar
                            }

                            SpinBox {
                                    id: spaceSpin
                                    font.family: "Poppins Medium"
                                    Layout.maximumWidth: 100
                                    Layout.minimumWidth: 65
                                    Layout.maximumHeight: 24
                                    Layout.minimumHeight: 24
                                    enabled: activeWindow
                                    value: spaceValue
                                    stepSize: 1
                                    to: 99
                                    from: 0
                                    background: Rectangle {
                                        color: myBackground2
                                        border.color: Qt.darker(myBackground2, 1.1)
                                        border.width: .5
                                        anchors.fill: parent
                                        radius: 8
                                    }
                                    down.indicator: Rectangle {
                                        height: 20
                                        width: 20
                                        anchors.left: parent.left
                                        anchors.right: parent.right
                                        anchors.verticalCenterOffset: 0
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.leftMargin: 3
                                        anchors.rightMargin: 44
                                        radius: 8
                                        color: spaceSpin.down.pressed ? myHighLighht : (spaceSpin.down.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) :
                                                    myBackground2)

                                        Rectangle {
                                            width: 8
                                            color: spaceSpin.down.pressed ? myHighLighht : (spaceSpin.down.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) : 
                                                    myBackground2)
                                            anchors.right: parent.right
                                            anchors.top: parent.top
                                            anchors.bottom: parent.bottom
                                            anchors.topMargin: 0
                                            anchors.bottomMargin: 0
                                            anchors.rightMargin: 0
                                        }

                                        Text {
                                            text: '❰'
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                            padding: 0
                                            font.pixelSize: 18
                                            font.family: "Poppins Medium"
                                            font.weight: Font.Medium
                                        }
                                    }

                                    up.indicator: Rectangle {
                                        height: 20
                                        width: 20
                                        radius: 8
                                        anchors.left: parent.left
                                        anchors.right: parent.right
                                        anchors.verticalCenterOffset: 0
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.leftMargin: 44
                                        anchors.rightMargin: 3
                                        color: spaceSpin.up.pressed ? myHighLighht : (spaceSpin.up.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) :
                                                    myBackground2)

                                        Rectangle {
                                            width: 8
                                            color: spaceSpin.up.pressed ? myHighLighht : (spaceSpin.up.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) :
                                                        myBackground2)
                                            anchors.left: parent.left
                                            anchors.top: parent.top
                                            anchors.bottom: parent.bottom
                                            anchors.bottomMargin: 0
                                            anchors.leftMargin: 0
                                            anchors.topMargin: 0
                                        }

                                        Text {
                                            text: '❱'
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                            padding: 0
                                            font.pixelSize: 18
                                            font.family: "Poppins Medium"
                                            font.weight: Font.Medium
                                        }
                                    }
                                    onValueChanged: {
                                        spaceValue = spaceSpin.value
                                        myData.getSpaces(spaceValue)
                                        enableEncDec()
                                    }
                                }

                            Label {
                                text: engCsTab.currentIndex == 0 ? "characters." : "znacích."
                                Layout.rightMargin: 20
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                font.pixelSize: 12
                                horizontalAlignment: Text.AlignLeft
                                verticalAlignment: Text.AlignVCenter
                                font.family: "Poppins Medium"
                                color: myUpperBar
                            }
                        }
                    }
                }
                
                //encode decode buttons
                RowLayout {
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.bottomMargin: 16
                    Layout.leftMargin: 12
                    Layout.rightMargin: 12
                    Layout.minimumHeight: 35
                    Layout.topMargin: -8

                    //encode btn
                    Button {
                        id: encBtn
                        enabled: activeWindow
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.rightMargin: -3
                        background: Rectangle {
                            anchors.fill: parent
                            color: encBtn.down ? myHighLighht : (encBtn.hovered && activeWindow ? Qt.lighter(myBackground, 2) : myBackground)
                            radius: 8

                            Label {
                                text: encOrDec ?  (engCsTab.currentIndex ? "Dešifrovat" : "Decode"):(engCsTab.currentIndex ? "Šifrovat" : "Encode")
                                anchors.fill: parent
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.family: "Roboto Medium"
                                color: myWhiteFont
                            }
                        }
                        onClicked: {
                            enableEncDec()
                            
                            if (!encOrDec) { // encoding
                                if(!err) {
                                    let itsOK = false
                                    let myIn =""
                                    if (textFileTab.currentIndex) {
                                        myIn = myInputText
                                    } else {
                                        myIn = inputText.text
                                    }
                                    myData.getInputIndex(textFileTab.currentIndex)

                                    if (inputText.text.includes(spcChar)) {
                                        spcCharErr.visible = true
                                        err = true
                                    } else if (engCsTab.currentIndex == 0 && spcChar == "I" ) {
                                        if (inputText.text.includes("J")) {
                                            spcCharErr.visible = true
                                            err = true
                                        }
                                    } else if (engCsTab.currentIndex && csVKTab.currentIndex == 0 && spcChar == "K") {
                                        if (inputText.text.includes("Q")) {
                                            spcCharErr.visible = true
                                            err = true
                                        }
                                    } else if (engCsTab.currentIndex && csVKTab.currentIndex && spcChar == "V"){
                                        if (inputText.text.includes("W")) {
                                            spcCharErr.visible = true
                                            err = true
                                        }
                                    } else {
                                        err = false
                                        keyErrText.visible = false
                                        spcCharErr.visible = false
                                        emptyInErr.visible = false
                                    }
                                    if (!err) {
                                        if(textFileTab.currentIndex == 0) {
                                            inputText.text = inputText.text.replace("\n", "")
                                            inputText.text = inputText.text.replace("\t", "")
                                            myData.getInput(inputText.text.toUpperCase())
                                        }
                                        myData.encode()
                                        if (repCount == 0) {
                                            activeWindow = false
                                            winSol.show()
                                        } else {
                                            activeWindow = false
                                            let component = Qt.createComponent("Repair.qml")
                                            let win = component.createObject()
                                            win.crComp()
                                        }
                                    }
                                } else {
                                    if (!key.text) {
                                        keyErrText.visible = true
                                    } else if (!spcCharErr.visible &&! keyErrText.visible) {
                                        emptyInErr.visible = true
                                    }
                                }
                            } else { // decoding
                                if(!err) {
                                    myData.getInputIndex(textFileTab.currentIndex)
                                    if(textFileTab.currentIndex == 0) {
                                        myData.getInput(inputText.text.toUpperCase())
                                    }
                                    myData.decode()
                                    if (repCount == 0) {
                                        winSol.show()
                                    }
                                } else {
                                    if (!key.text) {
                                        keyErrText.visible = true
                                    } else if (!spcCharErr.visible) {
                                        emptyInErr.visible = true
                                    }
                                }
                            }
                        }
                    }

                    
                    
                    WinSol {
                        id: winSol
                        visible: false
                    }
                }
            }
        }

        Rectangle {
            id: windowGlow
            color: "#cf018500"
            radius: 8
            anchors.fill: window
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0
            z: -1
        }
        FastBlur {
            anchors.fill: windowGlow
            radius: 12
            transparentBorder: true
            source: windowGlow
            z: -1
        }
        HueSaturation {
            anchors.fill: window
            source: window
            saturation: activeWindow ? 0 : -.75
            lightness: activeWindow ? 0 : -0.25
        }
        HueSaturation {
            anchors.fill: windowGlow
            source: windowGlow
            saturation: activeWindow ? 0 : -.85
            lightness: activeWindow ? 0 : -0.25
            z: -1
        }

        FileDialog {
            id: fileDialog
            visible: false
            nameFilters: [ "Text files (*.txt)"]
            onAccepted: {
                fileState.text = textChoseFile
                fileState.color = myUpperBar
                let url = String(fileDialog.currentFile)
                let index = 0
                let urlCh = url.split("")
                for (let i =0; i <url.length; i++){
                    if(urlCh[i] === "/") {index = i + 1;}
                }
                let filename = url.substring(index);
                fileState.text = filename
                myData.getInput(url)
                if (myInputText == ""){
                    fileState.text = engCsTab.currentIndex == 0 ? "File is empty." : "Soubor je prázný."
                    fileState.color = myCloseBtn
                } else {
                    myInputText = myInputText.normalize("NFD").replace(/[\u0300-\u036f]/g, "")
                    myInputText = myInputText.toUpperCase()
                    if (myInputText.includes(spcChar)) {
                        spcCharErr.visible = true
                    } else if (engCsTab.currentIndex == 0 && spcChar == "I") {
                        if (myInputText.includes("J")) {
                            spcCharErr.visible = true
                        }
                    } else {
                        if (csVKTab.currentIndex == 0 && spcChar == "K") {
                            if (myInputText.includes("Q")) {
                                spcCharErr.visible = true
                            }
                        } else {
                            if (spcChar == "V" && myInputText.includes("W")) {
                                spcCharErr.visible = true
                            }
                        }
                    }
                    myData.getInputIndex(0)
                    myData.getInput(myInputText)
                    rplSpc.currentIndex = rplSpcIndex()
                }
                enableEncDec()

            }
            onRejected: {
                fileState.text = textChoseFile
                myInputText = ""
                enableEncDec()
            }
        } 


        Connections {
            target: myData
            function onMyInputText(myI) {
                myInputText = myI
            }

            function onOpenText(opT) {
                myOpenText = opT
            }

            function onEncodeText(enTe) {
                myEncodeText = enTe
            }

            function onIllegalChars(ilCH) {
                badChar = ilCH
            }

            function onRepCount(rC){
                repCount = rC
            }

            function onErr2(er) {
                err2 = er
            }
        }
    }
}
