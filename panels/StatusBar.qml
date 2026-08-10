//@ pragma ComponentBehavior: Bound
import QtQuick
import "../"
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell
import Quickshell.Wayland
// import Quickshell.Widgets
import Qt5Compat.GraphicalEffects
import "../components/PearlButton.qml"

PanelWindow {
    id: root

    property PanelWindow leftPanel
    property PanelWindow rightPanel

    property var vertCenterAnchor: root

    readonly property int panelJoinRadius: Theme.borderRadius * 2
    readonly property int leftPanelEdge: Config.leftPanelMargin + Config.leftPanelWidth

    WlrLayershell.layer: WlrLayer.Overlay

    implicitHeight: Config.barHeight + panelJoinRadius
    exclusiveZone: Config.barHeight
    color: "transparent"
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
        id: statusBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: Config.barHeight
        color: Theme.background
        // border.width: 1
        // border.color: Theme.surface

        Row {
            id: barLeft
            spacing: 10
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            Rectangle {
                id: lMarginBlock
                width: 6
                height: Config.barHeight
                color: "transparent"
            }

            PearlButton {
            }

            WorkspaceSwitcher {
                // anchors.verticalCenter: leftButtonBg.verticalCenter
                // height: Config.barHeight
            }
        }

        WindowTitle {}

        Row {
            spacing: 10

            anchors {
                right: parent.right
                // rightMargin: 5
                verticalCenter: parent.verticalCenter
            }

            Battery {
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: Qt.formatDateTime(systemClock.date, "hh:mm AP")
                color: Theme.text
                font.family: Theme.fontFamily
                font.pixelSize: Theme.fontSize
            }

            /*  Right Toggle Button */

            MouseArea {
                width: Config.barHeight
                height: Config.barHeight
                cursorShape: Qt.PointingHandCursor
                onClicked: GlobalState.rightPanelOpen = !GlobalState.rightPanelOpen;

                Text {
                    id: rightPanelButton
                    text: ""
                    font.pixelSize: 16
                    // anchors.verticalCenter: parent.verticalCenter
                    anchors.centerIn: parent
                    color: root.rightPanel && GlobalState.rightPanelOpen ? Theme.accent : Theme.text

                    states: State {
                        name: "rotated"
                        when: GlobalState.rightPanelOpen
                        PropertyChanges {
                            target: rightPanelButton.rotation
                            rotation: 290
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

    Shape {
        x: root.leftPanelEdge
        y: Config.barHeight + 2
        width: root.panelJoinRadius
        height: root.panelJoinRadius
        visible: root.leftPanel && root.leftPanel.opened
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            fillColor: Theme.background
            strokeColor: "transparent"
            startX: 0
            startY: 0

            PathLine {
                x: root.panelJoinRadius
                y: 0
            }

            PathQuad {
                x: 0
                y: root.panelJoinRadius
                controlX: root.panelJoinRadius
                controlY: root.panelJoinRadius
            }

            PathLine {
                x: 0
                y: 0
            }
        }
    }

    Shape {
        x: Config.leftPanelMargin - root.panelJoinRadius
        y: Config.barHeight - 1
        width: root.panelJoinRadius
        height: root.panelJoinRadius
        visible: root.leftPanel && GlobalState.leftPanelOpen
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            fillColor: Theme.background
            strokeColor: "transparent"
            startX: root.panelJoinRadius
            startY: 0

            PathLine {
                x: root.panelJoinRadius
                y: root.panelJoinRadius
            }

            PathQuad {
                x: 0
                y: 0
                controlX: 0
                controlY: root.panelJoinRadius
            }

            PathLine {
                x: root.panelJoinRadius
                y: 0
            }
        }
    }
}
