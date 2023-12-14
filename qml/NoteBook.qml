import QtQuick 2.0
import QtGraphicalEffects 1.14
import "component/"

Item {
    anchors.fill: parent

    Rectangle {
        id: box_results
        width: 1160
        height: 680
        radius: 20
        anchors {
            top: parent.top
            topMargin: 200
            left: parent.left
            leftMargin: 100
        }
        visible: false
    }

    NoteResults {
        id: results
        anchors.fill: box_results
        isENG:search.isENG
        visible: false
    }

    OpacityMask {
        anchors.fill: box_results
        source: results
        maskSource: box_results
    }

    Rectangle {
        anchors.fill: box_results
        radius: 20
        color: "transparent"
        border.color: "#569bea"
    }

    SearchBar {
        id: search
        anchors.fill: parent
    }

    ListWord {
        id: list
        anchors.right: parent.right
    }
}
