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
        styleColor: "#FFF"
        color: "#45818E"
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
        border.color: "#45818E"
        color: "transparent"
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
        height: 690
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
                border.color: SETTING.isThemeLight ? "#cccccc" : "#343434"
                color: index == list_word.currentIndex ? "#bcbcbc" : (SETTING.isThemeLight ? "#FFF" : "#3b3b3b")
                opacity: 0.8
            }

            Text {
                text: NOTEBOOK.keys[index]
                font.pixelSize: 20
                anchors.centerIn: parent
                color: SETTING.isThemeLight ? "#000" : "#FFF"
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

    ButtonImage {
        id: add_new
        anchors {
            top: list_word.bottom
            topMargin: 70
            horizontalCenter: list_word.horizontalCenter
        }
        source: "qrc:/img/add.png"
        onClickButton: NOTEBOOK.popupAddNewData()
    }
}
