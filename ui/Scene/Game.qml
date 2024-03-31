import QtQuick 2.0
import QtQuick.Controls 2.12
import "../Common/"
import "../Component/Game"

Item {
    id: root
    anchors.fill: parent

    Rectangle {
        id: box
        width: 1700
        height: 780
        radius: 35
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
            verticalCenterOffset: -10
        }
        border.width: 2
        border.color: "#45818E"
        opacity: 0.8
        color: SETTING.isThemeLight ? "#FFF" : "#3b3b3b"
    }

    Introduce {
        id: intro
        anchors.fill: box
        visible: !GAME.isPlaying
    }

    MouseArea {
        id: lock_screen
        anchors.fill: parent
        enabled: GAME.isPlaying
    }

    ButtonImage {
        id: mute
        anchors {
            top: box.top
            topMargin: 30
            right: box.right
            rightMargin: 50
        }
        onClickButton: GAME.setMute()
        source: GAME.isMute ? "qrc:/img/mute.png" : "qrc:/img/unmute.png"
    }

    PlayingGame {
        id: playing
        anchors.fill: box
        visible: GAME.isPlaying
    }
}
