import QtQuick 2.0
import QtQuick.Controls 2.14
import QtMultimedia 5.14

Item {
    id: root
    width: 1700
    height: 680

    TableBase {
        id: key
        width: parent.width
        height: 120
        title: "Key"

        Text {
            id: key_word
            anchors {
                left: parent.left
                leftMargin: 300
                verticalCenter: parent.verticalCenter
                verticalCenterOffset: 25
            }
            font.pixelSize: 25
            text: DICTIONARY.key
        }
        Text {
            id: phonetic
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
                verticalCenterOffset: 25
            }
            font.pixelSize: 25
            text: DICTIONARY.phonetic
        }
        Image {
            id: audio_icon
            anchors {
                right: parent.right
                rightMargin: 300
                verticalCenter: parent.verticalCenter
                verticalCenterOffset: 25
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
    }
    TableBase {
        id: meanings
        width: parent.width
        height: parent.height - key.height
        anchors.top: key.bottom
        title: "Meanings"
        ListView {
            width: parent.width
            height: parent.height - 50
            anchors.bottom: parent.bottom
            clip: true
            model: DICTIONARY.means.length
            delegate: MeanItem {
                itemIndex: index
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
}
