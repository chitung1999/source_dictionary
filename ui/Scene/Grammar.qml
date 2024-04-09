import QtQuick 2.0
import QtQuick.Controls 2.12
import "../Common/"
import "../Component/Grammar"

Item {
    id: root
    anchors.fill: parent

    Rectangle {
        id: box
        width: 1700
        height: 780
        radius: 35
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
            verticalCenterOffset: -10
        }
        border.width: 1
        border.color: "#45818E"
        opacity: 0.8
        color: SETTING.isThemeLight ? "#FFF" : "#343434"
    }

    ListView {
        id: list
        width: 1680
        height: 740
        clip: true
        anchors.centerIn: box
        currentIndex: GRAMMAR.currentIndex
        model: GRAMMAR
        delegate: GrammarItem {
            index: model.index
            formText: model.form
            structureText: model.structure

            MouseArea {
                anchors.fill: parent
                //onClicked: GRAMMAR.se
            }
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

        function reset() {
            for(var i = 0; i < list.count; i++) {
                list.itemAtIndex(i).isSearch = false
            }
        }
    }

    ButtonImage {
        id: add
        anchors {
            top: box.bottom
            topMargin: 20
            horizontalCenter: box.horizontalCenter
            horizontalCenterOffset: -200
        }

        source: "qrc:/img/add.png"
        onClickButton: CTRL.appendItemGrammar()
    }

    SearchBar {
        id: search

        property bool isSearch: false

        width: search.isSearch ? 800 : 600
        height: 60
        anchors {
            top: box.bottom
            topMargin: 20
            right: box.right
        }
        textLeft: search.isSearch ? 40 + result.width : 30
        onRequestSearch: requestButton(true)
        Keys.onReturnPressed: requestButton(true)

        ResultSearch {
            id: result
            anchors {
                left: parent.left
                leftMargin: 20
                verticalCenter: parent.verticalCenter
            }
            visible: search.isSearch
            onCancel: search.requestButton(false)
        }

        function requestButton(isSearch) {
            search.isSearch = isSearch
            if(isSearch) {
                list.reset()
                var listSearch = GRAMMAR.search(search.textInput)
                for(var i = 0; i < listSearch.length; i++) {
                    list.itemAtIndex(listSearch[i]).isSearch = true
                }
            } else {
                search.textInput = ""
                list.reset()
            }
        }
    }
}
