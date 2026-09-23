import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import "../"
import Quickshell.Widgets
import Qt5Compat.GraphicalEffects

WrapperRectangle {
    id: root
    property bool lbHover: mouseArea.containsMouse ? true : false
    property bool lbPressed: mouseArea.containsPress ? true : false

    property bool overlayVisible: lbHover || lbPressed

    property var baseImage: Qt.resolvedUrl("../assets/l2-256.png")
    property var layerImage: Qt.resolvedUrl("../assets/l4-256.png")

    implicitWidth: leftPanelButton.width
    implicitHeight: Config.barHeight

    extraMargin: GlobalState.leftPanelOpen ? 16 : 0
    radius: height * 0.5

    color: "transparent"

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        // child: leftPanelButton
        // width: implicitWidth
        // height: implicitHeight
        cursorShape: Qt.PointingHandCursor
        onClicked: GlobalState.leftPanelOpen = !GlobalState.leftPanelOpen

        Image {
            id: leftPanelButton
            source: root.baseImage
            height: mouseArea.height * 0.86
            width: height * 0.86
            fillMode: Image.PreserveAspectFit
            mipmap: true
            anchors.centerIn: parent

            RotationAnimator on rotation {
                target: leftPanelButton
                from: 0
                to: 360
                duration: 20000
                loops: Animation.Infinite
                running: true
            }
        }
        Glow {
            anchors.fill: leftPanelButton
            source: leftPanelButton
            radius: height * 0.5
            samples: 7
            color: GlobalState.leftPanelOpen ? Theme.active : "transparent"
            visible: true
            spread: 0.01
            // visible: root.overlayVisible
        }

        ColorOverlay {
            id: leftButtonColor
            source: leftPanelButton
            color: Theme.text
            anchors.fill: leftPanelButton

            states: [
            State {
                name: "hovered"
                when: root.lbHover && !GlobalState.leftPanelOpen
                PropertyChanges {
                    leftButtonColor {
                        color: Theme.active
                    }
                }
            },
            State {
                name: "activated"; when: GlobalState.leftPanelOpen
                PropertyChanges {
                    leftButtonColor.color: Theme.active
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

        MultiEffect {
            id: brightEff
            source: leftPanelButton
            // layer.enabled: true
            // opacity: 0
            saturation: root.lbHover ? 1.5 : 0
        }
        Blend {
            anchors.fill: leftPanelButton
            source: leftPanelButton
            foregroundSource: pearlMotion
            mode: "subtract"
        }

        IconImage {
            id: pearlMotion
            source: root.layerImage
            anchors.centerIn: leftPanelButton
            width: leftPanelButton.width
            height: leftPanelButton.height
            mipmap: true

            opacity: 1

            RotationAnimator on rotation {
                target: leftPanelButton
                from: 0
                to: 360
                duration: 20000
                loops: Animation.Infinite
                running: true
            }
        }
    }
}
