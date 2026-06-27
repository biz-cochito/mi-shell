//@pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import "../"
import Quickshell.Hyprland
import QtQuick.Effects
import "../panels/statusBar.js" as JS

Row {
    id: root
    spacing: 2
    height: Config.barHeight

    Repeater {
        id: workspaceRepeater

        model: Hyprland.workspaces

        delegate: Rectangle {
            id: delegateRoot
            anchors.verticalCenter: root.verticalCenter

            required property var modelData
            height: Theme.fontSize * 1.75
            width: modelData.focused ? 32 : height

            radius: height / 2
            color: delegateRoot.modelData.urgent ? Theme.error : delegateRoot.modelData.focused ? Theme.accent : Theme.surface

            Behavior on width {
                PropertyAnimation {
                    duration: 250
                    easing.type: Easing.InCubic
                    easing.overshoot: 8.85
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
