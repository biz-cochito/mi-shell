pragma ComponentBehavior: Bound
import QtQuick
import Quickshell.Hyprland
// import QtQuick.Shapes
// import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../../theme"
import "utils.js" as Utils

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
            width: modelData.focused ? 36 : 20
            
            radius: Theme.borderRadius
            color: delegateRoot.modelData.focused ? Theme.accent : (delegateRoot.modelData.active ? Theme.background : "transparent");

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
                text: Utils.getWorkspaceIcon(delegateRoot.modelData.id)
                color: delegateRoot.modelData.focused ? Theme.text : Theme.textMuted
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
