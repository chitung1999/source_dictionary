import QtQuick 2.0
import QtQuick.Controls 2.12
import "../../Common/"

Item {
    id: root
    clip: true

    property int count: 0
    property var dictionary: ["D", "I", "C", "T", "I", "O", "N", "A", "R", "Y", ]

    ButtonImage {
        id: help
        anchors {
            top: parent.top
            topMargin: 30
            right: parent.right
            rightMargin: 130
        }
        scale: 0.8
        source: "qrc:/img/help.png"
    }

    ButtonBase {
        id: button
        width: 300
        height: 150
        radius: 30
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
            verticalCenterOffset: 150
        }
        border.width: 6
        border.color: "#44c41f"
        onClickButton: logoAni.start()
        Image {
            anchors.centerIn: parent
            source: "qrc:/img/play.png"
        }
    }

    Row {
        id: logo
        scale: 0.7
        spacing: 10
        anchors {
            verticalCenter: parent.verticalCenter
            verticalCenterOffset: - 100
            horizontalCenter: parent.horizontalCenter
        }

        Repeater {
            id: repeat
            model:root.dictionary
            LogoItem {
                source: "qrc:/img/logo_" + root.dictionary[index] + ".png"
            }
        }
    }

    Timer {
        id: logoAni
        running: false
        interval: 200
        repeat: true
        onTriggered: {
            repeat.itemAt(root.count).startAni(true)
            repeat.itemAt(root.dictionary.length - root.count - 1).startAni(false)

            if (root.count == 4) {
                buttonAni.start()
                logoAni.stop()
                root.count = 0
            } else {
                root.count ++
            }
        }
    }

    SequentialAnimation {
        id: buttonAni
        running: false
        property int dur: 500
        NumberAnimation {
            target: button
            property: "anchors.verticalCenterOffset"
            from: 150
            to: 0
            duration: buttonAni.dur * 1.5
        }
        ParallelAnimation {
            NumberAnimation {
                target: button
                property: "scale"
                from: 1
                to: 4
                duration: buttonAni.dur
            }
            NumberAnimation {
                target: button
                property: "opacity"
                from: 1
                to: 0
                duration: buttonAni.dur
            }
        }
        onStopped: GAME.play()
    }

    onVisibleChanged: if(root.visible) reset()

    function reset() {
        button.anchors.verticalCenterOffset = 150
        button.scale = 1
        button.opacity = 1
        for (var i = 0; i < root.dictionary.length; i++) {
            repeat.itemAt(i).reset()
        }
    }
}
