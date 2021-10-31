import QtQuick
import QtQuick.Controls
import QtQuick.Layouts 6.0
import QtQml.Models 2.2
import Qt5Compat.GraphicalEffects
import QtQml 2.15


Item {
property string myChar: ""
Layout.fillWidth: true
Layout.fillHeight: true

function isNumText() {
    if(myChar == "0" || myChar == "1" || myChar == "2" || myChar == "3" 
    || myChar == "4" || myChar == "5" || myChar == "6" || myChar == "7"
    || myChar == "8" || myChar == "9") {
        if (engCsTab.currentIndex) {
            return "Přejete si číslo přepsat či odstranit? Číslo: \"" + myChar + "\""
        } else {
            return "Do you want overwrite or remove number? Number: \"" + myChar + "\""
        }
    } else {
        if (engCsTab.currentIndex) {
            return "Přejete si znak přepsat či odstranit? Znak: \"" + myChar + "\""
        } else {
            return "Do you want overwrite or remove char? Character: \"" + myChar + "\""
        }
    }
}

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 8
        anchors.rightMargin: 6

        Label {
            text:  isNumText()
            font.pixelSize: 12
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            Layout.minimumHeight: 32
            Layout.maximumHeight: 32
            Layout.fillWidth: true
            anchors.leftMargin: 14
        }

        ComboBox {
            id: wT
            Layout.minimumHeight: 24
            Layout.maximumHeight: 24
            Layout.minimumWidth: 85
            Layout.maximumWidth: 85
            Layout.fillWidth: true
            currentIndex: 0
            font.family: "Poppins Medium"
            model: engCsTab.currentIndex ? ["Odstranit", "Přepsat"] : ["Remove", "Overwrite"]
            
            delegate: ItemDelegate {
                width: wT.width - 10
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
                highlighted: wT.highlightedIndex === index
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
                anchors.verticalCenter: wT.verticalCenter
                anchors.right: wT.right
                source: "icons/UpDown.svg"
                anchors.rightMargin: 6
                sourceSize.height: 10
                sourceSize.width: 10
                fillMode: Image.Pad                                        
                    
            }

            contentItem: Text {
                text: wT.displayText
                font: wT.font
                color: wT.pressed ? myBackground : myUpperBar
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: wT.horizontalCenter
                elide: Text.ElideRight
                anchors.verticalCenter: wT.verticalCenter
                
            }

            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 25
                border.color: wT.pressed ? myBackground2 : Qt.darker(myBackground2, 1.1)
                border.width: wT.visualFocus ? 2 : 1
                radius: 8
                color: myBackground2
            }

            popup: Popup {
                y: wT.height - 1
                width: wT.width
                implicitHeight: contentItem.implicitHeight
                padding: 5
                contentItem: ListView {
                    clip: true
                    implicitHeight: contentHeight + 10
                    model: wT.popup.visible ? wT.delegateModel : null
                    currentIndex: wT.highlightedIndex
                }                                        

                background: Rectangle {
                    border.width: 1
                    border.color: myHighLighht
                    radius:8
                    color: myBackground
                }
            }

            onActivated: {
                console.log("1");
            }
        }

        TextField {
            id: rewrite
            selectByMouse: true
            color: myUpperBar
            visible: wT.currentIndex
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.leftMargin: 0
            font.capitalization: Font.AllUppercase
            font.family: "Poppins Medium"
            placeholderTextColor: Qt.lighter(myUpperBar, 2)
            placeholderText: engCsTab.currentIndex ? ("\"" + myChar + "\" slovně") : "\"" + (myChar + "\" as word")
            validator: RegularExpressionValidator { regularExpression:  /^[a-zA-Zá-žÁ-Ž]+$/ }
            Layout.rightMargin: 0
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumHeight: 24
            Layout.maximumHeight: 24
            background: Rectangle {
                color: myBackground2
                border.width: 1
                border.color: Qt.darker(myBackground2, 1.1)
                radius: 8
            }
            onTextChanged: {
                if(rewrite.text != "") {
                    err3.visible = false
                    repair.height = 148 + (40 * repCount)
                    rewrite.placeholderTextColor = myUpperBar
                    var tmp = rewrite.cursorPosition
                    var illegal = false
                    let rW = rewrite.text
                    rW = rW.normalize("NFD").replace(/[\u0300-\u036f]/g, "")
                    if (rW.includes(spcChar)) {
                        illegal = true
                        rW = rW.replace(spcChar, "")
                    }
                    if (engCsTab.currentIndex){
                        if (csVKTab.currentIndex) {
                            rW = rW.replace("Q", "K")
                        } else {
                            rW = rW.replace("W", "V")
                        }
                    } else {
                        rW = rW.replace("J", "I")
                    }
                    rW = rW.toUpperCase()
                    rewrite.text = rW 
                    if (illegal) {
                        rewrite.cursorPosition = tmp - 1
                    } else {
                        rewrite.cursorPosition = tmp
                    }
                    
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
