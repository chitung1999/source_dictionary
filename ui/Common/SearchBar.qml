import QtQuick 2.0
import QtGraphicalEffects 1.14

Item {
    id: root

    property bool textFocus
    property int textLeft
    property alias textInput: input.text

    signal requestSearch()

    Rectangle {
        id: box
        anchors.fill: parent
        radius: parent.height
        color: "#FFF"
        border.color: SETTING.borderColor
        opacity: 0.8
    }

    Image {
        id: icon
        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: 15
        }
        source: "qrc:/img/search.png"
        MouseArea {
            anchors.fill: parent
            onClicked: root.requestSearch()
        }
    }

    TextInput {
        id: input
        width: parent.width - root.textLeft - icon.width - icon.anchors.rightMargin * 2
        height: 60
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: root.textLeft
        }
        font.pixelSize: 20
        clip: true
        focus: root.textFocus
        verticalAlignment: Text.AlignVCenter
    }
}
