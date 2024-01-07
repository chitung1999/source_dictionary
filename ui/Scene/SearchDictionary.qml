import QtQuick 2.0
import "../Common/"
import "../Component/"

Item {
    id: root

    Rectangle {
        id: search_box
        width: 500
        height: 60
        radius: 40
        anchors {
            top: parent.top
            topMargin: 100
            horizontalCenter: parent.horizontalCenter
        }
        color: "#FFF"
        border.color: "#569bea"
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
        MouseArea {
            anchors.fill: parent
            onClicked: search()
        }
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
        focus: false
        verticalAlignment: Text.AlignVCenter
        Keys.onReturnPressed: search()
    }

    function search() {
        DICTIONARY.search(text_input.text)
        text_input.text = ""
        text_input.focus = false
        results.visible = true
    }

    DictionaryResults {
        id: results
        anchors {
            top: parent.top
            topMargin: 200
            horizontalCenter: parent.horizontalCenter
        }
        visible: false
    }
}
