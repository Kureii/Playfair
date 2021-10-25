import QtQuick 2.9
import QtQuick.Controls
import QtQuick.Layouts 6.0

Window {
    id: mainWindow
    visible: true
    width: 600
    height: 400
    color: "transparent"
    
    flags:  Qt.Window | Qt.WindowMinimizeButtonHint | Qt.FramelessWindowHint

    property string windowTitle: "Playfair"
    property string lang: "Language / Jazyk"
    property string eng: "English"
    property string cs: "Czech (Česky)"

    readonly property color myUpperBar: "#1a1512"
    readonly property color myBackground: "#201e1b"
    readonly property color myWhiteFont: "#e4f8ff"
    readonly property color myBackground2: "#acb1aa"
    readonly property color myHighLighht: "#3fa108"
    readonly property color myCloseImg: "#fcf8fe"
    readonly property color myCloseImgUnA: "#878589"
    readonly property color myCloseBtn: "#de2f05"

    property bool activeWindow: true

    

    Flickable {
        anchors.fill: parent

        Rectangle {
            id: window
            color: myBackground2
            radius: 8
            border.color: myUpperBar
            border.width: 4
            anchors.fill: parent
            anchors.rightMargin: 12
            anchors.leftMargin: 12
            anchors.bottomMargin: 12
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
                    id: gridLayout
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
            }
        }
    }
}
