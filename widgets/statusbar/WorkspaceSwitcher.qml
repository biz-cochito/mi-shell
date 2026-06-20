//@pragma ComponentBehavior: Bound
import QtQuick
import Quickshell.Hyprland
import "../../theme"
import "statusBar.js" as JS

Row {
    id: root
    spacing: 2
    anchors.verticalCenter: parent.verticalCenter

    Repeater {
        id: workspaceRepeater

        model: Hyprland.workspaces

        delegate: Rectangle {
            id: delegateRoot

            required property var modelData
            height: Theme.fontSize + 4
            width: modelData.focused ? 42 : 20
            
            radius: Theme.borderRadius
            // color: delegateRoot.modelData.focused ? Theme.accent : (delegateRoot.modelData.active ? Theme.background : "transparent");
            color: delegateRoot.modelData.urgent ? Theme.error : delegateRoot.modelData.focused ? Theme.accent : "transparent"

            Behavior on width {
                NumberAnimation {
                    duration: 450
                    easing.type: Easing.OutCubic
                    easing.overshoot: 2.85
                }
            }

            Text {
                id: workspaceLabel
                anchors.centerIn: parent
                text: JS.getWorkspaceIcon(delegateRoot.modelData.id)
                color: delegateRoot.modelData.focused ? Theme.background : Theme.text
                font.bold: delegateRoot.modelData.focused
                font.pixelSize: 15
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
