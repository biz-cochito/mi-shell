import QtQuick
import Quickshell
import "../../theme"

PanelWindow {
    property var leftPanel
    property var rightPanel

    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: 32
    color: "transparent"

    SystemClock {
        id: systemClock
        precision: SystemClock.Seconds
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.background

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
                    color: leftPanel && leftPanel.opened ? Theme.accent : Theme.text
                    font.pixelSize: 16
                }
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: "Omarchy"
                color: Theme.text
                font.bold: true
            }

            Rectangle {
                width: 1
                height: 20
                color: Theme.border
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
                color: rightPanel && rightPanel.opened ? Theme.accent : Theme.text
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
                color: Theme.text
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
                    color: rightPanel && rightPanel.opened ? Theme.accent : Theme.text
                    font.pixelSize: 18
                }
            }
        }
    }
}
