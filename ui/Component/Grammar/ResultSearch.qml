import QtQuick 2.0
import "../../Common"

Item {
    id: root

    width: count.width + cancel.width + fence.width + cancel.anchors.leftMargin + fence.anchors.leftMargin
    height: cancel.height
    visible: false

    signal cancel()

    Text {
        id: count
        anchors.verticalCenter: cancel.verticalCenter
        font.pixelSize: 20
        font.bold: true
        text: GRAMMAR.result + " results"
    }

    ButtonImage {
        id: cancel
        anchors {
            left: count.right
            leftMargin: 10
        }
        source: "qrc:/img/cancel.png"
        onClickButton: root.cancel()
    }

    Rectangle {
        id: fence
        anchors {
            left: cancel.right
            leftMargin: 20
            verticalCenter: cancel.verticalCenter
        }
        width: 2
        height: 30
        color: "#000"
    }
}
