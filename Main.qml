import QtQuick
import QtQuick.Controls

ApplicationWindow {
    width: 500
    height: 350
    visible: true
    title: "Anchors Demo"

    Rectangle {
        id: header
        height: 60
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        color: "#303f9f"

        Text {
            text: "Panel Header"
            anchors.centerIn: parent
            color: "white"
            font.pixelSize: 20
        }
    }

    Rectangle {
        id: sidePanel
        width: 120
        anchors.left: parent.left
        anchors.top: header.bottom
        anchors.bottom: parent.bottom
        color: "#455a64"

        Text {
            text: "Menu"
            anchors.centerIn: parent
            color: "white"
        }
    }

    Rectangle {
        id: mainArea
        anchors.top: header.bottom
        anchors.left: sidePanel.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: "#eceff1"

        Text {
            text: "Main Content"
            anchors.centerIn: parent
            font.pixelSize: 24
        }

        TestButton {
            id: btn1
            anchors.centerIn: parent
            text: "Click Me!"
            bgColor: "#1976d2"
            bgPressed: "#1565c0"
            onClicked: {
                console.log("ButtonAli Clicked!")
            }
        }
    }
}
