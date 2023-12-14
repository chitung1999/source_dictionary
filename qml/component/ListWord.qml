import QtQuick 2.0
import QtQuick.Controls 2.14

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
        text: "Danh sách từ mới"
        font.pixelSize: 30
        font.bold: true
        style: Text.Raised
        styleColor: "#FFF"
        color: "#45818E"
    }

    Rectangle {
        id: box
        width: list_word.width + box.border.width * 2
        height: list_word.height + box.border.width * 2
        anchors {
            top: title.bottom
            topMargin: 30
            left: parent.left
        }
        border.width: 3
        border.color: "#45818E"
    }

    ListView {
        id: list_word
        width: 400
        height: 720
        clip: true
        anchors.centerIn: box
        model: NOTEBOOK.allData.length
        delegate: Rectangle {
            width: 400
            height: 40
            radius: 5
            border.color: "#cccccc"

            Text {
                text: NOTEBOOK.allData[index]
                font.pixelSize: 20
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    NOTEBOOK.search(NOTEBOOK.allData[index], true)
                }
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

    ButtonBase {
        id: update
        width: 160
        height: 50
        anchors {
            horizontalCenter: box.horizontalCenter
            top: box.bottom
            topMargin: 30
        }
        name: "Cập nhật"
        colorCenter: "#569bea"
        colorOutside: "#f4cccc"
        onClickButton: NOTEBOOK.updateData()
    }
}
