import QtQuick 2.0
import AppEnum 1.0
import "../../Common"

Item {
    id: root
    width: 900
    height: 600

    ButtonBase {
        id: btn1
        width: 200
        height: 80
        radius: 10
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
            verticalCenterOffset: -60
        }
        textColor: SETTING.isThemeLight ? "#000" : "#FFF"
        visible: false
        onClickButton: btn1_request()
    }

    ButtonBase {
        id: btn2
        width: 200
        height: 80
        radius: 10
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
            verticalCenterOffset: 60
        }
        textColor: SETTING.isThemeLight ? "#000" : "#FFF"
        visible: false
        onClickButton: btn2_request()
    }

    TextInputBase {
        id: text_input
        visible: false
        boxWidth: 250
        boxHeight: 60
        boxLeft: text_input.textLeft + 20
        anchors {
            horizontalCenter: root.horizontalCenter
            verticalCenter: root.verticalCenter
        }
        onTextChanged: text_request()
    }

    states: [
        State {
            name: AppEnum.LANGUAGE
            PropertyChanges {target: btn1; name: "English"; color: SETTING.language == AppEnum.ENGLISH ? "#2986CC" : "transparent"; visible: true}
            PropertyChanges {target: btn2; name: "Tiếng Việt"; color: SETTING.language == AppEnum.VIETNAMESE ? "#2986CC" : "transparent"; visible: true}
        },
        State {
            name: AppEnum.BACKGROUND
            PropertyChanges {
                target: text_input
                anchors.horizontalCenterOffset: - 20
                title: qsTr("Path")
                boxWidth: root.width - text_input.boxLeft - 100
                content: SETTING.background
            }
            PropertyChanges {target: text_input; visible: true}
        },
        State {
            name: AppEnum.DATA
            PropertyChanges {
                target: text_input
                anchors.horizontalCenterOffset: - 20
                title: qsTr("Path")
                boxWidth: root.width - text_input.boxLeft - 100
                content: SETTING.pathData
            }
            PropertyChanges {target: text_input; visible: true}
        },
        State {
            name: AppEnum.THEME
            PropertyChanges {target: btn1; name: qsTr("Light") + CTRL.translator; color: SETTING.isThemeLight? "#2986CC" : "transparent"; visible: true}
            PropertyChanges {target: btn2; name: qsTr("Dark") + CTRL.translator; color: !SETTING.isThemeLight? "#2986CC" : "transparent"; visible: true}
        }
    ]

        function btn1_request() {
            switch(parseInt(root.state)) {
            case AppEnum.LANGUAGE:
                CTRL.setLanguage(AppEnum.ENGLISH)
                break
            case AppEnum.THEME:
                CTRL.setTheme(true)
                break
            default:
                break
            }
        }

        function btn2_request() {
            switch(parseInt(root.state)) {
            case AppEnum.LANGUAGE:
                CTRL.setLanguage(AppEnum.VIETNAMESE)
                break
            case AppEnum.THEME:
                CTRL.setTheme(false)
                break
            default:
                break
            }
        }

    function text_request() {
        switch(parseInt(root.state)) {
        case AppEnum.BACKGROUND:
            CTRL.setBackground(text_input.textInput)
            break
        case AppEnum.DATA:
            CTRL.setPathData(text_input.textInput)
            break
        default:
            break
        }
    }
}
