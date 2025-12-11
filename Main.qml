import QtQuick
import QtQuick.Controls

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("TESTING NEW QML")

    property color colorState: "#ffa500"

    Rectangle {
        id: box
        width: 200
        height: 200
        color: colorState
        anchors.centerIn: parent

        Text {
            anchors.centerIn: parent
            text: "Hello Ali!"
            font.pixelSize: 24
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log(colorState)
                colorState = (colorState == "#ffa500") ? "#87ceeb" : "#ffa500"
                box.color = colorState
            }
        }
    }
}
