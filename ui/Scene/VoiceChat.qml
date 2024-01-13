import QtQuick 2.0
import "../Common/"
import "../Component/VoiceChat"

Item {
    id: root
    anchors.fill: parent

    BoxChat {
        id: box_chat
        anchors.fill: parent
    }

    MessageInput {
        id: input
        anchors.fill: parent
    }

    MouseArea {
        id: lock_screen
        anchors.fill: parent
        enabled: popup.visible
    }

    PopupNotify {
        id: popup
        anchors.fill: parent
    }
}
