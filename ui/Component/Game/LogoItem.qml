import QtQuick 2.0

Item {
    id: root
    width: logo.sourceSize.width
    height: logo.sourceSize.height

    property string source
    property bool isLeft: true

    Image {
        id: logo
        source: root.source
    }

    ParallelAnimation {
        id: logoAni
        running: false
        property int dur: 1500
        NumberAnimation {
            target: logo
            property: "rotation"
            from: 0
            to: (root.isLeft ? - 360 : 360) * 3
            duration: logoAni.dur
        }
        NumberAnimation {
            target: logo
            property: "x"
            from: 0
            to: root.isLeft ? -1100 : 1400
            duration: logoAni.dur
            easing.type: Easing.InOutCubic
        }
    }

    function startAni(isLeft) {
        root.isLeft = isLeft
        logoAni.start()
    }

    function reset() {
        logo.x = 0
    }
}
