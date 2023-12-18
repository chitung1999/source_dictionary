import QtQuick 2.0
import AppEnum 1.0
import "component/"

Item {
    id: root
    anchors.fill: parent
    state: AppEnum.LANGUAGE

    Rectangle {
        id: box_hide
        width: 1200
        height: 600
        anchors.centerIn: parent
        color: "#fff"
        Rectangle {
            width: 300
            height: 600
            color: "#eeeeee"
        }
        visible: false
    }

    BorderBase {
        id: box
        anchors.fill: box_hide
        source: box_hide
    }

    Text {
        id: title
        anchors {
            top: box.top
            topMargin: 30
            left: box.left
            leftMargin: 20
        }
        font.pixelSize: 30
        font.bold: true
        text: qsTr("Setting")
    }

    ListModel {
        id: option
        ListElement {
            titleItem: "Language"
            stateItem: AppEnum.LANGUAGE
            sourceItem: "qrc:/img/language.png"
        }
        ListElement {
            titleItem: "User Name"
            stateItem: AppEnum.USERNAME
            sourceItem: "qrc:/img/username.png"
        }
        ListElement {
            titleItem: "Connect"
            stateItem: AppEnum.CONNECT
            sourceItem: "qrc:/img/connect.png"
        }
    }

    Column {
        anchors {
            top: title.bottom
            topMargin: 23
            left: box.left
        }
        Repeater {
            id: repeat
            model: option
            Rectangle {
                width: 300
                height: 80
                color: "transparent"
                Image {
                    width: 32
                    height: 32
                    anchors {
                        left: parent.left
                        leftMargin: 40
                        verticalCenter: parent.verticalCenter
                    }
                    source: sourceItem
                }
                Text {
                    anchors {
                        left: parent.left
                        leftMargin: 90
                        verticalCenter: parent.verticalCenter
                    }
                    font.pixelSize: 20
                    text: titleItem
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: parent.color = "#bcbcbc"
                    onExited:  parent.color = "transparent"
                    onClicked: root.state = stateItem
                }
            }
        }
    }

    Rectangle {
        id: choose
        width: 5
        height: 80
        anchors.left: box.left
        color: "#5ca5d1"
    }

    Item {
        id: language_content
        width: 900
        height: 600
        anchors {
            top: box.top
            right: box.right
        }
        visible: false
        state: SETTING.language

        Rectangle {
            id: eng
            width: 200
            height: 80
            border.color: "black"
            property string textColor: "#000"
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
                verticalCenterOffset: -60
            }
            Text {
                anchors.centerIn: parent
                font.pixelSize: 20
                color: parent.textColor
                text: qsTr("English")
            }
            MouseArea {
                anchors.fill: parent
                onClicked: SETTING.setLanguage(AppEnum.ENGLISH)
            }
        }
        Rectangle {
            id: vn
            width: 200
            height: 80
            border.color: "black"
            property string textColor: "#000"
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
                verticalCenterOffset: 60
            }
            Text {
                anchors.centerIn: parent
                color: parent.textColor
                font.pixelSize: 20
                text: qsTr("Vietnamese")
            }
            MouseArea {
                anchors.fill: parent
                onClicked: SETTING.setLanguage(AppEnum.VIETNAMESE)
            }
        }
        states: [
            State {
                name: AppEnum.ENGLISH
                PropertyChanges {target: eng; color: "#5ca5d1"; textColor: "#fff"}
            },
            State {
                name: AppEnum.VIETNAMESE
                PropertyChanges {target: vn; color: "#5ca5d1"; textColor: "#fff"}
            }
        ]
    }

    Item {
        id: username_content
        width: 900
        height: 600
        anchors {
            top: box.top
            right: box.right
        }
        visible: false

        Text {
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 200
            }
            text: qsTr("User name:")
            font.pixelSize: 30
            font.bold: true
        }

        Rectangle {
            width: 250
            height: 60
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 380
            }
            border.color: "#000"

            TextInput {
                id: username
                font.pixelSize: 30
                width: 220
                anchors.centerIn: parent
                text: SETTING.userName
                focus: false
                clip: true
            }

            Image {
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: username.right
                    leftMargin: 25
                }
                visible: username.focus
                source: "qrc:/img/done.png"
                MouseArea {
                    anchors.fill: parent
                    onPressed: parent.scale = 0.7
                    onReleased: parent.scale = 1
                    onClicked: {
                        if (username.focus) {
                            username.focus = false
                            SETTING.setUserName(username.text)
                        }
                    }
                }
            }

            Keys.onReturnPressed: {
                if (username.focus) {
                    username.focus = false
                    SETTING.setUserName(username.text)
                }
            }
        }
    }

    Item {
        id: connect_content
        width: 900
        height: 600
        anchors {
            top: box.top
            right: box.right
        }
        visible: false

        Text {
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 100
            }
            text: qsTr("IP Adress Connect:")
            font.pixelSize: 30
            font.bold: true
        }

        Rectangle {
            width: 250
            height: 60
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 400
            }
            border.color: "#000"

            TextInput {
                id: ip
                font.pixelSize: 30
                width: 220
                anchors.centerIn: parent
                text: SETTING.ipAddress
                focus: false
                clip: true
            }

            Image {
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: ip.right
                    leftMargin: 25
                }
                visible: ip.focus
                source: "qrc:/img/done.png"
                MouseArea {
                    anchors.fill: parent
                    onPressed: parent.scale = 0.7
                    onReleased: parent.scale = 1
                    onClicked: {
                        if (ip.focus) {
                            ip.focus = false
                            SETTING.setIpAddress(ip.text)
                        }
                    }
                }
            }

            Keys.onReturnPressed: {
                if (ip.focus) {
                    ip.focus = false
                    SETTING.setIpAddress(ip.text)
                }
            }
        }
    }
    states: [
        State {
            name: AppEnum.LANGUAGE
            PropertyChanges {target: choose; y: 290}
            PropertyChanges {target: language_content; visible: true}
        },
        State {
            name: AppEnum.USERNAME
            PropertyChanges {target: choose; y: 370}
            PropertyChanges {target: username_content; visible: true}
        },
        State {
            name: AppEnum.CONNECT
            PropertyChanges {target: choose; y: 450}
            PropertyChanges {target: connect_content; visible: true}
        }
    ]
}
