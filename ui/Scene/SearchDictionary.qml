import QtQuick 2.0
import "../Common/"
import "../Component/Dictionary"

Item {
    id: root

    SearchBar {
        id: search
        width: 500
        height: 60
        anchors {
            top: parent.top
            topMargin: 100
            horizontalCenter: parent.horizontalCenter
        }
        textLeft: 30
        onRequestSearch: searchKey()
        Keys.onReturnPressed: searchKey()

        function searchKey() {
            DICTIONARY.search(search.textInput)
            search.textInput = ""
            results.visible = true
        }
    }

    DictionaryResults {
        id: results
        anchors {
            top: parent.top
            topMargin: 200
            horizontalCenter: parent.horizontalCenter
        }
        visible: false
    }
}
