import QtQuick 2.0

Item {
    id: root

    width: img.sourceSize.width
    height: img.sourceSize.height

    property string source
    property double opacityExited: 1
    property double scalePressed: 0.7

    signal clickButton()

    Image {
        id: img
        width: parent.width
        height: parent.height
        source: root.source
        opacity: root.opacityExited
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: img.opacity = 1
        onExited: img.opacity = root.opacityExited
        onPressed: img.scale = root.scalePressed
        onReleased: img.scale = 1
        onClicked: root.clickButton()
    }
}
