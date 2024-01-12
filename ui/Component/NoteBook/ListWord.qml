import QtQuick 2.0
import QtQuick.Controls 2.14
import "../../Common"

Item {
    id: root
    width: 550
    height: parent.height

    Text {
        id: title
        anchors {
            horizontalCenter: list_word.horizontalCenter
            top: parent.top
            topMargin: 90
        }
        text: qsTr("New words dictionary") + CTRL.translator
        font.pixelSize: 30
        font.bold: true
        style: Text.Raised
        styleColor: "#000"
        color: SETTING.themeColor
    }

    Rectangle {
        id: box
        width: list_word.width + box.border.width * 2
        height: list_word.height + box.border.width * 2 + 40
        radius: 5
        anchors {
            top: title.bottom
            topMargin: 20
            left: parent.left
        }
        border.width: 3
        border.color: SETTING.borderColor
        opacity: 0.9

        Rectangle {
            width: list_word.width
            height: 40
            anchors{
                left: parent.left
                leftMargin: box.border.width
                bottom: box.bottom
                bottomMargin: box.border.width
            }
            Text {
                anchors.centerIn: parent
                font.pixelSize: 20
                font.bold: true
                text: qsTr("Count: ") + CTRL.translator + NOTEBOOK.keys.length
            }
        }
    }

    ListView {
        id: list_word
        width: 400
        height: 780
        clip: true
        anchors {
            top: box.top
            topMargin: box.border.width
            horizontalCenter: box.horizontalCenter
        }
        model: NOTEBOOK.keys.length
        delegate: Item {
            width: 400
            height: 40
            Rectangle {
                radius: 5
                anchors.fill: parent
                border.color: "#cccccc"
                color: index == list_word.currentIndex ? "#bcbcbc" : "transparent"
            }

            Text {
                text: NOTEBOOK.keys[index]
                font.pixelSize: 20
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    list_word.currentIndex = index
                    list_word.focus = true
                    NOTEBOOK.search(NOTEBOOK.keys[index], true)
                }
            }

            Keys.onReturnPressed: {
                if(list_word.focus)
                    NOTEBOOK.search(NOTEBOOK.keys[list_word.currentIndex], true)
            }
        }

        ScrollBar.vertical: ScrollBar {
            background: Rectangle {
                implicitWidth: 10
                color: "transparent"
            }
            contentItem: Rectangle {
                implicitWidth: 10
                radius: 5
                color: "gray"
            }
        }
    }
}
