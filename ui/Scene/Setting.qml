import QtQuick 2.0
import AppEnum 1.0
import "../Common/"
import "../Component/"

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
        text: qsTr("Setting") + CTRL.translator
    }

    ListModel {
        id: option
        ListElement {
            titleItem: qsTr("Language")
            stateItem: AppEnum.LANGUAGE
            sourceItem: "qrc:/img/language.png"
        }
        ListElement {
            titleItem: qsTr("User Name")
            stateItem: AppEnum.USERNAME
            sourceItem: "qrc:/img/username.png"
        }
        ListElement {
            titleItem: qsTr("Connect")
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
                    text: titleItem + CTRL.translator
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
        id: content
        width: 900
        height: 600
        anchors {
            top: box.top
            right: box.right
        }

        Rectangle {
            id: eng
            width: 200
            height: 80
            visible: false
            color: SETTING.language == AppEnum.ENGLISH ? "#5ca5d1" : "#fff"
            border.color: "black"
            border.width: 3
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
                text: qsTr("English") + CTRL.translator
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
            visible: false
            color: SETTING.language == AppEnum.VIETNAMESE ? "#5ca5d1" : "#fff"
            border.color: "black"
            border.width: 3
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
                text: qsTr("Vietnamese") + CTRL.translator
            }
            MouseArea {
                anchors.fill: parent
                onClicked: SETTING.setLanguage(AppEnum.VIETNAMESE)
            }
        }

        TextInputBase {
            id: username_input
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 200
            }
            visible: false
            title: qsTr("User name:") + CTRL.translator
            boxWidth: 250
            boxHeight: 60
            boxLeft: 200
            content: SETTING.userName

            onTextChanged: SETTING.setUserName(username_input.textInput)
        }

        TextInputBase {
            id: ip_input
            anchors {
                verticalCenter: parent.verticalCenter
                verticalCenterOffset: -70
                left: parent.left
                leftMargin: 100
            }
            visible: false
            title: qsTr("IP Adress Connect:") + CTRL.translator
            boxWidth: 250
            boxHeight: 60
            boxLeft: 320
            content: SETTING.ipAddress
            onTextChanged: SETTING.setIpAddress(ip_input.textInput)
        }

        TextInputBase {
            id: port_input
            anchors {
                verticalCenter: parent.verticalCenter
                verticalCenterOffset: 25
                left: parent.left
                leftMargin: 100
            }
            visible: false
            title: qsTr("Port:") + CTRL.translator
            boxWidth: 250
            boxHeight: 60
            boxLeft: 320
            content: SETTING.port

            onTextChanged: SETTING.setPort(port_input.textInput)
        }
    }

    states: [
        State {
            name: AppEnum.LANGUAGE
            PropertyChanges {target: choose; y: 290}
            PropertyChanges {target: eng; visible: true}
            PropertyChanges {target: vn; visible: true}
        },
        State {
            name: AppEnum.USERNAME
            PropertyChanges {target: choose; y: 370}
            PropertyChanges {target: username_input; visible: true}
        },
        State {
            name: AppEnum.CONNECT
            PropertyChanges {target: choose; y: 450}
            PropertyChanges {target: ip_input; visible: true}
            PropertyChanges {target: port_input; visible: true}
        }
    ]
}
