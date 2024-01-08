import QtQuick 2.0

Item {
    id: root
    visible: false

    property string message: CTRL.notifyMsg

    Rectangle {
        anchors.fill: parent
        color: "#000"
        opacity: 0.5
    }

    MouseArea {
        anchors.fill: parent
    }

    Rectangle {
        id: box
        width: msg.width + 120
        height: msg.height + 160
        radius: 10
        anchors.centerIn: parent
        border.color: SETTING.borderColor
        border.width: 8
        color: "#eeeeee"

        Text {
            id: msg
            text: root.message
            font.pixelSize: 40
            color: "black"
            anchors.centerIn: parent
        }
    }

    Timer {
        id: timer
        interval: 1500
        onTriggered: root.visible = false
    }

    Connections {
        target: CTRL
        function onNotifyMsgChanged() {
            root.visible = true
            timer.start()
        }
    }
}
