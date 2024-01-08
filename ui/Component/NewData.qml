import QtQuick 2.0
import QtQuick.Controls 1.4
import "../Common"

Item {
    id: root

    Rectangle {
        id: bg
        anchors.fill: parent
        color: "#000"
        opacity: 0.5
        MouseArea {
            anchors.fill: parent
        }
    }

    Image {
        id: bg_box
        width: 1000
        height: 900
        anchors.centerIn: parent
        source: "qrc:/img/bg_popup.jpg"
        visible: false
    }

    BorderBase {
        id: box
        anchors.fill: bg_box
        source: bg_box
        borderWidth: 8
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
        border.width: 3
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
        border.width: 3
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

    Image {
        id: add_key
        width: 50
        height: 50
        anchors {
            top: keys.bottom
            topMargin: 15
            horizontalCenter: keys.horizontalCenter
        }
        source: "qrc:/img/add.png"
        MouseArea {
            anchors.fill: parent
            onPressed: parent.scale = 0.7
            onReleased: parent.scale = 1
            onClicked: {
                NOTEBOOK.popupAddItem(true, sendData(true))
            }
        }
    }

    Image {
        id: add_mean
        anchors {
            top: add_key.top
            horizontalCenter: means.horizontalCenter
        }
        width: 50
        height: 50
        source: "qrc:/img/add.png"
        MouseArea {
            anchors.fill: parent
            onPressed: parent.scale = 0.7
            onReleased: parent.scale = 1
            onClicked: {
                NOTEBOOK.popupAddItem(false, sendData(false))
            }
        }
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
            border.width: 3
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
            horizontalCenter: means.horizontalCenter
        }
        colorCenter: "#dadddb"
        colorOutside: "#fff"
        textColor: "#000"
        name: qsTr("OK") + CTRL.translator
        onClickButton: {
            CTRL.changeItemNote(sendData(true), sendData(false), notes.text)
            root.visible = false
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
