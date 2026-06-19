pragma ComponentBehavior: Bound
import QtQuick
import Quickshell.Hyprland
// import QtQuick.Shapes
// import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../../theme"

Row {
    id: root
    spacing: 0
    anchors.verticalCenter: parent.verticalCenter

    Repeater {
        id: workspaceRepeater

        model: Hyprland.workspaces

        delegate: Rectangle {
            id: delegateRoot

            required property var modelData

            width: delegateRoot.modelData.focused ? 48 : 20
            height: 20
            // radius: delegateRoot.modelData.focused ? (width / 1.5) : 2
            // radius: 12
            color: delegateRoot.modelData.focused ? Theme.accent : (delegateRoot.modelData.active ? Theme.background : "transparent")
            // border.color: Theme.surface
            border.width: 0

            function scratchpadTitle() {
                if (delegateRoot.modelData.id === -96)
                    return "";
                else if (delegateRoot.modelData.id === -97)
                    return "";
                else
                    return delegateRoot.modelData.id;
            }

            states: [
                State {
                    name: "active"
                    when: delegateRoot.modelData.active
                    PropertyChanges {
                        delegateRoot.radius: 12
                        delegateRoot.scale: 1
                        delegateRoot.width: 48
                    }
                },
                State {
                    name: "focused"
                    when: delegateRoot.modelData.focused
                    PropertyChanges {
                        delegateRoot.radius: parent.width
                        delegateRoot.scale: 1
                        delegateRoot.width: parent.width
                    }
                }
            ]

            Behavior on radius {
                NumberAnimation {
                    duration: 450
                    easing.type: Easing.OutBack
                    easing.overshoot: 1.75
                }
            }

            Behavior on scale {
                NumberAnimation {
                    duration: 450
                    easing.type: Easing.OutBack
                    easing.overshoot: 1.85
                }
            }

            Behavior on width {
                NumberAnimation {
                    duration: 450
                    easing.type: Easing.OutBack
                    easing.overshoot: 1.85
                }
            }

            // Behavior on color {
            //     ColorAnimation {
            //         duration: 50
            //     }
            // }

            ColorOverlay {
                anchors.fill: parent
                source: parent
                // color: Theme.accent
                opacity: 1
                visible: delegateRoot.modelData.focused
            }

            Text {
                id: workspaceLabel
                anchors.centerIn: parent
                text: delegateRoot.scratchpadTitle()
                color: Theme.text
                font.bold: delegateRoot.modelData.focused
                font.pixelSize: 14
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    delegateRoot.modelData.activate();
                    console.log(delegateRoot.modelData.id);
                }
            }
        }
    }
}
