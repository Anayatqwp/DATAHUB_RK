import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root


    property int uniIndex: 0
    property var backend
    property color cYellow: "#FFD700"
    property var allUnis: []
    property var uniDetails: root.backend ? root.backend.getUniversityDetails(root.uniIndex) : {}

    width: 450
    height: 600

    ColumnLayout {
        anchors.fill: parent
        spacing: 15


        ComboBox {
            id: localCombo
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            model: root.allUnis
            currentIndex: root.uniIndex


            onCurrentIndexChanged: root.uniIndex = currentIndex


            contentItem: Text {
                leftPadding: 15
                text: localCombo.displayText
                font.pixelSize: 18
                font.bold: true
                color: root.cYellow
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }


            background: Rectangle {
                color: localCombo.pressed ? "#2A2A2A" : "#1E1E1E"
                border.color: root.cYellow
                border.width: 2
                radius: 8
            }


            popup: Popup {
                y: localCombo.height - 1
                width: localCombo.width
                implicitHeight: contentItem.implicitHeight
                padding: 1
                contentItem: ListView {
                    clip: true
                    implicitHeight: contentHeight
                    model: localCombo.popup.visible ? localCombo.delegateModel : null
                    currentIndex: localCombo.highlightedIndex
                    ScrollIndicator.vertical: ScrollIndicator { }
                }
                background: Rectangle {
                    color: "#1E1E1E"
                    border.color: root.cYellow
                    radius: 8
                }
            }


            delegate: ItemDelegate {
                width: localCombo.width
                height: 50
                contentItem: Text {
                    text: modelData
                    color: hovered ? "black" : "white"
                    font.pixelSize: 16
                    font.bold: true
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 15
                }
                background: Rectangle {
                    color: hovered ? root.cYellow : "transparent"
                    radius: 4
                }
            }
        }


        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            ColumnLayout {
                width: parent.width
                spacing: 10


                property var uniDetails: root.backend ? root.backend.getUniversityDetails(root.uniIndex) : {}

                InfoBox { title: "📍 Город"; text: parent.details.city || "Загрузка..." }
                InfoBox { title: "💯 Ср. Проходной балл"; text: (parent.details.avgPassScore || "0") + " / 140" }
                InfoBox { title: "📚 Популярные специальности"; text: (parent.details.popularMajors || "").replaceAll("\n", ", ") }
                InfoBox { title: "🏛️ О ВУЗе"; text: (parent.details.about || "").substring(0, 150) + "..." }
                InfoBox { title: "🌍 Партнеры"; text: (parent.details.partners || "").split('\n')[0] + "..." }
                InfoBox { title: "💼 Трудоустройство"; text: (parent.details.stats || "").split('\n').filter(s => s.includes('Трудоустройство'))[0] || "-" }
                InfoBox { title: "📊 Рейтинг"; text: (parent.details.stats || "").split('\n').filter(s => s.includes('Rank'))[0] || "-" }
            }
        }
    }
}
