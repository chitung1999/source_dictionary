import QtQuick 2.0
import QtQuick.Controls 1.4
import "../../Common"

Item {
    id: root

    Rectangle {
        id: bg
        anchors.fill: parent
        color: "#000"
        opacity: 0.5
    }

    Rectangle {
        id: box
        width: 1000
        height: 900
        radius: 30
        border.width: 2
        border.color: SETTING.borderColor
        anchors.centerIn: parent
        gradient: Gradient {
            GradientStop { position: - 0.3; color: "#969696" }
            GradientStop { position: 0.5; color: SETTING.themeColor }
            GradientStop { position: 1.3; color: "#969696" }
        }
    }

    Text {
        id: keys_title
        anchors {
            top: box.top
            topMargin: 30
            horizontalCenter: keys.horizontalCenter
        }
        font.pixelSize: 30
        font.bold: true
        color: "#fff"
        text: qsTr("Words") + CTRL.translator
    }

    Text {
        id: means_title
        anchors {
            top: keys_title.top
            horizontalCenter: means.horizontalCenter
        }
        font.pixelSize: 30
        font.bold: true
        color: "#fff"
        text: qsTr("Means") + CTRL.translator
    }

    Text {
        id: notes_title
        anchors {
            bottom: notes.top
            bottomMargin: 20
            horizontalCenter: notes.horizontalCenter
        }
        font.pixelSize: 30
        font.bold: true
        color: "#fff"
        text: qsTr("Notes") + CTRL.translator
    }

    Rectangle {
        id: keys
        width: 400
        height: 360
        radius: 20
        anchors {
            top: box.top
            left: box.left
            topMargin: 80
            leftMargin: 50
        }
        border.color: SETTING.borderColor
        border.width: 1
        color: "#eeeeee"

        ListView {
            id: list_key
            width: parent.width
            height: parent.height - 20
            anchors.centerIn: parent
            clip: true
            model: NEWDATA.keys
            delegate: NewDataItem {
                text: NEWDATA.keys[index]
            }
        }
    }

    Rectangle {
        id: means
        width: keys.width
        height: keys.height
        radius: keys.radius
        anchors {
            top: keys.top
            right: box.right
            rightMargin: 50
        }
        border.color: SETTING.borderColor
        border.width: 1
        color: "#eeeeee"

        ListView {
            id: list_mean
            width: parent.width
            height: parent.height - 20
            anchors.centerIn: parent
            clip: true
            model: NEWDATA.means
            delegate: NewDataItem {
                text: NEWDATA.means[index]
            }
        }
    }

    ButtonImage {
        id: add_key
        width: 50
        height: 50
        anchors {
            top: keys.bottom
            topMargin: 15
            horizontalCenter: keys.horizontalCenter
        }
        source: "qrc:/img/add.png"
        onClickButton: NOTEBOOK.popupAddItem(true, sendData(true))
    }

    ButtonImage {
        id: add_mean
        width: 50
        height: 50
        anchors {
            top: add_key.top
            horizontalCenter: means.horizontalCenter
        }
        source: "qrc:/img/add.png"
        onClickButton: NOTEBOOK.popupAddItem(false, sendData(false))
    }

    TextArea {
        id: notes
        width: 900
        height: 250
        anchors {
            bottom: box.bottom
            bottomMargin: 100
            horizontalCenter: box.horizontalCenter
        }
        font.pixelSize: 25
        text: NEWDATA.notes

        Rectangle {
            anchors.fill: parent
            border.color: SETTING.borderColor
            border.width: 1
            color: "transparent"
        }
    }

    ButtonBase {
        id: cancel_button
        width: 200
        height: 50
        anchors {
            bottom: box.bottom
            bottomMargin: 30
            horizontalCenter: keys.horizontalCenter
        }
        color: "#dadddb"
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
            horizontalCenter: means.horizontalCenter
        }
        color: "#dadddb"
        textColor: "#000"
        name: qsTr("OK") + CTRL.translator
        onClickButton: {
            CTRL.changeItemNote(sendData(true), sendData(false), notes.text)
            root.visible = false
        }
    }


    Connections {
        target: NOTEBOOK
        function onRequestChangedData() {
            root.visible = true
        }
    }

    function sendData(isKeys) {
        var list = []
        var i
        for(i = 0; i < (isKeys ? list_key.count : list_mean.count); i++)
            list.push(isKeys ? list_key.itemAtIndex(i).text : list_mean.itemAtIndex(i).text)
        return list
    }
}
