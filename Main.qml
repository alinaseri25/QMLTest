import QtQuick
import QtQuick.Controls

ApplicationWindow {
    width: 500
    height: 350
    visible: true
    title: "Anchors Demo"

    signal buttonPressed(string data);

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
                //console.log("Button Clicked from HEADER!")
                buttonPressed("Hello World by BtnHeader")
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
                userFont.pixelSize: 16
                text: "Add Item"
                onClicked: listModel.addItem("New Item", Math.random() * 100)
            }

            TestButton {
                width: 120
                userFont.pixelSize: 14
                text: "Remove First"
                onClicked: listModel.removeFirst()
            }

            TestButton {
                width: 120
                userFont.pixelSize: 18
                text: "Edit First"
                onClicked: listModel.editFirst(999)
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

            model: listModel

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

    Component.onCompleted: {
        buttonPressed.connect(backend.doSomethingFromQml)
    }

    Connections {
        target: backend
        function onValueChanged(newValue) {
            console.log("Signal from C++ newValue =", newValue)
        }

        function onChangeButtonText(data){
            btnHeader.text = data
        }
    }
}
