import QtQuick 2.0

Item {
    id: root
    width: 1580
    height: box.height + 10

    property bool isModify: false
    property int index
    property string formText
    property string structureText

    Rectangle {
        id: box
        width: parent.width - 20
        anchors {
            left: parent.left
            leftMargin: 20
        }
        height: form.height + structure.height + 15
        radius: 10
        border.color: SETTING.borderColor
        border.width: 2
        visible: root.isModify
    }
    Text {
        id: icon_form
        anchors {
            verticalCenter: form.verticalCenter
            left: box.left
            leftMargin: 20
        }
        font.pixelSize: 30
        font.bold: true
        text: "❁    "
    }
    TextInput {
        id: form
        width: parent.width - icon_form.width - icon_form.anchors.leftMargin - 40
        anchors {
            top: parent.top
            topMargin: 5
            left: icon_form.right
        }
        wrapMode: Text.Wrap
        font.pixelSize: 30
        font.bold: true
        readOnly: !root.isModify
        text: root.formText

        Keys.onReturnPressed: {
            root.isModify = false
            CTRL.changedItemGrammar(root.index, form.text, structure.text)
        }
    }
    Text {
        id: icon_structure
        anchors {
            top: structure.top
            left: box.left
            leftMargin: 100
        }
        font.pixelSize: 30
        text: qsTr("Structure: ")
    }
    TextInput {
        id: structure
        width: parent.width - icon_structure.width - icon_structure.anchors.leftMargin - 40
        anchors {
            top: form.bottom
            topMargin: 5
            left: icon_structure.right
        }
        wrapMode: Text.Wrap
        font.pixelSize: 30
        readOnly: !root.isModify
        text: root.structureText

        Keys.onReturnPressed: {
            root.isModify = false
            CTRL.changedItemGrammar(root.index, form.text, structure.text)
        }
    }

    Image {
        id: modify
        anchors {
            left: root.right
            leftMargin: 20
            verticalCenter: root.verticalCenter
            verticalCenterOffset: -25
        }
        opacity: 0.5
        visible: !root.isModify
        source: "qrc:/img/edit.png"
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: parent.opacity = 1
            onExited: parent.opacity = 0.5
            onPressed: parent.scale = 0.7
            onReleased: parent.scale = 1
            onClicked: {
                root.isModify = true
            }
        }
    }
    Image {
        id: done_modify
        anchors.fill: modify
        source: "qrc:/img/ok.png"
        visible: root.isModify
        MouseArea {
            anchors.fill: parent
            onPressed: parent.scale = 0.7
            onReleased: parent.scale = 1
            onClicked: {
                root.isModify = false
                CTRL.changedItemGrammar(root.index, form.text, structure.text)
            }
        }
    }

    Image {
        id: remove
        anchors {
            right: modify.right
            verticalCenter: root.verticalCenter
            verticalCenterOffset: 15
        }
        opacity: 0.5
        source: "qrc:/img/remove.png"
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: parent.opacity = 0.8
            onExited: parent.opacity = 0.4
            onPressed: parent.scale = 0.7
            onReleased: parent.scale = 1
            onClicked: CTRL.receiveConf(root.index)
        }
    }
}
