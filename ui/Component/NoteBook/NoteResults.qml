import QtQuick 2.0
import QtQuick.Controls 2.14
import "../../Common"

Item {
    id: root

    TableVBase {
        id: box
        width: 1160
        height: 680
        anchors {
            top: parent.top
            topMargin: 200
            left: parent.left
            leftMargin: 100
        }
        heightTitle: 80
        visible: false
    }

    BorderBase {
        anchors.fill: box
        source: box
        opacity: 0.8
        borderWidth: 1

    }


    Text {
        id: box_title
        anchors {
            top: box.top
            topMargin: 15
            horizontalCenter: box.horizontalCenter
        }
        font.pixelSize: 40
        font.bold: true
        color: "#fff"
        text: NOTEBOOK.currentKey
    }

    ListView {
        id: results
        width: box.width
        height: box.height - 140
        anchors {
            left: box.left
            verticalCenter: box.verticalCenter
            verticalCenterOffset: 40
        }
        clip: true
        model: LISTNOTE

        delegate: NoteItem {
            index: model.index
            words: model.words
            means: model.means
            notes: model.notes
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
