import QtQuick 2.0

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
        border.color: "#569bea"
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

    TextInput {
        id: text_input
        width: 420
        height: 60
        anchors {
            verticalCenter: search_box.verticalCenter
            left: search_box.left
            leftMargin: 30
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

    Item {
        id: language
        width: 130
        height: 50
        anchors {
            verticalCenter: search_box.verticalCenter
            left: search_box.right
            leftMargin: 50
        }

        Text {
            id: vn
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
            }
            text: qsTr("VN")
            font.pixelSize: 20
            font.bold: true
            color: "#45818E"
            opacity: root.isENG ? 0.5 : 1
        }

        Text {
            id: en
            anchors {
                verticalCenter: parent.verticalCenter
                right: parent.right
            }
            text: qsTr("EN")
            font.pixelSize: 20
            font.bold: true
            opacity: root.isENG ? 1 : 0.5
            color: "#45818E"
        }

        Rectangle {
            id: bg_choose
            width: 60
            height: 30
            radius: 15
            anchors.centerIn: parent
            opacity: 0.5
        }

        Rectangle {
            id: choose
            width: 26
            height: 26
            radius: 26
            anchors {
                verticalCenter: bg_choose.verticalCenter
                left: bg_choose.left
                leftMargin: 34
            }
        }

        MouseArea {
            width: parent.width / 2
            height: parent.height
            onClicked: {
                root.isENG = false
                chooseAni.start()
                if (text_input.text != "")
                    NOTEBOOK.searchChar(text_input.text, root.isENG)
            }
        }
        MouseArea {
            width: parent.width / 2
            height: parent.height
            anchors.right: parent.right
            onClicked: {
                root.isENG = true
                chooseAni.start()
                if (text_input.text != "")
                    NOTEBOOK.searchChar(text_input.text, root.isENG)
            }
        }
    }

    NumberAnimation {
        id: chooseAni
        running: false
        target: choose
        property: "anchors.leftMargin"
        to: root.isENG ? 34 : 0
        duration: 100
    }

    function changedFocus(isListFocus) {
        list_search.focus = isListFocus
        text_input.focus = !isListFocus
    }
}
