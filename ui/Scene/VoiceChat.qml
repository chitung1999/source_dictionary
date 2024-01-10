import QtQuick 2.0
import "../Common/"
import "../Component/VoiceChat"

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
        border.color: SETTING.borderColor
        anchors {
            left: parent.left
            leftMargin: 400
            bottom: parent.bottom
            bottomMargin: 45
        }
        opacity: 0.8
    }
    TextInput {
        id: text_input
        font.pixelSize: 25
        width: 1180
        anchors.left: input.left
        anchors.leftMargin: 30
        anchors.verticalCenter: input.verticalCenter
        clip: true
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
            onClicked: sendMessage()
        }
    }

    PopupNotify {
        id: popup
        anchors.fill: parent
    }

    function sendMessage() {
        if(text_input.text != "") {
            CTRL.sendMessage(text_input.text)
            text_input.text = ""
        }
    }

    Keys.onReturnPressed: {
        if (text_input.focus)
            sendMessage()
    }
}
