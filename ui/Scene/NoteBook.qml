import QtQuick 2.0
import "../Common/"
import "../Component/"

Item {
    anchors.fill: parent

    NoteResults {
        id: results
        width: 1160
        height: 680
        anchors {
            top: parent.top
            topMargin: 200
            left: parent.left
            leftMargin: 100
        }
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
