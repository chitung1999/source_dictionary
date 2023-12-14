import QtQuick 2.0
import QtGraphicalEffects 1.14
import "component/"

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
            onClicked: {
                DICTIONARY.search(text_input.text)
                text_input.text = ""
                text_input.focus = false
            }
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
        verticalAlignment: Text.AlignVCenter
        Keys.onReturnPressed: {
            DICTIONARY.search(text_input.text)
            text_input.text = ""
            text_input.focus = false
        }
    }

    DictionaryResults {
        id: results
        anchors {
            top: parent.top
            topMargin: 200
            horizontalCenter: parent.horizontalCenter
        }
    }
}
