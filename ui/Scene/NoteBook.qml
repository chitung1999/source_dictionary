import QtQuick 2.0
import QtQuick.Controls 1.4
import "../Common/"
import "../Component/NoteBook"

Item {
    anchors.fill: parent

    ListWord {
        id: list
        anchors.right: parent.right
    }

    RandomWord {
        id: random
        width: 700
        height: 70
        anchors {
            left: parent.left
            leftMargin: 560
           verticalCenter: parent.verticalCenter
           verticalCenterOffset: 440
        }
    }

    NoteResults {
        id: results
        anchors.fill: parent
    }

    SearchWord {
        id: search
        anchors.fill: parent
    }

    PopupNotify {
        id: popup_notify
        anchors.fill: parent
    }

    PopupConfirm {
        id: popup_confirm
        anchors.fill: parent
        onConfirm: CTRL.removeItemNote()
    }
}
