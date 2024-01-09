import QtQuick 2.0
import QtGraphicalEffects 1.14

Item {
    id: root

    property bool isENG: true

    Rectangle {
        id: search_box
        width: 500
        height: 60
        radius: 40
        anchors {
            top: parent.top
            topMargin: 100
            left: parent.left
            leftMargin: 300
        }
        color: "#FFF"
        border.color: SETTING.borderColor
        opacity: 0.8
    }

    Image {
        id: search_icon
        anchors {
            verticalCenter: search_box.verticalCenter
            right: search_box.right
            rightMargin: 15
        }
        source: "qrc:/img/search.png"
    }

    Item {
        id: language
        width: 60
        height: 60
        anchors {
            top: search_box.top
            left: search_box.left
        }

        Text {
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 20
            }
            text: root.isENG ? "EN" : "VN"
            font.pixelSize: 20
            font.bold: true
            color: "#45818E"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.isENG = !root.isENG
                if (text_input.text != "")
                    NOTEBOOK.searchChar(text_input.text, root.isENG)
            }
        }
    }

    TextInput {
        id: text_input
        width: 390
        height: 60
        anchors {
            verticalCenter: search_box.verticalCenter
            left: search_box.left
            leftMargin: 60
        }
        font.pixelSize: 20
        clip: true
        verticalAlignment: Text.AlignVCenter
        onTextChanged: NOTEBOOK.searchChar(text_input.text, root.isENG)
        Connections {
            target: NOTEBOOK
            function onRequestSearch() {
                text_input.text = ""
            }
        }
        Keys.onDownPressed: changedFocus(true)
    }

    ListView {
        id: list_search
        width: 420
        height: 600
        clip: true
        anchors {
            top: search_box.bottom
            topMargin: 5
            left: search_box.left
            leftMargin: 30
        }
        model: NOTEBOOK.searchKeys.length
        delegate: Rectangle {
            width: 420
            height: 40
            border.color: "#cccccc"
            color: index == list_search.currentIndex ? "#bcbcbc" : "#f8f8f8"

            Text {
                text: NOTEBOOK.searchKeys[index]
                font.pixelSize: 20
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 20
                }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: NOTEBOOK.search(NOTEBOOK.searchKeys[index], root.isENG)
            }
            Keys.onReturnPressed: NOTEBOOK.search(NOTEBOOK.searchKeys[index], root.isENG)
            Keys.onRightPressed: changedFocus(false)
        }
    }

    function changedFocus(isListFocus) {
        list_search.focus = isListFocus
        text_input.focus = !isListFocus
    }
}
