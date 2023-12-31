import QtQuick 2.0
import QtQuick.Controls 1.4
import "../Common/"
import "../Component/"

Item {
    anchors.fill: parent

    ListWord {
        id: list
        anchors.right: parent.right
    }

    Rectangle {
        id: random
        width: 700
        height: 70
        radius: 35
        anchors {
            left: parent.left
            leftMargin: 560
           verticalCenter: parent.verticalCenter
           verticalCenterOffset: 440
        }
        gradient: Gradient {
                    GradientStop { position: -1; color: "transparent" }
                    GradientStop { position: 0.5; color: "#fff" }
                    GradientStop { position: 2; color: "transparent" }
                }
        border.width: 3
        border.color: SETTING.borderColor

        Text {
            id: randomKey
            width: 640
            font.pixelSize: 30
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            elide: Text.ElideRight
            text: NOTEBOOK.randomKey
            onTextChanged: {
                randomKey.opacity = 0
                randomKeyAni.start()
            }
        }
    }

    NoteResults {
        id: results
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

    SequentialAnimation {
        id: randomKeyAni
        running: false
        property int dur: 300
        NumberAnimation {
            target: random
            properties: "height"
            from: 70
            to: 0
            duration: randomKeyAni.dur
        }
        ParallelAnimation {
            NumberAnimation {
                target: random
                properties: "height"
                from: 0
                to: 70
                duration: randomKeyAni.dur
            }
            NumberAnimation {
                target: randomKey
                properties: "opacity"
                from: 0
                to: 1
                duration: randomKeyAni.dur * 2
            }
        }
    }
}
