import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Popup {
    id: popup

    property var uiStrings
    property color cYellow: "#FFD700"

    property var favModel

    anchors.centerIn: parent
    width: 450
    height: 500
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    background: Rectangle {
        color: "#181818"
        border.color: popup.cYellow
        border.width: 2
        radius: 12
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 25
        spacing: 15

        Text {
            text: "⭐ " + (popup.uiStrings && popup.uiStrings.lbl_fav ? popup.uiStrings.lbl_fav : "ИЗБРАННОЕ")
            color: popup.cYellow
            font.pointSize: 22
            font.bold: true
            font.family: "Impact"
            Layout.alignment: Qt.AlignHCenter
        }

        ListView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            model: popup.favModel


            Text {
                visible: popup.favModel.count === 0
                text: "Пока ничего нет.\nНажми на звездочку на главной!"
                color: "gray"
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 14
            }

            delegate: Rectangle {
                width: parent.width
                height: 60
                color: "transparent"
                border.color: "#333"
                border.width: 1
                radius: 8

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    Text {
                        text: "🎓"
                        font.pointSize: 20
                    }
                    Text {
                        text: model.uniName
                        color: "white"
                        font.bold: true
                        font.pointSize: 16
                        Layout.fillWidth: true
                    }
                    Text {
                        text: "✔️"
                        color: popup.cYellow
                        font.pointSize: 16
                    }
                }
            }
        }

        Button {
            text: "ЗАКРЫТЬ"
            Layout.fillWidth: true
            background: Rectangle { color: "#333"; radius: 8 }
            contentItem: Text { text: parent.text; color: "white"; font.bold: true; horizontalAlignment: Text.AlignHCenter }
            onClicked: popup.close()
        }
    }
}
