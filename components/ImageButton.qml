import Quickshell
import Quickshell.Layouts
import QtQuick
import "../"
// import QtQuick.Layouts
import Quickshell.Widgets
import Qt5Compat.GraphicalEffects

MouseArea {
    id: root

    required property var iconImgSrc
    required property var onClicked

    width: panelButton.width
    height: Config.barHeight
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: onClicked


    IconImage {
        id: panelButton
        source: Qt.resolvedUrl(root.iconImgSrc)
        implicitHeight: parent.height
        implicitWidth: parent.height * 0.75
        // anchors.centerIn: parent
    }

    ColorOverlay {
        id: buttonColor
        anchors.fill: panelButton
        source: panelButton
        color: "transparent"
    }

    states: [
        State {
            name: "rotated"
            when: leftPanel.opened
            PropertyChanges {
                target: leftPanelButton
                rotation: 90
            }
        },
        State {
            name: "hovered"
            when: root.containsMouse
            PropertyChanges {
                target: buttonColor
                color: Theme.active
            }
        }
    ]

    transitions: [
        Transition {
            RotationAnimation {
                duration: 150
                direction: RotationAnimation.Shortest
            }
        },
        Transition {
            from: ""
            to: "hovered"
            reversible: true
            ColorAnimation {
                duration: 1000
            }
        }
    ]
}
