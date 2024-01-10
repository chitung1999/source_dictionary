import QtQuick 2.12
import QtQuick.Window 2.12
import AppEnum 1.0
import "Component/Banner"

Window {
    id: root
    visible: true
    visibility:  Window.Maximized
    minimumWidth: 960
    minimumHeight: 500
    title: "Dictionary"

    Item {
        width: 1920
        height: 1001
        anchors.centerIn: parent
        scale: parent.width / 1920

        Image {
            id: bg
            anchors.fill: parent
            source: SETTING.background != "" ? "file:///" + SETTING.background : "qrc:/img/bg_backup.jpg"
        }

        Banner {
            id: banner
            anchors.fill: parent
            state: AppEnum.NOTEBOOK
        }

        Loader {
            id: content
            anchors.fill: parent
            source: banner.loader
        }
    }
}
