pragma ComponentBehavior: Bound
import "../../theme"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "WindowTitle.qml"

PanelWindow {
    id: root

    property PanelWindow leftPanel
    property PanelWindow rightPanel
    WlrLayershell.layer: WlrLayer.Top

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
                width: root.height
                height: root.height
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
                    font.pixelSize: 16
                    anchors.centerIn: parent
                    color: root.leftPanel && root.leftPanel.opened ? Theme.active : Theme.text
                }
            }

            WorkspaceSwitcher {
            }
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
                text: Qt.formatDateTime(systemClock.date, "ddd dd MMM  hh:mm")
                color: Theme.text
                font.family: Theme.fontFamily
            }

            // Right Toggle Button
            MouseArea {
                width: root.height
                height: root.height
                cursorShape: Qt.PointingHandCursor
                onClicked: rightPanel.opened = !rightPanel.opened 

                Text {
                    id: rightPanelButton
                    text: "󰳝"
                    font.pixelSize: 20
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.centerIn: parent
                    color: rightPanel && rightPanel.opened ? Theme.active : Theme.text
                    
                    states: State {
                        name: "rotated"
                        when: rightPanel.opened
                        PropertyChanges { target: rightPanelButton; rotation: -90 }
                    }

                    transitions: Transition {
                        RotationAnimation { duration: 150; direction: RotationAnimation.Shortest }
                    }
                    
                }
            }
        }
    }
}
