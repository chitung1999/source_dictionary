import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id: root
    width: 320
    height: 150
    visible: true
    title: "Server"

    Text {
        id: ip_title
        anchors {
            top: parent.top
            topMargin: 20
            left: parent.left
            leftMargin: 20
        }
        font.pixelSize: 20
        color: "#000"
        text: "IP Address:"
    }

    Rectangle {
        id: ip_box
        width: 170
        height: 35
        radius: 5
        anchors {
            verticalCenter: ip_title.verticalCenter
            left: ip_title.right
            leftMargin: 5
        }
        border.color: "#000"
        color: "#eeeeee"

        Text {
            id: ip
            anchors.centerIn: parent
            font.pixelSize: 20
            color: "#000"
            text: SERVER.hostAddress()
        }
    }


    Text {
        id: port_title
        anchors {
            top: ip_title.bottom
            topMargin: 20
            left: ip_title.left
        }
        font.pixelSize: 20
        color: "#000"
        text: "Port:"
    }

    Rectangle {
        id: port_box
        width: 90
        height: 35
        radius: 5
        anchors {
            verticalCenter: port_title.verticalCenter
            left: ip_box.left
        }
        border.color: "#000"
        color: "#eeeeee"

        TextInput {
            id: port
            width: port_box.width - 20
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 10
            }
            font.pixelSize: 20
            color: "#000"
            focus: false
            clip: true
            text: "8080"

            Keys.onReturnPressed: port.focus = false
        }
    }

    Image {
        id: done
        width: 20
        height: 20
        anchors {
            verticalCenter: port_box.verticalCenter
            left: port_box.right
            leftMargin: 10
        }
        visible: port.focus
        source: "qrc:/done.png"
        MouseArea {
            anchors.fill: parent
            onPressed: parent.scale = 0.7
            onReleased: parent.scale = 1
            onClicked: port.focus = false
        }
    }

    Text {
        id: notify
        anchors {
            top: port_title.bottom
            topMargin: 20
            left: port_title.left
        }
        font.pixelSize: 20
        font.bold: true
        color: "#000"
        text: SERVER.isConnect ? "Connected!" : "Connect"
    }

    Rectangle {
        id: choose_box
        width: 60
        height: 30
        radius: 15
        anchors {
            verticalCenter: notify.verticalCenter
            right: ip_box.right
        }
        color: SERVER.isConnect ? "#40ce00" : "#999999"
    }

    Rectangle {
        id: choose
        width: 26
        height: 26
        radius: 26
        anchors {
            verticalCenter: choose_box.verticalCenter
            left: choose_box.left
            leftMargin: 2
        }
    }

    MouseArea {
        anchors.fill: choose_box
        onClicked:
            if(!port.focus)
                SERVER.isConnect ? SERVER.disconnect() : SERVER.doConnect(port.text)
    }

    ParallelAnimation{
        id: chooseAni
        running: false
        property int dur: 100
        NumberAnimation {
            target: choose
            property: "anchors.leftMargin"
            to: SERVER.isConnect ? 32 : 2
            duration: chooseAni.dur
        }
        NumberAnimation {
            target: notify
            property: "opacity"
            from: 0
            to: 1
            duration: chooseAni.dur
        }
    }

    Connections {
        target: SERVER
        function onIsConnectChanged() {
            chooseAni.start()
        }
    }
}
