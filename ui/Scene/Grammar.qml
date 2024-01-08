import QtQuick 2.0
import QtQuick.Controls 2.12
import "../Common/"
import "../Component/"

Item {
    anchors.fill: parent

    Rectangle {
        id: box
        width: 1700
        height: 780
        radius: 35
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
            verticalCenterOffset: -10
        }
        border.width: 3
        border.color: SETTING.borderColor
        opacity: 0.8
    }

    ListView {
        id: list
        width: 1680
        height: 740
        clip: true
        anchors.centerIn: box
        model: GRAMMAR
        delegate: GrammarItem {
            index: model.index
            formText: model.form
            structureText: model.structure
        }

        ScrollBar.vertical: ScrollBar {
            background: Rectangle {
                implicitWidth: 10
                color: "transparent"
            }
            contentItem: Rectangle {
                implicitWidth: 10
                radius: 5
                color: "gray"
            }
        }
    }

    Image {
        id: add
        anchors {
            top: box.bottom
            topMargin: 20
            horizontalCenter: box.horizontalCenter
        }

        source: "qrc:/img/add.png"
        MouseArea {
            anchors.fill: parent
            onPressed: parent.scale = 0.7
            onReleased: parent.scale = 1
            onClicked: {
                onClicked: CTRL.appendItemGrammar();
            }
        }
    }
}
