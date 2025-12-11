import QtQuick
import QtQuick.Controls

ApplicationWindow {
    width: 500
    height: 350
    visible: true
    title: "Anchors Demo"

    Connections {
        target: backend
        function onValueChanged(newValue) {
            console.log("Signal from C++ newValue =", newValue)
        }
    }

    // --- HEADER ---
    Rectangle {
        id: header
        height: 60
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        color: "#303f9f"

        TestButton {
            id: btnHeader
            text: "Click Me!"
            bgColor: "#1976d2"
            bgPressed: "#1565c0"
            anchors.centerIn: parent

            onClicked: {
                console.log("ButtonAli Clicked from HEADER!")
                backend.doSomethingFromQml("سلام علی!");
            }
        }
    }

    // --- SIDE PANEL ---
    Rectangle {
        id: sidePanel
        width: 150
        anchors.left: parent.left
        anchors.top: header.bottom
        anchors.bottom: parent.bottom
        color: "#455a64"

        Column {
            anchors.centerIn: parent
            spacing: 12

            TestButton {
                width: 120
                text: "Add Item"
                onClicked: {
                    myModel.append({ "title": "New Item", "value": Math.random() * 100 })
                }
            }

            TestButton {
                width: 120
                text: "Remove First"
                onClicked: {
                    if (myModel.count > 0)
                        myModel.remove(0)
                }
            }

            TestButton {
                width: 120
                text: "Edit First"
                onClicked: {
                    if (myModel.count > 0)
                        myModel.setProperty(0, "value", 999)
                }
            }
        }
    }

    // --- MAIN AREA ---
    Rectangle {
        id: mainArea
        anchors.top: header.bottom
        anchors.left: sidePanel.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: "#eceff1"

        ListView {
            id: listView
            anchors.fill: parent
            anchors.margins: 8

            model: ListModel {
                id: myModel
                ListElement { title: "Item 1"; value: 10 }
                ListElement { title: "Item 2"; value: 20 }
                ListElement { title: "Item 3"; value: 30 }
            }

            delegate: Rectangle {
                width: listView.width
                height: 40
                color: index % 2 === 0 ? "#f0f0f0" : "#e0e0e0"

                Row {
                    spacing: 10
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 10

                    Text { text: title; font.pixelSize: 16 }
                    Text { text: value; font.pixelSize: 16; color: "#666" }
                }
            }
        }
    }
}
