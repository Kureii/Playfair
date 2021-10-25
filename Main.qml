import QtQuick 
import QtQuick.Controls
import QtQuick.Layouts 6.0
import QtQuick.Dialogs

Window {
    id: mainWindow
    visible: true
    width: 600
    height: 628
    color: "transparent"
    
    flags:  Qt.Window | Qt.WindowMinimizeButtonHint | Qt.FramelessWindowHint

    property string windowTitle: "Playfair"
    property string lang: "Language / Jazyk"
    property string eng: "English"
    property string cs: "Czech (Česky)"
    property string filename: ""
    property string textChoseFile: engCsTab.currentIndex == 0 ? "File unchosed" : "Soubor nevybrán"

    readonly property color myUpperBar: "#1a1512"
    readonly property color myBackground: "#201e1b"
    readonly property color myWhiteFont: "#e4f8ff"
    readonly property color myBackground2: "#acb1aa"
    readonly property color myHighLighht: "#3fa108"
    readonly property color myCloseImg: "#fcf8fe"
    readonly property color myCloseImgUnA: "#878589"
    readonly property color myCloseBtn: "#de2f05"

    property bool activeWindow: true

    property int spaceValue: 5

    

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
                                clickPos  = Qt.point(mouseX,mouseY)
                            }

                            onPositionChanged: {
                                var delta = Qt.point(mouseX-clickPos.x, mouseY-clickPos.y)
                                mainWindow.x += delta.x;
                                mainWindow.y += delta.y;
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
                                Layout.minimumWidth: 20
                                Layout.minimumHeight: 20
                                Layout.fillHeight: false
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                background: Rectangle{
                                    id: rectangle
                                    color: minimalise.pressed ? Qt.tint(Qt.lighter(myUpperBar, 2.5), "#100c03FF") : (minimalise.hovered ? Qt.tint(Qt.lighter(myUpperBar, 3), "#100c03FF") : myUpperBar)
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
                                Layout.minimumWidth: 20
                                Layout.minimumHeight: 20
                                Layout.fillHeight: false
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                                background: Rectangle{
                                    color: myClose.pressed ? Qt.darker(myCloseBtn, 1.5) : (myClose.hovered ? myCloseBtn : myUpperBar)
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
                        id: titleWindow
                        y: 7
                        text: windowTitle
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
                    }
                }

                GridLayout {
                    rowSpacing: 0
                    columnSpacing: 0
                    columns: 8
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    StackLayout {
                        width: 100
                        height: 100
                        currentIndex: engCsTab.currentIndex
                        Layout.maximumWidth: engCsTab.currentIndex === 0 ? 250 : 200
                        Layout.topMargin: 12
                        Layout.margins: 16
                        Layout.columnSpan: 3


                        Image {
                            id: gridEng
                            width: 100
                            height: 100
                            source: "icons/EngGrid.svg"
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
                                    id: gridCsV
                                    width: 100
                                    height: 100
                                    source: "icons/CsVGrid.svg"
                                    Layout.minimumHeight: 218
                                    Layout.minimumWidth: 218
                                    Layout.maximumWidth: 218
                                    Layout.maximumHeight: 218
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    sourceSize.height: 500
                                    sourceSize.width: 500
                                    fillMode: Image.PreserveAspectFit
                                }

                                Image {
                                    id: gridCsK
                                    width: 100
                                    height: 100
                                    source: "icons/CSKGrid.svg"
                                    Layout.minimumHeight: 218
                                    Layout.minimumWidth: 218
                                    Layout.maximumWidth: 218
                                    Layout.maximumHeight: 218
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    sourceSize.height: 500
                                    sourceSize.width: 500
                                    fillMode: Image.PreserveAspectFit
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
                                            text: "V ❱❱ W"
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
                                }
                                Layout.fillWidth: true
                                enabled: activeWindow
                                Layout.leftMargin: 0
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                                Layout.fillHeight: true
                                font.family: "Poppins Medium"
                                Layout.rightMargin: 0
                            }
                        }

                    }

                    ColumnLayout {
                        Layout.columnSpan: 5
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.leftMargin: engCsTab.currentIndex == 0 ? -4 : 16
                        Layout.margins: 16



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
                            onEditingFinished: {

                            }
                        }

                        RowLayout {
                            Layout.columnSpan: 5
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            
                            Label {
                                text: engCsTab.currentIndex ? "Znak pro náhradu mezer" : "Char for replace spaces" 
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
                                Layout.minimumHeight: 32
                                Layout.maximumHeight: 32
                                Layout.minimumWidth: 130
                                Layout.rightMargin: engCsTab.currentIndex == 0 ? 0 :14
                                Layout.maximumWidth: 130
                                Layout.fillWidth: true
                                currentIndex: 0
                                font.family: "Poppins Medium"
                                model: engCsTab.currentIndex == 0 ? 
                                    ["WHITOUT SPACES","A","B","C","D","E","F","G","H","I","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"] : //eng 
                                    (csVKTab.currentIndex == 0 ? 
                                    ["BEZ MEZER","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","X","Y","Z"] : //cs V
                                    ["BEZ MEZER","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","R","S","T","U","V","W","X","Y","Z"]) // cs K
                                
                                delegate: ItemDelegate {
                                    width: rplSpc.width
                                    contentItem: Text { //combobox menu 
                                        text: modelData
                                        color: myWhiteFont
                                        elide: Text.ElideRight
                                        verticalAlignment: Text.AlignVCenter
                                        font.family: "Roboto Medium"
                                    }
                                    highlighted: rplSpc.highlightedIndex === index
                                    Component.onCompleted: background.color =  myBackground
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
                                    y: rplSpc.height - 1
                                    width: rplSpc.width
                                    implicitHeight: contentItem.implicitHeight
                                    padding: 1
                                    contentItem: ListView {
                                        clip: true
                                        implicitHeight: contentHeight
                                        model: rplSpc.popup.visible ? rplSpc.delegateModel : null
                                        currentIndex: rplSpc.highlightedIndex
                                        ScrollIndicator.vertical: ScrollIndicator {active: true}
                                    }                                        

                                    background: Rectangle {
                                        border.color: Qt.darker(myBackground2, 1.1)
                                        radius: 8
                                        color: myBackground2
                                    }
                                }

                                onAccepted: {
                                }
                            }
                        }

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
                                    onEditingFinished: {
                                        console.log("edited")
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
                                    onClicked: fileDialog.visible = true
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
                            }
                        } 

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
                                    }
                                }

                            Label {
                                text: engCsTab.currentIndex == 0 ? "chars." : "znacích."
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

                RowLayout {
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.bottomMargin: 16
                    Layout.leftMargin: 12
                    Layout.rightMargin: 12
                    Layout.minimumHeight: 35
                    Layout.topMargin: -8

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
                                text: "Encode"
                                anchors.fill: parent
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.family: "Roboto Medium"
                                color: myWhiteFont
                            }

                            Rectangle {
                                width: 16
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                anchors.rightMargin: 0
                                anchors.topMargin: 0
                                anchors.bottomMargin: 0
                                color: encBtn.down ? myHighLighht : (encBtn.hovered && activeWindow ? Qt.lighter(myBackground, 2) : myBackground)
                            }
                        }
                        onClicked: console.log("encode")
                    }

                    Button {
                        id: decBtn
                        enabled: activeWindow
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.leftMargin: -3
                        background: Rectangle {
                            anchors.fill: parent
                            color: decBtn.down ? myHighLighht : (decBtn.hovered && activeWindow ? Qt.lighter(myBackground, 2) : myBackground)
                            radius: 8

                            Label {
                                text: "Decode"
                                anchors.fill: parent
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.family: "Roboto Medium"
                                color: myWhiteFont
                            }

                            Rectangle {
                                width: 16
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                anchors.leftMargin: 0
                                anchors.topMargin: 0
                                anchors.bottomMargin: 0
                                color: decBtn.down ? myHighLighht : (decBtn.hovered && activeWindow ? Qt.lighter(myBackground, 2) : myBackground)
                            }
                        }
                        onClicked: console.log("decode")
                    }
                }
            }
        }

        FileDialog {
            id: fileDialog
            visible: false
            nameFilters: [ "Text files (*.txt)"]
            onAccepted: {
                var url = String(fileDialog.currentFile)
                var index = 0
                var urlCh = url.split("")
                for (let i =0; i <url.length; i++){
                    if(urlCh[i] === "/") {index = i + 1;}
                }
                var filename = url.substring(index);
                fileState.text = filename

            }
            onRejected: {
                fileState.text = textChoseFile
            }

        } 
    }
}
