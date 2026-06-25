pragma ComponentBehavior: Bound
import QtQuick
import "../"
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

PanelWindow {
    id: root

    property PanelWindow leftPanel
    property PanelWindow rightPanel
    WlrLayershell.layer: WlrLayer.Top

    implicitHeight: Config.barHeight
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
                width: root.height
                height: root.height
                cursorShape: Qt.PointingHandCursor
                onClicked: root.leftPanel.opened = !root.leftPanel.opened

                Text {
                    id: leftPanelButton
                    text: ""
                    font.pixelSize: 16
                    anchors.centerIn: parent
                    color: root.leftPanel && root.leftPanel.opened ? Theme.active : Theme.text

                    states: State {
                        name: "rotated"
                        when: root.leftPanel.opened
                        PropertyChanges {
                            target: root.leftPanelButton
                            rotation: 90
                        }
                    }

                    transitions: Transition {
                        RotationAnimation {
                            duration: 150
                            direction: RotationAnimation.Shortest
                        }
                    }
                }
            }

            WorkspaceSwitcher {}
        }

        WindowTitle {}

        Row {
            spacing: 10

            anchors {
                right: parent.right
                rightMargin: 5
                verticalCenter: parent.center
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: Qt.formatDateTime(systemClock.date, "hh:mm AP")
                color: Theme.text
                font.family: Theme.fontFamily
            }

            // Right Toggle Button
            MouseArea {
                width: root.height
                height: root.height
                cursorShape: Qt.PointingHandCursor
                onClicked: root.rightPanel.opened = !root.rightPanel.opened

                Text {
                    id: rightPanelButton
                    text: "󰳝"
                    font.pixelSize: 20
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.centerIn: parent
                    color: root.rightPanel && root.rightPanel.opened ? Theme.active : Theme.text

                    states: State {
                        name: "rotated"
                        when: root.rightPanel.opened
                        PropertyChanges {
                            target: root.rightPanelButton
                            rotation: -90
                        }
                    }

                    transitions: Transition {
                        RotationAnimation {
                            duration: 150
                            direction: RotationAnimation.Shortest
                        }
                    }
                }
            }
        }
    }
}
