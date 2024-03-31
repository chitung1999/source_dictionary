import QtQuick 2.0
import QtGraphicalEffects 1.0
import AppEnum 1.0

Item {
    id: root

    property string loader: list_banner.get(root.state).loaderItem

    Rectangle {
        id: banner_top
        width: parent.width
        height: 70
        color: SETTING.isThemeLight ? "#FFF" : "#3b3b3b"

        Rectangle {
            id: choose
            x: choose.width * root.state
            width: parent.width / list_banner.count
            height: 5
            anchors.bottom: banner_top.bottom
            color: "#45818E"
        }

        ListModel {
            id: list_banner
            ListElement {
                stateItem: AppEnum.NOTEBOOK
                loaderItem: "qrc:/ui/Scene/NoteBook.qml"
                sourceItem: "qrc:/img/notebook.png"
                sourceItemHL: "qrc:/img/notebook_hightlight.png"
                titleItem: qsTr("Words")
            }
            ListElement {
                stateItem: AppEnum.GRAMMAR
                loaderItem: "qrc:/ui/Scene/Grammar.qml"
                sourceItem: "qrc:/img/grammar.png"
                sourceItemHL: "qrc:/img/grammar_hightlight.png"
                titleItem: qsTr("Grammar")
            }
            ListElement {
                stateItem: AppEnum.SEARCH
                loaderItem: "qrc:/ui/Scene/SearchDictionary.qml"
                sourceItem: "qrc:/img/dictionary.png"
                sourceItemHL: "qrc:/img/dictionary_hightlight.png"
                titleItem: qsTr("Dictionary")
            }
            ListElement {
                stateItem: AppEnum.GAME
                loaderItem: "qrc:/ui/Scene/Game.qml"
                sourceItem: "qrc:/img/game.png"
                sourceItemHL: "qrc:/img/game_hightlight.png"
                titleItem: qsTr("Game")
            }
            ListElement {
                stateItem: AppEnum.SETTING
                loaderItem: "qrc:/ui/Scene/Setting.qml"
                sourceItem: "qrc:/img/setting.png"
                sourceItemHL: "qrc:/img/setting_hightlight.png"
                titleItem: qsTr("Setting")
            }
        }

        Row {
            Repeater {
                model: list_banner
                BannerItem {
                    width: root.width / list_banner.count
                    height: banner_top.height
                    source: root.state == stateItem ? sourceItemHL : sourceItem
                    title: titleItem + CTRL.translator
                    colorText: root.state == stateItem ? "#00a8f3" : "#000"
                    onClick: root.state = stateItem
                }
            }
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
            visible: false
        }

        Rectangle {
            id: box_logo
            anchors.fill: logo
            gradient: Gradient {
//                GradientStop { position: -0.5; color: "#000" }
//                GradientStop { position: 0.5; color: "#45818E" }
//                GradientStop { position: 1.5; color: "#000" }
                GradientStop { position: 0; color: "#45818E" }
                GradientStop { position: 1; color: "#45818E" }
            }
            visible: false
        }

        OpacityMask {
            anchors.fill: box_logo
            source: box_logo
            maskSource: logo
        }

        Text {
            id: title
            anchors {
                left: logo.right
                leftMargin: 20
                top: logo.top
                topMargin: 10
            }
            text: "DICTIONARY"
            font.pixelSize: 30
            font.bold: true
            style: Text.Raised
            styleColor: "#FFF"
            color: "#45818E"
        }
    }
}
