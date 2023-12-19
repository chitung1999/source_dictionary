import QtQuick 2.0

Item {
    id: root
    visible: false

    property string message: CTRL.notifyMsg

    Rectangle {
        anchors.fill: parent
        color: "white"
        opacity: 0.5
    }

    MouseArea {
        anchors.fill: parent
    }

    Rectangle {
        id: box
        width: msg.width + 30
        height: msg.height + 30
        radius: 10
        anchors.centerIn: parent
        color: "#eeeeee"

        Text {
            id: msg
            text: root.message
            font.pixelSize: 30
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
