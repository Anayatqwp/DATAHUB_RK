import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Popup {
    id: popup

    property var backend
    property var uiStrings
    property color cYellow: "#FFD700"
    signal signupSuccess()

    anchors.centerIn: parent
    width: 420
    height: 500
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    background: Rectangle {
        color: "#181818"
        border.color: popup.cYellow
        border.width: 1
        radius: 12
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 30
        spacing: 15

        Text {
            text: "📝"
            font.pointSize: 40
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: (popup.uiStrings && popup.uiStrings.pop_sign_title) ? popup.uiStrings.pop_sign_title : "РЕГИСТРАЦИЯ"
            color: "white"
            font.pointSize: 22
            font.bold: true
            font.family: "Impact"
            Layout.alignment: Qt.AlignHCenter
        }

        TextField {
            id: regName
            placeholderText: "Ваше Имя"
            Layout.fillWidth: true; Layout.preferredHeight: 45
            color: "white"
            background: Rectangle { color: "#2A2A2A"; radius: 6; border.color: regName.activeFocus ? popup.cYellow : "#444" }
        }

        TextField {
            id: regEmail
            placeholderText: "Email"
            Layout.fillWidth: true; Layout.preferredHeight: 45
            color: "white"
            background: Rectangle { color: "#2A2A2A"; radius: 6; border.color: regEmail.activeFocus ? popup.cYellow : "#444" }
        }

        TextField {
            id: regPass
            placeholderText: "Придумайте пароль"
            echoMode: TextInput.Password
            Layout.fillWidth: true; Layout.preferredHeight: 45
            color: "white"
            background: Rectangle { color: "#2A2A2A"; radius: 6; border.color: regPass.activeFocus ? popup.cYellow : "#444" }
        }

        Text {
            id: regErr
            text: "Такой пользователь уже есть"
            color: "#FF5555"
            visible: false
            Layout.alignment: Qt.AlignHCenter
        }

        Item { Layout.fillHeight: true }

        Button {
            text: (popup.uiStrings && popup.uiStrings.btn_create) ? popup.uiStrings.btn_create : "СОЗДАТЬ АККАУНТ"
            Layout.fillWidth: true; Layout.preferredHeight: 50
            background: Rectangle { color: parent.down ? "#CCAA00" : popup.cYellow; radius: 8 }
            contentItem: Text { text: parent.text; color: "black"; font.bold: true; font.pointSize: 14; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
            onClicked: {
                if (popup.backend.registerUser(regName.text, regEmail.text, regPass.text)) {
                    regErr.visible = false
                    popup.signupSuccess()
                    popup.close()
                } else {
                    regErr.visible = true
                }
            }
        }
    }
}
