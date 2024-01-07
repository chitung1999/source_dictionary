import QtQuick 2.0

Rectangle {
    id: root

    property string name
    property color textColor: "#FFF"
    property var colorCenter
    property var colorOutside

    signal clickButton()

    radius: root.height / 2
    border.color: "#569bea"
    border.width: 2

    gradient: Gradient {
        GradientStop { position: -0.5; color: root.colorOutside }
        GradientStop { position: 0.3; color: root.colorCenter }
        GradientStop { position: 0.7; color: root.colorCenter }
        GradientStop { position: 1.5; color: root.colorOutside }
    }

    Text {
        anchors.centerIn: parent
        text: root.name
        font.pixelSize: 20
        font.bold: true
        color: root.textColor
    }
    MouseArea {
        anchors.fill: parent
        onPressed: {
            parent.scale = 0.8
            parent.opacity = 0.6
        }
        onReleased: {
            parent.scale = 1
            parent.opacity = 1
        }
        onClicked: {
            root.clickButton()
        }
    }
}
