import QtQuick 2.0

Item {
    id: root
    width: parent.width
    height: 90 * root.count

    property int itemIndex
    property int count: (DICTIONARY.means[itemIndex].length - 3) / 2

    Rectangle {
        id: part_speech
        width: 130
        height: parent.height
        border.color: "#000"
        Text {
            anchors.centerIn: parent
            font.pixelSize: 18
            font.bold: true
            text:  DICTIONARY.means[itemIndex][0]
        }
    }

    Rectangle {
        id: synonyms
        anchors.left: part_speech.right
        width: 260
        height: parent.height
        border.color: "#000"
        Text {
            anchors {
                left: parent.left
                leftMargin: 10
                verticalCenter: parent.verticalCenter
            }
            wrapMode: Text.Wrap
            width: 240
            font.pixelSize: 20
            text: "<p><b>❁ Synonyms: </b></p>" + DICTIONARY.means[itemIndex][1]
        }
    }

    Rectangle {
        id: antonyms
        anchors.left: synonyms.right
        width: 260
        height: parent.height
        border.color: "#000"
        Text {
            anchors {
                left: parent.left
                leftMargin: 10
                verticalCenter: parent.verticalCenter
            }
            wrapMode: Text.Wrap
            width: 240
            font.pixelSize: 20
            text: "<p><b>❁ Antonyms: </b></p>" + DICTIONARY.means[itemIndex][2]
        }
    }

    Column {
        Repeater {
            model: root.count
            Rectangle {
                x: 130 * 5
                width: root.width - 130 * 5
                height: 90
                border.color: "black"

                Text {
                    anchors {
                        left: parent.left
                        leftMargin: 10
                        top: parent.top
                        topMargin: 5
                    }
                    wrapMode: Text.Wrap
                    width: parent.width - 20
                    font.pixelSize: 16
                    text: "<b>❁ Mean: </b>" + DICTIONARY.means[itemIndex][index * 2 + 3]
                }

                Text {
                    anchors {
                        left: parent.left
                        leftMargin: 10
                        top: parent.top
                        topMargin: 45
                    }
                    wrapMode: Text.Wrap
                    width: parent.width - 20
                    font.pixelSize: 16
                    text: "<b>❁ Ex: </b>" + DICTIONARY.means[itemIndex][index * 2 + 4]
                }
            }
        }
    }
}
