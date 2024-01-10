import QtQuick 2.0
import AppEnum 1.0
import "../../Common"

Item {
    id: root
    width: 900
    height: 600

    Item {
        id: language
        anchors.fill: parent
        visible: false
        Rectangle {
            id: eng
            width: 200
            height: 80
            radius: 10
            color: SETTING.language == AppEnum.ENGLISH ? SETTING.themeColor : "#fff"
            border.color: SETTING.language == AppEnum.ENGLISH ? SETTING.borderColor : "#000"
            border.width: 2
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
                verticalCenterOffset: -60
            }
            Text {
                anchors.centerIn: parent
                font.pixelSize: 20
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
            color: SETTING.language == AppEnum.VIETNAMESE ? SETTING.themeColor : "#fff"
            border.color: SETTING.language == AppEnum.VIETNAMESE ? SETTING.borderColor : "#000"
            border.width: 2
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
                verticalCenterOffset: 60
            }
            Text {
                anchors.centerIn: parent
                font.pixelSize: 20
                text: qsTr("Vietnamese") + CTRL.translator
            }
            MouseArea {
                anchors.fill: parent
                onClicked: CTRL.setLanguage(AppEnum.VIETNAMESE)
            }
        }
    }

    TextInputBase {
        id: text_input1
        visible: true
        onTextChanged: input1_request()
    }

    TextInputBase {
        id: text_input2
        visible: true
        onTextChanged: input2_request()
    }

    states: [
        State {
            name: AppEnum.LANGUAGE
            PropertyChanges {target: language; visible: true}
            PropertyChanges {target: text_input1; visible: false}
            PropertyChanges {target: text_input2; visible: false}
        },
        State {
            name: AppEnum.USERNAME
            PropertyChanges {
                target: text_input1
                anchors.centerIn: root
                title: qsTr("User name")
                boxWidth: 250
                boxHeight: 60
                boxLeft: text_input1.textLeft + 20
                content: SETTING.userName
            }
            PropertyChanges {target: text_input2; visible: false}
        },
        State {
            name: AppEnum.CONNECT
            PropertyChanges {
                target: text_input1
                anchors {
                    verticalCenter: root.verticalCenter
                    verticalCenterOffset: -40
                    horizontalCenter: root.horizontalCenter
                }
                title: qsTr("IP Adress Connect")
                boxWidth: 250
                boxHeight: 60
                boxLeft: text_input1.textLeft + 20
                content: SETTING.ipAddress
            }
            PropertyChanges {
                target: text_input2
                anchors {
                    verticalCenter: root.verticalCenter
                    verticalCenterOffset: 40
                    left: text_input1.left
                }
                title: qsTr("Port")
                boxWidth: 250
                boxHeight: 60
                boxLeft: text_input1.textLeft + 20
                content: SETTING.port
            }
        },
        State {
            name: AppEnum.BACKGROUND
            PropertyChanges {
                target: text_input1
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 30
                }
                title: qsTr("Path")
                boxWidth: parent.width - text_input1.boxLeft - text_input1.anchors.leftMargin - 80
                boxHeight: 60
                boxLeft: text_input1.textLeft + 20
                content: SETTING.background
            }
            PropertyChanges {target: text_input2; visible: false}
        },
        State {
            name: AppEnum.COLOR
            PropertyChanges {
                target: text_input1
                anchors {
                    verticalCenter: root.verticalCenter
                    verticalCenterOffset: -40
                    left: text_input2.left
                }
                title: qsTr("Theme Color")
                boxWidth: 250
                boxHeight: 60
                boxLeft: text_input1.textLeft + 20
                content: SETTING.themeColor
            }
            PropertyChanges {
                target: text_input2
                anchors {
                    verticalCenter: root.verticalCenter
                    verticalCenterOffset: 40
                    horizontalCenter: root.horizontalCenter
                }
                title: qsTr("Border Color")
                boxWidth: 250
                boxHeight: 60
                boxLeft: text_input1.textLeft + 20
                content: SETTING.borderColor
            }
        }
    ]

    function input1_request() {
        switch(parseInt(root.state)) {
        case AppEnum.USERNAME:
            CTRL.setUserName(text_input1.textInput)
            break
        case AppEnum.CONNECT:
            CTRL.setIpAddress(text_input1.textInput)
            break
        case AppEnum.BACKGROUND:
            CTRL.setBackground(text_input1.textInput)
            break
        case AppEnum.COLOR:
            CTRL.setThemeColor(text_input1.textInput)
            break
        default:
            break
        }
    }

    function input2_request() {
        switch(parseInt(root.state)) {
        case AppEnum.CONNECT:
            CTRL.setPort(text_input2.textInput)
            break
        case AppEnum.COLOR:
            CTRL.setBorderColor(text_input2.textInput)
            break
        default:
            break
        }
    }
}
