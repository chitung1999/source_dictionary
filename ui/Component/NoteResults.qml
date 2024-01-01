import QtQuick 2.0
import QtQuick.Controls 2.14
import "../Common"

Item {
    id: root

    TableBase {
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
        height: box.height - 120
        anchors {
            verticalCenter: box.verticalCenter
            verticalCenterOffset: 40
        }
        clip: true
        visible: false
        model: NOTEBOOK.currentData

//        delegate: MeanItem {
//            partSpeed: model.part
//            synonyms: model.synonyms
//            antonyms: model.antonyms
//            definitions: model.definitions
//        }
        delegate: Rectangle {
            width: 500
            height: 500
            color: "red"
            border.color: "black"
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
