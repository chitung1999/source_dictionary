import QtQuick 2.0

Item {
    id: root

    property alias text: content.text

    width: parent.width
    height: box.height + 10

    Rectangle {
        id: box
        width: parent.width - 40
        height: 50
        radius: 10
        anchors {
            left: parent.left
            leftMargin: 20
            bottom: parent.bottom
        }
        border.color: "#000"
        border.width: 2
        color: SETTING.isThemeLight ? "#FFF" : "#898989"

        TextInput {
            id: content
            font.pixelSize: 25
            width: parent.width - 40
            anchors.centerIn: parent
            clip: true
            text: root.text
        }
    }
}
