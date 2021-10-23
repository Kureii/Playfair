import QtQuick 2.9
import QtQuick.Controls
import QtQuick.Layouts 6.0

TextField {
    id: repSpaces1
    selectByMouse: true
    color: myWhiteFont
    enabled: activeWindow
    horizontalAlignment: Text.AlignHCenter
    font.capitalization: Font.AllUppercase
    font.family: "Roboto Medium"
    placeholderTextColor: Qt.darker(myWhiteFont, 2)
    placeholderText: "A"
    Layout.rightMargin: 40
    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.maximumHeight: 24
    Layout.minimumWidth: 24
    Layout.maximumWidth: 24
    background: Rectangle {
        color: myBackground
        //border.width: 1
        //border.color: Qt.darker(myBackground2, 1.1)
        radius: 8
    }
}