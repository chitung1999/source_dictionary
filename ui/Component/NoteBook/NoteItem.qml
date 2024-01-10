import QtQuick 2.0
import "../../Common"

Item {
    id: root

    width: 1160
    height: words.height + means.height + notes.height + 20

    property int index
    property var words
    property var means
    property string notes

    TableHBase {
        id: words
        width: 1050
        anchors {
            left: parent.left
            leftMargin: 30
        }
        title: "Words"
        content: formatList(root.words)
    }

    TableHBase {
        id: means
        width: words.width
        anchors {
            left: parent.left
            leftMargin: 30
            top: words.bottom
            topMargin: - means.borderWidth
        }
        title: "Means"
        content: formatList(root.means)
    }

    TableHBase {
        id: notes
        width: words.width
        anchors {
            left: parent.left
            leftMargin: 30
            top: means.bottom
            topMargin: - means.borderWidth
        }
        title: "Notes"
        content: root.notes
    }

    Image {
        id: modify
        anchors {
            right: root.right
            rightMargin: 30
            verticalCenter: root.verticalCenter
            verticalCenterOffset: -40
        }
        opacity: 0.5
        source: "qrc:/img/edit.png"
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: parent.opacity = 1
            onExited: parent.opacity = 0.5
            onPressed: parent.scale = 0.7
            onReleased: parent.scale = 1
            onClicked: {
                NOTEBOOK.popupModifyData(root.index)
            }
        }
    }

    Image {
        id: remove
        anchors {
            right: modify.right
            verticalCenter: root.verticalCenter
            verticalCenterOffset: 20
        }
        opacity: 0.5
        source: "qrc:/img/remove.png"
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: parent.opacity = 0.8
            onExited: parent.opacity = 0.4
            onPressed: parent.scale = 0.7
            onReleased: parent.scale = 1
            onClicked: CTRL.receiveConf(root.index)
        }
    }

    function formatList(list) {
        var str = "";
        for (var i = 0; i < list.length; i++) {
            if(str !== "") str += ", "
            str += list[i]
        }
        return str;
    }
}
