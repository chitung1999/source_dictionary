import QtQuick 2.0
import AppEnum 1.0
import "component/"

Item {
    id: root

    Rectangle {
        id: banner_top
        width: parent.width
        height: 60
        border.color: "#dddddd"
        border.width: 2

        Rectangle {
            id: choose
            width: parent.width / 4
            height: 5
            anchors.bottom: banner_top.bottom
            color: "#5ca5d1"
        }

        BannerItem {
            id: notebook
            source: "qrc:/img/notebook.png"
            onClick: root.state = AppEnum.NOTEBOOK
        }
        BannerItem {
            id: search
            anchors.left: notebook.right
            source: "qrc:/img/dictionary.png"
            onClick: root.state = AppEnum.SEARCH
        }
        BannerItem {
            id: aichat
            anchors.left: search.right
            source: "qrc:/img/chat.png"
            onClick: root.state = AppEnum.AICHAT
        }
        BannerItem {
            id: game
            anchors.left: aichat.right
            source: "qrc:/img/setting.png"
            onClick: root.state = AppEnum.SETTING
        }
    }

    Item {
        id: banner_bot
        width: parent.width
        height: 100
        anchors.bottom: parent.bottom

        Image {
            id: logo
            source: "qrc:/img/LOGO_MINI.PNG"
            width: 80
            height: 80
            anchors {
                left: parent.left
                leftMargin: 60
            }
        }

        Text {
            id: title
            anchors {
                left: logo.right
                leftMargin: 20
                top: logo.top
                topMargin: 10
            }
            text: qsTr("DICTIONARY")
            font.pixelSize: 30
            font.bold: true
            style: Text.Raised
            styleColor: "black"
            color: "#FFF"
        }
    }

    states: [
        State {
            name: AppEnum.NOTEBOOK
            PropertyChanges {target: choose; x: root.width * 0/4}
            PropertyChanges {target: notebook; source: "qrc:/img/notebook_hightlight.png"}
        },
        State {
            name: AppEnum.SEARCH
            PropertyChanges {target: choose; x: root.width * 1/4}
            PropertyChanges {target: search; source: "qrc:/img/dictionary_hightlight.png"}
        },
        State {
            name: AppEnum.AICHAT
            PropertyChanges {target: choose; x: root.width * 2/4}
            PropertyChanges {target: aichat; source: "qrc:/img/chat_hightlight.png"}
        },
        State {
            name: AppEnum.SETTING
            PropertyChanges {target: choose; x: root.width * 3/4}
            PropertyChanges {target: game; source: "qrc:/img/setting_hightlight.png"}
        }
    ]
}
