import QtQuick
import QtQuick.Layouts

Rectangle {
    property string title: ""
    property string text: ""
    property color cYellow: "#FFD700"

    Layout.fillWidth: true
    height: col.implicitHeight + 20
    color: "#1E1E1E"
    radius: 8

    ColumnLayout {
        id: col
        anchors.fill: parent
        anchors.margins: 10
        Text {
            text: parent.title
            color: parent.cYellow
            font.pointSize: 12
        }
        Text {
            text: parent.text
            color: "white"
            font.pointSize: 14
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
        }
    }
}
