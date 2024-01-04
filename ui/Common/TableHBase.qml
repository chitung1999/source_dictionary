import QtQuick 2.0

Item {
    id: root

    height: content_id.height

    property string title
    property string content
    property int widthTitle: 100
    property int borderWidth: 3

    Rectangle {
        id: title_id
        width: root.widthTitle
        height: content_id.height
        anchors {
            left: parent.left
            top: parent.top
        }
        border.color: "#000"
        border.width: root.borderWidth
        Text {
            anchors.centerIn: parent
            text: root.title
            font.pixelSize: 25
            font.bold: true
        }
    }

    Rectangle {
        id: content_id
        width: parent.width - title_id.width
        height: content_text.height + 40
        anchors {
            left: title_id.right
            leftMargin: - border.width
            top: parent.top
        }
        border.color: "#000"
        border.width: root.borderWidth
        Text {
            id: content_text
            width: parent.width - content_text.anchors.leftMargin * 2
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 30
            }
            wrapMode: Text.Wrap
            text: root.content
            font.pixelSize: 25
        }
    }
}
