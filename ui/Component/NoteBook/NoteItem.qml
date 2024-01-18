import QtQuick 2.0
import AppEnum 1.0
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

    ButtonImage {
        id: modify
        anchors {
            right: root.right
            rightMargin: 30
            verticalCenter: root.verticalCenter
            verticalCenterOffset: -40
        }
        opacityExited: 0.5
        source: "qrc:/img/edit.png"
        onClickButton: NOTEBOOK.popupModifyData(root.index)
    }

    ButtonImage {
        id: remove
        anchors {
            right: modify.right
            verticalCenter: root.verticalCenter
            verticalCenterOffset: 20
        }
        opacityExited: 0.5
        source: "qrc:/img/remove.png"
        onClickButton: CTRL.receiveConf(AppEnum.NOTEITEM, root.index)
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
