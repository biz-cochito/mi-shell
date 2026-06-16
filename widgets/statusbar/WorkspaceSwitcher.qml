pragma ComponentBehavior: Bound
import QtQuick
import Quickshell.Hyprland
import "../../theme"

Row {
    id: root

    spacing: 5
    anchors.verticalCenter: parent.verticalCenter

    Repeater {
        id: workspaceRepeater

        model: Hyprland.workspaces

        delegate: Rectangle {
            id: delegateRoot

            required property var modelData

            width: 24
            height: 24
            radius: Theme.borderRadius
            color: delegateRoot.modelData.focused ? Theme.accent : (delegateRoot.modelData.active ? Theme.surfaceActive : "transparent")
            border.color: Theme.accent
            border.width: 1

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
                    }
                },
                State {
                    name: "focused"
                    when: delegateRoot.modelData.focused
                    PropertyChanges {
                        delegateRoot.radius: 12
                        delegateRoot.scale: 1
                    }
                }
            ]

            Behavior on radius {
                NumberAnimation {
                    duration: 1000
                    easing.type: Easing.OutBack
                    easing.overshoot: 2.25
                }
            }

            Behavior on scale {
                NumberAnimation {
                    duration: 400
                    easing.type: Easing.OutBack
                    easing.overshoot: 1.85
                }
            }

            Behavior on color {
                ColorAnimation { duration: 200 }
            }

            Behavior on border.color {
                ColorAnimation { duration: 200 }
            }

            Text {
                anchors.centerIn: parent
                text: delegateRoot.scratchpadTitle()
                color: delegateRoot.modelData.focused ? Theme.background : Theme.text
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
