import QtQuick 2.0

import "../../Common"

Item {
    id: root

    SearchBar {
        id: search
        anchors {
            top: parent.top
            topMargin: 100
            left: parent.left
            leftMargin: 300
        }
        width: 500
        height: 60
        textLeft: 60
        onTextInputChanged: NOTEBOOK.searchChar(search.textInput, language.isENG)
        Keys.onDownPressed: changedFocus(true)

        Connections {
            target: NOTEBOOK
            function onRequestSearch() {
                search.textInput = ""
            }
        }
    }

    Item {
        id: language

        property bool isENG: true

        width: 60
        height: search.height
        anchors {
            top: search.top
            left: search.left
        }

        Text {
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 20
            }
            text: language.isENG ? "EN" : "VN"
            font.pixelSize: 20
            font.bold: true
            color: "#45818E"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                language.isENG = !language.isENG
                NOTEBOOK.searchChar(search.textInput, language.isENG)
            }
        }
    }

    ListView {
        id: list_search
        width: 420
        height: 600
        clip: true
        anchors {
            top: search.bottom
            topMargin: 5
            left: search.left
            leftMargin: 30
        }
        model: NOTEBOOK.searchKeys.length
        delegate: Item {
            width: 420
            height: 40
            Rectangle {
                anchors.fill: parent
                border.color: SETTING.isThemeLight ? "#cccccc" : "#343434"
                color: index == list_search.currentIndex ? "#bcbcbc" : (SETTING.isThemeLight ? "#f8f8f8" : "#3b3b3b")
                opacity: 0.8
            }

            Text {
                text: NOTEBOOK.searchKeys[index]
                font.pixelSize: 20
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 20
                }
                color: SETTING.isThemeLight ? "#000" : "#FFF"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: NOTEBOOK.search(NOTEBOOK.searchKeys[index], language.isENG)
            }
            Keys.onReturnPressed: NOTEBOOK.search(NOTEBOOK.searchKeys[index], language.isENG)
            Keys.onRightPressed: changedFocus(false)
        }
    }

    function changedFocus(isListFocus) {
        list_search.focus = isListFocus
        search.textFocus = !isListFocus
    }
}
