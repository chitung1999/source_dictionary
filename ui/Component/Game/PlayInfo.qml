import QtQuick 2.0

Item {
    id: root
    width: award.sourceSize.width
    height: award.sourceSize.height

    Image {
        id: award
        source: "qrc:/img/award.png"
    }

    Rectangle {
        id: percent
        width: 200
        height: 10
        radius: 5
        anchors {
            top: award.bottom
            topMargin: 50
            horizontalCenter: award.horizontalCenter
        }
        color: "#cf3e2b"
        Rectangle {
            width: parent.width * ((GAME.correct == 0 && GAME.incorrect == 0) ? 1 :
                                    GAME.correct / (GAME.correct + GAME.incorrect))
            height: parent.height
            radius: parent.radius
            color: "#44c41f"
        }
    }

    Text {
        id: correct_count
        anchors {
            verticalCenter: percent.verticalCenter
            right: percent.left
            rightMargin: 20
        }
        font.bold: true
        font.pixelSize: 45
        color: "#44c41f"
        text: GAME.correct
    }

    Text {
        id: incorrect_count
        anchors {
            verticalCenter: percent.verticalCenter
            left: percent.right
            leftMargin: correct_count.anchors.rightMargin
        }
        font.bold: true
        font.pixelSize: correct_count.font.pixelSize
        color: "#cf3e2b"
        text: GAME.incorrect
    }

    Text {
        id: correct
        anchors {
            top: percent.bottom
            topMargin: 20
            horizontalCenter: correct_count.horizontalCenter
        }
        font.pixelSize: 25
        color: "#44c41f"
        text: "CORRECT"
    }

    Text {
        id: incorrect
        anchors {
            top: correct.top
            horizontalCenter: incorrect_count.horizontalCenter
        }
        color: "#cf3e2b"
        font.pixelSize: correct.font.pixelSize
        text: "INCORRECT"
    }
}
