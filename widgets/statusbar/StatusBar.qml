pragma ComponentBehavior: Bound
import "../../theme"
import QtQuick
import QtQuick.Layouts
import Quickshell
// import Quickshell.Wayland
import "WindowTitle.qml"

PanelWindow {
    id: root

    property PanelWindow leftPanel
    property PanelWindow rightPanel

    implicitHeight: 26
    color: Theme.background
    focusable: true


    anchors {
        top: true
        left: true
        right: true
    }

    SystemClock {
        id: systemClock

        precision: SystemClock.Minutes
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.background

        Row {
            spacing: 10

            anchors {
                left: parent.left
                leftMargin: 10
                verticalCenter: parent.verticalCenter
            }

            // Left Toggle Button
            MouseArea {
                width: 30
                height: 30
                cursorShape: Qt.PointingHandCursor
                onClicked: leftPanel.opened = !leftPanel.opened

                Image {
                    id: toggleIcon
                    source: "../../assets/3.png"
                    sourceSize: Qt.size(16, 16)
                    fillMode: Image.Stretch

                }


                Text {
                    text: ""
                    font.pixelSize: 18
                    anchors.centerIn: parent
                    color: leftPanel && leftPanel.opened ? Theme.active : Theme.text
                }

            }

            WorkspaceSwitcher {
            }

        }

        Row {
                spacing: 10
                Layout.maximumWidth: 300

                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: ""
                    color: Theme.text
                    font.pixelSize: 16
                }

                WindowTitle {
                }


        }

        Row {
            spacing: 10

            anchors {
                right: parent.right
                rightMargin: 5
                verticalCenter: parent.center
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: Qt.formatDateTime(systemClock.date, "ddd dd MMM  hh:mm")
                color: Theme.text
                font.family: Theme.fontFamily
            }

            // Right Toggle Button
            MouseArea {
                width: 30
                height: root.height
                cursorShape: Qt.PointingHandCursor
                onClicked: rightPanel.opened = !rightPanel.opened

                Text {
                    text: ""
                    font.pixelSize: 18
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.centerIn: parent
                    color: rightPanel && rightPanel.opened ? Theme.active : Theme.text
                }
            }

        }

    }

}
