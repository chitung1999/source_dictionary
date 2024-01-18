import QtQuick 2.0
import AppEnum 1.0
import "../../Common"

Item {
    id: root
    width: 1580
    height: box.height + 10

    property bool isModify: false
    property bool isSearch: false
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
        opacity: 0.8
        color: root.isSearch ? "#ede12a" : "#FFF"
        visible: (root.isModify || root.isSearch)
    }
    Text {
        id: icon_form
        anchors {
            top: parent.top
            topMargin: 5
            left: box.left
            leftMargin: 30
        }
        font.pixelSize: 30
        font.bold: true
        text: "❁  "
    }
    TextInput {
        id: form
        width: parent.width - icon_form.width - icon_form.anchors.leftMargin - 40
        anchors {
            verticalCenter: icon_form.verticalCenter
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
        id: form_backup
        text: qsTr("Form")
        font.pixelSize: 30
        font.bold: true
        anchors.fill: form
        opacity: 0.4
        visible: form.text == ""
    }

    TextInput {
        id: structure
        width: parent.width - structure.anchors.leftMargin - 40
        anchors {
            top: form.bottom
            topMargin: 5
            left: box.left
            leftMargin: 100
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
    Text {
        id: structure_backup
        text: qsTr("Structure")
        font.pixelSize: 30
        anchors.fill: structure
        opacity: 0.4
        visible: structure.text == ""
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
        onClickButton: CTRL.receiveConf(AppEnum.GRAMMARITEM, root.index)
    }
}
