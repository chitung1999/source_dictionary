import QtQuick 2.0

Item {
    id: root

    property string title
    property int heightTitle: 50

    Rectangle {
        id: title
        width: parent.width
        height: root.heightTitle
        border.color: "#569bea"
        color: "#45818E"

        Text {
            anchors.centerIn: parent
            text: root.title
            font.pixelSize: 20
            font.bold: true
            color: "#FFF"
        }
    }

    Rectangle {
        id: content
        width: parent.width
        height: parent.height - title.height
        anchors {
            top: title.bottom
        }
        border.color: "#569bea"
        color: "#FFF"
    }
}
