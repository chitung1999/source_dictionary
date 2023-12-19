import QtQuick 2.0

Rectangle {
    id: root
    radius: root.height / 2
    border.color: "#569bea"
    border.width: 2

    gradient: Gradient {
        GradientStop { position: 0.0; color: root.colorOutside }
        GradientStop { position: 0.2; color: root.colorCenter }
        GradientStop { position: 0.8; color: root.colorCenter }
        GradientStop { position: 1.0; color: root.colorOutside }
    }

    property string name
    property var colorCenter
    property var colorOutside
    signal clickButton()

    Text {
        anchors.centerIn: parent
        text: root.name
        font.pixelSize: 20
        font.bold: true
        color: "#FFF"
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

