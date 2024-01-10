import QtQuick 2.0
import "../../Common"

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

    ButtonImage {
        id: modify
        anchors {
            left: root.right
            leftMargin: 20
            verticalCenter: root.verticalCenter
            verticalCenterOffset: -25
        }
        visible: !root.isModify
        opacityExited: 0.5
        source: "qrc:/img/edit.png"
        onClickButton: root.isModify = true
    }
    ButtonImage {
        id: done
        anchors.fill: modify
        visible: root.isModify
        source: "qrc:/img/ok.png"
        onClickButton: {
            root.isModify = false
            CTRL.changedItemGrammar(root.index, form.text, structure.text)
        }
    }
    ButtonImage {
        id: remove
        anchors {
            right: modify.right
            verticalCenter: root.verticalCenter
            verticalCenterOffset: 15
        }
        opacityExited: 0.5
        source: "qrc:/img/remove.png"
        onClickButton: CTRL.receiveConf(root.index)
    }
}
