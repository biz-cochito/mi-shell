import QtQuick
import Quickshell

PanelWindow {
    property var leftPanel
    property var rightPanel

    anchors {
        top: true
        left: true
        right: true
    }
    height: 32
    color: "#7e9ece"

    SystemClock {
        id: systemClock
        precision: SystemClock.Seconds
    }

    Rectangle {
        anchors.fill: parent
        color: "#1e1e2e"
        
        Row {
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            spacing: 15

            // Left Toggle Button
            MouseArea {
                width: 30
                height: 30
                cursorShape: Qt.PointingHandCursor
                onClicked: leftPanel.opened = !leftPanel.opened

                Text {
                    anchors.centerIn: parent
                    text: ""
                    color: leftPanel && leftPanel.opened ? "#89b4fa" : "#cdd6f4"
                    font.pixelSize: 16
                }
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: "Omarchy"
                color: "#cdd6f4"
                font.bold: true
            }

            Rectangle {
                width: 1
                height: 20
                color: "#313244"
            }

            WorkspaceSwitcher {}
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            spacing: 10

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: ""
                color: rightPanel && rightPanel.opened ? "#89b4fa" : "#cdd6f4"
                font.pixelSize: 18
            }
        }

        Row {
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            spacing: 15

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: Qt.formatDateTime(systemClock.date, "ddd dd MMM  hh:mm")
                color: "#cdd6f4"
            }

            // Right Toggle Button
            MouseArea {
                width: 30
                height: 30
                cursorShape: Qt.PointingHandCursor
                onClicked: rightPanel.opened = !rightPanel.opened

                Text {
                    anchors.centerIn: parent
                    text: "󰂺"
                    color: rightPanel && rightPanel.opened ? "#89b4fa" : "#cdd6f4"
                    font.pixelSize: 18
                }
            }
        }
    }
}
