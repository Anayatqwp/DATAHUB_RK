import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Popup {
    id: popup

    property var backend
    property var uiStrings
    property color cYellow: "#FFD700"

    anchors.centerIn: parent
    width: 500
    height: 650 // Чуть выше, чтобы влезли все поля
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    background: Rectangle {
        color: "#181818"
        border.color: popup.cYellow
        border.width: 2
        radius: 12
    }

    // Алиасы, чтобы Main.qml мог заполнять эти поля данными из бэкенда при открытии
    property alias surnameText: fSurname.text
    property alias nameText: fName.text
    property alias patrText: fPatr.text
    property alias iinText: fIIN.text
    property alias phoneText: fPhone.text
    property alias cityText: fCity.text
    property alias scoreText: fScore.text
    property alias dateText: fDate.text

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 25
        spacing: 15

        Text {
            text: "👤 " + (popup.uiStrings && popup.uiStrings.lbl_profile ? popup.uiStrings.lbl_profile : "МОЙ ПРОФИЛЬ")
            color: popup.cYellow
            font.pointSize: 22
            font.bold: true
            font.family: "Impact"
            Layout.alignment: Qt.AlignHCenter
        }

        // Сетка для полей ввода (2 колонки)
        GridLayout {
            columns: 2
            columnSpacing: 15
            rowSpacing: 15
            Layout.fillWidth: true

            // --- ФИО ---
            TextField { id: fSurname; placeholderText: "Фамилия"; Layout.fillWidth: true; color: "white"; background: bgRect(fSurname) }
            TextField { id: fName; placeholderText: "Имя"; Layout.fillWidth: true; color: "white"; background: bgRect(fName) }

            TextField {
                id: fPatr; placeholderText: "Отчество"; Layout.fillWidth: true; Layout.columnSpan: 2
                color: "white"; background: bgRect(fPatr)
            }

            // --- ЛИЧНЫЕ ДАННЫЕ ---
            TextField { id: fDate; placeholderText: "Дата рожд. (01.01.2006)"; Layout.fillWidth: true; color: "white"; background: bgRect(fDate) }
            TextField { id: fIIN; placeholderText: "ИИН"; Layout.fillWidth: true; color: "white"; background: bgRect(fIIN) }

            // --- КОНТАКТЫ ---
            TextField { id: fPhone; placeholderText: "Телефон (+7...)"; Layout.fillWidth: true; color: "white"; background: bgRect(fPhone) }
            TextField { id: fCity; placeholderText: "Город проживания"; Layout.fillWidth: true; color: "white"; background: bgRect(fCity) }

            // --- ЕНТ ---
            TextField {
                id: fScore; placeholderText: "Балл ЕНТ (0-140)"; Layout.fillWidth: true; Layout.columnSpan: 2
                color: "white"; font.bold: true;
                background: bgRect(fScore)
                validator: IntValidator { bottom: 0; top: 140 }
            }
        }

        Item { Layout.fillHeight: true } // Распорка

        // Кнопка Сохранить
        Button {
            text: "💾 СОХРАНИТЬ ДАННЫЕ"
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
                // Сохраняем в C++
                popup.backend.saveProfile(
                    fSurname.text, fName.text, fPatr.text,
                    fDate.text, fIIN.text, fPhone.text,
                    fCity.text, parseInt(fScore.text)
                )
                popup.close()
            }
        }
    }

    // Вспомогательная функция для стиля полей
    function bgRect(field) {
        return Qt.createQmlObject('import QtQuick; Rectangle { color: "#2A2A2A"; radius: 6; border.color: parent.activeFocus ? "#FFD700" : "#444" }', field)
    }
}
