import QtQuick 2.0

Item {
    id: root

    signal click();
    property string source
    property string title
    property color colorText

    width: parent.width / 5
    height: parent.height
    Image {
        id: img
        width: 35
        height: 35
        anchors {
            verticalCenter: parent.verticalCenter
            verticalCenterOffset: -10
            horizontalCenter: parent.horizontalCenter
        }
        source: root.source
    }
    Text {
        id: title
        anchors {
            top: img.bottom
            topMargin: 2
            horizontalCenter: img.horizontalCenter
        }
        font.pixelSize: 15
        text: root.title
        color: root.colorText
    }
    MouseArea {
        anchors.fill: parent
        onClicked: root.click()
    }
}
