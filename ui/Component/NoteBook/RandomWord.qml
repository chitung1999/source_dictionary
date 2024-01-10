import QtQuick 2.0

Item {
    id: root

    Rectangle {
        id: box
        width: parent.width
        height: parent.height
        radius: root.height
        anchors.centerIn: parent

        gradient: Gradient {
                    GradientStop { position: -1; color: "transparent" }
                    GradientStop { position: 0.5; color: "#fff" }
                    GradientStop { position: 2; color: "transparent" }
                }
        border.width: 3
        border.color: SETTING.borderColor

        Text {
            id: key
            width: 640
            font.pixelSize: 30
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            elide: Text.ElideRight
            text: NOTEBOOK.randomKey
            onTextChanged: {
                key.opacity = 0
                randomAni.start()
            }
        }
    }

    SequentialAnimation {
        id: randomAni
        running: false
        property int dur: 300
        NumberAnimation {
            target: box
            properties: "height"
            from: root.height
            to: 0
            duration: randomAni.dur
        }
        ParallelAnimation {
            NumberAnimation {
                target: box
                properties: "height"
                from: 0
                to: root.height
                duration: randomAni.dur
            }
            NumberAnimation {
                target: key
                properties: "opacity"
                from: 0
                to: 1
                duration: randomAni.dur * 2
            }
        }
    }
}
