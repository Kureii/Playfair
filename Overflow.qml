import QtQuick
import QtQuick.Controls
import QtQuick.Layouts 6.0
import QtQml.Models 2.2
import Qt5Compat.GraphicalEffects
import QtQml 2.15


Window {
    id: overflow
    visible: true
    width: 350
    height: 500
    color: "transparent"

    property string myFrom: spcChar
    property string myTo: "B"

    function getFrom() {
        let myAbc2 = []
        if (engCsTab.currentIndex == 0) {
            myAbc2 = Array.from(engAlpha)
        } else if (csVKTab.currentIndex == 0) {
            myAbc2 = Array.from(csVAlpha)
        } else {
            myAbc2 = Array.from(csKAlpha)
        }
        let index2 = myAbc2.indexOf(myTo);
        if (index2 != -1) {
            myAbc2.splice(index2, 1);
        }
        return myAbc2
    }

    function getTo() {
        let myAbc3 = []
        if (engCsTab.currentIndex == 0) {
            myAbc3 = Array.from(engAlpha)
        } else if (csVKTab.currentIndex == 0) {
            myAbc3 = Array.from(csVAlpha)
        } else {
            myAbc3 = Array.from(csKAlpha)
        }
        let index = myAbc3.indexOf(myFrom);
        if (index != -1) {
            myAbc3.splice(index, 1);
        }
        return myAbc3
    }


    flags: Qt.Window | Qt.WindowMinimizeButtonHint | Qt.FramelessWindowHint
    Rectangle {
        color: "transparent"
        anchors.fill: parent
        Flickable {
            anchors.fill: parent
            synchronousDrag: true


            Rectangle {
                color: myBackground2
                radius: 8
                border.color: myUpperBar
                border.width: 4
                anchors.fill: parent
                anchors.rightMargin: 12
                anchors.leftMargin: 12
                anchors.bottomMargin: 352
                anchors.topMargin: 12

                GridLayout {
                    anchors.fill: parent
                    rowSpacing: 0
                    columns: 1
                    columnSpacing: 2

                    //upperBar
                    Rectangle {
                        width: 200
                        height: 200
                        color: myUpperBar
                        radius: 8
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
                                    clickPos = Qt.point(mouseX, mouseY)
                                }

                                onPositionChanged: {
                                    let delta = Qt.point(mouseX - clickPos.x,
                                                         mouseY - clickPos.y)
                                    overflow.x += delta.x
                                    overflow.y += delta.y
                                }
                            }
                        }
                        RowLayout {
                            anchors.fill: parent
                            anchors.rightMargin: 5
                            anchors.leftMargin: 5
                            anchors.bottomMargin: 5
                            anchors.topMargin: 5

                            Image {
                                horizontalAlignment: Image.AlignLeft
                                source: "icons/TaskBar.svg"
                                Layout.maximumWidth: 20
                                Layout.maximumHeight: 20
                                Layout.minimumHeight: 20
                                Layout.minimumWidth: 20
                                sourceSize.height: 20
                                sourceSize.width: 20
                            }
                            
                            Text {
                                text: engCsTab.currentIndex ? "Upravte svůj text" : "Edit your text"
                                font.pixelSize: 12
                                horizontalAlignment: Text.AlignLeft
                                verticalAlignment: Text.AlignVCenter
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                font.family: "Roboto Medium"
                                font.weight: Font.Medium
                                color: myWhiteFont
                            }

                        }
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        RowLayout {
                            Layout.rightMargin: 65
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Text {
                                text: engCsTab.currentIndex ? "Vyberte si převod" : "Chose your transfer:"
                                font.pixelSize: 12
                                horizontalAlignment: Text.AlignRight
                                verticalAlignment: Text.AlignVCenter
                                Layout.columnSpan: 1
                                Layout.rightMargin: 0
                                font.family: "Poppins Medium"
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                            }

                            ComboBox {
                                id: trans
                                Layout.leftMargin: 0
                                Layout.fillHeight: true
                                Layout.minimumHeight: 24
                                Layout.maximumHeight: 24
                                Layout.minimumWidth: 60
                                Layout.maximumWidth: 60
                                Layout.fillWidth: true
                                currentIndex: 0
                                font.family: "Poppins Medium"
                                model: ["J ❱❱ I", "W ❱❱ V", "Q ❱❱ K"]
                                
                                delegate: ItemDelegate {
                                    width: trans.width - 10
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
                                    highlighted: trans.highlightedIndex === index
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
                                    anchors.verticalCenter: trans.verticalCenter
                                    anchors.right: trans.right
                                    source: "icons/UpDown.svg"
                                    anchors.rightMargin: 6
                                    sourceSize.height: 10
                                    sourceSize.width: 10
                                    fillMode: Image.Pad

                                }

                                contentItem: Text {
                                    text: trans.displayText
                                    font: trans.font
                                    color: trans.pressed ? myBackground : myUpperBar
                                    verticalAlignment: Text.AlignVCenter
                                    anchors.horizontalCenter: trans.horizontalCenter
                                    elide: Text.ElideRight
                                    anchors.verticalCenter: trans.verticalCenter
                                    
                                }

                                background: Rectangle {
                                    implicitWidth: 100
                                    implicitHeight: 25
                                    border.color: trans.pressed ? myBackground2 : Qt.darker(myBackground2, 1.1)
                                    border.width: trans.visualFocus ? 2 : 1
                                    radius: 8
                                    color: myBackground2
                                }

                                popup: Popup {
                                    y: trans.height - 1
                                    width: trans.width
                                    implicitHeight: contentItem.implicitHeight
                                    padding: 5
                                    contentItem: ListView {
                                        clip: true
                                        implicitHeight: contentHeight + 10
                                        model: trans.popup.visible ? trans.delegateModel : null
                                        currentIndex: trans.highlightedIndex
                                    }

                                    background: Rectangle {
                                        border.width: 1
                                        border.color: myHighLighht
                                        radius:8
                                        color: myBackground
                                    }
                                }

                                onActivated: {
                                    if (trans.currentIndex == 0) {
                                        engCsTab.currentIndex = 0
                                    } else if (trans.currentIndex == 1) {
                                        engCsTab.currentIndex = 1
                                        csVKTab.currentIndex = 0
                                    } else if (trans.currentIndex == 2) {
                                        engCsTab.currentIndex = 1
                                        csVKTab.currentIndex = 1
                                    }
                                }
                            }
                        }

                        RowLayout {
                            Layout.rightMargin: 50
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Text {
                                text: engCsTab.currentIndex ? "Záměna znaků:" : "Swap characters:"
                                font.pixelSize: 12
                                Layout.columnSpan: 1
                                horizontalAlignment: Text.AlignRight
                                verticalAlignment: Text.AlignVCenter
                                font.family: "Poppins Medium"
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                            }

                            ComboBox {
                                id: from
                                Layout.minimumHeight: 24
                                Layout.maximumHeight: 24
                                Layout.minimumWidth: 40
                                Layout.maximumWidth: 40
                                Layout.fillWidth: true
                                currentIndex: getFrom().indexOf(myFrom)
                                font.family: "Poppins Medium"
                                model: getFrom()
                                
                                delegate: ItemDelegate {
                                    width: from.width - 10
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
                                    highlighted: from.highlightedIndex === index
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
                                    anchors.verticalCenter: from.verticalCenter
                                    anchors.right: from.right
                                    source: "icons/UpDown.svg"
                                    anchors.rightMargin: 6
                                    sourceSize.height: 10
                                    sourceSize.width: 10
                                    fillMode: Image.Pad                                        
                                        
                                }

                                contentItem: Text {
                                    text: from.displayText
                                    font: from.font
                                    color: from.pressed ? myBackground : myUpperBar
                                    verticalAlignment: Text.AlignVCenter
                                    anchors.horizontalCenter: from.horizontalCenter
                                    elide: Text.ElideRight
                                    anchors.verticalCenter: from.verticalCenter
                                    
                                }

                                background: Rectangle {
                                    implicitWidth: 100
                                    implicitHeight: 25
                                    border.color: from.pressed ? myBackground2 : Qt.darker(myBackground2, 1.1)
                                    border.width: from.visualFocus ? 2 : 1
                                    radius: 8
                                    color: myBackground2
                                }

                                popup: Popup {
                                    y: from.height - 1
                                    width: from.width
                                    implicitHeight: contentItem.implicitHeight
                                    padding: 5
                                    contentItem: ListView {
                                        clip: true
                                        implicitHeight: contentHeight + 10
                                        model: from.popup.visible ? from.delegateModel : null
                                        currentIndex: from.highlightedIndex
                                    }                                        

                                    background: Rectangle {
                                        border.width: 1
                                        border.color: myHighLighht
                                        radius:8
                                        color: myBackground
                                    }
                                }

                                onActivated: {
                                    myFrom = getFrom()[from.currentIndex]
                                    to.currentIndex = getTo().indexOf(myTo)
                                }
                            }

                            Text {
                                text: "❱❱"
                                Layout.columnSpan: 1
                                font.pixelSize: 12
                                horizontalAlignment: Text.AlignRight
                                verticalAlignment: Text.AlignVCenter
                                font.family: "Poppins Medium"
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                            }

                            ComboBox {
                                id: to
                                Layout.minimumHeight: 24
                                Layout.maximumHeight: 24
                                Layout.minimumWidth: 40
                                Layout.maximumWidth: 40
                                Layout.fillWidth: true
                                currentIndex: 0
                                font.family: "Poppins Medium"
                                model: getTo()
                                
                                delegate: ItemDelegate {
                                    width: to.width - 10
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
                                    highlighted: to.highlightedIndex === index
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
                                    anchors.verticalCenter: to.verticalCenter
                                    anchors.right: to.right
                                    source: "icons/UpDown.svg"
                                    anchors.rightMargin: 6
                                    sourceSize.height: 10
                                    sourceSize.width: 10
                                    fillMode: Image.Pad                                        
                                        
                                }

                                contentItem: Text {
                                    text: to.displayText
                                    font: to.font
                                    color: to.pressed ? myBackground : myUpperBar
                                    verticalAlignment: Text.AlignVCenter
                                    anchors.horizontalCenter: to.horizontalCenter
                                    elide: Text.ElideRight
                                    anchors.verticalCenter: to.verticalCenter
                                    
                                }

                                background: Rectangle {
                                    implicitWidth: 100
                                    implicitHeight: 25
                                    border.color: to.pressed ? myBackground2 : Qt.darker(myBackground2, 1.1)
                                    border.width: to.visualFocus ? 2 : 1
                                    radius: 8
                                    color: myBackground2
                                }

                                popup: Popup {
                                    y: to.height - 1
                                    width: to.width
                                    implicitHeight: contentItem.implicitHeight
                                    padding: 5
                                    contentItem: ListView {
                                        clip: true
                                        implicitHeight: contentHeight + 10
                                        model: to.popup.visible ? to.delegateModel : null
                                        currentIndex: to.highlightedIndex
                                    }                                        

                                    background: Rectangle {
                                        border.width: 1
                                        border.color: myHighLighht
                                        radius:8
                                        color: myBackground
                                    }
                                }

                                onActivated: {
                                    myTo = getTo()[to.currentIndex]
                                    from.currentIndex = getFrom().indexOf(myFrom)
                                }
                            }

                        }
                    }

                    RowLayout {
                        spacing: 8
                        Layout.margins: 8
                        Layout.maximumHeight: 42
                        Layout.topMargin: 0
                        Layout.leftMargin: 12
                        Layout.rightMargin: 12
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        
                        Button {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Layout.minimumHeight:  36
                            Layout.maximumHeight: 36
                            background: Rectangle {
                                implicitHeight: 36
                                anchors.fill: parent
                                color: parent.down ? myHighLighht : (parent.hovered ? Qt.lighter(myBackground, 1.25) : myBackground)
                                radius: 8
                            }

                            Label{
                                color: myWhiteFont
                                anchors.verticalCenter: parent.verticalCenter
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                padding: 8
                                font.family: "Roboto Medium"
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: engCsTab.currentIndex ? "Zavřít" : "Close"
                                
                            }
                            onClicked: {
                                overflow.close()
                                activeWindow = true
                            }
                        }

                        Button {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Layout.minimumHeight:  36
                            Layout.maximumHeight: 36
                            background: Rectangle {
                                implicitHeight: 36
                                anchors.fill: parent
                                color: parent.down ? myHighLighht : (parent.hovered ? Qt.lighter(myBackground, 1.25) : myBackground)
                                radius: 8
                            }

                            Label{
                                color: myWhiteFont
                                anchors.verticalCenter: parent.verticalCenter
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                padding: 8
                                font.family: "Roboto Medium"
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: engCsTab.currentIndex ? "Dokončit" : "Finish"
                                
                            }
                            onClicked: {
                                activeWindow = true
                                if (textFileTab.currentIndex) {
                                    myInputText = myInputText.replace(myFrom, myTo)
                                    rplSpc.currentIndex = 0
                                    rplSpcValue = 0
                                    spcChar = myFrom
                                    console.log(myInputText);
                                } else {
                                    inputText.text = inputText.text.replace(myFrom, myTo)
                                    rplSpc.currentIndex = 0
                                    rplSpcValue = 0
                                    spcChar = myFrom
                                }
                                overflow.close()
                            }
                        }

                        
                    }




                }
            }
        }
        Rectangle {
            id: overflowGlow
            color: "#cf018500"
            radius: 8
            anchors.fill: parent
            anchors.rightMargin: 12
            anchors.leftMargin: 12
            anchors.bottomMargin: 352
            anchors.topMargin: 12
            z: -1
        }
        FastBlur {
            anchors.fill: overflowGlow
            radius: 12
            transparentBorder: true
            source: overflowGlow
            z: -1
        }

    }
    
}
