import QtQuick 2.0

Item {
    id: root

    signal click();
    property string source

    width: parent.width / 5
    height: parent.height
    Image {
        id: img
        width: 35
        height: 35
        anchors.centerIn: parent
        source: root.source
    }
    MouseArea {
        anchors.fill: parent
        onClicked: root.click()
    }
}
