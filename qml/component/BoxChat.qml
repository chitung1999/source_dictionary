import QtQuick 2.0
import QtGraphicalEffects 1.14
import QtQuick.Controls 2.14

Item {
    id: root
    anchors.fill: parent

    Rectangle {
        id: box
        width: parent.width * 4/5
        height: 780
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 100
        }
        radius: 20
        visible: false
    }

    TableBase {
        id: content
        anchors.fill: box
        heightTitle: 80
        visible: false
    }

    OpacityMask {
        id: mask
        anchors.fill: box
        source: content
        maskSource: box
    }

    Rectangle {
        anchors.fill: box
        radius: 20
        color: "transparent"
        border.color: "#569bea"
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
        color: AICHAT.isConnect ? "#39ff00" : "gray"
    }

    TextInput {
        id: username
        property bool isEdit: false

        font.pixelSize: 25
        font.bold: true
        anchors {
            verticalCenter: connect.verticalCenter
            left: connect.left
            leftMargin: 30
        }
        color: "white"
        text: AICHAT.userName
        focus: isEdit
        readOnly: !isEdit
    }

    Image {
        id: changeUser
        width: 20
        height: 20
        anchors {
            bottom: username.bottom
            left: username.right
            leftMargin: 10
        }
        opacity: 0.7
        source: username.isEdit ? "qrc:/img/done.png" : "qrc:/img/edit.png"
        MouseArea {
            anchors.fill: parent
            onPressed: parent.scale = 0.7
            onReleased: parent.scale = 1
            onClicked: {
                if (username.isEdit)
                    AICHAT.setUserName(username.text)
                username.isEdit = !username.isEdit
            }
        }
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
        source: AICHAT.isConnect ? "qrc:/img/online.png" : "qrc:/img/offline.png"
        MouseArea {
            anchors.fill: parent
            onPressed: parent.scale = 0.7
            onReleased: parent.scale = 1
            onClicked: AICHAT.isConnect ? AICHAT.disconnect() : AICHAT.doConnect()
        }
    }
    TextInput {
        id: ip_address
        property bool isEdit: false

        font.pixelSize: 20
        font.bold: true
        anchors {
            verticalCenter: connect.verticalCenter
            right: change_IP.left
            rightMargin: 10
        }
        color: "white"
        text: "127.0.0.1"
        focus: isEdit
        readOnly: !isEdit
        visible: isEdit
    }

    Image {
        id: change_IP
        width: 20
        height: 20
        anchors {
            bottom: connect_button.bottom
            right: connect_button.left
            rightMargin: 10
        }
        opacity: 0.7
        source: ip_address.isEdit ? "qrc:/img/done.png" : "qrc:/img/edit.png"
        MouseArea {
            anchors.fill: parent
            onPressed: parent.scale = 0.7
            onReleased: parent.scale = 1
            onClicked: {
                if (ip_address.isEdit)
                    AICHAT.setIPAddress(ip_address.text)
                ip_address.isEdit = !ip_address.isEdit
            }
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
