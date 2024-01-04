import QtQuick 2.0
import QtQuick.Controls 2.14
import "../Common"

Item {
    id: root
    anchors.fill: parent

    TableVBase {
        id: content
        width: parent.width * 4/5
        height: 780
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 100
        }
        heightTitle: 80
        visible: false
    }

    BorderBase {
        id: box
        anchors.fill: content
        source: content
    }

    Rectangle {
        id: connect
        width: 15
        height: 15
        radius: 15
        anchors {
            top: box.top
            topMargin: 32
            left: box.left
            leftMargin: 30
        }
        color: VOICECHAT.isConnect ? "#39ff00" : "gray"
    }

    Text {
        id: username

        font.pixelSize: 25
        font.bold: true
        anchors {
            verticalCenter: connect.verticalCenter
            left: connect.left
            leftMargin: 30
        }
        color: "white"
        text: VOICECHAT.userName
    }

    Image {
        id: connect_button
        width: 50
        height: 50
        anchors {
            verticalCenter: connect.verticalCenter
            right: box.right
            rightMargin: 40
        }
        source: VOICECHAT.isConnect ? "qrc:/img/online.png" : "qrc:/img/offline.png"
        MouseArea {
            anchors.fill: parent
            onPressed: parent.scale = 0.7
            onReleased: parent.scale = 1
            onClicked: VOICECHAT.isConnect ? VOICECHAT.disconnect() : VOICECHAT.doConnect()
        }
    }

    ListView {
        id: msg
        width: parent.width * 4/5 - 40
        height: 780 - 40 - 80
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: box.top
            topMargin: 100
        }
        clip: true
        currentIndex: LISTMSG.length - 1
        model: LISTMSG
        delegate: MessageItem {
            isCurrentClient: model.isCurrentClient
            name: model.name
            message: model.message
        }

        ScrollBar.vertical: ScrollBar {
            background: Rectangle {
                implicitWidth: 10
                color: "transparent"
            }
            contentItem: Rectangle {
                implicitWidth: 10
                radius: 5
                color: "gray"
            }
        }
    }
}
