import QtQuick 2.12
import QtQuick.Window 2.12
import AppEnum 1.0
import "Common/"

Window {
    id: root
    visible: true
    visibility:  Window.Maximized
    minimumWidth: 960
    minimumHeight: 500
    title: qsTr("Dictionary")

    Item {
        width: 1920
        height: 1001
        anchors.centerIn: parent
        scale: parent.width / 1920

        Image {
            id: bg
            anchors.fill: parent
            source: "qrc:/img/bg.jpg"
        }

        Banner {
            id: banner
            anchors.fill: parent
            state: AppEnum.NOTEBOOK
        }

        Loader {
            id: content
            anchors.fill: parent
            state: banner.state
            source: "qrc:/ui/Scene/NoteBook.qml"
            states: [
                State {
                    name: AppEnum.NOTEBOOK
                    PropertyChanges {target: content; source: "qrc:/ui/Scene/NoteBook.qml"}
                },
                State {
                    name: AppEnum.SEARCH
                    PropertyChanges {target: content; source: "qrc:/ui/Scene/SearchDictionary.qml"}
                },
                State {
                    name: AppEnum.VOICECHAT
                    PropertyChanges {target: content; source: "qrc:/ui/Scene/VoiceChat.qml"}
                },
                State {
                    name: AppEnum.SETTING
                    PropertyChanges {target: content; source: "qrc:/ui/Scene/Setting.qml"}
                }
            ]
        }
    }
}
