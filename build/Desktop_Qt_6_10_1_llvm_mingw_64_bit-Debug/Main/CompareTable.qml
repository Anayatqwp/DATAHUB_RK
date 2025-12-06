import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    property var backend
    property color cYellow: "#FFD700"


    property var tableData: backend ? backend.getComparisonTableData() : []

    ColumnLayout {
        anchors.fill: parent
        spacing: 0


        Rectangle {
            Layout.fillWidth: true
            height: 50
            color: "#333"

            RowLayout {
                anchors.fill: parent
                spacing: 2


                component HeaderTxt: Rectangle {
                    property int w: 100
                    property string txt: ""

                    Layout.fillHeight: true
                    Layout.preferredWidth: w
                    color: "#222"
                    Text {
                        text: txt
                        color: root.cYellow
                        font.bold: true
                        anchors.centerIn: parent
                        font.pixelSize: 13
                    }
                }

                HeaderTxt { txt: "ВУЗ"; w: 160 }
                HeaderTxt { txt: "Город"; w: 90 }
                HeaderTxt { txt: "Балл"; w: 60 }
                HeaderTxt { txt: "Рейтинг"; w: 80 }
                HeaderTxt { txt: "Работа"; w: 70 }
                HeaderTxt { txt: "Общеж."; w: 70 }
            }
        }


        ListView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            model: root.tableData

            delegate: Rectangle {
                width: parent.width
                height: 50
                color: index % 2 === 0 ? "#181818" : "#202020"

                RowLayout {
                    anchors.fill: parent
                    spacing: 2


                    component CellTxt: Item {
                        property int w: 100
                        property string txt: ""
                        property bool isBold: false

                        Layout.fillHeight: true
                        Layout.preferredWidth: w
                        Text {
                            text: txt
                            color: isBold ? root.cYellow : "white"
                            font.bold: isBold
                            anchors.centerIn: parent
                            font.pixelSize: 14
                            elide: Text.ElideRight
                            width: parent.width - 10
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }

                    CellTxt { txt: modelData.name; w: 160; isBold: true }
                    CellTxt { txt: modelData.city; w: 90; isBold: false }
                    CellTxt { txt: modelData.score; w: 60; isBold: true }
                    CellTxt { txt: modelData.rank; w: 80; isBold: false }
                    CellTxt { txt: modelData.job; w: 70; isBold: false }
                    CellTxt { txt: modelData.dorm; w: 70; isBold: false }
                }

                Rectangle { anchors.bottom: parent.bottom; width: parent.width; height: 1; color: "#333" }
            }
        }
    }
}
