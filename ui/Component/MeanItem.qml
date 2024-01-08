import QtQuick 2.0

Item {
    id: root
    width: parent.width - 40

    property string partSpeed
    property string synonyms
    property string antonyms
    property var definitions

    Rectangle {
        id: box
        width: 520
        height: parent.height
        anchors {
            top: parent.top
            topMargin: 15
            left: parent.left
            leftMargin: 20
        }
        border.color: "#000"
        color: "transparent"

        Column {
            height: part_speech.height + synonyms_id.height + antonyms_id.height + spacing * 2
            anchors.verticalCenter: parent.verticalCenter
            spacing: 15
            Text {
                id: part_speech
                anchors.left: parent.left
                anchors.leftMargin: 20
                font.pixelSize: 30
                font.bold: true
                text:  root.partSpeed
            }

            Text {
                id: synonyms_id
                anchors {
                    left: parent.left
                    leftMargin: 40
                }
                wrapMode: Text.Wrap
                width: 460
                font.pixelSize: 20
                text: "❁ Synonyms: " + root.synonyms
            }

            Text {
                id: antonyms_id
                anchors {
                    left: parent.left
                    leftMargin: 40
                }
                wrapMode: Text.Wrap
                width: 460
                font.pixelSize: 20
                text: "❁ Antonyms: " + root.antonyms
            }
        }
    }
    property int itemHeight
    Column {
        anchors {
            top: box.top
            left: box.right
        }
        Repeater {
            id: repeat
            model: root.definitions.length / 2
            Rectangle {
                width: root.width - box.width
                border.color: "#000"
                color: "transparent"
                property int number: definition.height + example.height + 15

                Text {
                    id: definition
                    anchors {
                        left: parent.left
                        leftMargin: 20
                        top: parent.top
                        topMargin: 5
                    }
                    wrapMode: Text.Wrap
                    width: parent.width - 30
                    font.pixelSize: 16
                    text: "<b>❁ Mean: </b>" + root.definitions[index * 2]
                }

                Text {
                    id: example
                    anchors {
                        left: definition.left
                        top: definition.bottom
                        topMargin: 5
                    }
                    wrapMode: Text.Wrap
                    width: parent.width - 30
                    font.pixelSize: 16
                    text: "<b>❁ Ex: </b>" + root.definitions[index * 2 + 1]
                }
            }
        }
    }

    function rootHeight() {
        var height = 0;
        for(var i = 0; i < root.definitions.length / 2; i++) {
            height += repeat.itemAt(i).number
        }

        for(i = 0; i < root.definitions.length / 2; i++) {
            repeat.itemAt(i).height = (height < 150 ? (300 / root.definitions.length) : repeat.itemAt(i).number)
        }

        return (height < 150 ? 150 : height)
    }

    Component.onCompleted: root.height = rootHeight()
}
