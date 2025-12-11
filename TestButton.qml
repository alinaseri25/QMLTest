import QtQuick
import QtQuick.Controls

Rectangle {
    id: root
    width: 120
    height: 40
    radius: 8

    // رنگ‌ها و propertyهای قابل تنظیم
    property color bgColor: "#4caf50"
    property color bgPressed: "#43a047"
    property string text: "ButtonAli"
    property color textColor: "white"

    color: bgColor

    Text {
        anchors.centerIn: parent
        text: root.text
        color: root.textColor
        font.pixelSize: 16
    }

    MouseArea {
        anchors.fill: parent
        onPressed: root.color = bgPressed
        onReleased: root.color = bgColor
        onClicked: root.clicked()
    }

    signal clicked()
}
