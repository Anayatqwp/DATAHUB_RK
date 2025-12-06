import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Popup {
    id: popup

    property var backend
    property var uiStrings
    property color cYellow: "#FFD700"
    signal loginSuccess()

    anchors.centerIn: parent
    width: 420
    height: 400
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    background: Rectangle {
        color: "#181818"
        border.color: popup.cYellow
        border.width: 1
        radius: 12


        layer.enabled: true
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 30
        spacing: 20

        // Иконка
        Text {
            text: "🔐"
            font.pointSize: 40
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: (popup.uiStrings && popup.uiStrings.pop_log_title) ? popup.uiStrings.pop_log_title : "ВХОД"
            color: "white"
            font.pointSize: 22
            font.bold: true
            font.family: "Impact"
            Layout.alignment: Qt.AlignHCenter
        }

        // Поля ввода
        TextField {
            id: logEmail
            placeholderText: "Email"
            Layout.fillWidth: true
            Layout.preferredHeight: 45
            color: "white"
            background: Rectangle {
                color: "#2A2A2A"
                radius: 6
                border.color: logEmail.activeFocus ? popup.cYellow : "#444"
            }
        }

        TextField {
            id: logPass
            placeholderText: "Пароль"
            echoMode: TextInput.Password
            Layout.fillWidth: true
            Layout.preferredHeight: 45
            color: "white"
            background: Rectangle {
                color: "#2A2A2A"
                radius: 6
                border.color: logPass.activeFocus ? popup.cYellow : "#444"
            }
        }

        Text {
            id: logErr
            text: (popup.uiStrings && popup.uiStrings.err_fail) ? popup.uiStrings.err_fail : "Ошибка доступа"
            color: "#FF5555"
            visible: false
            Layout.alignment: Qt.AlignHCenter
            font.pointSize: 12
        }

        Item { Layout.fillHeight: true }

        Button {
            text: (popup.uiStrings && popup.uiStrings.btn_enter) ? popup.uiStrings.btn_enter : "ВОЙТИ"
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            background: Rectangle {
                color: parent.down ? "#CCAA00" : popup.cYellow
                radius: 8
            }
            contentItem: Text {
                text: parent.text
                color: "black"
                font.bold: true
                font.pointSize: 14
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            onClicked: {
                if (popup.backend.loginUser(logEmail.text, logPass.text)) {
                    logErr.visible = false
                    popup.loginSuccess()
                    popup.close()
                } else {
                    logErr.visible = true
                }
            }
        }
    }
}
