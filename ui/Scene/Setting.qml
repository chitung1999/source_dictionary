import QtQuick 2.0
import AppEnum 1.0
import "../Common/"
import "../Component/Setting"

Item {
    id: root
    anchors.fill: parent

    Rectangle {
        id: box_hide
        width: 1200
        height: 600
        anchors.centerIn: parent
        color: "#fff"
        Rectangle {
            width: 300
            height: 600
            color: "#969696"
        }
        visible: false
    }

    BorderBase {
        id: box
        anchors.fill: box_hide
        source: box_hide
        borderWidth: 1
        opacity: 0.8
    }

    Text {
        id: title
        anchors {
            top: box.top
            topMargin: 30
            left: box.left
            leftMargin: 20
        }
        font.pixelSize: 30
        font.bold: true
        text: qsTr("Setting") + CTRL.translator
    }

    ListOption {
        id: option
        anchors {
            top: title.bottom
            topMargin: 23
            left: box.left
        }
    }

    Content {
        id: content
        anchors {
            top: box.top
            right: box.right
        }
        state: option.state
    }

    PopupNotify {
        id: popup
        anchors.fill: parent
    }
}
