import QtQuick 2.0

Rectangle {
    id: root

    property string name
    property color textColor: "#FFF"
    property int textSize: 20

    signal clickButton()

    radius: root.height / 2
    border.color: SETTING.borderColor
    border.width: 2
    color: "transparent"

    Rectangle {
        id: center_button
        width: parent.width - parent.border.width * 2
        height: parent.height - parent.border.width * 2
        anchors.centerIn: parent
        radius: parent.radius - parent.border.width
        opacity: 0
    }

    Text {
        anchors.centerIn: parent
        text: root.name
        font.pixelSize: root.textSize
        font.bold: true
        color: root.textColor
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: center_button.opacity = 0.5
        onExited: center_button.opacity = 0
        onPressed: parent.scale = 0.8
        onReleased: parent.scale = 1
        onClicked: root.clickButton()
    }
}
