pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import "../"
import Quickshell.Hyprland
import QtQuick.Effects
import "../panels/statusBar.js" as JS

Row {
    id: root
    spacing: 0
    height: Config.barHeight


    Repeater {
        id: workspaceRepeater

        model: Hyprland.workspaces

        delegate: Rectangle {
            id: delegateRoot
            anchors.verticalCenter: root.verticalCenter

            required property var modelData
            height: Config.barHeight
            width: modelData.focused ? 32 : 24
            radius: 0
            color: delegateRoot.modelData.urgent ? Theme.error : delegateRoot.modelData.focused ? Theme.accent : Theme.surface

            Behavior on width {
                PropertyAnimation {
                    duration: 250
                    easing.type: Easing.InCubic
                    easing.overshoot: 8.85
                }
            }

            ThemeText {
                id: workspaceLabel
                anchors.centerIn: parent
                text: JS.getWorkspaceIcon(delegateRoot.modelData.id)
                color: delegateRoot.modelData.focused ? Theme.background : Theme.text
                font.bold: delegateRoot.modelData.focused
                font.pixelSize: 16

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
