import QtQuick 2.0
import "component/"

Item {
    id: root
    anchors.fill: parent

    BoxChat {
        id: box_chat
    }

    Rectangle {
        id: input
        width: 1240
        height: 60
        radius: 30
        border.color: "black"
        anchors {
            left: parent.left
            leftMargin: 400
            bottom: parent.bottom
            bottomMargin: 45
        }

        TextInput {
            id: text_input
            font.pixelSize: 25
            width: 1180
            anchors.left: parent.left
            anchors.leftMargin: 30
            anchors.verticalCenter: parent.verticalCenter
            clip: true
        }
    }

    Image {
        id: send
        anchors {
            verticalCenter: input.verticalCenter
            left: input.right
            leftMargin: 20
        }
        source: "qrc:/img/send.png"
        MouseArea {
            anchors.fill: parent
            onPressed: parent.scale = 0.7
            onReleased: parent.scale = 1
            onClicked: {
                AICHAT.sendMessage(text_input.text)
            }
        }
    }

    PopUp {
        id: popup
        anchors.fill: parent
    }
}
