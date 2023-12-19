import QtQuick 2.0
import "../Common"

Item {
    id: root

    property bool isENG

    TableBase {
        id: english
        width: parent.width / 2
        height: 430
        title: qsTr("Keys") + CTRL.translator

        Column {
            anchors {
                left: parent.left
                leftMargin: 60
                verticalCenter: parent.verticalCenter
                verticalCenterOffset: 25
            }
            spacing: 15
            Repeater {
                model: 8
                Text {
                    text: NOTEBOOK.currentData[index] === "" ? "" : "❁ " + NOTEBOOK.currentData[index]
                    font.pixelSize: 25
                    color: NOTEBOOK.currentData[index] === NOTEBOOK.currentKey ? "red" : "#000"
                }
            }
        }
    }

    TableBase {
        id: vietnamese
        width: parent.width / 2
        height: english.height
        anchors.left: english.right
        title: qsTr("Meanings")

        Column {
            anchors {
                left: parent.left
                leftMargin: 60
                verticalCenter: parent.verticalCenter
                verticalCenterOffset: 25
            }
            spacing: 10
            Repeater {
                model: 4
                Text {
                    text: NOTEBOOK.currentData[index + 8] === "" ? "" : "❁ " + NOTEBOOK.currentData[index + 8]
                    font.pixelSize: 25
                    color: NOTEBOOK.currentData[index + 8] === NOTEBOOK.currentKey ? "red" : "#000"
                }
            }
        }
    }

    TableBase {
        id: note
        width: parent.width
        height: english.height
        anchors.top: english.bottom
        title: qsTr("Note")
    }
}
