import QtQuick 2.0
import QtQuick.Controls 1.4
import "../Common/"
import "../Component/"

Item {
    anchors.fill: parent

    NoteResults {
        id: results
        width: 1160
        height: 680
        anchors {
            top: parent.top
            topMargin: 200
            left: parent.left
            leftMargin: 100
        }
    }

    SearchBar {
        id: search
        anchors.fill: parent
    }

    ListWord {
        id: list
        anchors.right: parent.right
    }

    Rectangle {
        id: random
        width: 700
        height: 70
        radius: 35
        anchors {
            right: results.right
            verticalCenter: results.verticalCenter
            verticalCenterOffset: 400
        }
        color: "#fff"
        border.width: 3
        border.color: "#45818E"

        Text {
            id: randomKey
            width: 640
            font.pixelSize: 30
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            elide: Text.ElideRight
            text: NOTEBOOK.randomKey
            onTextChanged: {
                randomKey.opacity = 0
                randomKeyAni.start()
            }
        }
    }

    SequentialAnimation {
        id: randomKeyAni
        running: false
        property int dur: 300
        NumberAnimation {
            target: random
            properties: "height"
            from: 70
            to: 0
            duration: randomKeyAni.dur
        }
        ParallelAnimation {
            NumberAnimation {
                target: random
                properties: "height"
                from: 0
                to: 70
                duration: randomKeyAni.dur
            }
            NumberAnimation {
                target: randomKey
                properties: "opacity"
                from: 0
                to: 1
                duration: randomKeyAni.dur * 2
            }
        }
    }
}
