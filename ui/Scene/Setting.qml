import QtQuick 2.0
import AppEnum 1.0
import "../Common/"
//import "../Component/Setting"

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
            color: "#969696"
        }
        visible: false
    }

    BorderBase {
        id: box
        anchors.fill: box_hide
        source: box_hide
        borderWidth: 1
        opacity: 0.8
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
        ListElement {
            titleItem: qsTr("BackGround")
            stateItem: AppEnum.BACKGROUND
            sourceItem: "qrc:/img/bg_icon.png"
        }
        ListElement {
            titleItem: qsTr("Color")
            stateItem: AppEnum.COLOR
            sourceItem: "qrc:/img/color.png"
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
        width: 8
        height: 80
        anchors.left: box.left
        color: SETTING.themeColor
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
            radius: 10
            visible: false
            color: SETTING.language == AppEnum.ENGLISH ? SETTING.themeColor : "#fff"
            border.color: SETTING.language == AppEnum.ENGLISH ? SETTING.borderColor : "#000"
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
                onClicked: CTRL.setLanguage(AppEnum.ENGLISH)
            }
        }
        Rectangle {
            id: vn
            width: 200
            height: 80
            radius: 10
            visible: false
            color: SETTING.language == AppEnum.VIETNAMESE ? SETTING.themeColor : "#fff"
            border.color: SETTING.language == AppEnum.VIETNAMESE ? SETTING.borderColor : "#000"
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
                onClicked: CTRL.setLanguage(AppEnum.VIETNAMESE)
            }
        }

        TextInputBase {
            id: username_input
            anchors.centerIn: parent
            visible: false
            title: qsTr("User name") + CTRL.translator
            boxWidth: 250
            boxHeight: 60
            boxLeft: username_input.textLeft + 20
            content: SETTING.userName

            onTextChanged: CTRL.setUserName(username_input.textInput)
        }

        TextInputBase {
            id: ip_input
            anchors {
                verticalCenter: parent.verticalCenter
                verticalCenterOffset: -40
                horizontalCenter: parent.horizontalCenter
            }
            visible: false
            title: qsTr("IP Adress Connect") + CTRL.translator
            boxWidth: 250
            boxHeight: 60
            boxLeft: ip_input.textLeft + 20
            content: SETTING.ipAddress
            onTextChanged: CTRL.setIpAddress(ip_input.textInput)
        }

        TextInputBase {
            id: port_input
            anchors {
                verticalCenter: parent.verticalCenter
                verticalCenterOffset: 40
                left: ip_input.left
            }
            visible: false
            title: qsTr("Port") + CTRL.translator
            boxWidth: 250
            boxHeight: 60
            boxLeft: ip_input.textLeft + 20
            content: SETTING.port

            onTextChanged: CTRL.setPort(port_input.textInput)
        }

        TextInputBase {
            id: background_input
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 30
            }
            visible: false
            title: qsTr("Path") + CTRL.translator
            boxWidth: parent.width - background_input.boxLeft - background_input.anchors.leftMargin - 80
            boxHeight: 60
            boxLeft: background_input.textLeft + 20
            fontSize: 25
            content: SETTING.background

            onTextChanged: CTRL.setBackground(background_input.textInput)
        }

        TextInputBase {
            id: theme_input
            anchors {
                verticalCenter: parent.verticalCenter
                verticalCenterOffset: -40
                left: border_input.left
            }
            visible: false
            title: qsTr("Theme Color") + CTRL.translator
            boxWidth: 250
            boxHeight: 60
            boxLeft: border_input.textLeft + 20
            content: SETTING.themeColor
            onTextChanged: CTRL.setThemeColor(theme_input.textInput)
        }

        TextInputBase {
            id: border_input
            anchors {
                verticalCenter: parent.verticalCenter
                verticalCenterOffset: 40
                left: ip_input.left
            }
            visible: false
            title: qsTr("Border Color") + CTRL.translator
            boxWidth: 250
            boxHeight: 60
            boxLeft: border_input.textLeft + 20
            content: SETTING.borderColor

            onTextChanged: CTRL.setBorderColor(border_input.textInput)
        }
    }

    PopupNotify {
        id: popup
        anchors.fill: parent
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
        },
        State {
            name: AppEnum.BACKGROUND
            PropertyChanges {target: choose; y: 530}
            PropertyChanges {target: background_input; visible: true}
        },
        State {
            name: AppEnum.COLOR
            PropertyChanges {target: choose; y: 610}
            PropertyChanges {target: theme_input; visible: true}
            PropertyChanges {target: border_input; visible: true}
        }
    ]
}
