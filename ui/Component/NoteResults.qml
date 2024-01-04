import QtQuick 2.0
import QtQuick.Controls 2.14
import "../Common"

Item {
    id: root

    TableVBase {
        id: box
        anchors.fill: parent
        title: NOTEBOOK.currentKey
        titleSize: 40
        heightTitle: 80
        visible: false
    }

    BorderBase {
        anchors.fill: box
        source: box
    }

    ListView {
        id: results
        width: box.width
        height: box.height - 140
        anchors {
            verticalCenter: box.verticalCenter
            verticalCenterOffset: 40
        }
        clip: true
        visible: false
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

    Connections {
        target: NOTEBOOK
        function onRequestSearch() {
            results.visible = true
        }
    }
}
