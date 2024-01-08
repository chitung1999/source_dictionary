import QtQuick 2.0
import QtQuick.Controls 2.14
import QtMultimedia 5.14
import "../Common"

Item {
    id: root
    width: 1700
    height: 680

    Item {
        id: box
        anchors.fill: parent
        visible: false
        TableVBase {
            id: key
            width: parent.width
            height: 120
        }
        TableVBase {
            id: meanings
            width: parent.width
            height: parent.height - key.height
            anchors.top: key.bottom
        }
    }

    BorderBase {
        anchors.fill: parent
        source: box
        opacity: 0.8
        borderWidth: 3
    }

    Text {
        id: key_title
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 10
        }
        font.pixelSize: 20
        font.bold: true
        color: "#FFF"
        text: qsTr("Key") + CTRL.translator
    }

    Text {
        id: means_title
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 130
        }
        font.pixelSize: 20
        font.bold: true
        color: "#FFF"
        text: qsTr("Result") + CTRL.translator
    }

    Text {
        id: key_word
        anchors {
            left: parent.left
            leftMargin: 300
            top: parent.top
            topMargin: 70
        }
        font.pixelSize: 25
        text: DICTIONARY.key
    }
    Text {
        id: phonetic
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: key_word.verticalCenter
        }
        font.pixelSize: 25
        text: DICTIONARY.phonetic
    }
    Image {
        id: audio_icon
        anchors {
            right: parent.right
            rightMargin: 300
            verticalCenter: key_word.verticalCenter
        }
        width: 40
        height: 40
        source: "qrc:/img/volume.png"
        MouseArea {
            anchors.fill: audio_icon
            onPressed: audio_icon.scale = 0.7
            onReleased: audio_icon.scale = 1
            onClicked: audio.play()
        }
    }
    Audio {
        id: audio
        source: DICTIONARY.urlAudio
    }

    ListView {
        width: parent.width
        height: parent.height - 120 - 50
        anchors.bottom: parent.bottom
        clip: true
        model: LISTMEAN

        delegate: MeanItem {
            partSpeed: model.part
            synonyms: model.synonyms
            antonyms: model.antonyms
            definitions: model.definitions
        }

        ScrollBar.vertical: ScrollBar {
            background: Rectangle {
                implicitWidth: 10
                color: "transparent"
            }
            contentItem: Rectangle {
                implicitWidth: 10
                radius: 5
                color: "gray"
            }
        }
    }
}
