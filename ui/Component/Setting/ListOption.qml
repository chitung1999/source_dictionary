import QtQuick 2.0
import AppEnum 1.0

Item {
    id: root

    state: AppEnum.LANGUAGE

    ListModel {
        id: option
        ListElement {
            titleItem: qsTr("Language")
            stateItem: AppEnum.LANGUAGE
            sourceItem: "qrc:/img/language.png"
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
        y: choose.height * root.state
        width: 8
        height: 80
        color: SETTING.themeColor
    }
}
