import QtQuick
import QtQuick.Controls
import QtQuick.Layouts 6.0
import QtQml.Models 2.2
import Qt5Compat.GraphicalEffects
import QtQuick.Dialogs 

Window {
    id: winSol
    visible: false
    width: 600
    height: 450

    color: "transparent"

    flags: Qt.Window | Qt.WindowMinimizeButtonHint | Qt.FramelessWindowHint

    Flickable {
        anchors.fill: parent
        boundsBehavior: Flickable.StopAtBounds

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
                                winSol.x += delta.x
                                winSol.y += delta.y
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
                                id: myClose1
                                width: 20
                                height: 20
                                flat: true
                                Layout.minimumWidth: 20
                                Layout.minimumHeight: 20
                                Layout.fillHeight: false
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                                background: Rectangle {
                                    color: myClose1.pressed ? Qt.darker(myCloseBtn, 1.5) :
                                                              (myClose1.hovered ? myCloseBtn : myUpperBar)
                                    radius: 4
                                    Rectangle {
                                        width: 16
                                        height: 2
                                        radius: 1
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        rotation: 45
                                        color: myClose1.pressed ? Qt.darker(myCloseImg, 1.5) : myCloseImg
                                    }
                                    Rectangle {
                                        width: 16
                                        height: 2
                                        radius: 1
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        rotation: -45
                                        color: myClose1.pressed ? Qt.darker(myCloseImg, 1.5) : myCloseImg
                                    }
                                }
                                onClicked: {
                                    winSol.close()
                                    spaceSpin.value = 5
                                    spaceValue = 5
                                    fileDialog.currentFile = ""
                                    inputText.text = ""
                                    fileState.text = textChoseFile
                                    key.text = ""
                                    illChar = ""
                                    textFileTab.currentIndex = 0
                                    myData.makeDefaultGrids()
                                    gridEng.source = ""
                                    gridCsV.source = ""
                                    gridCsK.source = ""
                                    gridEng.source = "icons/EngGrid.svg"
                                    gridCsV.source = "icons/CsVGrid.svg"
                                    gridCsK.source = "icons/CsKGrid.svg"
                                    myEncodeText = ""
                                    myOpenText = ""
                                    activeWindow = true


                                }
                            }
                        }
                    }

                    Text {
                        y: 7
                        text: engCsTab.currentIndex ? "Řešení" : "Solution"
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

                ColumnLayout {
                    width: 100
                    height: 100
                    Layout.topMargin: 4
                    spacing: 0
                    Layout.margins: 12
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    ColumnLayout {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Label {
                            text: engCsTab.currentIndex == 0 ? "Key:" : "Klíč"
                            bottomPadding: 0
                            topPadding: 4
                            padding: 8
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            font.family: "Poppins Medium"
                            color:  myUpperBar
                            Layout.minimumHeight: 18
                        }


                        Flickable {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Layout.minimumHeight: 32
                            TextArea.flickable: TextArea {
                                selectByMouse: true
                                visible: true
                                readOnly: true
                                text: key.text
                                color: myWhiteFont
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.Wrap
                                font.family: "Roboto Medium"
                                background: Rectangle {
                                    color: myBackground
                                    radius: 8
                                }
                            }

                            ScrollBar.vertical: ScrollBar {}
                        }
                    }
                    

                    ColumnLayout {
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        Label {
                            text: engCsTab.currentIndex ? "Doplňkový znak:" : "Supplement char:" 
                            bottomPadding: 0
                            topPadding: 4
                            padding: 8
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            font.family: "Poppins Medium"
                            color:  myUpperBar
                            Layout.minimumHeight: 18
                        }


                        Flickable {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Layout.minimumHeight: 32
                            TextArea.flickable: TextArea {
                                selectByMouse: true
                                visible: true
                                readOnly: true
                                text: spcChar
                                color: myWhiteFont
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.Wrap
                                font.family: "Roboto Medium"
                                background: Rectangle {
                                    color: myBackground
                                    radius: 8
                                }
                            }

                            ScrollBar.vertical: ScrollBar {}
                        }
                    }

                    
                    Label {
                        text: engCsTab.currentIndex == 0 ? "Open text:" : "Otevřený text"
                        bottomPadding: 0
                        topPadding: 4
                        padding: 8
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        font.family: "Poppins Medium"
                        color:  myUpperBar
                        Layout.minimumHeight: 18
                    }

                    Flickable {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.minimumHeight: 64
                        TextArea.flickable: TextArea {
                            selectByMouse: true
                            visible: true
                            readOnly: true
                            text: myOpenText
                            color: myWhiteFont
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            wrapMode: Text.Wrap
                            font.family: "Roboto Medium"
                            background: Rectangle {
                                color: myBackground
                                radius: 8
                            }
                        }

                        ScrollBar.vertical: ScrollBar {}
                    }
                    

                    Label {
                        text: engCsTab.currentIndex == 0 ? "Encoded text:" : "Šifrovaný text"
                        bottomPadding: 0
                        topPadding: 4
                        padding: 8
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        font.family: "Poppins Medium"
                        color:  myUpperBar
                        Layout.minimumHeight: 18
                    }

                    Flickable {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.minimumHeight: 64
                        TextArea.flickable: TextArea {
                            selectByMouse: true
                            visible: true
                            readOnly: true
                            text: myEncodeText
                            color: myWhiteFont
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            wrapMode: Text.Wrap
                            font.family: "Roboto Medium"
                            background: Rectangle {
                                color: myBackground
                                radius: 8
                            }
                        }

                        ScrollBar.vertical: ScrollBar {}
                    }


                    Button {
                        id: makeAlpha
                        Layout.topMargin: 8
                        Layout.minimumWidth: 150
                        Layout.minimumHeight: 42
                        Layout.fillWidth: true
                        onClicked: {
                            saveDialog.visible = true
                        }
                        background: Rectangle {
                            anchors.fill: parent
                            color: parent.down ? myHighLighht : (parent.hovered ? Qt.lighter(myBackground, 2) : myBackground)
                            radius: 8
                            Label{
                                text: "saveText"
                                anchors.fill: parent
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.family: "Roboto Medium"
                                color: makeAlpha.down ? myUpperBar : (makeAlpha.hovered ? Qt.darker(myWhiteFont, 1.25) :myWhiteFont)
                            }
                        }
                    }
                }
            }
        }

        Rectangle {
            id: winSolGlow
            color: "#cf018500"
            radius: 8
            anchors.fill: parent
            anchors.rightMargin: 12
            anchors.leftMargin: 12
            anchors.bottomMargin: 12
            anchors.topMargin: 12
            z: -1
        }
        FastBlur {
            anchors.fill: winSolGlow
            radius: 12
            transparentBorder: true
            source: winSolGlow
            z: -1
        }

        FileDialog {
            id: saveDialog
            visible: false
            nameFilters: [ "Text files (*.txt)"]
            fileMode: FileDialog.SaveFile
            onAccepted: {
                myData.getSaveFile(saveDialog.currentFile)
                winSol.close()
            }
            onRejected: saveDialog.currentFile = ""
        }
    }
}
