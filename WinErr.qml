import QtQuick
import QtQuick.Controls
import QtQuick.Layouts 6.0
import QtQml.Models 2.2
import Qt5Compat.GraphicalEffects
import QtQml 2.15

Window {
    id: winErr
    visible: true
    width: 300
    height: 150

    color: "transparent"

    flags: Qt.Window | Qt.WindowMinimizeButtonHint | Qt.FramelessWindowHint

    Flickable {
        anchors.fill: parent

        Rectangle {
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
                anchors.fill: parent
                rowSpacing: 0
                columns: 1
                columnSpacing: 2

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
                                var delta = Qt.point(mouseX - clickPos.x,
                                                     mouseY - clickPos.y)
                                winErr.x += delta.x
                                winErr.y += delta.y
                            }
                        }
                    }
                    RowLayout {
                        id: rectangle
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
                            text: engCsTab.currentIndex ? "Chyba vstupu" : "Input error"
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
                    width: 100
                    height: 100
                    Layout.bottomMargin: 12
                    Layout.topMargin: 8
                    spacing: 8
                    Layout.margins: 16
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Label {
                        color: myCloseBtn
                        text: engCsTab.currentIndex ? "Text nelze dešifrovat" : "Text is not possible to decode"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.Wrap
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        font.family: "Poppins Medium"
                    }

                   

                    Button {
                        id: ok
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                        Layout.minimumWidth: 150
                        Layout.minimumHeight: 32
                        Layout.fillWidth: true
                        onClicked: {
                            winErr.close()
                            activeWindow = true
                            inputErr = false
                            inDecErr = false
                        }
                        background: Rectangle {
                            anchors.fill: parent
                            color: parent.down ? myHighLighht : (parent.hovered ? Qt.lighter(myBackground, 2) : myBackground)
                            radius: 8
                            Label{
                                text: "OK"
                                anchors.fill: parent                                    
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.family: "Roboto Medium"
                                color: ok.down ? myUpperBar : (ok.hovered ? Qt.darker(myWhiteFont, 1.25) :myWhiteFont)
                            }
                        }
                    }
                    
                }
            }
        }

        Rectangle {
            id: winErrGlow
            color: "#c4cb0000"
            radius: 8
            anchors.fill: parent
            anchors.rightMargin: 14
            anchors.leftMargin: 14
            anchors.bottomMargin: 14
            anchors.topMargin: 14
            z: -1
        }
        FastBlur {
            anchors.fill: winErrGlow
            radius: 14
            transparentBorder: true
            source: winErrGlow
            z: -1
        }
    }
}

