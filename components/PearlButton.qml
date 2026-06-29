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

    property var baseImage: Qt.resolvedUrl("../assets/l1-256.png")
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
            height: mouseArea.height * 0.9
            width: height * 0.9
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

            // ScaleAnimator {
            //     target: leftPanelButton
            //     from: 0.5
            //     to: 1
            //     duration: 100
            //     running: true
            // }
        }

        ColorOverlay {
            id: leftButtonColor
            source: root.baseImage
            color: Theme.active
            anchors.fill: leftPanelButton

            states: [
            State {
                name: "hovered"
                when: root.lbHover && !GlobalState.leftPanelOpen
                PropertyChanges {
                    leftButtonColor {
                        color: Theme.accent
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
            mode: "multiply"
        }

        IconImage {
            id: pearlMotion
            source: root.layerImage
            anchors.centerIn: leftPanelButton
            width: leftPanelButton.width
            height: leftPanelButton.height
            mipmap: true

            opacity: 1

            SequentialAnimation on opacity {
                loops: Animation.Infinite
                running: true

                OpacityAnimator {
                    from: 0.6
                    to: 0.2
                    duration: 1700
                    easing.type: Easing.InCubic
                }

                OpacityAnimator {
                    from: 0.2
                    to: 0.6
                    duration: 1700
                    easing.type: Easing.InCubic
                }
            }
        }
    }
}
