import QtQuick 2.0

Item {
    id: root

    property string title
    property int heightTitle: 50
    property int titleSize: 20

    Rectangle {
        id: title
        width: parent.width
        height: root.heightTitle
        color: SETTING.themeColor

        Text {
            anchors.centerIn: parent
            text: root.title
            font.pixelSize: root.titleSize
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
        color: "#FFF"
    }
}
