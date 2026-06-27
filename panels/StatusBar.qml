//@ pragma ComponentBehavior: Bound
import QtQuick
import "../"
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import Qt5Compat.GraphicalEffects

PanelWindow {
    id: root

    property PanelWindow leftPanel
    property PanelWindow rightPanel
    property bool lbHover: leftButtonMouseArea.containsMouse ? true : false
    property bool lbPressed: leftButtonMouseArea.containsPress ? true : false

    readonly property int panelJoinRadius: Theme.borderRadius * 2
    readonly property int leftPanelEdge: Config.leftPanelMargin + Config.leftPanelWidth

    WlrLayershell.layer: WlrLayer.Top

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
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: Config.barHeight
        color: Theme.background
        border.width: 1
        border.color: Theme.surface

        Row {
            spacing: 5

            anchors {
                left: parent.left
                leftMargin: 10
            }

            // Left Toggle Button
            WrapperMouseArea {
                id: leftButtonMouseArea
                child: leftPanelButton
                implicitWidth: Config.barHeight
                implicitHeight: Config.barHeight
                extraMargin: root.lbHover ? 8 : 6
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: GlobalState.leftPanelOpen = !GlobalState.leftPanelOpen

                IconImage {
                    id: leftPanelButton
                    source: Qt.resolvedUrl("../assets/l4-256.png")
                    // implicitHeight: parent.height * 0.6
                    // root.lbHover ? parent.height * 0.7 : parent.height * 0.8
                    // implicitWidth: parent.height * 0.6
                    // fillMode: Image.PreserveAspectFit
                    mipmap: true
                    anchors.centerIn: parent
                    // anchors.margins: 8

                    ScaleAnimator {
                        target: leftPanelButton
                        from: 0.5
                        to: 1
                        duration: 100
                        running: true
                    }
                }
                IconImage {
                    id: pearlMotion
                    source: Qt.resolvedUrl("../assets/l1.png")
                    anchors.centerIn: leftPanelButton
                    width: leftPanelButton.width
                    height: leftPanelButton.height
                    opacity: 0.22
                    visible: leftButtonMouseArea.visible

                    RotationAnimator on rotation {
                        from: 0
                        to: 360
                        duration: 45000
                        loops: Animation.Infinite
                        running: pearlMotion.visible
                    }

                    SequentialAnimation on opacity {
                        loops: Animation.Infinite
                        running: pearlMotion.visible

                        OpacityAnimator {
                            from: 0.17
                            to: 0.98
                            duration: 700
                            easing.type: Easing.InOutSine
                        }

                        OpacityAnimator {
                            from: 0.98
                            to: 0.17
                            duration: 4000
                            easing.type: Easing.InOutSine
                        }
                    }
                }
                IconImage {
                    id: mishLogo
                    source: Qt.resolvedUrl("../assets/mishell.svg")
                    height: parent.height
                    // width: parent.height * 0.4
                    // fillMode: Image.PreserveAspectFit
                    visible: root.lbPressed ? true : false
                    anchors.centerIn: parent
                    rotation: GlobalState.leftPanelOpen ? 90 : 0
                }

                ColorOverlay {
                    id: leftButtonColor
                    anchors.fill: pearlMotion
                    source: pearlMotion
                    color: GlobalState.leftPanelOpen ? Theme.active : leftButtonMouseArea.containsMouse ? Theme.textBright : Theme.accent
                    opacity: 0.3

                    Behavior on color {
                        ColorAnimation {
                            duration: 150
                        }
                    }
                }

                Blend {
                    anchors.fill: leftPanelButton
                    source: pearlMotion
                    foregroundSource: leftButtonColor
                    mode: "softLight"
                }
                // ColorOverlay {
                //     id: mishLogoColor
                //     anchors.fill: mishLogo
                //     source: mishLogo
                //     color: Theme.background
                //     rotation: GlobalState.leftPanelOpen ? 90 : 0

                //     Behavior on color {
                //         ColorAnimation {
                //             duration: 150
                //         }
                //     }
                // }

                states: [
                    State {
                        name: "hovered"
                        when: leftButtonMouseArea.containsMouse && !GlobalState.leftPanelOpen
                        PropertyChanges {
                            target: leftButtonColor
                            color: Theme.accent
                        }
                    },
                    State {
                        name: "activated"
                        when: GlobalState.leftPanelOpen
                        PropertyChanges {
                            target: leftButtonColor
                            color: Theme.active
                        }
                    }
                ]

                transitions: [
                    Transition {
                        from: ""
                        to: "hovered"
                        reversible: true
                        ColorAnimation {
                            duration: 150
                        }
                    }
                ]
            }

            WorkspaceSwitcher {
                // anchors.verticalCenter: leftButtonBg.verticalCenter
                height: Config.barHeight
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

            // Right Toggle Button
            MouseArea {
                width: Config.barHeight
                height: Config.barHeight
                cursorShape: Qt.PointingHandCursor
                onClicked: root.rightPanel.opened = !root.rightPanel.opened

                Text {
                    id: rightPanelButton
                    text: ""
                    font.pixelSize: 16
                    // anchors.verticalCenter: parent.verticalCenter
                    anchors.centerIn: parent
                    color: root.rightPanel && root.rightPanel.opened ? Theme.accent : Theme.text

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
        visible: root.leftPanel && root.leftPanel.opened
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
