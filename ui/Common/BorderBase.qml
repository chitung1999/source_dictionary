import QtQuick 2.0
import QtGraphicalEffects 1.14

Item {
    id: root

    property Item source: Item
    property int radius: 20
    property int borderWidth: 1
    property string borderColor: "#45818E"

    OpacityMask {
        id: mask
        anchors.fill: parent
        source: root.source
        maskSource: box
    }

    Rectangle {
        id: box
        anchors.fill: parent
        radius: root.radius
        visible: false
    }

    Rectangle {
        id: border
        anchors.fill: parent
        radius: root.radius
        border.color: root.borderColor
        border.width: root.borderWidth
        color: "transparent"
    }
}
