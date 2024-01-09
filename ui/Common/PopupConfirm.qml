import QtQuick 2.0

Item {
    id: root
    visible: false

    property string message: CTRL.popupConfirm

    signal confirm()

    Rectangle {
        anchors.fill: parent
        color: "#000"
        opacity: 0.5
    }

    MouseArea {
        anchors.fill: parent
    }

    Rectangle {
        id: box
        width: msg.width + 120
        height: msg.height + cancel_button.height + 180
        radius: 30
        anchors.centerIn: parent
        border.color: SETTING.borderColor
        border.width: 2
        color: "#eeeeee"
    }

    Text {
        id: msg
        text: root.message
        font.pixelSize: 40
        color: "black"
        anchors {
            horizontalCenter: box.horizontalCenter
            top: box.top
            topMargin: 60
        }
    }

    ButtonBase {
        id: cancel_button
        width: 200
        height: 50
        anchors {
            top: msg.bottom
            topMargin: 60
            horizontalCenter: box.horizontalCenter
            horizontalCenterOffset: - 150
        }
        colorCenter: "#dadddb"
        colorOutside: "#fff"
        textColor: "#000"
        name: qsTr("Cancel") + CTRL.translator
        onClickButton: root.visible = false
    }

    ButtonBase {
        id: ok_button
        width: 200
        height: 50
        anchors {
            bottom: cancel_button.bottom
            horizontalCenter: box.horizontalCenter
            horizontalCenterOffset: 150
        }
        colorCenter: "#dadddb"
        colorOutside: "#fff"
        textColor: "#000"
        name: qsTr("OK") + CTRL.translator
        onClickButton: {
            root.confirm()
            root.visible = false
        }
    }

    Connections {
        target: CTRL
        function onPopupConfirmChanged() {
            root.visible = true
        }
    }
}
