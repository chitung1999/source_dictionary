import QtQuick 2.0

Item {
    id: root
    width: parent.width

    property string partSpeed
    property string synonyms
    property string antonyms
    property var definitions

    Rectangle {
        id: box
        width: 520
        height: parent.height
        border.color: "#000"

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

    Column {
        Repeater {
            id: repeat
            model: root.definitions.length / 2
            Rectangle {
                x: box.width
                width: root.width - box.width
                height: definition.height + example.height + 15
                border.color: "black"

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
            height += repeat.itemAt(i).height
        }
        if(height < 150)
            height = 150
        return height
    }

    Component.onCompleted: root.height = rootHeight()
}
