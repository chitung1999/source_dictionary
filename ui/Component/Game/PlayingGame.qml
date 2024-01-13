import QtQuick 2.0
import QtQuick.Controls 2.12
import "../../Common/"

Item {
    id: root

    property bool isCorrect: true

    PlayInfo {
        id: play_info
        anchors {
            top: parent.top
            topMargin: 150
            right: parent.right
            rightMargin: 200
        }
    }

    Text {
        id: state
        anchors {
            horizontalCenter: result_box.horizontalCenter
            top: parent.top
            topMargin: 100
        }
        font.bold: true
        font.pixelSize: 55
        color: root.isCorrect ? "#44c41f" : "#cf3e2b"
        text: root.isCorrect ? "CORRECT!" : "INCORRECT!"
        visible: false
    }

    Text {
        id: question
        width: 900
        height: 300
        anchors {
            left: parent.left
            leftMargin: result_box.anchors.leftMargin - 100
            top: parent.top
            topMargin: 130
        }
        color: "#008896"
        font.pixelSize: 50
        font.bold: true
        text: GAME.question + "<font color = '%1'>%2</font>".arg(state.visible ? state.color : "#008896")
        .arg(state.visible ? GAME.answer : "...")
        textFormat: Text.RichText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.Wrap
    }

    Rectangle {
        id: result_box
        width: 700
        height: 100
        radius: 20
        anchors {
            top: parent.top
            topMargin: 410
            left: parent.left
            leftMargin: 250
        }
        border.color: "#008896"
        border.width: 6
        color: "transparent"
    }
    TextInput {
        id: result
        width: result_box.width - result.anchors.leftMargin * 2
        anchors {
            left: result_box.left
            leftMargin: 40
            verticalCenter: result_box.verticalCenter
        }
        color: state.visible ? state.color : "#008896"
        font.pixelSize: 40
        font.bold: true
        clip: true
        horizontalAlignment: TextInput.AlignHCenter

        Keys.onReturnPressed: {
            if(state.visible) {
                next()
            } else {
                root.isCorrect = GAME.check(result.text)
                state.visible = true
            }
        }
    }

    ButtonBase {
        id: button_next
        width: 300
        height: 120
        radius: 30
        anchors {
            horizontalCenter: result_box.horizontalCenter
            verticalCenter: button_end.verticalCenter
        }
        border.width: 6
        border.color: "#008896"
        visible: state.visible
        onClickButton: next()
        Image {
            anchors.centerIn: parent
            scale: 0.8
            source: "qrc:/img/right_arrow.png"
        }
    }

    ButtonBase {
        id: button_end
        width: 300
        height: 120
        radius: 30
        anchors {
            horizontalCenter: play_info.horizontalCenter
            verticalCenter: parent.verticalCenter
            verticalCenterOffset: 280
        }
        border.width: 6
        border.color: "#008896"
        name: "END GAME"
        textColor: "#008896"
        textSize: 40
        onClickButton: {
            state.visible = false
            result.text = ""
            GAME.stop()
        }
    }

    function next() {
        state.visible = false
        result.text = ""
        GAME.next()
    }
}
